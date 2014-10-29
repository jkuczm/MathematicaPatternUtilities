(* ::Package:: *)

Get["https://raw.githubusercontent.com/jkuczm/MathematicaBootstrapInstaller/v0.1.1/BootstrapInstaller.m"]


BootstrapInstall[
	"PatternUtilities",
	"https://github.com/jkuczm/MathematicaPatternUtilities/releases/download/v0.1.0/PatternUtilities.zip",
	"AdditionalFailureMessage" ->
		Sequence[
			"You can ",
			Hyperlink[
				"install PatternUtilities package manually",
				"https://github.com/jkuczm/MathematicaPatternUtilities#manual-installation"
			],
			"."
		]
]
