(* WolframKernel -noinit -script tools/tests/acceptance-metadata.wl *)
$HistoryLength = 0;
root = Environment["SENSCALC_TEST_ROOT"];
If[!StringQ[root] || root === "", root = Nest[DirectoryName, $InputFileName, 3]];
notebook = Environment["SENSCALC_TEST_NOTEBOOK"];
If[!StringQ[notebook] || notebook === "", notebook = FileNameJoin[{root, "1. Acceptances.nb"}]];
work = CreateDirectory[FileNameJoin[{$TemporaryDirectory, "senscalc-metadata-test-" <> CreateUUID[]}]];
results = {};
check[name_, value_] := (AppendTo[results, TrueQ[value]]; Print[If[TrueQ[value], "PASS ", "FAIL "], name]);
cells = Cases[Get[notebook], Cell[BoxData[b_], "Input", ___] :> b, Infinity];
Print["Loaded acceptance notebook"];
ev[h_List] := Scan[ev, h];
ev[h_HoldComplete] := ReleaseHold[h];
sm = Cases[Get[FileNameJoin[{root, "codes/SensCalc/SM particles.nb"}]], Cell[BoxData[b_], "Input", ___] :> b, Infinity];
Block[{Print = Function[Null]}, ev[ToExpression[First[sm], StandardForm, HoldComplete]]];
Print["Loaded particle definitions"];
GivenExperiment = "SHiP-ECN3"; FacilityGivenExperiment = "SPS";
ECALoptionGivenExperiment = "True"; DecayVolumeAsDetectorGivenExperiment = "False";
DipoleMagnetOptionGivenExperiment = "True"; Bval = .77;
zMagnetMinGivenExperiment = 80.; zMagnetMaxGivenExperiment = 81.;
DetectablePDGsGivenExperiment = {-13., -11., 11., 13.}; pdgfake = -999.;
$UseExHadDecaySamples = True;
WhetherCuts = IfEcuts = IfEtotLowercuts = IfpTcuts = IfIPcuts = IfSScuts = 1;
IfEtotUppercuts = IfAngSepCuts = IfminvCuts = IfminvLowerCuts = IfminvUpperCuts = 0;
ecutLowerID[id_, q_] := If[Abs[id] == 11., 2., 1.]; ecutUpperID[_, _] := 100.;
pTcutLowerID[_, q_] := If[q == 0., 0., .1]; pTcutUpperID[_, _] := 10.^10;
EtotCutLowerID[_, _, _] := 3.; EtotCutUpperID[_, _, _] := 10.^10;
minvCutLowerID[_, _, _] := 0.; minvCutUpperID[_, _, _] := 10.^10;
IPcutID[_, _] := .05; AngSepCutID[_, _] := 0.; SScutID[_, _] := .02;
mLLPlist[_] := {.05, .1}; ntracksmin = 4;
procs = {"nuEE", "nuGamma"};
ListDecayProducts["HNL-mixing-e", "nuEE"] = Join[ParamPDGidToProduct /@ {12., -11., 11.}, {"Null"}];
ListDecayProducts["HNL-mixing-e", "nuGamma"] = Join[ParamPDGidToProduct /@ {12., 22.}, {"Null", "Null"}];
ListDecayProducts["ALP-electroweak", "2gamma"] = {"\[Gamma]", "\[Gamma]", "Null", "Null"};
ListDecayProducts["inelastic-fixture", "Xgamma"] = {"X", "\[Gamma]", "Null", "Null"};
ProcessesListRefined[_, _] := procs;
listDecayDescriptions[_] := {"Default", "Alternative"}; descrDefault[_] := "Default";
BrVisibleGivenSetup[_, _, _, _, description_] := If[description === "Alternative", .25, .75];
DecayDescriptionExplanation[_, d_] := "fixture " <> d;
c\[Tau]LLP[_, _, m_, g_] := m/g^2; couplingSymbol[_] := y;
TableParticlesNumbersGivenExperiment = {{11., 1.}};
FinalBlockMass[_, mass_, _, _, _, _, _, _, _] := {{mass, .01, 10., 45., .75}};
selectionDialog[_, _] := {"nuEE"};
combinedDialog[_, _] := {"SHiP-ECN3-" <> mode, "Select particular channels", mode,
  "Hadronized products", {"Default", "Alternative"}, {"\[Gamma]", ParamPDGidToProduct[12.], "Null"}};
Block[{NotebookDirectory = Function[{}, work], Print = Function[Null]},
 ev[ToExpression[cells[[33]], StandardForm, HoldComplete]]];
