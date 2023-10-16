# SensCalc

## What it is?

SensCalc is a Mathematica-based code allowing to calculate sensitivities of lifetime frontier experiments to Feebly Interacting Particles (FIPs). The method of the calculation is based on the semi-analytic approach described in [2305.13383](https://arxiv.org/abs/2305.13383) and successfully many times in older publications. The main purposes of the code are:

1. Comparison of the sensitivities of various experiments obtained under the same assumptions about the FIP phenomenology (such as production and decay),
2. Possibility of studying how the sensitivity would change under varying the experimental setup, such as dimensions of the experiment and the selection of the events with FIPs,
3. Allowing any person beyond the experiment collaboration to check and understand qualitatively the sensitivity of the experiment.

## Why Mathematica?

Evaluating sensitivities to FIPs is often much simpler than detailed event analysis or background evaluation. If computing the distributions of mother particles producing the FIPs externally, the sensitivity evaluation is split into relatively trivial computations such as calculating the FIP distribution function and evaluating the acceptances for the FIP and its decay products. Mathematica is a great environment for such a task. Namely, everything from computing the matrix elements of the FIP production and decay to working with the geometry of the experiment may be made inside it. In addition, [Mathematica notebooks](https://www.wolfram.com/notebooks/) provide a convenient visual framework. Finally, there is a very friendly and experienced [Mathematica community](https://mathematica.stackexchange.com/) whose members may help with any question (and probably optimize the performance of SensCalc by another factor of ten).


Mathematica language does not suit well for performing some low-level routine operations such as producing the phase space of decays or propagating the particles through space. Fortunately, to improve this part, the Mathematica code may be simply [compiled](https://reference.wolfram.com/language/Compile/tutorial/Efficiency.html#9770950728) into a native machine code, which may improve the performance by a factor of a hundred and more. 


## How to launch

### Dependencies

To run SensCalc, two tools have to be installed: [FeynCalc](https://feyncalc.github.io/) and a C compiler. 

### Input

You should provide the pheomenology of the given model (the list of branching ratios of the production and decay channels, corresponding squared matrix elements (if the production/decay channel is 3-body and higher), and the experimental setup -- geometry and selection criteria for the FIP decay products. More details are provided in *Manual.pdf*. If the mentioned ingredients are similar to the already implemented cases, this may be done by copying the existing code.

### Code structure

SensCalc has a modular structure. The sensitivity calculation is performed with the help of four notebooks:

1. <dt><code>Acceptances.nb</code></dt> which evaluates the tabulated acceptances for the given FIP to decay inside decay volume and for its decay products to satisfy the decay acceptance criteria.

2. <dt><code>FIP distribution.nb</code></dt> which evaluates the angle-energy distribution of FIPs at the facility housing the given experiment.

3. <dt><code>FIP sensitivity.nb</code></dt> which calculates the tabulated number of events with decays of FIPs at the given experiment.

4. <dt><code>Plots.nb</code></dt> which makes figures with the sensitivities.

Details are described in *Manual.pdf*.

For the FIPs and experiments that are already implemented, the user just needs to launch the section *Just launch the code below to run the notebook* located at the top of each notebook. The relevant sections will then be launched automatically, and the notebook will prompt the user to specify the required inputs via dialog windows. If, however, the user wants to modify the model, geometry, or assumptions, they may change the code and inputs as described in the following sections.


## (Currently) implemented list of facilities and FIPs

The following experiments that either have been proposed or are currently running are implemented:

* Fermilab (beam dump facilities)
  - DUNE-ND-LAr, DUNE-PRISM, DarkQuest
* SPS
  - SHiP, SHADOWS, HIKE-dump, NA62-dump, CHARM, BEBC
* LHC
  - FACET, FASER, FASER2, FASER2-FPF, FASERν, FASERν2, SND@LHC, advSND<sub>near</sub>, advSND<sub>far</sub>, ANUBIS-shaft, ANUBIS-ceiling, MATHUSLA, CODEX-b, LHCb (beyond VELO)
* FCC-hh 
  - MATHUSLA-FCC, FACET-FCC, FOREHUNT

The following FIPs are implemented:

* Heavy Neutral Leptons (HNLs) with arbitrary mixing pattern
* Dark photons
* Mediators coupled to anomaly-free combinations of the baryon and lepton currents: U<sub>B-L</sub>(1), U<sub>B-3Lmu</sub>(1), U<sub>B-Le-3Lmu+Ltau</sub>(1), U<sub>B-3Le-Lmu+Ltau</sub>(1)
* Dark scalars with mixing and quartic couplings
* ALPs coupled to photons, fermions, or gluons
* Millicharged particles (only the production in the public version)


