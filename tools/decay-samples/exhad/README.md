# exHad decay samples

These compressed event samples describe hadronic decays of the Higgs-mixed scalar, fermion-universal ALP, dark photon, $B-L$ vector, and heavy neutral leptons. [exHad](https://github.com/maksymovchynnikov/exHad) generates complete daughter four-momenta in the parent rest frame. SensCalc boosts the events and applies the experimental selection. Regeneration requires exHad and WolframKernel; acceptance calculations use the stored tables directly.

The scalar samples cover all four decay-width calculations available in SensCalc. For each boson, the complete hadronic final state is sampled with the total hadronic branching fraction from the selected SensCalc calculation. Exclusive hadronic channels are combined before sampling. Leptonic and diphoton decays keep their existing treatment. Total widths and production rates are unchanged.

For the dark photon, this combines the DarkCast hadronic normalization in SensCalc with the DeLiVeR-based exclusive composition in exHad. Comparisons with a complete exHad calculation must also account for this difference in decay rates.

HNL samples keep separate charged- and neutral-current decays and pure electron, muon, and tau mixings. Their primary three-body momenta follow the matrix elements and daughter masses loaded by SensCalc. The quark pair is replaced with hadrons at its sampled invariant mass, respecting the hadronic thresholds and the physical lepton endpoint. Charge-conjugate decays have equal probabilities. Subsequent tau decays are included. Neutral-current momenta are shared between the three mixings; the primary neutrino's flavour is assigned when sampling.

## Coverage and use

Each table contains 3000 unweighted events. The mass points are the existing SensCalc hadronization grid within these ranges:

| Model | Tabulated parent masses, GeV |
|---|---|
| Scalar | 2–62.49 |
| Fermion-universal ALP | 2.3–4.5 |
| Dark photon | 1.75–4.75 |
| $B-L$ vector | 2.25–4.75 |
| HNL | Open quark-pair channels at 1.5–20 |

With **Hadronized products** selected, the acceptance notebook uses these samples at their tabulated masses. Other masses and decay descriptions keep the existing treatment. The ALP-gluon model continues to use its original Pythia samples.

For bosons, include the complete hadronic channel set in the decay selection. A selection containing only some hadronic channels requires the Pythia calculation: set `$UseExHadDecaySamples = False` after initialization. The same setting restores the baseline for all models; `True` enables the exHad tables again. Leptonic-only selections are supported with either setting.

The events use the eight-field format described in [Preparing decay samples](../README.md). Neutrinos are retained. Photons, electrons, muons, charged pions and kaons, long-lived neutral kaons, and nucleons are terminal particles. The loader holds one additional table in memory at a time.

## Regeneration

Run from the SensCalc repository root, using an installed exHad and its Python environment:

```sh
workdir=$(mktemp -d /tmp/senscalc-exhad.XXXXXX)
WolframKernel -noinit -script tools/decay-samples/exhad/prepare.wls "$PWD" "$workdir"
python3 tools/decay-samples/exhad/generate.py \
  "$workdir/native-inputs.json" "$workdir/samples" --exhad /path/to/exHad
```

Copy the resulting `.wxf` files and `manifest.json` into `simulated phase space/exHad/` after verification. The generation script checks four-momentum, mass shells, electric charge, baryon number, and final-particle identities for every event. Compressed files must restore the arrays bit for bit. Each raw binary file is deleted immediately after this check. Remove the remaining preparation directory after installing and testing the compact inputs.

The sample size and parallel worker count can be set with `--events` and `--workers`. Deterministic seeds are assigned to each model, mass, decay-width calculation, and HNL current. The metadata records the exact channel grouping and a checksum for each table.
