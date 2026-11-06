$HistoryLength=0;$CharacterEncoding="ASCII";
{root,out}=Take[$CommandLine,-2];
If[!DirectoryQ[out],CreateDirectory[out,CreateIntermediateDirectories->True]];
Needs["CCompilerDriver`"];
CCompilerDriver`$CCompilerInternalDirectory=FileNameJoin[{out,"compile"}];
cells[f_]:=Cases[ToExpression[Import[FileNameJoin[{root,f}],"Text"],InputForm,HoldComplete],Cell[BoxData[b_],"Input",___]:>HoldComplete[b],Infinity];
ev[f_,ii_]:=Block[{NotebookDirectory=Function[{},DirectoryName[FileNameJoin[{root,f}]]]},
 Do[Scan[ReleaseHold,Flatten[{ToExpression[ReleaseHold[cells[f][[i]]],StandardForm,HoldComplete]}]/.{HoldPattern[Export[___]]:>Null,HoldPattern[CreateDirectory[___]]:>Null,HoldPattern[LogLogPlot[___]]:>Null}],{i,ii}]];
AccCode=True;LLPdistr=False;EventCalc=False;
ev["codes/generic.nb",{1}];ev["codes/kinematics.nb",{1}];ev["codes/SensCalc/SM particles.nb",{1}];
chbar=1.973269788*^-16;
ev["codes/Acceptances/llp-exclusive-decays-summary.nb",{2}];
ev["codes/Acceptances/HNL.nb",{2,4}];
LLPsel="Scalar";
scalarRatesCell=If[FreeQ[ToExpression[ReleaseHold[cells["codes/Acceptances/Scalar.nb"][[3]]],StandardForm,HoldComplete],ListBrRatios],4,3];
ev["codes/Acceptances/Scalar.nb",{2,scalarRatesCell}];
ev["codes/Acceptances/ALP-fermion.nb",{2,3}];
ev["codes/Acceptances/DP.nb",{2,3}];
ev["codes/Acceptances/B-L.nb",{2,3}];
files=FileNames[{"*.m","*.wxf"},FileNameJoin[{root,"simulated phase space"}]];
masses[model_]:=Sort[DeleteDuplicates[N[ToExpression[Last[StringSplit[FileBaseName[#],"_"]]]]&/@Select[files,StringStartsQ[FileNameTake[#],model<>"_"]&]]];
sampleRecords=Import[FileNameJoin[{root,"simulated phase space","exHad","manifest.json"}],"RawJSON"];
Do[masses[model]=Sort[DeleteDuplicates[Join[masses[model],N[Lookup[Select[sampleRecords,#model===model&],"mass"]],If[StringStartsQ[model,"HNL-mixing-"],{1.25},{}]]]],{model,DeleteDuplicates[Lookup[sampleRecords,"model"]]}];
masses["ALP-fermion"]=masses["ALP-gluon"];
masses["HNL-mixing-mu"]=masses["HNL-mixing-tau"]=masses["HNL-mixing-e"];
specs={};
Do[
 descriptions=Switch[model,"Scalar",listDecayDescriptions[model],_,{"Default"}];
 channels=ProcessesList[model,"True"];
 If[!ListQ[channels],Print["NO CHANNELS ",model];Quit[1]];
 Print[{model,descriptions,masses[model]}];
 Do[
  records=Table[
   ids=ParamProductToPDGid/@DeleteCases[ListDecayProducts[model,proc],"Null"];
   expr=If[StringStartsQ[model,"HNL"]&&StringStartsQ[proc,"Jets"],Msquared3BodyLLP[model,proc,E1,E3,mLLP,descr],1.];
   <|"channel"->proc,"pdgs"->ids,"masses"->N[ParamProductMass/@ids],"matrix_element"->ToString[expr,InputForm],"rates"->Table[N[ListBrRatios[model,m,proc,descr]],{m,masses[model]}]|>,
   {proc,channels}];
  AppendTo[specs,<|"model"->model,"description"->descr,"masses"->masses[model],"channels"->records|>],
 {descr,descriptions}],
 {model,Join[HNLsList,{"Scalar","ALP-fermion","DP","B-L"}]}];
Export[FileNameJoin[{out,"native-inputs.json"}],specs,"RawJSON"];
Print["EXPORTED ",Length[specs]];Quit[];
