//==========================================================
// KIT Thesis template for Typst.
// Based on the modified version of the sdqthesis template by Adrian Freund,
// which can be found at https://gitlab.kit.edu/kit/typst-templates/sdqthesis-typst
//
//
// Created by Adrian Freund <adrian.freund@student.kit.edu>
// Updated by Janina Wibker <me@janina.lol>
// =========================================================
// LTeX: enabled=false
#import "@preview/typearea:0.2.0": *
#import "@preview/linguify:0.4.2": * // Translation support
#import "@preview/i-figured:0.2.4" // figure numbering per section
#import "@preview/hydra:0.6.0": hydra // chapter name in page heading


#let _kit-thesis-translations = toml("assets/lang.toml")
#let _t(..rest) = linguify(..rest, from: _kit-thesis-translations)

#let _kit-thesis-small = 11pt
#let _kit-thesis-large = 14pt
#let _kit-thesis-Large = 18pt
#let _kit-thesis-huge = 20pt

#let kit-logo(..rest) = context {
  image("assets/kit-logo-" + text.lang + ".svg", ..rest)
}

#let _title-page(
  title,
  author,
  thesis-type,
  group-logo,
  institute,
  first-examiner,
  second-examiner,
  advisor,
  is-draft,
  serif-font,
) = {
  page(
    header: [],
    footer: [],
    background: if is-draft { rotate(24deg, text(150pt, fill: rgb("dedede66"))[*DRAFT*]) },
    margin: (
      inside: 31mm,
      outside: 23mm,
      top: 31mm,
      bottom: 36mm,
    ),
  )[
    #set text(size: _kit-thesis-large)
    #grid(
      rows: (auto, auto, 1fr),
      align: center,
      [
        #grid(
          columns: (auto, 1fr),
          align: (left, right),
          [#kit-logo(height: 18mm)], [#set image(height: 18mm); #group-logo],
        )
      ],
      [
        #v(27mm)
        #text(
          weight: "bold",
          size: _kit-thesis-huge,
          font: serif-font,
          title,
        )
        #v(2em)
        #text(size: 14pt)[
          #thesis-type #_t("of")
        ]
        #v(1em)
        #text(size: _kit-thesis-Large, author)
      ],
      grid.cell(align: horizon)[
        #align(horizon)[
          #_t("at-the") #_t("kit-department-informatics") \
          #institute
          
          #v(2em)
          
          #grid(
            columns: 2,
            align: left,
            row-gutter: 0.5em,
            column-gutter: 1em,
            [#_t("first-examiner"):], first-examiner,
            [#_t("second-examiner"):], second-examiner,
            [], [],
            [#_t("advisor"):], advisor,
          )
        ]
      ],
    )
  ]
}

#let _address-page() = {
  set text(lang: "de")
  page[
    Karlsruher Institut für Technologie \
    Fakultät für Informatik \
    Postfach 6980 \
    76128 Karlsruhe
  ]
}

#let _declaration-page(author) = {
  page[
    #align(bottom)[
      #line(length: 100%, stroke: 0.5pt)
      #_t("declaration")
      
      #strong[#_t("PLACE"), #_t("DATE")]
      #v(15mm)
      #line(stroke: stroke(dash: "loosely-dotted"), length: 80mm)
      #h(20mm) (#author)
    ]
  ]
}

#let _abstract-page(abstract) = {
  heading(_t("abstract"))
  
  abstract
}

#let _german-abstract-page(abstract) = {
  set text(lang: "de")
  // Don't use _t("abstract") here. It will be english in the table of contents.
  heading[Zusammenfassung]
  
  abstract
}

#let _table-of-contents-page() = {
  // Table of contents
  outline(title: _t("table-of-contents"))
}

#let _content-pages(body) = {
  state("content.switch").update(false)
  
  // Ensure that >= 1 empty page is inserted
  pagebreak(to: "even", weak: true)
  pagebreak(to: "odd", weak: true)
  state("content.switch").update(false)
  
  set page(numbering: "1")
  set heading(numbering: "1.")
  counter(page).update(1)
  
  body
}

#let _show-heading-in-header(body) = {
  set block(above: 0.4em)
  set text(style: "italic")
  if body.has("numbering") and body.numbering != none {
    numbering(body.numbering, ..counter(heading).at(body.location()))
    [ ]
  }
  body.body
  line(length: 100%, stroke: 0.5pt)
}

