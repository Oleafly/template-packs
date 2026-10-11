// =============================================================================
// ElegantPaper-Typst
// 优雅的 Typst 工作论文模板 | An Elegant Typst Template for Working Papers
// https://github.com/Iorest/ElegantPaper-Typst
// Style inspired by ElegantPaper (LaTeX): https://github.com/ElegantLaTeX/ElegantPaper
// =============================================================================

// ---------------------------------------------------------------------------
// Main template function
// ---------------------------------------------------------------------------

#let elegantpaper(
  // Paper info
  title:     none,
  authors:   (),    // array of (name, institute) dicts, or plain strings
  date:      none,
  version:   none,
  // Abstract
  abstract:  none,
  keywords:  none,
  // Language
  lang:      "en",
  // Content
  body,
) = {

  // Language strings
  let strings = if lang == "cn" {(
    abstract:     "摘　要",
    keywords:     "关键词：",
    bibliography: "参考文献",
    contents:     "目录",
    figure:       "图",
    table:        "表",
    theorem:      "定理",
    lemma:        "引理",
    proposition:  "命题",
    corollary:    "推论",
    definition:   "定义",
    conjecture:   "猜想",
    example:      "例",
    remark:       "评论",
    note:         "注",
    proof:        "证明",
    version-label:"版本：",
    date-label:   "日期：",
    appendix:     "附录",
  )} else {(
    abstract:     "Abstract",
    keywords:     "Keywords: ",
    bibliography: "Bibliography",
    contents:     "Contents",
    figure:       "Figure",
    table:        "Table",
    theorem:      "Theorem",
    lemma:        "Lemma",
    proposition:  "Proposition",
    corollary:    "Corollary",
    definition:   "Definition",
    conjecture:   "Conjecture",
    example:      "Example",
    remark:       "Remark",
    note:         "Note",
    proof:        "Proof",
    version-label:"Version: ",
    date-label:   "Date: ",
    appendix:     "Appendix",
  )}

  // ---- Document settings ----
  set document(
    title: if title != none { title } else { "ElegantPaper" },
  )

  set page(
    paper: "a4",
    margin: (top: 1in, bottom: 1in, left: 1in, right: 1in),
    numbering: "1",
    number-align: center,
    header: none,
  )

  set text(
    font: ("Libertinus Serif", "Songti SC"),
    size: 11pt,
    lang: lang,
  )

  // linespread 1.35 in LaTeX ≈ leading 0.9em at 11pt (1.35 × baseline)
  set par(
    justify: true,
    leading: 0.9em,
    first-line-indent: 2em,
    spacing: 1em,
  )

  // Math display spacing: abovedisplayskip / belowdisplayskip = 3pt
  set math.equation(numbering: none)
  show math.equation.where(block: true): it => {
    v(3pt, weak: true)
    it
    v(3pt, weak: true)
  }

  // Heading styles
  set heading(numbering: "1.1")

  // winered color (matching LaTeX version)
  let winered = rgb(128, 0, 0)

  show heading.where(level: 1): it => {
    v(1.2em)
    block({
      set text(size: 14pt, weight: "bold")
      if it.numbering != none {
        counter(heading).display("1") + "　" + it.body
      } else {
        it.body
      }
    })
    v(0.5em)
  }

  show heading.where(level: 2): it => {
    v(0.8em)
    block({
      set text(size: 12pt, weight: "bold")
      if it.numbering != none {
        counter(heading).display("1.1") + "　" + it.body
      } else {
        it.body
      }
    })
    v(0.3em)
  }

  show heading.where(level: 3): it => {
    v(0.5em)
    block({
      set text(size: 11pt, weight: "bold")
      if it.numbering != none {
        counter(heading).display("1.1.1") + "　" + it.body
      } else {
        it.body
      }
    })
    v(0.2em)
  }

  // Figure and table captions: labelfont=bf, skip=3pt
  set figure(gap: 3pt)
  show figure.caption: it => {
    set text(size: 10pt)
    strong(it.supplement + " " + it.counter.display(it.numbering) + it.separator)
    it.body
  }

  // Links — winered color
  show link: it => {
    set text(fill: winered)
    it
  }

  // Code blocks
  show raw.where(block: true): it => {
    set text(font: ("JetBrainsMono NF", "Sarasa Mono SC", "Menlo"), size: 9pt)
    block(
      fill: luma(242),
      stroke: none,
      radius: 2pt,
      inset: 8pt,
      width: 100%,
      it,
    )
  }

  show raw.where(block: false): it => {
    set text(font: ("JetBrainsMono NF", "Sarasa Mono SC", "Menlo"), size: 9.5pt)
    box(
      fill: luma(242),
      stroke: none,
      radius: 2pt,
      inset: (x: 3pt, y: 1pt),
      it,
    )
  }

  // ---- Title page ----
  if title != none {
    v(2em)
    align(center, {
      set par(first-line-indent: 0pt)
      // \LARGE in LaTeX article (11pt base) ≈ 17pt
      text(size: 17pt, weight: "bold", title)
      v(1.5em)
      // Authors
      if authors.len() > 0 {
        let author-cells = authors.map(a => {
          if type(a) == str {
            text(size: 12pt, a)
          } else {
            stack(
              text(size: 12pt, a.name),
              if "institute" in a {
                v(0.3em)
                text(size: 10pt, fill: luma(60), a.institute)
              }
            )
          }
        })
        grid(
          columns: author-cells.len(),
          gutter: 2em,
          ..author-cells
        )
        v(0.5em)
      }
      // Version and date
      set text(size: 10pt, style: "italic", fill: luma(60))
      if version != none {
        strings.version-label + version
        linebreak()
      }
      if date != none {
        strings.date-label + date
      }
    })
    v(1.5em)
  }

  // ---- Abstract ----
  if abstract != none {
    set par(first-line-indent: 0pt)
    block(
      width: 100%,
      inset: (x: 2em),
      {
        // Abstract title: \normalsize\bfseries; CN: 摘\hspace{2em}要
        let abs-title = if lang == "cn" { "摘　要" } else { "Abstract" }
        align(center, text(size: 11pt, weight: "bold", abs-title))
        v(0.5em)
        // Abstract body: \small (10pt); EN uses sffamily (sans-serif)
        set text(
          size: 10pt,
          font: if lang == "en" {
            ("Helvetica Neue", "Arial", "Songti SC")
          } else {
            ("Libertinus Serif", "Songti SC")
          }
        )
        set par(
          justify: true,
          first-line-indent: 0pt,
        )
        abstract
        if keywords != none {
          v(0.5em)
          text(weight: "bold", strings.keywords)
          keywords
        }
      }
    )
    v(1.5em)
  }

  // ---- Body ----
  body
}

