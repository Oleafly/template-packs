#import "lib.typ": book, paper
#import "@preview/typsium:0.2.0": ce
#import "@preview/fancy-units:0.1.1": unit
// cSpell:disable
#let abbreviations = (
("AI", [_ab initio_]),
("CHA", "chabazite"),
("CMM", "Center for Molecular Modeling"),
)


#let quote = [
  #v(4cm)
#align(center)[Inspiring quote goes here.]
//#v(20pt)
#align(right)[_yourself_]
]

// Spellcheck can be enabled for specific parts of text through using //cSpell:enable and //cSpell:disable

#let preface = [// cSpell:enable
Thank you.
#v(20pt)
#align(right)[X Y \ Gent, d m yyyy]// cSpell:disable
]
// cSpell:enable
#let AIuse = [
In this work, generative artificial intelligence was used in accordance with the #link("https://www.ugent.be/en/ghentuniv/mission/genai/")[framework for responsible use of generative AI of Ghent University]. More specifically, ...
]

#let summary = [

Your summary of min. 1000 words.

]
// cSpell:disable
#let samenvatting = [#set text(lang: "nl")

Uw samenvatting van min. 1000 woorden.

]

#let supp1 = (
  number: "I",
  title: [
    Supporting Information for:\
    Your Fancy Paper
  ],
  authors: [Your Name, X Y],
  journal: [_Journal of Fancy Papers_, *2024*, _20_, 9, 3000--3001],
  contributor: "X performed Y, Z performed A.",
  copyright: "Some copyright statement.",
  num_pages: 10, // set to correct number
  location: "papers/paper1/si/flattened",
)

#let paper1 = (
  number: "I",
  title: [
    Your Fancy Paper
  ],
  authors: [X Y],
  journal: [_Journal of Fancy Papers_, *2024*, _20_, 9, 3000--3001],
  contributor: "X performed Y, Z performed A.",
  copyright: "Some copyright statement.",
  num_pages: 16, //set to correct number
  location: "papers/paper1/main/flattened",
  supp: supp1
) 

#let supp2 = (
  number: "II",
  title: [
    Supporting Information for:\
    Your Fancy Paper 2
  ],
  authors: [Your Name, X Y],
  journal: [_Journal of Fancy Papers_, *2024*, _20_, 9, 3000--3001],
  contributor: "X performed Y, Z performed A.",
  copyright: "Some copyright statement.",
  num_pages: 4, // set to correct number
  location: "papers/paper2/si/flattened",
)

#let paper2 = (
  number: "II",
  title: [
    Your Fancy Paper 2
  ],
  authors: [X Y],
  journal: [_Journal of Fancy Papers_, *2025*, _20_, 9, 3000--3001],
  contributor: "X performed Y, Z performed A.",
  copyright: "Some copyright statement.",
  num_pages: 6, //set to correct number
  location: "papers/paper2/main/flattened",
  supp: supp2
) 

#let talks = (
  (
    title: [Talk about Fancy Paper],
    authors: [Your Name],
    event: "NCCC",
    date: "March 2026",
    location: "Noordwijkerhout, The Netherlands",
  ),
)

#let posters= (
  (
    title: [Your Fancy Poster],
    authors: [Your Name],
    event: "Conference of Fancy Posters",
    date: "September 2023",
    location: "Leuven, Belgium",
  ),
)

#let software = (
  (
  name: "Typst",
  description: [Typst is an open-source, markup-based typesetting system, which the author sincerely hopes is the final nail in the coffin for `LaTeX`.\
  #link("typst.app")]
  ),
)


#let acknowledgements = grid(
    columns: 1,
    row-gutter: 5mm,
    align: (center + top, center + top),
    image("logos/ugent.png", width:100%),
    [Funding was received from the European Union's Horizon 2020 research and innovation programme under the European Research Council consolidator grant agreement no. 647755 (project acronym: DYNPOR).],
    image("logos/dynpor.png", width: 100%),
    [The resources and services used in this work were provided by the VSC (Flemish Supercomputer Center), funded by the Research Foundation -- Flanders (FWO) and the Flemish Government. HPC-UGent provided access and support for the UGent Tier-2 systems. Additionally, we acknowledge the EuroHPC Joint Undertaking for awarding part of this project access to the EuroHPC supercomputer LUMI, hosted by CSC (Finland) and the LUMI consortium through a EuroHPC Regular Access call.],
    image("logos/computelogos.png", width: 20em),
)

#show: book.with(
  title: [Your \ Fancy \ Title],
  author: "Your Name",
  supervisors: ("Your Supervisor"),
  abbreviations: abbreviations,
  quote: quote,
  preface: preface,
  AIuse: AIuse,
  summary: summary,
  samenvatting: samenvatting,
  papers: (paper1,paper2), // effectief in te voegen
  allpapers: (paper1,paper2), // niet per se in te voegen
  talks: talks,
  posters: posters,
  software: software,
  acknowledgements: acknowledgements,
)

 // #set par.line(numbering:"1", numbering-scope: "page")
