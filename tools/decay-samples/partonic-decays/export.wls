$HistoryLength=0;
{input,output}=Take[$CommandLine,-2];
If[!DirectoryQ[output],CreateDirectory[output,CreateIntermediateDirectories->True]];
files=Select[FileNames["*.json",input],!StringEndsQ[#,".report.json"]&];
Do[
 events=Import[file,"RawJSON"];
 If[Length[events]==0 || !And@@(VectorQ[#,MachineNumberQ]&&Mod[Length[#],8]==0&/@events),Print["INVALID ",file];Exit[1]];
 table=Developer`ToPackedArray[PadRight[events,Automatic,-999.]];
 target=FileNameJoin[{output,FileBaseName[file]<>".wxf"}];
 bytes=BinarySerialize[table,PerformanceGoal->"Size"];
 temporary=target<>".tmp";
 stream=OpenWrite[temporary,BinaryFormat->True];BinaryWrite[stream,bytes];Close[stream];
 If[BinarySerialize[BinaryDeserialize[ReadByteArray[temporary]],PerformanceGoal->"Speed"]=!=BinarySerialize[table,PerformanceGoal->"Speed"],Print["ROUNDTRIP FAILED ",file];Exit[2]];
 If[RenameFile[temporary,target,OverwriteTarget->True]===$Failed,Exit[3]];
 legacy=FileNameJoin[{output,FileBaseName[file]<>".m"}];
 If[FileExistsQ[legacy],DeleteFile[legacy]];
 Print[{FileNameTake[target],Dimensions[table],FileByteCount[target]}],{file,files}];
Print["COMPLETED ",Length[files]];Exit[];
