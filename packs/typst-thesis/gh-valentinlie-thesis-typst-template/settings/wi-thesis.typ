// ============================================================
//
// Typst template of the CHAIR OF MACHINE LEARNING AND DATA ENGINEERING
// and CHAIR OF DIGITAL INNOVATION AND THE PUBLIC SECTOR
// of the University of Münster
//
// Rebuilt from the LaTeX class wi-thesis.cls (v2.5, 2025/06/24).
//
// Terms of use:
// Under no condition, do NOT change this file!
// If additional settings are required, add them in the
// "main_thesis.typ"-file before the #show rule.
// If problems occur, contact the author.
//
// ============================================================

// _______________ Colours _______________

#let wi-colors = (
  ercis-red: rgb(133, 35, 57),
  wwu-black: rgb(62, 62, 59),
  wwu-green: rgb(0, 142, 150),
  wwu-lightgreen: rgb(122, 181, 22),
  wwu-blue: rgb(0, 110, 137),
  wwu-lightblue: rgb(0, 157, 209),
  wi-green1: rgb("#5bbb56"),
  wi-green2: rgb("#8dbb56"),
  wi-iceblue: rgb("#56bbb7"),
  wi-darkblue: rgb("#567cbb"),
  wi-pink: rgb("#f36196"),
  wi-coral: rgb("#f88379"),
  wi-rose: rgb("#FFC0CB"),
  wi-purple: rgb("#880085"),
  wi-mud: rgb("#b5bb56"),
  wi-ocher: rgb("#bbb056"),
  wi-grey: rgb("#929292"),
  code-background: rgb(242, 242, 245),
  wi-question-bg: rgb(235, 245, 250),
  wi-question-frame: rgb(0, 110, 137),
)

// _______________ Internal state _______________

#let _wi-sectionquestions = state("wi-sectionquestions", false)
#let _wi-chapterword = state("wi-chapterword", "Chapter")

// Font stacks (first available font is used)
#let _serif-fonts = ("New Computer Modern", "Libertinus Serif")
#let _sans-fonts = ("New Computer Modern Sans", "Liberation Sans", "DejaVu Sans")

// LaTeX font sizes for a 12pt document
#let _size-large = 14.4pt // \large
#let _size-Large = 17.28pt // \Large
#let _size-LARGE = 20.74pt // \LARGE
#let _size-footnote = 10pt // \footnotesize
#let _size-small = 10.95pt // \small

// _______________ Public helpers _______________

// Box for guiding questions of a section. Only shown if the option
// "sectionquestions: true" is set in the #show rule of main_thesis.typ.
#let sectionquestions(body) = context {
  if _wi-sectionquestions.get() {
    block(
      width: 100%,
      stroke: 0.8pt + wi-colors.wi-question-frame,
      radius: 3pt,
      clip: true,
      stack(
        block(
          width: 100%,
          fill: wi-colors.wi-question-frame,
          inset: (x: 10pt, y: 6pt),
          text(fill: white, weight: "bold")[Section Questions],
        ),
        block(width: 100%, fill: wi-colors.wi-question-bg.lighten(60%), inset: 10pt, body),
      ),
    )
  }
}

// A sub-figure to be placed (e.g. via #grid) inside a regular #figure.
// Sub-figures are numbered (a), (b), ... and restart for every figure.
#let subfigure(body, caption: none) = figure(
  body,
  caption: caption,
  kind: "wi-subfigure",
  supplement: none,
  numbering: "(a)",
  outlined: false,
)

// A float for pseudo-code, numbered independently of figures and tables.
#let algorithm(body, caption: none) = figure(
  {
    set align(left)
    block(
      width: 100%,
      stroke: (top: 0.8pt, bottom: 0.8pt),
      inset: (y: 6pt),
      body,
    )
  },
  caption: caption,
  kind: "wi-algorithm",
  supplement: [Algorithm],
)

