# ALP-electroweak inputs

[Back to models and couplings](../../docs/models.md#axion-like-particles)

`ALP-electroweak` describes an axion-like particle coupled to the $`\mathrm{SU}(2)_L`$ gauge fields, with diphoton decay, B and charged-kaon decays, and Primakov production. The interaction and decay width follow [arXiv:2609.19269](https://arxiv.org/abs/2609.19269). The [model reference](../../docs/models.md#axion-like-particles) defines the coupling $`g_W`$ in GeV$`^{-1}`$.

## Lifetime and mass coverage

`decay widths/ctauALP.txt` contains two whitespace-separated columns: mass in GeV and proper decay length in metres at $`g_W=1\;\mathrm{GeV}^{-1}`$. Logarithmic interpolation gives the lifetime between tabulated masses. At another coupling, multiply it by $`(1\;\mathrm{GeV}^{-1}/g_W)^2`$.

| Quantity | Mass range in GeV |
| --- | --- |
| Lifetime table | 0.001 to 10 |
| Acceptance grid | 0.02 to 5.12 |
| B-production grid | 0.02 to 5.12, subject to each recoil threshold |
| Charged-kaon production | 0.02 to 0.354 |
| Primakov production | 0.02 to 4 |

These tables use the diphoton approximation defined in the [model reference](../../docs/models.md#axion-like-particles), with unit branching fraction into two photons.

## Meson production

The branching tables give coefficients at $`g_W=1\;\mathrm{GeV}^{-1}`$. Multiplying by $`(g_W/(1\;\mathrm{GeV}^{-1}))^2`$ gives the branching fraction in the small-coupling regime.

`Production probabilities/Br-B-exclusive.txt` starts with mass in GeV, followed by ten $`B^+`$ branching coefficients. Their order is:

| Column | Recoil state | Mass in GeV |
| --- | --- | --- |
| 2 | $`K^+`$ | 0.493677 |
| 3 | $`K^*(892)^+`$ | 0.89556 |
| 4 | $`K^*(1410)^+`$ | 1.414 |
| 5 | $`K^*(1680)^+`$ | 1.718 |
| 6 | $`K_0^*(700)^+`$ | 0.838 |
| 7 | $`K_0^*(1430)^+`$ | 1.425 |
| 8 | $`K_1(1270)^+`$ | 1.256 |
| 9 | $`K_1(1400)^+`$ | 1.403 |
| 10 | $`K_2^*(1430)^+`$ | 1.4324 |
| 11 | $`\pi^+`$ | 0.13957039 |

The strange recoil states use the relative branching fractions of a Higgs-mixed scalar from [arXiv:1904.10447](https://arxiv.org/abs/1904.10447), normalized to the electroweak $`B\to Ka`$ rate. The pion contribution uses the corresponding $`b\to d`$ transition. Each channel closes at its recoil threshold. Neutral B decays are approximated by 0.93 times the charged-B rate.

`Production probabilities/Br-Kcharged.txt` contains mass in GeV and the $`K^+\to\pi^+a`$ branching coefficient, including the up-, charm- and top-quark loop contributions. The final point is the threshold at 0.35410661 GeV. Charge-conjugate decays have the same rate.

The total yield uses the facility's B-species fractions and bottom-production probability, including both bottom and antibottom. For `SPS`, the charged-kaon normalization is 0.36 per incident proton, with the decay-in-flight convention of the production spectra. Other facilities require their own beam and target inputs.

## Primakov production

Photon conversion in the target uses the normalized spectra of `ALP-photon`. The production probability is multiplied by $`(\alpha_{\rm em}/\pi)^2g_W^2`$, with $`\alpha_{\rm em}=1/137.035999177`$, to express it in the electroweak coupling convention. Primary photons and photons from the target cascade contribute separately.

See [existing constraints](../../contours/ALP-electroweak/README.md) for the exclusion data used in sensitivity plots.
