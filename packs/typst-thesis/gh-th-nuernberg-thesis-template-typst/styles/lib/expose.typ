/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "parameters.typ" : p, thesis-parameters
#import "translations.typ" : t
#import "util.typ" : *

#let expose(
  /// Title of the thesis or report.
  title: none,

  /// Author of this thesis or report.
  author: none,

  /// Date of this work, defaults to today.
  date: datetime.today(),

  /// Bibliography to use for this document.
  bibliography-file: none,

  /// Citation standard to use, see https://typst.app/docs/reference/model/bibliography for a full list. Alphanumeric is supported.
  bibliography-style: "ieee",

  /// Type of this thesis expose, can be "bachelor" or "master".
  type: none,

  /// Language of this document, only "de", "en" are fully supported.
  lang: none,

  /// Name of the examiner or list of names if multiple examiners.
  examiners: none,

  /// Name of the supervisor or list of names if multiple supervisors.
  supervisors: none,

  /// List of keywords for the title page.
  keywords: none,

  /// Company that supported this thesis.
  company: none,

  /// Don't emit any parts of the document itself, only set the styling options. Structure can be set up manually using the thesis-* functions.
  manual: false,

  /// Thesis content, use as global show rule is encouraged.
  body,
) = {
  // Validate parameters
  if not ("bachelor", "master").contains(type) {
    panic("Set either 'bachelor' or 'master' as the document type option")
  }
  let lang-base = lang.split("-").at(0)
  if not ("de", "en").contains(lang-base) {
    panic("Set either 'de' or 'en' as the document language")
  }

  thesis-parameters.update((
    title: title,
    author: author,
    date: date,
    bibliography-file: bibliography-file,
    bibliography-style: bibliography-style,
    type: type,
    lang: lang,
    supervisors: supervisors,
    examiners: examiners,
    keywords: keywords,
    company: company,
    manual: manual,
  ))

  // Set document properties if given
  if title != none { set document(title: title) }
  if author != none { set document(author: author) }
  if keywords != none { set document(keywords: keywords) }
  context { set document(description: [Exposé #t("for_a") #t(p("type"))]) }

  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 3cm, x: 2cm),
    header-ascent: 1cm,
    columns: 2,
    header: context {
      set align(center)
      set text(8pt)
      if here().page() == 1 [
        #t("faculty") #t("at_uni")
        #if company != none [#t("and") #p("company")]
      ] else [
        Exposé: #p("title")
      ]
    },
    footer: context {
      set align(center)
      set text(8pt)
      if here().page() == 1 [
        #smallcaps(t("city")) #date.display("[year]")
      ] else [
        #t("page") #counter(page).display(t("numbering-1of1"), both: true)
      ]
    },
  )

  set columns(gutter: 8mm)
  set par(justify: true)

  set text(
    lang: lang-base,
    font: "New Computer Modern",
    weight: "medium",
    size: 10pt,
  )

  // Show rules for common abbreviations
  include "text-show-rules.typ"

  // Title section
  place(
    top + center,
    float: true,
    scope: "parent",
    context {
      let examiners = normalize-multivalue(p("examiners"))
      let supervisors = normalize-multivalue(p("supervisors"))
      stack(
        spacing: 0.75em,
        text(size: 20.74pt, weight: "bold", title),
        v(2em),
        text(size: 12pt)[#author, Exposé #t("for_a") #t(p("type"))],
        if examiners != none {
          if examiners.len() == 1 [#t("examiners-singular"): ] else [#t("examiners-plural"): ]
          examiners.join(", ")
        },
        if supervisors != none {
          if supervisors.len() == 1 [#t("supervisors-singular"): ] else [#t("supervisors-plural"): ]
          supervisors.join(", ")
        },
      )
      v(2em)
    }
  )

  body

  context if bibliography-file != none {
    heading(numbering: none, outlined: true, t("BIB"))
    set text(size: 8pt)
    bibliography(
      "../../" + bibliography-file,
      title: none,
      style: if bibliography-style == "alphanumeric" { "ieee" } else { bibliography-style },
    )
  }
}
