// Template erstellt von Merlin Jonathan Fischer, fischer@lingua.uni-frankfurt.de

#import "functions.typ": *

///////////// Packages /////////////

#import "@preview/eggs:0.6.0": *
#show: eggs.with(auto-judges: ())
#import abbreviations: *
#let hab = abbreviation[hab][habitual]

#import "@preview/arborly:0.3.2": * // needs function "a"

#import "@preview/numbly:0.1.0": numbly

#import "@preview/citesugar:0.1.0": *
#show cite: citesugar.with(
  forms: (
    "as": (key, suppl) => cite-author-genitive-s(key, supplement: suppl),
    "ps": (key, suppl) => cite-prose-genitive-s(key, supplement: suppl),
  )
)



////////////// Layout //////////////

#let language = "de" //// "de" or "en"
 

#let lang(de, en) = ("de": de, "en": en).at(language)
#set text(
  lang: language,
  size: 12pt,
)

#set enum(full: true, numbering: numbly("{1:1.}", "{2:i.}"))

#set heading(numbering: "1.1")
#show heading: it => block(
  above: 2.2em,
  below: 1.5em,
  it,
)

#set page(
  margin: 2.5cm,
  numbering: "1",
  number-align: right,
)



#set par(
  justify: true,
  leading: 1.5em,
  spacing: 1.5em,
)

#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => ( 
    top: if y <= 1 { 0.8pt } else { 0pt },
    bottom: 0.8pt
  ),
)
#show table: it => {
  set par(leading: 0.8em)
  it
}
#show figure.caption: it => {
  set par(leading: 0.8em)
  it
}

#let original_example(..args) = example(..args)
#let example(..args) = {
  set par(leading: 0.8em)
  original_example(..args)
}



//////////// Title Page ////////////

#let autor = "YOUR NAME" ////
#let titel = "YOUR TITLE" ////
#set document(author: autor, title: titel)
#let datum = lang(datetime.today().display("[day].[month].[year]"), datetime.today().display("[month repr:short]. [day], [year]"))

#place(std.top + std.right, image("Logo-Goethe-University-Frankfurt-am-Main.svg.png", height: 2cm), )
Goethe #lang[Universität][University] Frankfurt am Main

#lang[Fachbereich 10 -- Neuere Philologien][Faculty 10 -- Modern Languages]

#lang[Institut für Linguistik][Department of Linguistics]

Seminar: SEMINAR TITLE ////

#lang[Lehrperson][Lecturer]: LECTURER ////


#align(center)[
  #v(14em)
  #text(size: 20pt, titel)
  #v(1fr)
  #lang[vorgelegt von][submitted by] \ \

  #autor

  #lang[Matrikelnr.][Student number]: 1234567 ////

  E-#lang[M][m]ail: YOUR-EMAIL\@stud.uni-frankfurt.de ////

  BA #lang[Linguistik][Linguistics] ////

  X. #lang[S][s]emester ////
  
  \ \

  Datum: #datum
]



#set par(first-line-indent: 2em)
#pagebreak()

#outline(indent: 1em)
#pagebreak()



/////////////// Text ///////////////

= Introduction

For the first example using Leipzig glossing rules, include this footnote.#footnote[All glossing abbreviations are written in accordance to the Leipzig Glossing Rules. All cited glosses that do not conform to this standard have been adapted to the Leipzig Glossing Rules without further explanation.]<glossings>


= Theoretical background

== Subchapter

=== Subsubchapter

= Some Examples

== Glossings

#example(label: <children>)[
  @mohanan1995wordhood[77--78]
  + - ilaa  #emph[baccõ=ko]@glossings  kʰojtii  rahtii  hai
    - Ila.#nom  children=#acc  search.#smallcaps[hab]  #prog  be.#prs
    'Ila keeps searching for the/some children.'
  + - ilaa  #emph[bacce]  kʰojtii  rahtii  hai
    - Ila.#nom  children.#nom  search.#smallcaps[hab]  #prog  be.#prs
    'Ila keeps children-searching (i.e. performing the act of searching for children).'
]

Reference to @children:b.


== Tables

#figure(
  table(
    align: left,
    columns: (auto, 1fr, auto, auto),
    [],
    [@doner2025linguistics[p:]],
    [@sadock1980noun[p:302f.]],
    [@mohanan1995wordhood[p:79]],

    [uninterruptibility], [a], [f], [i],
    [independence], [b], [a], [],
    [phonological domains], [d], [b], [],
    [speaker intuition], [e], [g], [(p.~94, p.~86)],
    [no conjunction], [], [d], [iv],
    [prosody], [], text(size: 9pt)[@arnhold2018prosody[p:]], [(p.~95)],
    table.cell(colspan: 2)[no modification / question],[], [ii, iii],
  ),
  caption: [Comparison of notions of wordhood.]
) <comparison>





== Trees

