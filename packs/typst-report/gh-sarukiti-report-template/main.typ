#import "@preview/codelst:2.0.2": sourcecode, sourcefile, lineref, code-frame
#import "@preview/cjk-unbreak:0.1.0": remove-cjk-break-space
#import "cover.typ": cover
#import "@preview/enja-bib:0.1.0": *
#import bib-setting-plain: *
#show: bib-init

#let font_sizes = (h1: 18pt, h2: 16pt, h3: 14pt, h4: 12pt, normal: 10.5pt, math: 12pt)
#let code_fonts = ("UDEV Gothic 35NF")
#let math_fonts = ("New Computer Modern Math")
#let serif_fonts = (
  "Times New Roman", // half-width (ASCII)
  "YuMincho",
)
#let sans_fonts = (
  "Arial", // half-width (ASCII)
  "YuGothic",
)
#let leading_size = 1.0em
#let spacing_size = 1.2em

#set heading(numbering: "1.")
#set math.equation(supplement: "式", numbering: numbering.with("(1.1)"))
#set text(font: serif_fonts, size: font_sizes.normal)
#set par(
  first-line-indent: (
    all: true,
    amount: 1em,
  ),
  leading: leading_size, spacing: spacing_size, justify: true,
)
#set page(
  paper: "a4",
  columns: 1,
  margin: (bottom: 1.5cm, top: 1.5cm, left: 1.5cm, right: 1.5cm),
  footer: context[ #align(center)[#counter(page).display()] ],
)

#show figure.where(kind: image): set figure(supplement: "図")
#show figure.where(kind: table): set figure(supplement: "表")
#show figure.where(kind: image): set text(font: sans_fonts, size: font_sizes.normal)
#show figure.where(kind: table): set text(font: sans_fonts, size: font_sizes.normal)
#show figure.where(kind: "bib"): set text(font: serif_fonts, size: font_sizes.normal)
#show table: set text(font: sans_fonts, size: font_sizes.normal)
#show math.equation: set text(font: math_fonts, size: font_sizes.math)
#show raw: set text(font: code_fonts, size: font_sizes.normal)
#show heading: set text(font: sans_fonts, size: font_sizes.normal, weight: "medium")
#show heading: it => {
  set par(first-line-indent: 0em)
  if it.numbering != none {
    let num = counter(heading).display(it.numbering)
    [#num#h(1.0em)#it.body]
  } else {
    [#it #h(1.0em)]
  }
}

#show: remove-cjk-break-space // from @preview/cjk-unbreak

#cover(
  title: "",
  exp_dates: ("",),
  submit_date: "",
  serial_no: "",
  student_id: "",
  author_name: ""
)

#counter(page).update(1)

// 本文

/*
#bibliography-list(
  title: [参考文献],
  ..bib-file(
    read("参考文献.bib"),
    bibtex-book-ja: (
      ("author", (none, "", author-set3, "", ", ", (), ".")),
      ("title", (none,"「",all-return, "」", ", ", (), ".")),
      ("editor", (none,"",all-return, "", ", ", (), ".")),
      ("page", (none,"p.",all-return, "", ", ", (), ".")),
      ("pages", (none,"pp.",all-return, "", ", ", (), ".")),
      ("publisher", (none,"",all-return, "", ", ", (), ".")),
      ("year", (none, "", all-return, "", ", ", (), ".")),
    ),
    bibtex-online-ja: (
      ("author", (none, "", author-set3, "", ", ", (), ".")),
      ("title", (none,"「", all-return, "」", ", ", (), ".")),
      ("publisher", (none,"",all-return, "", ", ", (), ".")),
      ("url", (none,"",all-return, "", ", ", (), ".")),
      ("access", (none, "", all-return, "", ", ", (), "参照.")),
    ),
  ),
)
*/
