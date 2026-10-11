
// Small fancy stuff for creating tables
#let fance-table-align(col, row) = {
  if row == 0 { center } else if col == 0 { left + horizon } else { right + horizon }
}
#let fancy-table-fill(col, row) = {
  if row == 0 { gray } else if calc.odd(row) { silver } else { white }
}
#let fancy-table-stroke = 0.5pt + black

// Cite as "Author1 et. al.[XXX]" whenever there are more than two authors.
//
// NOTE: Only for for `form:"prose"` or `form:"author"`. Otherwise just use normal citing
#let cite-et-al(label-string, form: "prose", supplement: "") = {
  let label-c = if type(label-string) == "string" {
    label(label-string)
  } else { label-string }
  if supplement != "" {
    cite(label(label-c), form: form, style: "trends", supplement: [#supplement])
  } else {
    cite(label(label-c), form: form, style: "trends")
  }
}

// This is just a shorthand for #cite(label("my_citation")...)
// Citing using strings ("my_citation") in case the citation key has some characters
// that mess the key recognition (such as: "+").
#let cite-string(label-string, supplement: "", form: "", style: "ieee") = {
  let actual-form = if form != "" { form } else { "normal" }
  if supplement == "" {
    cite(label(label-string), form: actual-form, style: style)
  } else {
    cite(label(label-string), form: actual-form, style: style, supplement: supplement)
  }
}

// Build header shown on pages where a Chapter starts
#let build-main-header(main-heading-content) = {
  [
    #align(center, smallcaps(main-heading-content))
    #line(length: 100%)
  ]
}

#let build-secondary-header(main-heading-content, current-page, page-counter) = {
  let page-string = str(page-counter)
  if calc.even(current-page) {
    [
      #page-string  #h(1fr)  #main-heading-content
      #line(length: 100%)
    ]
  } else {
    [
      #main-heading-content  #h(1fr) #page-string
      #line(length: 100%)
    ]
  }
}

#let build-footer-with-title(document-title) = {
  [
    #line(length: 100%)
    #align(center, smallcaps(document-title))
  ]
}

#let build-empty() = {
  []
}

#let get-nice-date(yaml-dict) = {
  let today = datetime.today()
  let months = yaml-dict.months
  let nice-month = months.at(today.month() - 1)
  [
    #nice-month #today.display("[year]")
  ]
}

// To know if the secondary heading appears after the main heading on the same page
#let is-secondary-heading-after-main-heading(secondary-heading, main-heading) = {
  let secHeadPos = secondary-heading.location().position()
  let mainHeadPos = main-heading.location().position()
  if (secHeadPos.at("page") > mainHeadPos.at("page")) {
    return true
  }
  if (secHeadPos.at("page") == mainHeadPos.at("page")) {
    return secHeadPos.at("y") > mainHeadPos.at("y")
  }
  return false
}

#let print-proclamation(city, lang) = {
  set page(header: none, numbering: none)
  heading(lang.proclamation.title, numbering: none)
  [
    #lang.proclamation.contents
  ]
  v(1.0cm)
  align(right)[
    #line(length: 35%)
    #city, #get-nice-date(lang)
  ]
  pagebreak(weak: true)
}

#let build-footer-with-number(current-abs-page, page-counter, is-main-heading: false) = {
  let number-string = str(page-counter)
  if is-main-heading {
    [
      #align(center, number-string)
    ]
  } else if calc.even(current-abs-page) {
    [
      #align(left, number-string)
    ]
  } else {
    [
      #align(right, number-string)
    ]
  }
}

