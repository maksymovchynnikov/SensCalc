# Calculation method

[Back to the README](../README.md)

## Expected number of decays

For a search that detects the decay of one LLP, SensCalc computes

```math
N_{\rm events}=\sum_i N_i\int d\theta\,dE\,dz\;
f_i(\theta,E)\,\epsilon_{\rm az}(\theta,z)\,
\frac{dP_{\rm decay}}{dz}\,
\mathrm{Br}_{\rm vis}\,\epsilon_{\rm dec}(m,\theta,E,z).
```

Here $`i`$ labels a production mechanism, $`N_i`$ is the total number of LLPs produced through it, and $`f_i`$ is their normalized distribution in polar angle $`\theta`$ and energy $`E`$. The coordinate $`z`$ measures longitudinal displacement from the production point. Angles are in radians, energies and the LLP mass $`m`$ in GeV, and distances in metres.

The fraction $`\epsilon_{\rm az}`$ averages over the azimuthal angle: it measures which positions at fixed $`(\theta,z)`$ lie inside the decay volume. The factor $`\mathrm{Br}_{\rm vis}`$ is the sum of branching fractions for the selected decay channels. Conditional on those channels and an allowed decay position, $`\epsilon_{\rm dec}`$ is the fraction that passes the detector requirements. This separation is the basis of the method in [arXiv:2305.13383](https://arxiv.org/abs/2305.13383).

For a particle travelling toward positive $`z`$, the mean longitudinal decay length is

```math
\lambda_z=c\tau\,\frac{\sqrt{E^2-m^2}}{m}\cos\theta,
\qquad
\frac{dP_{\rm decay}}{dz}=\frac{e^{-z/\lambda_z}}{\lambda_z}.
```

The proper decay length $`c\tau`$ depends on the model's mass and coupling. The exponential accounts for survival to the decay position, followed by decay per unit longitudinal distance. A ray crossing the volume from $`z_1`$ to $`z_2`$ therefore has probability $`e^{-z_1/\lambda_z}-e^{-z_2/\lambda_z}`$.

## Production normalization

The distribution tables describe spectral shape. Absolute production is included separately, through the exposure and the probability per collision:

```math
N_i=N_{\rm collisions}\,P_i(m,g).
```

The symbol $`g`$ denotes the model's scan parameter, defined in the [model reference](models.md); some scans use a squared coupling. For production in secondary-particle decays, $`P_i`$ combines the mother yield with the branching fraction and LLP multiplicity. Scattering probabilities are normalized to the corresponding beam exposure.

Mother-particle yields include the charge-conjugate states specified by the facility's production inputs.

At symmetric colliders, the distribution routines combine the two beam hemispheres. Integrating a forward half of the angular domain gives the corresponding fraction of the total distribution.

## Decay acceptance

Rest-frame decays are sampled using two-body kinematics or the implemented three-body matrix elements, then boosted and propagated to the detector. Resampling uses the absolute value of each evaluated matrix-element weight, including negative values from truncated approximations. The same magnitude rule applies to production-decay sampling and four-body phase-space weights. Unstable daughters can decay recursively. Precomputed hadronized samples describe the multiparticle final states from quark and gluon channels; the alternative treatment replaces partons by hadronic proxies.

The selection determines $`\mathrm{Br}_{\rm vis}`$, while geometry, magnetic deflection and kinematic cuts enter $`\epsilon_{\rm dec}`$. Photon detection depends on the electromagnetic calorimeter setting. The [selection reference](experiments.md#selection-cuts) explains the multiplicity options.

## Integrating and comparing assumptions

Expected event counts are evaluated on a mass-coupling grid by interpolating the production and acceptance tables and summing over angle, energy and decay position. Direct numerical integration is also available for comparison.

A sensitivity region contains parameter points whose expected signal exceeds the chosen threshold. Separate production and decay descriptions allow uncertainty comparisons, for example among bremsstrahlung form factors or hadronic widths. Each scenario combines one description for each production mechanism.

Uncertainty bands span the sensitivities obtained with alternative production and decay descriptions. Contributions without alternative calculations stay fixed. For `Scalar`, mixing and pair production share a common decay description and are combined at the chosen Higgs branching fraction.

The long-lifetime approximation expands the decay probability when the boosted decay length greatly exceeds the detector distance. The full exponential also accounts for decays before the particle reaches the volume.
