#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Title::Closed:: *)
(*Just launch the code below to run the notebook (shift+enter)*)


(* ::Input:: *)
(*ClearAll["Global`*"]*)
(*ParallelEvaluate[ClearAll["Global`*"]];*)
(*BlockEvaluation[tag_]:=Block[{},*)
(*nb=EvaluationNotebook[];*)
(*NotebookFind[nb,tag,All,CellTags];*)
(*SelectionEvaluate[nb]*)
(*]*)
(*CloseKernels[];*)
(*LaunchKernels[];*)
(*dropdownDialog[list_,phrase_]:=DialogInput[{choice=""},Column[{TextCell[phrase],PopupMenu[Dynamic[choice],list],Button["OK",DialogReturn[choice]]}]]*)
(*infoDialog[phrase_]:=DialogInput[{choice=""},Column[{TextCell[phrase],Button["Proceed",DialogReturn[choice]]}]]*)
(*If[(DirectoryQ[FileNameJoin[{NotebookDirectory[],"Auxiliary data"}]]//ToString)=="False",CreateDirectory[FileNameJoin[{NotebookDirectory[],"Auxiliary data"}]]];*)
(*choiceslist={"Tabulated Nevents+sensitivity","Sensitivity only (tabulated Nevents must be produced before)","Acceptance"};*)
(*taglist["Acceptance"]="Acceptance";*)
(*taglist["Tabulated Nevents+sensitivity"]="Number-of-events+sensitivity";*)
(*taglist["Sensitivity only (tabulated Nevents must be produced before)"]="Sensitivity";*)
(*computationchoice=dropdownDialog[choiceslist,"Do you want to compute the tabulated number of events and then sensitivity, or just sensitivity (if the tabulated number of events has been already produced)?"];*)
(*tagselected=taglist[computationchoice]*)
(*BlockEvaluation[tagselected]*)


(* ::Title::Closed:: *)
(*Definitions*)


(* ::Chapter::Closed:: *)
(*Various directories*)


(* ::Input:: *)
(*LLPdirName="DP";*)
(*(*Set the directory for the search where tabulated acceptances are located*)*)
(*directory["Acceptances"]=FileNameJoin[{NotebookDirectory[],"Acceptances"}];*)
(*(*Set the directory for the search where tabulated angle-energy distributions are located*)*)
(*directory["Distribution"]=FileNameJoin[{NotebookDirectory[],"spectra/New physics particles spectra",LLPdirName}]; *)
(*(*The directory storing production weights of the given LLP*)*)
(*directory["Production weights"]=FileNameJoin[{NotebookDirectory[],"phenomenology",LLPdirName,"Production probabilities"}]; *)
(*(*Directory to which various auxillary datasets will be stored*)*)
(*directory["Auxiliary"]=FileNameJoin[{NotebookDirectory[],"Auxiliary data",LLPdirName}]; *)
(*If[!DirectoryQ[directory["Auxiliary"]],CreateDirectory[directory["Auxiliary"]]];*)
(*(*Directory containing decay widths of the LLPs*)*)
(*directory["Decays"]=FileNameJoin[{NotebookDirectory[],"phenomenology",LLPdirName,"decay widths"}]; *)


(* ::Chapter::Closed:: *)
(*Parameters and critical definitions*)


(* ::Input:: *)
(*dropdownDialog[list_,phrase_]:=DialogInput[{choice=""},Column[{TextCell[phrase],PopupMenu[Dynamic[choice],list],Button["OK",DialogReturn[choice]]}]]*)
(*infoDialog[phrase_]:=DialogInput[{choice=""},Column[{TextCell[phrase],Button["Proceed",DialogReturn[choice]]}]]*)
(*selectionDialog[list_,phrase_]:=DialogInput[{choice={}},Column[{Row[{phrase}],Pane[TogglerBar[Dynamic[choice],list,Appearance->"Vertical"->{Automatic,5}],ImageSize->{Automatic,Automatic},Scrollbars->{False,True}],Button["OK",DialogReturn[choice]]}]]*)
(*(*Conversion units*)*)
(*GeVMinusOneTom=2*10^-16;*)
(*chbarval=3*10^8*6.58*10^-25;*)
(*(*EM coupling*)*)
(*\[Alpha]EM=1/137;*)
(*(*Mesons masses*)*)
(*{mSM["Rho0"],mSM["Pi0"],mSM["Eta"],mSM["EtaPr"],mSM["p"]}={0.775,0.135,0.547,0.958,0.939};*)
(*\[CapitalGamma]SM["\[Rho]780"]=0.149;*)
(*\[Sigma]pNucleonInpb[Atarget_]=51*Atarget^-0.29*10^9;*)


(* ::Chapter::Closed:: *)
(*LLP phenomenology: production probabilities, decay widths*)


(* ::Section::Closed:: *)
(*Production probabilities*)


(* ::Subsection::Closed:: *)
(*Via decays of mesons*)


(* ::Input:: *)
(*PmotherToLLP//Clear;*)
(*(*Production from decays of mesons and mixing with \[Rho]^0*)*)
(*Br\[Pi]To\[Gamma]\[Gamma]=0.98799;*)
(*Br\[Eta]To\[Gamma]\[Gamma]=0.3931181;*)
(*(*Br\[Omega]To\[Pi]\[Gamma]=0.0834941;*)*)
(*Br\[Eta]prTo\[Gamma]\[Gamma]=0.0219297;*)
(*Br\[Pi]0ToV[mLLP_]=If[mLLP<mSM["Pi0"],Evaluate[2*(1-mLLP^2/mSM["Pi0"]^2)^3*Br\[Pi]To\[Gamma]\[Gamma]],0];*)
(*Br\[Eta]ToV[mLLP_]=If[mLLP<mSM["Eta"],Evaluate[2*(1-mLLP^2/mSM["Eta"]^2)^3*Br\[Eta]To\[Gamma]\[Gamma]],0];*)
(*(*Br\[Omega]ToV[mLLP_]=If[mLLP<m\[Omega]-m\[Pi]0,Br\[Omega]To\[Pi]\[Gamma]*(m\[Omega]^2-mLLP^2-m\[Pi]0^2)^2*Sqrt[(m\[Omega]^2-mLLP^2+m\[Pi]0^2)^2-4*m\[Omega]^2*m\[Pi]0^2]/(m\[Omega]^2-mLLP^2)^3,0];*)*)
(*Br\[Eta]prToV[mLLP_]=If[mLLP<mSM["EtaPr"],Evaluate[2*(1-mLLP^2/mSM["EtaPr"]^2)^3*Br\[Eta]prTo\[Gamma]\[Gamma]],0];*)
(*{BrDecay[mLLP_,\[Epsilon]2_,"Pi0"],BrDecay[mLLP_,\[Epsilon]2_,"Eta"],BrDecay[mLLP_,\[Epsilon]2_,"EtaPr"]}=\[Epsilon]2*{Br\[Pi]0ToV[mLLP],Br\[Eta]ToV[mLLP],Br\[Eta]prToV[mLLP]};*)
(*FacilitiesList={"SPS","FermilabBD","LHC","FCC-hh","Serpukhov"};*)
(*Do[*)
(*PmotherToLLP[mLLP_,\[Epsilon]2_,part,Facility]=BrDecay[mLLP,\[Epsilon]2,part];*)
(*,{part,{"Pi0","Eta","EtaPr"}},{Facility,FacilitiesList}]*)


(* ::Subsection::Closed:: *)
(*Via Drell-Yan*)


(* ::Input:: *)
(*(*_____________________________*)*)
(*(*Production from Drell-Yan process*)*)
(*(*_____________________________*)*)
(*(*Average enhancement LO vs LO+NLO obtained for SPS energies in 2011.05115*)*)
(*kfactorNLO=1.7;*)
(*\[Sigma]DrellYanData[Facility_]:=Block[{},*)
(*dat=Import[FileNameJoin[{directory["Production weights"],"sigmaDrellYan_DP_"<>Facility<>".txt"}],"Table"];*)
(*MinMaxMassesDrellYan[Facility]={Min[dat[[All,1]]],Max[dat[[All,1]]]};*)
(*int[ma_]=If[MinMaxMassesDrellYan[Facility][[1]]<= ma<=MinMaxMassesDrellYan[Facility][[2]],Evaluate[10^(Interpolation[{Log10[#[[1]]],Log10[#[[2]]+10^-90]}&/@dat,InterpolationOrder->1][Log10[ma]])],0];*)
(*PmotherToLLP[mLLP_,\[Epsilon]2_,"DrellYan",Facility]=If[Facility=="SPS",kfactorNLO,1]*\[Epsilon]2*int[mLLP]/\[Sigma]pNucleonInpb[Atarget]*)
(*]*)
(*Do[\[Sigma]DrellYanData[Facility],{Facility,{"SPS","FermilabBD","LHC"}}]*)


(* ::Subsection::Closed:: *)
(*Via bremsstrahlung*)


(* ::Input:: *)
(**)
(*(*________________*)*)
(*(*Bremsstrahlung*)*)
(*(*________________*)*)
(*BremProd[Facility_]:=Module[{},*)
(*bremprobfiles=FileNames["Pbrem*_"<>Facility<>".m",directory["Production weights"]];*)
(*If[bremprobfiles!={},*)
(*(*Scanning over all available files with the bremsstrahlung probability. They describe different descriptions of the bremsstrahlung*)*)
(*(*Extract the bremsstrahlung description from the filename*)*)
(*bremprobfilenames=Last@FileNameSplit[#]&/@bremprobfiles;*)
(*bremdescription=("Bremsstrahlung-"<>(StringSplit[#,{"Pbrem_"<>LLPdirName<>"_","_"}][[1]])&/@bremprobfilenames);*)
(*Do[*)
(*datbrem[mLLP_,\[Theta]LLP_]=Import[bremprobfiles[[i]],"MX"];*)
(*If[StringContainsQ[bremdescription[[i]],"Baseline"],*)
(*PmotherToLLP[mLLP_,\[Epsilon]2_,bremdescription[[i]],Facility]=datbrem[mLLP,\[Theta]LLP][[1]]*\[Epsilon]2;*)
(*ELLPmin[bremdescription[[i]],Facility]=Evaluate[datbrem[mLLP,\[Theta]LLP][[2]]];*)
(*\[Theta]maxBrem[bremdescription[[i]],Facility]=Evaluate[datbrem[mLLP,\[Theta]LLP][[3]]];*)
(*ELLPmax[mLLP_,\[Theta]LLP_,bremdescription[[i]],Facility]=Evaluate[datbrem[mLLP,\[Theta]LLP][[4]]];*)
(*,*)
(*Do[*)
(*PmotherToLLP[mLLP_,\[Epsilon]2_,bremdescription[[i]]<>"-"<>datbrem[mLLP,\[Theta]LLP][[j]][[1]],Facility]=datbrem[mLLP,\[Theta]LLP][[j]][[2]]*\[Epsilon]2;*)
(*ELLPmin[bremdescription[[i]]<>"-"<>datbrem[mLLP,\[Theta]LLP][[j]][[1]],Facility]=Evaluate[datbrem[mLLP,\[Theta]LLP][[j]][[3]]];*)
(*\[Theta]maxBrem[bremdescription[[i]]<>"-"<>datbrem[mLLP,\[Theta]LLP][[j]][[1]],Facility]=Evaluate[datbrem[mLLP,\[Theta]LLP][[j]][[4]]];*)
(*ELLPmax[mLLP_,\[Theta]LLP_,bremdescription[[i]]<>"-"<>datbrem[mLLP,\[Theta]LLP][[j]][[1]],Facility]=Evaluate[datbrem[mLLP,\[Theta]LLP][[j]][[5]]];*)
(*,{j,1,Length[datbrem[mLLP,\[Theta]LLP]],1}]*)
(*]*)
(*,{i,1,Length[bremdescription],1}]*)
(*]*)
(*]*)
(*Do[*)
(*BremProd[Facility],{Facility,{"FCC-hh","Serpukhov","SPS","FermilabBD","LHC"}}]*)
(**)


(* ::Subsection::Closed:: *)
(*Via mixing*)


(* ::Input:: *)
(*YieldsMixing[mLLP_]=Import[FileNameJoin[{directory["Production weights"],"Yield-Mixing_DP.mx"}],"MX"];*)
(*(*Old description a-la 2201.05170*)*)
(*(*Mixing angle \[Rho]^0-DP. Following https://arxiv.org/pdf/1810.01879.pdf*)*)
(*g\[Rho]0=5;*)
(*\[Theta]DP\[Rho]02[mLLP_,\[Epsilon]2_]=\[Epsilon]2*(4Pi*\[Alpha]EM)/g\[Rho]0^2 mSM["Rho0"]^4/((mLLP^2-mSM["Rho0"]^2)^2+\[CapitalGamma]SM["\[Rho]780"]^2*mSM["Rho0"]^2);*)
(*Print["Description of the production via mixing"]*)
(*SelectedMixingChoice=dropdownDialog[{"Revised","Old (2201.05170)"},"Select the description of the DP production via mixing with vector mesons:"]*)
(*If[SelectedMixingChoice=="Revised",*)
(*Do[*)
(*PmotherToLLP[mLLP_,\[Epsilon]2_,"Mixing",YieldsMixing[mLLP][[i]][[1]]]=\[Epsilon]2*YieldsMixing[mLLP][[i]][[2]]*)
(*,{i,1,Length[YieldsMixing[mLLP]],1}];*)
(*,*)
(*Do[*)
(*PmotherToLLP[mLLP_,\[Epsilon]2_,"Mixing-Old",facility]=Yield\[Rho]0*\[Theta]DP\[Rho]02[mLLP,\[Epsilon]2]*)
(*,{facility,{"SPS","Serpukhov","FermilabBD","LHC","FCC-hh"}}];*)
(*]*)
(*WeightsCombinations=Keys[DownValues@PmotherToLLP][[All,1,#]]&/@{3,4}//Transpose//Sort;*)


(* ::Section::Closed:: *)
(*Scanning for tabulated distributions*)


(* ::Input:: *)
(*(*Define the file pattern*)*)
(*pattern="DoubleDistr_*_*_*.m";*)
(*(*Search for files matching the pattern in the directory and its subdirectories*)*)
(*matchingFiles=FileNames[pattern,{directory["Distribution"]},Infinity];*)
(*(*List of LLPs, production modes, and facilities for which the tabulated distributions have been computed at the previous stage of using SensCalc*)*)
(*ExtractedProductionParameters=Function[filename,parts=StringSplit[FileNameTake[filename],"_"];*)
(*{parts[[2]],parts[[3]],StringDrop[parts[[4]],-2]} ];*)
(*(*combinations selected LLP, production channel, facility for which the tabulated distributions are present*)*)
(*DistrCombinations=(ExtractedProductionParameters/@matchingFiles)//Sort;*)
(*If[SelectedMixingChoice=="Revised",*)
(*DistrCombinations=Select[DistrCombinations,#[[2]]!="Mixing-Old"&]*)
(*,*)
(*DistrCombinations=Select[DistrCombinations,#[[2]]!="Mixing"&]*)
(*];*)
(*If[MemberQ[DistrCombinations[[All,2]],"Bremsstrahlung-FR"]||MemberQ[DistrCombinations[[All,2]],"Bremsstrahlung-AP"],*)
(*FacilitiesFR=Select[DistrCombinations,StringContainsQ[#[[2]],{"FR"}]&][[All,3]];*)
(*FacilitiesAP=Select[DistrCombinations,StringContainsQ[#[[2]],{"AP"}]&][[All,3]];*)
(*DistrCombinationsToCheck=Select[DistrCombinations,!StringContainsQ[#[[2]],{"FR","AP"}]&];*)
(*DistrCombinationsToCheck=Join[DistrCombinationsToCheck,Flatten[Table[{LLPdirName,brem,fac},{fac,FacilitiesFR},{brem,Select[WeightsCombinations,#[[2]]==fac&&StringContainsQ[#[[1]],"FR"]&][[All,1]]}],1],Flatten[Table[{LLPdirName,brem,fac},{fac,FacilitiesAP},{brem,Select[WeightsCombinations,#[[2]]==fac&&StringContainsQ[#[[1]],"AP"]&][[All,1]]}],1]]//Sort;*)
(*,*)
(*DistrCombinationsToCheck=DistrCombinations*)
(*];*)
(*IfCondDistrToWeights=True;*)
(*Do[*)
(*IfCondDistrToWeights=Select[WeightsCombinations,#[[1]]==DistrCombinationsToCheck[[i]][[2]]&&#[[2]]==DistrCombinationsToCheck[[i]][[3]]&]!={};*)
(*If[IfCondDistrToWeights==False,Break[]];*)
(*,{i,1,Length[DistrCombinationsToCheck],1}]*)
(*IfCondDistrToWeights*)
(*If[!IfCondDistrToWeights,infoDialog["You have not provided the production probabilities PmotherToLLP to all the generated tabulated distributions! Please do this first to avoid problems"];]*)


(* ::Section::Closed:: *)
(*Decays*)


(* ::Input:: *)
(*(*Decay width in GeV*)*)
(*\[CapitalGamma]LLP[mLLP_,\[Epsilon]2_]=\[Epsilon]2*10^(Interpolation[{Log10[#[[1]]],Log10[#[[2]]]}&/@Import[FileNameJoin[{directory["Decays"],"GammaDarkPhoton.txt"}],"Table"],InterpolationOrder->1][Log10[mLLP]]);*)
(*(*Decay length*)*)
(*c\[Tau]LLP[mLLP_,\[Epsilon]2_]=chbarval/\[CapitalGamma]LLP[mLLP,\[Epsilon]2];*)
(*ldecayLLP[mLLP_,\[Epsilon]2_,ELLP_]=c\[Tau]LLP[mLLP,\[Epsilon]2]*Sqrt[ELLP^2-mLLP^2]/mLLP;*)
(*\[Epsilon]2val=10^-14;*)
(*LogLogPlot[Evaluate[c\[Tau]LLP[mLLP,10^-14]],{mLLP,0.05,4},Frame->True,ImageSize->Large, FrameStyle->Directive[Black, 22],PlotRange->{{0.05,4},All},PlotStyle->{{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick,Brown}},AspectRatio->0.66,ImageSize->Large,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(V\)]\) [GeV]","\!\(\*SubscriptBox[\(c\[Tau]\), \(V\)]\) [m]"},PlotLabel->Style[Row[{"Proper lifetime of dark photon. \!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\) = ",N[\[Epsilon]2val]}],18,Black]]*)
(**)


(* ::Chapter::Closed:: *)
(*Loading necessary routines*)


(* ::Input:: *)
(*If[Length[inecessary]==0,*)
(*NotebookEvaluate[FileNameJoin[{NotebookDirectory[],"codes/generic.nb"}]];*)
(*NotebookEvaluate[FileNameJoin[{NotebookDirectory[],"codes/for-sensitivities.nb"}]];*)
(*inecessary={1,2,3};*)
(*]*)


(* ::Title::Closed:: *)
(*Specifying the experiment and run next sections*)


(* ::Chapter::Closed:: *)
(*Specifying the experiment*)


(* ::Input:: *)
(*SetDirectory[NotebookDirectory[]];*)
(*(*Parent directory*)*)
(*NotebookDirectory[]//ParentDirectory;*)
(*ExperimentDirectoriesList=Select[FileNames["*",directory["Acceptances"],1],DirectoryQ];*)
(*(*List of available experiments (for which the geometry has been implemented)*)*)
(*ExperimentsListTemp=Table[FileNameTake[ExperimentDirectoriesList[[i]],-1],{i,1,Length[ExperimentDirectoriesList],1}];*)
(*ExperimentsListTemp2=Join[Partition[ExperimentsListTemp,1],Table[{TrueQ@FileExistsQ@FileNameJoin[{directory["Acceptances"],ExperimentsListTemp[[i]],ToString@StringForm["Acceptance_``_for_``.m",Sequence@@{ExperimentsListTemp[[i]],LLPdirName}]}]},{i,1,Length[ExperimentsListTemp]}],2];*)
(*ExperimentsList=Select[ExperimentsListTemp2,#[[2]]==True&][[All,1]]//Sort*)
(*If[Length[ExperimentsList]==0,Print["No experiment is available, generate first the acceptance for the given experiment using module 1"]]*)
(*Print["Selected experiments:"]*)
(*SelectedExperimentList=If[Length[ExperimentsList]!=0,selectionDialog[ExperimentsList,"Select the experiments:"]]*)
(*icounter=1;*)


(* ::Chapter::Closed:: *)
(*Running block for next sections*)


(* ::Input:: *)
(*BlockEvaluation[tag_]:=Block[{},*)
(*nb=EvaluationNotebook[];*)
(*NotebookFind[nb,tag,All,CellTags];*)
(*SelectionEvaluate[nb]*)
(*]*)
(*If[tagselected=="Number-of-events+sensitivity",*)
(*Do[*)
(*BlockEvaluation["Number-of-events-computation+sensitivity"];*)
(*,{icounter,1,Length[SelectedExperimentList],1}],*)
(*If[tagselected=="Acceptance",*)
(*Do[*)
(*BlockEvaluation["Acceptance-computation"];*)
(*,{icounter,1,Length[SelectedExperimentList],1}]*)
(*]*)
(*]*)


(* ::Title::Closed:: *)
(*Number of events*)


(* ::Chapter::Closed:: *)
(*Particular experiment*)


(* ::Input:: *)
(*SelectedExperiment=SelectedExperimentList[[icounter++]];*)
(*Print[Row[{"Experiment ",icounter-1,"/",Length[SelectedExperimentList]}]];*)


(* ::Chapter::Closed:: *)
(*Cross-sections, acceptances*)


(* ::Input:: *)
(*dataAcceptances=Import[FileNameJoin[{FileNameJoin[{directory["Acceptances"],SelectedExperiment,ToString@StringForm["Acceptance_``_for_``.m",Sequence@@{SelectedExperiment,LLPdirName}]}]}],"MX"];//AbsoluteTiming*)
(*{FacilityGivenExperiment,FullAcceptanceData0,BrVis[mLLP_]}=dataAcceptances[[#]]&/@{1,3,5};*)
(*Print["Total branching ratio of visible decays (computed by notebook 1):"]*)
(*LogLogPlot[Evaluate[BrVis[mLLP]],{mLLP,0.02,10},Frame->True,ImageSize->Large,FrameStyle->Directive[Black, 22],PlotStyle->{{Thickness[0.003],Blue},{Thickness[0.003],Darker@Red},{Thickness[0.003],Darker@Darker@Green},{Thickness[0.003],Black}},GridLines->Automatic,PlotRange->{{0.1,10},{0.01,1.2}},Frame->True,ImageSize->Large,FrameLabel->{"m [GeV]","\!\(\*SubscriptBox[\(Br\), \(vis\)]\)"},PlotLabel-> Style[Row[{"For ",SelectedExperiment}], 20, Black]]*)
(*(*___________________________*)*)
(*(*Interpolation of the tabulated azimuthal acceptance, extracting Subscript[\[Theta], min/max], etc.*)*)
(*(*___________________________*)*)
(*{AzimuthalAcceptanceInt[\[Theta]LLP_,zLLP_],\[Theta]minExpAll,\[Theta]maxExpAll,\[Theta]minExp,\[Theta]maxExp,zminExp,zmaxExp,zmin\[Theta][\[Theta]LLP_],zmax\[Theta][\[Theta]LLP_]}=Block\[Epsilon]Azimuthal[FullAcceptanceData0];*)
(*(*Logarithmized data with full acceptance, and also decay acceptance and full acceptance interpolations*)*)
(*{FullAcceptanceData,DecayAcceptanceInt[mLLP_,\[Theta]LLP_,ELLP_,zLLP_],FullAcceptanceInt[mLLP_,\[Theta]LLP_,ELLP_,zLLP_],InGridm\[Epsilon],InGrid\[Theta]\[Epsilon],InGridE\[Epsilon],InGridz\[Epsilon],\[Epsilon]vals,\[Epsilon]azvals,mmin\[Epsilon],mmax\[Epsilon]}=Block\[Epsilon]Decay[FullAcceptanceData0,zminExp,BrVis];*)
(*CrossSectionData=dataAcceptances[[4]]//Transpose;*)
(*listquantities=((#//ToString)&/@{Npot,PPi0,PEta,PEtapr,PRho0,Atarget});*)
(*quantityselector[quantity_]:=Select[CrossSectionData,#[[1]]==quantity&][[1]][[2]]//N;*)
(*{NpotGivenExperiment,ProbMother["Pi0"],ProbMother["Eta"],ProbMother["EtaPr"],ProbMother["Rho0"],AtargetVal}=Table[quantityselector[quantity],{quantity,listquantities}];*)
(*(*infoDialog[Row[{"The number of proton collisions is ", NpotGivenExperiment,". You may change it at the stage of computing the sensitivities"}]]*)*)
(*Row[{"Search for "<>LLPdirName<>" at ", SelectedExperiment, " located at ",FacilityGivenExperiment,". \!\(\*SubscriptBox[\(N\), \(collisions\)]\) = ",NpotGivenExperiment}]*)
(*{{"Quantity","\!\(\*SubscriptBox[\(\[Theta]\), \(min\)]\), rad","\!\(\*SubscriptBox[\(\[Theta]\), \(max\)]\), rad","\!\(\*SubscriptBox[\(\[Theta]\), \(min\)]\)(\!\(\*SubscriptBox[\(\[Epsilon]\), \(dec\)]\)), rad","\!\(\*SubscriptBox[\(\[Theta]\), \(max\)]\)(\!\(\*SubscriptBox[\(\[Epsilon]\), \(dec\)]\)), rad","\!\(\*SubscriptBox[\(z\), \(min\)]\), m","\!\(\*SubscriptBox[\(z\), \(max\)]\), m"},{"Description","Min angle covered by experiment","Max angle covered by experiment","Min angle where \!\(\*SubscriptBox[\(\[Epsilon]\), \(decay\)]\)\[NotEqual]0","Max angle where \!\(\*SubscriptBox[\(\[Epsilon]\), \(decay\)]\)\[NotEqual]0","Min long. displacement of the decay volume","Max long. displacement of the decay volume"},{"Value",\[Theta]minExpAll,\[Theta]maxExpAll,\[Theta]minExp,\[Theta]maxExp,zminExp,zmaxExp}}//TableForm*)


(* ::Chapter::Closed:: *)
(*Angle-energy distributions and differential yields  for the given experiment*)


(* ::Section::Closed:: *)
(*Importing and definitions*)


(* ::Subsection::Closed:: *)
(*Specifying production channels*)


(* ::Input:: *)
(*(*List of production channels for the selected facility*)*)
(*ProductionPatternSelectedDistr=Select[DistrCombinations,#[[3]]==FacilityGivenExperiment&];*)
(*ProductionPatternSelected=Select[DistrCombinationsToCheck,#[[3]]==FacilityGivenExperiment&];*)
(*ProductionListTemp=ProductionPatternSelected[[All,2]]//DeleteDuplicates;*)
(*(*Selecting only those bremsstrahlung channels for which the distribution is non-zero*)*)
(*BremVariantsGivenFacility=Select[WeightsCombinations[[All,{1,2}]],#[[2]]==FacilityGivenExperiment&&StringContainsQ[#[[1]],"Bremsstrahlung"]&][[All,1]];*)
(*Do[*)
(*ProbMother[channel]=1;*)
(*,{channel,Join[{"DrellYan"},BremVariantsGivenFacility,{"Mixing","Mixing-Old"}]}]*)
(*Print["Production list:"]*)
(*(*Deciding if the bremsstrahlung contributes to the production by comparing Subscript[\[Theta], max,brem] with Subscript[\[Theta], min,experiment]*)*)
(*Do[*)
(*ELLPmax[mLLP_,\[Theta]LLP_,ch]=ELLPmax[mLLP,\[Theta]LLP,ch,FacilityGivenExperiment];*)
(*ELLPmin[ch]=ELLPmin[ch,FacilityGivenExperiment];*)
(*\[Theta]maxBrem[ch]=\[Theta]maxBrem[ch,FacilityGivenExperiment]*)
(*,{ch,BremVariantsGivenFacility}]*)
(*ProdListBrem=Select[ProductionListTemp,StringContainsQ[#,"Bremsstrahlung"]&];*)
(*(*ProdListBremSelected=Select[ProdListBrem,\[Theta]maxBrem[#]>\[Theta]minExp&];*)*)
(*ProdListBremSelected=ProdListBrem;*)
(*ProductionList=Join[ProdListBremSelected,Select[ProductionListTemp,!StringContainsQ[#,"Bremsstrahlung"]&]]*)
(*(*Production list with only baseline bremsstrahlung description*)*)
(*BremSelected="Bremsstrahlung-FR-Central";*)
(*ProductionListBaseline=Select[ProductionList,!StringContainsQ[#,"Bremsstrahlung"]||#==BremSelected&];*)
(*Do[*)
(*If[!MemberQ[ProductionList,_String?(StringContainsQ[#,pattern]&)],*)
(*ProductionPatternSelectedDistr=Select[ProductionPatternSelectedDistr,!StringContainsQ[#[[2]],pattern]&]*)
(*];*)
(*,{pattern,{"AP","Fouroghi-Ritz","Baseline"}}]*)
(*BremVariantsGivenFacility=Select[ProductionList,StringContainsQ[#,"Bremsstrahlung"]&];*)


(* ::Subsection::Closed:: *)
(*Importing distributions*)


(* ::Input:: *)
(*Do[*)
(*Module[{prod,prodbrem},*)
(*prod=ProductionPatternSelectedDistr[[i]][[2]];*)
(*dirimp=If[StringContainsQ[prod,{"DrellYan","Mixing"}]&&!StringContainsQ[prod,"Mixing-Old"],FileNameJoin[{directory["Distribution"],"Pregenerated"}],directory["Distribution"]];*)
(*(*Importing the data with distribution*)*)
(*If[!StringContainsQ[prod,{"AP","FR"}],*)
(*DistrDataImport[prod]=Abs[Import[FileNameJoin[{dirimp,"DoubleDistr_"<>LLPdirName<>"_"<>prod<>"_"<>FacilityGivenExperiment<>".m"}],"MX"]];*)
(*If[prod=="DrellYan",*)
(*DistrDataImport[prod]=Select[DistrDataImport[prod],MinMaxMassesDrellYan[FacilityGivenExperiment][[1]]<=#[[1]]<=MinMaxMassesDrellYan[FacilityGivenExperiment][[2]]&];*)
(*];*)
(*,*)
(*(*If the selected channel is Bremsstrahlung under the description of AP or FR, then there are variants for the description parametrizing the theoretical uncertainty*)*)
(*DistrDataImportTemp[prod]=Import[FileNameJoin[{dirimp,"DoubleDistr_"<>LLPdirName<>"_"<>prod<>"_"<>FacilityGivenExperiment<>".m"}],"MX"];*)
(*Do[*)
(*prodbrem=prod<>"-"<>DistrDataImportTemp[prod][[j]][[1]];*)
(*DistrDataImport[prodbrem]=DistrDataImportTemp[prod][[j]][[2]];*)
(*mlistDistr[prodbrem]=DeleteDuplicates[DistrDataImport[prodbrem][[All,1]]];*)
(*{mLLPmin[prodbrem],mLLPmax[prodbrem]}=MinMax[mlistDistr[prodbrem]];*)
(*,{j,1,Length[DistrDataImportTemp[prod]],1}];*)
(*];*)
(*]*)
(*,{i,1,Length[ProductionPatternSelectedDistr],1}]*)
(*Do[*)
(*Module[{},*)
(*mlistDistr[prod]=DeleteDuplicates[DistrDataImport[prod][[All,1]]];*)
(*{mLLPmin[prod],mLLPmax[prod]}=MinMax[mlistDistr[prod]];*)
(*DoubleDistrLLPint[mLLP_,\[Theta]LLP_,ELLP_,prod]=10^(Interpolation[distrlogComp[DistrDataImport[prod]],InterpolationOrder->1][Log10[mLLP],Log10[\[Theta]LLP],Log10[ELLP]]);*)
(*If[StringContainsQ[prod,"Bremsstrahlung"],*)
(*DoubleDistrLLPint[mLLP_,\[Theta]LLP_,ELLP_,prod]=If[ELLP<=ELLPmax[mLLP,\[Theta]LLP,prod],Evaluate[DoubleDistrLLPint[mLLP,\[Theta]LLP,ELLP,prod]],0.]];*)
(*(*Probability to produce LLP*)*)
(*ProbLLP[mLLP_,finv_,prod]=ProbMother[prod]*PmotherToLLP[mLLP,finv,prod,FacilityGivenExperiment]/.{Atarget->AtargetVal,Yield\[Rho]0->ProbMother["Rho0"]};*)
(*]*)
(*,{prod,ProductionList}]*)
(*Do[{GridInFinal[prod],DistrVals[prod]}=BlockGridsValsDistr[prod,DistrDataImport],{prod,ProductionList}];//AbsoluteTiming*)
(*(*____________________________*)*)
(*(*Finding Subscript[E, max](Subscript[m, LLP],Subscript[\[Theta], LLP]) for the angular range at the given experiment*)*)
(*(*____________________________*)*)
(*Do[ELLPmax[mfip_,\[Theta]fip_,prod]=EmaxBlock[prod,8,DistrDataImport,FacilityGivenExperiment],{prod,Select[ProductionList,!StringContainsQ[#,"Bremsstrahlung"]&]}]//AbsoluteTiming*)


(* ::Subsection::Closed:: *)
(*Exporting averaged distribution*)


(* ::Input:: *)
(*directory["Auxiliary-experiment"]=FileNameJoin[{directory["Auxiliary"],SelectedExperiment}];*)
(*If[!DirectoryQ[directory["Auxiliary-experiment"]],CreateDirectory[directory["Auxiliary-experiment"]]];*)
(*Export[FileNameJoin[{directory["Auxiliary-experiment"],"Double-Distr-Averaged-"<>LLPdirName<>".m"}],{Sum[If[mLLPmin[prod]<mLLP<mLLPmax[prod],Evaluate[ProbLLP[mLLP,1,prod]],0],{prod,ProductionList}],(1/Sum[If[mLLPmin[prod]<mLLP<mLLPmax[prod],Evaluate[ProbLLP[mLLP,1,prod]],0],{prod,ProductionList}])Sum[If[mLLPmin[prod]<mLLP<mLLPmax[prod],Evaluate[ProbLLP[mLLP,1,prod]*DoubleDistrLLPint[mLLP,\[Theta]LLP,ELLP,prod]],0],{prod,ProductionListBaseline}]},"MX"];*)


(* ::Section::Closed:: *)
(*Plots*)


(* ::Input:: *)
(*ptenergies=LogLogPlot[Evaluate[Table[ELLPmax[0.1,\[Theta]LLP,prod],{prod,ProductionListBaseline}]],{\[Theta]LLP,\[Theta]minExp,\[Theta]maxExp},Frame->True,ImageSize->Large,PlotLegends->Placed[Style[#,15]&/@ProductionListBaseline,Right]];*)
(*ptprodprob=With[{prl=(ProductionListBaseline/.{"Bremsstrahlung-FR-Central"->"Bremsstrahlung"}//Sort)},LogLogPlot[Evaluate[Table[ProbLLP[ma,1,prod],{prod,Sort[ProductionListBaseline]}]],{ma,mmin\[Epsilon],mmax\[Epsilon]},Frame->True,ImageSize->Large,PlotLegends->Placed[Style[#,16]&/@prl,{0.2,0.28}], FrameStyle->Directive[Black, 25],PlotRange->{{0.02,3},{10^-8,100}},PlotStyle->{{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick,Brown}},AspectRatio->0.66,ImageSize->Large,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(LLP\)]\) [GeV]","\!\(\*SubscriptBox[\(P\), \(prod\)]\)/\!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\)"},PlotLabel->Style[Row[{"Production probabilities of ",LLPdirName," at ",FacilityGivenExperiment}],18,Black]]];*)
(*ptprodprobbrem=With[{prl=Select[BremVariantsGivenFacility,#!="Bremsstrahlung-FR-Central"&]},LogLogPlot[Evaluate[Table[ProbLLP[ma,1,prod],{prod,prl}]],{ma,mmin\[Epsilon],mmax\[Epsilon]},Frame->True,ImageSize->Large,FrameStyle->Directive[Black, 25],PlotRange->{{0.02,2},{10^-8,1000}},PlotStyle->{{Thick,Blue,Dashing[0.01]},{Thick,Lighter@Lighter@Blue},{Thick,Lighter@Lighter@Blue},{Thick,Darker@Cyan},{Thick,Magenta},{Thick,Brown}},AspectRatio->0.66,ImageSize->Large,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(LLP\)]\) [GeV]","\!\(\*SubscriptBox[\(P\), \(prod\)]\)/\!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\)"},PlotLabel->Style[Row[{"Production probabilities of ",LLPdirName," at ",FacilityGivenExperiment}],18,Black],Filling->{2->{{3},Directive[Lighter@Blue,Opacity[0.1]]}}]];*)
(*Style[Row[{ptenergies,Show[ptprodprob,ptprodprobbrem]}],ImageSizeMultipliers->{1, 1,1}]*)


(* ::Chapter::Closed:: *)
(*Number of events*)


(* ::Section::Closed:: *)
(*Number of events - using the mapping method *)


(* ::Subsection::Closed:: *)
(*Initializing all routines*)


(* ::Input:: *)
(*Do[{OutGrid\[Theta]final[prod],\[CapitalDelta]\[Theta]vals[prod]}=OutGrid\[Theta]Temp[InGrid\[Theta]\[Epsilon],30,prod,\[Theta]maxBrem[prod]],{prod,ProductionList}]*)
(*{OutGridzfinal,\[CapitalDelta]zvals}=OutGridszTemp[InGridz\[Epsilon],30,zminExp];*)
(*(*Final energy grid. Mass- and production channel-dependent*)*)
(*If[FacilityGivenExperiment!="ESS",*)
(*StepEtemp[Efip_]=Piecewise[{{0.3,Efip<=2.5},{0.5,2.5<Efip<35},{2,35<=Efip<=50},{4,50<Efip<160},{5,160<=Efip<=400},{25,400<Efip<600},{50,600<=Efip<2000},{200,2000<=Efip<4000},{400,4000<=Efip<7000},{500,7000<=Efip<=50000}}];*)
(*OutGridEnergy[m_,ProdChannel_]:=Block[{},*)
(*emin=If[!StringContainsQ[ProdChannel,"Bremsstrahlung"],N[m],ELLPmin[ProdChannel]];*)
(*egridtemp=With[{start=emin,end=ELLPmax[m,\[Theta]minExp,ProdChannel]},*)
(*Log10[NestWhileList[#+StepEtemp[#]&,start,#<=end&,1,\[Infinity],-1]]]//N;*)
(*If[Length[egridtemp]==1,egridtemp=Join[egridtemp,{Log10[2*emin]}]];*)
(*egridtemp*)
(*]*)
(*,*)
(*StepEtemp[Efip_]=0.001;*)
(*OutGridEnergy[m_,ProdChannel_]:=Block[{},*)
(*tabt=Table[e,{e,1.0001m,ELLPmax[m,\[Theta]minExp,ProdChannel],0.001}];*)
(*If[Length[tabt]==1,tabt=Join[tabt,{ELLPmax[m,\[Theta]minExp,ProdChannel]}]//Sort//DeleteDuplicates];*)
(*Log10[tabt]//N*)
(*]*)
(*]*)
(*(*____________________________________________________*)*)
(*(*Block that computes the grid Subscript[\[Theta], S],Subscript[E, S],Subscript[z, S], Subscript[\[Epsilon], Full]\[Times]Subscript[f, Subscript[\[Theta], S],Subscript[E, S]]*)*)
(*(*____________________________________________________*)*)
(*(*The block which sets all the values of Subscript[\[Epsilon], Full]\[Times]Subscript[f, \[Theta],E] for which E < Subscript[E, max] to zero, for Bremsstrahlung*)*)
(*createCompiledFunctionBrem[BremChoice_]:=Module[{func},*)
(*func[mfip_,th_]=ELLPmax[mfip,th,BremChoice];*)
(*Hold@Compile[{{angleenergy,_Real,1},{mfip,_Real}},Module[{angles,energies,distrvals,d},*)
(*angles=Compile`GetElement[angleenergy,1];*)
(*energies=Compile`GetElement[angleenergy,2];*)
(*distrvals=Compile`GetElement[angleenergy,3];*)
(*d=If[energies<func[mfip,angles],distrvals,10^-90.];*)
(*d],CompilationTarget->"C",RuntimeOptions->"Speed",RuntimeAttributes->{Listable},Parallelization->True]/. DownValues@func//ReleaseHold*)
(*];*)
(*(*Generate a dictionary of compiled functions for each variant*)compiledBremCutter=AssociationThread[BremVariantsGivenFacility,createCompiledFunctionBrem/@BremVariantsGivenFacility];*)
(*BremCut[OutGrid\[Theta]final_,OutGridEfinal_,distr_,mLLP_,bremChoice_]:=Block[{},*)
(*angleenergy=Join[10^Tuples[{OutGrid\[Theta]final,OutGridEfinal}],Partition[distr,1],2];*)
(*compiledFunc=compiledBremCutter[bremChoice];*)
(*compiledFunc[angleenergy,mLLP]*)
(*];*)
(*TableIntegrandDiscret[m_,ProdChannel_,\[Epsilon]DecOp_]:=TableIntegrandDiscretTemp[m,ProdChannel,\[Epsilon]DecOp,\[Epsilon]vals,\[Epsilon]azvals,OutGrid\[Theta]final[ProdChannel],OutGridzfinal,OutGridEnergy,InGridm\[Epsilon],InGrid\[Theta]\[Epsilon],InGridE\[Epsilon],InGridz\[Epsilon],\[CapitalDelta]\[Theta]vals[ProdChannel],\[CapitalDelta]zvals,zminExp,GridInFinal,DistrVals,FacilityGivenExperiment,ELLPmax,\[Theta]minExp]*)


(* ::Subsection::Closed:: *)
(*Generalized acceptances*)


(* ::Subsubsection::Closed:: *)
(*Definitions*)


(* ::Input:: *)
(*(*Tabulated acceptance*)*)
(*FactorANUBISceiling=If[SelectedExperiment=="ANUBIS-ceiling",2,1];*)
(*AcceptanceDiscret[m_,ProdChannel_,\[Epsilon]decOp_,decProb_]:=AcceptanceDiscretTemp[m,ProdChannel,\[Epsilon]decOp,decProb,mLLPmin,mmin\[Epsilon],mLLPmax,mmax\[Epsilon],ELLPmax,\[Theta]minExp,TableIntegrandDiscret,BrVis,zmaxExp,zminExp,FactorANUBISceiling,0.]*)
(*Do[mlistAcceptance[prod]=Join[Table[m,{m,1.01Max[mLLPmin[prod],mmin\[Epsilon]],0.95Min[mLLPmax[prod],mmax\[Epsilon]],Min[(0.95Min[mLLPmax[prod],mmax\[Epsilon]]-1.01Max[mLLPmin[prod],mmin\[Epsilon]])/20,2]}],{0.99Min[mLLPmax[prod],mmax\[Epsilon]]}],{prod,ProductionList}];*)


(* ::Subsubsection::Closed:: *)
(*Calculating tabulated acceptances*)


(* ::Input:: *)
(**)
(*Do[*)
(*\[Epsilon]GeomTabs[prod]=ParallelTable[{m,AcceptanceDiscret[m,prod,"False",0],AcceptanceDiscret[m,prod,"True",0],AcceptanceDiscret[m,prod,"False",1],AcceptanceDiscret[m,prod,"True",1]},{m,mlistAcceptance[prod]}];*)
(*\[Epsilon]GeomTabs[prod]=Join[{Join[{Max[mLLPmin[prod],mmin\[Epsilon]]},Drop[\[Epsilon]GeomTabs[prod][[1]],1]]},\[Epsilon]GeomTabs[prod],{Join[{Min[mLLPmax[prod],mmax\[Epsilon]]},Drop[\[Epsilon]GeomTabs[prod][[-1]],1]]}];*)
(*,{prod,ProductionList}];//AbsoluteTiming*)
(*PlotAcc[ProdChannel_]:=ListLogPlot[Evaluate[{\[Epsilon]GeomTabs[ProdChannel][[All,{1,2}]],\[Epsilon]GeomTabs[ProdChannel][[All,{1,3}]],\[Epsilon]GeomTabs[ProdChannel][[All,{1,4}]],\[Epsilon]GeomTabs[ProdChannel][[All,{1,5}]]}],FrameStyle->Directive[Black, 22],PlotStyle->{{Thickness[0.003],Blue},{Thickness[0.003],Darker@Red},{Thickness[0.003],Darker@Darker@Green},{Thickness[0.003],Black}},GridLines->Automatic,PlotRange->{MinMax[\[Epsilon]GeomTabs[ProdChannel][[All,1]]],{Max[0.9Min[Min[\[Epsilon]GeomTabs[ProdChannel][[All,4]]],Min[\[Epsilon]GeomTabs[ProdChannel][[All,3]]]],10^-5],1.1Max[Max[\[Epsilon]GeomTabs[ProdChannel][[All,2]]],Max[\[Epsilon]GeomTabs[ProdChannel][[All,4]]]]}},Joined->True,Frame->True,ImageSize->Large,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(LLP\)]\) [GeV]","Acceptance"},PlotLabel-> Style[Row[{"From ",ProdChannel}], 20, Black],PlotLegends->Placed[{Style[#, 18]&/@{"<\!\(\*SubscriptBox[\(\[Epsilon]\), \(LLP\)]\)>","<\!\(\*SubscriptBox[\(\[Epsilon]\), \(LLP\)]\)\!\(\*SubscriptBox[\(\[Epsilon]\), \(decay\)]\)>","c\[Tau]<\!\(\*SubscriptBox[\(\[Epsilon]\), \(LLP\)]\)\!\(\*SubscriptBox[\(P\), \(decay\)]\)>","c\[Tau]<\!\(\*SubscriptBox[\(\[Epsilon]\), \(LLP\)]\)\!\(\*SubscriptBox[\(P\), \(decay\)]\)\!\(\*SubscriptBox[\(\[Epsilon]\), \(decay\)]\)>"}},{0.75,0.2}]]*)
(*Style[Row[Evaluate[Table[PlotAcc[prod],{prod,ProductionList}]]],ImageSizeMultipliers->{1,1,1,1}]*)
(*(*Do[FilenameAcceptance[prod]=ToString@StringForm["Acceptance_ALP-fermion_at_``_From_``.dat",Sequence@@{SelectedExperiment,ExportList[prod]}];*)
(*Export[FileNameJoin[{NotebookDirectory[],"Auxiliary data/ALPs with fermion coupling",SelectedExperiment,FilenameAcceptance[prod]}],\[Epsilon]GeomTabs[prod][[All,{1,2,4,5}]],"Table"]*)
(*,{prod,ProductionList}]*)*)
(*AccAveraged[mLLP_,c\[Tau]_]=NpotGivenExperiment{Sum[If[mLLPmin[prod]<mLLP<mLLPmax[prod],Evaluate[ProbLLP[mLLP,1,prod]],0],{prod,ProductionListBaseline}],Sum[If[Max[mLLPmin[prod],mmin\[Epsilon]]<mLLP<Min[mLLPmax[prod],mmax\[Epsilon]],Evaluate[ProbLLP[mLLP,1,prod]*Interpolation[\[Epsilon]GeomTabs[prod][[All,{1,2}]],InterpolationOrder->1][mLLP]],0],{prod,ProductionListBaseline}],Sum[If[Max[mLLPmin[prod],mmin\[Epsilon]]<mLLP<Min[mLLPmax[prod],mmax\[Epsilon]],Evaluate[ProbLLP[mLLP,1,prod]/c\[Tau]*Interpolation[\[Epsilon]GeomTabs[prod][[All,{1,4}]],InterpolationOrder->1][mLLP]],0],{prod,ProductionListBaseline}],Sum[If[Max[mLLPmin[prod],mmin\[Epsilon]]<mLLP<Min[mLLPmax[prod],mmax\[Epsilon]],Evaluate[ProbLLP[mLLP,1,prod]/c\[Tau]*Interpolation[\[Epsilon]GeomTabs[prod][[All,{1,5}]],InterpolationOrder->1][mLLP]],0],{prod,ProductionListBaseline}]};*)
(*Export[FileNameJoin[{directory["Auxiliary-experiment"],"AcceptanceAveraged-"<>LLPdirName<>".m"}],AccAveraged[mLLP,c\[Tau]],"MX"];*)


(* ::Subsection::Closed:: *)
(*Rough estimates of the upper and lower bounds*)


(* ::Input:: *)
(*Do[LowerBoundEstimate[mLLP_,prod]=((NpotGivenExperiment*ProbLLP[mLLP,1,prod]*Interpolation[\[Epsilon]GeomTabs[prod][[All,{1,5}]],InterpolationOrder->1][mLLP])/(2.3ldecayLLP[mLLP,1,ELLP] mLLP/Sqrt[ELLP^2-mLLP^2]))^(-(1/2));*)
(*UpperBoundEstimate[mLLP_,prod]=(Abs[Re[Evaluate[-(ProductLog[-1,-2.3*b/a]/b)/.{a-> NpotGivenExperiment*ProbLLP[mLLP,1,prod]*Interpolation[\[Epsilon]GeomTabs[prod][[All,{1,3}]],InterpolationOrder->1][mLLP],b->zminExp/ldecayLLP[mLLP,1,ELLPmax[0.5,\[Theta]minExp,prod]]}]]]),{prod,ProductionList}]*)
(*ProdTest=ProductionList[[1]]*)
(*LogLogPlot[Evaluate[{0.3LowerBoundEstimate[mLLP,ProdTest],1.8UpperBoundEstimate[mLLP,ProdTest]}],{mLLP,Max[mLLPmin[ProdTest],mmin\[Epsilon]],Min[mLLPmax[ProdTest],mmax\[Epsilon]]},Frame->True,ImageSize->Large]*)


(* ::Subsection::Closed:: *)
(*Number of events - fast*)


(* ::Input:: *)
(*FactorLowerBound=If[MemberQ[{"ANUBIS-shaft-volume-1","ANUBIS-shaft-volume-2","ANUBIS-shaft-volume-3"},SelectedExperiment]==True,0.1,0.3];*)
(*NeventsDiscret[m_,ProdChannel_,couplinglist_]:=Module[{NevDiscret,NpotTimes\[Chi]val,zshift},*)
(*If[Max[mLLPmin[ProdChannel],mmin\[Epsilon]]<m<Min[mLLPmax[ProdChannel],mmax\[Epsilon]],*)
(*integrandtab=TableIntegrandDiscret[m,ProdChannel,"True"];*)
(*NpotTimes\[Chi]val[coupling_]=NpotGivenExperiment*ProbLLP[m,coupling,ProdChannel];*)
(*{lowerbound,upperbound}={LowerBoundEstimate[m,ProdChannel],UpperBoundEstimate[m,ProdChannel]};*)
(*brvis=BrVis[m];*)
(*NevDiscret[coupling_]:=If[0.1lowerbound<coupling<(*1.5*)2upperbound,NpotTimes\[Chi]val[coupling]*brvis*sumcompile[tableprefac[integrandtab,m,c\[Tau]LLP[m,coupling],1,0.]],0.];*)
(*Table[{m,couplinglist[[i]],NevDiscret[couplinglist[[i]]]},{i,1,Length[couplinglist],1}],Table[{m,couplinglist[[i]],0.},{i,1,Length[couplinglist],1}]]*)
(*]*)


(* ::Subsection::Closed:: *)
(*Number of events - slow (using built-in Mathematica functions Interpolation, NIntegrate)*)


(* ::Input:: *)
(*(*Differential decay probability 1/ldecayExp[-l/ldecay], where l is expressed in terms of the longitudinal displacement z and polar angle \[Theta] as z/cos\[Theta]*)*)
(*(*Differential decay probability (1/ldecay)Exp[-l/ldecay], where l is expressed in terms of the longitudinal displacement z and polar angle \[Theta] as z/cos\[Theta]*)*)
(*PdecayDensity[mLLP_,coupling_,\[Theta]LLP_,ELLP_,zLLP_]=Exp[-zLLP/(Cos[\[Theta]LLP]*ldecayLLP[mLLP,coupling,ELLP])]/(Abs[Cos[\[Theta]LLP]]*ldecayLLP[mLLP,coupling,ELLP]);*)
(*(*The integrand determining the differential rate for events*)*)
(*Do[IntegrandLLP[mLLP_,coupling_,\[Theta]LLP_,ELLP_,zLLP_,prod]=DoubleDistrLLPint[mLLP,\[Theta]LLP,ELLP,prod]*PdecayDensity[mLLP,coupling,\[Theta]LLP,ELLP,zLLP]*AzimuthalAcceptanceInt[\[Theta]LLP,zLLP]*DecayAcceptanceInt[mLLP,\[Theta]LLP,ELLP,zLLP],{prod,ProductionList}]*)
(*IntegralLLP[mLLP_,coupling_,ProdChannel_]:=NIntegrate[Abs[IntegrandLLP[mLLP,coupling,\[Theta]LLP,Exp[ELLP],zLLP,ProdChannel]Exp[ELLP]],{\[Theta]LLP,\[Theta]minExp,\[Theta]maxExp},{ELLP,Log[mLLP],Log[ELLPmax[mLLP,\[Theta]LLP,ProdChannel]]},{zLLP,zmin\[Theta][\[Theta]LLP],zmax\[Theta][\[Theta]LLP]},Method->"AdaptiveMonteCarlo"]*)
(*NeventsInt[mLLP_,coupling_,ProdChannel_]:=If[mLLPmin[ProdChannel]<=mLLP<=mLLPmax[ProdChannel]&&BrVis[mLLP]!=0,If[0.1LowerBoundEstimate[mLLP,ProdChannel]<coupling<2UpperBoundEstimate[mLLP,ProdChannel],NpotGivenExperiment*ProbLLP[mLLP,coupling,ProdChannel]*IntegralLLP[mLLP,coupling,ProdChannel],0.],0.]*)
(*IntegralLLPE[mLLP_,coupling_,ProdChannel_,ELLP_]:=NIntegrate[Abs[IntegrandLLP[mLLP,coupling,\[Theta]LLP,ELLP,zLLP,ProdChannel]],{\[Theta]LLP,\[Theta]minExp,\[Theta]maxExp},{zLLP,zmin\[Theta][\[Theta]LLP],zmax\[Theta][\[Theta]LLP]},Method->"AdaptiveMonteCarlo"]*)
(*NeventsDiffInt[mLLP_,coupling_,ProdChannel_,ELLP_]:=If[mLLPmin[ProdChannel]<=mLLP<=mLLPmax[ProdChannel]&&BrVis[mLLP]!=0&&mLLP<ELLP<=ELLPmax[mLLP,\[Theta]minExp,ProdChannel],If[0.1LowerBoundEstimate[mLLP,ProdChannel]<coupling<2UpperBoundEstimate[mLLP,ProdChannel],NpotGivenExperiment*ProbLLP[mLLP,coupling,ProdChannel]*IntegralLLPE[mLLP,coupling,ProdChannel,ELLP],0.],0.]*)


(* ::Section::Closed:: *)
(*Tests*)


(* ::Subsection::Closed:: *)
(*Differential number of events*)


(* ::Input:: *)
(*(*This is a comparison between the slow and fast integration methods. For the selected mass and production channel, the numbers of events obtained using the methods should agree within 10%*)*)
(*(*If the agreement is worse, there may be a few reasons*)*)
(*(*1) The grid for the fast method is not dense enough. Try to increase the grid density (OutGrid\[Theta]final, OutGridEfinal, OutGridzfinal) to see whether the agreement improves. Sometimes, even a slightly denser grid for e.g. z may lead to a significant improvement in the agrement*)*)
(*(*2) The Monte-Carlo integrator for the slow method fails to evaluate properly; this may happen if the range of the integration over energies is too large compared to the domain where most of the events actually are (off-axis experiments such as MATHUSLA and ANUBIS). Another symptom is that for the given mass and coupling the integral "jumps", i.e., returns values with large error*)*)
(*(*A separate discussion should be made for the couplings belong to the domain c\[Tau] \[Gamma] << Subscript[z, experiment]. The discrepancy may be significant, and the reason is insufficient grid density for the fast integration method. However, due to the exponential suppression of the number of events, this may be compensated by a tiny shift in the coupling, so the discrepancy should be considered as appropriate.*)*)
(*ProdTest=ProductionList[[2]]*)
(*mtest=Max[mLLPmin[ProdTest]+(mLLPmax[ProdTest]-mLLPmin[ProdTest])*0.3,1.2*mmin\[Epsilon]];*)
(*\[Epsilon]2list=(*{10^-12,3*10^-12,5*10^-12,10^-11,5*10^-11,10^-10,5*10^-10,10^-9,5*10^-9,10^-8,2*10^-8,4*10^-8,10^-7,5*10^-7,6*10^-7,7*10^-7,8*10^-7,9*10^-7,10^-6,2*10^-6}//N*)Table[10^x,{x,-17.,-3.,0.3}];*)
(*dat1=NeventsDiscret[mtest,ProdTest,\[Epsilon]2list];//AbsoluteTiming*)
(*dat2=ParallelTable[{\[Epsilon]2list[[i]],c\[Tau]LLP[mtest,\[Epsilon]2list[[i]]],Quiet[NeventsInt[mtest,\[Epsilon]2list[[i]],ProdTest]]},{i,1,Length[\[Epsilon]2list],1}];//AbsoluteTiming*)
(*Join[{{"\!\(\*FractionBox[SubscriptBox[\(m\), \(LLP\)], \(GeV\)]\)","coupling","\!\(\*FractionBox[\(c\[Tau]\), SubscriptBox[\(z\), \(min\)]]\)","\!\(\*SubscriptBox[\(N\), \(events, fast\)]\)","\!\(\*SubscriptBox[\(N\), \(events, slow\)]\)"}},Join[dat1[[All,{1,2}]],{#[[2]]/zminExp}&/@dat2,dat1[[All,{3}]],dat2[[All,{3}]],2]]//TableForm*)


(* ::Subsection::Closed:: *)
(*Differential number of events*)


(* ::Input:: *)
(*(*Variable = "Subscript[E, X]","Subscript[z, X]","Subscript[\[Theta], X]". The number belongs to the column in the tabulated data*)*)
(*iVal:=Association[{"\!\(\*SubscriptBox[\(E\), \(LLP\)]\)" ->2,"\!\(\*SubscriptBox[\(\[Theta]\), \(LLP\)]\)"->1,"\!\(\*SubscriptBox[\(z\), \(LLP\)]\)"->3}]*)
(*\[CapitalDelta]xvals["\!\(\*SubscriptBox[\(E\), \(LLP\)]\)"]:=\[CapitalDelta]Evals;*)
(*\[CapitalDelta]xvals["\!\(\*SubscriptBox[\(z\), \(LLP\)]\)"]=\[CapitalDelta]zvals;*)
(*Do[\[CapitalDelta]xvals["\!\(\*SubscriptBox[\(\[Theta]\), \(X\)]\)",prod]=\[CapitalDelta]\[Theta]vals[prod],{prod,ProductionList}];*)
(*LegendX:=Association[{"\!\(\*SubscriptBox[\(E\), \(LLP\)]\)"->"\!\(\*SubscriptBox[\(E\), \(LLP\)]\) [GeV]","\!\(\*SubscriptBox[\(\[Theta]\), \(LLP\)]\)"->"\!\(\*SubscriptBox[\(\[Theta]\), \(LLP\)]\) [rad]","\!\(\*SubscriptBox[\(z\), \(LLP\)]\)"-> "\!\(\*SubscriptBox[\(z\), \(LLP\)]\) [m]"}]*)
(*LegendY:=Association[{"\!\(\*SubscriptBox[\(E\), \(LLP\)]\)"->"\!\(\*SubscriptBox[\(dN\), \(ev\)]\)/\!\(\*SubscriptBox[\(dE\), \(LLP\)]\) [\!\(\*SuperscriptBox[\(GeV\), \(-1\)]\)]","\!\(\*SubscriptBox[\(\[Theta]\), \(LLP\)]\)"->"\!\(\*SubscriptBox[\(dN\), \(ev\)]\)/\!\(\*SubscriptBox[\(d\[Theta]\), \(LLP\)]\) [\!\(\*SuperscriptBox[\(rad\), \(-1\)]\)]","\!\(\*SubscriptBox[\(z\), \(LLP\)]\)"-> "\!\(\*SubscriptBox[\(dN\), \(ev\)]\)/\!\(\*SubscriptBox[\(dz\), \(LLP\)]\) [\!\(\*SuperscriptBox[\(m\), \(-1\)]\)]"}]*)
(*(*Differential number of events*)*)
(*NeventsDifferentialDiscretProd[m_,ProdChannel_,coupling_,Variable_]:=Module[{NpotTimes\[Chi]val},*)
(*ival=iVal[Variable];*)
(*NpotTimes\[Chi]val=NpotGivenExperiment*ProbLLP[m,coupling,ProdChannel];*)
(*tablegrid0=TableIntegrandDiscret[m,ProdChannel,"True"];*)
(*OutGridEfinalTemp=OutGridEnergy[N[m],ProdChannel];*)
(*\[CapitalDelta]Evals=(Rest[10^OutGridEfinalTemp]-Most[10^OutGridEfinalTemp]);*)
(*\[CapitalDelta]xval=\[CapitalDelta]xvals[Variable];*)
(*c\[Tau]Val=c\[Tau]LLP[m,coupling];*)
(*brvis=BrVis[m];*)
(*ilist=DeleteDuplicates[{ival,1,2,3}];*)
(*tablegrid1=SortBy[{#[[ilist[[1]]]],#[[ilist[[2]]]],#[[ilist[[3]]]],#[[4]]}&/@tableGridPrefac[tablegrid0,m,c\[Tau]Val,0.],{#[[1]],#[[2]],#[[3]]}&];*)
(*GridQuantity=tablegrid1[[All,1]]//DeleteDuplicates;*)
(*LengthPerVariable=Length[tablegrid1]/Length[GridQuantity];*)
(*tab1=NdiffCompiled[tablegrid1,GridQuantity,LengthPerVariable,NpotTimes\[Chi]val*brvis];*)
(*Join[tab1[[All,{1}]],Partition[tab1[[All,2]]*\[CapitalDelta]xval^-1,1],2]*)
(*]*)
(*NeventsDifferentialDiscret[m_,coupling_,Variable_]:=Module[{NdiffInt,LegendList,QuantityMinMax,ValueMinMax},*)
(*prodlisttemp={};*)
(*Do[If[Max[mLLPmin[prod],mmin\[Epsilon]]<m<Min[mLLPmax[prod],mmax\[Epsilon]],*)
(*prodlisttemp=Join[prodlisttemp,{prod}];*)
(*NdiffData[prod]=NeventsDifferentialDiscretProd[m,prod,coupling,Variable];*)
(*XvalminmaxNdiff=Select[NdiffData[prod],#[[2]]>10^-40&][[All,1]]//MinMax;*)
(*NdiffInt[X_,prod]=If[XvalminmaxNdiff[[1]]<X<XvalminmaxNdiff[[2]],Evaluate[10^Interpolation[{Log10[#[[1]]],Log10[#[[2]]+10^-90]}&/@NdiffData[prod],InterpolationOrder->1][Log10[X]]],0]],{prod,ProductionListBaseline}];*)
(*NdiffInt[X_,"Total"]=Sum[NdiffInt[X,prod],{prod,prodlisttemp}];*)
(*LegendList=Join[{"Total"},prodlisttemp];*)
(*QuantityMinMax=Flatten[Table[MinMax[NdiffData[prod][[All,1]]],{prod,prodlisttemp}],1]//MinMax;*)
(*ValueMinMax=Max[Max[NdiffData[#][[All,2]]]&/@prodlisttemp];*)
(*{Table[NdiffInt[X,prod],{prod,LegendList}],LegendList,QuantityMinMax,ValueMinMax}*)
(*]*)
(*mvaltest=If[FacilityGivenExperiment=="ESS",0.04,0.3];*)
(*couplingvaltest=2*LowerBoundEstimate[mvaltest,"Eta"];*)
(*quantity="\!\(\*SubscriptBox[\(E\), \(LLP\)]\)";*)
(*{NdiffTab[X_],LegendList,QuantityMinMax,ValueMinMax}=NeventsDifferentialDiscret[mvaltest,couplingvaltest,quantity];*)
(*Do[*)
(*prch=LegendList[[i]];*)
(*NdiffInt[X_,prch]=NdiffTab[X][[i]];*)
(*,{i,1,Length[LegendList]}];*)
(*plotdiff=LogLogPlot[Evaluate[Table[NdiffInt[X,prod],{prod,LegendList}]],{X,QuantityMinMax[[1]],QuantityMinMax[[2]]},Frame->True,ImageSize->Large,PlotRange->{All,{10^-5,2ValueMinMax}},PlotStyle->{{Thick,Black,Dashing[0.02]},{Thick,Lighter@Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick,Lighter@Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]}},PlotLegends->Placed[Style[#,16]&/@(LegendList/.{"Bremsstrahlung-FR-Central"->"Bremsstrahlung"}),{0.82,0.7}],FrameLabel->{LegendX[quantity] ,LegendY[quantity]},FrameStyle->Directive[Black, 18],PlotLabel->Style[Row[{SelectedExperiment,". \!\(\*SubscriptBox[\(m\), \(LLP\)]\) = ",mvaltest," GeV, \!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\) = ",couplingvaltest//N}],18,Black]]*)


(* ::Title::Closed:: *)
(*Exporting tabulated number of events*)


(* ::Chapter::Closed:: *)
(*Definitions*)


(* ::Input:: *)
(*directory["Nevents"]=FileNameJoin[{NotebookDirectory[],"Tabulated Nevents"}];*)
(*directory["Nevents-LLP"]=FileNameJoin[{NotebookDirectory[],"Tabulated Nevents",LLPdirName}];*)
(*directory["Nevents-LLP-experiment"]=FileNameJoin[{NotebookDirectory[],"Tabulated Nevents",LLPdirName,SelectedExperiment}];*)
(*If[!DirectoryQ[directory[#]],CreateDirectory[directory[#]]]&/@{"Nevents","Nevents-LLP","Nevents-LLP-experiment"};*)
(*Print["Filenames with tabulated \!\(\*SubscriptBox[\(N\), \(events\)]\):"]*)
(*Do[FilenameNeventsInt[prod]=ToString@StringForm["Nevents_``_``_at_``_Npot=``.dat",Sequence@@{LLPdirName,prod,SelectedExperiment,NpotGivenExperiment//CForm//ToString}],{prod,ProductionList}]*)
(*FilenameNeventsInt[#]&/@ProductionList*)
(*Do[mRangeExport[prod]=Join[{0.021,0.026,0.031,0.036,0.041,0.046,0.051,0.056,0.061,0.066,0.07,0.08,0.09,0.1,0.11,0.12,0.125,0.13,0.14,0.15,0.17,0.2,0.215,0.25,0.3,0.35,0.4,0.45,0.46,0.47,0.48,0.5,0.51,0.52,0.53,0.54,0.55,0.575,0.6,0.625,0.65,0.675,0.7,0.72,0.73,0.74,0.75,0.76,0.77,0.775,0.777,0.78,0.782,0.785,0.79,0.795,0.8,0.81,0.82,0.84,0.9,0.95,0.97,1,1.005,1.01,1.012,1.015,1.017,1.018,1.02,1.022,1.023,1.024,1.025,1.03,1.05,1.07,1.09,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45,1.475,1.5,1.525,1.55,1.575,1.6,1.62,1.65,1.67,1.7,1.75,1.8,1.85,1.9,1.95,2.,2.05,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,3.,3.05,3.1,3.2},Table[mLLP,{mLLP,3.21,Max[Table[mLLPmax[prod],{prod,ProductionList}]],(Max[Table[mLLPmax[prod],{prod,ProductionList}]]-3)/20}]]//N*)
(*,{prod,ProductionList}];*)
(*couplingsRangeExport=Table[10^x,{x,-18.8,-6,0.03}]//N;*)


(* ::Chapter::Closed:: *)
(*Exporting*)


(* ::Input:: *)
(*BlockExport[ProdChannel_]:=Module[{mlist},*)
(*mlist=mRangeExport[ProdChannel];*)
(*TabFrom=ParallelTable[Quiet[NeventsDiscret[mlist[[k]],ProdChannel,couplingsRangeExport]],{k,1,Length[mlist],1}];*)
(*Export[FileNameJoin[{directory["Nevents-LLP-experiment"],FilenameNeventsInt[ProdChannel]}],Flatten[TabFrom,1],"Table"]*)
(*]*)
(*Monitor[*)
(*Do[*)
(*prod=ProductionList[[j]];*)
(*BlockExport[prod],{j,1,Length[ProductionList],1}],*)
(*Row[{ProgressIndicator[j,{1,Length[ProductionList]}]," Production mode = ",ProductionList[[j]]," (", j,"/",Length[ProductionList],")"}]]//AbsoluteTiming*)
(*If[icounter>Length[SelectedExperimentList],BlockEvaluation["Sensitivity"]]*)


(* ::Title::Closed:: *)
(*Computing sensitivities*)


(* ::Chapter::Closed:: *)
(*Basic definitions*)


(* ::Input:: *)
(*LLPdirName="DP";*)
(*directory["Sensitivity"]=FileNameJoin[{NotebookDirectory[],"Sensitivity domains"}];*)
(*directory["Sensitivity-LLP"]=FileNameJoin[{directory["Sensitivity"],LLPdirName}];*)
(*If[!DirectoryQ[directory[#]],CreateDirectory[directory[#]]]&/@{"Sensitivity","Sensitivity-LLP"};*)
(*directory["Nevents-LLP"]=FileNameJoin[{NotebookDirectory[],"Tabulated Nevents",LLPdirName}];*)
(*dropdownDialog[list_,phrase_]:=DialogInput[{choice=""},Column[{TextCell[phrase],PopupMenu[Dynamic[choice],list],Button["OK",DialogReturn[choice]]}]]*)
(*infoDialog[phrase_]:=DialogInput[{choice=""},Column[{TextCell[phrase],Button["Proceed",DialogReturn[choice]]}]]*)
(*selectionDialog[list_,phrase_]:=DialogInput[{choice={}},Column[{Row[{phrase}],Pane[TogglerBar[Dynamic[choice],list,Appearance->"Vertical"->{Automatic,5}],ImageSize->{Automatic,Automatic},Scrollbars->{False,True}],Button["OK",DialogReturn[choice]]}]]*)
(*ExperimentDirectoriesListNevents=Select[FileNames["*",directory["Nevents-LLP"],1],DirectoryQ];*)
(*Print["List of available experiments with tabulated \!\(\*SubscriptBox[\(N\), \(events\)]\) for " <>LLPdirName<>":"]*)
(*ExperimentsListNevents=Table[FileNameTake[ExperimentDirectoriesListNevents[[i]],-1],{i,1,Length[ExperimentDirectoriesListNevents],1}]//Sort;*)
(*ExperimentsListNevents//TableForm*)
(*If[Length[ExperimentsListNevents]==0,Print["No experiment is available, generate first the acceptance for the given experiment using module 1"],*)
(*SelectedExperimentList=If[Length[ExperimentsListNevents]!=0,selectionDialog[ExperimentsListNevents,"Select the experiments for which the sensitivity will be computed:"]];*)
(*icounter=1;*)
(*BlockEvaluation[tag_]:=Block[{},*)
(*nb=EvaluationNotebook[];*)
(*NotebookFind[nb,tag,All,CellTags];*)
(*SelectionEvaluate[nb]*)
(*];*)
(*Do[*)
(*BlockEvaluation["Sensitivity-computation"];*)
(*,{icounter,1,Length[SelectedExperimentList],1}]*)
(*]*)


(* ::Chapter::Closed:: *)
(*Specifying the experiment and interpolating tabulated number of events*)


(* ::Section::Closed:: *)
(*Selecting the experiment*)


(* ::Input:: *)
(*Print["Selected experiment:"]*)
(*GivenExperimentForSensitivityComputation=SelectedExperimentList[[icounter++]]*)
(*CondANUBIS=MemberQ[{"ANUBIS-shaft-volume-1","ANUBIS-shaft-volume-2","ANUBIS-shaft-volume-3"},GivenExperimentForSensitivityComputation];*)
(*If[CondANUBIS==True,infoDialog[Row[{"One of the modules of ANUBIS-shaft is chosen. The full sensitivity includes three modules. The importing will be over all modules, so for all ot the the sensitivity has to be computed"}]]]*)
(*If[CondANUBIS==False,GivenExperimentForSensitivityComputationList={GivenExperimentForSensitivityComputation},GivenExperimentForSensitivityComputationList={"ANUBIS-shaft-volume-1","ANUBIS-shaft-volume-2","ANUBIS-shaft-volume-3"}];*)
(*PathsNeventsSelected={};*)
(*Do[PathsNeventsSelected=Join[PathsNeventsSelected,FileNames["*.dat",FileNameJoin[{directory["Nevents-LLP"],exp}]]],{exp,GivenExperimentForSensitivityComputationList}];*)
(*(*Creating the directory for exporting sensitivity curves*)*)
(*ExperimentFolder=If[CondANUBIS==True,"ANUBIS",GivenExperimentForSensitivityComputation];*)
(*directory["Sensitivity-LLP-exp"]=FileNameJoin[{directory["Sensitivity-LLP"],ExperimentFolder}];*)
(*If[!DirectoryQ[directory["Sensitivity-LLP-exp"]],CreateDirectory[directory["Sensitivity-LLP-exp"]]]*)


(* ::Section::Closed:: *)
(*Importing data and interpolations*)


(* ::Input:: *)
(*(*______________________________________________________*)*)
(*(*Importing and interpolation*)*)
(*(*______________________________________________________*)*)
(*Print["List of production channels:"]*)
(*FilenamesNeventsSelected=Table[Last@FileNameSplit@PathsNeventsSelected[[i]],{i,1,Length[PathsNeventsSelected],1}];*)
(*FilenameParameters[i_]:=StringCases[FilenamesNeventsSelected[[i]],"Nevents_"<>LLPdirName<>"_"~~mother__~~"_at_"~~experiment__~~"_Npot="~~Npot__~~".dat":>{mother,experiment,Npot}][[1]]*)
(*ProductionInfoList=Table[FilenameParameters[i],{i,1,Length[FilenamesNeventsSelected],1}];*)
(*Join[{{"Mother","Experiment","\!\(\*SubscriptBox[\(N\), \(PoT\)]\)"}},ProductionInfoList]//TableForm*)
(*ProductionChannelsList=ProductionInfoList[[All,1]];*)
(*NpotDefault=Interpreter["Number"][ProductionInfoList[[1]][[3]]];*)
(*NeventsTabulated//Clear;*)
(*\[Epsilon]reco[mLLP_]=1;*)
(*If[StringContainsQ[GivenExperimentForSensitivityComputation,"LHCb-downstream"],*)
(*\[Epsilon]reco[mLLP_]=0.4];*)
(*If[StringContainsQ[GivenExperimentForSensitivityComputation,"NuCal"],*)
(*\[Epsilon]reco[mLLP_]=0.7];*)
(*If[StringContainsQ[GivenExperimentForSensitivityComputation,"CHARM"],*)
(*\[Epsilon]reco[mLLP_]=0.6];*)
(*Do[*)
(*Module[{prod},*)
(*prod=ProductionChannelsList[[i]];*)
(*(*The condition if one sums the number of events for the same production mode over several experiments*)*)
(*IfprodExists=MemberQ[Keys[DownValues@NeventsTabulated][[All,1,1]],prod];*)
(*NeventsTabulated[prod]=If[!IfprodExists,Import[PathsNeventsSelected[[i]],"Table"],Join[NeventsTabulated[prod][[All,{1,2}]],NeventsTabulated[prod][[All,{3}]]+Import[PathsNeventsSelected[[i]],"Table"][[All,{3}]]]];*)
(*{mminmax[prod],couplingminmax[prod]}=(NeventsTabulated[prod][[All,#]]//MinMax)&/@{1,2};*)
(*NevMax[prod]=NeventsTabulated[prod][[All,3]]//Max;*)
(*NevInt[mLLP_,\[Epsilon]2_,prod]=\[Epsilon]reco[mLLP]*If[mminmax[prod][[1]]<= mLLP<=mminmax[prod][[2]]&&couplingminmax[prod][[1]]<=\[Epsilon]2<=couplingminmax[prod][[2]],Evaluate[10^(Interpolation[{Log10[#[[1]]],Log10[#[[2]]],Log10[#[[3]]+10^-90]}&/@NeventsTabulated[prod],InterpolationOrder->1][Log10[mLLP],Log10[\[Epsilon]2]])],0];*)
(*]*)
(*,{i,1,Length[ProductionInfoList],1}]*)
(*{mminmaxOverall,couplingminmaxOverall}=MinMax[Table[#[prod],{prod,ProductionChannelsList}]//Flatten]&/@{mminmax,couplingminmax};*)
(*NevMaxOverall=Max[Table[NevMax[prod],{prod,ProductionChannelsList}]];*)


(* ::Subsection::Closed:: *)
(*Accounting for various bremsstrahlung descriptions*)


(* ::Input:: *)
(*Print["List of various bremsstrahlung channels:"]*)
(*BremChannelsList=Select[ProductionChannelsList,StringContainsQ[#,"Bremsstrahlung"]&]//Sort*)
(*(*Defining the baseline bremsstrahlung setup*)*)
(*BremChannelBaseline="Bremsstrahlung-FR-Central";*)
(*If[BremChannelsList=={},*)
(*ProductionChannelsListUnified=ProductionChannelsList;*)
(*,*)
(*If[MemberQ[BremChannelsList,BremChannelBaseline],*)
(*ProductionChannelsBaseline=Join[Select[ProductionChannelsList,!StringContainsQ[#,"Bremsstrahlung"]&],{BremChannelBaseline}];*)
(*,*)
(*ProductionChannelsBaseline=Join[Select[ProductionChannelsList,!StringContainsQ[#,"Bremsstrahlung"]&],{BremChannelsList[[1]]}]*)
(*];*)
(*ProductionChannelsListUnified=Join[Select[ProductionChannelsList,!StringContainsQ[#,"Bremsstrahlung"]&],{"Bremsstrahlung"}];*)
(*];*)
(*MapThread[(BremNameExportPattern[#1]=#2)&,{("Bremsstrahlung-"<>#)&/@{"FR-Upper","FR-Central","FR-Lower","Baseline","AP-Upper","AP-Central","AP-Lower"},{"FR-Upper","FR-Central","FR-Lower","Baseline","AP-Upper","AP-Central","AP-Lower"}}];*)
(*NevIntOverall[mLLP_,\[Epsilon]2_]=Sum[NevInt[mLLP,\[Epsilon]2,prod],{prod,ProductionChannelsBaseline}];*)
(*pt[mLLP_]:=LogLogPlot[Evaluate[Table[NevInt[mLLP,y,prod],{prod,ProductionChannelsBaseline}]],{y,couplingminmaxOverall[[1]],couplingminmaxOverall[[2]]},PlotLegends->Placed[Style[#,15]&/@ProductionChannelsBaseline,Right],PlotRange->{couplingminmaxOverall,{10^-2,NevMaxOverall}},Frame->True,ImageSize->Large,FrameLabel->{"\!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\)" , "\!\(\*SubscriptBox[\(N\), \(events\)]\)[\!\(\*SubscriptBox[\(m\), \(V\)]\),\!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\)]"},FrameStyle->Directive[Black, 23],PlotStyle->{{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Black},{Thick,Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]},{Thick,Black,Dashing[0.02]}},PlotLabel->Style[Row[{ExperimentFolder,". \!\(\*SubscriptBox[\(m\), \(V\)]\) = ",mLLP, " GeV"}],20,Black]]*)
(*pt[0.7]*)


(* ::Chapter::Closed:: *)
(*Sensitivity*)


(* ::Section::Closed:: *)
(*Events density plot*)


(* ::Input:: *)
(*plot=DensityPlot[Evaluate[Log10[NevIntOverall[mLLP,\[Epsilon]2]]],{mLLP,mminmaxOverall[[1]],mminmaxOverall[[2]]},{\[Epsilon]2,couplingminmaxOverall[[1]],couplingminmaxOverall[[2]]},ScalingFunctions->{"Log","Log"},AspectRatio->0.78,PlotRange->{All,All,{Log10[2.3],Log10[NevMaxOverall]}},ImageSize->Large,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(V\)]\) [GeV]","\!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\)"}, Frame-> True, FrameStyle->Directive[Black, 25],PlotPoints->100,PlotLegends->Placed[BarLegend[{Automatic,{Log10[2.3],Log10[NevMaxOverall]}},LegendMarkerSize->340,LegendLabel->Placed["\!\(\*SubscriptBox[\(Log\), \(10\)]\)[\!\(\*SubscriptBox[\(N\), \(ev\)]\)]",Bottom],LabelStyle->{FontSize->22},Method->{FrameStyle->Black,AxesStyle->None,TicksStyle->Black}],Right],PlotLabel->Style[Row[{ExperimentFolder}],20,Black](*,FrameTicks->{{Automatic,Automatic},{TicksPlotx,None}}*)]*)
(*Export[FileNameJoin[{NotebookDirectory[],"plots/SensCalc/NeventsDensityPlotExample.pdf"}],plot,"AllowRasterization"->False]*)


(* ::Section::Closed:: *)
(*Importing constraints*)


(* ::Input:: *)
(*ConstraintsDPtemp=Import[FileNameJoin[{NotebookDirectory[],"contours/DP/constraints-DP.mx"}],"MX"];*)
(*ConstraintsTypeDP=ConstraintsDPtemp[[All,1]]*)
(*Do[*)
(*ExcludedRegions["DP",ConstraintsDPtemp[[i]][[1]]]=ConstraintsDPtemp[[i]][[2]];*)
(*,{i,1,Length[ConstraintsDPtemp],1}]*)


(* ::Section::Closed:: *)
(*Sensitivity evaluation*)


(* ::Subsection::Closed:: *)
(*Sensitivity calculator block*)


(* ::Input:: *)
(*SensitivityExtractor[SelectedProduction_,Npot_,NevMin_]:=Module[{RegSens,SensTemp},*)
(*NevTot[mLLP_,\[Epsilon]2_]=Sum[NevInt[mLLP,\[Epsilon]2,prod],{prod,SelectedProduction}];*)
(*RegSens=RegionPlot[Npot/NpotDefault NevTot[10^mLLP,10^\[Epsilon]2]>=NevMin,{mLLP,Log10[mminmaxOverall[[1]]],Log10[mminmaxOverall[[2]]]},{\[Epsilon]2,Log10[couplingminmaxOverall[[1]]],Log10[couplingminmaxOverall[[2]]]},PlotPoints->300];*)
(*SensTemp=Cases[Normal@RegSens,Line[x_]:>x,Infinity];*)
(*Table[{10^#[[1]],10^#[[2]]}&/@SensTemp[[i]],{i,1,Length[SensTemp],1}]*)
(*]*)
(*SensitivityExtractorBrem[SelectedProduction_,i_,Npot_,NevMin_]:=Module[{bremch,selprod},*)
(*bremch=BremChannelsList[[i]];*)
(*selprod=Join[Select[SelectedProduction,#!="Bremsstrahlung"&],{bremch}];*)
(*{i,selprod,BremNameExportPattern[bremch],SensitivityExtractor[selprod,Npot,NevMin]}*)
(*]*)
(*SensitivityBlock[NevMin_,Npot_,SelectedProduction_]:=Block[{},*)
(*If[!MemberQ[SelectedProduction,"Bremsstrahlung"],*)
(*TabSens={{1,SelectedProduction,"None",SensitivityExtractor[SelectedProduction,Npot,NevMin]}};*)
(*,*)
(*TabSens=Table[SensitivityExtractorBrem[SelectedProduction,i,Npot,NevMin],{i,1,Length[BremChannelsList],1}];*)
(*];*)
(*filenameexport=FileNameJoin[{directory["Sensitivity-LLP-exp"],ToString@StringForm["Sensitivity_``_at_``_Nev=``_Npot=``.",Sequence@@{LLPdirName,ExperimentFolder,NevMin//ToString,N[Npot]//CForm//ToString}]}];*)
(*assocData=Map[Association["Index"->#[[1]],"Production modes"->#[[2]],"Bremsstrahlung description"->#[[3]],"Sensitivity domains"->#[[4]]]&,TabSens];*)
(*Export[filenameexport<>"mx",TabSens,"MX"];*)
(*Export[filenameexport<>"json",assocData,"JSON"];*)
(*(*TabSens*)*)
(*Import[filenameexport<>"mx","MX"]*)
(*]*)


(* ::Subsection::Closed:: *)
(*Sensitivity setup and plot*)


(* ::Input:: *)
(*productionlist=Join[{"All"},ProductionChannelsListUnified];*)
(*DynamicModule[{input1=NpotDefault,input2=2.3,choice={"All"},list,phrase},*)
(*DialogInput[Column[{Style[ExperimentFolder,Bold],TextCell["Enter the number of proton collisions:"],InputField[Dynamic[input1],Expression],TextCell["Enter the value of N_ev,min for which the sensitivity will be computed:"],InputField[Dynamic[input2],Expression],Row[{"Select the production channels to be used for the sensitivity calculation:"}],Pane[TogglerBar[Dynamic[choice],productionlist,Appearance->"Vertical"->{Automatic,1}],ImageSize->{Automatic,Automatic},Scrollbars->{False,True}],Button["Submit",DialogReturn[{NpotVal,NevMinVal,SelectedProduction}={input1,input2,choice}//N],ImageSize->Automatic]}]]];*)
(*If[MemberQ[SelectedProduction,"All"],SelectedProduction=ProductionChannelsListUnified;]*)
(*{{"\!\(\*SubscriptBox[\(N\), \(PoT\)]\) for computation","\!\(\*SubscriptBox[\(N\), \(ev, min\)]\)","Selected production modes"},{NpotVal,NevMinVal,SelectedProduction}}//TableForm*)
(*sens=SensitivityBlock[NevMinVal,NpotVal,SelectedProduction];*)
(*legends=sens[[All,-2]];*)
(*sensregions=sens[[All,-1]];*)
(*ColorsForPlot={{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick, Black},{Thick,Lighter@Brown},{Thick,Lighter@Blue},{Thick,Lighter@Red},{Thick,Lighter@Green},{Thick,Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]},{Thick,Darker@Cyan,Dashing[0.02]},{Thick,Magenta,Dashing[0.02]},{Thick,Black,Dashing[0.02]},{Thick,Lighter@Brown,Dashing[0.02]},{Thick,Lighter@Blue,Dashing[0.02]},{Thick,Lighter@Red,Dashing[0.02]},{Thick,Lighter@Green,Dashing[0.02]}};*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsForPlot[[i]],If[MatrixQ[sensregions[[i]]],1,Length@sensregions[[i]]]],{i,1,Length[sensregions],1}],1];*)
(*pt1=Show[*)
(*ListLogLogPlot[Cases[sensregions,_?MatrixQ,All],Joined->{True,True,True,True},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(V\)]\) [GeV]" , "\!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\)"},FrameStyle->Directive[Black, 23],PlotStyle->plotstylelist,ImageSize->Large,PlotRange->{{1.01mminmaxOverall[[1]],1.1mminmaxOverall[[2]]},{couplingminmaxOverall[[1]],Max[0.99couplingminmaxOverall[[2]]]}},PlotLabel->Style[Row[{"Bremsstrahlung uncertainty"}],18,Black]],LogLogPlot[{1,1,1,1,1,1},{x,1,10},PlotStyle->DeleteDuplicates[plotstylelist],ImageSize->Large,PlotRange->{{1.01mminmaxOverall[[1]],1.1mminmaxOverall[[2]]},{couplingminmaxOverall[[1]],Max[0.2,0.99couplingminmaxOverall[[2]]]}},PlotLabel->Style[Row[{GivenExperimentForSensitivityComputation,", \!\(\*SubscriptBox[\(N\), \(events\)]\) \[GreaterEqual] ",NevMinVal}],18,Black],PlotLegends->Placed[Style[#,15]&/@legends,{0.75,0.75}]]];*)
(*pt2=Show[ListLogLogPlot[Cases[ExcludedRegions[LLPdirName,"FR-Central"],_?MatrixQ,All],Joined->{True,True,True,True},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(V\)]\) [GeV]" , "\!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\)"},FrameStyle->Directive[Black, 23],PlotStyle->{{Thick,Gray}},Filling->Table[i->{True,Directive[Gray,Opacity[0.3]]},{i,1,10,1}],ImageSize->Large,PlotRange->{{1.01mminmaxOverall[[1]],1.1mminmaxOverall[[2]]},{0.3Min[Flatten[sensregions]],0.99couplingminmaxOverall[[2]]}},PlotLabel->Style[Row[{GivenExperimentForSensitivityComputation,", \!\(\*SubscriptBox[\(N\), \(events\)]\) \[GreaterEqual] ",NevMinVal}],18,Black]],*)
(*ListLogLogPlot[Cases[sensregions[[2]],_?MatrixQ,All],Joined->{True,True,True,True},PlotStyle->plotstylelist,ImageSize->Large,PlotRange->{{1.01mminmaxOverall[[1]],1.1mminmaxOverall[[2]]},{couplingminmaxOverall[[1]],Max[0.2,0.99couplingminmaxOverall[[2]]]}}],Graphics[{Text[Style["Excluded",24,Black],Scaled[{0.2,0.5}]]}],LogLogPlot[{1,1,1,1,1,1},{x,1,10},PlotStyle->DeleteDuplicates[plotstylelist],ImageSize->Large,PlotRange->{{1.01mminmaxOverall[[1]],1.1mminmaxOverall[[2]]},{couplingminmaxOverall[[1]],Max[0.2,0.99couplingminmaxOverall[[2]]]}},PlotLabel->Style[Row[{GivenExperimentForSensitivityComputation,", \!\(\*SubscriptBox[\(N\), \(events\)]\) \[GreaterEqual] ",NevMinVal}],18,Black],PlotLegends->Placed[Style[#,15]&/@{legends[[2]]},{0.2,0.15}]]];*)
(*Style[Row[{pt2,pt1}]]*)


(* ::Input:: *)
(* *)


(* ::Input:: *)
(**)


(* ::Title::Closed:: *)
(*Deleting generated cells*)


(* ::Input:: *)
(*FrontEndTokenExecute["DeleteGeneratedCells"];*)
(*FrontEndTokenExecute["SelectAll"];*)
(*FrontEndTokenExecute["SelectionCloseAllGroups"];*)
