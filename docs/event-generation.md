# Event generation

[Back to the README](../README.md)

[`EventCalc.nb`](../EventCalc.nb) generates LLP momenta, decay vertices and daughter momenta from the production distributions. The method accompanies [arXiv:2409.11096](https://arxiv.org/abs/2409.11096). The events carry weights that reproduce the decay yield; they can be passed to further detector studies with those weights.

## Run

Generate the required spectra with notebook 2. Open EventCalc and run its launch section, then select the experiment, model, production modes and decay channels. The model-selection dialog offers `HNL`, `Scalar`, `DP`, `ALP-photon` and `ALP-fermion`.

After initialization, the main call is

```wolfram
{expectedEvents, llpInfo, daughters} =
  NeventsBlock[mass, coupling1, coupling2, numberToSample];
```

Use the coupling definitions initialized for the selected model. The second coupling is relevant when production has an independent parameter, such as scalar pair production. The initialized notebook contains examples showing those choices.

The default decay call uses the direct decay products. The underlying routine exposes explicit choices through

```wolfram
SimulateFullEvent[mass, coupling1, coupling2, numberToSample,
  HadronizationOption, DecayUnstable]
```

The last two arguments are the strings `"True"` or `"False"`. They control the use of hadronized samples and subsequent decays of unstable daughters, respectively. EventCalc's production and decay selections must have data at the requested mass.

## LLP information

The returned LLP table has one row per generated decay:

| Columns | Meaning |
| --- | --- |
| 1 to 3 | LLP momentum components in GeV |
| 4, 5 | Energy and mass in GeV |
| 6, 7 | Cosine of the polar angle and momentum divided by mass |
| 8 | Decay probability along the sampled ray inside the volume |
| 9 to 11 | Decay position $`x,y,z`$ in metres |
| 12 | Azimuthal sampling weight |
| 13 | Total production normalization used for the selected sample |
| 14 | Fraction from the angle-energy selection |

Let $`w_j`$ denote column 12 and $`P_j`$ column 8 for event $`j`$. The yield returned by `NeventsLLP` is

```math
N_{\rm events}=N_{\rm prod}\,\epsilon_{\rm geom}
\frac{1}{n}\sum_{j=1}^{n}P_jw_j,
```

where $`n`$ is the sample size and the constant factors $`N_{\rm prod}`$ and $`\epsilon_{\rm geom}`$ are columns 13 and 14. Distributions of the generated decays use the same event weights $`P_jw_j`$.

For `Scalar`, the relative populations from mixing and pair production include both the total production rate $`R_i`$ and the fraction $`A_i`$ inside the sampled angle and energy domain of component $`i`$. Its probability is $`R_i A_i/\sum_j R_j A_j`$, and column 14 is $`\sum_i R_i A_i/\sum_i R_i`$.

The azimuthal sampling weight corrects the distribution used to choose rays through the volume. It can exceed one and contributes to both the event yield and decay distributions. For a ray at polar angle $`\theta`$ and azimuth $`\phi`$, it is $`w=I(\theta)/L(\theta,\phi)`$, where $`L`$ is the length of its allowed interval in the longitudinal coordinate $`z`$, and $`I(\theta)=\int dz\,\epsilon_{\rm az}(\theta,z)`$. The sampler selects rays in proportion to $`L`$; this factor removes that bias.

## Daughter information and exports

The daughter table uses consecutive groups of eight columns per particle: momentum components, energy, mass, PDG identifier, charge and stability. Units and padding are specified in the [decay-sample format](inputs-and-outputs.md#hadronized-decay-samples). LLP and daughter rows correspond event by event.

`NeventsBlock` exports `LLPinfo_mass=…_coupling1=…_coupling2=….mx` and `DecayEvents_mass=…_coupling1=…_coupling2=….mx` inside a new `Sampled Nevents/<experiment>/<model>/run-<id>/` directory on each call. The accompanying `metadata.json` records the model, experiment, facility, mass, couplings, sample count, selected production and decay channels, decay description, and column units. Read the arrays with `Import[path, "MX"]` and keep the three files together.

Detector propagation and event selection can then be applied to the generated daughters.

For `DP`, production spectra distinguish meson-mixing and fragmentation descriptions, following [arXiv:2409.11096](https://arxiv.org/abs/2409.11096).