// cSpell:enable
= Introduction<chap:introduction>
#v(2em)

I wish the PhD had never come to me. But now that I am here, I guess I'll show you how to insert a figure. For example, @fig:gasp.

#figure(
  image("figures/introduction/gasp.pdf", width: 95%),
  caption: "Excerpts from landmark publications by Dirac (top, copyright Royal Society)"+[@Dirac1928Roy]+" and The Event Horizon Telescope Collaboration (middle, copyright AAS)"+[@Akiyama2019TheAst]+", and the Wow!-signal (SETI) (bottom, licensed under CC BY 4.0)."+[@mendez_arecibo_2025],
) <fig:gasp>

Or a fancy table, for example @tab:systems-overview.

#let bubble(size) = box(circle(
  radius: size/1.4, 
  fill: gray.darken(20%), // Or use a colour like blue.lighten(20%)
  stroke: 0.5pt + black
),
inset: (top: 0pt, bottom: 0pt),
)
#figure(
  // Wrap the table in a text function to scope the size
  text(size: 8pt, table(
    columns: (1.1fr, 2.6fr, .9fr, 1fr, 2.4fr, 1.3fr), 
    inset: 5pt,
    align: horizon,
    stroke: none,
    
    // Header row
    table.hline(stroke: 1pt),
    [#box[*system*] \ *pore size* ], [*structure \ pore aperture \ (state -- EF species)*], [*main isotopes*], [*exp. \ method*], [*comp. method*], [*chapter/paper*],
    table.hline(stroke: 1pt),
    
    // Data rows
    [TAPD COFs \ #bubble(27pt)], [limited geometric or layer stacking disorder \ 13--27 Å \ (solid -- none)], [$""^13$C,\ $""^15$N], [CPMAS NMR], [static (periodic), symmetry-based spatial averaging], [Paper I],
     [Tp COFs \ #bubble(20pt)],  [limited geometric or layer stacking disorder \ 18--19 Å \ (solid -- none)], [$""^13$C,\ $""^15$N], [CPMAS NMR], [static (periodic), symmetry-based spatial averaging], [Paper II],
     [JBW \ zeolite \ #bubble(4.3pt)], [limited geometric disorder, defect-free, known Al distribution \ 3.7 Å \ (solid -- Na, K, #box()[H$""_2$O])], [$""^27$Al$""^dagger.double$,\ $""^29$Si,\ $""^23$Na$""^dagger$], [1D MAS NMR], [static and dynamic (periodic), symmetry-based spatial averaging and dynamic averaging], [Paper III],
     [LTJ/EDI zeolite\ #bubble(4.1pt)/#bubble(5.7pt)], [limited geometric disorder, multiple crystals in sample, known Al distribution \ 3.1 Å/3.4 Å \ 
     (solid -- K, #box()[H$""_2$O], #box()[OH$""^-$])], [$""^27$Al$""^dagger.double$,\ $""^29$Si], [1D MAS NMR], [dynamic (periodic), symmetry-based spatial averaging and dynamic averaging], [],
     [CHA\ zeolite \ #bubble(7.4pt)], [geometric and Al disorder, defective, unknown Al distribution \ 3.7 Å \ (solid -- #box()[H$""_2$O], #box()[H$""_3$O$""^+$)]], [$""^27$Al$""^dagger.double$,\ $""^29$Si], [1D MAS NMR], [static and dynamic (periodic), dynamic averaging], [Paper V],
     [HSILs\ N.A.], [diverse local environments, hindered dynamics \ N.A. \ (liquid -- N.A.)], [$""^23$Na$""^dagger$, $""^133$Cs$""^dagger.triple$], [1D MAS NMR], [dynamic (cluster), no averaging], [Paper IV],
    table.hline(stroke: 1pt),
     )),
  caption: [Overview of systems studied in this work. Columns from left to right contain: system abbreviation / schematic relative largest pore size, details on the structure / pore aperture /state -- presence of extraframework (EF) species, main NMR isotopes employed, experimental method, computational method and where the results may be found in this work.\
  Quadrupolar nuclei are labelled: spin-$3/2$ ($""^dagger$), spin-$5/2$ ($""^dagger.double$), spin-$7/2$ ($""^dagger.triple$).],
  supplement: [Table],
  kind: table,
) <tab:systems-overview>

== Sublevel 1 title
=== Sublevel 2 title

= NMR and computational modelling of nanostructured materials<chap:mod-mat>

Another chapter, sigh.

= Conclusions & outlook<chap:conclusions>
Repeat for the 10th time what you did here.

#pagebreak(to: "odd")

