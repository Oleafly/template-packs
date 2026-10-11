// sapthesis.typ -- Typst port inspired by Francesco Biccari's LaTeX sapthesis class.
// Upstream LaTeX class: sapthesis v5.1, LPPL 1.3, https://ctan.org/pkg/sapthesis

#let sap-red = rgb("#822433")

#let _labels(language) = {
  if language == "italian" {
    (
      id_number: "Matricola",
      advisor: "Relatore",
      advisors: "Relatori",
      coadvisor: "Correlatore",
      coadvisors: "Correlatori",
      director: "Direttore",
      directors: "Direttori",
      cycle: "ciclo",
      academic_year: "Anno Accademico",
      not_defended: "Tesi non ancora discussa",
      defended_on: "Tesi discussa il",
      examiners_intro: "di fronte a una commissione esaminatrice composta da",
      sapienza_name: "Sapienza Università di Roma",
      version: "Versione",
      website: "Sito web",
      acknowledgments: "Ringraziamenti",
      abstract: "Sommario",
      all_rights: "Tutti i diritti riservati",
      information: "Questa tesi è stata composta con Typst e il template sapthesis.typ",
      email: "Email dell'autore",
      reviewers: "Revisori",
    )
  } else {
    (
      id_number: "ID number",
      advisor: "Advisor",
      advisors: "Advisors",
      coadvisor: "Co-Advisor",
      coadvisors: "Co-Advisors",
      director: "Director",
      directors: "Directors",
      cycle: "cycle",
      academic_year: "Academic Year",
      not_defended: "Thesis not yet defended",
      defended_on: "Thesis defended on",
      examiners_intro: "in front of a Board of Examiners composed by",
      sapienza_name: "Sapienza University of Rome",
      version: "Version",
      website: "Website",
      acknowledgments: "Acknowledgments",
      abstract: "Abstract",
      all_rights: "All rights reserved",
      information: "This thesis has been typeset by Typst and the sapthesis.typ template",
      email: "Author's email",
      reviewers: "Reviewers",
    )
  }
}

#let _layout(layout, binding: 0pt, two_sided: true) = {
  let base = if layout == "a5" or layout == "a5paper" {
    (
      paper: "a5",
      font_size: 10pt,
      logo_width: 4cm,
      title_height: 9.3cm,
      indent: 1.38cm,
      title_size: 17pt,
      subtitle_size: 10pt,
      inner: 16.3mm,
      outer: 26.3mm,
      top: 15.1mm,
      bottom: 24.5mm,
    )
  } else if layout == "b5" or layout == "b5paper" {
    (
      paper: "b5",
      font_size: 10pt,
      logo_width: 4cm,
      title_height: 11.4cm,
      indent: 1.38cm,
      title_size: 17pt,
      subtitle_size: 10pt,
      inner: 21.6mm,
      outer: 34.9mm,
      top: 21.7mm,
      bottom: 35.0mm,
    )
  } else {
    (
      paper: "a4",
      font_size: 11pt,
      logo_width: 5cm,
      title_height: 12.8cm,
      indent: 1.72cm,
      title_size: 20pt,
      subtitle_size: 12pt,
      inner: 27.1mm,
      outer: 43.8mm,
      top: 27.4mm,
      bottom: 44.3mm,
    )
  }

  let margin = if two_sided {
    (inside: base.inner + binding, outside: base.outer, top: base.top, bottom: base.bottom)
  } else {
    let horizontal = (base.inner + base.outer) / 2
    (left: horizontal + binding, right: horizontal, top: base.top, bottom: base.bottom)
  }

  base + (margin: margin)
}

#let _need(value, message) = {
  assert(value != none, message: message)
}

#let _need_nonempty(items, message) = {
  assert(items.len() > 0, message: message)
}

#let _render-lines(items, gap: 1mm) = {
  for i in range(items.len()) {
    items.at(i)
    if i + 1 < items.len() {
      linebreak()
      v(gap)
    }
  }
}

#let _plural-label(items, singular, plural, custom: none) = {
  if custom != none { custom } else if items.len() == 1 { singular } else { plural }
}

