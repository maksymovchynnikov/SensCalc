(* Usage: WolframKernel -script export.wls input.json output-directory *)
{input, output} = Take[$CommandLine, -2];
data = Import[input, "RawJSON"];
If[!DirectoryQ[output], CreateDirectory[output, CreateIntermediateDirectories -> True]];
Do[
 table = Developer`ToPackedArray[N[PadRight[sample["events"], Automatic, -999.]]];
 file = FileNameJoin[{output, "SM_" <> ToString[sample["pdg"]] <> "_" <>
     ToString[sample["mass"], InputForm] <> ".wxf"}];
 temporary = file <> ".tmp";
 stream = OpenWrite[temporary, BinaryFormat -> True];
 BinaryWrite[stream, BinarySerialize[table, PerformanceGoal -> "Size"]]; Close[stream];
 If[BinarySerialize[BinaryDeserialize[ReadByteArray[temporary]], PerformanceGoal -> "Speed"] =!=
    BinarySerialize[table, PerformanceGoal -> "Speed"], Print["ROUNDTRIP FAILED ", file]; Exit[1]];
 If[RenameFile[temporary, file, OverwriteTarget -> True] === $Failed, Exit[2]];
 legacy = FileNameJoin[{output, FileBaseName[file] <> ".m"}];
 If[FileExistsQ[legacy], DeleteFile[legacy]];
 Print[{FileNameTake[file], Dimensions[table]}];
, {sample, data["samples"]}];
Exit[];
