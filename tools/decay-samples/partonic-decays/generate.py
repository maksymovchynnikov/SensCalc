"""Generate missing SensCalc partonic-decay samples with native HNL weights.

The HNL distribution is the spin-averaged charged-current squared matrix
element in HNLdecaysSensCalc.mx. Sampling is exact rejection sampling, not
finite-pool resampling. Pythia supplies the shower, fragmentation and complete
secondary decays. This prepares conditional shapes, never branching ratios.
"""
import argparse
import json
from pathlib import Path
import zlib
import numpy as np
try:
    import pythia8
except ImportError:
    import pythia8mc as pythia8


def direction(rng):
    z = rng.uniform(-1., 1.)
    phi = rng.uniform(0., 2.*np.pi)
    r = np.sqrt(1.-z*z)
    return np.array([r*np.cos(phi), r*np.sin(phi), z])


def triangle(a, b, c):
    return (a-b-c)**2-4*b*c


def boost(p, beta):
    b2 = np.dot(beta, beta)
    if b2 == 0:
        return p
    gamma = 1./np.sqrt(1.-b2)
    bp = np.dot(beta, p[:3])
    return np.r_[p[:3] + (((gamma-1.)*bp/b2)+gamma*p[3])*beta,
                 gamma*(p[3]+bp)]


class Primary:
    def __init__(self, spec, rng):
        self.spec, self.rng = spec, rng
        self.pool = []

    def next(self):
        M = self.spec['mass']
        m = self.spec['masses']
        rng = self.rng
        if len(m) == 2:
            p = np.sqrt(triangle(M*M, m[0]**2, m[1]**2))/(2*M)
            vec = p*direction(rng)
            return [np.r_[vec, (M*M+m[0]**2-m[1]**2)/(2*M)],
                    np.r_[-vec, (M*M+m[1]**2-m[0]**2)/(2*M)]]
        m1, m2, m3 = m
        if self.spec['matrix'] == 'nc':
            return self.neutral_current()
        if not self.pool:
            low, high = (m1+m3)**2, (M-m2)**2
            bound = (M*M+m2*m2-m1*m1-m3*m3)**2/4.
            while not self.pool:
                s = rng.uniform(low, high, 4096)
                ps = np.sqrt(triangle(M*M, s, m2*m2))/M**2
                ps *= np.sqrt(triangle(s, m1*m1, m3*m3))/s
                # |M|^2 / 8 = (M^2+m2^2-s)(s-m1^2-m3^2).
                weight = ps*(M*M+m2*m2-s)*(s-m1*m1-m3*m3)
                if np.any(weight < 0) or np.any(weight > bound*(1.+1.e-12)):
                    raise RuntimeError('Invalid analytical rejection bound')
                self.pool = s[rng.random(len(s))*bound < weight].tolist()
        s = self.pool.pop()
        p2 = np.sqrt(triangle(M*M, s, m2*m2))/(2*M)
        vec2 = p2*direction(rng)
        E2 = (M*M+m2*m2-s)/(2*M)
        EQ = M-E2
        p1 = np.sqrt(triangle(s, m1*m1, m3*m3))/(2*np.sqrt(s))
        vec1 = p1*direction(rng)
        beta = -vec2/EQ
        one = boost(np.r_[vec1, (s+m1*m1-m3*m3)/(2*np.sqrt(s))], beta)
        three = boost(np.r_[-vec1, (s+m3*m3-m1*m1)/(2*np.sqrt(s))], beta)
        return [one, np.r_[vec2, E2], three]

    def neutral_current(self):
        M = self.spec['mass']
        m1, m2, m3 = self.spec['masses']
        a, b, c = self.spec['coefficients']
        assert m1 == m2 and m3 == 0. and min(a,b,c) >= 0.
        # Uniform Dalitz coordinates are uniform three-body phase space.
        bound = M*(a*M+(b+c)*M**3/8.)
        while not self.pool:
            e1 = self.rng.uniform(m1, M/2., 8192)
            e3 = self.rng.uniform(0., (M*M-4*m1*m1)/(2*M), 8192)
            e2 = M-e1-e3
            p1 = np.sqrt(e1*e1-m1*m1)
            cos = (e2*e2-m2*m2-p1*p1-e3*e3)/(2*p1*e3)
            physical = (e2>=m2)&(np.abs(cos)<=1.)
            weight = M*(a*e3+b*e1*(M*M-2*M*e1)+c*e2*(M*M-2*M*e2))
            if np.any(weight[physical]<0) or np.any(weight[physical]>bound*(1+1e-12)):
                raise RuntimeError('Invalid NC rejection bound')
            accepted = physical & (self.rng.random(len(e1))*bound<weight)
            self.pool = np.stack([e1[accepted],e3[accepted],cos[accepted]],axis=1).tolist()
        e1,e3,cos = self.pool.pop()
        n = direction(self.rng)
        axis = np.array([1.,0.,0.]) if abs(n[0])<0.9 else np.array([0.,1.,0.])
        u = np.cross(n,axis); u /= np.linalg.norm(u)
        v = np.cross(n,u)
        phi = self.rng.uniform(0.,2*np.pi)
        n3 = cos*n+np.sqrt(max(0.,1-cos*cos))*(u*np.cos(phi)+v*np.sin(phi))
        q1=np.sqrt(e1*e1-m1*m1)*n
        q3=e3*n3
        return [np.r_[q1,e1],np.r_[-q1-q3,M-e1-e3],np.r_[q3,e3]]


