(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`HoldAllSubpatterns`"];


(* ::Section:: *)
(*Tests*)


Test[
	HoldAllSubpatterns[2 + 2 * 5]
	,
	HoldPattern[
		HoldPattern[Plus][
			HoldPattern[2],
			HoldPattern[HoldPattern[Times][HoldPattern[2], HoldPattern[5]]]
		]
	]
	,
	TestID -> "basic expression"
];


Test[
	HoldAllSubpatterns[Message[Sin::argx, Sin, 2]]
	,
	HoldPattern[
		HoldPattern[Message][
			HoldPattern[
				HoldPattern[MessageName][HoldPattern[Sin], HoldPattern["argx"]]
			]
			,
			HoldPattern[Sin],
			HoldPattern[2]
		]
	]
	,
	TestID -> "given expression is not evaluated"
];


Test[
	HoldAllSubpatterns[2 + 2 * 5, Heads -> False]
	,
	HoldPattern[
		Plus[
			HoldPattern[2],
			HoldPattern[Times[HoldPattern[2], HoldPattern[5]]]
		]
	]
	,
	TestID -> "option: Heads -> False"
];


Test[
	HoldAllSubpatterns[
		x_ :> 2 x,
		"VerbatimLocalVariables" -> False
	]
	,
	HoldPattern[
		HoldPattern[RuleDelayed][
			HoldPattern[
				HoldPattern[Pattern][x_, HoldPattern[HoldPattern[Blank][]]]
			]
			,
			HoldPattern[HoldPattern[Times][HoldPattern[2], x_]]
		]
	]
	,
	TestID -> "named patterns: option: \"VerbatimLocalVariables\" -> False"
];


Test[
	HoldAllSubpatterns[
		x_ :> 2 x,
		"VerbatimLocalVariables" -> True
	]
	,
	HoldPattern[
		HoldPattern[RuleDelayed][
			HoldPattern[
				HoldPattern[Pattern][
					HoldPattern[x], HoldPattern[HoldPattern[Blank][]]
				]
			],
			HoldPattern[HoldPattern[Times][HoldPattern[2], HoldPattern[x]]]
		]
	]
	,
	TestID -> "named patterns: option: \"VerbatimLocalVariables\" -> True"
];


Test[
	HoldAllSubpatterns[
		x_ :> 2 x,
		"VerbatimLocalVariables" -> False,
		Heads -> False
	]
	,
	HoldPattern[
		RuleDelayed[
			HoldPattern[
				Pattern[x_, HoldPattern[Blank[]]]
			]
			,
			HoldPattern[Times[HoldPattern[2], x_]]
		]
	]
	,
	TestID -> "named patterns: options: \
\"VerbatimLocalVariables\" -> False, Heads -> False"
];


Test[
	HoldAllSubpatterns[
		With[{const = "With constant"}, const],
		"VerbatimLocalVariables" -> False
	]
	,
	HoldPattern[
		HoldPattern[With][
			HoldPattern[
				HoldPattern[List][
					HoldPattern[
						HoldPattern[Set][const_, HoldPattern["With constant"]]
					]
				]
			]
			,
			const_
		]
	]
	,
	TestID -> "With constants: option: \"VerbatimLocalVariables\" -> False"
];


Test[
	HoldAllSubpatterns[
		With[
			{const1 = "With constant 1", const2 = "With constant 2"}
			,
			{const1, const2}
		]
		,
		"VerbatimLocalVariables" -> False
	]
	,
	HoldPattern[
		HoldPattern[With][
			HoldPattern[
				HoldPattern[List][
					HoldPattern[
						HoldPattern[Set][
							const1_,
							HoldPattern["With constant 1"]
						]
					]
					,
					HoldPattern[
						HoldPattern[Set][
							const2_,
							HoldPattern["With constant 2"]
						]
					]
				]
			]
			,
			HoldPattern[HoldPattern[List][const1_, const2_]]
		]
	]
	,
	TestID -> "With 2 constants: option: \"VerbatimLocalVariables\" -> False"
];


Test[
	HoldAllSubpatterns[
		With[{const = "With constant"}, const],
		"VerbatimLocalVariables" -> True
	]
	,
	HoldPattern[
		HoldPattern[With][
			HoldPattern[
				HoldPattern[List][
					HoldPattern[
						HoldPattern[Set][
							HoldPattern[const],
							HoldPattern["With constant"]
						]
					]
				]
			]
			,
			HoldPattern[const]
		]
	]
	,
	TestID -> "With constants: option: \"VerbatimLocalVariables\" -> True"
];


Test[
	HoldAllSubpatterns[
		With[{const = "With constant"}, const],
		"VerbatimLocalVariables" -> False,
		Heads -> False
	]
	,
	HoldPattern[
		With[
			HoldPattern[
				{HoldPattern[Set[const_, HoldPattern["With constant"]]]}
			]
			,
			const_
		]
	]
	,
	TestID -> "With constants: options: \
\"VerbatimLocalVariables\" -> False, Heads -> False"
];


Test[
	HoldAllSubpatterns[
		Module[{var = "Module var"}, var],
		"VerbatimLocalVariables" -> False
	]
	,
	HoldPattern[
		HoldPattern[Module][
			HoldPattern[
				HoldPattern[List][
					HoldPattern[
						HoldPattern[Set][var_, HoldPattern["Module var"]]
					]
				]
			]
			,
			var_
		]
	]
	,
	TestID -> "Module variables: option: \"VerbatimLocalVariables\" -> False"
];


Test[
	HoldAllSubpatterns[
		Module[
			{var1 = "Module var 1", var2}
			,
			{var1, var2}
		]
		,
		"VerbatimLocalVariables" -> False
	]
	,
	HoldPattern[
		HoldPattern[Module][
			HoldPattern[
				HoldPattern[List][
					HoldPattern[
						HoldPattern[Set][
							var1_,
							HoldPattern["Module var 1"]
						]
					]
					,
					var2_
				]
			]
			,
			HoldPattern[HoldPattern[List][var1_, var2_]]
		]
	]
	,
	TestID -> "Module 2 variables: option: \"VerbatimLocalVariables\" -> False"
];


Test[
	HoldAllSubpatterns[
		Module[{var = "Module var"}, var],
		"VerbatimLocalVariables" -> True
	]
	,
	HoldPattern[
		HoldPattern[Module][
			HoldPattern[
				HoldPattern[List][
					HoldPattern[
						HoldPattern[Set][
							HoldPattern[var],
							HoldPattern["Module var"]
						]
					]
				]
			]
			,
			HoldPattern[var]
		]
	]
	,
	TestID -> "Module variables: option: \"VerbatimLocalVariables\" -> True"
];


Test[
	HoldAllSubpatterns[
		Module[{var = "Module var"}, var],
		"VerbatimLocalVariables" -> False,
		Heads -> False
	]
	,
	HoldPattern[
		Module[
			HoldPattern[
				{HoldPattern[Set[var_, HoldPattern["Module var"]]]}
			]
			,
			var_
		]
	]
	,
	TestID -> "Module variables: options: \
\"VerbatimLocalVariables\" -> False, Heads -> False"
];


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
