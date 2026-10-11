// pucthesis.typ — faithful Typst port of pucthesis.cls (2014/10/31 PUC thesis)
// Every metric cites its source in pucthesis.cls / amsbook.

// ===== Geometry (from pucthesis.cls) ========================================
#let text-w = 150.9mm            // \textwidth
#let text-h = 214.4mm            // \textheight
#let m-top = 40.4mm              // 1in + \topmargin(-25mm) + \headheight + \headsep
#let m-left = 40.4mm             // 1in + \oddsidemargin(15mm)

// ===== Calibration constants (measured from the LaTeX reference PDF) ========
#let bskip = 20.9pt              // measured \baselineskip (amsbook 12pt x 1.5)
#let par-leading = 13.0pt        // gives 20.9pt baseline pitch with Nimbus Roman
#let par-indent = 18pt           // \parindent (x-positions match ref exactly)
#let chap-top-pad = 1pt          // chapter head baseline at ref y=127.3pt
#let chap-below = 29pt           // chapter head -> first line pitch 36.9pt
#let schap-below = 49.8pt        // front-matter title -> content
// ponytail: LaTeX adds \parskip after schapter paragraphs (ACK/ABSTRACT start
// 10pt higher here than ref); TOC/LOF/LOT match exactly, which matters more
#let sec-above = 32.7pt          // text -> section head pitch 40.8pt
// ponytail: chapter->section collapses to max() in Typst, so that one gap runs
// ~4pt over the ref (LaTeX sums its skips); per-context spacing if it matters
#let sec-below = (30.1pt, 24.5pt, 23.2pt) // head -> text pitch 38.0/32.4/~31 (lvl 2/3/4+)
#let toc-line-gap = 12.9pt       // TOC line pitch 20.9pt; +8pt groups = 28.9pt
#let caption-leading = 6pt       // captions are single-spaced (pitch 13.9pt)
#let caption-max-w = text-w - 120pt // CALIBRATE: multi-line caption block width
#let pnum-w = 24pt               // \@pnumwidth column for TOC page numbers

// ===== States ================================================================
#let in-appendix = state("puc-in-appendix", false)
#let in-outline = state("puc-in-outline", false)

// LaTeX \caption[short]{long}: short form shows in LOF only
#let flex-caption(short, long) = context if in-outline.get() { short } else { long }

// chapter-or-appendix prefix ("3" or "A") resolved at a location
#let puc-prefix(loc) = {
  let ch = counter(heading).at(loc).first()
  if in-appendix.at(loc) { numbering("A", ch) } else { str(ch) }
}

// ===== Theorem environments (Thesis.tex \newtheorem{...}[chapter]) ==========
#let puc-thm-kinds = ("definition", "property", "claim", "lemma", "proposition",
                      "theorem", "corollary", "pf", "example", "remark")

#let puc-thm(kind, name) = body => {
  counter("puc-thm-" + kind).step()
  context {
    let n = counter("puc-thm-" + kind).get().first()
    // AMS plain theoremstyle: bold "Name C.N." head, italic body
    block(width: 100%)[#strong[#name #puc-prefix(here()).#n.]#h(0.5em)#emph(body)]
  }
}
#let definition = puc-thm("definition", "Definition")
#let property = puc-thm("property", "Property")
#let claim = puc-thm("claim", "Claim")
#let lemma = puc-thm("lemma", "Lemma")
#let proposition = puc-thm("proposition", "Proposition")
#let theorem = puc-thm("theorem", "Theorem")
#let corollary = puc-thm("corollary", "Corollary")
#let pf = puc-thm("pf", "Proof")
#let example = puc-thm("example", "Example")
#let remark = puc-thm("remark", "Remark")

// amsbook proof environment
#let proof(body) = block(width: 100%)[#emph[Proof.]#h(0.5em)#body#h(1fr)$square$]

// \scshape fallback: Nimbus Roman has no smcp feature, synthesize small caps
#let puc-sc(body) = {
  show regex("[a-záéíóúñü]+"): m => text(size: 0.75em, upper(m.text))
  body
}

// \verbinput{file} — verbatim listing (path relative to template root)
#let verbinput(path) = raw(read(path))

// \numberwithin{figure/table/equation}{chapter} — reset at each chapter
#let puc-reset-counters() = {
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(math.equation).update(0)
  for k in puc-thm-kinds { counter("puc-thm-" + k).update(0) }
}

