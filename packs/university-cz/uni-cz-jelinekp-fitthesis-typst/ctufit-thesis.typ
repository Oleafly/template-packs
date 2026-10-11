// =============================================================================
// ctufit-thesis — a Typst port of the CTU FIT thesis class.
//
// Ported from FITthesis-LaTeX v1.6.4
//   https://gitlab.fit.cvut.cz/theses-templates/FITthesis-LaTeX
//
// Original LaTeX template:
//   © 2024 Tomáš Nováček, © 2021 Eliška Šestáková & Ondřej Guth
//
// Distributed under the LaTeX Project Public License (LPPL) 1.3+.
// =============================================================================

// muchpdf is used to embed the (multi-page) thesis assignment PDF.
#import "@preview/muchpdf:0.1.1": muchpdf

// -----------------------------------------------------------------------------
// Localised labels (cz / en / sk).
// -----------------------------------------------------------------------------

#let _LABELS = (
  thesis-type: (
    bachelor:          (cs: "Bakalářská práce",   en: "Bachelor's thesis",     sk: "Bakalárska práca"),
    master:            (cs: "Diplomová práce",    en: "Master's thesis",       sk: "Diplomová práca"),
    dissertation:      (cs: "Disertační práce",   en: "Dissertation thesis",   sk: "Disertačná práca"),
    "doctoral-report": (cs: "Odborná studie",     en: "Doctoral study report", sk: "Odborná štúdia"),
  ),
  university:        (cs: "České vysoké učení technické v Praze",
                      en: "Czech Technical University in Prague",
                      sk: "České vysoké učenie technické v Prahe"),
  faculty:           (cs: "Fakulta informačních technologií",
                      en: "Faculty of Information Technology",
                      sk: "Fakulta informačných technológií"),
  program:           (cs: "Studijní program",  en: "Study program",       sk: "Študijný program"),
  specialisation:    (cs: "Specializace",      en: "Specialisation",      sk: "Špecializácia"),
  supervisor:        (cs: "Vedoucí",           en: "Supervisor",          sk: "Vedúci"),
  citation:          (cs: "Odkaz na tuto práci", en: "Citation of this thesis", sk: "Odkaz na túto prácu"),
  rights-reserved:   (cs: "Všechna práva vyhrazena.", en: "All rights reserved.", sk: "Všetky práva vyhradené."),
  listing:           (cs: "Výpis kódu",        en: "Code listing",         sk: "Výpis kódu"),
  list-of-listings:  (cs: "Seznam výpisů kódu", en: "List of Code listings", sk: "Zoznam výpisov kódu"),
  algorithm:         (cs: "Pseudokód",         en: "Algorithm",            sk: "Pseudokód"),
  list-of-algorithms:(cs: "Seznam pseudokódů", en: "List of Algorithms",   sk: "Zoznam pseudokódov"),
  declaration:       (cs: "Prohlášení",        en: "Declaration",          sk: "Vyhlásenie"),
  abbreviations:     (cs: "Seznam zkratek",    en: "List of abbreviations", sk: "Zoznam skratiek"),
  acknowledgments:   (cs: "Poděkování",        en: "Acknowledgments",      sk: "Poďakovanie"),
  abstract-cze:      (cs: "Abstrakt",          en: "Abstrakt",             sk: "Abstrakt"),
  abstract-eng:      (cs: "Abstract",          en: "Abstract",             sk: "Abstract"),
  keywords-cze:      (cs: "Klíčová slova",     en: "Klíčová slova",        sk: "Kľúčové slová"),
  keywords-eng:      (cs: "Keywords",          en: "Keywords",             sk: "Keywords"),
  in-place:          (cs: "V",                 en: "In",                   sk: "V"),
  on-date:           (cs: "dne",               en: "on",                   sk: "dňa"),
  contents:          (cs: "Obsah",             en: "Contents",             sk: "Obsah"),
  list-of-figures:   (cs: "Seznam obrázků",    en: "List of Figures",      sk: "Zoznam obrázkov"),
  list-of-tables:    (cs: "Seznam tabulek",    en: "List of Tables",       sk: "Zoznam tabuliek"),
  bibliography:      (cs: "Bibliografie",      en: "Bibliography",         sk: "Bibliografia"),
  figure:            (cs: "Obrázek",           en: "Figure",               sk: "Obrázok"),
  table:             (cs: "Tabulka",           en: "Table",                sk: "Tabuľka"),
  chapter:           (cs: "Kapitola",          en: "Chapter",              sk: "Kapitola"),
  appendix:          (cs: "Příloha",           en: "Appendix",             sk: "Príloha"),
  copyright-text: (
    cs: [Tato práce vznikla jako školní dílo na Českém vysokém učení technickém v~Praze, Fakultě informačních technologií. Práce je chráněna právními předpisy a~mezinárodními úmluvami o~právu autorském a~právech souvisejících s~právem autorským. K~jejímu užití, s~výjimkou bezúplatných zákonných licencí a nad rámec oprávnění uvedených v~Prohlášení, je nezbytný souhlas autora.],
    en: [This thesis is school work as defined by the Copyright Act of the Czech Republic. It has been submitted to the Czech Technical University in Prague, Faculty of Information Technology. The thesis is protected by the Copyright Act and its use, with the exception of free statutory licenses and beyond the scope of the authorisations specified in the Declaration, requires the consent of the author.],
    sk: [Táto práca vznikla ako školské dielo na FIT ČVUT v Prahe. Práca je chránená medzinárodnými predpismi a~zmluvami o~autorskom práve a~právach súvisiacich s~autorským právom. Na jej využitie, s~výnimkou bezodplatných zákonných licencií a nad rámec oprávnení uvedených vo~Vyhlásenie, je nutný súhlas autora.],
  ),
  // theorem-style labels
  theorem:     (cs: "Věta",       en: "Theorem",     sk: "Veta"),
  lemma:       (cs: "Tvrzení",    en: "Lemma",       sk: "Tvrdenie"),
  observation: (cs: "Pozorování", en: "Observation", sk: "Pozorovanie"),
  corollary:   (cs: "Důsledek",   en: "Corollary",   sk: "Dôsledok"),
  proposition: (cs: "Návrh",      en: "Proposition", sk: "Návrh"),
  definition:  (cs: "Definice",   en: "Definition",  sk: "Definícia"),
  example:     (cs: "Příklad",    en: "Example",     sk: "Príklad"),
  note:        (cs: "Poznámka",   en: "Note",        sk: "Poznámka"),
  remark:      (cs: "Poznámka",   en: "Remark",      sk: "Pozorovanie"),
  proof:       (cs: "Důkaz",      en: "Proof",       sk: "Dôkaz"),
)

