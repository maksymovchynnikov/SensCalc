# Installation and first calculation

[Back to the README](../README.md)

## Installation

1. Install and activate [Wolfram Mathematica](https://www.wolfram.com/mathematica/), version 14.1 or later. The interactive workflow uses its notebook interface.
2. Follow the [FeynCalc installation instructions](https://feyncalc.github.io/).
3. Install a compiler supported by your Mathematica version. On Windows, Visual Studio's **Desktop development with C++** workload is one option; on macOS, install the Xcode command-line tools. Consult Wolfram's [compiler documentation](https://reference.wolfram.com/language/CCompilerDriver/tutorial/SpecificCompilers.html) for your platform.
4. Download the complete repository or clone it:

```sh
git clone https://github.com/maksymovchynnikov/SensCalc.git
```

Keep the directory tree together. The main notebooks locate their inputs relative to their own directory. A checkout in cloud storage must have its data files downloaded locally before a calculation starts.

Open [`0. Check for the needed soft.nb`](../0.%20Check%20for%20the%20needed%20soft.nb) and evaluate both cells. `DefaultCCompiler[]` should identify a compiler, and FeynCalc should load. For a direct compilation check, evaluate:

```wolfram
cf = Compile[{{x, _Real}}, x*x, CompilationTarget -> "C"];
cf[2.]
```

Successful compilation returns `4.`.

## Example: a Higgs-mixed scalar at SHiP

This example calculates the reach of the `SHiP-ECN3` setup for `Scalar`, with production through Higgs mixing. The scalar mass is in GeV and the scan variable is the squared mixing angle. [Model conventions](models.md) define the optional Higgs decay coupling.

### 1. Compute acceptance

Open [`1. Acceptances.nb`](../1.%20Acceptances.nb). Evaluate the top launch section using **Shift+Enter** and follow its dialogs:

- Choose `SHiP-ECN3`.
- Review the geometry, detectable species and cuts displayed by the notebook.
- Select `Scalar`, the decay channels of interest and a decay description.
- Choose the required detected-particle multiplicity and whether to use the precomputed hadronized decay samples.
- Keep the displayed experiment name for the standard configuration. Give modified cuts or geometry a distinct export name to keep those results separately.

The notebook displays the geometry and azimuthal acceptance. When evaluation finishes, the acceptance export is available under `Acceptances/<experiment>/`.

### 2. Compute production spectra

Open [`2. LLP distribution.nb`](../2.%20LLP%20distribution.nb) and run its top section. Select facility `SPS`, then `Scalar` and the production mechanisms to include. For the mixing example, use the available channels whose names end in `mixing`, plus proton bremsstrahlung if desired. The `quartic` channels describe production of a scalar pair through the Higgs coupling.

You can select several LLPs for the same facility. Choose production channels separately for each LLP; all selections are collected before calculations begin. `All channels` applies to the LLP named in that dialog.

The sampling dialog accepts an integer such as `10^6`, shared by the selected channels that use Monte Carlo sampling. Larger samples improve the statistical precision, particularly in angular and energy tails, at the cost of calculation time and memory.

Outputs are written to `spectra/New physics particles spectra/Scalar/`. The facility appears in each filename. Bremsstrahlung also produces probability tables under `phenomenology/Scalar/Production probabilities/`.

### 3. Compute event counts and sensitivity

Run [`3. Scalar sensitivity.nb`](../3.%20Scalar%20sensitivity.nb). Select the acceptance export from step 1, the same decay description, and production modes with completed spectra from step 2. Set the Higgs branching fraction into a scalar pair to zero for production through mixing alone.

Review the exposure and select the event threshold appropriate to the statistical analysis. The notebook calculates expected signal counts; its sensitivity boundary is the contour at the chosen count. A background model and a confidence-level construction are inputs to the choice of that threshold.

The results appear in `Tabulated Nevents/Scalar/<experiment>/` and `Sensitivity domains/Scalar/<experiment>/`. If a dialog reports missing distributions or production probabilities, generate those inputs before including the affected channels.

### 4. Plot

Open [`4. Plots.nb`](../4.%20Plots.nb), run the relevant model chapter and choose the available sensitivities. The saved metadata identify the exposure, event threshold and model parameters for each curve. Figures are exported under `plots/`.

HNL plots can combine different mixing patterns and Dirac/Majorana natures. Such a mixed plot keeps every selected sensitivity curve, uses the title “HNLs” and omits exclusion overlays. Select a common configuration when you want its matching constraints and detailed title.

## Reusing a calculation

| Change | What to run again |
| --- | --- |
| Exposure or signal-event threshold only | The rescaling/sensitivity section of notebook 3, then notebook 4 |
| Detector geometry, detectable species or cuts | Notebook 1, then 3 and 4 |
| Decay branching fractions, lifetime or matrix elements | Notebook 1, then 3 and 4; regenerate hadronized samples if their decay model changed |
| Mother spectra, production channels or their relative fractions | Notebook 2, then 3 and 4 |
| New masses outside the existing tables | Extend the relevant physical inputs and grids, then rerun all dependent steps |
| Figure labels or style | Notebook 4 |

Production spectra can be reused between experiments with the same facility inputs, including target material and beam conditions.

## If a run stops

Start from the first reported error. Compilation errors belong to the compiler setup; import failures usually identify a missing file or an incomplete download. After editing geometry or model definitions, open a fresh kernel and rerun the launch section to rebuild compiled functions and dependent quantities.

A decay description with zero branching fraction into the selected channels produces no acceptance table. If an export with that name already exists, the notebook stops and identifies the file to rename or remove before continuing.

For interpolation warnings, inspect the requested mass against both the production and acceptance tables. A zero event count can reflect a closed production channel, an excluded decay mode or the absence of acceptance. The [calculation method](calculation.md) describes how these ingredients determine the yield.

Memory use grows with the number of sampled decays and simultaneous calculations. Smaller samples or sequential facility runs reduce it, with the sample size also determining statistical precision.
