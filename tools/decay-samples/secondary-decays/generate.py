"""Generate rest-frame D+/-, Ds+/-, eta_c decays for SensCalc.

Run with a Python installation containing Pythia 8 and NumPy. Run export.wls
afterwards to turn the temporary JSON into the standard SensCalc MX .m files.
"""
import argparse
import json
from pathlib import Path

import numpy as np
try:
    import pythia8
except ImportError:
    import pythia8mc as pythia8


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--events", type=int, default=3000)
    parser.add_argument("--seed", type=int, default=182031)
    args = parser.parse_args()
    if args.events < 1 or not 1 <= args.seed < 900000000:
        parser.error("events must be positive and seed must be in [1, 900000000)")
    p = pythia8.Pythia("", False)
    for setting in ["ProcessLevel:all = off", "PartonLevel:all = off",
                    "HadronLevel:all = on", "Print:quiet = on",
                    "Random:setSeed = on", f"Random:seed = {args.seed}"]:
        if not p.readString(setting):
            raise RuntimeError(setting)
    # SensCalc treats these charged tracks and neutral hadrons as metastable.
    for pid in (13, 211, 321, 130, 2112):
        p.particleData.mayDecay(pid, False)
    if not p.init():
        raise RuntimeError("Pythia initialization failed")
    parents = [(411, 1.869), (-411, 1.869), (431, 1.968), (-431, 1.968), (441, 2.9839)]
    records, reports = [], []
    for pid, mass in parents:
        events = []
        max_error = 0.0
        retried = 0
        for _ in range(args.events):
            for attempt in range(100):
                p.event.reset()
                p.event[0].p(pythia8.Vec4(0, 0, 0, mass))
                p.event[0].m(mass)
                p.event.append(pid, 91, 0, 0, 0., 0., 0., mass, mass)
                # Complete hadron-level evolution also fragments partonic
                # products of heavy-hadron decays.
                if not p.forceHadronLevel():
                    retried += 1
                    continue
                rows = []
                charge3 = baryon = 0
                for i in range(1, p.event.size()):
                    a = p.event[i]
                    if a.isFinal():
                        rows.append([a.px(), a.py(), a.pz(), a.e(), a.m(),
                                     float(a.id()), a.charge(), 1.])
                        charge3 += a.chargeType()
                        if p.particleData.isBaryon(a.id()):
                            baryon += 1 if a.id() > 0 else -1
                arr = np.asarray(rows)
                if not rows or not np.isfinite(arr).all():
                    raise RuntimeError(f"Nonfinite or empty decay for {pid}")
                error = float(np.max(np.abs(arr[:, :4].sum(axis=0) - [0, 0, 0, mass])))
                shell = float(np.max(np.abs(arr[:, 3]**2 - (arr[:, :3]**2).sum(axis=1) - arr[:, 4]**2)))
                if charge3 != p.particleData.chargeType(pid) or baryon != 0:
                    raise RuntimeError(f"Quantum-number violation in {pid} decay")
                if error > 1.e-8 * mass or shell > 1.e-8 * mass**2:
                    retried += 1
                    continue
                max_error = max(max_error, error)
                events.append(arr.ravel().tolist())
                break
            else:
                raise RuntimeError(f"Failed to finish {pid} decay after 100 attempts")
        records.append({"pdg": pid, "mass": mass, "events": events})
        report = {"pdg": pid, "events": len(events), "max_p4_error_GeV": max_error,
                  "retries": retried, "mean_multiplicity": np.mean([len(e)/8 for e in events])}
        reports.append(report)
        print(json.dumps(report), flush=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps({"pythia_version": p.settings.parm("Pythia:versionNumber"),
                                      "seed": args.seed, "samples": records}, separators=(",", ":")))
    args.output.with_suffix(".report.json").write_text(json.dumps(reports, indent=2))


if __name__ == "__main__":
    main()