#let get-footer(document-title) = {
  context {
    let loc = here()
    // Find if there is a level 1 heading on the current page
    let next-main-heading = query(selector(heading).after(loc)).find(headIt => {
      headIt.location().page() == loc.page() and headIt.level == 1
    })
    if (next-main-heading != none) {
      return build-footer-with-number(counter(page).at(loc).at(0))
    }
    // Find the last previous level 1 heading -- at this point surely there's one :-)
    let last-main-heading = query(selector(heading).before(loc))
      .filter(headIt => {
        headIt.level == 1
      })
      .last()
    if last-main-heading.location().page() == loc.page() {
      return build-footer-with-number(loc.page(), counter(page).at(loc).at(0), is-main-heading: true)
    }
    // Find if the last level > 1 heading in previous pages
    let previous-secondary-heading-array = query(selector(heading).before(loc)).filter(headIt => {
      headIt.level > 1
    })
    let last-secondary-heading = if (previous-secondary-heading-array.len() != 0) {
      previous-secondary-heading-array.last()
    } else { none }
    // Find if the last secondary heading exists and if it's after the last main heading
    if (
      last-secondary-heading != none
        and is-secondary-heading-after-main-heading(last-secondary-heading, last-main-heading)
    ) {
      return build-footer-with-title(document-title)
    }
    return build-footer-with-title(document-title)
  }
}

#let get-header(double-sided) = {
  // counter(footnote).update(0)
  context {
    let loc = here()
    // Find if there is a level 1 heading on the current page
    let next-main-heading = query(selector(heading).after(loc)).find(headIt => {
      headIt.location().page() == loc.page() and headIt.level == 1
    })
    if (next-main-heading != none) {
      return build-empty()
    }
    // Find the last previous level 1 heading -- at this point surely there's one :-)
    let last-main-heading = query(selector(heading).before(loc))
      .filter(headIt => {
        headIt.level == 1
      })
      .last()
    let lastMainIndex = counter(heading).get().at(0)
    // Find if the last level > 1 heading in previous pages
    let previous-secondary-heading-array = query(selector(heading).before(loc)).filter(headIt => {
      headIt.level > 1
    })
    let last-secondary-heading = if (previous-secondary-heading-array.len() != 0) {
      previous-secondary-heading-array.last()
    } else { none }
    // Find if the last secondary heading exists and if it's after the last main heading
    if (
      last-secondary-heading != none
        and is-secondary-heading-after-main-heading(last-secondary-heading, last-main-heading)
    ) {
      let headingText = if (calc.even(loc.page())) {
        str(lastMainIndex) + ". " + last-main-heading.body
      } else {
        str(lastMainIndex) + "." + str(last-secondary-heading.level) + ". " + last-secondary-heading.body
      }
      // Always make the absolute-page an odd number, if there not printing
      // double-sided, so the page-number always comes on the right side
      let absolute-page = if not double-sided { 1 } else { loc.page() }
      return build-secondary-header(headingText, absolute-page, counter(page).get().at(0))
    }
    let heading-title = str(last-main-heading.body.text)
    let headingText = if heading-title.find("Bibliography") != none {
      "Bibliography"
    } else {
      str(lastMainIndex) + ". " + last-main-heading.body
    }
    // Always make the absolute-page an odd number, if there not printing
    // double-sided, so the page-number always comes on the right side
    let absolute-page = if not double-sided { 1 } else { loc.page() }
    return build-secondary-header(headingText, absolute-page, counter(page).get().at(0))
  }
}

#let invisible-heading(level: 1, numbering: none, supplement: auto, outlined: true, content) = {
  // show heading.where(level: level): set text(size: 0em, color: red)
  show heading.where(level: level): it => block[]
  text(size: 0pt)[
    #heading(level: level, numbering: numbering, supplement: supplement, outlined: outlined)[#content]
  ]
}

#let small-title(content, outlined: true) = {
  align(center)[
    // #show heading.where(level: 1): set text(size: 0.85em)
    #show heading.where(level: 1): it => block[
      #set text(size: 0.85em)
      #it.body
    ]
    #heading(
      outlined: outlined,
      numbering: none,
      content,
      // text(0.85em,content),
    )
    #v(5mm)
  ]
}

/// For dictionary stuff just below. Might change in the future
#let GLS_PREFIX = "gls-auto-"