Print["Loaded acceptance export"];
Do[
 Block[{$FrontEnd = Null, NotebookDirectory = Function[{}, work], Print = Function[Null],
   ResourceFunction = Function[name, Identity],
   DynamicModule = Function[Null, Null, HoldAll]}, FinalBlock["HNL-mixing-e", 17]];
 Do[
  path = FileNameJoin[{work, "Acceptances", "SHiP-ECN3-" <> mode,
    "Acceptance_SHiP-ECN3-" <> mode <> "_for_HNL-mixing-e_decayDescription_" <> d <> ".m"}];
  metaPath = FileNameJoin[{DirectoryName[path], FileBaseName[path] <> ".txt"}];
  check[mode <> " / " <> d <> " paired files", FileExistsQ[path] && FileExistsQ[metaPath]];
  text = Import[metaPath, "Text"];
  check["description and allowed channel", StringContainsQ[text, "Decay description: " <> d] &&
    StringContainsQ[text, "nueePeM | PDGs: {12., -11., 11.}"] && !StringContainsQ[text, "nuegamma |"]];
  check["detectable list and cuts", StringContainsQ[text, "eM (11.)"] &&
    StringContainsQ[text, "e+/- | E [GeV]: {2., 100.} | pT [GeV]: {0.1, 1.*^10}"] &&
    StringContainsQ[text, "IP max [m]: 0.05"] && StringContainsQ[text, "Angular separation: 0"]];
  check["mode-specific multiplicity", StringContainsQ[text, "Minimum multiplicity: " <>
    Switch[mode, ">=2", "2", ">=n", "4", "Mono-particle", "1", _, "all detectable particles"]]];
  check["veto activation", If[mode === "All detectable",
    StringContainsQ[text, "gamma (absolute PDG 22.)"] && StringContainsQ[text, "nue (absolute PDG 12.)"] &&
      !StringContainsQ[text, "999999"], StringContainsQ[text, "Explicit particle veto: not applied"]]];
  data = Import[path, "MX"];
  expected = {"SPS", "True", {{.05, .01, 10., 45., .75}, {.1, .01, 10., 45., .75}},
    {{11., 1.}}, If[d === "Alternative", .25, .75], "fixture " <> d, mLLP/y^2};
  check["MX payload unchanged", data === expected], {d, {"Default", "Alternative"}}],
 {mode, {">=2", ">=n", "All detectable", "Mono-particle"}}];
SilentOption = 1;
Block[{NotebookDirectory = Function[{}, work], Print = Function[Null]},
 ev[ToExpression[cells[[34]], StandardForm, HoldComplete]]];
procs = {"2gamma"};
Block[{$FrontEnd = Null, NotebookDirectory = Function[{}, work], Print = Function[Null],
 ResourceFunction = Function[name, Identity]},
 FinalBlock["ALP-electroweak", 17]];
silentPath = FileNameJoin[{work, "Acceptances", GivenExperimentNameFin,
 "Acceptance_" <> GivenExperimentNameFin <> "_for_ALP-electroweak_decayDescription_Default.txt"}];
text = Import[silentPath, "Text"];
check["silent export and symbolic diphoton name", StringContainsQ[text, "2gamma | PDGs: {22., 22.}"] &&
 StringContainsQ[text, "Selected mode: All detectable"]];
directPath = FileNameJoin[{work, "dummy.mx"}];
exportAcceptanceMetadata[directPath, "inelastic-fixture", "Default", {"Xgamma"}, ">=2", 9,
 "False", {}, {.1}, 3];
text = Import[FileNameJoin[{work, "dummy.txt"}], "Text"];
check["physical invisible daughter preserved", StringContainsQ[text, "Xgamma | PDGs: {-11111., 22.}"]];
check[".mx extension and parton mode", StringContainsQ[text, "Acceptance file: dummy.mx"] &&
 StringContainsQ[text, "Hadronization: partons"]];
GivenExperiment = "CHARM-photon";
exportAcceptanceMetadata[directPath, "ALP-electroweak", "Default", {"2gamma"}, "All detectable", 99,
 "True", {22.}, {.1}, 3];
text = Import[FileNameJoin[{work, "dummy.txt"}], "Text"];
check["dedicated photon route recorded", StringContainsQ[text, "Dedicated CHARM/NuCal photon acceptance"] &&
 StringContainsQ[text, "Explicit particle veto: not applied"]];
check["small metadata files", Max[FileByteCount /@ FileNames["*.txt", work, Infinity]] < 20000];
Print["Acceptance metadata: ", Count[results, True], "/", Length[results], " passed"];
DeleteDirectory[work, DeleteContents -> True];
Quit[If[And @@ results, 0, 1]];