// Simple numbered pseudo-code lines for use inside #algorithm.
// Indent nested lines with the #ind helper.
#let ind = h(1.5em)
#let pseudocode(..lines) = {
  set par(leading: 0.5em, spacing: 0.5em)
  grid(
    columns: (2em, 1fr),
    row-gutter: 0.6em,
    ..lines
      .pos()
      .enumerate()
      .map(((i, l)) => (text(size: 0.8em, fill: wi-colors.wi-grey)[#(i + 1):], l))
      .flatten(),
  )
}

// Marks a comment in pseudo-code.
#let pseudocomment(body) = {
  h(1fr)
  text(fill: wi-colors.wi-grey)[$triangle.r$ #body]
}

// _______________ Internal building blocks _______________

#let _l10n(language, en, de) = if language == "german" { de } else { en }

#let _titlefont(sansserif, body) = if sansserif {
  text(font: _sans-fonts, body)
} else {
  smallcaps(body)
}

// Thesis type block on the title page
#let _thesistype(language, thesis, course, sansserif) = {
  let tf = _titlefont.with(sansserif)
  if thesis == "seminar" {
    tf(text(size: _size-Large, _l10n(language, [Seminar Thesis], [Seminararbeit])))
    parbreak()
    v(0.3cm)
    _l10n(language, [in the context of the seminar], [im Rahmen des Seminars])
    parbreak()
    v(0.3cm)
    tf(text(size: _l10n(language, _size-large, _size-Large), course))
  } else if thesis == "master" {
    tf(text(size: _size-Large)[Master Thesis])
  } else if thesis == "bachelor" {
    tf(text(size: _size-Large, _l10n(language, [Bachelor Thesis], [Bachelorarbeit])))
  } else {
    panic("Unknown type of thesis '" + thesis + "' specified")
  }
}

// Chair block at the bottom of the title page
#let _chairlogo(language, chair) = {
  if chair == "csssa" {
    image("Logos/LS_logo.png", width: 4.5cm)
  } else if chair == "machineLearning" {
    box(width: 70%, text(size: _size-large, smallcaps(_l10n(
      language,
      [Machine Learning and Data Engineering],
      [Machine Learning und Data Engineering],
    ))))
  } else if chair == "datascience" {
    box(width: 100%, text(size: _size-large, smallcaps(_l10n(
      language,
      [Chairs of Data Science: \ Computational Social Science and Systems Analysis & \ Machine Learning and Data Engineering],
      [Lehrstühle für Data Science: \ Computational Social Science and Systems Analysis & \ Machine Learning und Data Engineering],
    ))))
  } else if chair == "dips" {
    image("Logos/DIPS_ext.png", width: 6.5cm)
  } else if chair == "bpm" {
    image("Logos/ERCIS_logo_color.png", width: 6.5cm)
  } else if chair == "SE" {
    image("Logos/SE_Logo.png", width: 4.5cm)
  } else {
    panic("Unknown chair '" + chair + "' specified")
  }
}

// Chair name for the back of the title page: (intro line, name lines)
#let _chairname(language, chair) = {
  if chair == "csssa" {
    (
      _l10n(language, [Chair for Data Science:], [Lehrstuhl für Data Science:]),
      [Computational Social Science & Systems Analysis],
    )
  } else if chair == "machineLearning" {
    (
      none,
      _l10n(language, [Machine Learning and \ Data Engineering], [Maschinelles Lernen und \ Data Engineering]),
    )
  } else if chair == "datascience" {
    (
      _l10n(language, [Chairs for Data Science:], [Lehrstühle für Data Science:]),
      _l10n(
        language,
        [Computational Social Science \ and Systems Analysis & \ ML and Data Engineering],
        [Computational Social Science \ and Systems Analysis & \ ML und Data Engineering],
      ),
    )
  } else if chair == "dips" {
    (
      _l10n(language, [Chair for Digital Innovation], [Lehrstuhl für Digital Innovation]),
      [and the Public Sector],
    )
  } else if chair == "bpm" {
    (
      _l10n(language, [Chair of Information Systems], [Lehrstuhl für Wirtschaftsinformatik]),
      _l10n(language, [and Business Process Management], [und Geschäftsprozessmanagement]),
    )
  } else if chair == "SE" {
    (
      _l10n(language, [Chair of], [Lehrstuhl für]),
      [Software Engineering],
    )
  } else {
    panic("Unknown chair '" + chair + "' specified")
  }
}

