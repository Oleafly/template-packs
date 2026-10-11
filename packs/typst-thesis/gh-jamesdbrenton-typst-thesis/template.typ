// ******************************************************************************
// template.typ
//
// Typst re-implementation of the "look and feel" of the `lualatex-thesis`
// LaTeX class (a modernised, LuaLaTeX-only fork of Krishna Kumar's
// PhDThesisPSnPDF, github.com/jamesdbrenton/lualatex-thesis). This port is
// kept deliberately in step with the LaTeX class's options and rationale --
// see README.md's "Design mapping" table for the full LaTeX -> Typst
// correspondence, and each block below for what changed and why.
//
// This file plays the role that lualatex-thesis.cls played in the LaTeX
// version: it owns all layout decisions (paper size, margins, fonts,
// headers/footers, heading styles, title-page geometry, TOC naming) so that
// thesis.typ can stay as clean as thesis.tex was.
// ******************************************************************************

// ------------------------------------------------------------------
// Font option -> (text font, math font, heading font) triples.
//
// Mirrors the LaTeX class's four real OpenType text+maths pairings plus its
// Latin-Modern-alike default -- see the LaTeX README's "font selection"
// section for why these four and not others (pagella/garamond considered
// and dropped for Cyrillic coverage / maturity reasons respectively; the
// same reasoning applies unchanged here, since it's about font maturity,
// not the typesetting engine).
//
// NONE of times/fourier/libertinus/cambridge ship with Typst -- you'll need
// the fonts installed system-wide, or drop the .otf/.ttf files into a
// `fonts/` folder next to thesis.typ and compile with
// `typst compile --font-path fonts thesis.typ`. See README.md's "Fonts"
// section for exactly which files each option needs.
//
// The default ("latin-modern") uses New Computer Modern + New Computer
// Modern Math, both bundled with Typst -- nothing to install, and a closer
// match to the LaTeX default (Latin Modern) than the previous default of
// Libertinus Serif body text paired with New Computer Modern Math, which
// wasn't a real pairing on either side of the fork.
// ------------------------------------------------------------------
#let font-table = (
  "latin-modern": (
    text: "New Computer Modern",
    math: "New Computer Modern Math",
    heading: none,
  ),
  "times": (
    text: "STIX Two Text",
    math: "STIX Two Math",
    heading: none,
  ),
  "fourier": (
    text: "Erewhon",
    math: "Erewhon Math",
    heading: none,
  ),
  "libertinus": (
    text: "Libertinus Serif",
    math: "Libertinus Math",
    heading: none,
  ),
  // Cambridge: Open Sans body/maths-adjacent sans, Fira Math for maths,
  // Feijoa (commercial, not bundled or on any free font repository --
  // license and install it yourself) reserved for headlines/titles/quotes
  // only, per cam.ac.uk/brand-resources/guidelines/typography -- see the
  // heading/quote show-rules further down for exactly where it's applied.
  // Also forces ragged-right, same as the LaTeX class's `cambridge` option.
  "cambridge": (
    text: "Open Sans",
    math: "Fira Math",
    heading: "Feijoa",
  ),
)

// ------------------------------------------------------------------
// Bibliography style option -> Typst `bibliography(style: ...)` value.
// Mirrors the LaTeX class's authoryear/numbered/nature/csl options -- all
// four are directly expressible as a CSL style name or path, since Typst's
// bibliography() already speaks native CSL rather than needing a separate
// citeproc-lua-style side backend the way biblatex+csl did in the LaTeX
// class. `csl-styles/nature.csl` (copied over from the LaTeX repo -- the
// same CSL project's official Nature style) is used for both `nature' and
// `csl' here, since Typst has no biblatex-nature equivalent to fall back to
// and the CSL file is the more robust route anyway (the LaTeX README notes
// biblatex-nature has sometimes fallen back to bracketed rather than
// superscript numbers).
// ------------------------------------------------------------------
#let bib-style-table = (
  "numbered": "ieee",
  "authoryear": "apa",
  "nature": "csl-styles/nature.csl",
  "csl": "csl-styles/nature.csl",
)

// ------------------------------------------------------------------
// State used to fake fancyhdr's \markboth / \markright running heads.
// Updated by the chapter/section heading show-rules below, and read
// back inside the page header via `context`.
// ------------------------------------------------------------------
#let chapter-mark = state("chapter-mark", none)
#let section-mark = state("section-mark", none)

// Small helper: true on odd (recto/right-hand) pages.
#let is-odd(loc) = calc.odd(loc.page())