#let print-glossary(glossaries, name, bold: true) = {
  let to_print = ()
  for (key, value) in glossaries.at(name).pairs() {
    // let (abbr, full) = value
    let abbr = value.at(0)
    let full = value.at(1)
    to_print.push([#if bold [*#abbr*] else [#abbr] #label(GLS_PREFIX + key)])
    to_print.push(full)
  }
  grid(
    columns: 2,
    gutter: 3mm,
    ..to_print
  )
}

#let GLOSSARIES = state("glossaries", (:))
#let PRINTED_GLOSSARIES = state("printed_glossaries", ())

// Use `name` that should/would appear in the Glossary. (See "glossaries.typ")
#let gls(name) = {
  let contents = locate(loc => {
    let glossaries = GLOSSARIES.at(loc)
    for table in glossaries.values() {
      if name in table.keys() {
        if table.at(name).len() > 2 {
          link(label(GLS_PREFIX + name))[#table.at(name).at(2)]
        } else if name not in PRINTED_GLOSSARIES.at(loc) {
          link(label(GLS_PREFIX + name))[#table.at(name).at(1) (#table.at(name).at(0))]
        } else {
          link(label(GLS_PREFIX + name))[#table.at(name).at(0)]
        }
        break
      }
    }
  })
  contents
  PRINTED_GLOSSARIES.update(curr => {
    if name not in curr {
      curr.push(name)
    }
    curr
  })
  // [#glossaries]
}

#let todays-date = datetime.today()

#let city = ""

#let project(
  title: "",
  work-type: "bachelor",
  lang: "en",
  abstract: "",
  author: "",
  registration-number: "",
  email: "",
  institute: "Institue of Very Cool People",
  city: "Osnabrück",
  logo: "images/logo.png",
  bibliography-path: "",
  bibliography-style: "ieee",
  first-supervisor: "Prof. 1",
  second-supervisor: "Person 2",
  glossaries: (abbreviation: (:)),
  double-sided: true,
  body,
) = {
  let margin = (bottom: 1.135in + 0.4in, top: 1.125in + 0.4in)
  if double-sided {
    margin.insert("outside", 1.0in)
    margin.insert("inside", 1.3in)
  } else {
    margin.insert("left", 1.3in)
    margin.insert("right", 1.0in)
  }
  set page(
    paper: "a4",
    // margin: (outside: 1.0in, inside: 1.3in, bottom:1.125in+0.4in, top: 1.125in + 0.4in),
    margin: margin,
    header-ascent: 0.4in,
    footer-descent: 0.3in,
    // binding: left
  )
  // city = city
  // Set the document's basic properties.
  set document(author: author, title: title)
  // set text(font: "Linux Libertine", lang: "en")
  set text(
    size: 12pt,
    // font: "Times_New_Roman",
    font: "Libertinus Serif",
    // stretch: 120%,
    lang: "en",
  )
  let lang = yaml("languages/" + lang + ".yaml")

  // Make sure that Figures' numbers are bold
  // show figure.caption: it => [
  //   #strong(it.supplement) #strong(it.counter.display(it.numbering)) : #it.body
  //   // #strong(repr(it.fields().pairs()))
  // ]

  let fig-params = (
    "placement",
    "caption",
    "kind",
    "supplement",
    "numbering",
    "gap",
    "outlined",
  )
  show figure.caption: emph
  show math.equation: set text(weight: 400)
  set math.equation(numbering: "(1.1)")
  set heading(numbering: "1.1")
  set par(justify: true)

  // show heading.where(level: 1): set text(size: 24pt)
  show heading.where(level: 2): set text(size: 18pt)
  show heading.where(level: 3): set text(size: 14pt)

  show outline.entry.where(level: 1): it => {
    v(16pt, weak: true)
    strong(it)
    // set outline(
    //   fill: none,
    // )
  }

  show outline.entry.where(level: 2): it => {
    it
  }
  // show link: set text(fill: blue)
  show ref: it => {
    let eq = math.equation
    let hd = heading
    let el = it.element
    if el != none {
      if el.func() == eq {
        // Override equation references.
        link(el.label)[#numbering(
          el.numbering,
          ..counter(eq).at(el.location()),
        )]
      } else if el.func() == hd {
        // headings
        text(fill: green.darken(60%))[#it]
      } else if el.func() == figure {
        // figures
        text(fill: blue.darken(60%))[#it]
      } else if el.func() == table {
        // table
        text(fill: red.darken(70%))[#it]
      } else if el.func() == ref {
        // ref
        text(fill: gray.darken(60%))[#it]
      }
    } else {
      // Other references as usual.
      it
    }
  }
  show cite: set text(fill: gray.darken(60%))


  // Title page.
  // v(0.25fr)
  // Logo
  if logo != none {
    v(0.25fr)
    align(center, image(logo, width: 26%))
    v(0.20fr)
  } else {
    v(0.45fr)
  }
  align(center)[
    #text(1.2em, weight: 600, institute)
  ]
  v(0.20fr)

  align(center)[
    #text(style: "italic")[#lang.work-type.at(work-type)]
  ]
  align(center)[
    #text(1.8em, weight: 700, title)
  ]

  // Author information.
  align(center)[
    #text(size: 14pt)[#author] \
    #if registration-number != "" [#registration-number \ ]

    #v(2cm)
    // #datetime.today().display("[month] [year]")
    #get-nice-date(lang)

    #v(2cm)
    #table(
      columns: 2,
      stroke: none,
      align: left,
      [#lang.supervisors.first:], [#first-supervisor],
      [#lang.supervisors.second:], [#second-supervisor],
    )

  ]


  pagebreak()

  if abstract != "" {
    small-title([Abstract])
    abstract
    // v(1.618fr)
    pagebreak()
  }

  show heading.where(level: 1): it => [
    #set text(size: 24pt)
    #v(1.5in)
    #par(first-line-indent: 0pt)[#it.body]
    #v(1.5cm)
  ]


  // Table of contents.
  heading(lang.index, numbering: none, outlined: false)
  outline(
    title: none,
    depth: 3,
    indent: auto,
  )
  pagebreak()
  ///*
  /// Lists...
  set page(numbering: "i", number-align: center)
  heading(lang.lists.figure, numbering: none)
  outline(
    title: none,
    depth: 3,
    indent: auto,
    target: figure.where(kind: image),
  )
  pagebreak()

  heading(lang.lists.tables, numbering: none)
  outline(
    title: none,
    depth: 3,
    indent: auto,
    target: figure.where(kind: table),
  )
  pagebreak()
  //*/
  GLOSSARIES.update(glossaries)

  heading(
    outlined: true,
    numbering: none,
    text(lang.lists.glossary),
  )
  print-glossary(glossaries, "abbreviation", bold: true)
  pagebreak()

  // heading(
  //   outlined: true,
  //   numbering: none,
  //   text("List of Symbols"),
  // )
  // print-glossary(glossaries, "symbol", bold: false)

  // Main body.
  set page(numbering: "1", number-align: bottom)
  set par(first-line-indent: 20pt)
  set page(header: get-header(double-sided), footer: get-footer(title))
  counter(page).update(1)

  // set gls(glossaries: glossaries)
  show heading: set heading(supplement: [#lang.sections.other])
  show heading.where(level: 1): set heading(supplement: [#lang.sections.main])
  show heading.where(level: 1): it => [
    // #pagebreak(weak: true)
    #set text(size: 24pt)
    #v(1.5in)
    #block[
      #if it.numbering != none [
        #lang.sections.main #counter(heading).display()
        #v(0.5cm)
      ]
      #par(first-line-indent: 0pt)[#it.body]
    ]
    #v(1.5cm, weak: true)
  ]
  // show heading: it => [
  //   #if it.level > 1 [
  //     #set it.supplement(dict.at(lang).at(sections).at(other))
  //   ]
  // ]
  show heading.where(level: 2): it => [
    #set text(size: 18pt)
    #v(1cm, weak: true)
    #block[
      #if it.numbering != none [
        #counter(heading).display()
      ]
      #it.body
    ]
    #v(1cm, weak: true)
  ]
  show heading.where(level: 2): set text(size: 18pt)
  show heading.where(level: 3): set text(size: 14pt)
  ///
  set page(numbering: "1", number-align: center)
  // set footnote(numbering: "*")

  body

  // Bibliography
  pagebreak(weak: true)
  bibliography(
    bibliography-path,
    title: [#lang.bibliography],
    // style: "american-physics-society"
    style: bibliography-style,
    // style: "thieme"
  )
  pagebreak(weak: true)

  // Proclamation
  print-proclamation(city, lang)
}