#let kit-thesis(
  author: none,
  title: none,
  thesis-type: "bachelor",
  abstract: none,
  german-abstract: none,
  group-logo: none,
  institute: none,
  first-examiner: none,
  second-examiner: none,
  advisor: none,
  lang: "de",
  is-draft: none,
  _binding-correction: 20mm,
  style: (serif-font: none, monospace-font: none, citation-color: none),
  body,
) = {
  assert.ne(author, none, message: "Author missing")
  assert.ne(title, none, message: "Title missing")
  assert.ne(abstract, none, message: "Abstract missing")
  assert.ne(first-examiner, none, message: "First examiner missing")
  assert.ne(second-examiner, none, message: "Second examiner missing")
  assert.ne(advisor, none, message: "Advisor missing")
  assert.ne(institute, none, message: "Institute missing")
  assert.ne(is-draft, none, message: "is-draft missing")
  assert(lang in ("de", "en"), message: "Unsupported language: " + lang)
  assert(
    not (lang != "de" and german-abstract == none),
    message: "German abstract missing",
  )
  assert.ne(style.serif-font, none, message: "Serif font missing")
  assert.ne(style.monospace-font, none, message: "Monospace font missing")
  assert.ne(style.citation-color, none, message: "Citation color missing")
  
  set document(author: author.text, title: title.text)
  set text(size: 12pt, font: style.serif-font, lang: lang)
  
  show: typearea.with(
    paper: "a4",
    div: 16,
    binding-correction: _binding-correction,
    header-include: true,
    header-height: 1.1em,
    header: context {
      let page = here().page()
      let is-start-chapter = query(heading.where(level: 1)).any(it => (
        it.location().page() == page
      ))
      
      if not state("content.switch", false).get() and not is-start-chapter {
        // "Empty Page" (or a page without heading/line number; this can also be a page prior to the abstract as these also don't have either)
        return
      }
      
      // This gets read out by the footer
      state("content.pages", (0,)).update(it => return it + (page,))
      
      if not state("header.enabled", false).get() {
        // Additional switch for enabling/disabling header, prior to content pages
        // while maintaining the page numbering
        return
      }
      
      // Pages that contain a level 1 heading don't have a header.
      // Hydra should do this for us, but it somehow doesn't work reliably
      let page-headings = query(heading).filter(it => it.level == 1).filter(it => it.location().page() == page)
      
      if page-headings.len() == 0 {
        if calc.odd(page) {
          align(
            right,
            hydra(
              2,
              use-last: true,
              display: (ctx, it) => _show-heading-in-header(it),
            ),
          )
        } else {
          align(
            left,
            hydra(1, display: (ctx, it) => _show-heading-in-header(it)),
          )
        }
      }
    },
    footer: context {
      let has-content = state("content.pages", (0,))
        .get()
        .contains(
          here().page(),
        )
      
      if page.numbering != none and has-content {
        block(width: 100%)[
          #align(if calc.even(here().page()) {
            left
          } else {
            right
          })[
            #counter(page).display(page.numbering)
          ]
        ]
      }
    },
    numbering: none,
  )
  
  // color citations and references (or the numbers in them) with citation-color
  // also make normal references italic, but not citations
  show cite: it => {
    // Only color the number, not the brackets.
    show regex("\d+"): set text(fill: style.citation-color)
    // or regex("[\p{L}\d+]+") when using the alpha-numerical style
    it
  }
  
  show ref: it => {
    if it.element == none {
      // This is a citation, which is handled above.
      return it
    }
    
    // Only color the number, not the supplement.
    show regex("[\d.]+"): set text(fill: style.citation-color)
    text(style: "italic")[#it]
  }
  
  set bibliography(title: _t("bibliography"), style: "ieee")
  
  // styling for paragraphs, headings, code, tables and figures
  set par(spacing: 0.65em)
  set par(first-line-indent: 0mm, justify: true)
  show heading: i-figured.reset-counters
  show heading.where(level: 1): it => {
    state("content.switch").update(false)
    pagebreak(weak: true, to: "odd")
    state("content.switch").update(true)
    
    v(22mm)
    it
  }
  show heading: set text(font: style.serif-font, weight: "bold")
  show heading: set block(above: 12mm, below: 10mm)
  show heading.where(level: 1): set text(size: _kit-thesis-huge)
  show heading.where(level: 1): set block(above: 10mm, below: 15mm)
  show heading.where(level: 1): set heading(supplement: _t("chapter"))
  show heading.where(level: 2): set heading(supplement: _t("section"))
  
  show raw: set text(font: style.monospace-font)
  show raw.where(block: true): set text(size: 8pt)
  
  show table: set text(size: _kit-thesis-small)
  set figure(supplement: auto)
  show figure: i-figured.show-figure
  
  // outline styling, proper linking and numbering
  set outline.entry(fill: repeat[.#h(5pt)])
  set outline(indent: 1em)
  show outline.entry.where(level: 1): it => {
    set text(weight: "bold", font: style.serif-font)
    let link-to-page(body) = link((
      "page": it.element.location().page(),
      "x": 0em,
      "y": 0em,
    ))[#body]
    v(0.57em)
    box[#link-to-page[#it.prefix() #it.body()] #h(1fr) #link-to-page[#it.page()]]
  }
  
  // pre-defined content of the thesis, starting with title page, address page, declaration page, abstract, (german abstract), table of contents and lastly the rest of the thesis
  // omitted here are appendix, list of abbreviations, and bibliography; these are added in thesis.typ, after calling out to this function
  _title-page(
    title,
    author,
    thesis-type,
    group-logo,
    institute,
    first-examiner,
    second-examiner,
    advisor,
    is-draft,
    style.serif-font,
  )
  _address-page()
  _declaration-page(author)
  
  state("content.switch").update(false)
  pagebreak(to: "odd", weak: true)
  state("content.switch").update(true)
  set page(numbering: "i")
  counter(page).update(1)
  _abstract-page(abstract)
  if lang != "de" {
    state("content.switch").update(false)
    pagebreak(to: "odd", weak: true)
    state("content.switch").update(true)
    _german-abstract-page(german-abstract)
  }
  _table-of-contents-page()
  
  state("header.enabled").update(true)
  _content-pages(body)
}

// the appendix (if added) has a different numbering scheme
#let appendix(body) = {
  set heading(numbering: none)
  
  show figure: i-figured.show-figure.with(numbering: "A.1.")
  counter(heading).update(1)
  
  heading(_t("appendix"))
  
  body
}