def generate(spec, count, seed):
    rng = np.random.default_rng(seed)
    source = Primary(spec, rng)
    p = pythia8.Pythia('', False)
    for setting in ['ProcessLevel:all = off', 'Print:quiet = on',
                    'Random:setSeed = on', f'Random:seed = {seed}',
                    'PartonLevel:MPI = off', 'PartonLevel:ISR = off']:
        if not p.readString(setting):
            raise RuntimeError(setting)
    for pid in [13, 211, 321, 130, 2112]:
        p.particleData.mayDecay(pid, False)
    if not p.init():
        raise RuntimeError('Pythia initialization failed')
    events, attempts, failures = [], 0, 0
    max_error = 0.
    M = spec['mass']
    while len(events) < count:
        attempts += 1
        if attempts > 100*count:
            raise RuntimeError(f'Excessive hadronization failures: {spec}')
        momenta = source.next()
        if np.max(np.abs(np.sum(momenta,axis=0)-[0,0,0,M])) > 1.e-9*M:
            raise RuntimeError('Primary four-momentum violation')
        p.event.reset()
        p.event[0].p(0., 0., 0., M)
        p.event[0].m(M)
        for pid, mass, q in zip(spec['pdgs'], spec['masses'], momenta):
            pid = int(pid)
            p.event.append(pid, 23, 501 if 0<pid<6 else 0,
                           501 if -6<pid<0 else 0, *q, mass)
            p.event[p.event.size()-1].scale(M/2.)
        p.forceTimeShower(1, len(momenta), M/2.)
        if not p.forceHadronLevel():
            failures += 1
            continue
        rows = []
        charge3 = baryon = 0
        for i in range(1, p.event.size()):
            a = p.event[i]
            if a.isFinal():
                if abs(a.id()) <= 6 or a.id() == 21:
                    raise RuntimeError('Unhadronized final parton')
                rows.append([a.px(), a.py(), a.pz(), a.e(), a.m(),
                             float(a.id()), a.charge(), 1.])
                charge3 += a.chargeType()
                if p.particleData.isBaryon(a.id()):
                    baryon += 1 if a.id()>0 else -1
        arr = np.asarray(rows)
        if not len(rows) or not np.isfinite(arr).all():
            raise RuntimeError('Nonfinite event')
        error = np.max(np.abs(arr[:,:4].sum(axis=0)-[0.,0.,0.,M]))
        shell = np.max(np.abs(arr[:,3]**2-np.sum(arr[:,:3]**2,axis=1)-arr[:,4]**2))
        if charge3 != 0 or baryon != 0:
            raise RuntimeError('Charge or baryon-number violation')
        if error > 1.e-8*M or shell > 1.e-8*M*M:
            raise RuntimeError(f'Final four-momentum/mass-shell violation: {error}, {shell}')
        max_error = max(max_error, float(error))
        events.append(arr.ravel().tolist())
    report = dict(spec, events=count, attempts=attempts, failures=failures,
                  max_p4_error_GeV=max_error, seed=seed,
                  pythia_version=p.settings.parm('Pythia:versionNumber'),
                  mean_multiplicity=float(np.mean([len(e)/8 for e in events])))
    return events, report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('manifest', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--events', type=int, default=3000)
    parser.add_argument('--seed', type=int, default=182031)
    parser.add_argument('--limit', type=int)
    parser.add_argument('--start', type=int, default=0)
    parser.add_argument('--stop', type=int)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    specs = json.loads(args.manifest.read_text())
    specs = specs[args.start:args.stop]
    if args.limit:
        specs = specs[:args.limit]
    for spec in specs:
        name = f"{spec['model']}_{spec['channel']}_{spec['mass']:.2f}"
        path = args.output / (name+'.json')
        if path.exists():
            continue
        seed = 1+(args.seed+zlib.crc32(name.encode()))%899999998
        events, report = generate(spec, args.events, seed)
        path.write_text(json.dumps(events, separators=(',',':')))
        (args.output/(name+'.report.json')).write_text(json.dumps(report, indent=2))
        print(json.dumps(report), flush=True)


if __name__ == '__main__':
    main()