#let _MONTHS-GENITIVE = (
  cs: ("ledna", "února", "března", "dubna", "května", "června",
       "července", "srpna", "září", "října", "listopadu", "prosince"),
  sk: ("januára", "februára", "marca", "apríla", "mája", "júna",
       "júla", "augusta", "septembra", "októbra", "novembra", "decembra"),
  en: ("January", "February", "March", "April", "May", "June",
       "July", "August", "September", "October", "November", "December"),
)

#let _lang-key(language) = (
  if   language == "english" { "en" }
  else if language == "slovak"  { "sk" }
  else                          { "cs" }
)

#let _typst-lang(language) = (
  if   language == "english" { "en" }
  else if language == "slovak"  { "sk" }
  else                          { "cs" }
)

#let _L(key, language) = _LABELS.at(key).at(_lang-key(language))

#let _thesis-type-name(thesis-type, language) = {
  _LABELS.thesis-type.at(thesis-type).at(_lang-key(language))
}

// Localised long date — emulates LaTeX `\today` under Czech / Slovak / English babel.
#let format-long-date(date, language) = {
  let lk = _lang-key(language)
  let m = _MONTHS-GENITIVE.at(lk).at(date.month() - 1)
  if language == "english" { [#m #date.day(), #date.year()] }
  else                     { [#date.day(). #m #date.year()] }
}

// -----------------------------------------------------------------------------
// Document state.
// -----------------------------------------------------------------------------

#let _matter   = state("ctufit-matter",   "front")     // "front" | "main" | "appendix" | "back"
#let _language = state("ctufit-language", "czech")
#let _bw       = state("ctufit-bw", false)

// -----------------------------------------------------------------------------
// Public helpers.
// -----------------------------------------------------------------------------

// Italic mini-introduction at the top of a chapter — the LaTeX
// `chapterabstract` environment (see ctufit-thesis.cls).  In the original it's
// rendered as `\hfill\begin{minipage}{textwidth-0.5cm}\itshape`, i.e. a
// minipage flush against the right edge with a 0.5 cm gap on the left.
#let chapter-abstract(body) = {
  block(
    width: 100%,
    above: 4em,
    below: 2em,
    pad(left: 0.5cm, text(style: "italic", body)),
  )
}

// Minimal LaTeX `dirtree` port.
#let dirtree(tree) = {
  set par(leading: 0.55em, justify: false, first-line-indent: 0pt)
  let render(nodes, depth) = {
    for node in nodes {
      let name = node.at(0)
      let comment = node.at(1, default: "")
      let children = if node.len() > 2 { node.slice(2) } else { () }
      block(
        spacing: 0.35em,
        {
          h(1.2em * depth)
          if depth > 0 { [├── ] }
          raw(name)
          if comment != "" and comment != none {
            h(0.6em); text(style: "italic", size: 0.9em)[\u{2026} #comment]
          }
        },
      )
      if children.len() > 0 { render(children, depth + 1) }
    }
  }
  render(tree, 0)
}

// -----------------------------------------------------------------------------
// Theorem-like environments.
// -----------------------------------------------------------------------------

#let _theorem-counter = counter("ctufit-theorem")

#let _theorem-block(name, body, label-name: none) = {
  _theorem-counter.step()
  context {
    let n = _theorem-counter.get().first()
    let chap = counter(heading).get().at(0, default: 1)
    let bw   = _bw.get()
    let mark-color = if bw { black } else { rgb(0, 122, 195) }
    block(above: 1.6em, below: 1.6em, {
      text(fill: mark-color)[▸]
      h(0.4em)
      strong[#name #chap.#n#if label-name != none [ (#label-name)]]
      [.]
      h(0.5em)
      body
    })
  }
}

#let theorem(body, label-name: none)     = context _theorem-block(_L("theorem",     _language.get()), body, label-name: label-name)
#let lemma(body, label-name: none)       = context _theorem-block(_L("lemma",       _language.get()), body, label-name: label-name)
#let observation(body, label-name: none) = context _theorem-block(_L("observation", _language.get()), body, label-name: label-name)
#let corollary(body, label-name: none)   = context _theorem-block(_L("corollary",   _language.get()), body, label-name: label-name)
#let proposition(body, label-name: none) = context _theorem-block(_L("proposition", _language.get()), body, label-name: label-name)
#let definition(body, label-name: none)  = context _theorem-block(_L("definition",  _language.get()), body, label-name: label-name)
#let example(body, label-name: none)     = context _theorem-block(_L("example",     _language.get()), body, label-name: label-name)
#let note(body, label-name: none)        = context _theorem-block(_L("note",        _language.get()), body, label-name: label-name)
#let remark(body, label-name: none)      = context _theorem-block(_L("remark",      _language.get()), body, label-name: label-name)

#let proof(body) = context block(above: 1em, below: 1em, {
  emph(_L("proof", _language.get()) + ".")
  h(0.5em)
  body
  h(1fr)
  sym.square.stroked
})

