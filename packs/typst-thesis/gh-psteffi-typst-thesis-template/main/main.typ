#import "@preview/glossarium:0.5.10": gls, glspl, make-glossary, print-glossary, register-glossary
#import "@preview/acrostiche:0.6.0": init-acronyms, print-index
#import "uni-terms.typ": *

// This function gets your whole document as its `body` and formats it as
// a thesis in the style of the University of Applied Sciences Mannheim.
// Example usage can be found in `thesis.typ`.
#let main-thesis(
  // The english title of the thesis.
  title-en: [Title of the Thesis],
  // The german title of the thesis.
  title-de: [Titel der Thesis],
  // Language of the thesis ("de" or "en").
  lang: "en",
  // English abstract.
  abstract-en: none,
  // German abstract.
  abstract-de: none,
  // The author's surname.
  author-surname: none,
  // The author's givenname.
  author-given-name: none,
  // The company this thesis is written at
  company: none,
  // The submission date.
  submission-date: datetime.today(),
  // The submission city.
  city: "Karlsruhe",
  // Toggle for proposal-mode. Mainly changes the title and omits some declarations.
  // This is useful if you want to cleanly transition from a proposal into a thesis
  // without much copy-pasting or restructuring. The template does it for you.
  is-proposal: false,
  // List of glossary items, Check `glossary.typ`
  glossary: none,
  // Your bibliography. Pass `bibliography("your_refs.bib")`.
  bibliography: none,
  // A list of acronyms. Check the example in `acronyms.typ`.
  acronyms: none,
  // Your appendix. This has to be passed separately from the rest of the thesis as the numbering of the headings is different.
  appendix: none,
  // An image of your handwritten signature.
  signature: none,
  // chapter preview
  chapter-preview: false,
  // The content of your thesis.
  body,
) = {
  let is-en = lang == "en"
  let sans = "TeX Gyre Heros"
  let serif = "TeX Gyre Termes"

  let title = if is-en { title-en } else { title-de }

  // Configure the page.
  set page(paper: "a4")

  // Set the body font.
  set text(size: 11pt, font: "New Computer Modern", lang: lang)
  set par(justify: true, leading: 0.9em, spacing: 1.35em)

  let date-format = "[day].[month].[year]"

  // No page numbering until abstract.
  set page(numbering: none)

  // Configure enum numbering scheme.
  set enum(
    indent: 1em,
    spacing: 1em,
    numbering: (..n) => {
      // For the first level we use numbers 1, 2, 3, ...
      // On the second level we use letters a), b), c), ...
      let level = n.pos().len() - 1
      let pattern = "1a".at(level, default: "a")
      let suffix = ".)".at(level, default: ")")
      numbering(pattern, n.pos().last()) + suffix
    },
    full: true,
  )

  // Configure unnumbered list
  set list(indent: 1em, spacing: 1em, marker: ([•], [◦], [‣]))

  // Tables & figures
  set figure(gap: 1.5em)
  show figure.caption: set text(font: "New Computer Modern", size: 9pt)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure: set block(breakable: true)
  show figure.where(kind: image): set figure(
    supplement: [Abb.],
  )
  show figure.where(kind: image): it => {
    v(0.7cm)
    it
    v(0.7cm)
  }
  show figure.where(kind: table): it => {
    v(0.7cm)
    it
    v(0.7cm)
  }
  show figure.where(kind: raw): it => {
    v(0.7cm)
    //line(length: 35%, stroke: 0.6pt)
    it
    line(length: 35%, stroke: 0.6pt)
    v(0.7cm)
  }
  show figure.caption.where(kind: raw): it => {
    it
    line(length: 35%, stroke: 0.6pt)
  }
  show figure.where(kind: raw): set figure(supplement: [Quellcode])
  show figure.where(kind: raw): set figure.caption(position: top)
  set table(stroke: none, align: left)

  // Configure quotes.
  set quote(block: true)
  show quote: set pad(x: 3em, top: -1em)

  // cover page später als pdf importiert
  //image("Titelblatt.pdf")

  set page(numbering: "I")

  // Omit for proposal.
  if not is-proposal and abstract-de != none {
    // Declarations, signature and license.
    page[
      #let declaration = if is-en [Declaration] else [Erklärung]
      #text(size: 20pt, font: "New Computer Modern", strong(declaration))

      #if is-en [
        I confirm that the submitted thesis is my original work and was written by me without further assistance. Appropriate credit has been given where reference has been made to the work of others.
      ] else [
        Hiermit erkläre ich, dass ich die vorliegende Arbeit eigenständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Textpassagen, die sich auf Publikationen anderer Autoren stützen, sind als solche gekennzeichnet. Zur stellenweise Unterstützung des sprachlichen Ausbaus wurde das KI-gestützte Sprachmodell ChatGPT (OpenAI) verwendet. Die inhaltliche Konzeption, Analyse und Ausarbeitung der Arbeit erfolgten eigenständig.
      ]

      #pad(
        [#city, #submission-date.display(date-format)],
        top: 0.5cm,
        bottom: 0.25cm,
      )

      #box[
        #signature
        #v(-4cm)
        #line(start: (0%, 10%), length: 30%)
        #author-given-name #author-surname
      ]
      //#signature
    ]

    page[
      #let notice = if is-en [Confidentiality Notice] else [Sperrvermerk]
      #text(size: 20pt, font: "New Computer Modern", strong(notice))

      Die vorliegende Abschlussarbeit beinhaltet vertrauliche Daten der #text(company), die nicht für die Öffentlichkeit bestimmt sind.
      Sie darf lediglich Gutachtern sowie berechtigten Mitgliedern des Prüfungsausschusses zugänglich gemacht werden.
      Die Veröffentlichung oder Vervielfältigung der Abschlussarbeit - auch auszugsweise - ist untersagt.
      An Dritte darf dieses Dokument während der Sperrfrist nur mit ausdrücklicher schriftlicher Genehmigung des Verfassers sowie des Unternehmens weitergegeben werden.
    ]

    // Vermerk für Gendern
    page[
      #if not is-en {
        [
          Um die Lesbarkeit zu vereinfachen, wird in dieser Arbeit bei personenbezogenen Bezeichnungen auf Formulierungen über der männlichen Form hinaus verzichtet.
          Es wird daher darauf hingewiesen, dass die Verwendung entsprechender Begriffe explizit als geschlechtsunabhängig verstanden werden soll und im Sinne der Gleichbehandlung aller Geschlechter gilt.
        ]
      }
    ]
  }

  // Configure paragraphs.
  set par(justify: true)

  // Configure heading text.
  show heading: h => {
    text(font: "New Computer Modern", strong(h))
  }

  // Top level headings always start on a new page.
  show heading.where(level: 1): h => {
    pagebreak(weak: true)
    pad(top: 5em, bottom: 2em, text(size: 22pt, h))
  }

  // Configure padding and text size depending on heading level.
  show heading.where(level: 2): h => pad(bottom: 1em, top: 1em, text(size: 15pt, h))
  show heading.where(level: 3): h => pad(bottom: 1em, top: 0.6em, h)
  show heading.where(level: 4): h => text(font: "New Computer Modern", h.body)

  // Abstract in german and english. Omit if proposal.
  if not is-proposal and abstract-de != none {
    text(size: 20pt, font: "New Computer Modern", strong([Zusammenfassung]))
    v(1em)
    abstract-de

    pagebreak()

    text(size: 20pt, font: "New Computer Modern", strong([Abstract]))
    v(1em)
    abstract-en
  }

  // Configure the table of contents (called `outline` in typst).
  // Check https://typst.app/docs/reference/model/outline/ for details.
  show outline.entry.where(level: 1): it => link(
    it.element.location(),
    pad(
      top: 0.5em,
      text(font: "New Computer Modern", weight: "bold", it.indented(
        it.prefix(),
        [#it.body() #h(1fr) #it.page()],
        gap: 1em,
      )),
    ),
  )

  // Print the table of contents.
  if not chapter-preview {
    outline(indent: auto, depth: 3)
  }

  // Initialize acronyms.
  if acronyms != none {
    let sorted-acronyms = acronyms.pairs().sorted(key: k => k.at(0))
    init-acronyms(sorted-acronyms)
  }

  // Configure headings.
  let supplement = if is-en [Chapter] else [Kapitel]
  set heading(numbering: "1.1", supplement: supplement)

  // Configure the page header. It shows the first heading that appears on that page.
  // The header is omitted for each top level heading.
  set page(
    header: [
      #context {
        let current-page = here().page()
        let headings-on-page = query(heading)
          .filter(h => h.level < 3 and h.location().page() == current-page)
          .sorted(key: h => h.level)
        let headings-before-page = query(heading).filter(h => h.level < 3 and h.location().page() < current-page)

        let h = none
        if headings-on-page.len() > 0 {
          h = headings-on-page.first()
        } else if headings-before-page.len() > 0 {
          h = headings-before-page.last()
        }

        set align(center)

        if h != none and h.level != 1 {
          if h.numbering != none {
            emph(numbering(h.numbering, ..counter(heading).at(h.location())))
          }

          [ #emph(h.body)]
          v(-0.75em)
          line(length: 100%, stroke: 0.5pt)
        }
      }
    ],
  )

  let custom-glossary(entry, ..args) = {
    align(left)[
      #block(width: 100%)[
        #text(weight: "bold")[#entry.short]
        #linebreak()
        #entry.description
      ]
    ]
    v(-4.5em)
  }

  // Init glossary, this needs to happen before the `body` is included.
  if glossary != none {
    show: make-glossary
    register-glossary(glossary)
  }

  context {
    // Remember the page number before resetting.
    let page-number = here().page()

    // Set page numbering to arabic for the main content and reset the counter to 1.
    set page(numbering: "1")
    counter(page).update(1)

    // Put invisible label at the start and end of the body so
    // we can easily count the number of pages of actual content.
    [#metadata("Start of body") <start-of-body>]
    body
    [#metadata("End of body") <end-of-body>]

    // Change back to roman numbering after the main content.
    // Set the counter back to where we left off before the body.
    set page(numbering: "I")
    counter(page).update(page-number)
  }

  set heading(numbering: none)

  // Print the glossary
  if glossary != none {
    pagebreak(weak: true)
    [= Glossar]
    print-glossary(glossary, show-all: true, user-print-gloss: custom-glossary)
  }

  // Change the outline styling for figures, tables and listings.
  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner()),
  )
  show outline: set heading(outlined: true)

  // Print the list of figures if it's not empty. The context block enables us to react to the
  // number of images present in the document. See https://typst.app/docs/reference/context/.
  if not chapter-preview {
    context {
      if counter(figure.where(kind: image)).final().at(0) > 0 {
        let title = if lang == "de" [Abbildungsverzeichnis] else [List of Figures]
        outline(indent: auto, title: title, target: figure.where(kind: image))
      }
    }

    // Print the list of tables if it's not empty.
    context {
      if counter(figure.where(kind: table)).final().at(0) > 0 {
        let title = if is-en [List of Tables] else [Tabellenverzeichnis]
        outline(indent: auto, title: title, target: figure.where(kind: table))
      }
    }

    // Print the list of listings if it's not empty.
    context {
      if counter(figure.where(kind: raw)).final().at(0) > 0 {
        let title = if is-en [List of Source Code] else [Quellcodeverzeichnis]
        outline(indent: auto, title: title, target: figure.where(kind: raw))
      }
    }

    // Print acronyms.
    if acronyms != none {
      let title = if lang == "de" [Abkürzungsverzeichnis] else [Acronyms Index]
      print-index(delimiter: "", title: title, clickable: false, row-gutter: 1em, outlined: true)
    }
  }
  // Print bibliography.
  bibliography

  // Change the heading numbering for the appendix.
  counter(heading).update(0)
  let supplement = if is-en [Appendix] else [Anhang]
  set heading(numbering: "A.1", supplement: supplement)

  // Print appendix.
  if appendix != none {
    [#appendix]
  }
}
