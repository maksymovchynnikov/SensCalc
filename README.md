# SensCalc

## What is it?

SensCalc is a Mathematica-based code allowing to calculate sensitivities of lifetime frontier experiments to Long-Lived Particles (LLPs). The method of the calculation is based on the semi-analytic approach described in [2305.13383](https://arxiv.org/abs/2305.13383) and [2409.11096](https://arxiv.org/abs/2409.11096) and successfully used many times in past publications. The main purposes of the code are:

1. Comparison of the sensitivities of various experiments obtained under the same assumptions about the LLP phenomenology (such as production and decay),
2. Possibility of studying how the sensitivity would change under varying the experimental setup, such as dimensions of the experiment and the selection of the events with LLPs,
3. Allowing any person beyond the experiment collaboration to check and understand qualitatively the sensitivity of the experiment.

You are allowed to flexibly choose many inputs, including (but not restricting to): what mother particles distributions to use; which production and decay channels of LLPs to consider when calculating the number of events, what selection should be imposed on decay products. You may easily change the setup of the experiment by adjusting several simple parameters. Making all these changes, you may recalculate the sensitivities very fast - the feature which is unavailable with long simulations. Finally, the code allows qualitative understanding of why some setup would provide higher event rate than another one: you may analyze the impact of the angular placement, decay probability, and decay products acceptance between different experiments. 

SensCalc has been tested with many various full simulations (such as SHiP and LHCb simulation frameworks) and lightweight codes (ALPINIST, FORESEE). 

## Why Mathematica?

Evaluating sensitivities to LLPs is often much simpler than detailed event analysis or background evaluation. If computing the distributions of mother particles producing the LLPs externally, the sensitivity evaluation is split into relatively trivial computations, such as calculating the LLP distribution function and evaluating the acceptances for the LLP and its decay products. Mathematica is a great environment for such a task. Namely, everything from computing the matrix elements of the LLP production and decay to working with the geometry of the experiment may be made inside it. In addition, [Mathematica notebooks](https://www.wolfram.com/notebooks/) provide a convenient visual framework. Finally, there is a very friendly and experienced [Mathematica community](https://mathematica.stackexchange.com/) whose members may help with any question (and probably optimize the performance of SensCalc by another factor of ten).


Mathematica language does not suit well for performing some low-level routine operations such as producing the phase space of decays or propagating the particles through space. Fortunately, to improve this part, the Mathematica code may be simply [compiled](https://reference.wolfram.com/language/Compile/tutorial/Efficiency.html#9770950728) into a native machine code, which may improve the performance by a factor of a hundred and more. 


## How to launch

### Dependencies

To run SensCalc, two tools have to be installed: [FeynCalc](https://feyncalc.github.io/) and a C compiler. 

### Input

In short, you should provide: 

* The phenomenology of the given model (branching ratios of the production and decay channels; corresponding squared matrix elements (if the production/decay channel is 3-body and higher); tabulated LLP lifetime)
* The tabulated distributions of mother particles that may produce LLPs, 
* The experimental setup -- geometry and selection criteria for the LLP decay products. 

More details are given in *SensCalc_Manual.pdf*. 

### Code structure

SensCalc has a modular structure. The sensitivity calculation is performed with the help of four notebooks:

1. <dt><code>1. Acceptances.nb</code></dt>, which evaluates the tabulated geometric probabilities for the given LLP to decay inside decay volume and for its decay products to satisfy the decay acceptance criteria, such as crossing the detector and satisfying various cuts (energy, angular, impact parameter, etc.).

2. <dt><code>2. LLP distribution.nb</code></dt>, which evaluates the angle-energy distribution of LLPs at the facility housing the given experiment.

3. <dt><code>3. LLP sensitivity.nb</code></dt>, which calculates the tabulated number of events with decays of LLPs at the given experiment, and then the sensitivity based on the input (such as expected background and the number of proton collisions).

4. <dt><code>4. Plots.nb</code></dt>, which makes figures with the sensitivities.

5. <dt><code>EventCalc.nb</code>, which uses the output of LLP distribution.nb and the information about decays and samples events with LLPs a-la traditional Monte-Carlo approaches.


For the LLPs and experiments that are already implemented, the user just needs to launch the very first section located at the top of each notebook. The relevant sections will then be launched automatically, and the notebook will prompt the user to specify the required inputs via dialog windows. If, however, the user wants to modify the model, geometry, or assumptions, they may change the code and inputs as described in the following sections.


## (Currently) implemented list of facilities and LLPs

The following experiments that either have been proposed or are currently running are implemented:

* Serpukhov
  - NuCal
* Fermilab (beam dump facilities)
  - DUNE-ND-LAr, DUNE-PRISM, DarkQuest
* SPS
  - SHiP, SHADOWS, HIKE-dump, NA62-dump, CHARM, BEBC
* LHC
  - FACET, PREFACE, FASER, FASER2, FASER2-FPF, FASERν, FASERν2, SND@LHC, advSND<sub>near</sub>, advSND<sub>far</sub>, ANUBIS-shaft, ANUBIS-ceiling, MATHUSLA, CODEX-b, Downstream@LHCb, muon chambers@LHCb.
* FCC-hh 
  - MATHUSLA-FCC, FACET-FCC, FOREHUNT
* SLAC
  - E137

The following LLPs are implemented:

* Heavy Neutral Leptons (HNLs) with arbitrary mixing pattern
* Dark photons
* Mediators coupled to anomaly-free combinations of the baryon and lepton currents: U<sub>B-L</sub>(1), U<sub>B-3Lmu</sub>(1), U<sub>B-Le-3Lmu+Ltau</sub>(1), U<sub>B-3Le-Lmu+Ltau</sub>(1)
* Dark scalars with mixing and quartic couplings
* ALPs coupled to photons, fermions, or gluons
* Millicharged particles (only the production in the public version)
* Inelastic dark matter coupled via dipole portal


## To be added soon/exiting in private repository.

* New models to be included: HNL dipole portal, inelastic dark matter (decay and scattering signatures), elastic dark matter (scattering signatures).
* New facilities and experiments: ESS, MicroBooNE/MiniBooNE, MATHUSLA40.