(* Run with WolframKernel -noinit -script tools/tests/inelastic-dp-dm-sensitivity.wl. *)
root = ParentDirectory[ParentDirectory[DirectoryName[$InputFileName]]];
nb = Get[FileNameJoin[{root, "3. Inelastic-DP-DM sensitivity.nb"}]];
cells = Cases[nb, c : Cell[BoxData[_], "Input", ___] :> c, Infinity];
failures = {};
check[ok_, label_] := If[TrueQ[ok], Print["PASS ", label], AppendTo[failures, label]; Print["FAIL ", label]];
controlIndex = First@Select[Range[Length[cells]], StringContainsQ[ToString[cells[[#]], InputForm], "Use available distributions"] &];
tags = First@Cases[cells[[controlIndex]], Rule[CellTags, t_] :> t];
check[ContainsAll[tags, {"Acceptance-computation", "Number-of-events-computation+sensitivity"}], "automatic distribution step"];
control = ToExpression[cells[[controlIndex, 1, 1]], StandardForm, HoldComplete];
LLPdirName = "Inelastic-DP-DM-Model-1"; FacilitySelected = "SPS";
directory["Production weights"] = FileNameJoin[{root, "phenomenology", LLPdirName, "Production probabilities"}];
DistrCombinationsDP = {{"DP", "Eta", "SPS"}};
PmotherToMediator[m_, e_, "Eta", "SPS"] = e;
paths = Join[Table[FileNameJoin[{root, "spectra", "New physics particles spectra", LLPdirName,
    "DoubleDistr_" <> LLPdirName <> "_Total-" <> variant <> "_SPS.mx"}], {variant, {"Central", "Lower", "Upper"}}],
  {FileNameJoin[{directory["Production weights"], "ProdProbabilities-SPS.mx"}]}];
Do[
 {available, reply, expectedReuse, expectedPrompts} = scenario;
 prompts = 0;
 selectionDialogExplanationOneOption[args___] := (prompts++; reply);
 DistrCombinations = {{"stale", "Total", "LHC"}};
 expr = control /. {HoldPattern[NotebookDirectory[]] :> root,
    FileExistsQ -> (MemberQ[available, #] &), DirectoryQ -> (True &)};
 result = CheckAbort[ReleaseHold[expr]; True, False];
 check[result && SameQ[\[Chi]prProdExists, expectedReuse] && prompts == expectedPrompts,
  "distribution choice " <> ToString[{Length[available], reply}]];
 check[fileProdProbabilities === Last[paths], "production-probability path"];
 If[!expectedReuse, check[DistrCombinations === DistrCombinationsDP && WeightsCombinations === {{"Eta", "SPS"}}, "dark-photon inputs restored"]];
, {scenario, {{{}, "unused", False, 0}, {paths, "Use available distributions", True, 1},
   {paths, "Recompute distributions", False, 1}, {Most[paths], "unused", False, 0}, {Delete[paths, 2], "unused", False, 0}}}];
loaderIndex = First@Select[Range[Length[cells]], StringContainsQ[ToString[cells[[#]], InputForm], "relicTarget"] &];
loader = ToExpression[cells[[loaderIndex, 1, 1]], StandardForm, HoldComplete] /. HoldPattern[NotebookDirectory[]] :> root;
check[TimeConstrained[Check[ReleaseHold[loader]; True, False], 45, False], "constraint import"];
check[Dimensions[relicTarget] === {588, 2} && Dimensions[labConstraints] === {4300, 2}, "constraint dimensions"];
check[First[labConstraints] === Last[labConstraints] && Min[Flatten[labConstraints]] > 0, "closed exclusion domain"];
check[Min[Flatten[relicTarget]] > 0 && First[relicTarget] =!= Last[relicTarget], "open relic target"];
check[SameQ @@ (ParameterSpace[LLPdirName, #] & /@ {"Central", "Lower", "Upper"}), "fixed constraints for production variants"];
LLPdirName = "Inelastic-DP-DM-Model-2";
ReleaseHold[loader];
check[And @@ (ParameterSpace[LLPdirName, #] === {} & /@ {"Central", "Lower", "Upper"}), "Model 1 constraints stay in Model 1"];
Print["Failures: ", failures];
Quit[If[failures === {}, 0, 1]];