// ---------------------------------------------------------------------------
// Theorem-like environments
// ---------------------------------------------------------------------------

// Counters (reset per section)
#let _thm-cnt  = counter("ep-theorem")
#let _def-cnt  = counter("ep-definition")
#let _con-cnt  = counter("ep-conjecture")
#let _exa-cnt  = counter("ep-example")

// Helper: section.counter display
#let _sec-num() = context {
  str(counter(heading.where(level: 1)).get().first())
}

/// Theorem environment
#let theorem(name: none, lang: "en", body) = {
  _thm-cnt.step()
  let label = if lang == "cn" { "定理" } else { "Theorem" }
  block(
    width: 100%,
    above: 8pt,
    below: 8pt,
    {
      context {
        let sec = counter(heading.where(level: 1)).get().first()
        let n   = _thm-cnt.get().first()
        let num-str = str(sec) + "." + str(n)
        if name != none {
          text(weight: "bold", style: "italic", label + " " + num-str + " (" + name + ")　")
        } else {
          text(weight: "bold", style: "italic", label + " " + num-str + "　")
        }
      }
      text(style: "italic", body)
    }
  )
}

/// Lemma environment
#let lemma(name: none, lang: "en", body) = {
  _thm-cnt.step()
  let label = if lang == "cn" { "引理" } else { "Lemma" }
  block(
    width: 100%,
    above: 8pt,
    below: 8pt,
    {
      context {
        let sec = counter(heading.where(level: 1)).get().first()
        let n   = _thm-cnt.get().first()
        let num-str = str(sec) + "." + str(n)
        if name != none {
          text(weight: "bold", style: "italic", label + " " + num-str + " (" + name + ")　")
        } else {
          text(weight: "bold", style: "italic", label + " " + num-str + "　")
        }
      }
      text(style: "italic", body)
    }
  )
}

