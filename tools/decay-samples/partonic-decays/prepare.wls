$HistoryLength=0;
{root,out}=Take[$CommandLine,-2];
If[!DirectoryQ[out],CreateDirectory[out,CreateIntermediateDirectories->True]];
cells[file_]:=Cases[Get[FileNameJoin[{root,file}]],Cell[BoxData[b_],"Input",___]:>b,Infinity];
evaluate[file_,indices_:All]:=Module[{cc=cells[file],held,idx},
 idx=If[indices===All,Range[Length[cc]],indices];
 Do[held=ToExpression[cc[[i]],StandardForm,HoldComplete];
 Block[{NotebookDirectory=Function[{},DirectoryName[FileNameJoin[{root,file}]]]},
 Scan[ReleaseHold,If[ListQ[held],held,{held}]]],{i,idx}]];
AccCode=True;LLPdistr=False;EventCalc=False;
evaluate["codes/generic.nb"];
evaluate["codes/kinematics.nb"];
evaluate["codes/SensCalc/SM particles.nb"];
chbar=1.973269788*^-16;
evaluate["codes/Acceptances/HNL.nb",{2,4}];
files=FileNames[{"*.m","*.wxf"},FileNameJoin[{root,"simulated phase space"}]];
masses[model_]:=Sort[DeleteDuplicates[ToExpression[Last[StringSplit[FileBaseName[#],"_"]]]&/@Select[files,StringStartsQ[FileNameTake[#],model<>"_"]&]]];
rows={};
Do[Do[If[StringMatchQ[proc,"Jets-us*"|"Jets-cd*"|"Jets-ub*"|"Jets-cb*"|"Jets-bbv"]&&TrueQ[ListBrRatios[model,mass,proc,"Default"]>10^-15] && (proc=!="Jets-bbv" || model==="HNL-mixing-e"),
 ids=ParamProductToPDGid/@DeleteCases[ListDecayProducts[model,proc],"Null"];
 formula=Msquared3BodyLLP[model,proc,E1,E3,mLLP,"Default"];
 mm=ParamProductMass/@ids;
 expected=If[proc==="Jets-bbv",mLLP*(aa*E3+bb*E1*(mLLP^2-2*mLLP*E1)+cc*(mLLP-E1-E3)*(mLLP^2-2*mLLP*(mLLP-E1-E3))),16*mLLP*(mLLP-E1-E3)*(mLLP^2+mm[[2]]^2-mm[[1]]^2-mm[[3]]^2-2*mLLP*(mLLP-E1-E3))];
 If[proc==="Jets-bbv",coeff=N[{aa,bb,cc}/.First[Solve[Thread[Flatten[CoefficientList[Expand[formula-expected],{E1,E3,mLLP}]]==0],{aa,bb,cc}]]];expected=expected/.Thread[{aa,bb,cc}->coeff]];
 (* This form must equal the native weak-current expression up to roundoff. *)
 If[Max[Abs[CoefficientList[Expand[formula-expected],{E1,E3,mLLP}]]]>10^-12,Print["MATRIX MISMATCH ",model,proc];Exit[2]];
 AppendTo[rows,Join[<|"model"->model,"channel"->proc,"mass"->mass,"pdgs"->ids,"masses"->mm,"matrix"->If[proc==="Jets-bbv","nc","cc"]|>,If[proc==="Jets-bbv",<|"coefficients"->coeff|>,<||>]]]],
 {proc,ProcessesList[model,"True"]}],{model,HNLsList},{mass,masses["HNL-mixing-e"]}];
Do[AppendTo[rows,<|"model"->"ALP-gluon","channel"->"Jets-ss","mass"->mass,"pdgs"->{3,-3},"masses"->{ParamProductMass[3.],ParamProductMass[-3.]},"matrix"->"two-body"|>],{mass,{4.5,5.1}}];
Export[FileNameJoin[{out,"samples.json"}],rows,"RawJSON"];
Print["SAMPLES ",Length[rows],"\n",Counts[Lookup[rows,"model"]]];
