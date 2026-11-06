"""Prepare conditional, unweighted exHad decay samples for SensCalc.

Rates remain in SensCalc. Bosons have one complete hadronic sample per mass
and width prescription; HNLs retain a sample for each weak-current channel.
Raw binary events are consumed and deleted by export.wls, one table at a time.
"""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

import numpy as np


MODELS = {"DP": ("dark-photon", 1.7, 5.), "B-L": ("b-l", 2., 5.),
          "ALP-fermion": ("alp-fermion", 1.91, 5.)}
SCALARS = {"1809.01876": "scalar-1809", "2407.13587-Central": "scalar-central",
           "2407.13587-Lower": "scalar-lower", "2407.13587-Upper": "scalar-upper"}


def plans(inputs):
    result = []
    for item in inputs:
        model, description = item['model'], item['description']
        hnl = model.startswith('HNL-')
        if hnl:
            generator, lo, hi = 'hnl', 0., 40.
        elif model == 'Scalar':
            generator, lo, hi = SCALARS[description], 2., 63.
        else:
            generator, lo, hi = MODELS[model]
        hadronic = [r for r in item['channels'] if any(
            abs(p) not in {11, 12, 13, 14, 15, 16, 22} for p in r['pdgs'])]
        for i, mass in enumerate(item['masses']):
            if not lo <= mass <= hi:
                continue
            groups = [[r] for r in hadronic if r['channel'].startswith('Jets-')
                      and r['rates'][i] > 0.] if hnl else [hadronic]
            for group in groups:
                rate = sum(r['rates'][i] for r in group)
                if rate <= 0.:
                    continue
                channel = group[0]['channel'] if hnl else 'hadronic'
                # NC matrix elements and momenta are the same for pure flavours.
                identity = ('HNL-NC' if hnl and channel.endswith('v') else model)
                key = f'{identity}_{description}_{channel}_{mass:g}'
                result.append(dict(model=model, description=description, mass=mass,
                    generator=generator, channel=channel, key=key,
                    members=[r['channel'] for r in group], rate=rate,
                    **({k: group[0][k] for k in ('pdgs', 'masses', 'matrix_element')} if hnl else {})))
    identities = {}
    for row in result:
        identity = {k: row.get(k) for k in ('generator','mass','pdgs','masses','matrix_element')}
        if row['key'] in identities and identities[row['key']] != identity:
            raise RuntimeError('Shared sample has different primary dynamics: '+row['key'])
        identities[row['key']] = identity
    return result


def hnl_events(g, spec, n, seed, xml):
    from exhad.core import kinematics
    from exhad.core.pdg import charge, m0, antiparticle
    from exhad.secondary import decayer
    ids = [int(p) for p in spec['pdgs']]
    masses = tuple(spec['masses'])
    M = spec['mass']
    expression = spec['matrix_element'].replace('*^', 'e').replace('^', '**')
    kinematics.seed(seed)
    spectator = next(i for i, p in enumerate(ids) if abs(p) > 6)
    quarks = [i for i in range(3) if i != spectator]
    chunks = []
    remaining = n
    for _ in range(20):
        p = kinematics.three_body(M, remaining, ids, masses,
            [charge(pid) for pid in ids], [0]*3, expression)
        rows = p.reshape(-1, 3, 8)
        q = rows[:, quarks, :4].sum(axis=1)
        W = np.sqrt(np.maximum(0., q[:, 3]**2 - np.sum(q[:, :3]**2, axis=1)))
        # Respect the current's physical endpoint despite the rounded spectator
        # masses in the historical SensCalc primary matrix elements.
        p = p[W <= M - m0(ids[spectator])]
        chunks.append(p)
        remaining -= len(p)
        if not remaining:
            break
    if remaining:
        raise RuntimeError('HNL endpoint support could not be sampled')
    primary = np.concatenate(chunks)
    events = g.hadronize_hnl(M, ids, primary.tolist(), seed=seed)
    if not np.allclose(np.asarray([e[0][:5] for e in events]),
                       primary.reshape(-1, 3, 8)[:, spectator, :5], atol=2e-8, rtol=2e-8):
        raise RuntimeError('Hadronization changed the HNL spectator')
    # The hadronizer retains the spectator as its first particle, even a tau.
    if abs(ids[spectator]) == 15:
        daughters = decayer(xml).finish([[e[0]] for e in events], seed)
        events = [[*d, *e[1:]] for d, e in zip(daughters, events)]
    # Native rows include the Majorana charge-conjugate decay with equal rate.
    rng = np.random.default_rng(seed)
    for event, conjugate in zip(events, rng.random(n) < .5):
        if conjugate:
            for p in event:
                p[5] = antiparticle(int(p[5]))
    return events


