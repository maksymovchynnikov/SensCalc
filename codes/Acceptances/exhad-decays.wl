(* Conditional exHad samples. Lifetimes and channel rates remain host-owned. *)
exHadSampleDirectory=FileNameJoin[{Nest[ParentDirectory,DirectoryName[$InputFileName],2],"simulated phase space","exHad"}];
Clear[exHadRecords,exHadData,exHadRecord,exHadGroup,exHadAvailable,exHadDraw,exHadBranchingRatio];
exHadCachedFile="";exHadCachedArray={};
exHadRecords=If[FileExistsQ[FileNameJoin[{exHadSampleDirectory,"manifest.json"}]],
 Import[FileNameJoin[{exHadSampleDirectory,"manifest.json"}],"RawJSON"],{}];
exHadBosons={"Scalar","ALP-fermion","DP","B-L"};
exHadRecord[llp_,mass_,description_,channel_]:=SelectFirst[exHadRecords,
 #model===llp && #description===description && Abs[#mass-mass]<10^-10 && #channel===channel&,Missing["NotTabulated"]];
exHadRecord[llp_,mass_,description_,exHadChannel[key_]]:=SelectFirst[exHadRecords,
 #model===llp && #description===description && Abs[#mass-mass]<10^-10 && #key===key&,Missing["NotTabulated"]];
exHadAvailable[llp_,mass_,channel_,had_,description_]:=
 had==="True"&&AssociationQ[exHadRecord[llp,mass,description,channel]];
exHadGroup::selection="The exHad sample for `1` at `2` GeV describes all hadronic decays together. Select the complete hadronic channel set.";
exHadGroup[llp_,mass_,processes_,had_,description_]:=Module[{record,positive,selected},
 If[had=!="True"||!MemberQ[exHadBosons,llp],Return[processes]];
 record=exHadRecord[llp,mass,description,"hadronic"];
 If[!AssociationQ[record],Return[processes]];
 positive=Select[record["members"],TrueQ[ListBrRatios[llp,mass,#,description]>0]&];
 selected=Intersection[processes,positive];
 If[selected==={},Return[processes]];
 If[Complement[positive,processes]=!={},Message[exHadGroup::selection,llp,mass];Abort[]];
 Append[Complement[processes,record["members"]],exHadChannel[record["key"]]]];
exHadBranchingRatio[llp_,mass_,channel_,description_]:=ListBrRatios[llp,mass,channel,description];
exHadBranchingRatio[llp_,mass_,channel_exHadChannel,description_]:=
 Total[ListBrRatios[llp,mass,#,description]&/@exHadRecord[llp,mass,description,channel]["members"]];
exHadProcesses[llp_,mass_,processes_,had_,description_]:=Select[
 exHadGroup[llp,mass,processes,had,description],Function[channel,
 If[exHadAvailable[llp,mass,channel,had,description]||
   (had==="True"&&JetsPresence[llp,channel]==="Yes"&&ifHadronizedPhaseSpaceIsPresent[llp,mass,channel]),True,
   mass>(Total[ParamProductMass[ParamProductToPDGid[#]]&/@DeleteCases[ListDecayProducts[llp,channel],"Null"]]/.{mX->mXval[llp,mass]})]]];
exHadData::invalid="Invalid or missing exHad sample: `1`. Regenerate the sample with tools/decay-samples/exhad.";
exHadData[file_]:=Module[{path=FileNameJoin[{exHadSampleDirectory,file}],array},
 If[exHadCachedFile===file,Return[exHadCachedArray]];
 If[!FileExistsQ[path],Message[exHadData::invalid,file];Abort[]];
 array=BinaryDeserialize[ReadByteArray[path]];
 If[!MatrixQ[array,MachineNumberQ]||Length[array]<1||Mod[Length[First[array]],8]!=0,
 Message[exHadData::invalid,file];Abort[]];
 exHadCachedFile=file;exHadCachedArray=array];
exHadDraw[llp_,mass_,channel_,count_,description_]:=Module[{record,array,draw,flavour},
 record=exHadRecord[llp,mass,description,channel];array=exHadData[record["file"]];
 draw=If[count<=Length[array],RandomSample[array,count],RandomChoice[array,count]];
 If[StringStartsQ[record["key"],"HNL-NC_"]&&MemberQ[{"HNL-mixing-mu","HNL-mixing-tau"},llp],
  flavour=If[llp==="HNL-mixing-mu",14.,16.];
  (* The first particle is the preserved primary neutrino. Secondary neutrinos
     keep their own flavour, including those from charm and tau decays. *)
  draw[[All,6]]=flavour Sign[draw[[All,6]]]];
 Developer`ToPackedArray[draw]];
