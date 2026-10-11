#import "main.typ" as biorxiv

#show: biorxiv.template.with(
	journal:    "BioRxiv",  // "Cell Reports"
	supertitle: "Preprint", // "Resource"
	title:      "On Doing a project",
	authors:    ("John Doe", "Jane Rue"),
	//doi:      "10.1016/j.cell.2006.07.024",
)

// === [ Summary ] =============================================================

#biorxiv.summary[
	#lorem(200)
]

// === [ Introduction ] ========================================================

= Introduction

#lorem(300) @takahashi2006induction

// === [ Results ] =============================================================

= Results

#lorem(4445)

As seen in @tbl-foo ...

#figure(
	caption: lorem(5),
	table(
		columns: 3,
		biorxiv.toprule(),
		table.header[*foo*][*bar*][*baz*],
		biorxiv.midrule(),
		[a], [b], [c],
		[a], [b], [c],
		[a], [b], [c],
		biorxiv.bottomrule(),
	),
) <tbl-foo>

// === [ Discussion ] ==========================================================

= Discussion

#lorem(625)

// === [ Bibliography ] ========================================================

#bibliography("references.bib")

// === [ Methods ] =============================================================

#set page(columns: 1)

= Methods

#lorem(1505)
