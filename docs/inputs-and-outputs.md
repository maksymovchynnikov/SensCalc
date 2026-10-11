# Inputs, outputs and extensions

[Back to the README](../README.md)

## Directory map

Paths below are relative to the repository root. Generated directories are created when the corresponding calculation runs.

| Directory | Contents |
| --- | --- |
| `codes/` | Shared notebook routines and experiment definitions |
| `codes/Acceptances/` | Model decay definitions and decay-sampling routines |
| `codes/LLP distribution/` | Production definitions and spectrum-generation routines |
| `codes/SensCalc/` | Yield integration and sensitivity routines |
| `codes/EventCalc/` | Event-generation routines |
| `phenomenology/<model>/` | Lifetimes, branching fractions, matrix elements and production probabilities |
| `spectra/SM particles/` | Mother-particle angle-energy distributions |
| `spectra/New physics particles spectra/<model>/` | LLP spectra; the facility is encoded in the filename |
| `simulated phase space/` | Rest-frame hadronized decay samples |
| `Acceptances/<experiment>/` | Acceptance tables and experiment data |
| `Tabulated Nevents/<model>/<experiment>/` | Signal counts as a function of mass and coupling |
| `Sensitivity domains/<model>/<experiment>/` | Sensitivity contours and uncertainty regions |
| `contours/<model>/` | Existing exclusions for comparison |
| `Sampled Nevents/<experiment>/<model>/run-<id>/` | Weighted EventCalc samples |
| `plots/` | Exported figures |

Several `.m` files contain Wolfram **MX binary data**. The extension alone does not identify their format. Use the import format shown below or in the notebook that reads the file.

## Input spectra

A mother spectrum is a table of

```text
polar_angle_rad    energy_GeV    probability_density
```

The density is defined with respect to `dtheta dE`; its units are inverse radians per GeV. The angular domain and normalization follow the facility definition, including the two hemispheres of a symmetric collider. Absolute mother yields enter separately through the experiment data.

The naming pattern is `DoubleDistr_<facility>_<mother>.txt`. Recognized particle names and their masses are defined in [`codes/SensCalc/SM particles.nb`](../codes/SensCalc/SM%20particles.nb). After initialization, inspect them with:

```wolfram
Keys[DownValues[mSM]][[All, 1, 1]]
```

Some production spectra come from external event generation and reside in the model's `Pregenerated/` subdirectory. The [MadGraph](https://launchpad.net/mg5amcnlo) and [Pythia](https://pythia.org/) calculations that produce such inputs are separate from running the standard notebook sequence. The repository includes UFO model files under `UFO files/`.

## Acceptance output

Notebook 1 writes

```text
Acceptances/<experiment>/Acceptance_<experiment>_for_<model>_decayDescription_<description>.m
```

Read it with `Import[path, "MX"]`. The result has seven elements:

| Position | Meaning |
| --- | --- |
| 1 | Facility identifier |
| 2 | Electromagnetic-calorimeter availability |
| 3 | Numeric acceptance table |
| 4 | Experiment exposure and mother-particle production data |
| 5 | Branching fraction of the selected decay modes, as an expression in mass |
| 6 | Explanation of the decay description |
| 7 | Proper decay length in metres, as an expression in mass and coupling |

Each row of element 3 is

```text
mass_GeV    theta_rad    energy_GeV    z_m    epsilon_az    epsilon_dec
```

