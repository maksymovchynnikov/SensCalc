#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Chapter::Closed:: *)
(*Definitions (launch first)*)


(* ::Input:: *)
(*dropdownDialog[list_,phrase_]:=DialogInput[{choice=""},Column[{TextCell[phrase],PopupMenu[Dynamic[choice],list],Button["OK",DialogReturn[choice]]}]]*)
(*selectionDialog[list_,phrase_]:=DialogInput[{choice={}},Column[{Row[{"Select the experiments for which the number of events will be computed. The meaning is ",phrase}],Pane[TogglerBar[Dynamic[choice],list,Appearance->"Vertical"->{Automatic,3}],ImageSize->{Automatic,Automatic},Scrollbars->{False,True}],Button["OK",DialogReturn[choice]]}]]*)
(*selectionDialog2[list_,phrase_]:=DialogInput[{choice=Null},Column[{Row[{phrase}],Pane[RadioButtonBar[Dynamic[choice],list,Appearance->"Vertical"],ImageSize->{Automatic,Automatic},Scrollbars->{False,True}],Button["OK",DialogReturn[choice]]}]]*)
(*If[(DirectoryQ[FileNameJoin[{NotebookDirectory[],"plots"}]]//ToString)=="False",CreateDirectory[FileNameJoin[{NotebookDirectory[],"plots"}]]]*)
(*(*List of implemented LLPs*)*)
(*LLPlist={"HNL","Scalar","DP","ALP-photon","ALP-fermion","ALP-gluon","B-L","B-3Le-Lmu+Ltau","B-Le-3Lmu+Ltau","B-3Lmu"};*)


(* ::Section::Closed:: *)
(*Constraints/sensitivities*)


(* ::Input:: *)
(*importformat["txt"]=importformat["dat"]="Table";*)
(*importformat["m"]=importformat["mx"]="MX";*)
(*importformat["xls"]="XLS";*)
(*Do[*)
(*dir=FileNameJoin[{NotebookDirectory[],"contours",LLP}];*)
(*If[DirectoryQ[dir],*)
(*filenames=FileNames[LLP<>"-excluded*",dir,Infinity];*)
(*ExcludedRegions[LLP]=Import[#,importformat[FileExtension[#]]]&/@FileNames[LLP<>"-excluded*",dir,Infinity];*)
(*];*)
(*If[!DirectoryQ[dir],*)
(*ExcludedRegions[LLP]={{{10.,10.}}};*)
(*]*)
(*,{LLP,Select[LLPlist,#!="DP"&]}]*)


(* ::Subsection::Closed:: *)
(*DP*)


(* ::Input:: *)
(*ConstraintsDPtemp=Import[FileNameJoin[{NotebookDirectory[],"contours/DP/constraints-DP.mx"}],"MX"];*)
(*ConstraintsTypeDP=ConstraintsDPtemp[[All,1]]*)
(*Do[*)
(*ExcludedRegions["DP",ConstraintsDPtemp[[i]][[1]]]=ConstraintsDPtemp[[i]][[2]];*)
(*,{i,1,Length[ConstraintsDPtemp],1}]*)


(* ::Chapter::Closed:: *)
(*HNL*)


(* ::Section::Closed:: *)
(*Importing sensitivities from other papers*)


(* ::Input:: *)
(*(*Importing contours with past experiments and some sensitivities*)*)
(*Seesaw=Table[{mN,5*10^-11/mN},{mN,0.01,90,0.1}];*)


(* ::Section::Closed:: *)
(*List of available sensitivities*)


(* ::Input:: *)
(*LLPdirName="HNL";*)
(*filenamesSensitivityTemp=FileNames["*.xls",FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName}],2]//Sort;*)
(*filenamesSensitivity=Table[Last@FileNameSplit@filenamesSensitivityTemp[[i]],{i,1,Length[filenamesSensitivityTemp],1}];*)
(*ParametersSensitivityTemp[i_]:=StringCases[filenamesSensitivity[[i]],"Sensitivity_"<>LLPdirName<>"_Pattern_"~~ue__~~"-"~~um__~~"-"~~ut__~~"_"~~type__~~"_at_"~~experiment__~~"_Nev="~~Nev__~~"_Npot="~~Npot__~~".xls":>{ue,um,ut,type,experiment,Nev,Npot}][[1]]*)
(*ParametersSensitivity=Table[ParametersSensitivityTemp[i],{i,1,Length[filenamesSensitivity],1}];*)
(*Print["List of available sensitivities:"]*)
(*rowexpl={{"\!\(\*FractionBox[SubscriptBox[SuperscriptBox[\(U\), \(2\)], \(e\)], SuperscriptBox[\(U\), \(2\)]]\)","\!\(\*FractionBox[SubscriptBox[SuperscriptBox[\(U\), \(2\)], \(\[Mu]\)], SuperscriptBox[\(U\), \(2\)]]\)","\!\(\*FractionBox[SubscriptBox[SuperscriptBox[\(U\), \(2\)], \(\[Tau]\)], SuperscriptBox[\(U\), \(2\)]]\)","Nature","Experiment","\!\(\*SubscriptBox[\(N\), \(ev, min\)]\)","\!\(\*SubscriptBox[\(N\), \(PoT\)]\)"}};*)
(*Join[rowexpl,ParametersSensitivity]//TableForm*)
(*Print["Selected sensitivities:"]*)
(*listSensitivities=selectionDialog[ParametersSensitivity,"{\!\(\*SubscriptBox[\(x\), \(e\)]\), \!\(\*SubscriptBox[\(x\), \(\[Mu]\)]\), \!\(\*SubscriptBox[\(x\), \(\[Tau]\)]\), Nature, Experiment, \!\(\*SubscriptBox[\(N\), \(ev, min\)]\), \!\(\*SubscriptBox[\(N\), \(PoT\)]\)}"];*)
(*Join[rowexpl,listSensitivities]//TableForm*)
(*SensitivitiesForPlot=Table[Import[FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName,listSensitivities[[i]][[5]],ToString@StringForm["Sensitivity_"<>LLPdirName<>"_Pattern_``-``-``_``_at_``_Nev=``_Npot=``.xls",Sequence@@listSensitivities[[i]]]}]],{i,1,Length[listSensitivities],1}];*)
(*dirplots=FileNameJoin[{NotebookDirectory[],"plots",LLPdirName}];*)
(*If[!DirectoryQ[dirplots],CreateDirectory[dirplots]]*)
(*{mminmaxoverall,couplingminmaxoverall}=MinMax[Join[##,1]&@@Table[MinMax[Flatten[SensitivitiesForPlot[[i]],1][[All,#]]],{i,1,Length[SensitivitiesForPlot]}]]&/@{1,2};*)
(*(*If the selected pattern coincides with pure e, mu, or tau mixings, the plot will also include the excluded region*)*)
(*pattern=listSensitivities[[All,{1,2,3}]][[1]]//ToExpression;*)
(*nature=listSensitivities[[All,4]][[1]];*)
(*ExcludedRegionsTemp[LLPdirName]=If[nature=="Majorana",If[pattern=={1,0,0},{Seesaw,ExcludedRegions[LLPdirName][[1]],ExcludedRegions[LLPdirName][[4]]},If[pattern=={0,1,0},{Seesaw,ExcludedRegions[LLPdirName][[2]],ExcludedRegions[LLPdirName][[5]]},If[pattern=={0,0,1},{Seesaw,ExcludedRegions[LLPdirName][[3]],ExcludedRegions[LLPdirName][[6]]},{Seesaw}]]],{Seesaw}];*)


(* ::Section::Closed:: *)
(*Plot*)


(* ::Input:: *)
(*LegendsForPlot=Table[Row[{listSensitivities[[i]][[5]],", \!\(\*SubscriptBox[\(N\), \(ev\)]\) \[GreaterEqual] ", listSensitivities[[i]][[6]]}],{i,1,Length[listSensitivities],1}];*)
(*ColorsForPlot={{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick, Black},{Thick,Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]},{Thick,Darker@Cyan,Dashing[0.02]},{Thick,Magenta,Dashing[0.02]},{Thick,Black,Dashing[0.02]}};*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsForPlot[[i]],If[MatrixQ[SensitivitiesForPlot[[i]]],1,Length@SensitivitiesForPlot[[i]]]],{i,1,Length[SensitivitiesForPlot],1}],1];*)
(*PlotSensitivityHNL=Show[ListLogLogPlot[Evaluate[ExcludedRegionsTemp[LLPdirName]],Joined->True,PlotStyle->{{Thick,Gray,Dashing[0.05]},{Thick,Gray},{Thick,Lighter@Gray}},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(N\)]\) [GeV]" , "\!\(\*SuperscriptBox[\(U\), \(2\)]\)"},FrameStyle->Directive[Black, 23],ImageSize->Large,PlotRange->{{1.01mminmaxoverall[[1]],1.1mminmaxoverall[[2]]},{0.05*couplingminmaxoverall[[1]],0.97couplingminmaxoverall[[2]]}},PlotLabel->Style[Row[{"HNLs. ", nature, " nature, pattern =", pattern}],16,Black],Filling->{1->{Bottom,Directive[Gray,Opacity[0.2]]},2->{True,Directive[Gray,Opacity[0.3]]},2->{Bottom,Directive[Lighter@Gray,Opacity[0.2]]}}],ListLogLogPlot[Cases[SensitivitiesForPlot,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist],Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelist],PlotLegends->Placed[Style[#,15]&/@LegendsForPlot,(*{0.24,0.14}*)Right]],Graphics[{Text[Style["Excluded",24,Black],Scaled[{0.5,0.9}]]}]]*)
(*Export[FileNameJoin[{dirplots,"Sensitivity_"<>LLPdirName<>".pdf"}],PlotSensitivityHNL]*)


(* ::Chapter::Closed:: *)
(*Scalar*)


(* ::Section:: *)
(*Importing constraints/sensitivities from other papers*)


(* ::Section::Closed:: *)
(*List of available sensitivities*)


(* ::Input:: *)
(*LLPdirName="Scalar";*)
(*SensitivityFolder=FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName}];*)
(*filenamesSensitivityTemp=FileNames["*.mx",SensitivityFolder,2];*)
(*filenamesSensitivity=Table[Last@FileNameSplit@filenamesSensitivityTemp[[i]],{i,1,Length[filenamesSensitivityTemp],1}];*)
(*ParametersSensitivityTemp[i_]:=StringCases[filenamesSensitivity[[i]],"Sensitivity_"<>LLPdirName<>"_at_"~~experiment__~~"_BrhToSS="~~BrhToSS__~~"_Nev="~~Nev__~~"_Npot="~~Npot__~~".mx":>{experiment,BrhToSS//ToExpression,Nev//ToExpression,Npot}][[1]]*)
(*ParametersSensitivity=Table[ParametersSensitivityTemp[i],{i,1,Length[filenamesSensitivity],1}];*)
(*Print["List of available sensitivities:"]*)
(*rowexpl={{"Experiment","Br(h->SS)","\!\(\*SubscriptBox[\(N\), \(ev, min\)]\)","\!\(\*SubscriptBox[\(N\), \(PoT\)]\)"}};*)
(*Join[rowexpl,ParametersSensitivity]//TableForm*)
(*Print["Selected sensitivities:"]*)
(*listSensitivities=selectionDialog[ParametersSensitivity,"{Experiment, \!\(\*SubscriptBox[\(Br\), \(h -> SS\)]\), \!\(\*SubscriptBox[\(N\), \(ev, min\)]\), \!\(\*SubscriptBox[\(N\), \(PoT\)]\)}"];*)
(*Join[rowexpl,listSensitivities]//TableForm*)
(*SensitivitiesForPlotTemp=Table[Import[FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName,listSensitivities[[i]][[1]],ToString@StringForm["Sensitivity_"<>LLPdirName<>"_at_``_BrhToSS=``_Nev=``_Npot=``.mx",Sequence@@listSensitivities[[i]]]}]],{i,1,Length[listSensitivities],1}];*)
(*bremBaseline=selectionDialog2[SensitivitiesForPlotTemp[[1]][[All,3]],"Select the baseline bremsstrahlung choice:"];*)
(*SensitivitiesForPlotBaselineTemp=Table[Select[SensitivitiesForPlotTemp[[i]],#[[3]]==bremBaseline&],{i,1,Length[SensitivitiesForPlotTemp]}];*)
(*SensitivitiesForPlotBaseline=SensitivitiesForPlotBaselineTemp[[All,1,-1]];*)
(*dirplots=FileNameJoin[{NotebookDirectory[],"plots",LLPdirName}];*)
(*If[!DirectoryQ[dirplots],CreateDirectory[dirplots]]*)
(*{mminmaxoverall,couplingminmaxoverall}=MinMax[Join[##,1]&@@Table[MinMax[Flatten[SensitivitiesForPlotBaseline[[i]],1][[All,#]]],{i,1,Length[SensitivitiesForPlotBaseline]}]]&/@{1,2};*)
(*(*Importing constraints*)*)
(*PlotRangeDomain={{0.025,5.3},{10^-13.,10^-4}};*)
(*PlotConstraintsTemp[phrase_]:=Show[ListLogLogPlot[Evaluate[ExcludedRegions[LLPdirName]],Joined->True,PlotStyle->{{Thick,Gray},{Thick,Gray},{Thick,Gray},{Thick,Lighter@Gray},{Thick,Gray}},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(S\)]\) [GeV]" , "\!\(\*SuperscriptBox[\(\[Theta]\), \(2\)]\)"},FrameStyle->Directive[Black, 23],ImageSize->Large,PlotRange->PlotRangeDomain,PlotLabel->Style[Row[{phrase}],18,Black],Filling->{1->{True,Directive[Gray,Opacity[0.3]]},2->{True,Directive[Gray,Opacity[0.3]]},3->{True,Directive[Gray,Opacity[0.3]]},4->{True,Directive[Gray,Opacity[0.1]]}}],Graphics[{Text[Style["Excluded",24,Black],Scaled[{0.25,0.95}]]}]]*)
(*PlotConstraintsTemp["Dark scalar"]*)


(* ::Section::Closed:: *)
(*Plots - baseline*)


(* ::Input:: *)
(*LegendsForPlot=Table[Row[{listSensitivities[[i]][[1]],", \!\(\*SubscriptBox[\(N\), \(ev\)]\) \[GreaterEqual] ", listSensitivities[[i]][[3]]}],{i,1,Length[listSensitivities],1}];*)
(*ColorsForPlot={{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick, Black},{Thick,Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]},{Thick,Darker@Cyan,Dashing[0.02]},{Thick,Magenta,Dashing[0.02]},{Thick,Black,Dashing[0.02]}};*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsForPlot[[i]],If[MatrixQ[SensitivitiesForPlotBaseline[[i]]],1,Length@SensitivitiesForPlotBaseline[[i]]]],{i,1,Length[SensitivitiesForPlotBaseline],1}],1];*)
(*PlotSensitivityScalar=Show[PlotConstraintsTemp["Dark scalar"],ListLogLogPlot[Cases[SensitivitiesForPlotBaseline,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist],Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelist],PlotLegends->Placed[Style[#,15]&/@LegendsForPlot,{0.3,0.14}(*Right*)]]]*)
(*Export[FileNameJoin[{dirplots,"Sensitivity_"<>LLPdirName<>".pdf"}],PlotSensitivityScalar]*)


(* ::Section::Closed:: *)
(*Plot - bremsstrahlung uncertainties (for dedicated experiments)*)


(* ::Input:: *)
(*counterval=1;*)
(*sensitivityExperiment//Clear;*)
(*Print["Selected experiment:"]*)
(*GivenExperiment=listSensitivities[[counterval]][[1]]*)
(*sensData=SensitivitiesForPlotTemp[[counterval]];*)
(*Print["Available bremsstrahlung descriptions:"]*)
(*bremVariants=sensData[[All,3]]*)
(*Do[*)
(*sensitivityExperiment[sensData[[i]][[3]]]=sensData[[i]][[-1]]*)
(*,{i,1,Length[sensData],1}]*)
(*sensitivitiesGivenExperiment=sensitivityExperiment[#]&/@bremVariants;*)
(*BremDescriptionUncertainty="AP";*)
(*ColorsBrem["Baseline"]={Thick,Darker@Red};*)
(*{lower,central,upper}=(BremDescriptionUncertainty<>"-"<>#<>"-mixing")&/@{"Lower","Central","Upper"};*)
(*ColorsBrem[central]={Thick,Blue};*)
(*ColorsBrem[lower]={Thick,Blue,Dashing[0.01]};*)
(*ColorsBrem[upper]={Thick,Blue,Dashing[0.01]};*)
(*(*Do[*)
(*PlotSens[bremvariant]=ListLogLogPlot[Cases[sensitivityExperiment[bremvariant],_?MatrixQ,All],Joined->True,PlotStyle->ColorsBrem[bremvariant]]*)
(*,{bremvariant,bremVariants}*)
(*]*)*)
(*PlotUncertainty[sensitivityExperiment_]:=Block[{},*)
(*Do[LenRegions[u]=Length[sensitivityExperiment[u]],{u,{upper,lower}}];*)
(*SensitivitiesToPlot=Join[Table[sensitivityExperiment[upper][[i]],{i,1,LenRegions[upper]}],Table[sensitivityExperiment[lower][[i]],{i,1,LenRegions[lower]}]];*)
(*FillingDirective=Join[Table[i->{True,Directive[Blue,Opacity[0.1]]},{i,1,LenRegions[upper],1}],Table[i+LenRegions[upper]->{True,Directive[White]},{i,1,LenRegions[lower],1}]];*)
(*ColorsDirective=Join[Table[ColorsBrem[upper],LenRegions[upper]],Table[ColorsBrem[lower],LenRegions[lower]]];*)
(*plot1=ListLogLogPlot[Evaluate[SensitivitiesToPlot],Joined->True,Filling->FillingDirective,PlotStyle->ColorsDirective,Frame->True,PlotRange->PlotRangeDomain,FrameStyle->Directive[Black, 23],ImageSize->Large,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(S\)]\) [GeV]" , "\!\(\*SuperscriptBox[\(\[Theta]\), \(2\)]\)"},PlotLabel->Style[Row[{GivenExperiment}],18,Black]];*)
(*plot2=PlotConstraintsTemp[GivenExperiment];*)
(*Show[plot1,plot2]*)
(*]*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsBrem[bremVariants[[i]]],If[MatrixQ[sensitivitiesGivenExperiment[[i]]],1,Length@sensitivitiesGivenExperiment[[i]]]],{i,1,Length[sensitivitiesGivenExperiment],1}],1];*)
(*(*For filling the uncertainty band*)*)
(*PlotSensitivityDP=Show[PlotUncertainty[sensitivityExperiment],ListLogLogPlot[Cases[sensitivitiesGivenExperiment,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist](*,plotUncertainty*)(*,Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelist],PlotLegends\[Rule]Placed[Style[#,15]&/@LegendsForPlot,(*{0.24,0.14}*)Right]]*)]*)
(**)


(* ::Chapter::Closed:: *)
(*DP*)


(* ::Section::Closed:: *)
(*Importing constraints/sensitivities*)


(* ::Input:: *)
(*{otherconstraint["NA62-dump-lepton"],otherconstraint["NuCal"],otherconstraint["CHARM-lepton"]}=Import[FileNameJoin[{NotebookDirectory[],"contours/DP/Particular constraints/",#}],"Table"]&/@{"DP_NA62-dump-with-brem-collaboration.txt","DP_NuCal_Tsai.txt","DP_CHARM_Tsai.txt"};*)
(*{legendotherconstraint["NA62-dump-lepton"],legendotherconstraint["NuCal"],legendotherconstraint["CHARM-lepton"]}={"2303.08666","1908.07525","1908.07525"};*)


(* ::Section::Closed:: *)
(*List of available sensitivities*)


(* ::Input:: *)
(*LLPdirName="DP";*)
(*filenamesSensitivityTemp=FileNames["*.mx",FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName}],2];*)
(*filenamesSensitivity=Table[Last@FileNameSplit@filenamesSensitivityTemp[[i]],{i,1,Length[filenamesSensitivityTemp],1}];*)
(*ParametersSensitivityTemp[i_]:=StringCases[filenamesSensitivity[[i]],"Sensitivity_"<>LLPdirName<>"_at_"~~experiment__~~"_Nev="~~Nev__~~"_Npot="~~Npot__~~".mx":>{experiment,Nev//ToExpression,Npot}][[1]]*)
(*ParametersSensitivity=Table[ParametersSensitivityTemp[i],{i,1,Length[filenamesSensitivity],1}];*)
(*Print["List of available sensitivities:"]*)
(*rowexpl={{"Experiment","\!\(\*SubscriptBox[\(N\), \(ev, min\)]\)","\!\(\*SubscriptBox[\(N\), \(PoT\)]\)"}};*)
(*Join[rowexpl,ParametersSensitivity]//TableForm*)
(*Print["Selected sensitivities:"]*)
(*listSensitivities=selectionDialog[ParametersSensitivity,"{Experiment, \!\(\*SubscriptBox[\(N\), \(ev, min\)]\), \!\(\*SubscriptBox[\(N\), \(PoT\)]\)}"];*)
(*Join[rowexpl,listSensitivities]//TableForm*)
(*SensitivitiesForPlotTemp=Table[Import[FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName,listSensitivities[[i]][[1]],ToString@StringForm["Sensitivity_"<>LLPdirName<>"_at_``_Nev=``_Npot=``.mx",Sequence@@listSensitivities[[i]]]}]],{i,1,Length[listSensitivities],1}];*)
(*bremBaseline=selectionDialog2[SensitivitiesForPlotTemp[[1]][[All,3]],"Select the baseline bremsstrahlung choice:"];*)
(*SensitivitiesForPlotBaselineTemp=Table[Select[SensitivitiesForPlotTemp[[i]],#[[3]]==bremBaseline&],{i,1,Length[SensitivitiesForPlotTemp]}];*)
(*SensitivitiesForPlotBaseline=SensitivitiesForPlotBaselineTemp[[All,1,-1]];*)
(*dirplots=FileNameJoin[{NotebookDirectory[],"plots",LLPdirName}];*)
(*If[!DirectoryQ[dirplots],CreateDirectory[dirplots]]*)
(*{mminmaxoverall,couplingminmaxoverall}=MinMax[Join[##,1]&@@Table[MinMax[Flatten[SensitivitiesForPlotBaseline[[i]],1][[All,#]]],{i,1,Length[SensitivitiesForPlotBaseline]}]]&/@{1,2};*)
(*(*Importing constraints*)*)
(*PlotRangeDomain={{0.025,5.02},{10^-19.,10^-4}};*)
(*PlotConstraintsTemp[phrase_,brem_, beamDumpPhrase_]:=Show[ListLogLogPlot[Evaluate[ExcludedRegions[LLPdirName,brem]],Joined->True,PlotStyle->{{Thick,Gray},{Thick,Gray},{Thick,Gray},{Thick,Gray},{Thick,Gray}},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(V\)]\) [GeV]" , "\!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\)"},FrameStyle->Directive[Black, 23],ImageSize->Large,PlotRange->PlotRangeDomain,PlotLabel->Style[Row[{phrase}],18,Black],Filling->{1->{True,Directive[Gray,Opacity[0.1]]},2->{True,Directive[Gray,Opacity[0.3]]},3->{True,Directive[Gray,Opacity[0.3]]},4->{True,Directive[Gray,Opacity[0.3]]}}],Graphics[{Text[Style["SN1987A",24,Black],Scaled[{0.14,0.1}]],Text[Style[beamDumpPhrase,24,Black],Scaled[{0.18,0.5}]],Text[Style["Prompt signatures",24,Black],Scaled[{0.25,0.95}]]}]]*)
(*PlotConstraintsTemp["Dark photon",bremBaseline];*)
(**)


(* ::Section::Closed:: *)
(*Plot - basic*)


(* ::Input:: *)
(*LegendsForPlot=Table[Row[{listSensitivities[[i]][[1]],", \!\(\*SubscriptBox[\(N\), \(ev\)]\) \[GreaterEqual] ",listSensitivities[[i]][[2]]}],{i,1,Length[listSensitivities],1}];*)
(*ColorsForPlot={{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick, Black},{Thick,Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]},{Thick,Darker@Cyan,Dashing[0.02]},{Thick,Magenta,Dashing[0.02]},{Thick,Black,Dashing[0.02]}};*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsForPlot[[i]],If[MatrixQ[SensitivitiesForPlotBaseline[[i]]],1,Length@SensitivitiesForPlotBaseline[[i]]]],{i,1,Length[SensitivitiesForPlotBaseline],1}],1];*)
(*PlotSensitivityDP=Show[PlotConstraintsTemp["Dark photon",bremBaseline,"Beam dump"],ListLogLogPlot[Cases[SensitivitiesForPlotBaseline,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist],Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelist],PlotLegends->Placed[Style[#,15]&/@LegendsForPlot,(*{0.24,0.14}*)Right]]]*)
(*Export[FileNameJoin[{dirplots,"Sensitivity_"<>LLPdirName<>".pdf"}],PlotSensitivityDP]*)


(* ::Section::Closed:: *)
(*Plot - bremsstrahlung uncertainties (for dedicated experiments)*)


(* ::Input:: *)
(*counterval=8;*)
(*sensitivityExperiment//Clear;*)
(*Print["Selected experiment:"]*)
(*GivenExperiment=listSensitivities[[counterval]][[1]]*)
(*sensData=SensitivitiesForPlotTemp[[counterval]];*)
(*Print["Available bremsstrahlung descriptions:"]*)
(*bremVariants=sensData[[All,3]]*)
(*Do[*)
(*sensitivityExperiment[sensData[[i]][[3]]]=sensData[[i]][[-1]]*)
(*,{i,1,Length[sensData],1}]*)
(*sensitivitiesGivenExperiment=sensitivityExperiment[#]&/@bremVariants;*)
(*BremDescriptionUncertainty="FR";*)
(*ColorsBrem["Baseline"]={Thick,Darker@Red};*)
(*{lower,central,upper}=(BremDescriptionUncertainty<>"-"<>#)&/@{"Lower","Central","Upper"};*)
(*ColorsBrem[central]={Thick,Blue};*)
(*ColorsBrem[lower]={Thick,Blue,Opacity[0.1]};*)
(*ColorsBrem[upper]={Thick,Blue,Opacity[0.1]};*)
(*(*Do[*)
(*PlotSens[bremvariant]=ListLogLogPlot[Cases[sensitivityExperiment[bremvariant],_?MatrixQ,All],Joined->True,PlotStyle->ColorsBrem[bremvariant]]*)
(*,{bremvariant,bremVariants}*)
(*]*)*)
(*PlotUncertainty[sensitivityExperiment_]:=Block[{},*)
(*Do[LenRegions[u]=Length[sensitivityExperiment[u]],{u,{upper,lower}}];*)
(*SensitivitiesToPlot=Join[Table[sensitivityExperiment[upper][[i]],{i,1,LenRegions[upper]}],Table[sensitivityExperiment[lower][[i]],{i,1,LenRegions[lower]}]];*)
(*FillingDirective=Join[Table[i->{True,Directive[Blue,Opacity[0.1]]},{i,1,LenRegions[upper],1}],Table[i+LenRegions[upper]->{True,Directive[White]},{i,1,LenRegions[lower],1}]];*)
(*ColorsDirective=Join[Table[ColorsBrem[upper],LenRegions[upper]],Table[ColorsBrem[lower],LenRegions[lower]]];*)
(*plot1=ListLogLogPlot[Evaluate[SensitivitiesToPlot],Joined->True,Filling->FillingDirective,PlotStyle->ColorsDirective,Frame->True,PlotRange->PlotRangeDomain,FrameStyle->Directive[Black, 23],ImageSize->Large,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(V\)]\) [GeV]" , "\!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\)"},PlotLabel->Style[Row[{GivenExperiment}],18,Black]];*)
(*plot2=PlotConstraintsTemp[GivenExperiment,"No brem","e beam dumps"];*)
(*Show[plot1,plot2]*)
(*]*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsBrem[bremVariants[[i]]],If[MatrixQ[sensitivitiesGivenExperiment[[i]]],1,Length@sensitivitiesGivenExperiment[[i]]]],{i,1,Length[sensitivitiesGivenExperiment],1}],1];*)
(*(*For filling the uncertainty band*)*)
(*If[Length[otherconstraint[GivenExperiment][[1]]]>0,*)
(*PlotSensitivityDP=Show[PlotUncertainty[sensitivityExperiment],ListLogLogPlot[otherconstraint[GivenExperiment],Joined->True,PlotStyle->{{Darker@Green,Dashing[0.01]}},PlotLegends->Placed[Style[#,15]&/@{legendotherconstraint[GivenExperiment]},{0.83,0.1}]],ListLogLogPlot[Cases[sensitivitiesGivenExperiment,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist]],PlotSensitivityDP=Show[PlotUncertainty[sensitivityExperiment],ListLogLogPlot[Cases[sensitivitiesGivenExperiment,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist]]*)
(*]*)
(*Export[FileNameJoin[{NotebookDirectory[],"plots/DP/Uncertainties/Brem_"<>GivenExperiment<>".pdf"}],PlotSensitivityDP]*)
(**)


(* ::Section::Closed:: *)
(*Plot - bremsstrahlung uncertainties (overall; include NuCal and NA62-dump-lepton constraints!!)*)


(* ::Input:: *)
(*experimentsPast={"BEBC","NuCal","CHARM-lepton"};*)
(*experimentsNA62lepton={"NA62-dump-lepton"};*)
(*experimentsFuture={"SHiP-ECN3","FACET","FASER2-FPF","NA62-dump","DarkQuest-phase-1","LHCb-Downstream"};*)
(*senslisttemp=Table[{listSensitivities[[i]][[1]],SensitivitiesForPlotTemp[[i]]},{i,1,Length[listSensitivities],1}];*)
(*senslistPastAll=Select[senslisttemp,MemberQ[experimentsPast,#[[1]]]&];*)
(*{senslistPast["Lower"],senslistPast["Upper"]}=Table[Select[Flatten[senslistPastAll[[All,2]],1],#[[3]]==list&][[All,4]],{list,{"FR-Lower","FR-Upper"}}];*)
(*senslistNA62leptonAll=Select[senslisttemp,MemberQ[experimentsNA62lepton,#[[1]]]&];*)
(*{senslistNA62lepton["Lower"],senslistNA62lepton["Upper"]}=Table[Select[Flatten[senslistNA62leptonAll[[All,2]],1],#[[3]]==list&][[All,4]],{list,{"FR-Lower","FR-Upper"}}];*)
(*senslistFutureAll=Select[senslisttemp,MemberQ[experimentsFuture,#[[1]]]&];*)
(*{senslistFuture["Lower"],senslistFuture["Upper"]}=Table[Select[Flatten[senslistFutureAll[[All,2]],1],#[[3]]==list&][[All,4]],{list,{"FR-Lower","FR-Upper"}}];*)
(*ColorsForPlot={{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick, Black},{Thick,Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]},{Thick,Darker@Cyan,Dashing[0.02]},{Thick,Magenta,Dashing[0.02]},{Thick,Black,Dashing[0.02]}};*)
(*{plotstylelistFuture["Lower"],plotstylelistFuture["Upper"]}=Table[Flatten[Table[ConstantArray[ColorsForPlot[[i]],If[MatrixQ[list[[i]]],1,Length@list[[i]]]],{i,1,Length[list],1}],1],{list,{senslistFuture["Lower"],senslistFuture["Upper"]}}];*)
(*PlotConstraintsTemp1[phrase_]:=Show[ListLogLogPlot[Evaluate[ExcludedRegions[LLPdirName]],Joined->True,PlotStyle->{{Thick,Gray},{Thick,Gray},{Thick,Gray},{Thick,Lighter@Gray},{Thick,Gray}},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(V\)]\) [GeV]" , "\!\(\*SuperscriptBox[\(\[Epsilon]\), \(2\)]\)"},FrameStyle->Directive[Black, 23],ImageSize->Large,PlotRange->PlotRangeDomain,PlotLabel->Style[Row[{phrase}],18,Black],Filling->{1->{True,Directive[Gray,Opacity[0.3]]},2->{True,Directive[Gray,Opacity[0.3]]},3->{True,Directive[Gray,Opacity[0.3]]},4->{True,Directive[Gray,Opacity[0.1]]}}],Graphics[{Text[Style["Excluded",24,Black],Scaled[{0.25,0.95}]]}]]*)
(*plotOverall["Lower"]=Show[PlotConstraintsTemp["Lower bound of bremsstrahlung","FR-Lower", "Beam dump"],ListLogLogPlot[Cases[senslistNA62lepton["Lower"],_?MatrixQ,All],Joined->True,PlotStyle->{{Thick,Black,Dashing[0.02]}},Filling->Table[{i->{True,Directive[Lighter@Gray,Opacity[0.1]]}},{i,1,20,1}]],ListLogLogPlot[Cases[senslistFuture["Lower"],_?MatrixQ,All],Joined->True,PlotStyle->plotstylelistFuture["Lower"]],Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelistFuture["Lower"]],PlotLegends->Placed[Style[#,15]&/@senslistFutureAll[[All,1]],{0.81,0.67}(*Right*)]]];*)
(*plotOverall["Upper"]=Show[PlotConstraintsTemp["Upper bound of bremsstrahlung","FR-Upper", "Beam dump"],ListLogLogPlot[Cases[senslistNA62lepton["Upper"],_?MatrixQ,All],Joined->True,PlotStyle->{{Thick,Black,Dashing[0.02]}},Filling->Table[{i->{True,Directive[Lighter@Gray,Opacity[0.1]]}},{i,1,20,1}]],ListLogLogPlot[Cases[senslistFuture["Upper"],_?MatrixQ,All],Joined->True,PlotStyle->plotstylelistFuture["Upper"]],Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelistFuture["Upper"]],PlotLegends->Placed[Style[#,15]&/@senslistFutureAll[[All,1]],{0.81,0.67}(*Right*)]]];*)
(*Style[Row[plotOverall[#]&/@{"Lower","Upper"}]]*)
(*Export[FileNameJoin[{NotebookDirectory[],"plots/DP/Uncertainties/Summary-Brem-"<>#<>".pdf"}],plotOverall[#]]&/@{"Lower","Upper"};*)


(* ::Chapter::Closed:: *)
(*ALP-photon*)


(* ::Section:: *)
(*Importing constraints/sensitivities*)


(* ::Section::Closed:: *)
(*List of available sensitivities*)


(* ::Input:: *)
(*LLPdirName="ALP-photon";*)
(*filenamesSensitivityTemp=FileNames["*.xls",FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName}],2];*)
(*filenamesSensitivity=Table[Last@FileNameSplit@filenamesSensitivityTemp[[i]],{i,1,Length[filenamesSensitivityTemp],1}];*)
(*ParametersSensitivityTemp[i_]:=StringCases[filenamesSensitivity[[i]],"Sensitivity_"<>LLPdirName<>"_at_"~~experiment__~~"_Nev="~~Nev__~~"_Npot="~~Npot__~~".xls":>{experiment,Nev//ToExpression,Npot}][[1]]*)
(*ParametersSensitivity=Table[ParametersSensitivityTemp[i],{i,1,Length[filenamesSensitivity],1}];*)
(*Print["List of available sensitivities:"]*)
(*rowexpl={{"Experiment","\!\(\*SubscriptBox[\(N\), \(ev, min\)]\)","\!\(\*SubscriptBox[\(N\), \(PoT\)]\)"}};*)
(*Join[rowexpl,ParametersSensitivity]//TableForm*)
(*listSensitivities=selectionDialog[ParametersSensitivity,"{Experiment, \!\(\*SubscriptBox[\(N\), \(ev, min\)]\), \!\(\*SubscriptBox[\(N\), \(PoT\)]\)}"];*)
(*Print["Selected sensitivities:"]*)
(*Join[rowexpl,listSensitivities]//TableForm*)
(*SensitivitiesForPlot=Table[Import[FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName,listSensitivities[[i]][[1]],ToString@StringForm["Sensitivity_"<>LLPdirName<>"_at_``_Nev=``_Npot=``.xls",Sequence@@listSensitivities[[i]]]}]],{i,1,Length[listSensitivities],1}];*)
(*dirplots=FileNameJoin[{NotebookDirectory[],"plots",LLPdirName}];*)
(*If[!DirectoryQ[dirplots],CreateDirectory[dirplots]]*)
(**)


(* ::Section::Closed:: *)
(*Plot*)


(* ::Input:: *)
(*{mminmaxoverall,couplingminmaxoverall}=MinMax[Join[##,1]&@@Table[MinMax[Flatten[SensitivitiesForPlot[[i]],1][[All,#]]],{i,1,Length[SensitivitiesForPlot]}]]&/@{1,2};*)
(*LegendsForPlot=Table[Row[{listSensitivities[[i]][[1]],", \!\(\*SubscriptBox[\(N\), \(ev\)]\) \[GreaterEqual] ", listSensitivities[[i]][[2]]}],{i,1,Length[listSensitivities],1}];*)
(*ColorsForPlot={{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick, Black},{Thick,Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]},{Thick,Darker@Cyan,Dashing[0.02]},{Thick,Magenta,Dashing[0.02]},{Thick,Black,Dashing[0.02]}};*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsForPlot[[i]],If[MatrixQ[SensitivitiesForPlot[[i]]],1,Length@SensitivitiesForPlot[[i]]]],{i,1,Length[SensitivitiesForPlot],1}],1];*)
(*PlotSensitivityALPphoton=Show[ListLogLogPlot[Evaluate[ExcludedRegions[LLPdirName]],Joined->True,PlotStyle->{{Thick,Gray}},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(a\)]\) [GeV]" , "\!\(\*SubscriptBox[\(g\), \(a\)]\) [\!\(\*SuperscriptBox[\(GeV\), \(-1\)]\)]"},FrameStyle->Directive[Black, 23],ImageSize->Large,PlotRange->{{1.01mminmaxoverall[[1]],1.1mminmaxoverall[[2]]},{0.05*couplingminmaxoverall[[1]],0.99couplingminmaxoverall[[2]]}},PlotLabel->Style[Row[{"ALPs coupled to photons"}],18,Black],Filling->{1->{True,Directive[Gray,Opacity[0.3]]}}],ListLogLogPlot[Cases[SensitivitiesForPlot,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist],Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelist],PlotLegends->Placed[Style[#,15]&/@LegendsForPlot,(*{0.24,0.14}*)Right]],Graphics[{Text[Style["Excluded",24,Black],Scaled[{0.2,0.5}]]}]]*)
(*Export[FileNameJoin[{dirplots,"Sensitivity_"<>LLPdirName<>".pdf"}],PlotSensitivityALPphoton]*)
(**)


(* ::Chapter::Closed:: *)
(*ALP-fermion*)


(* ::Section:: *)
(*Importing constraints/sensitivities from other papers*)


(* ::Section::Closed:: *)
(*List of available sensitivities*)


(* ::Input:: *)
(*LLPdirName="ALP-fermion";*)
(*filenamesSensitivityTemp=FileNames["*.xls",FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName}],2];*)
(*filenamesSensitivity=Table[Last@FileNameSplit@filenamesSensitivityTemp[[i]],{i,1,Length[filenamesSensitivityTemp],1}];*)
(*ParametersSensitivityTemp[i_]:=StringCases[filenamesSensitivity[[i]],"Sensitivity_"<>LLPdirName<>"_at_"~~experiment__~~"_Nev="~~Nev__~~"_Npot="~~Npot__~~".xls":>{experiment,Nev//ToExpression,Npot}][[1]]*)
(*ParametersSensitivity=Table[ParametersSensitivityTemp[i],{i,1,Length[filenamesSensitivity],1}];*)
(*Print["List of available sensitivities:"]*)
(*rowexpl={{"Experiment","\!\(\*SubscriptBox[\(N\), \(ev, min\)]\)","\!\(\*SubscriptBox[\(N\), \(Pot\)]\)"}};*)
(*Join[rowexpl,ParametersSensitivity]//TableForm*)
(*listSensitivities=selectionDialog[ParametersSensitivity,"{Experiment, \!\(\*SubscriptBox[\(N\), \(ev, min\)]\), \!\(\*SubscriptBox[\(N\), \(PoT\)]\)}"];*)
(*Print["Selected sensitivities:"]*)
(*Join[rowexpl,listSensitivities]//TableForm*)
(*SensitivitiesForPlot=Table[Import[FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName,listSensitivities[[i]][[1]],ToString@StringForm["Sensitivity_"<>LLPdirName<>"_at_``_Nev=``_Npot=``.xls",Sequence@@listSensitivities[[i]]]}]],{i,1,Length[listSensitivities],1}];*)
(*dirplots=FileNameJoin[{NotebookDirectory[],"plots",LLPdirName}];*)
(*If[!DirectoryQ[dirplots],CreateDirectory[dirplots]]*)
(*{mminmaxoverall,couplingminmaxoverall}=MinMax[Join[##,1]&@@Table[MinMax[Flatten[SensitivitiesForPlot[[i]],1][[All,#]]],{i,1,Length[SensitivitiesForPlot]}]]&/@{1,2};*)
(**)


(* ::Section::Closed:: *)
(*Plot*)


(* ::Input:: *)
(*LegendsForPlot=Table[Row[{listSensitivities[[i]][[1]],", \!\(\*SubscriptBox[\(N\), \(ev\)]\) \[GreaterEqual] ",listSensitivities[[i]][[2]]}],{i,1,Length[listSensitivities],1}];*)
(*ColorsForPlot={{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick, Black},{Thick,Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]},{Thick,Darker@Cyan,Dashing[0.02]},{Thick,Magenta,Dashing[0.02]},{Thick,Black,Dashing[0.02]}};*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsForPlot[[i]],If[MatrixQ[SensitivitiesForPlot[[i]]],1,Length@SensitivitiesForPlot[[i]]]],{i,1,Length[SensitivitiesForPlot],1}],1];*)
(*PlotSensitivityALPfermion=Show[ListLogLogPlot[Evaluate[Cases[ExcludedRegions[LLPdirName],_?MatrixQ,All]],Joined->True,PlotStyle->{{Thick,Gray}},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(a\)]\) [GeV]" , "\!\(\*SubscriptBox[\(g\), \(Y\)]\) = 2\!\(\*SubscriptBox[\(v\), \(h\)]\)/\!\(\*SubscriptBox[\(f\), \(a\)]\)"},FrameStyle->Directive[Black, 23],ImageSize->Large,PlotRange->{{1.01mminmaxoverall[[1]],1.1mminmaxoverall[[2]]},{0.05*couplingminmaxoverall[[1]],0.99couplingminmaxoverall[[2]]}},PlotLabel->Style[Row[{"ALPs coupled to fermions"}],18,Black],Filling->Table[i->{True,Directive[Gray,Opacity[0.3]]},{i,1,20,1}]],ListLogLogPlot[Cases[SensitivitiesForPlot,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist],Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelist],PlotLegends->Placed[Style[#,15]&/@LegendsForPlot,(*{0.24,0.14}*)Right]],Graphics[{Text[Style["Excluded",24,Black],Scaled[{0.75,0.94}]]}]]*)
(*Export[FileNameJoin[{dirplots,"Sensitivity_"<>LLPdirName<>".pdf"}],PlotSensitivityALPfermion]*)


(* ::Chapter::Closed:: *)
(*ALP-gluon*)


(* ::Section:: *)
(*Importing constraints and sensitivities from other studies*)


(* ::Section::Closed:: *)
(*List of available sensitivities*)


(* ::Input:: *)
(*LLPdirName="ALP-gluon";*)
(*filenamesSensitivityTemp=FileNames["*.xls",FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName}],2];*)
(*filenamesSensitivity=Table[Last@FileNameSplit@filenamesSensitivityTemp[[i]],{i,1,Length[filenamesSensitivityTemp],1}];*)
(*ParametersSensitivityTemp[i_]:=StringCases[filenamesSensitivity[[i]],"Sensitivity_"<>LLPdirName<>"_at_"~~experiment__~~"_Nev="~~Nev__~~"_Npot="~~Npot__~~".xls":>{experiment,Nev//ToExpression,Npot}][[1]]*)
(*ParametersSensitivity=Table[ParametersSensitivityTemp[i],{i,1,Length[filenamesSensitivity],1}];*)
(*Print["List of available sensitivities:"]*)
(*rowexpl={{"Experiment","\!\(\*SubscriptBox[\(N\), \(ev, min\)]\)","\!\(\*SubscriptBox[\(N\), \(PoT\)]\)"}};*)
(*Join[rowexpl,ParametersSensitivity]//TableForm*)
(*Print["Selected sensitivities:"]*)
(*listSensitivities=selectionDialog[ParametersSensitivity,"{Experiment, \!\(\*SubscriptBox[\(N\), \(ev, min\)]\), \!\(\*SubscriptBox[\(N\), \(PoT\)]\)}"];*)
(*SensitivitiesForPlot=Table[Import[FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName,listSensitivities[[i]][[1]],ToString@StringForm["Sensitivity_"<>LLPdirName<>"_at_``_Nev=``_Npot=``.xls",Sequence@@listSensitivities[[i]]]}]],{i,1,Length[listSensitivities],1}];*)
(*dirplots=FileNameJoin[{NotebookDirectory[],"plots",LLPdirName}];*)
(*If[!DirectoryQ[dirplots],CreateDirectory[dirplots]]*)
(*Join[rowexpl,listSensitivities]//TableForm*)
(**)


(* ::Section::Closed:: *)
(*Plot*)


(* ::Input:: *)
(*{mminmaxoverall,couplingminmaxoverall}=MinMax[Join[##,1]&@@Table[MinMax[Flatten[SensitivitiesForPlot[[i]],1][[All,#]]],{i,1,Length[SensitivitiesForPlot]}]]&/@{1,2};*)
(*LegendsForPlot=Table[Row[{listSensitivities[[i]][[1]],", \!\(\*SubscriptBox[\(N\), \(ev\)]\) \[GreaterEqual] ", listSensitivities[[i]][[2]]}],{i,1,Length[listSensitivities],1}];*)
(*ColorsForPlot={{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick, Black},{Thick,Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]},{Thick,Darker@Cyan,Dashing[0.02]},{Thick,Magenta,Dashing[0.02]},{Thick,Black,Dashing[0.02]}};*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsForPlot[[i]],If[MatrixQ[SensitivitiesForPlot[[i]]],1,Length@SensitivitiesForPlot[[i]]]],{i,1,Length[SensitivitiesForPlot],1}],1];*)
(*PlotSensitivityALPgluon=Show[ListLogLogPlot[Evaluate[ExcludedRegions[LLPdirName][[1]]],Joined->True,PlotStyle->{{Thick,Gray}},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(a\)]\) [GeV]" , "\!\(\*SubscriptBox[\(f\), \(G\)]\) [\!\(\*SuperscriptBox[\(GeV\), \(-1\)]\)]"},FrameStyle->Directive[Black, 23],ImageSize->Large,PlotRange->{{Max[1.01mminmaxoverall[[1]]],1.1mminmaxoverall[[2]]},{0.05*couplingminmaxoverall[[1]],0.99couplingminmaxoverall[[2]]}},PlotLabel->Style[Row[{"ALPs coupled to gluons"}],18,Black],Filling->{1->{True,Directive[Gray,Opacity[0.3]]},2->{True,Directive[Gray,Opacity[0.3]]},3->{True,Directive[Gray,Opacity[0.3]]},4->{True,Directive[Gray,Opacity[0.3]]}}],ListLogLogPlot[Cases[SensitivitiesForPlot,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist],Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelist],PlotLegends->Placed[Style[#,15]&/@LegendsForPlot,(*{0.24,0.14}*)Right]],Graphics[{Text[Style["Excluded",24,Black],Scaled[{0.15,0.7}]]}]]*)
(*Export[FileNameJoin[{dirplots,"Sensitivity_"<>LLPdirName<>".pdf"}],PlotSensitivityALPgluon]*)


(* ::Input:: *)
(*3*ArcSin[0.02/0.3]*)


(* ::Chapter::Closed:: *)
(*B mediators*)


(* ::Section::Closed:: *)
(*List of available sensitivities*)


(* ::Input:: *)
(*LLPdirName=dropdownDialog[{"B-L","B-3Lmu","B-3Le-Lmu+Ltau","B-Le-3Lmu+Ltau"},"Select the type of the mediator:"]*)
(*filenamesSensitivityTemp=FileNames["*.mx",FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName}],2];*)
(*filenamesSensitivity=Table[Last@FileNameSplit@filenamesSensitivityTemp[[i]],{i,1,Length[filenamesSensitivityTemp],1}];*)
(*ParametersSensitivityTemp[i_]:=StringCases[filenamesSensitivity[[i]],"Sensitivity_"<>LLPdirName<>"_at_"~~experiment__~~"_Nev="~~Nev__~~"_Npot="~~Npot__~~".mx":>{experiment,Nev//ToExpression,Npot}][[1]]*)
(*ParametersSensitivity=Table[ParametersSensitivityTemp[i],{i,1,Length[filenamesSensitivity],1}];*)
(*Print["List of available sensitivities:"]*)
(*rowexpl={{"Experiment","\!\(\*SubscriptBox[\(N\), \(ev, min\)]\)","\!\(\*SubscriptBox[\(N\), \(PoT\)]\)"}};*)
(*Join[rowexpl,ParametersSensitivity]//TableForm*)
(*Print["Selected sensitivities:"]*)
(*listSensitivities=selectionDialog[ParametersSensitivity,"{Experiment, \!\(\*SubscriptBox[\(N\), \(ev, min\)]\), \!\(\*SubscriptBox[\(N\), \(PoT\)]\)}"];*)
(*Join[rowexpl,listSensitivities]//TableForm*)
(*SensitivitiesForPlotTemp=Table[Import[FileNameJoin[{NotebookDirectory[],"Sensitivity domains",LLPdirName,listSensitivities[[i]][[1]],ToString@StringForm["Sensitivity_"<>LLPdirName<>"_at_``_Nev=``_Npot=``.mx",Sequence@@listSensitivities[[i]]]}]],{i,1,Length[listSensitivities],1}];*)
(*bremBaseline=selectionDialog2[SensitivitiesForPlotTemp[[1]][[All,3]],"Select the baseline bremsstrahlung choice:"];*)
(*SensitivitiesForPlotBaselineTemp=Table[Select[SensitivitiesForPlotTemp[[i]],#[[3]]==bremBaseline&],{i,1,Length[SensitivitiesForPlotTemp]}];*)
(*SensitivitiesForPlotBaseline=SensitivitiesForPlotBaselineTemp[[All,1,-1]];*)
(*dirplots=FileNameJoin[{NotebookDirectory[],"plots",LLPdirName}];*)
(*If[!DirectoryQ[dirplots],CreateDirectory[dirplots]]*)
(*{mminmaxoverall,couplingminmaxoverall}=MinMax[Join[##,1]&@@Table[MinMax[Flatten[SensitivitiesForPlotBaseline[[i]],1][[All,#]]],{i,1,Length[SensitivitiesForPlotBaseline]}]]&/@{1,2};*)
(*(*Importing constraints*)*)
(*PlotRangeDomain={{0.025,5.02},{10^-21.,10^-6}};*)
(*If[LLPdirName=="B-L",*)
(*PlotConstraintsTemp[phrase_]:=Show[ListLogLogPlot[Evaluate[ExcludedRegions[LLPdirName]],Joined->True,PlotStyle->{{Thick,Gray},{Thick,Gray},{Thick,Gray},{Thick,Lighter@Gray},{Thick,Gray}},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(V\)]\) [GeV]" , "\!\(\*SubscriptBox[\(\[Alpha]\), \(B\)]\)"},FrameStyle->Directive[Black, 23],ImageSize->Large,PlotRange->PlotRangeDomain,PlotLabel->Style[Row[{phrase}],18,Black],Filling->{1->{True,Directive[Gray,Opacity[0.3]]},2->{True,Directive[Gray,Opacity[0.3]]},3->{True,Directive[Gray,Opacity[0.3]]},4->{True,Directive[Gray,Opacity[0.1]]}}],Graphics[{Text[Style["Excluded",24,Black],Scaled[{0.25,0.95}]]}]]*)
(*,*)
(*PlotConstraintsTemp[phrase_]:=Show[ListLogLogPlot[Table[{x,10^5},{x,0.01,100,1}],Joined->True,PlotStyle->{{Thick,Gray},{Thick,Gray},{Thick,Gray},{Thick,Lighter@Gray},{Thick,Gray}},Frame-> True,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(V\)]\) [GeV]" , "\!\(\*SubscriptBox[\(\[Alpha]\), \(B\)]\)"},FrameStyle->Directive[Black, 23],ImageSize->Large,PlotRange->PlotRangeDomain,PlotLabel->Style[Row[{phrase}],18,Black],Filling->{1->{True,Directive[Gray,Opacity[0.3]]},2->{True,Directive[Gray,Opacity[0.3]]},3->{True,Directive[Gray,Opacity[0.3]]},4->{True,Directive[Gray,Opacity[0.1]]}}],Graphics[{Text[Style["Excluded",24,Black],Scaled[{0.25,0.95}]]}]]*)
(*]*)
(*PlotConstraintsTemp[LLPdirName];*)
(**)


(* ::Section::Closed:: *)
(*Plot - baseline*)


(* ::Input:: *)
(*LegendsForPlot=Table[Row[{listSensitivities[[i]][[1]],", \!\(\*SubscriptBox[\(N\), \(ev\)]\) \[GreaterEqual] ",listSensitivities[[i]][[2]]}],{i,1,Length[listSensitivities],1}];*)
(*ColorsForPlot={{Thick,Blue},{Thick,Darker@Red},{Thick,Darker@Darker@Green},{Thick,Darker@Cyan},{Thick,Magenta},{Thick, Black},{Thick,Blue,Dashing[0.02]},{Thick,Darker@Red,Dashing[0.02]},{Thick,Darker@Darker@Green,Dashing[0.02]},{Thick,Darker@Cyan,Dashing[0.02]},{Thick,Magenta,Dashing[0.02]},{Thick,Black,Dashing[0.02]}};*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsForPlot[[i]],If[MatrixQ[SensitivitiesForPlotBaseline[[i]]],1,Length@SensitivitiesForPlotBaseline[[i]]]],{i,1,Length[SensitivitiesForPlotBaseline],1}],1];*)
(*PlotSensitivityDP=Show[PlotConstraintsTemp[LLPdirName],ListLogLogPlot[Cases[SensitivitiesForPlotBaseline,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist],Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelist],PlotLegends->Placed[Style[#,15]&/@LegendsForPlot,(*{0.24,0.14}*)Right]]]*)
(*Export[FileNameJoin[{dirplots,"Sensitivity_"<>LLPdirName<>".pdf"}],PlotSensitivityDP]*)


(* ::Section::Closed:: *)
(*Plot - bremsstrahlung uncertainties (for dedicated experiments)*)


(* ::Input:: *)
(*counterval=1;*)
(*sensitivityExperiment//Clear;*)
(*Print["Selected experiment:"]*)
(*GivenExperiment=listSensitivities[[counterval]][[1]]*)
(*sensData=SensitivitiesForPlotTemp[[counterval]];*)
(*Print["Available bremsstrahlung descriptions:"]*)
(*bremVariants=sensData[[All,3]]*)
(*Do[*)
(*sensitivityExperiment[sensData[[i]][[3]]]=sensData[[i]][[-1]]*)
(*,{i,1,Length[sensData],1}]*)
(*sensitivitiesGivenExperiment=sensitivityExperiment[#]&/@bremVariants;*)
(*BremDescriptionUncertainty="AP";*)
(*ColorsBrem["Baseline"]={Thick,Darker@Red};*)
(*{lower,central,upper}=(BremDescriptionUncertainty<>"-"<>#)&/@{"Lower","Central","Upper"};*)
(*ColorsBrem[central]={Thick,Blue};*)
(*ColorsBrem[lower]={Thick,Blue,Dashing[0.01]};*)
(*ColorsBrem[upper]={Thick,Blue,Dashing[0.01]};*)
(*(*Do[*)
(*PlotSens[bremvariant]=ListLogLogPlot[Cases[sensitivityExperiment[bremvariant],_?MatrixQ,All],Joined->True,PlotStyle->ColorsBrem[bremvariant]]*)
(*,{bremvariant,bremVariants}*)
(*]*)*)
(*PlotUncertainty[sensitivityExperiment_]:=Block[{},*)
(*Do[LenRegions[u]=Length[sensitivityExperiment[u]],{u,{upper,lower}}];*)
(*SensitivitiesToPlot=Join[Table[sensitivityExperiment[upper][[i]],{i,1,LenRegions[upper]}],Table[sensitivityExperiment[lower][[i]],{i,1,LenRegions[lower]}]];*)
(*FillingDirective=Join[Table[i->{True,Directive[Blue,Opacity[0.1]]},{i,1,LenRegions[upper],1}],Table[i+LenRegions[upper]->{True,Directive[White]},{i,1,LenRegions[lower],1}]];*)
(*ColorsDirective=Join[Table[ColorsBrem[upper],LenRegions[upper]],Table[ColorsBrem[lower],LenRegions[lower]]];*)
(*plot1=ListLogLogPlot[Evaluate[SensitivitiesToPlot],Joined->True,Filling->FillingDirective,PlotStyle->ColorsDirective,Frame->True,PlotRange->PlotRangeDomain,FrameStyle->Directive[Black, 23],ImageSize->Large,FrameLabel->{"\!\(\*SubscriptBox[\(m\), \(V\)]\) [GeV]" , "\!\(\*SubscriptBox[\(\[Alpha]\), \(B\)]\)"},PlotLabel->Style[Row[{GivenExperiment}],18,Black]];*)
(*If[LLPdirName=="B-L",*)
(*plot2=PlotConstraintsTemp[GivenExperiment];*)
(*pt3=Show[plot1,plot2]*)
(*,*)
(*plot1*)
(*]*)
(*]*)
(*plotstylelist=Flatten[Table[ConstantArray[ColorsBrem[bremVariants[[i]]],If[MatrixQ[sensitivitiesGivenExperiment[[i]]],1,Length@sensitivitiesGivenExperiment[[i]]]],{i,1,Length[sensitivitiesGivenExperiment],1}],1];*)
(*(*For filling the uncertainty band*)*)
(*PlotSensitivityDP=Show[PlotUncertainty[sensitivityExperiment],ListLogLogPlot[Cases[sensitivitiesGivenExperiment,_?MatrixQ,All],Joined->True,PlotStyle->plotstylelist](*,plotUncertainty*)(*,Plot[{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},{x,0,1},PlotStyle->DeleteDuplicates[plotstylelist],PlotLegends\[Rule]Placed[Style[#,15]&/@LegendsForPlot,(*{0.24,0.14}*)Right]]*)]*)
(**)


(* ::Title::Closed:: *)
(*Deleting generated cells*)


(* ::Input:: *)
(*FrontEndTokenExecute["DeleteGeneratedCells"];*)
(*FrontEndTokenExecute["SelectAll"];*)
(*FrontEndTokenExecute["SelectionCloseAllGroups"];*)