// -----------------------------------------------------------------------------
// Code listing helper.
// -----------------------------------------------------------------------------

#let listing(body, caption: none, lang: none) = context {
  let bw = _bw.get()
  let bg = if bw { rgb(240, 240, 240) } else { rgb(199, 219, 241) }
  figure(
    kind: "listing",
    supplement: _L("listing", _language.get()),
    caption: caption,
    block(
      width: 100%,
      fill: bg,
      inset: 0.6em,
      stroke: none,
      if type(body) == str {
        raw(body, lang: lang, block: true)
      } else {
        body
      },
    ),
  )
}

#let list-of-listings() = context outline(
  title: _L("list-of-listings", _language.get()),
  target: figure.where(kind: "listing"),
)

// -----------------------------------------------------------------------------
// Matter switches.
// -----------------------------------------------------------------------------

// Applied via `#show: appendix-matter` just before the first appendix chapter.
#let appendix-matter(body) = {
  _matter.update("appendix")
  counter(heading).update(0)
  set heading(numbering: (..n) => {
    let nums = n.pos()
    if nums.len() == 1 {
      numbering("A", nums.first())
    } else {
      numbering("A", nums.first()) + "." + nums.slice(1).map(str).join(".")
    }
  })
  body
}

// Applied via `#show: back-matter` for content that should have unnumbered
// chapters (e.g. the bibliography, `Obsah příloh` / contents of the attached
// medium).  Call this once between the appendix and the bibliography.
#let back-matter(body) = {
  _matter.update("back")
  set heading(numbering: none)
  body
}

