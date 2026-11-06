(* Read-only checks of the installed samples and channel bookkeeping. *)
$HistoryLength=0;
root=Nest[ParentDirectory,DirectoryName[$InputFileName],3];
Get[FileNameJoin[{root,"codes","Acceptances","exhad-decays.wl"}]];
fail[label_]:=(Print["FAIL: ",label];Quit[1]);
If[exHadRecords==={},fail["empty catalogue"]];
files=DeleteDuplicatesBy[exHadRecords,#file&];
Do[
 path=FileNameJoin[{exHadSampleDirectory,r["file"]}];
 If[!FileExistsQ[path]||FileHash[path,"SHA256","HexString"]=!=r["sha256"],fail[{"checksum",r["file"]}]];
 events=exHadData[r["file"]];
 If[Length[events]!=r["events"],fail[{"event count",r["file"]}]];
 Do[
  particles=Select[Partition[event,8],#[[6]]!=-999.&];
  If[particles==={}||!And@@(MemberQ[{11,12,13,14,16,22,130,211,321,2112,2212},Abs[Round[#]]]&/@particles[[All,6]]),fail[{"terminal particle",r["file"]}]];
  If[Max[Abs[Total[particles[[All,1;;4]]]-{0.,0.,0.,r["mass"]}]]>2*10^-7 Max[1.,r["mass"]],fail[{"four-momentum",r["file"]}]];
  If[Abs[Total[particles[[All,7]]]]>10^-10,fail[{"charge",r["file"]}]];
  If[!And@@(#[[8]]==1.&/@particles),fail[{"stability",r["file"]}]];
  ,{event,events}];
 ,{r,files}];
If[exHadAvailable["ALP-gluon",3.,"Jets-GG","True","Default"]=!=False,fail["ALP-gluon isolation"]];
If[exHadAvailable["Dark-QCD-rho",3.25,"hadronic","True","Default"]=!=False,fail["dark-QCD isolation"]];
If[exHadAvailable["B",3.25,"hadronic","True","Default"]=!=False,fail["baryon-current isolation"]];
If[exHadAvailable["ALP-fermion",3.,"hadronic","True","PBC"]=!=False,fail["PBC isolation"]];
Print["PASS: ",Length[files]," files, ",Total[Lookup[files,"events"]]," events; checksums, four-momentum, charge, terminal particles, model separation."];
Quit[];