// License statement for the declaration page
#let _license-statement(language, license) = {
  if license == none or license == "" { return none }
  let template(name) = _l10n(
    language,
    [Unless explicitly specified otherwise, this work is licensed under the license #name.],
    [Soweit nicht anders angegeben unterliegt diese Arbeit der Lizenz #name.],
  )
  if license == "cc-by-sa" {
    image("cc-icons/cc-by-sa.png", width: 2cm)
    template(link("https://creativecommons.org/licenses/by-sa/4.0/legalcode")[Attribution-ShareAlike 4.0 International])
  } else if license == "cc-by" {
    image("cc-icons/cc-by.png", width: 2cm)
    template(link("https://creativecommons.org/licenses/by/4.0/legalcode")[Attribution 4.0 International])
  } else if license == "cc0" {
    image("cc-icons/cc-zero.png", width: 2cm)
    template(link("https://creativecommons.org/publicdomain/zero/1.0/legalcode")[CC0 1.0 Universal])
  } else {
    panic("Unknown license '" + license + "' specified")
  }
}

// Signature block for declaration and consent form
#let _signatures(language, multiauthor, author, city, date) = {
  [#city, #date]
  v(3em)
  line(length: 2in, stroke: 0.5pt)
  if multiauthor {
    _l10n(language, [Signatures], [Unterschriften])
  } else {
    author
  }
}

// Human-readable thesis type name, e.g. for the confidentiality statement
#let _thesistypename(language, thesis) = _l10n(
  language,
  ("seminar": "seminar thesis", "bachelor": "bachelor thesis", "master": "master thesis").at(thesis, default: "thesis"),
  ("seminar": "Seminararbeit", "bachelor": "Bachelorarbeit", "master": "Masterarbeit").at(thesis, default: "Arbeit"),
)

// _______________ Appendix _______________

// Use as `#show: appendix` before including appendix chapters.
#let appendix(body) = {
  counter(heading).update(0)
  set heading(numbering: "A.1", supplement: [Appendix])
  _wi-chapterword.update("Appendix")
  body
}

// _______________ The template _______________