// ===== Front matter generators ==============================================
#let toc(spanish: false) = {
  heading(level: 1, numbering: none, outlined: false, bookmarked: true,
    if spanish [ÍNDICE DE CONTENIDOS] else [TABLE OF CONTENTS])
  in-outline.update(true)
  outline(title: none, depth: 3)          // \c@tocdepth=2 → subsections included
  in-outline.update(false)
}

#let lof(spanish: false) = {
  heading(level: 1, numbering: none,
    if spanish [ÍNDICE DE FIGURAS] else [LIST OF FIGURES])
  in-outline.update(true)
  outline(title: none, target: figure.where(kind: image))
  in-outline.update(false)
}

#let lot(spanish: false) = {
  heading(level: 1, numbering: none,
    if spanish [ÍNDICE DE TABLAS] else [LIST OF TABLES])
  in-outline.update(true)
  outline(title: none, target: figure.where(kind: table))
  in-outline.update(false)
}

// ===== \appendix =============================================================
#let appendix(spanish: false, body) = {
  let name = if spanish { "ANEXO" } else { "APPENDIX" }
  in-appendix.update(true)
  counter(heading).update(0)
  set heading(numbering: "A.1.")
  {
    // Separator page: cls \appendix prints the word 8cm down, 5.7cm right,
    // on its own page; TOC gets a plain "APPENDIX" line.
    show heading.where(level: 1): it => {
      pagebreak(weak: true)
      v(8cm + 23.9pt)   // \vspace{8cm}; +offset measured against reference
      h(5.7cm)
      strong(upper(name))
    }
    heading(level: 1, numbering: none, outlined: true)[#name]
  }
  body
}