/// Proposition environment
#let proposition(name: none, lang: "en", body) = {
  _thm-cnt.step()
  let label = if lang == "cn" { "命题" } else { "Proposition" }
  block(
    width: 100%,
    above: 8pt,
    below: 8pt,
    {
      context {
        let sec = counter(heading.where(level: 1)).get().first()
        let n   = _thm-cnt.get().first()
        let num-str = str(sec) + "." + str(n)
        if name != none {
          text(weight: "bold", style: "italic", label + " " + num-str + " (" + name + ")　")
        } else {
          text(weight: "bold", style: "italic", label + " " + num-str + "　")
        }
      }
      text(style: "italic", body)
    }
  )
}

/// Corollary environment (unnumbered)
#let corollary(name: none, lang: "en", body) = {
  let label = if lang == "cn" { "推论" } else { "Corollary" }
  block(
    width: 100%,
    above: 8pt,
    below: 8pt,
    {
      if name != none {
        text(weight: "bold", style: "italic", label + " (" + name + ")　")
      } else {
        text(weight: "bold", style: "italic", label + "　")
      }
      text(style: "italic", body)
    }
  )
}

/// Definition environment
#let definition(name: none, lang: "en", body) = {
  _def-cnt.step()
  let label = if lang == "cn" { "定义" } else { "Definition" }
  block(
    width: 100%,
    above: 8pt,
    below: 8pt,
    {
      context {
        let sec = counter(heading.where(level: 1)).get().first()
        let n   = _def-cnt.get().first()
        let num-str = str(sec) + "." + str(n)
        if name != none {
          text(weight: "bold", label + " " + num-str + " (" + name + ")　")
        } else {
          text(weight: "bold", label + " " + num-str + "　")
        }
      }
      body
    }
  )
}

/// Conjecture environment
#let conjecture(name: none, lang: "en", body) = {
  _con-cnt.step()
  let label = if lang == "cn" { "猜想" } else { "Conjecture" }
  block(
    width: 100%,
    above: 8pt,
    below: 8pt,
    {
      context {
        let sec = counter(heading.where(level: 1)).get().first()
        let n   = _con-cnt.get().first()
        let num-str = str(sec) + "." + str(n)
        if name != none {
          text(weight: "bold", label + " " + num-str + " (" + name + ")　")
        } else {
          text(weight: "bold", label + " " + num-str + "　")
        }
      }
      body
    }
  )
}

/// Example environment
#let example(name: none, lang: "en", body) = {
  _exa-cnt.step()
  let label = if lang == "cn" { "例" } else { "Example" }
  block(
    width: 100%,
    above: 8pt,
    below: 8pt,
    {
      context {
        let sec = counter(heading.where(level: 1)).get().first()
        let n   = _exa-cnt.get().first()
        let num-str = str(sec) + "." + str(n)
        if name != none {
          text(weight: "bold", label + " " + num-str + " (" + name + ")　")
        } else {
          text(weight: "bold", label + " " + num-str + "　")
        }
      }
      body
    }
  )
}

/// Remark environment (unnumbered)
#let remark(lang: "en", body) = {
  let label = if lang == "cn" { "评论" } else { "Remark" }
  block(
    width: 100%,
    above: 6pt,
    below: 6pt,
    {
      text(weight: "bold", label + "　")
      body
    }
  )
}

/// Note environment (unnumbered)
#let note(lang: "en", body) = {
  let label = if lang == "cn" { "注" } else { "Note" }
  block(
    width: 100%,
    above: 6pt,
    below: 6pt,
    {
      text(weight: "bold", label + "　")
      body
    }
  )
}

/// Proof environment (ends with □)
#let proof(lang: "en", body) = {
  let label = if lang == "cn" { "证明　" } else { "Proof　" }
  block(
    width: 100%,
    above: 6pt,
    below: 6pt,
    {
      text(weight: "bold", style: "italic", label)
      body
      h(1fr)
      $square$
    }
  )
}

// ---------------------------------------------------------------------------
// Utility commands
// ---------------------------------------------------------------------------

/// Email link
#let email(address) = link("mailto:" + address, address)

/// Figure reference
#let figref(label-key, lang: "en") = {
  let prefix = if lang == "cn" { "图 " } else { "Figure " }
  strong(prefix)
  ref(label-key)
}

/// Table reference
#let tabref(label-key, lang: "en") = {
  let prefix = if lang == "cn" { "表 " } else { "Table " }
  strong(prefix)
  ref(label-key)
}

// ---------------------------------------------------------------------------
// Appendix helper
// ---------------------------------------------------------------------------

/// Start appendix section (resets heading numbering to A, B, C...)
#let appendix(lang: "en", body) = {
  counter(heading).update(0)
  set heading(numbering: "A.1")
  body
}
