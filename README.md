# SensCalc

SensCalc is a [Wolfram Mathematica](https://www.wolfram.com/mathematica/) package for calculating the expected number of long-lived particle (LLP) decays and the sensitivity of accelerator experiments. It combines production spectra, decay probabilities, detector geometry and selection cuts using a common semi-analytic method. The [physics references](#physics-references-and-citation) describe the calculation method and the model phenomenology used in the framework.

The calculation separates quantities that can be reused: production spectra are tabulated for each facility, and decay acceptance for each experimental setup. This makes it possible to compare experiments under the same physics assumptions, vary their geometry or cuts, and examine which ingredients determine the reach.

## Start here

You need Mathematica **14.1 or later**, [FeynCalc](https://feyncalc.github.io/), and a C/C++ compiler recognized by Mathematica. Open [`0. Check for the needed soft.nb`](0.%20Check%20for%20the%20needed%20soft.nb) to check the installation.

For an implemented model and experiment, evaluate **“Launch this section to run the notebook”** at the top of each entry below. Dialogs guide the calculation.

| Step | Notebook | Result |
| --- | --- | --- |
| 1 | [`1. Acceptances.nb`](1.%20Acceptances.nb) | Geometry and decay acceptance for the chosen experiment and decay channels |
| 2 | [`2. LLP distribution.nb`](2.%20LLP%20distribution.nb) | LLP angle-energy distributions for the chosen facility and production modes |
| 3 | The model's `3. … sensitivity.nb`, for example [`3. Scalar sensitivity.nb`](3.%20Scalar%20sensitivity.nb) | Expected event counts and sensitivity regions |
| 4 | [`4. Plots.nb`](4.%20Plots.nb) | Figures comparing sensitivities and existing constraints |

Follow the [installation and first calculation](docs/getting-started.md) for a complete example.

## Documentation

The [PDF user guide](SensCalc_manual.pdf) covers the physics conventions and the full calculation workflow.

- [Calculation method](docs/calculation.md): event yield, acceptance, normalization and uncertainty choices.
- [Models and couplings](docs/models.md): physics definitions, production mechanisms and mass coverage.
- [Experiments and selection cuts](docs/experiments.md): available setups, geometry and detector requirements.
- [Recommended event selections](docs/recommended-selections.md): SHiP cuts and the NA62 reference selection.
- [Inputs, outputs and extensions](docs/inputs-and-outputs.md): file formats, units and how to add a model or production channel.
- [Event generation](docs/event-generation.md): weighted LLP decays and their output format.
- [Preparing decay samples](tools/decay-samples/README.md): converting fips-jets HepMC events to Mathematica inputs and generating quark-pair and secondary charm decays with Pythia.

The acceptance calculation includes secondary decays of $D^\pm$, $D_s^\pm$ and $\eta_c$ using compact, pre-generated Pythia samples. These inputs are included; Pythia is required only to regenerate them.

SensCalc's tabulated hadronic decay phase space does not include [exHad](https://github.com/maksymovchynnikov/exHad). Equal total widths or branching fractions between programs do not imply identical exclusive final states, daughter momenta or detector acceptances. Comparisons with exHad must distinguish the rate inputs, decay and hadronization models, and detector selections; differences between the tabulated Pythia samples and exHad-generated events must be assessed separately.

SensCalc includes heavy neutral leptons, dark photons, Higgs-mixed scalars, vector bosons coupled to baryon and lepton currents, several axion-like particle models, and inelastic dark matter coupled through a dark photon or an electromagnetic transition dipole. Millicharged particle production is also available. The [model reference](docs/models.md) defines their interactions and scan parameters.

For the scalar [BC5 benchmark](https://arxiv.org/abs/1901.09966), set the
Higgs branching fraction to $\mathrm{Br}(h\to SS)=0.01$ in the scalar
sensitivity notebook, where $h$ is the Higgs boson and $S$ the light scalar.
This parameter controls pair production independently of the mixing that sets
the decay lifetime. Select both pair-production and mixing-induced channels
for a combined prediction. Sensitivity filenames record the chosen Higgs
branching fraction as `BrhToSS=…`.

## Physics references and citation

Please cite the SensCalc method and the works relevant to the physics inputs used in your calculation.

| Subject | Reference |
| --- | --- |
| SensCalc method | M. Ovchynnikov, J.-L. Tastet, O. Mikulenko and K. Bondarenko, *Sensitivities to feebly interacting particles: public and unified calculations*, Phys. Rev. D **108**, 075028 (2023), [arXiv:2305.13383](https://arxiv.org/abs/2305.13383). |
| Dark photons and event generation | Y. Kyselov and M. Ovchynnikov, *Searches for long-lived dark photons at proton accelerator experiments*, Phys. Rev. D **111**, 015030 (2025), [arXiv:2409.11096](https://arxiv.org/abs/2409.11096). |
| Production through meson mixing | Y. Kyselov, S. Mrenna and M. Ovchynnikov, *New physics particles mixing with mesons: production in the fragmentation chain*, Phys. Rev. D **112**, 055033 (2025), [arXiv:2504.06828](https://arxiv.org/abs/2504.06828). |
| `ALP-photon`: primary and cascade Primakoff production, angle-energy fluxes and diphoton acceptance | M. Climescu, Y. Kyselov and M. Ovchynnikov, *Detector performance at SHiP for cascade-produced long-lived particles*, Phys. Rev. D **114**, 056016 (2026), [arXiv:2606.07743](https://arxiv.org/abs/2606.07743). |
| `ALP-electroweak`: meson decays, primary and cascade Primakoff production, flux normalization and diphoton signals | M. Climescu, M. F. Mikkelsen and M. Ovchynnikov, *SHiP as a (post-)discovery machine: identifying the diphoton signals' origin*, [arXiv:2609.19269](https://arxiv.org/abs/2609.19269). |

References for individual models accompany their definitions.

## License and contact

SensCalc is distributed under the [BSD 3-Clause License](LICENSE). Questions and reproducible problems can be submitted through [GitHub issues](https://github.com/maksymovchynnikov/SensCalc/issues). Contact: Maksym Ovchynnikov, [o.maxim@gmail.com](mailto:o.maxim@gmail.com).