#let wi-thesis(
  // a) the language of your thesis: "english" or "german"
  language: "english",
  // b) the type of the thesis: "bachelor", "master" or "seminar"
  thesis: "master",
  // c) the chair: "csssa", "machineLearning", "datascience", "dips", "bpm" or "SE"
  chair: "csssa",
  // d) "supervisor" if there is a professor and a supervisor,
  //    "postdoc" if the thesis is only supervised by a postdoc
  supervisor-mode: "supervisor",
  // e) free and open license: "cc0", "cc-by", "cc-by-sa" or none
  license: none,
  // f) true for (seminar) papers with multiple authors
  multiauthor: false,
  // g) true for fonts without serifs (serif font is standard)
  sansserif: false,
  // h) true to display the #sectionquestions[] boxes
  sectionquestions: false,
  // Information for the title page
  title: [],
  author: "",
  email: "",
  id: "",
  field: "",
  city: "Münster",
  professor: "",
  supervisor: "",
  course: none, // only required for seminar theses
  date: "",
  // Optional parts
  abstract: none, // content of the abstract, or none
  confidential: none, // company name for the confidentiality statement, or none
  bibliography: none, // pass: bibliography("library.bib")
  body,
) = {
  // ____ Option validation ____
  assert(
    language in ("english", "german"),
    message: "Unknown language '" + language + "' specified",
  )
  assert(
    thesis in ("seminar", "bachelor", "master"),
    message: "Unknown type of thesis '" + thesis + "' specified",
  )
  assert(
    chair in ("csssa", "machineLearning", "datascience", "dips", "bpm", "SE"),
    message: "Unknown chair '" + chair + "' specified",
  )
  assert(
    supervisor-mode in ("supervisor", "postdoc"),
    message: "Unknown supervisor mode '" + supervisor-mode + "' specified",
  )

  let l10n = _l10n.with(language)
  let tf = _titlefont.with(sansserif)
  let main-font = if sansserif { _sans-fonts } else { _serif-fonts }

  // Chapters are called "Section" in English DIPS theses;
  // appendix chapters are called "Appendix" (see #appendix).
  let chapterword = l10n(if chair == "dips" { "Section" } else { "Chapter" }, "Kapitel")
  _wi-sectionquestions.update(sectionquestions)
  _wi-chapterword.update(chapterword)

  // ____ Document & text setup ____

  set document(title: title, author: author)
  set text(
    font: main-font,
    size: 12pt,
    lang: l10n("en", "de"),
    region: l10n("GB", "DE"),
  )

  // One-and-a-half line spacing, no indent, spacing between paragraphs
  set par(leading: 0.8em, spacing: 1.6em, justify: true, first-line-indent: 0pt)

  // ____ Headings ____

  set heading(numbering: "1.1", supplement: l10n([Section], [Abschnitt]))
  show heading.where(level: 1): set heading(supplement: context _wi-chapterword.get())

  show heading: it => {
    // Chapters (level 1): start a new page, \Large bold, number in a 1 cm box
    if it.level == 1 {
      pagebreak(weak: true)
      counter(math.equation).update(0) // equations are numbered per chapter
      block(above: 0pt, below: 18pt, {
        set text(size: _size-Large, weight: "bold", font: main-font)
        set par(justify: false, leading: 0.5em)
        if it.numbering != none {
          box(width: 1cm, counter(heading).display(it.numbering))
        }
        it.body
      })
    } else if it.numbering == none {
      // Numberless sub-headings are set in italics
      block(above: 12pt, below: 10pt, text(weight: "regular", style: "italic", it.body))
    } else if it.level <= 3 {
      // Sections & subsections: bold, number in a 1 cm box
      block(above: 16pt, below: 12pt, {
        set text(weight: "bold")
        box(width: 1cm, counter(heading).display(it.numbering))
        if it.level == 3 { h(8pt) } // enlarged spacing for subsection numbers
        it.body
      })
    } else {
      // Deeper levels: bold sans-serif, without a number
      block(above: 16pt, below: 12pt, text(weight: "bold", font: _sans-fonts, size: 12pt, it.body))
    }
  }

  // ____ Lists, quotes, links, footnotes ____

  set list(marker: [--], indent: 20pt, body-indent: 12pt)
  set enum(numbering: "1.", indent: 20pt, body-indent: 12pt)
  set quote(block: true)
  show quote.where(block: true): set pad(x: 2em)

  show link: set text(fill: black) // all links are typeset in black

  set footnote.entry(
    separator: line(length: 2in, stroke: 0.5pt),
    indent: 0.75cm,
  )

  // ____ Floats: figures, tables, listings, algorithms ____

  // Continuous numbering and a quad between label and caption
  set figure.caption(separator: h(1em))
  show figure.where(kind: "wi-algorithm"): set figure.caption(position: top)

  // Restart sub-figure numbering, (a), (b), ..., for every regular figure
  show figure: it => {
    if it.kind != "wi-subfigure" {
      counter(figure.where(kind: "wi-subfigure")).update(0)
    }
    it
  }

  // Show the (a), (b), ... numbering in front of sub-figure captions
  show figure.where(kind: "wi-subfigure"): subfig => {
    show figure.caption: cap => context {
      let n = counter(figure.where(kind: "wi-subfigure")).get().first()
      [#numbering("(a)", n)#h(0.5em)#cap.body]
    }
    subfig
  }

  // Source code listings with a light background
  show raw.where(block: true): block.with(
    width: 100%,
    fill: wi-colors.code-background,
    inset: 8pt,
    radius: 2pt,
  )

  // ____ Equations ____

  // Equations are numbered per chapter, e.g. (2.1)
  set math.equation(numbering: n => context {
    let chapter = counter(heading).get().first()
    numbering("(1.1)", chapter, n)
  })

  // ____ Bibliography style ____

  // Alphanumeric style, e.g. [GBC16], for the Machine Learning chair,
  // APA style for all other chairs.
  set std.bibliography(style: if chair == "machineLearning" { "alphanumeric.csl" } else { "apa" })

  // ____ Title page ____

  set page(paper: "a4")

  page(margin: (x: 2cm, y: 3cm), header: none, footer: none, {
    set align(center)
    v(0.3cm)
    tf(text(size: _size-Large, l10n([University of Münster], [Universität Münster])))
    parbreak()
    tf(text(size: _size-large, l10n([Department of Information Systems], [Institut für Wirtschaftsinformatik])))
    v(1cm)
    line(length: 90%, stroke: 0.5mm + gray)
    v(0.5cm)
    box(width: 90%, {
      set text(size: _size-LARGE)
      set par(leading: 0.6em, justify: false)
      title
    })
    v(0.5cm)
    line(length: 90%, stroke: 0.5mm + gray)
    v(1.5cm)
    box(width: 75%, _thesistype(language, thesis, course, sansserif))
    parbreak()
    v(0.4cm)
    l10n([submitted by], [eingereicht von])
    parbreak()
    v(0.4cm)
    text(size: _size-LARGE, author)
    v(1fr)
    _chairlogo(language, chair)
  })

  // ____ Back of the title page ____

  page(margin: (x: 2cm, y: 3cm), header: none, footer: none, {
    let (chair-intro, chair-name) = _chairname(language, chair)
    set align(center + bottom)
    grid(
      columns: (5.5cm, 7cm),
      align: (right, left),
      inset: (x: 8pt, y: 5pt),
      grid.vline(x: 1, stroke: 0.5pt),
      strong(l10n([Principal Supervisor], [Themensteller])), smallcaps(professor),
      ..if supervisor-mode == "supervisor" {
        (strong(l10n([Supervisor], [Betreuer])), smallcaps(supervisor))
      } else { () },
      ..if chair-intro != none { ([], chair-intro) } else { () },
      [], chair-name,
      [], [],
      strong(l10n([Student Candidate], [Studierender])), author,
      strong(l10n([Matriculation Number], [Matrikelnummer])), id,
      strong(l10n([Field of Study], [Studienfach])), field,
      strong(l10n([Contact Details], [Kontaktdetails])), link("mailto:" + email, email),
      strong(l10n([Submission Date], [Abgabedatum])), date,
    )
  })

  // ____ Abstract (optional) ____

  if abstract != none {
    page(margin: (x: 2.9cm, top: 2.9cm, bottom: 2.3cm), header: none, footer: none, {
      v(2cm)
      align(center, text(size: _size-large, weight: "bold", l10n([Abstract], [Zusammenfassung])))
      v(1em)
      pad(x: 1cm, abstract)
    })
  }

  // ____ Confidentiality statement (optional) ____

  if confidential != none {
    page(margin: (x: 2.9cm, top: 2.9cm, bottom: 2.3cm), header: none, footer: none, {
      text(size: _size-Large, weight: "bold", l10n([Confidentiality Statement], [Sperrvermerk]))
      v(1em)
      l10n(
        [This #_thesistypename(language, thesis) is based on internal and confidential
          data from the Company #confidential. This work may not be made accessible to
          third parties, except for the supervisors, authorized members of the
          examination committee and examination office, without explicit consent from
          both the company and the author. Reproduction and publication of the
          #_thesistypename(language, thesis), even in part, is not permitted without
          explicit permission.],
        [Diese #_thesistypename(language, thesis) basiert auf internen und vertraulichen
          Daten des Unternehmens #confidential. Diese Arbeit darf Dritten, mit Ausnahme
          der betreuenden Dozenten, befugten Mitgliedern des Prüfungsausschusses und des
          Prüfungsamtes ohne ausdrückliche Zustimmung des Unternehmens und des
          Verfassers nicht zugänglich gemacht werden. Eine Vervielfältigung und
          Veröffentlichung der #_thesistypename(language, thesis) ohne ausdrückliche
          Genehmigung -- auch in Auszügen -- ist nicht erlaubt.],
      )
    })
  }

  // ____ Table of contents ____

  {
    set page(margin: (x: 3cm, top: 3cm, bottom: 2.5cm), header: none, footer: none)
    set par(leading: 0.65em, spacing: 0.9em)
    outline(depth: 3)
  }

  // ____ Main content ____

  // Header with the current chapter for bachelor and master theses
  let nice-header = context {
    let chapters = query(heading.where(level: 1))
      .filter(h => h.numbering != none and h.location().page() <= here().page())
    if chapters.len() == 0 { return }
    let current = chapters.last()
    let number = numbering(current.numbering, ..counter(heading).at(current.location()))
    set text(size: _size-footnote)
    align(right, upper[#_wi-chapterword.get() #number. #current.body])
    place(bottom, dy: 4pt, line(length: 100%, stroke: 0.1pt))
  }

  set page(
    margin: (x: 2.9cm, top: 2.9cm, bottom: 2.3cm),
    header: if thesis == "seminar" { none } else { nice-header },
    footer: align(center, text(size: _size-small, context counter(page).display("1"))),
  )

  counter(page).update(1)

  body

  // ____ Backmatter: bibliography, declarations & consent forms ____

  set page(header: none)

  if bibliography != none {
    bibliography
  }

  // Declaration of Authorship
  page(footer: none, {
    text(size: _size-Large, weight: "bold", l10n([Declaration of Authorship], [Abschließende Erklärung]))
    v(1em)
    if language == "german" {
      if multiauthor [
        Wir versichern hiermit, dass wir die Arbeit #emph(title) selbständig und ohne
        fremde Hilfe angefertigt haben und dass wir alle von anderen Autoren wörtlich
        übernommenen Stellen wie auch die sich an die Gedankengänge anderer Autoren eng
        anlehnenden Ausführungen unserer Arbeit besonders gekennzeichnet und die
        Quellen zitiert haben; dies gilt auch für Tabellen, Skizzen, Zeichnungen,
        bildliche Darstellungen usw.
      ] else [
        Ich versichere hiermit, dass ich meine Arbeit #emph(title) selbständig und ohne
        fremde Hilfe angefertigt habe und dass ich alle von anderen Autoren wörtlich
        übernommenen Stellen wie auch die sich an die Gedankengänge anderer Autoren eng
        anlehnenden Ausführungen meiner Arbeit besonders gekennzeichnet und die Quellen
        zitiert habe; dies gilt auch für Tabellen, Skizzen, Zeichnungen, bildliche
        Darstellungen usw.
      ]
    } else {
      if multiauthor [
        We hereby declare that, to the best of our knowledge and belief, this thesis
        titled #emph(title) is our own, independent work. We confirm that each
        significant contribution to and quotation in this thesis that originates from
        the work or works of others is indicated by proper use of citation and
        references; this also holds for tables and graphical works.
      ] else [
        I hereby declare that, to the best of my knowledge and belief, this thesis
        titled #emph(title) is my own, independent work. I confirm that each significant
        contribution to and quotation in this thesis that originates from the work or
        works of others is indicated by proper use of citation and references; this
        also holds for tables and graphical works.
      ]
    }
    v(1em)
    _signatures(language, multiauthor, author, city, date)
    v(1fr)
    _license-statement(language, license)
  })

  // Consent Form
  page(footer: none, {
    text(size: _size-Large, weight: "bold", l10n([Consent Form], [Einverständniserklärung]))
    v(3mm)
    if language == "german" [
      *Name:* #author \
      *Titel der Arbeit:* #title

      *Was ist ein Plagiat?* Als ein Plagiat wird eine Übernahme fremden Gedankengutes
      in die eigene Arbeit angesehen, bei der die Quelle, aus der die Übernahme
      erfolgt, nicht kenntlich gemacht wird. Es ist dabei unerheblich, ob z.B. fremde
      Texte wörtlich übernommen werden, nur Strukturen (z.B. argumentative Figuren
      oder Gliederungen) aus fremden Quellen entlehnt oder Texte aus einer
      Fremdsprache übersetzt werden.

      *Softwarebasierte Überprüfung.* Alle Bachelor- und Masterarbeiten werden vom
      Prüfungsamt mit Hilfe einer entsprechenden Software auf Plagiate geprüft. Die
      Arbeit wird zum Zweck der Plagiatsprüfung an einen Software-Dienstleister
      übermittelt und dort auf Übereinstimmung mit anderen Quellen geprüft. Zum Zweck
      eines zukünftigen Abgleichs mit anderen Arbeiten wird die Arbeit dauerhaft in
      einer Datenbank gespeichert. Ein Abruf der Arbeit ist ausschließlich durch die
      Wirtschaftswissenschaftliche Fakultät der Universität Münster möglich. Der
      Studierende erklärt sich damit einverstanden, dass allein zum beschriebenen
      Zweck der Plagiatsprüfung die Arbeit dauerhaft gespeichert und vervielfältigt
      werden darf. Das Ergebnis der elektronischen Plagiatsprüfung wird dem
      Erstgutachter mitgeteilt.

      *Sanktionen* Liegt ein Plagiat vor, ist dies ein Täuschungsversuch i.S. der
      Prüfungsordnung, durch den die Prüfungsleistung als „nicht bestanden" gewertet
      wird. Es erfolgt eine Mitteilung an das Prüfungsamt und die dortige
      Dokumentation. In schwerwiegenden Täuschungsfällen kann der Prüfling von der
      Prüfung insgesamt ausgeschlossen werden. Dies kann unter Umständen die
      Exmatrikulation bedeuten. Plagiate können auch nach Abschluss des
      Prüfungsverfahrens und Verleihung des Hochschulgrades zum Entzug des erworbenen
      Grades führen.

      #if multiauthor [
        Hiermit erklären wir, dass wir die obigen Ausführungen gelesen haben und mit
        dem Verfahren zur Aufdeckung und Sanktionierung von Plagiaten einverstanden
        sind.
      ] else [
        Hiermit erkläre ich, dass ich die obigen Ausführungen gelesen habe und mit dem
        Verfahren zur Aufdeckung und Sanktionierung von Plagiaten einverstanden bin.
      ]

      #_signatures(language, multiauthor, author, city, date)
    ] else [
      *Name:* #author \
      *Title of Thesis:* #title

      *What is plagiarism?* Plagiarism is defined as submitting someone else's work
      or ideas as your own without a complete indication of the source. It is hereby
      irrelevant whether the work of others is copied word by word without
      acknowledgment of the source, text structures (e.g. line of argumentation or
      outline) are borrowed or texts are translated from a foreign language.

      *Use of plagiarism detection software.* The examination office uses plagiarism
      software to check each submitted bachelor and master thesis for plagiarism. For
      that purpose the thesis is electronically forwarded to a software service
      provider where the software checks for potential matches between the submitted
      work and work from other sources. For future comparisons with other theses,
      your thesis will be permanently stored in a database. Only the School of
      Business and Economics of the University of Münster is allowed to access your
      stored thesis. The student agrees that his or her thesis may be stored and
      reproduced only for the purpose of plagiarism assessment. The first examiner of
      the thesis will be advised on the outcome of the plagiarism assessment.

      *Sanctions* Each case of plagiarism constitutes an attempt to deceive in terms
      of the examination regulations and will lead to the thesis being graded as
      "failed". This will be communicated to the examination office where your case
      will be documented. In the event of a serious case of deception the examinee
      can be generally excluded from any further examination. This can lead to the
      exmatriculation of the student. Even after completion of the examination
      procedure and graduation from university, plagiarism can result in a withdrawal
      of the awarded academic degree.

      #if multiauthor [
        We confirm that we have read and understood the information in this document.
        We agree to the outlined procedure for plagiarism assessment and potential
        sanctioning.
      ] else [
        I confirm that I have read and understood the information in this document. I
        agree to the outlined procedure for plagiarism assessment and potential
        sanctioning.
      ]

      #_signatures(language, multiauthor, author, city, date)
    ]
  })
}