#let _title-page(
  title,
  subtitle,
  alttitle,
  author,
  id_number,
  course,
  course_organizer,
  academic_year,
  advisors,
  coadvisors,
  directors,
  cycle,
  labels,
  layout,
  logo,
  advisor_label: none,
  coadvisor_label: none,
  director_label: none,
  title_font: "New Computer Modern",
) = {
  set text(font: title_font, size: layout.font_size)
  set par(justify: false, leading: 0.55em)

  v(-10mm)
  image(logo, width: layout.logo_width)
  v(0pt)

  pad(left: layout.indent)[
    #block(width: 100%, height: layout.title_height)[
      #v(1fr)
      #text(fill: sap-red, size: layout.title_size, weight: "regular")[#title]
      #if subtitle != none [
        #v(4mm)
        #text(fill: sap-red, size: layout.subtitle_size)[#subtitle]
      ] else if alttitle != none [
        #v(10mm)
        #text(fill: sap-red, size: layout.title_size)[#alttitle]
      ]
      #v(1fr)
    ]
  ]

  pad(left: layout.indent)[
    #text(fill: sap-red)[
      #course_organizer\
      #course#if cycle != none [ (#cycle #labels.cycle)]
    ]

    #v(9mm)
    #strong(author)\
    #labels.id_number #id_number

    #v(9mm)
    #grid(columns: (1fr, 1fr), gutter: 15mm)[
      #_plural-label(advisors, labels.advisor, labels.advisors, custom: advisor_label)\
      #_render-lines(advisors)
    ][
      #if coadvisors.len() > 0 [
        #_plural-label(coadvisors, labels.coadvisor, labels.coadvisors, custom: coadvisor_label)\
        #_render-lines(coadvisors)
      ]
    ]

    #if directors.len() > 0 [
      #v(9mm)
      #_plural-label(directors, labels.director, labels.directors, custom: director_label)\
      #_render-lines(directors, gap: 0.75mm)
    ]
  ]

  v(1fr)
  pad(left: layout.indent)[#labels.academic_year #academic_year]
}

#let _back-title-page(
  title,
  author,
  author_email,
  copyyear,
  labels,
  no_exam_info,
  exam_date,
  examiners,
  reviewers,
  reviewer_label,
  extra_info,
  thesis_type,
  isbn,
  copyright_statement,
  version_date,
  website,
) = {
  set par(justify: false, leading: 0.55em)
  set text(size: 10pt)

  v(1cm)

  if extra_info != none {
    extra_info
    v(1.5cm)
  }

  if not no_exam_info {
    if exam_date == none and examiners.len() == 0 {
      labels.not_defended
    } else {
      assert(exam_date != none, message: "sapthesis: exam_date is required when examiners are given")
      assert(examiners.len() > 0, message: "sapthesis: at least one examiner is required when exam_date is given")
      [#labels.defended_on #exam_date\
        #labels.examiners_intro:#v(2mm)
        #_render-lines(examiners, gap: 0.75mm)]
    }
  }

  v(1cm)

  if reviewers.len() > 0 {
    [#if reviewer_label == none { labels.reviewers } else { reviewer_label }:#v(2mm)
      #_render-lines(reviewers)]
  }

  v(1fr)
  line(length: 100%)
  v(2mm)
  set text(size: 8.8pt)

  [
    #strong(title)\
    #if thesis_type != none [#thesis_type. ]#labels.sapienza_name\
    #if isbn != none [ISBN: #isbn]
    #linebreak()
    #if copyright_statement == none [© #copyyear #author. #labels.all_rights] else [#copyright_statement]
    #v(1.5mm)

    #labels.information.#linebreak()
    #if version_date != none [#labels.version: #version_date#linebreak()]
    #if website != none [#labels.website: #link(website)[#website]#linebreak()]
    #labels.email: #link("mailto:" + author_email)[#author_email]
  ]
}

#let _header() = context {
  set text(size: 9pt, weight: "bold")
  align(right)[#counter(page).display()]
  line(length: 100%, stroke: 0.4pt)
}

/// Apply the Sapienza thesis layout and title pages to a Typst document.
#let sapthesis(
  title: none,
  subtitle: none,
  alttitle: none,
  author: none,
  id_number: none,
  course: none,
  course_organizer: none,
  academic_year: none,
  copyyear: none,
  author_email: none,
  advisors: (),
  coadvisors: (),
  directors: (),
  cycle: none,
  thesis_type: none,
  exam_date: none,
  examiners: (),
  reviewers: (),
  reviewer_label: none,
  extra_info: none,
  isbn: none,
  copyright_statement: none,
  version_date: none,
  website: none,
  language: "english",
  paper: "a4",
  binding: 0pt,
  two_sided: true,
  no_exam_info: false,
  logo: "assets/sapienzalogo.pdf",
  advisor_label: none,
  coadvisor_label: none,
  director_label: none,
  font: ("New Computer Modern", "Libertinus Serif"),
  title_font: "New Computer Modern",
  body,
) = {
  _need(title, "sapthesis: title is required")
  _need(author, "sapthesis: author is required")
  _need(id_number, "sapthesis: id_number is required")
  _need(course, "sapthesis: course is required")
  _need(course_organizer, "sapthesis: course_organizer is required")
  _need(academic_year, "sapthesis: academic_year is required")
  _need(copyyear, "sapthesis: copyyear is required")
  _need(author_email, "sapthesis: author_email is required")
  _need_nonempty(advisors, "sapthesis: at least one advisor is required")

  let labels = _labels(language)
  let layout = _layout(paper, binding: binding, two_sided: two_sided)
  let lang-code = if language == "italian" { "it" } else { "en" }

  set document(title: title, author: author)
  set text(font: font, size: layout.font_size, lang: lang-code)
  set par(justify: true, leading: 0.55em)
  set page(
    paper: layout.paper,
    margin: layout.margin,
    header: _header(),
    footer: none,
    numbering: "i",
  )
  set heading(numbering: none)
  show figure: set block(above: 1em, below: 1em)

  {
    set page(paper: layout.paper, margin: layout.margin, header: none, footer: none, numbering: none)
    _title-page(
      title,
      subtitle,
      alttitle,
      author,
      id_number,
      course,
      course_organizer,
      academic_year,
      advisors,
      coadvisors,
      directors,
      cycle,
      labels,
      layout,
      logo,
      advisor_label: advisor_label,
      coadvisor_label: coadvisor_label,
      director_label: director_label,
      title_font: title_font,
    )
    pagebreak()
    _back-title-page(
      title,
      author,
      author_email,
      copyyear,
      labels,
      no_exam_info,
      exam_date,
      examiners,
      reviewers,
      reviewer_label,
      extra_info,
      thesis_type,
      isbn,
      copyright_statement,
      version_date,
      website,
    )
    pagebreak()
  }

  counter(page).update(1)
  set page(
    paper: layout.paper,
    margin: layout.margin,
    header: _header(),
    footer: none,
    numbering: "i",
  )
  body
}

/// Switch to front matter: roman page numbers and unnumbered headings.
#let frontmatter() = {
  pagebreak(weak: true)
  counter(page).update(1)
  set page(numbering: "i")
  set heading(numbering: none)
}