The last two entries are the azimuthal and decay-product acceptances defined in the [yield equation](calculation.md#expected-number-of-decays). The file contains both those functions and the visible branching fraction so that notebook 3 can apply each factor once.

## Production output

A standard LLP spectrum is stored as

```text
spectra/New physics particles spectra/<model>/DoubleDistr_<model>_<production>_<facility>.m
```

Its MX data have four columns:

```text
mass_GeV    theta_rad    energy_GeV    probability_density
```

All three HNL mixing cases use the `HNL/` directory. Bremsstrahlung exports may contain a list of named descriptions, each with its distribution table, because the production calculation evaluates several physical assumptions. The corresponding probability tables must match the selected description and facility.

### Inspect the mass domain

For a standard spectrum and an acceptance export, evaluate in a fresh kernel with `spectrumPath` and `acceptancePath` set to the actual filenames:

```wolfram
spectrum = Import[spectrumPath, "MX"];
acceptance = Import[acceptancePath, "MX"];
{
  "production masses" -> MinMax[spectrum[[All, 1]]],
  "acceptance masses" -> MinMax[acceptance[[3, All, 1]]]
}
```

For a file containing named production descriptions, first select the distribution table for one description. Use only the common interval, subject to physical thresholds and the lifetime/branching-fraction domain. The sampled mass nodes can be inspected by replacing `MinMax` with `DeleteDuplicates`.

## Event counts and contours

Notebook 3 exports counts for each production mode as text tables with columns

```text
mass_GeV    model_scan_parameter    expected_events
```

The coupling convention is model dependent; see [models and couplings](models.md). Filenames include the model, production mechanism, experiment, exposure and decay description.

A sensitivity calculation combines the event-count tables for its selected production channels and decay description.

Sensitivity files begin with `Sensitivity_` and contain the selected production modes, uncertainty choices, decay description and a list of sensitivity regions. MX exports preserve Wolfram expressions; JSON exports use named fields. Each region is an ordered list of mass-coupling coordinates. Multiple disconnected regions remain separate lists. `Uncertainty_` files describe the central contour and the regions produced by varying the physical inputs.

An adjacent `.metadata.json` file records the selected production channels, decay descriptions, exposure and event threshold, together with model-specific parameters. Exporting to an existing filename replaces that result, including when production channels or decay descriptions have changed. Notebook 4 reads the saved paths and metadata.

The three ANUBIS-shaft modules contribute to a common event count by summing tables with matching mass/coupling grids, exposure and decay description.

Existing exclusions under `contours/` provide comparison bounds for sensitivity plots. A closed contour lists consecutive boundary vertices and repeats its first point at the end.

## Hadronized decay samples

A rest-frame sample contains one decay per row, with eight entries per daughter:

```text
px    py    pz    energy    mass    PDG_identifier    electric_charge    stability
```

The first five quantities are in GeV, charge is in proton-charge units, and stability is `1.` for a stable or metastable particle and `0.` for an unstable one. PDG identifiers are numeric, for example `22.` for a photon. Variable-length events are padded on the right with `-999.` to form rectangular arrays. Treat padding as missing particle data.

Names follow the `<model>_<channel>_<mass>.m` convention, with the model and channel spelling used by the decay definitions. Read these files with the import format used in the corresponding model section.

Hadronized samples are available at discrete masses. The initialization constructs a compatible mass list and can fall back to the implemented hadronic-proxy treatment where a sample is absent.

## Add a model

Start from the existing model closest in spin, decay topology and production mechanism. Keep definitions in the corresponding model notebooks and reuse the common samplers.

For decays, add `codes/Acceptances/<model>.nb` with:

- `ModelDescription`, `couplingSymbol`, and the selectable decay descriptions;
- `cτLLP[model, description, mass, coupling]` in metres;
- `ListBrRatios[model, mass, process, description]` and `ListDecayProducts[model, process]`;
- three-body matrix elements in the argument convention used by that model's decay loader;
- hadronized samples where required.

The daughter list has four entries, with unused positions set to the string `"Null"`. A three-body squared matrix element is expressed in the parent mass and rest-frame energies of daughters **1 and 3**, in exactly that ordering. A constant overall factor cancels when sampling a normalized shape; relative terms and interference must be preserved. Generic four-body generation uses the implemented phase-space treatment.

Register the acceptance mass grid and launch section in notebook 1. A decay description needs mutually consistent branching fractions, lifetime and matrix elements across its domain.

For production, add `codes/LLP distribution/prod-pheno-<model>.nb` with:

- `ProcessesListAll[model]` and `ProductionType[model, process]`;
- `ReactionProductsList[model, process]`, with the mother first and LLP last;
- `Msquared3Body[model, process, mass, E1, E3]` for three-body production;
- the relative branching fractions needed when several decays contribute to one merged spectrum.

Update facility availability and the production sections and mass grids in notebook 2. Its section names follow `<model>_<production>`. Reuse an existing two-body, three-body, Primakov, fusion or bremsstrahlung calculation when the physical process matches.

Finally, adapt a model sensitivity notebook so `PmotherToLLP` agrees with the new spectrum normalization and coupling convention. Add the plotting chapter and any constraints with their sources.
