# Preparing decay samples

SensCalc reads compact samples of daughter four-momenta in the parent's rest frame. Each event contains repeated groups of eight values:

`px, py, pz, E, mass, PDG code, electric charge, stability`

Momenta and masses are in GeV, charge is in positron-charge units, and stability is `1` for particles whose subsequent decays are not simulated. Events are padded with `-999.` to a common length. The loader accepts binary `MX` files (`.m`) and losslessly compressed Wolfram Expression Format files (`.wxf`). Both restore the same machine-precision arrays before sampling.

The complete-event exporters write compressed `.wxf` files and check that reading them restores the arrays bit for bit before replacing a same-named `.m` sample. Event counts, particle order and numerical precision are preserved.

## Converting fips-jets events

The two notebooks in `fips-jets/` convert HepMC events:

- `convert-hepmc.nb` exports complete events for acceptance calculations. Place files named `<model>_<process>_<mass>.hepmc` in `fips-jets/Initial phase space/`, create `fips-jets/Extracted phase space/`, evaluate the initialization, then use the lower **all-decays** export section (`SelectingCommonestDecays1`). The default sample contains up to 3000 events. Copy the resulting `.wxf` files into SensCalc's `simulated phase space/` directory.
- `select-channels.nb` selects particular final-state compositions and exports their relative fractions and momenta. Put `<model>-<process>-<mass>.hepmc` files beside this notebook and run its upper export section. Its output is for channel studies; the acceptance loader uses the complete-event format above.

Configure the event generator before conversion so that photons, electrons, muons, charged pions and kaons, long-lived neutral kaons, and nucleons are final particles. Neutrinos must remain in the event record. The converter reads HepMC final-status particles and preserves their momenta.

The input samples must already be generated in the parent's rest frame, with the same parent mass used by SensCalc. Raw HepMC files are temporary preparation data and should be removed after checking the compact exports.

## Secondary charm decays

The required samples in `simulated phase space/SM/` contain inclusive decays of $D^\pm$, $D_s^\pm$ and $\eta_c$, including their decay chains. They are generated with [Pythia 8](https://pythia.org/) at parent masses 1.869, 1.968 and 2.9839 GeV, respectively. SensCalc samples these events and boosts the daughters from the parent rest frame to the HNL rest frame. HNL branching ratios and total widths are supplied by the HNL phenomenology tables.

To regenerate these inputs, use Python with NumPy and the Pythia 8 binding, followed by WolframKernel. Run from the repository root:

```sh
python3 tools/decay-samples/secondary-decays/generate.py /tmp/secondary-decays.json
WolframKernel -noinit -script tools/decay-samples/secondary-decays/export.wls \
  /tmp/secondary-decays.json "simulated phase space/SM"
```

The generator checks four-momentum, electric charge and baryon number for every event and writes a small report next to the temporary JSON file. The fixed seed and 3000 events per parent are defaults; `--seed` and `--events` change them. Pythia is needed only when regenerating the samples. Delete the temporary JSON after checking the `.wxf` files.


## Quark-pair decays

The HNL samples contain $N\to\ell^-u\bar s$, $N\to\ell^-c\bar d$, $N\to\ell^-u\bar b$, $N\to\ell^-c\bar b$ and $N\to\nu b\bar b$, with $\ell=e,\mu,\tau$. They use the spin-averaged weak-current matrix elements and daughter masses loaded by SensCalc. The corresponding ALP samples contain isotropic $a\to s\bar s$ decays. Pythia simulates radiation from the outgoing quarks and charged leptons, hadronization and the subsequent decays, with a shower starting scale of half the parent mass. Total widths and branching ratios come from the phenomenology tables.

The HNL inputs cover the open channels on SensCalc's hadronization mass grid up to 20 GeV. The strange-quark ALP samples include 4.5 and 5.1 GeV. To regenerate them from the repository root:

```sh
WolframKernel -noinit -script tools/decay-samples/partonic-decays/prepare.wls \
  "$PWD" /tmp/partonic-decays
python3 tools/decay-samples/partonic-decays/generate.py \
  /tmp/partonic-decays/samples.json /tmp/partonic-decays/events
WolframKernel -noinit -script tools/decay-samples/partonic-decays/export.wls \
  /tmp/partonic-decays/events "simulated phase space"
```

The preparation step checks the analytic HNL expression against the loaded matrix elements and records the masses. Rejection sampling produces 3000 independent primary decays per channel and parent mass; Pythia then generates complete final states. Each saved event must conserve four-momentum, electric charge and baryon number. These samples were generated with Pythia 8.312. Another version may give different fragmentation and decay distributions. Remove the temporary JSON events after checking the compact Mathematica inputs.
