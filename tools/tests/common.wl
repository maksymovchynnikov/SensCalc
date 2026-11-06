(* Run each test with WolframKernel -noinit -noprompt -script tools/tests/<name>.wl. *)
root=Nest[DirectoryName,$InputFileName,3];
hasPhotonStrata=FileExistsQ[FileNameJoin[{root,"codes/LLP distribution/llp-sampler-Primakov-fusion.nb"}]];
work=CreateDirectory[FileNameJoin[{$TemporaryDirectory,"senscalc-check-"<>CreateUUID[]}]];
SetDirectory[work];Needs["CCompilerDriver`"];
CCompilerDriver`$CCompilerInternalDirectory=work;
cells[f_]:=cells[f]=Cases[Get[FileNameJoin[{root,f}]],Cell[BoxData[b_],"Input",___]:>b,Infinity];
held[f_,i_]:=ToExpression[cells[f][[i]],StandardForm,HoldComplete]/.HoldPattern[NotebookDirectory[]]->DirectoryName[FileNameJoin[{root,f}]];
ev[x_List]:=Scan[ev,x];ev[x_HoldComplete]:=ReleaseHold[x];
load[f_,i_]:=Block[{Print=Function[Null]},ev[held[f,i]]];
results={};
check[name_,condition_,value_:Null]:=(AppendTo[results,TrueQ[condition]];Print[If[TrueQ[condition],"PASS ","FAIL "],name,If[value===Null,""," "<>ToString[value,InputForm]]]);
finish[name_]:=Module[{errors},
 errors=Select[$MessageList,!FreeQ[#,CompiledFunction|Compile|Part|Set|Get|ToExpression|Syntax]&];
 check["no compilation or evaluation failures",errors=={},ToString[errors,InputForm]];
 If[DirectoryQ[FileNameJoin[{work,"exports"}]],DeleteDirectory[FileNameJoin[{work,"exports"}],DeleteContents->True]];
 Print[name,": ",Count[results,True],"/",Length[results]," passed"];
 Quit[If[And@@results,0,1]]];