/// Switch to main matter: Arabic page numbers and numbered level-1/2 headings.
#let mainmatter() = {
  pagebreak(weak: true)
  counter(page).update(1)
  set page(numbering: "1")
  set heading(numbering: "1.1")
}

/// Switch to back matter: Arabic page numbers and unnumbered headings.
#let backmatter() = {
  pagebreak(weak: true)
  set page(numbering: "1")
  set heading(numbering: none)
}

/// Typeset a dedication page.
#let dedication(body) = {
  pagebreak(weak: true)
  v(5cm)
  align(right)[#emph(body)]
  v(1fr)
  pagebreak()
}

/// Typeset an abstract-like front-matter section.
#let abstract(title: none, body) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: true)[#if title == none { _labels("english").abstract } else { title }]
  v(5mm)
  body
}

/// Typeset an acknowledgments section.
#let acknowledgments(title: none, body) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: true)[#if title == none { _labels("english").acknowledgments } else {
    title
  }]
  v(5mm)
  emph(body)
}

// Small scientific helpers inspired by the LaTeX class.
#let degree = [°]
#let g = degree
#let celsius = [°C]
#let C = celsius
#let angstrom = [Å]
#let A = angstrom
#let micro = [µ]
#let ohm = [Ω]
#let eu = $upright(e)$
#let iu = $upright(i)$
#let unit(body) = $upright(#body)$
#let un = unit
#let rb(body) = $attach(none, b: upright(#body))$
#let rp(body) = $attach(none, t: upright(#body))$
#let tb(body) = text(size: 0.7em, baseline: -0.25em)[#body]
#let tp(body) = super(body)
#let diff(roman: false) = if roman { $upright(d)$ } else { $d$ }
#let der(f, x, order: none, roman_diff: false) = {
  let d = diff(roman: roman_diff)
  if order == none {
    $frac(#d #f, #d #x)$
  } else {
    $frac(#d^#order #f, #d #x^#order)$
  }
}
#let pder(f, x, order: none) = {
  if order == none {
    $frac(∂ #f, ∂ #x)$
  } else {
    $frac(∂^#order #f, ∂ #x^#order)$
  }
}
