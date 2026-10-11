# Experiments and selection cuts

[Back to the README](../README.md)

## Available setups

A **facility** defines the beam and production inputs; an **experiment** specifies geometry, exposure and detector requirements. Representative selections are:

| Facility identifier | Experiment choices |
| --- | --- |
| `SPS` | `SHiP-ECN3`, `SHiP-ECN4`, SHADOWS, HIKE-dump, NA62-dump, CHARM, BEBC |
| `FermilabBD` | `DUNE-ND-LAr`, `DUNE-PRISM`, `DarkQuest-phase-1`, `DarkQuest-phase-2` |
| `Serpukhov` | NuCal lepton and photon searches |
| `LHC` | FACET, PREFACE, FASER/FASER2, MATHUSLA, CODEX-b, ANUBIS-shaft, SND@LHC, advanced SND, FASER neutrino detectors and LHCb configurations |
| `FCC-hh`, `FCC-hh-85-TeV` | FCC configurations of FACET and MATHUSLA, FOREHUNT variants |
| `SLAC-E137` | `E137` |
| `ESS` | `SHiNESS`, `SHiNESS-forward` |
| `SuperKEKB` | `Belle II`, `Belle II optimistic` |

The experiment dialog shows the exact names and configuration variants. [`1. Acceptances. ANUBIS-ceiling.nb`](../1.%20Acceptances.%20ANUBIS-ceiling.nb) treats the ceiling geometry separately. Each setup defines its exposure, dimensions and detector requirements.

## Coordinates and geometry

The beam defines the longitudinal $`z`$ axis, with the production point at the origin. Positions and detector dimensions are in metres. A trajectory at polar angle $`\theta`$ and azimuth $`\phi`$ has $`x=z\tan\theta\cos\phi`$ and $`y=z\tan\theta\sin\phi`$ for forward motion.

[`codes/experiments.nb`](../codes/experiments.nb) contains the geometry and exposure definitions. Box, cylinder and annular-cylinder configurations use common geometry routines. Other shapes use explicit conditions. The detector plane can be transverse or parallel to the beam; its projection coordinates follow that choice.

To add a setup, copy the closest existing geometry section, choose a unique experiment identifier and specify:

- its facility, decay-volume position and dimensions;
- detector position, plane orientation and active cross-section;
- electromagnetic-calorimeter availability and any magnetic field and magnet boundaries;
- beam exposure, target material and mother-particle production yields;
- detectable species and the decay selection.

The existing definitions `DecayVolumeGeometry[experiment]`, `IfLLPinsideDecVol[z,x,y,experiment]` and detector-pointing conditions connect that geometry to the sampling. Their argument order and dimension conventions follow the chosen setup, including the use of full widths or half widths in its boundary conditions.

Notebook 1 displays the detector geometry and its angular acceptance. For an off-axis detector, the accepted azimuthal interval depends on the polar angle and decay position.

## Selection cuts

The [recommended event selections](recommended-selections.md) give SHiP settings and the NA62 reference cuts.

Notebook 1 prompts for detectable particles and the event signature. Geometry is evaluated with the particle trajectories, including the implemented magnetic deflection for charged daughters. Available cuts include individual energy and transverse momentum, as well as pair invariant mass, pair energy, separation and impact parameter where enabled by the setup.

| Selection | Requirement |
| --- | --- |
| `>=2` | At least one qualifying pair with zero total electric charge passes the relevant requirements |
| `>=n` | At least the requested number of detectable daughters passes the corresponding selection |
| `All detectable` | Every detectable daughter passes its own geometry, energy and transverse-momentum requirements; pair cuts are disabled for this option |

Special photon-search configurations have signatures described in the selection dialog. With `All detectable`, the additional forbidden-species list rejects events containing those particles, independently of whether they are detectable. Select `Null` when no such veto is intended.

The decay-channel list and the detector requirements are separate choices. Selecting a decay contributes its branching fraction to the visible rate; individual events still need to satisfy the acceptance criteria. Distinct export names identify configurations with different cuts or geometry. The [reuse table](getting-started.md#reusing-a-calculation) lists which calculations depend on each setting.

## Exposure

For a fixed-target search, exposure is the number of incident protons or electrons, with production evaluated for the chosen target material. For a collider, the integrated luminosity and production cross-sections determine the number of collisions and secondary particles. These quantities enter the acceptance export's experiment data and are imported by the sensitivity notebook.

A change in exposure alone rescales expected counts. Modifying beam energy, target material or relative mother yields can also alter the LLP spectrum and requires regenerated production inputs.
