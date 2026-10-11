#import "../lib/ulaval-thesis.typ": article-chapter, long-quote

#article-chapter(
  title: "Titre original du premier article",
  french-abstract: [
    Présentez ici le résumé français de l’article. Lorsqu’un article est rédigé dans
    une autre langue que le français, ce résumé est obligatoire et limité à 150 mots.
  ],
  abstract: [
    Provide the article abstract in its original language. This section is recommended
    and appears in the table of contents alongside the French summary.
  ],
)[
  #set text(lang: "en")

  == Introduction

  Insert the article manuscript here and adapt its typography to the rest of the
  thesis. Do not paste a publisher-formatted PDF.

  == Methods

  Article content can use normal Typst equations, tables, figures, notes, and citations.

  == Results

  This placeholder demonstrates a compliant long quotation:

  #long-quote[
    Long quotations of more than five lines are single-spaced, set as a separate
    paragraph, indented by 10 mm on both sides, and use neither quotation marks nor
    italics.
  ]

  == Discussion

  Relate the article’s results to its objectives. All article references should feed the
  single consolidated bibliography for the thesis.
]
