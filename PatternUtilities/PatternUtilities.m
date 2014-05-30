(* ::Package:: *)

BeginPackage["PatternUtilities`"]


(* ::Section:: *)
(*Usage messages*)


HoldAllSubpatterns::usage = 
"\
HoldAllSubpatterns[expr] \
returns expr with every subexpression wrapped with HoldPattern."


(* ::Section:: *)
(*Implementation*)


(*
	Unprotect all symbols in this context
	(all public symbols provided by this package)
*)
Unprotect["`*"]


Begin["`Private`"]


(* ::Subsection:: *)
(*HoldAllSubpatterns*)


SetAttributes[HoldAllSubpatterns, HoldAllComplete]


Options[HoldAllSubpatterns] = {
	Heads -> True,
	"VerbatimLocalVariables" -> False
}


HoldAllSubpatterns[expr_, OptionsPattern[]] :=
	MapAll[
		HoldPattern,
		Unevaluated[expr],
		Heads -> OptionValue[Heads]
	] /.
		If[OptionValue["VerbatimLocalVariables"],
			{}
		(* else *),
			With[
				{
					localVariables =
						Flatten[
							Cases[
								HoldComplete[expr]
								,
								(
									HoldPattern[Pattern][name_, _] |
									(With | Module)[name_, _]
								) :>
									ReleaseHold[
										Hold[name] /.
											(Set | SetDelayed)[x_, _] :> x
									]
								,
								{1, Infinity}
							]
						]
				}
				,
				Quiet[
					Verbatim[HoldPattern[#]] :> Pattern[#, _]& /@
						localVariables
					,
					RuleDelayed::rhs
				]
			]
		]



End[]


(* ::Subsection:: *)
(*Public symbols protection*)


(*
	Protect all symbols in this context
	(all public symbols provided by this package)
*)
Protect["`*"]


EndPackage[]