def packed(events, M):
    from exhad.core.pdg import charge
    from exhad.full_decays import STABLE
    from particle.pdgid import is_baryon
    result = np.full((len(events), max(map(len, events))*8), -999., dtype='<f8')
    error = shell = 0.
    for i, event in enumerate(events):
        p = np.asarray(event, dtype=float)
        ids = p[:, 5].astype(int)
        if not np.isfinite(p).all() or not all(abs(k) in STABLE for k in ids):
            raise RuntimeError('Nonfinite or nonterminal final event')
        q = np.array([charge(k) for k in ids])
        if abs(q.sum()) > 1e-10 or sum(int(np.sign(k)) for k in ids if is_baryon(int(k))) != 0:
            raise RuntimeError('Charge or baryon number is not conserved')
        error = max(error, float(np.max(np.abs(p[:, :4].sum(axis=0) - [0., 0., 0., M]))))
        shell = max(shell, float(np.max(np.abs(p[:, 3]**2-np.sum(p[:, :3]**2, axis=1)-p[:, 4]**2))))
        result[i, :len(p)*8] = np.column_stack((p, q, np.ones(len(p)))).ravel()
    if error > 2e-7*max(1., M) or shell > 2e-7*max(1., M*M):
        raise RuntimeError(f'Four-momentum or mass-shell failure: {error}, {shell}')
    return result, dict(max_p4_error=error, max_shell_error=shell,
        mean_multiplicity=float(np.mean(list(map(len, events)))))


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('inputs', type=Path)
    ap.add_argument('output', type=Path)
    ap.add_argument('--exhad', type=Path, required=True)
    ap.add_argument('--wolfram', default='WolframKernel')
    ap.add_argument('--events', type=int, default=3000)
    ap.add_argument('--workers', type=int, default=2)
    ap.add_argument('--models', nargs='*')
    ap.add_argument('--keys', nargs='*', help='Regenerate only the named samples')
    ap.add_argument('--limit', type=int)
    ap.add_argument('--plan-only', action='store_true')
    args = ap.parse_args()
    sys.path.insert(0, str(args.exhad.resolve()))
    from exhad import Generator
    specs = plans(json.loads(args.inputs.read_text()))
    if args.models:
        specs = [s for s in specs if s['model'] in args.models]
    if args.keys:
        specs = [s for s in specs if s['key'] in args.keys]
        if set(args.keys) != {s['key'] for s in specs}:
            raise ValueError('An unknown sample key was requested')
    if args.limit:
        specs = specs[:args.limit]
    args.output.mkdir(parents=True, exist_ok=True)
    (args.output/'plan.json').write_text(json.dumps(specs, indent=2))
    print('PLAN', len(specs), 'rows,', len({s['key'] for s in specs}), 'unique tables', flush=True)
    if args.plan_only:
        return
    xml = json.loads((args.exhad/'.runtime/current.json').read_text())['xmldoc']
    manifest = []
    generators = {}
    completed = {}
    try:
        for spec in specs:
            key = spec['key']
            if key in completed:
                manifest.append(dict(spec, **completed[key]))
                continue
            seed = int.from_bytes(hashlib.sha256(key.encode()).digest()[:4], 'big') % 899900000+1
            path = args.output/(key+'.wxf')
            receipt = path.with_suffix('.json')
            if path.exists() and receipt.exists():
                data = json.loads(receipt.read_text())
                if data['events'] != args.events or data['sha256'] != hashlib.sha256(path.read_bytes()).hexdigest():
                    raise RuntimeError('Existing sample does not match its receipt')
            else:
                start = time.monotonic()
                name = spec['generator']
                if name not in generators:
                    generators[name] = Generator(name, workers=args.workers)
                g = generators[name]
                print('BEGIN', key, flush=True)
                events = (hnl_events(g, spec, args.events, seed, xml) if name == 'hnl' else
                          g.generate(spec['mass'], args.events, seed=seed))
                if len(events) != args.events:
                    raise RuntimeError('Generator returned the wrong event count')
                array, checks = packed(events, spec['mass'])
                raw = path.with_suffix('.bin')
                array.tofile(raw)
                subprocess.run([args.wolfram, '-noinit', '-script',
                    str(Path(__file__).with_name('export.wls')), str(raw), str(path),
                    str(len(array)), str(array.shape[1])], check=True, timeout=120)
                data = dict(file=path.name, events=args.events, seed=seed,
                    sha256=hashlib.sha256(path.read_bytes()).hexdigest(), bytes=path.stat().st_size,
                    seconds=time.monotonic()-start, **checks)
                receipt.write_text(json.dumps(data, indent=2))
                print('PASS', key, round(data['seconds'], 2), data['bytes'], flush=True)
            completed[key] = data
            manifest.append(dict(spec, **data))
            (args.output/'manifest.json').write_text(json.dumps(manifest, indent=2))
        (args.output/'manifest.json').write_text(json.dumps(manifest, indent=2))
    finally:
        for g in generators.values():
            g.close()


if __name__ == '__main__':
    main()
