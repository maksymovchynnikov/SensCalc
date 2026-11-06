Get[FileNameJoin[{DirectoryName[$InputFileName],"common.wl"}]];
load["codes/generic.nb",1];load["codes/kinematics.nb",1];load["codes/EventCalc/DecayProductsSampler.nb",2];
Scan[load["codes/experiments.nb",#]&,{3,36,38}];
GivenExperiment="CHARM-photon";
DetectorPlaneOrientationGivenExperiment=DetectorPlaneOrientationExperiment[GivenExperiment];
xLongMaxDetectorGivenExperiment=xLongMaxDetectorExperiment[GivenExperiment];
xLongMuonPlaneGivenExperiment=xLongMuonPlaneExperiment[GivenExperiment];
xLongNonMuonPlaneGivenExperiment=xLongNonMuonPlaneExperiment[GivenExperiment];
DecayVolumeAsDetectorGivenExperiment="False";
Bval=0.;zMagnetMinGivenExperiment=0.;zMagnetMaxGivenExperiment=0.;pointSecondCoordinate=2;
LLPdecVTXatGivenZx[z_,th_,ph_]=z Tan[th] Cos[ph];LLPdecVTXatGivenZy[z_,th_,ph_]=z Tan[th] Sin[ph];
DecayAcceptanceGeometry[x_,y_,z_]=IfLLPtoDet[x,y,z,GivenExperiment];
index\[Theta]LLP=1;indexELLP=2;indexzLLP=3;indexLLPazAcc=4;index\[Phi]LLP=5;
IfpTcuts=IfAngSepCuts=IfIPcuts=IfminvCuts=IfSScuts=0;
conditionEnergyCuts=Compile[{{id1,_Real},{q1,_Real},{id2,_Real},{e1,_Real},{e2,_Real}},Boole[e1+e2>0.],CompilationTarget->"C"];
Scan[load["codes/decay-acceptance.nb",#]&,{1,6,8}];
check["CHARM scalar geometric acceptance",conditionDecayAcceptanceGeometric[0.,22.,5.,0.,500.,0.,0.,10.,10.,0.]===1.];
check["CHARM geometric veto",conditionDecayAcceptanceGeometric[0.,22.,50.,0.,500.,0.,0.,10.,10.,0.]===0.];
fixtureGrid=N[{ArcTan[.01],100.,500.,1.,0.}];
Do[WhetherCuts=cuts;IfEcuts=cuts;load["codes/decay-acceptance.nb",19];
 Do[products=Table[N[{0,(-1)^j/n,0,1/n,0,22,0,1}],{j,n}];
 value=First[DecayAcceptanceCHARM\[Gamma]Comp[fixtureGrid,products,1.,{{1,n}}]];
 check["CHARM photon count "<>ToString[n]<>" cuts "<>ToString[cuts],value==If[n<=2,1.,0.],value],{n,1,4}];
 products={{0.,.5,0.,.5,0.,22.,0.,1.},{0.,-.5,0.,.5,0.,11.,-1.,1.}};
 value=First[DecayAcceptanceCHARM\[Gamma]Comp[fixtureGrid,products,1.,{{1,2}}]];
 check["CHARM charged-particle veto cuts "<>ToString[cuts],value==0.],{cuts,{0,1}}];
(* The unit-geometric-acceptance approximation must include backward tracks. *)
DecayVolumeAsDetectorGivenExperiment="True";load["codes/decay-acceptance.nb",8];
Do[value=conditionDecayAcceptanceGeometric[0.,22.,5.,0.,500.,.1,.2,pz,10.,0.];
 check["volume detector pz "<>ToString[pz],value==1.,value],{pz,{-10.,0.,10.}}];
DecayVolumeAsDetectorGivenExperiment="False";load["codes/decay-acceptance.nb",8];
check["ordinary detector still rejects backward tracks",conditionDecayAcceptanceGeometric[0.,22.,5.,0.,500.,0.,0.,-10.,10.,0.]===0.];
(* Only neutral-pair separation is projected to ECAL, not charged tracks. *)
ECALpositionGivenExperiment=550.;xLongNonMuonPlaneGivenExperiment=600.;xLongMuonPlaneGivenExperiment=650.;
SScutID[_,_]=0.;SScutZero=0.;load["codes/decay-acceptance.nb",13];
Do[{pdg,charge,plane}=triple;value=computingFinalCoordinates[charge,pdg,5.,0.,500.,.1,0.,10.,10.,0.];
 check["separation projection PDG "<>ToString[pdg],Max[Abs[value-{5.+.01*(plane-500.),0.}]]<10^-12,value],
 {triple,{{22.,0.,550.},{130.,0.,550.},{211.,1.,600.},{13.,-1.,650.}}}];
finish["geometry-results"];