// Emits the bibliography as a back-matter chapter.  Equivalent to LaTeX
// `\printbibliography[heading=bibintoc]` after `\backmatter`.
//
// Call between the appendix and any additional back-matter content (e.g.
// `Obsah příloh`).  Requires the `back-matter` switch to already be active.
// Default style: bracketed ISO-690 numeric, matching LaTeX biblatex
// `style=iso-numeric` (which produces `[N]` in-text citations and an
// ISO-690 reference list).  Pass an alternative style as the keyword
// argument or as a path to a CSL file.
#let bibliography-section(source, style: "iso690-numeric-brackets-cs.csl", language: auto) = context {
  let lang = if language == auto { _language.get() } else { language }
  // Add a little extra vertical breathing room between entries.  LaTeX's
  // `biblatex` adds `\itemsep` between items; we mirror that with paragraph
  // spacing scoped to the bibliography.
  set par(spacing: 1em)
  bibliography(source, style: style, full: false, title: _L("bibliography", lang))
}

// -----------------------------------------------------------------------------
// Main template entry point.
// -----------------------------------------------------------------------------

#let ctufit-thesis(
  // ---- bibliographic information ----
  title: "",
  author-full: "",
  author-given-names: "",
  author-surnames: "",
  supervisor: "",
  department: "",
  program: "",
  specialisation: none,
  year: 2026,
  declaration-place: "",
  declaration-date: datetime.today(),     // either a `datetime` or a string
  // ---- abstracts / keywords ----
  abstract-cze: [],
  abstract-eng: [],
  keywords-cze: "",
  keywords-eng: "",
  // ---- structural options ----
  language: "czech",
  thesis-type: "bachelor",
  bw: false,
  twoside: false,
  // ---- optional content blocks ----
  acknowledgment: none,
  declaration: none,
  abbreviations: none,
  // ---- assignment ----
  assignment: none,
  // ---- font configuration ----
  body-font: "New Computer Modern",
  sans-font: "New Computer Modern",
  mono-font: "DejaVu Sans Mono",
  // ---- the document body ----
  body,
) = {
  // ---------- colour palette ----------
  let decoration   = if bw { rgb(0, 0, 0) } else { rgb(0, 122, 195) }
  let heading-clr  = decoration
  let head-bg-gray = if bw { rgb(208, 208, 208) } else { rgb(199, 219, 241) }
  let bg-gray      = if bw { rgb(240, 240, 240) } else { rgb(199, 219, 241) }
  let head-gray    = rgb("#7F7F82")
  let enum-gray    = decoration

  // ---------- logo path ----------
  let logo-path = if language == "english" {
    if bw { "images/logos/logo_CVUT_en_bw.pdf" } else { "images/logos/logo_CVUT_en.pdf" }
  } else {
    if bw { "images/logos/logo_CVUT_bw.pdf" } else { "images/logos/logo_CVUT.pdf" }
  }

  // ---------- format declaration date ----------
  let date-str = if type(declaration-date) == str {
    declaration-date
  } else {
    format-long-date(declaration-date, language)
  }
  let title-page-date = format-long-date(datetime.today(), language)

  // ---------- document metadata ----------
  set document(title: title, author: author-full)

  // ---------- global text & paragraph defaults ----------
  set text(lang: _typst-lang(language), font: body-font, size: 11pt)
  // `all: false` matches LaTeX behaviour where the first paragraph after a
  // heading has no indent, while continuation paragraphs do.
  set par(justify: true, leading: 0.65em, spacing: 0.65em,
    first-line-indent: (amount: 1.5em, all: false))

  _language.update(language)
  _bw.update(bw)

  // ---------- page geometry ----------
  let page-margin = if twoside {
    (top: 4.6cm, bottom: 4cm, inside: 4.7cm, outside: 3.25cm)
  } else {
    (top: 4.6cm, bottom: 4cm, left: 3.95cm, right: 4.0cm)
  }

  // ---------- list / enum / terms markers ----------
  // Indent: 1.5em per nesting level (LaTeX `\leftmargini..\leftmarginiv`).
  // `tight: false` gives the breathing room between items the LaTeX class
  // produces with its default itemize spacing.
  set list(
    tight: false,
    indent: 0.8em,
    body-indent: 0.5em,
    marker: (
      // baseline matches LaTeX `\rule[0.3ex]{...}` — rectangle sits with its
      // bottom about 0.3 ex above the text baseline, i.e. roughly mid-x-height.
      box(width: 0.67em, height: 0.33em, fill: enum-gray, baseline: 0.5em),
      box(width: 0.45em, height: 0.225em, fill: enum-gray, baseline: 0.5em),
      text(fill: enum-gray, weight: "bold", baseline: 0.2em)[\*],
      text(fill: enum-gray, weight: "bold")[·],
    ),
  )
  // LaTeX `\labelenumi/ii/iii/iv` produce 1., a., i., A. at successive levels.
  set enum(
    tight: false,
    indent: 0.8em,
    full: true,
    numbering: (..nums) => {
      let depth = nums.pos().len()
      let n = nums.pos().last()
      let label = if depth == 1 { numbering("1.", n) }
        else if depth == 2 { numbering("a.", n) }
        else if depth == 3 { numbering("i.", n) }
        else                { numbering("A.", n) }
      text(fill: enum-gray, weight: "bold", label)
    },
  )
  // Add a small top/bottom margin around lists, mirroring LaTeX's `\topsep`.
  show list: it => block(above: 0.9em, below: 0.6em, it)
  show enum: it => block(above: 0.9em, below: 0.6em, it)
  show terms.item: it => block(above: 0.4em, {
    text(fill: enum-gray, weight: "bold", it.term)
    h(0.6em)
    it.description
  })

  // ---------- captions ----------
  show figure.caption: it => block(
    width: 100%,
    above: 0.6em,
    {
      set text(size: 10pt)
      set par(justify: false, first-line-indent: 0pt, leading: 0.55em)
      box(width: 0.73em, height: 0.73em, fill: decoration, baseline: 0pt)
      h(0.67em)
      text(weight: "bold", font: sans-font)[#it.supplement #context it.counter.display(it.numbering)]
      sym.space.nobreak
      it.body
    },
  )

  show figure.where(kind: image): set figure(supplement: _L("figure", language))
  show figure.where(kind: table): set figure(supplement: _L("table",  language))

  // Figures (image / table / listing) inherit the figure's default placement
  // (centred).  Override to align them with the body's left margin so they
  // sit flush left, matching the body text, and give them generous breathing
  // room above and below the caption.
  set figure(placement: none)
  show figure: it => block(above: 1.6em, below: 1.6em, align(left, it))

  // ---------- raw blocks ----------
  show raw.where(block: true): it => block(
    width: 100%,
    fill: bg-gray,
    inset: 0.6em,
    text(font: mono-font, size: 9pt, it),
  )
  show raw.where(block: false): it => box(
    inset: (x: 0.15em),
    text(font: mono-font, size: 0.95em, it),
  )

  // ---------- links ----------
  show link: it => underline(stroke: 0.4pt + decoration, offset: 2pt, it)
  show ref: it => text(fill: decoration, it)

  // ---------- outline (TOC) entries — colour level-1 chapter entries blue
  // and add vertical breathing room before each one (LaTeX `\addvspace{1em}`
  // in `\contentsline{chapter}`).  Figure / table / listing outlines keep the
  // body colour and the default tight spacing.
  show outline.entry.where(level: 1): it => context {
    if it.element.func() == heading {
      v(1em)
      text(fill: heading-clr, weight: "bold", it)
    } else {
      it
    }
  }

  // ===========================================================================
  // HEADING SHOW RULES
  // ===========================================================================

  show heading.where(level: 1): it => context {
    let matter = _matter.get()
    pagebreak(weak: true, to: if twoside { "odd" } else { none })
    if matter == "main" or matter == "appendix" {
      // Mainmatter / appendix chapter heading — sits with book-class top
      // padding, dotted decoration + "Kapitola N", then huge blue title
      // (right-aligned).
      let chap-num = counter(heading).get().first()
      let chap = if matter == "appendix" { numbering("A", chap-num) } else { str(chap-num) }
      let kind-label = if matter == "appendix" { _L("appendix", language) } else { _L("chapter", language) }
      v(2cm)
      // Dotted rule fills the line from the left margin up to the
      // "Kapitola N" label on the right (LaTeX `\titlerule*[1pc]{...}`).
      block(above: 0pt, below: 0.4cm, width: 100%, {
        box(width: 1fr,
          repeat(gap: 0.6em, box(width: 0.25em, height: 0.25em, fill: head-bg-gray)))
        h(1em)
        text(size: 15pt, weight: "bold", fill: black)[#kind-label~#chap]
      })
      block(above: 0pt, below: 1cm, width: 100%, {
        set align(right)
        text(size: 22pt, weight: "bold", fill: heading-clr, it.body)
      })
    } else if matter == "back" {
      // Back-matter chapter heading — Huge blue title, no decoration label
      // (LaTeX `\backmatter` mode: bibliography, attached medium contents).
      v(2cm)
      block(above: 0pt, below: 1cm, width: 100%, {
        set align(right)
        text(size: 22pt, weight: "bold", fill: heading-clr, it.body)
      })
    } else {
      // Front-matter chapter heading — \Large \bfseries (~14pt) right-aligned,
      // with chapter-like top spacing.  The vertical offset matches the
      // book-class default chapter top padding.
      v(4.5cm)
      block(above: 0pt, below: 0.6cm, width: 100%, {
        set align(right)
        text(size: 14pt, weight: "bold", fill: heading-clr, it.body)
      })
    }
  }

  show heading.where(level: 2): it => context {
    let matter = _matter.get()
    if matter == "main" or matter == "appendix" {
      let nr = counter(heading).display()
      block(above: 2.3em, below: 1.6em, {
        text(size: 14pt, weight: "bold", fill: heading-clr)[
          #box(fill: head-bg-gray, inset: (x: 0.2em), outset: (y: 0.2em))[#text(fill: black)[#nr]]#h(1em)#it.body
        ]
      })
    } else {
      block(above: 1.2em, below: 0.6em, text(size: 13pt, weight: "bold", fill: heading-clr, it.body))
    }
  }

  show heading.where(level: 3): it => context {
    let nr = counter(heading).display()
    block(above: 2.1em, below: 1.5em, {
      text(size: 13pt, weight: "bold", fill: heading-clr)[
        #text(fill: black)[#nr]#h(1em)#it.body
      ]
    })
  }

  show heading.where(level: 4): it => context {
    let nr = counter(heading).display()
    block(above: 1.9em, below: 1.5em, {
      text(size: 11pt, weight: "bold", fill: heading-clr)[
        #text(fill: black)[#nr]#h(1em)#it.body
      ]
    })
  }

  show heading.where(level: 5): it => block(above: 1.4em, below: 1.3em,
    text(size: 11pt, weight: "bold", fill: heading-clr, it.body))

  // Reset theorem counter at every chapter.
  show heading.where(level: 1): it => {
    _theorem-counter.update(0)
    it
  }

  // ===========================================================================
  // FRONT MATTER
  // ===========================================================================

  set page(
    paper: "a4",
    margin: page-margin,
    header: none,
    footer: context align(center,
      text(fill: head-gray, weight: "bold", counter(page).display("i"))),
    numbering: "i",
  )
  set heading(numbering: none, outlined: false)
  _matter.update("front")
  counter(page).update(1)

  // ----- title page -----
  page(
    margin: (left: 67mm, top: 80mm, right: 40mm, bottom: 40mm),
    header: none,
    footer: none,
    numbering: none,
    {
      set par(first-line-indent: 0pt, justify: false)
      image(logo-path, height: 2.5cm)
      v(2.4cm)
      par(leading: 0.85em,
        text(size: 24.88pt, weight: "bold", fill: black, upper(title)))
      v(1.6cm)
      text(size: 14.4pt, weight: "bold", author-full)
      v(1fr)
      set par(leading: 0.7em)
      [
        #_thesis-type-name(thesis-type, language) \
        #_L("faculty",    language) \
        #_L("university", language) \
        #department \
        #_L("program",    language): #program \
        #if specialisation != none [#_L("specialisation", language): #specialisation \ ]
        #_L("supervisor", language): #supervisor \
        #title-page-date
      ]
    },
  )

  // The title page does not count toward the visible Roman folio.  Reset the
  // counter to 0 here so the next page (assignment / imprint) gets folio "i"
  // and the abbreviations chapter ends up on "ix" (matching the LaTeX
  // book class behaviour).
  counter(page).update(0)

  // ----- assignment PDF -----
  // `assignment` can be a path to a PDF (string) or already-rendered content
  // produced by `muchpdf`.  When a path is given the file is embedded with
  // muchpdf at 100% width using the default page margins of the assignment.
  if assignment != none {
    page(margin: 0pt, header: none, footer: none, numbering: none,
      if type(assignment) == str {
        muchpdf(read(assignment, encoding: none), width: 100%)
      } else {
        assignment
      })
  }

  // ----- imprint -----
  page(header: none, footer: none, numbering: none, {
    set par(first-line-indent: 0pt, justify: true)
    v(1fr)
    set text(size: 9pt)
    [
      #_L("university", language) \
      #_L("faculty",    language) \
      © #year #author-full. #_L("rights-reserved", language) \
      #emph(_L("copyright-text", language))
    ]
    v(1em)
    [#_L("citation", language): #author-surnames #author-given-names. #emph(title). #_thesis-type-name(thesis-type, language). #_L("university", language), #_L("faculty", language), #year.]
  })

  // ----- acknowledgment (no visible heading; italic 70% block in upper third) -----
  if acknowledgment != none {
    page(header: none, footer: none, numbering: none, {
      set par(first-line-indent: 0pt)
      v(1fr)
      box(width: 70%, text(style: "italic", acknowledgment))
      v(2fr)
    })
  }

  // ----- declaration -----
  if declaration != none {
    page(header: none, footer: none, numbering: none, {
      v(1fr)
      block(width: 100%, above: 0pt, below: 1cm, {
        set align(right)
        text(size: 14pt, weight: "bold", fill: heading-clr,
          _L("declaration", language))
      })
      declaration
      v(1cm)
      par(first-line-indent: 0pt)[#_L("in-place", language)~#declaration-place #_L("on-date", language)~#date-str]
    })
  }

  // ----- abstracts (two pages, language-ordered) -----
  let make-abstract-page(title-label, abstract, kw-label, keywords) = page(
    header: none, footer: none, numbering: none,
    {
      set par(first-line-indent: 0pt)
      v(2.5cm)
      align(left, text(size: 14pt, weight: "bold", fill: heading-clr, title-label))
      v(0.6cm)
      abstract
      v(0.5cm)
      [#text(weight: "bold", fill: heading-clr)[#kw-label]#h(1em)#keywords]
    },
  )
  let cze-abstract-page = make-abstract-page(
    _L("abstract-cze", language), abstract-cze,
    _L("keywords-cze", language), keywords-cze,
  )
  let eng-abstract-page = make-abstract-page(
    _L("abstract-eng", language), abstract-eng,
    _L("keywords-eng", language), keywords-eng,
  )
  if language == "english" { eng-abstract-page; cze-abstract-page }
  else                     { cze-abstract-page; eng-abstract-page }

  // ----- TOC -----
  // Front-matter chapters must NOT appear in the TOC; we leave their headings
  // un-outlined and turn outlining on at main-matter start.
  outline(title: _L("contents", language), depth: 4, indent: auto)

  // ----- Lists of figures / tables / listings (combined on one page) -----
  // LaTeX wraps `\listoftables` and friends in `\begingroup\let\clearpage\relax`
  // so they share a page with `\listoffigures`.  We mirror that by emitting
  // the figure list through `outline()` (which inserts the page break and
  // chapter heading), then placing follow-up lists with a plain heading-like
  // block on the same page.
  let secondary-list-heading(title-label) = block(
    above: 2cm, below: 2em, width: 100%,
    {
      set align(right)
      text(size: 14pt, weight: "bold", fill: heading-clr, title-label)
    },
  )
  context {
    let figs   = query(figure.where(kind: image))
    let tabs   = query(figure.where(kind: table))
    let lstngs = query(figure.where(kind: "listing"))
    if figs.len() > 0 {
      outline(title: _L("list-of-figures", language), target: figure.where(kind: image))
    }
    if tabs.len() > 0 {
      secondary-list-heading(_L("list-of-tables", language))
      outline(title: none, target: figure.where(kind: table))
    }
    if lstngs.len() > 0 {
      secondary-list-heading(_L("list-of-listings", language))
      outline(title: none, target: figure.where(kind: "listing"))
    }
  }

  // ----- abbreviations -----
  if abbreviations != none {
    heading(level: 1, numbering: none, outlined: false, _L("abbreviations", language))
    abbreviations
  }

  // ===========================================================================
  // MAIN MATTER
  // ===========================================================================

  pagebreak(to: if twoside { "odd" } else { none })

  set page(
    paper: "a4",
    margin: page-margin,
    header: context {
      let here-loc = here()
      let cur-page = here-loc.page()
      // Suppress header on chapter-opening pages.
      let chapters-on-page = query(heading.where(level: 1))
        .filter(h => h.location().page() == cur-page)
      if chapters-on-page.len() > 0 { return [] }
      // Section name = most recent level-2 heading; fall back to chapter.
      let active-chap = none
      let active-sec  = none
      for h in query(heading.where(level: 1)) {
        if h.location().page() <= cur-page { active-chap = h }
      }
      for h in query(heading.where(level: 2)) {
        if h.location().page() <= cur-page { active-sec = h }
      }
      // Make sure section reset happens on chapter boundaries.
      if active-sec != none and active-chap != none and active-sec.location().page() < active-chap.location().page() {
        active-sec = none
      }
      if active-chap == none or active-chap.numbering == none { return [] }

      let chap-n = counter(heading).at(active-chap.location()).first()
      let chap-text = if _matter.at(here-loc) == "appendix" {
        [#numbering("A", chap-n).~#active-chap.body]
      } else { [#chap-n.~#active-chap.body] }

      // LaTeX `\rightmark` is just the section title (\sectionmark{#1}\markright{#1}),
      // no chapter / section number prefix.
      let sec-text = if active-sec != none { active-sec.body } else { chap-text }

      let pn = counter(page).display()
      let txt-style(c) = text(fill: head-gray, weight: "bold", c)
      if twoside {
        if calc.odd(cur-page) {
          // odd: section L, page R
          txt-style(sec-text); h(1fr); txt-style(pn)
        } else {
          // even: page L, chapter R
          txt-style(pn); h(1fr); txt-style(chap-text)
        }
      } else {
        // oneside: section L, page R (matches LaTeX `\fancyhead[LO]/[RO]`)
        txt-style(sec-text); h(1fr); txt-style(pn)
      }
    },
    footer: context {
      let cur-page = here().page()
      let chapters-on-page = query(heading.where(level: 1))
        .filter(h => h.location().page() == cur-page)
      if chapters-on-page.len() > 0 {
        align(center, text(fill: head-gray, weight: "bold", counter(page).display("1")))
      } else { [] }
    },
    numbering: "1",
  )
  set heading(numbering: "1.1.1.1", outlined: true)
  _matter.update("main")
  counter(heading).update(0)
  counter(page).update(1)

  body
}
