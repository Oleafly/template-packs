#import "pages/cover.typ": cover
#import "pages/decl.typ": decl
#import "pages/abstract.typ": abstract
#import "pages/abstract-en.typ": abstract-en
#import "layouts/doc.typ": doc
#import "layouts/preface.typ": preface
#import "pages/outline-page.typ": outline-page
#import "layouts/mainmatter.typ": mainmatter
#import "layouts/glossary.typ": gloss, make-glossary-table
#import "pages/acknowledgement.typ": acknowledgement
#import "layouts/appendix.typ": appendix
#import "utils/bilingual.typ": bibliography
#import "@preview/gb7714-bilingual:0.2.3": init-gb7714, multicite
#import "@preview/pointless-size:0.1.2": zh

#let documentclass(
  info: (:),
  twoside: false,
  anonymous: false,
  font: "SimSun",
  reference-data: none,
  reference-font: ("Times New Roman", "SimSun"),
  reference-font-size: zh(5),
  reference-show-url: false,
  reference-show-doi: false,
  reference-show-accessed: false,
  prose-offset: 0em,
) = {
  return (
    doc: (body, ..args) => {
      doc(body, ..args, info: info + args.named().at("info", default: (:)))
    },
    init-bib: body => {
      show: init-gb7714.with(
        reference-data,
        style: "numeric",
        version: "2025",
        show-url: reference-show-url,
        show-doi: reference-show-doi,
        show-accessed: reference-show-accessed,
      )
      body
    },
    cover: (..args) => {
      cover(
        anonymous: anonymous,
        ..args,
        info: info,
      )
    },
    decl: (..args) => decl(
      anonymous: anonymous,
      twoside: twoside,
      ..args,
      info: info,
    ),
    abstract: (..args) => abstract(
      twoside: twoside,
      info: info,
      font: font,
      ..args,
    ),
    abstract-en: (..args) => abstract-en(
      twoside: twoside,
      info: info,
      ..args,
    ),
    preface: (..args) => preface(
      twoside: twoside,
      ..args,
    ),
    outline-page: (..args) => outline-page(
      twoside: twoside,
      font: font,
      ..args,
    ),
    mainmatter: (..args) => mainmatter(
      twoside: twoside,
      font: font,
      prose-offset: prose-offset,
      ..args,
    ),
    gloss: gloss,
    make-glossary-table: make-glossary-table,
    no-indent: body => par(first-line-indent: 0em, body),
    bibliography: (..args) => bibliography(
      font: reference-font,
      font-size: reference-font-size,
      prose-offset: prose-offset,
      ..args,
    ),
    multicite: multicite,
    acknowledgement: (..args) => {
      acknowledgement(
        anonymous: anonymous,
        twoside: twoside,
        font: font,
        ..args,
      )
    },
    appendix: (..args) => {
      appendix(
        ..args,
      )
    },
    twoside: twoside,
  )
}