// ===== The class =============================================================
#let pucthesis(
  mdate: none, version: "0",
  title: "", author: "",
  address: none, email: none,
  university: "PONTIFICIA UNIVERSIDAD CATÓLICA DE CHILE",
  school: "ESCUELA DE INGENIERÍA",
  faculty-to: none, department: none, faculty: none,
  degree: none, subject: none,
  advisor: none,
  committee-member-a: none, committee-member-b: none,
  guest-member-a: none, guest-member-b: none, ogrs-member: none,
  date: none, copyright-name: none, copyright-year: none,
  dedication: none,
  spanish: false,
  logo-path: "figures/LogoUC.pdf",
  beftitle: 105pt, afttitle: 65pt,     // \beftitle / \afttitle
  body,
) = {
  set document(title: title, author: author)

  set page(
    paper: "us-letter",
    margin: (top: m-top, left: m-left,
             right: 215.9mm - m-left - text-w,
             bottom: 279.4mm - m-top - text-h),
    numbering: "i",                     // roman front matter; doc flips to "1"
    footer: align(center, text(size: 11pt, context counter(page).display())),
  )
  set text(font: ("Nimbus Roman", "Liberation Serif"),
           size: 12pt, lang: if spanish { "es" } else { "en" })
  set par(leading: par-leading, spacing: par-leading + 10pt, // \parskip 10pt
          first-line-indent: (amount: par-indent, all: true), justify: true)
  set heading(numbering: "1.1.")        // displays "1.", "2.1.", "2.1.1."
  set enum(numbering: "(i)")            // \labelenumi = (\roman{enumi})

  // ----- figures / tables / equations: numbered per chapter -----------------
  set figure(numbering: n => context { puc-prefix(here()) + "." + str(n) })
  set figure(gap: 0.7 * bskip)          // \abovecaptionskip / \belowcaptionskip
  // \textfloatsep 0.9\baselineskip; LaTeX adds \parskip around floats
  show figure: set block(above: 0.9 * bskip + 10pt, below: 0.9 * bskip + 10pt)
  show figure.where(kind: table): set figure.caption(position: top)
  set figure.caption(separator: [.#h(0.5em)])  // AMS: "Figure 3.1.␣␣caption"

  // \floatstyle{boxed}\restylefloat{figure}: frame the body, caption outside
  show figure.where(kind: image): it => {
    show image: im => rect(width: 100%, stroke: 0.4pt, inset: 3pt,
                           align(center, im))
    it
  }

  // AMS caption: single line centered, multi-line justified block; captions
  // are single-spaced in the reference (13.9pt pitch), not 1.5-spaced
  show figure.caption: it => context {
    set par(first-line-indent: 0pt, leading: caption-leading)
    let probe = [#it.supplement #it.counter.display(it.numbering)#it.separator#it.body]
    if measure(probe).width <= caption-max-w { align(center, probe) }
    else {
      align(center, box(width: caption-max-w,
        align(left, par(justify: true, probe))))
    }
  }

  // reference list: no \parskip between entries (matches apacite output)
  show bibliography: set par(spacing: par-leading)

  set math.equation(supplement: none,
    numbering: n => context { "(" + puc-prefix(here()) + "." + str(n) + ")" })

  // ----- \ref semantics ------------------------------------------------------
  show ref: it => {
    let el = it.element
    if el == none { it }                     // citations pass through
    else if el.func() == figure {
      context {
        let loc = el.location()
        let num = puc-prefix(loc) + "." + str(el.counter.at(loc).first())
        link(loc)[#el.supplement #num]       // "Figure 3.1" / "Table 3.1"
      }
    } else if el.func() == math.equation {
      context {
        let loc = el.location()
        link(loc, "(" + puc-prefix(loc) + "." +
                  str(counter(math.equation).at(loc).first()) + ")")
      }
    } else if el.func() == heading {
      context {
        let loc = el.location()
        let pat = if in-appendix.at(loc) { "A.1" } else { "1.1" }
        link(loc, numbering(pat, ..counter(heading).at(loc)))  // bare "2", like \ref
      }
    } else { it }
  }

  // ----- headings ------------------------------------------------------------
  show heading: it => {
    set text(size: 12pt, weight: "bold")
    set par(first-line-indent: 0pt, justify: false)
    if it.level == 1 {
      pagebreak(weak: true)                  // \chapter → \cleardoublepage (oneside)
      if it.numbering != none {
        puc-reset-counters()
        v(chap-top-pad)                      // \topskip 11mm
        block(width: 100%, below: chap-below, context {
          let pfx = counter(heading).display(it.numbering)
          grid(columns: (auto, 1fr), column-gutter: 0.5em, pfx, upper(it.body))
        })
      } else {
        // \@makeschapterhead: centered bold uppercase (TOC/LOF/LOT/ABSTRACT/…)
        block(width: 100%, above: 0pt, below: schap-below,
          align(center, upper(it.body)))
      }
    } else {
      // \@startsection: afterskip ratios .5 / .1 / .01 \linespacing (+\parskip)
      let below = sec-below.at(calc.min(it.level, 4) - 2)
      block(width: 100%, above: sec-above, below: below, context {
        let up = it.level == 2 and in-appendix.get()  // appendix sections uppercase
        let title = if up { upper(it.body) } else { it.body }
        if it.numbering != none {
          let pfx = counter(heading).display(it.numbering)
          grid(columns: (auto, 1fr), column-gutter: 0.5em, pfx, title)
        } else { title }
      })
    }
  }

  // ----- TOC / LOF / LOT lines (cls \@tocline table) --------------------------
  show outline.entry: it => context {
    let el = it.element
    let loc = el.location()
    set par(first-line-indent: 0pt, justify: false)
    // \@dotsep leaders: ref pitch 9.2pt, lead-in gap ~11pt before first dot
    let dots = box(width: 1fr, inset: (left: 8pt, right: 2pt),
                   repeat([.], gap: 5.9pt))
    let entry = if el.func() == figure {
      // \l@figure: hang 30pt, leaders, 8pt above
      let num = puc-prefix(loc) + "." + str(el.counter.at(loc).first())
      (indent: 0pt, hang: 30pt, prefix: num, body: el.caption.body,
       fill: dots, above: 8pt + toc-line-gap)
    } else {
      // appendix "chapters" are LaTeX sections → style one level deeper
      // (the unnumbered APPENDIX separator keeps its chapter-level line)
      let lvl = if in-appendix.at(loc) and el.numbering != none {
        it.level + 1
      } else { it.level }
      let pat = if in-appendix.at(loc) { "A.1.1." } else { "1.1.1." }
      let pfx = if el.numbering == none { none }
                else { numbering(pat, ..counter(heading).at(loc)) }
      // (leftskip, hang): \l@chapter 0/22pt, \l@section 1pc/2.5pc, \l@subsection 2pc/3.5pc
      let cfg = ((0pt, 22pt), (12pt, 30pt), (24pt, 42pt)).at(lvl - 1)
      (indent: cfg.at(0), hang: cfg.at(1), prefix: pfx,
       body: if lvl == 1 { upper(el.body) } else { el.body },
       fill: if lvl == 1 { h(1fr) } else { dots },       // chapters: no leaders
       above: if lvl == 1 { 8pt + toc-line-gap } else { toc-line-gap })
    }
    block(above: entry.above, link(loc, {
      set par(hanging-indent: entry.indent + entry.hang)
      h(entry.indent)
      if entry.prefix != none { box(width: entry.hang, entry.prefix) }
      entry.body
      entry.fill
      box(width: pnum-w, align(right, it.page()))
    }))
  }

  // ===== Title pages (cls \@maketitle) =======================================
  // \hspace{100pt}\parbox{w}: grid overflows the line like LaTeX's overfull
  // hbox instead of wrapping (100pt + w can exceed \textwidth by design)
  let frame-box(w, body) = grid(columns: (100pt, w), [], body)
  let dots-if-none(v) = if v == none { "........." } else { upper(v) }
  let degree-text = if spanish [
    Tesis para optar al grado de \
    #if degree != none { degree } else { "........." }
  ] else [
    Thesis submitted to the Office of Research and Graduate Studies \
    in partial fulfillment of the requirements for the degree of \
    #if degree != none { degree } else { "........." }
  ]
  let bottom-lines = {
    frame-box(0.75 * text-w)[Santiago de Chile,
      #if date != none { date } else { "Month Year" }]
    v(5pt + 24.1pt)                          // \vskip5pt + date-row deficit
    frame-box(0.75 * text-w, text(size: 10pt)[#sym.copyright
      #copyright-year, #puc-sc(if copyright-name != none { copyright-name }
                               else { ".........." })])
  }
  let header-and-title = {
    set block(spacing: 0pt)                  // LaTeX \vskip semantics: only
                                             // explicit v() spaces the blocks
    // the +Npt terms below compensate LaTeX's \baselineskip-tall text rows
    // (Typst rows are glyph-tall); values measured against the reference PDF
    v(-20mm + 12pt + 30.3pt)                 // \vskip12pt \vspace*{-20mm}
    // vertical decorative line: .5pt x (\textheight+19mm) at 80pt
    place(top + left, dx: 80pt, dy: -21mm,
      line(angle: 90deg, length: text-h + 19mm, stroke: 0.5pt))
    // logo hangs beside the university block without inflating the row
    place(top + left, dx: -1mm, dy: -16.3mm, image(logo-path, width: 23mm))
    grid(columns: (80pt, 20pt, 0.75 * text-w),
      align: (center, center, left),
      [], [],
      [#university \ #school #if department != none [ \ #department ]])
    v(2mm + 25.2pt)                          // univ rows' height deficit
    // horizontal decorative line: 13mm into left margin, 15mm past text
    move(dx: -13mm, line(length: text-w + 28mm, stroke: 0.5pt))
    v(0.7pt)
    v(beftitle)                              // \beftitle 105pt
    frame-box(text-w - 120pt + 15mm, align(center,
      text(size: 17.28pt, weight: "bold", upper(title))))   // \bfseries\Large
    v(13.7pt)
    v(afttitle)                              // \afttitle 65pt
    frame-box(text-w - 120pt + 15mm, align(center,
      text(size: 14.4pt, weight: "bold", upper(author))))   // \bfseries\large
    v(13.7pt)
    v(15pt)
    v(21pt)                                  // \prepresentedto = 1.75pc
  }

  page(footer: none, {
    set par(first-line-indent: 0pt, justify: false)
    set block(spacing: 0pt)
    header-and-title
    frame-box(0.75 * text-w, degree-text)
    v(3.2pt)                                 // degree-row deficit
    v(10pt)
    v(21pt)
    frame-box(0.75 * text-w)[
      #if spanish [Profesor Supervisor:] else [Advisor:] \
      #dots-if-none(advisor)]
    v(5pt)
    v(1fr)
    bottom-lines
  })

  page(footer: none, {
    set par(first-line-indent: 0pt, justify: false)
    set block(spacing: 0pt)
    header-and-title
    frame-box(0.75 * text-w)[
      #if spanish [Miembros del Comité:] else [Members of the Committee:] \
      #dots-if-none(advisor) \
      #dots-if-none(committee-member-a) \
      #if committee-member-b != none [#upper(committee-member-b) \ ]
      #dots-if-none(guest-member-a) \
      #if guest-member-b != none [#upper(guest-member-b) \ ]
      #dots-if-none(ogrs-member)]
    v(5pt)
    v(21pt)
    frame-box(0.75 * text-w, degree-text)
    v(10pt)
    v(1fr)
    bottom-lines
  })

  if dedication != none {
    page(footer: none, {
      set par(first-line-indent: 0pt, justify: false)
      set block(spacing: 0pt)
      v(0.7 * text-h)                        // \vspace*{.7\textheight}
      h(0.6 * text-w)
      box(width: 0.4 * text-w, align(center, emph(dedication)))
    })
  }

  body
}
