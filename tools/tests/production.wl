Get[FileNameJoin[{DirectoryName[$InputFileName],"common.wl"}]];
LLPdistr=True;EventCalc=False;AccCode=False;
Scan[load["codes/generic.nb",#]&,{1,2,5,6,7,8,9,10,18}];
Scan[load["codes/SensCalc/SM particles.nb",#]&,{1,2}];
check["iron atomic number",znucleus["Fe"]==26,znucleus["Fe"]];
check["iron mass number unchanged",anucleus["Fe"]==56];
Scan[load["codes/LLP distribution/prod-pheno-ALP-photon.nb",#]&,If[hasPhotonStrata,{4,6,7,9},{4,6,7}]];
rows=Flatten[Table[With[{a=\[Sigma]PrimakovNucleus[m,e,mnucleus["Fe"],56,26]+\[Sigma]PrimakovNucleons[m,e,26]}, {m,e,a}],{m,{.05,.2,1.}},{e,{2.,10.,50.}}],1];
check["iron cross sections numeric and positive",And@@(NumericQ[#[[3]]]&&#[[3]]>0.&/@rows)];
If[hasPhotonStrata,
Scan[load["codes/LLP distribution/mother-sampler.nb",#]&,{2,3,4,5}];
synthetic=Flatten[Table[{th,e,1.},{th,{.1,.5,1.,N[Pi/2],2.,3.}},{e,{1.,2.,3.,4.}}],1];
Do[SeedRandom[901];sample=BlockPointsFromSmoothDistribution1[synthetic,0.,20000,9,facility,1.2,3.2];
 expected=If[facility=="LHC",2.*(N[Pi/2]-.1)*2.,(3.-.1)*2.];
 check["restricted photon normalization "<>facility,Abs[sample[[2]]/expected-1.]<.005,sample[[2]]];
 check["photon sample numeric "<>facility,MatrixQ[sample[[1]],Developer`MachineRealQ]&&Dimensions[sample[[1]]]=={20000,5}];
 If[facility=="LHC",check["collider sample has equal hemispheres",Count[sample[[1,All,3]],_?Positive]==10000&&Count[sample[[1,All,3]],_?Negative]==10000]],{facility,{"LHC","SPS"}}]];
(* Test the actual collider integrand, including support and an interior point. *)
mSM["p"]=.938;mSM["e"]=.000511;\[Alpha]EMval=1/137.035999;GeVm2Topb=3.89379*10^8;
EmaxFacility["LHC"]=7000.;EmaxFacility["FCC-hh"]=50000.;EmaxFacility["FCC-hh-85-TeV"]=42500.;
Scan[load["codes/LLP distribution/prod-pheno-ALP-photon.nb",#]&,If[hasPhotonStrata,{4,5,10,11,15},{4,5,8,9,13}]];
ev[First[held["codes/LLP distribution/prod-pheno-ALP-photon.nb",If[hasPhotonStrata,16,14]]]];
a=pTp1MaxEPA[.3,.0001,4000.,"LHC","p"];b=pTp2MaxEPA[.3,.0001,4000.,"LHC","p"];
value=IntegrandFusionConverted1[.3,.0001,4000.,.99*(a+b),0.,"LHC","p"];
check["fusion excludes out-of-bounds individual photons",value==0.,value];
value=IntegrandFusionConverted1[.3,.0001,4000.,.5,0.,"LHC","p"];
check["fusion interior point retained",NumericQ[value]&&value>0.,value];
(* Execute the saved angular-folding statement itself, without production files. *)
If[hasPhotonStrata,
fold=Cases[held["codes/LLP distribution/llp-sampler-Primakov-fusion.nb",2],x:HoldPattern[If[MemberQ[{"LHC","FCC-hh","FCC-hh-85-TeV"},Facility],_]]:>HoldComplete[x],Infinity];
check["one active forward-fold statement",Length[fold]==1,Length[fold]];
Do[Facility=facility;alpPoints={{.2,10.},{N[Pi]-.2,10.}};ev[First[fold]];
 check["Primakov angular convention "<>facility,Max[Abs[alpPoints[[All,1]]-If[facility=="SPS",{.2,N[Pi]-.2},{.2,.2}]]]<10^-12],{facility,{"LHC","SPS"}}]];
finish["production-results"];
