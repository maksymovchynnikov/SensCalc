# Models and couplings

[Back to the README](../README.md)

## Model choices

The following model identifiers are used in filenames and notebook definitions. The dialogs group the three heavy-neutral-lepton mixing cases under `HNL`. Inelastic models with fixed mass splittings have additional identifiers generated from their decay tables.

| Identifier | Particle and main production mechanisms | Physics reference |
| --- | --- | --- |
| `HNL-mixing-e`, `HNL-mixing-mu`, `HNL-mixing-tau` | Heavy neutral lepton mixing with the indicated neutrino flavour; meson, lepton and electroweak-boson decays | [1805.08567](https://arxiv.org/abs/1805.08567) |
| `Scalar` | Higgs-mixed scalar, with an optional Higgs coupling to a scalar pair; meson and Higgs decays, proton bremsstrahlung | [1904.10447](https://arxiv.org/abs/1904.10447), [2407.13587](https://arxiv.org/abs/2407.13587) |
| `DP` | Dark photon; meson decays, proton and electron bremsstrahlung, and Drell-Yan production where available | [1801.04847](https://arxiv.org/abs/1801.04847), [2409.11096](https://arxiv.org/abs/2409.11096) |
| `B`, `B-L`, `B-3Lmu`, `B-3Le-Lmu+Ltau`, `B-Le-3Lmu+Ltau` | Vector bosons coupled to baryon and lepton currents; meson decays, bremsstrahlung and Drell-Yan production | [1801.04847](https://arxiv.org/abs/1801.04847) |
| `ALP-photon` | Axion-like particle coupled to photons; Primakov production, photon fusion and radiative meson decays | [1904.02091](https://arxiv.org/abs/1904.02091) |
| `ALP-fermion` | Axion-like particle with universal fermion couplings at 1 TeV; heavy and light meson decays and production through hadronic interactions | [2501.04525](https://arxiv.org/abs/2501.04525) |
| `ALP-gluon` | Axion-like particle coupled to gluons at 1 TeV; meson decays and production through hadronic interactions | [2501.04525](https://arxiv.org/abs/2501.04525) |
| `ALP-electroweak` | Axion-like particle coupled to the weak SU(2) gauge fields; B and charged-kaon decays, primary and cascade Primakov production; diphoton decay | [2609.19269](https://arxiv.org/abs/2609.19269) |
| `Inelastic-dipole-DM` family | Two dark fermions coupled through an electromagnetic transition dipole; the heavier state decays into the lighter one and a photon | [2301.05252](https://arxiv.org/abs/2301.05252) |
| `MCP` | Millicharged particle production; the public workflow supplies fluxes | [2205.09137](https://arxiv.org/abs/2205.09137) |

Available mechanisms depend on the facility and its input spectra. Notebook 2 displays the implemented model/facility combinations before generation. Additional chapters cover `Dark-QCD-rho` and `Inelastic-DP-DM`, with parameters and input tables defined in their model sections.

## Heavy neutral leptons

For the heavy neutral lepton $`N`$, the charged-current interaction is

```math
\mathcal L\supset-\frac{g_2}{\sqrt2}\sum_{\alpha=e,\mu,\tau}
U_\alpha W^-_\mu\,\bar\ell_\alpha\gamma^\mu P_LN+\mathrm{h.c.},
```

with the corresponding neutral-current interaction fixed by electroweak mixing. Here $`g_2`$ is the weak gauge coupling, $`P_L`$ projects onto left chirality, and $`U_\alpha`$ is the mixing with flavour $`\alpha`$. The sensitivity notebook combines the three flavour inputs for a chosen ratio of $`|U_\alpha|^2`$ and scans their overall normalization.

## Higgs-mixed scalar

The interaction of `Scalar` is defined by

```math
\mathcal L\supset\theta m_h^2hS+\frac{\alpha}{2}hS^2.
```

The fields $`h`$ and $`S`$ are the Higgs boson and the lighter scalar; $`m_h`$ is the Higgs mass, $`\theta`$ is the small mixing angle, and $`\alpha`$ is a trilinear coupling with units of GeV. The scan parameter is $`\theta^2`$. Pair production is parameterized by $`\mathrm{Br}(h\to SS)`$ in the sensitivity notebook. The production labels containing `quartic` refer to this pair-production contribution.

Alternative hadronic decay descriptions change the widths into pions and kaons and therefore the lifetime and visible branching fractions.

## Vector bosons

For `DP`, the low-energy interaction contains kinetic mixing,

```math
\mathcal L\supset\frac{\epsilon}{2}V_{\mu\nu}F^{\mu\nu},
```

where $`V_{\mu\nu}`$ and $`F_{\mu\nu}`$ are the dark-photon and electromagnetic field strengths. The sensitivity scan uses $`\epsilon^2`$.

The baryon/lepton models use

```math
\mathcal L\supset g_B V_\mu\left(J_B^\mu+
\sum_{\alpha=e,\mu,\tau}x_\alpha J_{L_\alpha}^\mu\right),
\qquad \alpha_B=\frac{g_B^2}{4\pi}.
```

The currents $`J_B^\mu`$ and $`J_{L_\alpha}^\mu`$ count baryon number and individual lepton flavours. Their coefficients $`(x_e,x_\mu,x_\tau)`$ are $`(0,0,0)`$, $`(-1,-1,-1)`$, $`(0,-3,0)`$, $`(-3,-1,1)`$ and $`(-1,-3,1)`$ in the order of the vector-model identifiers in the table. The scan variable is $`\alpha_B`$. The `B` current is anomalous; its meson production depends on the assumptions about the ultraviolet theory described in the cited phenomenology.

## Axion-like particles

The dual of a field strength is $`\widetilde X^{\mu\nu}=\tfrac12\epsilon^{\mu\nu\rho\sigma}X_{\rho\sigma}`$. The implemented interactions and scan variables are:

| Model | Interaction | Scan variable |
| --- | --- | --- |
| `ALP-photon` | $`\mathcal L\supset(g_{a\gamma\gamma}/4)aF_{\mu\nu}\widetilde F^{\mu\nu}`$ | $`g_{a\gamma\gamma}`$ in GeV$`^{-1}`$ |
| `ALP-fermion` | $`\mathcal L\supset(\partial_\mu a/f_a)\sum_f\bar f\gamma^\mu\gamma_5 f`$ at 1 TeV | $`y=2v/f_a`$, dimensionless |
| `ALP-gluon` | $`\mathcal L\supset[\alpha_s/(4\pi f_a)]aG^A_{\mu\nu}\widetilde G^{A\mu\nu}`$ at 1 TeV | $`f_a^{-1}`$ in GeV$`^{-1}`$ |
| `ALP-electroweak` | $`\mathcal L\supset[\alpha_2g_W/(4\pi)]aW^I_{\mu\nu}\widetilde W^{I\mu\nu}`$ | $`g_W`$ in GeV$`^{-1}`$ |

Here $`a`$ is the axion-like field, $`f_a`$ is its interaction scale, $`v`$ is the electroweak vacuum expectation value, and $`\alpha_s`$ and $`\alpha_2`$ are the strong and weak fine-structure constants. The indices $`A`$ and $`I`$ label gluon and weak gauge fields. Evolution from 1 TeV induces other interactions in `ALP-fermion` and `ALP-gluon`; their decay tables include alternative hadronic descriptions.

Production of `ALP-fermion` in B decays includes both strange recoil states and $`B\to\pi a`$. Their spectra are combined using the relative branching fractions from the production tables.

At SPS, `ALP-fermion` production includes $`K^\pm\to\pi^\pm a`$, with the charged-kaon spectrum accounting for decays in flight. Its normalization is 0.36 in-flight charged-kaon decays per proton, from [arXiv:2004.07974](https://arxiv.org/abs/2004.07974). The $`K_S\to\pi^0a`$ contribution is a separate channel.

For `ALP-electroweak`, the diphoton coupling is $`g_{a\gamma\gamma}=\alpha_{\rm em}g_W/\pi`$, where $`\alpha_{\rm em}`$ is the electromagnetic fine-structure constant. Its decay width is

```math
\Gamma_{\gamma\gamma}=\frac{\alpha_{\rm em}^2m_a^3g_W^2}{64\pi^3},
\qquad c\tau=\frac{1.973269804\times10^{-16}\;\mathrm{GeV\,m}}
{\Gamma_{\gamma\gamma}}.
```

This calculation sets $`\mathrm{Br}(a\to\gamma\gamma)=1`$, following the diphoton approximation in [arXiv:2609.19269](https://arxiv.org/abs/2609.19269). See the [input definitions](../phenomenology/ALP-electroweak/README.md) for mass coverage, recoil states and production normalization, and the [constraint reference](../contours/ALP-electroweak/README.md) for existing bounds.

## Electromagnetic dark-sector interactions

The transition-dipole model uses

```math
\mathcal L\supset\frac{\mu}{2}F^{\mu\nu}\bar\chi_1\sigma_{\mu\nu}\chi_0+\mathrm{h.c.},
```

where $`\chi_1`$ is the heavier fermion, $`\chi_0`$ the lighter state and $`\mu`$ the dipole coupling in GeV$`^{-1}`$. The mass splitting is fixed by the selected model description.

A millicharged particle $`\chi`$ couples through $`\mathcal L\supset\epsilon e A_\mu\bar\chi\gamma^\mu\chi`$, with electric charge $`\epsilon e`$. Its flux calculation is selected in notebook 2.

## Mass coverage

A usable sensitivity point needs overlapping production, acceptance and lifetime/branching-fraction inputs. These domains depend on the channel, facility, decay description and availability of hadronized samples. Meson decays close at the mother mass minus the recoil masses; scattering spectra have their own tabulated range.

The available grid points are listed by `mLLPlist[model]` in notebook 1 and `MassList[model, productionMode, facility]` in notebook 2 after initialization. Notebook 3 uses the common mass interval of the imported tables. The [file reference](inputs-and-outputs.md#inspect-the-mass-domain) shows how to read the mass range from an export.
