(* Run in a fresh kernel. Loads existing inputs without generating or exporting data. *)
$HistoryLength = 0;
root = ParentDirectory[ParentDirectory[DirectoryName[$InputFileName]]];
notebook = Get[FileNameJoin[{root, "3. Dark-QCD-rho sensitivity.nb"}]];
inputCells = Cases[notebook, Cell[BoxData[b_], "Input", ___] :> b, Infinity];
input[marker_] := SelectFirst[inputCells, !FreeQ[#, marker] &];
evaluate[b_] := ReleaseHold[ToExpression[b, StandardForm, HoldComplete] /.
  HoldPattern[NotebookDirectory[]] -> root];
assert[condition_, label_] := If[!TrueQ[condition], Print["FAIL: ", label]; Quit[1]];

LLPdirName = "Dark-QCD-rho";
selectionDialogExplanationOneOption[___] := "Revised (2504.06828)";
directory["Distribution"] = FileNameJoin[{root, "spectra", "New physics particles spectra", LLPdirName}];
evaluate[input["GeVMinusOneTom"]];
evaluate[input["\[Sigma]DrellYanData"]];
evaluate[input["YieldsFragmentation"]];
evaluate[input["ExtractedProductionParameters"]];
assert[MemberQ[DistrCombinations, {LLPdirName, "Fragmentation", "SPS"}], "fragmentation discovery"];
assert[MemberQ[DistrCombinations, {LLPdirName, "DrellYan", "SPS"}], "Drell-Yan discovery"];
assert[DuplicateFreeQ[DistrCombinations], "no duplicate channel/facility records"];
assert[MemberQ[WeightsCombinations, {"Fragmentation", "SPS"}], "fragmentation weight"];

FacilityGivenExperiment = "SPS";
ProductionPatternSelectedDistr = Select[DistrCombinations,
  #[[3]] === "SPS" && MemberQ[{"Fragmentation", "DrellYan"}, #[[2]]] &];
loadLoop = Cases[ToExpression[input["DistrDataImportTemp"], StandardForm, HoldComplete],
  (d_Do /; !FreeQ[Unevaluated[d], dirimp]) :> HoldComplete[d], Infinity];
assert[Length[loadLoop] === 1, "notebook spectrum-import loop"];
ReleaseHold[First[loadLoop] /. HoldPattern[NotebookDirectory[]] -> root];
Do[
  reference = Abs[Import[FileNameJoin[{root, "spectra", "New physics particles spectra",
    "DP", "Pregenerated", "DoubleDistr_DP_" <> mode <> "_SPS.m"}], "MX"]];
  assert[MatrixQ[DistrDataImport[mode], NumericQ] && DistrDataImport[mode] === reference,
    mode <> " spectrum equals shared DP input"],
  {mode, {"Fragmentation", "DrellYan"}}];
Do[assert[MatrixQ[DistrDataImport["DrellYan-" <> variant], NumericQ],
  "Drell-Yan " <> variant <> " spectrum"], {variant, {"Lower", "Central", "Upper"}}];
condrev = False;
evaluate[input["ExtractedProductionParameters"]];
assert[FreeQ[DistrCombinations, "Fragmentation"], "old-mixing selection excludes fragmentation"];
Print["PASS: Dark-QCD shared-spectrum discovery, weights and numerical loading"];
Quit[0];