// ------------------------------------------------------------------
// Header/footer builders for the three page styles the LaTeX class
// supports (default / PageStyleI / PageStyleII), each with a `twoside`
// and `oneside` branch matching the class's `\if@twoside` fancyhdr
// conditionals -- including the same reasoning for the oneside fallback:
// with no verso/recto distinction to hang an inner/outer arrangement off,
// oneside documents get one unmirrored header, rather than a formally
// "mirrored" header that never actually alternates.
//
// `page-style: "default"` here folds in this port's one deliberate,
// documented departure from the LaTeX original regardless of twoside/
// oneside: folio moves to a plain centred footer rather than sitting in
// the header's outer corner, and the running head sits in the outer
// corner rather than the inner (spine-side) edge. Both are defensible
// typographic conventions; PageStyleI reproduces the LaTeX original's
// combined name+folio-in-header, empty-footer layout exactly if you want
// that back instead. See README.md's "Page numbering" and "Running
// headers" sections for the full rationale.
// ------------------------------------------------------------------
#let make-header-footer(page-style, twoside) = {
  if page-style == "I" {
    // PageStyleI: running name + " | " + bold folio, combined in the
    // header; footer empty. Mirrored L/R under twoside; one-sided
    // arrangement under oneside.
    let content(loc) = {
      let mark = if twoside and not is-odd(loc) { chapter-mark.at(loc) } else { section-mark.at(loc) }
      [#mark #h(0.4em) | #h(0.4em) #strong(str(loc.page()))]
    }
    (
      header: context {
        if twoside and not is-odd(here()) {
          align(left)[#content(here())]
        } else {
          align(right)[#content(here())]
        }
      },
      footer: none,
    )
  } else if page-style == "II" {
    // PageStyleII: bold running name only in the header (chapter on
    // verso, section on recto under twoside; a single running mark under
    // oneside), plain centred folio in the footer.
    (
      header: context {
        if twoside and not is-odd(here()) {
          align(left)[#strong(chapter-mark.at(here()))]
        } else {
          align(right)[#strong(section-mark.at(here()))]
        }
      },
      footer: context { align(center)[#strong(str(here().page()))] },
    )
  } else {
    // default: running name in the header's outer corner (unmirrored
    // under oneside), plain centred folio in the footer.
    (
      header: context {
        if twoside and not is-odd(here()) {
          align(left)[#chapter-mark.at(here())]
        } else {
          align(right)[#section-mark.at(here())]
        }
      },
      footer: context { align(center)[#strong(str(here().page()))] },
    )
  }
}

// ------------------------------------------------------------------
// Title page -- a direct translation of \maketitle / computeTitlePageSpacing.
// Typst's `1fr` spacers do the "compute the remaining vertical space and
// distribute it" job that the LaTeX class had to do by hand with
// \newsavebox + \totalheightof. `heading-font` is threaded through so the
// `cambridge` font option's Feijoa-for-titles rule (see lualatex-thesis.cls's
// \computeTitlePageSpacing: `\ifTHESIS@cambridge\THESIS@headingfont\fi`)
// carries over here too.
// ------------------------------------------------------------------
#let title-page(
  title: [],
  subtitle: none,
  author: [],
  department: [],
  university: [],
  crest: none,
  college-shield: none,
  supervisor: none,
  supervisor-role: [Supervisor: ],
  advisor: none,
  advisor-role: [Advisor: ],
  degree-title: [],
  college: none,
  degree-date: datetime.today().display("[month repr:long] [year]"),
  submission-text: [This dissertation is submitted for the degree of],
  heading-font: none,
) = {
  set align(center)
  set page(numbering: none, header: none, footer: none)
  show: it => if heading-font != none { set text(font: heading-font); it } else { it }

  v(1fr)
  if college-shield != none [
    #college-shield
    #v(1fr)
  ]

  text(size: 25pt, weight: "bold")[#title]
  if subtitle != none {
    v(0.6em)
    text(size: 17pt)[#subtitle]
  }

  v(1fr)
  if college-shield == none and crest != none {
    crest
    v(1fr)
  } else if crest != none {
    crest
    v(0.6em)
  }

  text(size: 17pt, weight: "bold")[#author]
  v(0.8em)

  if supervisor != none {
    text(size: 17pt)[#supervisor-role #supervisor]
    v(0.6em)
  }
  if advisor != none {
    text(size: 17pt)[#advisor-role #advisor]
    v(0.6em)
  }

  v(1fr)
  text(size: 14pt)[#department \ #university]
  v(1fr)

  text(size: 14pt)[
    #submission-text \
    #emph[#degree-title]
  ]

  v(1fr)
  if college != none {
    grid(
      columns: (1fr, 1fr),
      align(left)[#text(size: 14pt)[#college]],
      align(right)[#text(size: 14pt)[#degree-date]],
    )
  } else {
    align(center)[#text(size: 14pt)[#degree-date]]
  }
  v(2em)
}

// ------------------------------------------------------------------
// Generic centred "label" front-matter pages: Declaration, Acknowledgements,
// plain (non-separate) Abstract. Mirrors the class's \chapter*{\centering
// \Large ...} pattern.
// ------------------------------------------------------------------
#let label-page(title, body) = {
  pagebreak(to: "odd", weak: true)
  align(center)[#text(size: 17pt, weight: "bold")[#title]]
  v(1.5em)
  body
}

#let dedication-page(body) = {
  pagebreak(to: "odd", weak: true)
  set align(center + horizon)
  emph(body)
}

// ------------------------------------------------------------------
// Main entry point -- call this once at the top of thesis.typ, in the same
// spirit as \documentclass[...]{lualatex-thesis}.
//
// New parameters (all mirror a lualatex-thesis.cls class option):
//   font:      "latin-modern" (default) | "times" | "fourier" |
//              "libertinus" | "cambridge"
//   mode:      "online" (default) | "print" | "screen"
//   twoside:   bool, default true. `mode: "screen"` forces this to false,
//              same as the LaTeX class's `screen` option forcing `oneside`
//              at the class level -- recto/verso asymmetry and mirrored
//              running heads are a print-binding convention with nothing
//              to do on screen.
//   page-style: "default" (this port's own folio-in-footer convention,
//              documented above) | "I" | "II" (closer replicas of the
//              LaTeX class's PageStyleI/PageStyleII)
//   bib-style: "numbered" (default) | "authoryear" | "nature" | "csl", or
//              any raw CSL style name/path Typst's bibliography() accepts
//              directly (the `custombib` equivalent)
// ------------------------------------------------------------------
#let thesis(
  title: [],
  author: [],
  keywords: (),
  paper: "a4",
  font: "latin-modern",
  mode: "online",
  twoside: true,
  page-style: "default",
  doc,
) = {
  set document(title: title, author: author, keywords: keywords)

  // `screen` forces oneside, exactly as `\PassOptionsToClass{oneside}{book}`
  // does in the LaTeX class's `screen` option -- see the class comment
  // there for the full rationale (no on-screen equivalent to recto/verso
  // margin asymmetry or forced blank filler pages).
  let effective-twoside = if mode == "screen" { false } else { twoside }

  // ---- Fonts ----
  let fonts = font-table.at(font, default: font-table.at("latin-modern"))
  // Base size 12pt, matching the LaTeX repo's demo thesis.tex (which
  // passes `12pt` as a class option) -- most university guidelines
  // recommend a 12pt minimum body size anyway (the LaTeX class emits a
  // ClassWarning if you pick 10pt).
  set text(
    size: 12pt,
    lang: "en",
    font: fonts.text,
    // Lining figures throughout, regardless of font choice -- mirrors the
    // LaTeX class's `Numbers={Lining,Proportional}` on every \setmainfont
    // call. Typst fonts vary in default numeral style just like their
    // OpenType counterparts on the LaTeX side (New Computer Modern and
    // Libertinus default to old-style; STIX Two/Erewhon/Open Sans default
    // to lining), so this is pinned down explicitly for consistency
    // across every font option, the same reasoning as the LaTeX class.
    number-type: "lining",
    number-width: "proportional",
  )
  show math.equation: set text(font: fonts.math)

  // Tabular (fixed-width) figures inside tables only, so number columns
  // align on their digits -- mirrors the LaTeX class's \AddToHook calls
  // for tabular/longtable/tabularx. Applies to every `table` element
  // (including ones inside `figure`), without touching digit style
  // anywhere else in the document.
  show table: set text(number-width: "tabular")

  // ---- Cambridge: Feijoa reserved for headlines/titles/quotes, forced
  // ragged-right (see cam.ac.uk/brand-resources/guidelines/typography,
  // quoted in full in the LaTeX class and README) ----
  let justify-body = font != "cambridge"

  // ---- Page geometry ----
  // `print`/`online` share the same scale=0.75-equivalent margins as
  // before; `print` additionally reserves a 5mm binding offset on the
  // inside edge, matching the LaTeX class's `bindingoffset=5mm` under
  // `print` (absent under the plain online default). `screen` uses a
  // plain, symmetric 25mm margin with no binding reservation at all --
  // there's no physical binding to account for -- matching the LaTeX
  // class's `screen` geometry line exactly.
  let margins = if mode == "screen" {
    (x: 25mm, y: 25mm)
  } else if mode == "print" {
    (inside: 3.1cm + 5mm, outside: 2.6cm, top: 3.7cm, bottom: 3.7cm)
  } else {
    (inside: 3.1cm, outside: 2.6cm, top: 3.7cm, bottom: 3.7cm)
  }

  // ---- Hyperlink colouring ----
  // `print`: black links (matches linkcolor=urlcolor=citecolor=
  // anchorcolor=black under the LaTeX class's `print` option -- a bound
  // physical copy has no coloured links to speak of anyway).
  // `online`/`screen`: blue links (matches the LaTeX class's blue/green
  // scheme; Typst has no separate "anchor colour" concept for internal
  // targets, so this port uses one link colour for all link kinds rather
  // than trying to fake that distinction). Covers all three of Typst's
  // link-like elements: `link` (explicit #link(...) calls, e.g. URLs),
  // `ref` (cross-references to labelled headings/figures/equations), and
  // `cite` (bibliography citations) -- `show link: ...` alone only
  // catches the first of these, which under `screen` mode left citations
  // and cross-references black even though the mode is specifically
  // meant for interactive on-screen review.
  let link-color = if mode == "print" { black } else { blue }
  show link: set text(fill: link-color)
  show ref: set text(fill: link-color)
  show cite: set text(fill: link-color)

  // ---- Page geometry / header-footer wiring ----
  let hf = make-header-footer(page-style, effective-twoside)
  set page(
    paper: paper,
    margin: margins,
    binding: left,
    numbering: "1",
    header: hf.header,
    footer: hf.footer,
  )

  // ---- Suppress header/footer on the blank filler page that
  // pagebreak(to: "odd"/"even") sometimes has to insert to reach the
  // right parity (mirrors \thispagestyle{empty} on cleardoublepage's
  // filler page in the LaTeX class). Typst doesn't do this automatically
  // -- this is the community workaround for that gap (see
  // github.com/typst/typst/issues/2722). Caveat: doesn't cover the case
  // of several consecutive bare pagebreak() calls, only pagebreak(to: ..).
  // Under `mode: "screen"` (forced oneside) this rule is inert, same as
  // \cleardoublepage collapsing to \clearpage under oneside in the LaTeX
  // class -- there's no odd/even parity to chase, so no filler pages are
  // ever inserted.
  show selector.or(
    pagebreak.where(to: "odd"),
    pagebreak.where(to: "even"),
  ): set page(header: none, footer: none)

  // ---- Paragraph / line spacing: baselinestretch 1.2, justified unless
  // `cambridge` forces ragged-right, ragged bottom (Typst doesn't stretch
  // pages to fill by default, so no extra setting is needed for that
  // part) ----
  set par(
    justify: justify-body,
    leading: 0.85em,
    first-line-indent: 0pt,
    spacing: 1.1em,
  )

  // ---- Heading numbering depth: secnumdepth=2 / tocdepth=2 ----
  set heading(numbering: (..nums) => {
    let vals = nums.pos()
    if vals.len() <= 3 { numbering("1.1", ..vals) } else { none }
  })

  // Chapter (level 1): plain book-class style -- "Chapter N" then the
  // title in large bold, generous white space, no rules or colour.
  // Under `cambridge`, both the "Chapter N" label and the title itself
  // switch to Feijoa Bold -- mirroring sectsty's \chapterfont hook in the
  // LaTeX class, which is deliberately scoped to \chapter only (section/
  // subsection/etc. are left at the book class's already-bold default,
  // which under `cambridge`'s Open Sans body already renders as Open Sans
  // Bold -- exactly the brand guidelines' "subheadings" treatment, with
  // no override needed here either).
  show heading.where(level: 1): it => {
    chapter-mark.update(it.body)
    section-mark.update(it.body)
    pagebreak(to: "odd", weak: true)
    v(3.5em)
    show: body => if fonts.heading != none {
      set text(font: fonts.heading, weight: "bold")
      body
    } else {
      body
    }
    if it.numbering != none {
      // "Chapter N" and the title itself are the same size here,
      // matching book class's \@makechapterhead: \huge for the "Chapter
      // N" label and \Huge for the title -- which are literally the same
      // point size (~25pt) at the 12pt document class option this port
      // defaults to. Distinguished by the vertical gap between them, not
      // by size.
      text(size: 25pt)[Chapter #counter(heading).display()]
      v(0.6em)
    }
    text(size: 25pt, weight: "bold")[#it.body]
    v(1.8em)
  }

  // Section (level 2)
  show heading.where(level: 2): it => {
    section-mark.update([#counter(heading).display() #h(0.4em) #it.body])
    v(1.4em)
    text(size: 17pt, weight: "bold")[#counter(heading).display() #h(0.6em) #it.body]
    v(0.8em)
  }

  // Subsection (level 3)
  show heading.where(level: 3): it => {
    v(1.1em)
    text(size: 14pt, weight: "bold", style: "italic")[
      #counter(heading).display() #h(0.6em) #it.body
    ]
    v(0.6em)
  }

  // ---- Block quotes: Feijoa Medium Italic under `cambridge`, matching
  // the "Feijoa Medium Italic" specimen on cam.ac.uk's typography page
  // (see lualatex-thesis.cls's quote/quotation \renewenvironment) ----
  show quote.where(block: true): it => {
    if fonts.heading != none {
      set text(font: fonts.heading, style: "italic")
      it
    } else {
      it
    }
  }

  // ---- Captions: "Fig." supplement, labelsep=space; table captions
  // above the float, figure captions below (caption package settings) ----
  show figure.where(kind: image): set figure(supplement: [Fig.])
  // Table captions above the float, figure captions below (caption.sty's
  // tableposition=top). Comment out the `set figure.caption(position: top)`
  // line below if your Typst version doesn't yet support caption placement.
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: it => text(size: 10pt)[#it]

  // ---- Widow/orphan avoidance (clubpenalty/widowpenalty=10000 equivalent) ----
  set par(linebreaks: "optimized")

  doc
}

// ------------------------------------------------------------------
// Front-matter helper. Continuous arabic numbering means there's no
// page-numbering change here any more (see README) -- this is kept as a
// named wrapper purely so thesis.typ still reads the same way
// \frontmatter did, and as a hook if you want to reintroduce roman
// numerals later.
// ------------------------------------------------------------------
#let frontmatter(doc) = doc

// ------------------------------------------------------------------
// Main-matter helper: restarts chapter numbering at 1, but -- unlike the
// LaTeX class -- does NOT reset the page counter, since page numbers now
// run continuously front-to-back.
// ------------------------------------------------------------------
#let mainmatter(doc) = {
  counter(heading).update(0)
  doc
}

// ------------------------------------------------------------------
// Appendix helper: switches chapter numbering to A, B, C, ... and resets
// the chapter counter, mirroring the `appendix` package's
// \begin{appendices} ... \end{appendices}.
// ------------------------------------------------------------------
#let appendices(doc) = {
  counter(heading).update(0)
  set heading(numbering: (..nums) => {
    let vals = nums.pos()
    if vals.len() <= 3 { numbering("A.1", ..vals) } else { none }
  })
  show heading.where(level: 1): it => {
    chapter-mark.update(it.body)
    section-mark.update(it.body)
    pagebreak(to: "odd", weak: true)
    v(3.5em)
    text(size: 25pt)[Appendix #counter(heading).display("A")]
    v(0.6em)
    text(size: 25pt, weight: "bold")[#it.body]
    v(1.8em)
  }
  doc
}

// ------------------------------------------------------------------
// Table of contents / list of figures / list of tables, renamed to match
// the class's \renewcommand{\contentsname}{Table of contents} etc.
// ------------------------------------------------------------------
#let thesis-outline() = {
  heading(numbering: none, outlined: false)[Table of contents]
  // tocdepth=2 in the LaTeX class numbers/lists chapter+section+subsection,
  // which are Typst heading levels 1-3.
  outline(title: none, depth: 3)

  heading(numbering: none, outlined: false)[List of figures]
  outline(title: none, target: figure.where(kind: image))

  heading(numbering: none, outlined: false)[List of tables]
  outline(title: none, target: figure.where(kind: table))
}

// ------------------------------------------------------------------
// Resolve a lualatex-thesis-style `bib-style` option ("numbered" /
// "authoryear" / "nature" / "csl", or a raw CSL style name/path already
// in the format bibliography() expects -- the `custombib` equivalent)
// to the string Typst's bibliography(style: ...) wants.
// ------------------------------------------------------------------
#let resolve-bib-style(bib-style) = bib-style-table.at(bib-style, default: bib-style)
