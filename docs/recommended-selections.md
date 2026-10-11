# Recommended event selections

[Back to the README](../README.md) · [Experiments and selection cuts](experiments.md)

These examples give preferred starting selections for LLP decay searches. Enter the cuts when calculating acceptance in [`1. Acceptances.nb`](../1.%20Acceptances.nb); selecting an experiment loads its geometry but does not apply these examples automatically.

## SHiP

For `SHiP-ECN3` and `SHiP-ECN4`, use the following selection, following [*BDF/SHiP at the ECN3 high-intensity beam facility* (CERN-SPSC-2023-033)](https://cds.cern.ch/record/2878604?ln=en):

| Setting | Choice |
| --- | --- |
| Signature | `>=2` detectable particles |
| Individual energy | Above 1 GeV for every particle category: electrons, muons, charged hadrons, photons and neutral hadrons |
| Impact parameter | Below 2.5 m |
| Decay channels | All allowed channels |
| Other optional kinematic cuts | Disabled |

The energy threshold applies to each daughter used to satisfy the signature. The `>=2` option requires a qualifying pair with zero total electric charge; its impact parameter is obtained by projecting the pair's combined momentum back toward the production point.

## NA62 in dump mode

For `NA62-dump`, the reference selection is described in Appendix C.4 of [*Not-so-inelastic Dark Matter*, arXiv:2405.08081](https://arxiv.org/abs/2405.08081), informed by discussions with collaboration members.

| Requirement | Reference selection |
| --- | --- |
| Signature | At least two charged decay products |
| Geometry | Daughter trajectories within the detector acceptance through the calorimeters |
| Individual momentum | Above 1 GeV |
| Muon-pair separation | At least 0.02 m at the beginning of the straw tracker |
| Electron/hadron-pair separation | At least 0.20 m at the ECAL entrance |

In the acceptance dialog, use `>=2` and an individual **energy above 1 GeV** as the practical approximation to the momentum requirement for relativistic daughters. For the paper's example with an invisible daughter, leave the impact-parameter cut disabled; that study does not prescribe a numerical threshold.

**Separation settings:** the dialog supplies one threshold for charged particles. Although the trajectory routines distinguish muon and non-muon projection planes, `NA62-dump` assigns both to the downstream detector plane. The two species-dependent requirements in the table therefore need separate thresholds and projection planes to reproduce the reference selection exactly; entering a single charged-particle separation value does not implement both.