#example(
  label: <dpcp>,

  grid(columns: 2)[
    + Noun Incorporation
    #tree(
      style: (
        fit: "band",
        text: (size: 11pt),
      ),
      horizontal-gap: 12pt,
    )[CP [TP [#nu\P [NP [iglu- \ \# house #a(triangle: true)]] [#nu [-liu- \ make]]] [T [-lauq- \ #dist.#pst]]] [C [-tunga \ #decl.1#sg \#]]]
    - iglu-liu-lauq-tuq
    - house-make-#dist.#pst\-#decl.1#sg
    'I made a house.'
  ][
    + Full DP Object
    #tree(
        style: (
          fit: "band",
          text: (size: 11pt),
        ),
        horizontal-gap: 12pt,
      )[CP [TP [#nu\P [VP [DP [iqalung-mi \ \# fish-#obl.#sg \# #a(triangle: true)]] [V [taku \ see]]] [#nu]] [T [-qqau- \ #smallcaps[rec].#pst]]] [C [-junga \ #decl.1#sg \#]]]
    - iqalung-mi  taku-qqau-junga
    - fish-#obl.#sg  see-#smallcaps[rec].#pst\-#decl.1#sg
    'I saw a fish.'
  ]
) // size trees

Example @dpcp:a



#let dotted = a(child-lines: (stroke: (dash: "dotted")))
#example(label: <hindiphase-NI>)[
  #align(center)[anilne kitaabẽ becĩĩ #h(1em) #math.accent("=", "^")]
  #text(size: 14pt)[$ overbrace("                                                                                            ", "")$]
  #v(-1em)
  #grid(
    columns: (1fr, 1fr),

    [
      + 'Anil sold books.' #h(1em) #math.accent("=", "^")
      #tree(
        style: (
          fit: "band",
          text: (size: 11pt),
        ),
        horizontal-gap: 9pt,
        code: {
          agree("a1", "a2", 2)
        },
      )[
        TP
        [
          #nu\P
          [
            DP
            [NP [anil\ Anil #a(triangle: true)]]
            [P #dotted [=ne\ #erg]]
          ]
          [
            VP
            [
              DP
              [kitaabẽ\ books.#nom\ \[#pl.#f\] #a(triangle: true, name: "a1")]
            ]
            [V\ #strike(offset: -2.4pt)[bec-\ sell]]
          ]
        ]
        [T\ becĩĩ\ sold\ \[#emph(sym.phi.alt): #prf.#pl.#f\] #a(name: "a2")]
      ]
    ],

    [
      + 'Anil did book-selling.' #h(1em) #math.accent("=", "^")
      #tree(
        style: (
          fit: "band",
          text: (size: 11pt),
        ),
        horizontal-gap: 6pt,
        code: {
          agree("a1", "a2", 2.3)
        },
      )[
        TP
        [
          #nu\P
          [
            DP
            [NP [anil\ Anil #a(triangle: true)]]
            [P #dotted [=ne\ #erg]]
          ]
          [
            VP
            [~~]
            [
              V
              [N\ #strike(offset: -2.4pt)[kitaabẽ\ books.#nom\ ]\[#pl.#f\] #a(name: "a1")]
              [V\ #strike(offset: -2.4pt)[bec-\ sell]]
            ]
          ]
        ]
        [
          T
          [kitaabẽ becĩĩ\ did book-selling\ \[#emph(sym.phi.alt): #prf.#pl.#f\] #a(triangle: true,name: "a2")]
        ]
      ]
    ]
  )
]



= Discussion & Conclusion



//////////// End of Text ////////////



#pagebreak()
= #lang[Bibliografie][Bibliography]

#set par(first-line-indent: 0pt)
#bibliography("refs.bib", style: "unified-style-sheet-for-linguistics.csl", title: none)




#pagebreak()
= #lang[Selbstständigkeitserklärung][Declaration of authorship]

#lang[
  Ich versichere hiermit an Eides statt, dass die vorliegende schriftliche Arbeit nach den Regeln guter wissenschaftlicher Praxis angefertigt wurde. Ich habe die Arbeit selbstständig verfasst und alle benutzten Quellen und Hilfsmittel angegeben. Alle Stellen, die wörtlich oder annähernd wörtlich oder sinngemäß aus Veröffentlichungen oder unveröffentlichten fremden Texten entnommen sind, habe ich als solche kenntlich gemacht. Dies bezieht sich auch auf die in der Arbeit gelieferten Zeichnungen, Skizzen, bildlichen Darstellungen und dergleichen. Ich habe beim Abfassen der Arbeit ausschließlich zulässige Hilfsmittel und diese in zulässiger Weise (gemäß den mir gemachten Vorgaben) verwendet. Generative KI (wie z.B. ChatGPT) wurde nicht zum Erstellen des eigenen Texts genutzt. Inwiefern KI ggf. im Arbeitsprozess zur Unterstützung herangezogen wurde, ist im Anhang zur Arbeit genau offengelegt. Diese Arbeit wurde noch nicht, auch nicht auszugsweise, für eine andere Studien- oder Prüfungsleistung verwendet. Mir ist bekannt, dass ein Verstoß gegen diese Regeln als Täuschung im Sinne der Studien- und Prüfungsordnung gewertet und entsprechend sanktioniert werden kann.
][
  I hereby affirm in lieu of an oath that this written work has been prepared in accordance with the rules of good scientific practice. I have authored the work independently and have cited all sources and aids used. All passages that are quoted verbatim, approximately verbatim, or paraphrased from publications or unpublished texts by others are clearly indicated as such. This includes the drawings, sketches, illustrations, and similar materials provided in the work. In writing this paper, I have used only permissible aids and have used them in an acceptable manner according to the guidelines provided to me. Generative AI (such as ChatGPT) was not used to create my own text. Any assistance from AI in the work process is disclosed in detail in the appendix of the paper. This work has not been used, even in part, for another course requirement or examination. I am aware that a violation of these rules may be considered deceit in the sense of the study and examination regulations and may be sanctioned accordingly.
]

#v(1fr)

Frankfurt am Main, #datum
#v(1.5cm)  //// Signature