(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`Acceptance`HoldAllSubpatterns`"];


(* Mock function. *)
Remove[f]


(* function definitions *)
f[arg1_, restArgs__Integer:0] := arg1 + restArgs

f[arg_] := With[{withArg = arg}, withArg]


(* ::Section:: *)
(*Tests*)


Test[
	DownValues[f]
	,
	HoldPattern[f[arg1_, restArgs__Integer:0]] :> arg1 + restArgs
	,
	EquivalenceFunction -> (! MemberQ[##]&)
	,
	TestID -> "pattern without holded subpatterns is not member of down values"
];


Test[
	DownValues[f]
	,
	HoldPattern[HoldPattern[f[arg1_, restArgs__Integer:0]] :> arg1 + restArgs]
	,
	EquivalenceFunction -> (! MemberQ[##]&)
	,
	TestID -> "pattern wrapped in HoldPattern is not member of down values"
];


Test[
	DownValues[f]
	,
	HoldAllSubpatterns[
		HoldPattern[f[a_, b__Integer:0]] :> a + b
	]
	,
	EquivalenceFunction -> MemberQ
	,
	TestID -> "pattern with holded subpatterns with changed names, \
is member of down values"
];


Test[
	DownValues[f]
	,
	HoldAllSubpatterns[
		HoldPattern[f[a_, b__Integer:0]] :> a + b,
		"VerbatimLocalVariables" -> True
	]
	,
	EquivalenceFunction -> (! MemberQ[##]&)
	,
	TestID -> "pattern with holded subpatterns, with changed names and with \
\"VerbatimLocalVariables\" option set to True, is not member of down values"
];


Test[
	DownValues[f]
	,
	HoldAllSubpatterns[
		HoldPattern[f[arg1_, restArgs__Integer:0]] :> arg1 + restArgs,
		"VerbatimLocalVariables" -> True
	]
	,
	EquivalenceFunction -> MemberQ
	,
	TestID -> "pattern with holded subpatterns, with same names and with \
\"VerbatimLocalVariables\" option set to True, is member of down values"
];


Test[
	DownValues[f]
	,
	HoldAllSubpatterns[
		HoldPattern[f[arg_]] :> With[{withArg = arg}, withArg]
	]
	,
	EquivalenceFunction -> MemberQ
	,
	TestID -> "pattern with With, holded subpatterns and with same names, \
is member of down values"
];


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
