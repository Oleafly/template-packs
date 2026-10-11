// =============================================================================
// ElegantBook Typst Template
// ElegantBook (Typst) — 优雅的 Typst 书籍模板
// Style inspired by ElegantBook (LaTeX): https://github.com/ElegantLaTeX/ElegantBook
// =============================================================================

#import "@preview/showybox:2.0.4": showybox

// ---------------------------------------------------------------------------
// Color Themes
// ---------------------------------------------------------------------------

// Blue theme (default)
#let theme-blue = (
  structure: rgb(60, 113, 183),
  main:      rgb(0, 166, 82),
  second:    rgb(255, 134, 24),
  third:     rgb(0, 174, 247),
)

// Green theme
#let theme-green = (
  structure: rgb(0, 120, 2),
  main:      rgb(0, 120, 2),
  second:    rgb(230, 90, 7),
  third:     rgb(0, 160, 152),
)

// Cyan theme
#let theme-cyan = (
  structure: rgb(31, 186, 190),
  main:      rgb(59, 180, 5),
  second:    rgb(175, 153, 8),
  third:     rgb(244, 105, 102),
)

// Gray theme
#let theme-gray = (
  structure: rgb(150, 150, 150),
  main:      rgb(150, 150, 150),
  second:    rgb(150, 150, 150),
  third:     rgb(150, 150, 150),
)

// Black theme
#let theme-black = (
  structure: rgb(0, 0, 0),
  main:      rgb(0, 0, 0),
  second:    rgb(0, 0, 0),
  third:     rgb(0, 0, 0),
)

// ---------------------------------------------------------------------------
// Main template function
// ---------------------------------------------------------------------------

#let elegantbook(
  // Cover info
  title:     none,
  subtitle:  none,
  author:    none,
  institute: none,
  date:      none,
  version:   none,
  bioinfo:   none,   // (caption, content) array
  extrainfo: none,
  cover:     none,   // path to cover image
  logo:      none,   // path to logo image
  // Theme
  color:     "blue",
  // Language
  lang:      "en",
  // Content
  body,
) = {

  // Select color theme
  let theme = if color == "green"  { theme-green  }
         else if color == "cyan"   { theme-cyan   }
         else if color == "gray"   { theme-gray   }
         else if color == "black"  { theme-black  }
         else                      { theme-blue   }

  // Language strings
  let strings = if lang == "cn" {(
    contents:     "目录",
    figure:       "图",
    table:        "表",
    chapter:      "第",
    chapter-post: "章",
    appendix:     "附录",
    bibliography: "参考文献",
    proof:        "证明",
    note:         "笔记",
    definition:   "定义",
    theorem:      "定理",
    axiom:        "公理",
    postulate:    "公设",
    lemma:        "引理",
    proposition:  "命题",
    corollary:    "推论",
    example:      "例题",
    exercise:     "练习",
    problem:      "问题",
    remark:       "注",
    assumption:   "假设",
    conclusion:   "结论",
    solution:     "解",
    property:     "性质",
    introduction: "内容提要",
    author:       "作者：",
    institute:    "组织：",
    date-label:   "时间：",
    version-label:"版本：",
  )} else {(
    contents:     "Contents",
    figure:       "Figure",
    table:        "Table",
    chapter:      "Chapter",
    chapter-post: "",
    appendix:     "Appendix",
    bibliography: "Bibliography",
    proof:        "Proof",
    note:         "Note",
    definition:   "Definition",
    theorem:      "Theorem",
    axiom:        "Axiom",
    postulate:    "Postulate",
    lemma:        "Lemma",
    proposition:  "Proposition",
    corollary:    "Corollary",
    example:      "Example",
    exercise:     "Exercise",
    problem:      "Problem",
    remark:       "Remark",
    assumption:   "Assumption",
    conclusion:   "Conclusion",
    solution:     "Solution",
    property:     "Property",
    introduction: "Introduction",
    author:       "Author: ",
    institute:    "Institute: ",
    date-label:   "Date: ",
    version-label:"Version: ",
  )}

  // ---- Document settings ----
  set document(
    title: if title != none { title } else { "ElegantBook" },
    author: if author != none { author } else { "" },
  )

  set page(
    paper: "a4",
    margin: (top: 25.4mm, bottom: 25.4mm, left: 20mm, right: 20mm),
    header: context {
      let page-num = here().page()
      let chapters = query(selector(heading.where(level: 1)).before(here()))
      let sections = query(selector(heading.where(level: 2)).before(here()))
      let current-chapter = if chapters.len() > 0 { chapters.last() } else { none }
      let current-section = if sections.len() > 0 { sections.last() } else { none }
      let header-text = if current-section != none {
        current-section.body
      } else if current-chapter != none {
        current-chapter.body
      } else { [] }
      set text(fill: theme.structure, size: 9pt)
      grid(
        columns: (1fr,),
        align(right, header-text),
        line(length: 100%, stroke: 1pt + theme.structure),
      )
    },
    footer: context {
      set text(fill: theme.structure, size: 9pt)
      align(center, str(here().page()))
    },
    header-ascent: 4mm,
    footer-descent: 12mm,
  )

  set text(
    font: ("Libertinus Serif", "Songti SC"),
    size: 10pt,
    lang: lang,
  )

  set par(
    justify: true,
    leading: if lang == "cn" { 0.78em } else { 0.65em },
    first-line-indent: 2em,
  )

  // Heading styles
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1em)
    block(
      width: 100%,
      {
        set text(fill: theme.structure, size: 20pt, weight: "bold")
        if it.numbering != none {
          let num = counter(heading).display("1")
          if lang == "cn" {
            strings.chapter + " " + num + " " + strings.chapter-post + "　" + it.body
          } else {
            strings.chapter + " " + num + "　" + it.body
          }
        } else {
          it.body
        }
      }
    )
    v(1.3em)
  }

  show heading.where(level: 2): it => {
    v(0.5em)
    block({
      set text(fill: theme.structure, size: 17pt, weight: "bold")
      if it.numbering != none {
        counter(heading).display("1.1") + "　" + it.body
      } else {
        it.body
      }
    })
    v(0.2em)
  }

  show heading.where(level: 3): it => {
    v(0.3em)
    block({
      set text(fill: theme.structure, size: 14pt, weight: "bold")
      if it.numbering != none {
        counter(heading).display("1.1.1") + "　" + it.body
      } else {
        it.body
      }
    })
    v(0.1em)
  }

  // Figure and table captions
  set figure(gap: 0.5em)
  show figure.caption: it => {
    set text(size: 9pt)
    it
  }

  // Links
  show link: it => {
    set text(fill: rgb(128, 0, 0))
    it
  }

  // Code blocks
  show raw.where(block: true): it => {
    set text(font: ("JetBrainsMono NF", "Sarasa Mono SC", "Menlo"), size: 9pt)
    block(
      fill: luma(245),
      stroke: 0.5pt + luma(180),
      radius: 3pt,
      inset: 8pt,
      width: 100%,
      it,
    )
  }

  show raw.where(block: false): it => {
    set text(font: ("JetBrainsMono NF", "Sarasa Mono SC", "Menlo"), size: 9.5pt)
    box(
      fill: luma(245),
      stroke: 0.3pt + luma(200),
      radius: 2pt,
      inset: (x: 3pt, y: 1pt),
      it,
    )
  }

  // ---- Cover page ----
  if cover != none or title != none {
    set page(margin: 0pt, header: none, footer: none)
    // Cover image
    if cover != none {
      image(cover, width: 100%)
    }
    // Color bar (flush against cover image)
    v(-0.65em)
    block(
      width: 100%,
      height: 0.5in,
      fill: theme.second,
      above: 0pt,
      below: 0pt,
    )
    // Title + info block
    v(1fr)
    pad(left: 2em, right: 2em, {
      set par(first-line-indent: 0pt)
      if title != none {
        text(size: 25pt, weight: "bold", title)
        v(0.5em)
      }
      if subtitle != none {
        text(size: 18pt, fill: luma(80), weight: "bold", subtitle)
        v(1em)
      }
      // Author info
      set text(size: 11pt, fill: luma(60))
      if author != none {
        text(weight: "bold", strings.author) + author
        linebreak()
      }
      if institute != none {
        text(weight: "bold", strings.institute) + institute
        linebreak()
      }
      if date != none {
        text(weight: "bold", strings.date-label) + date
        linebreak()
      }
      if version != none {
        text(weight: "bold", strings.version-label) + version
        linebreak()
      }
      if bioinfo != none {
        text(weight: "bold", bioinfo.at(0) + ": ") + bioinfo.at(1)
        linebreak()
      }
    })
    v(1fr)
    // Extra info (centered)
    if extrainfo != none {
      pad(left: 2em, right: 2em,
        align(center, text(size: 9pt, style: "italic", extrainfo))
      )
    }
    v(1fr)
    // Logo — fixed at bottom-right of cover page
    if logo != none {
      place(bottom + right, dx: -0.8in, dy: -1.5in,
        image(logo, width: 4.2cm)
      )
    }
  }

  // ---- Table of contents ----
  // (called manually in document via #outline())

  // ---- Body ----
  counter(page).update(1)
  body
}

// ---------------------------------------------------------------------------
// Theorem-like environments (fancy style with colored boxes)
// ---------------------------------------------------------------------------

// Internal counter helpers
#let _thm-counter(name) = counter("elegant-" + name)

// Generic theorem box builder
#let _thm-box(
  name,
  label-prefix,
  title-name,
  frame-color,
  back-color,
  symbol,
  number-within: heading,
  body-content,
  thm-name: none,
) = {
  let cnt = _thm-counter(name)
  cnt.step()
  let num = context {
    let h = counter(heading).get()
    let n = cnt.get().first()
    str(h.first()) + "." + str(n)
  }
  showybox(
    frame: (
      border-color: frame-color,
      title-color: frame-color,
      body-color: back-color,
      radius: 3pt,
      thickness: 0.5pt,
    ),
    title: context {
      let h = counter(heading).get()
      let n = cnt.get().first()
      let num-str = str(h.first()) + "." + str(n)
      if thm-name != none and thm-name != "" and thm-name != [] {
        strong(title-name + " " + num-str) + " (" + thm-name + ")"
      } else {
        strong(title-name + " " + num-str)
      }
    },
    title-style: (color: white, weight: "bold"),
    body-style: (color: black),
    sep: (dash: "solid"),
    shadow: (offset: 2pt, color: frame-color.lighten(70%)),
    {
      set text(style: "italic")
      body-content
      h(1fr)
      text(fill: frame-color, symbol)
    }
  )
}

// ---- Theorem environments ----

// Counters (reset per chapter)
#let _def-cnt  = counter("elegant-definition")
#let _thm-cnt  = counter("elegant-theorem")
#let _lem-cnt  = counter("elegant-lemma")
#let _cor-cnt  = counter("elegant-corollary")
#let _axi-cnt  = counter("elegant-axiom")
#let _pos-cnt  = counter("elegant-postulate")
#let _pro-cnt  = counter("elegant-proposition")
#let _exa-cnt  = counter("elegant-example")
#let _exr-cnt  = counter("elegant-exercise")
#let _prb-cnt  = counter("elegant-problem")

// Reset all counters when a new chapter starts
#let _reset-thm-counters() = {
  _def-cnt.update(0)
  _thm-cnt.update(0)
  _lem-cnt.update(0)
  _cor-cnt.update(0)
  _axi-cnt.update(0)
  _pos-cnt.update(0)
  _pro-cnt.update(0)
  _exa-cnt.update(0)
  _exr-cnt.update(0)
  _prb-cnt.update(0)
}

// Helper: get chapter.counter display
#let _chap-num() = context {
  str(counter(heading.where(level: 1)).get().first())
}

// ---- Public environment functions ----

/// Definition environment (green/main color)
#let definition(name: none, theme: theme-blue, lang: "en", body) = {
  _def-cnt.step()
  let frame-color = theme.main
  let back-color  = theme.main.lighten(90%)
  let strings = if lang == "cn" {(definition: "定义")} else {(definition: "Definition")}
  showybox(
    frame: (
      border-color: frame-color,
      title-color:  frame-color,
      body-color:   back-color,
      radius: 3pt,
      thickness: 0.5pt,
    ),
    title: context {
      let ch = counter(heading.where(level: 1)).get().first()
      let n  = _def-cnt.get().first()
      let num-str = str(ch) + "." + str(n)
      if name != none and name != "" and name != [] {
        strong(strings.definition + " " + num-str + " (" + name + ")")
      } else {
        strong(strings.definition + " " + num-str)
      }
    },
    title-style: (color: white, weight: "bold"),
    body-style:  (color: black),
    shadow: (offset: 2pt, color: frame-color.lighten(70%)),
    {
      set text(style: "italic")
      body
      h(1fr)
      text(fill: frame-color, "♣")
    }
  )
}

/// Theorem environment (orange/second color)
#let theorem(name: none, theme: theme-blue, lang: "en", body) = {
  _thm-cnt.step()
  let frame-color = theme.second
  let back-color  = theme.second.lighten(90%)
  let strings = if lang == "cn" {(theorem: "定理")} else {(theorem: "Theorem")}
  showybox(
    frame: (
      border-color: frame-color,
      title-color:  frame-color,
      body-color:   back-color,
      radius: 3pt,
      thickness: 0.5pt,
    ),
    title: context {
      let ch = counter(heading.where(level: 1)).get().first()
      let n  = _thm-cnt.get().first()
      let num-str = str(ch) + "." + str(n)
      if name != none and name != "" and name != [] {
        strong(strings.theorem + " " + num-str + " (" + name + ")")
      } else {
        strong(strings.theorem + " " + num-str)
      }
    },
    title-style: (color: white, weight: "bold"),
    body-style:  (color: black),
    shadow: (offset: 2pt, color: frame-color.lighten(70%)),
    {
      set text(style: "italic")
      body
      h(1fr)
      text(fill: frame-color, "♥")
    }
  )
}

/// Lemma environment (orange/second color)
#let lemma(name: none, theme: theme-blue, lang: "en", body) = {
  _lem-cnt.step()
  let frame-color = theme.second
  let back-color  = theme.second.lighten(90%)
  let strings = if lang == "cn" {(lemma: "引理")} else {(lemma: "Lemma")}
  showybox(
    frame: (
      border-color: frame-color,
      title-color:  frame-color,
      body-color:   back-color,
      radius: 3pt,
      thickness: 0.5pt,
    ),
    title: context {
      let ch = counter(heading.where(level: 1)).get().first()
      let n  = _lem-cnt.get().first()
      let num-str = str(ch) + "." + str(n)
      if name != none and name != "" and name != [] {
        strong(strings.lemma + " " + num-str + " (" + name + ")")
      } else {
        strong(strings.lemma + " " + num-str)
      }
    },
    title-style: (color: white, weight: "bold"),
    body-style:  (color: black),
    shadow: (offset: 2pt, color: frame-color.lighten(70%)),
    {
      set text(style: "italic")
      body
      h(1fr)
      text(fill: frame-color, "♥")
    }
  )
}

/// Corollary environment (orange/second color)
#let corollary(name: none, theme: theme-blue, lang: "en", body) = {
  _cor-cnt.step()
  let frame-color = theme.second
  let back-color  = theme.second.lighten(90%)
  let strings = if lang == "cn" {(corollary: "推论")} else {(corollary: "Corollary")}
  showybox(
    frame: (
      border-color: frame-color,
      title-color:  frame-color,
      body-color:   back-color,
      radius: 3pt,
      thickness: 0.5pt,
    ),
    title: context {
      let ch = counter(heading.where(level: 1)).get().first()
      let n  = _cor-cnt.get().first()
      let num-str = str(ch) + "." + str(n)
      if name != none and name != "" and name != [] {
        strong(strings.corollary + " " + num-str + " (" + name + ")")
      } else {
        strong(strings.corollary + " " + num-str)
      }
    },
    title-style: (color: white, weight: "bold"),
    body-style:  (color: black),
    shadow: (offset: 2pt, color: frame-color.lighten(70%)),
    {
      set text(style: "italic")
      body
      h(1fr)
      text(fill: frame-color, "♥")
    }
  )
}

/// Axiom environment (orange/second color)
#let axiom(name: none, theme: theme-blue, lang: "en", body) = {
  _axi-cnt.step()
  let frame-color = theme.second
  let back-color  = theme.second.lighten(90%)
  let strings = if lang == "cn" {(axiom: "公理")} else {(axiom: "Axiom")}
  showybox(
    frame: (
      border-color: frame-color,
      title-color:  frame-color,
      body-color:   back-color,
      radius: 3pt,
      thickness: 0.5pt,
    ),
    title: context {
      let ch = counter(heading.where(level: 1)).get().first()
      let n  = _axi-cnt.get().first()
      let num-str = str(ch) + "." + str(n)
      if name != none and name != "" and name != [] {
        strong(strings.axiom + " " + num-str + " (" + name + ")")
      } else {
        strong(strings.axiom + " " + num-str)
      }
    },
    title-style: (color: white, weight: "bold"),
    body-style:  (color: black),
    shadow: (offset: 2pt, color: frame-color.lighten(70%)),
    {
      set text(style: "italic")
      body
      h(1fr)
      text(fill: frame-color, "♥")
    }
  )
}

/// Postulate environment (orange/second color)
#let postulate(name: none, theme: theme-blue, lang: "en", body) = {
  _pos-cnt.step()
  let frame-color = theme.second
  let back-color  = theme.second.lighten(90%)
  let strings = if lang == "cn" {(postulate: "公设")} else {(postulate: "Postulate")}
  showybox(
    frame: (
      border-color: frame-color,
      title-color:  frame-color,
      body-color:   back-color,
      radius: 3pt,
      thickness: 0.5pt,
    ),
    title: context {
      let ch = counter(heading.where(level: 1)).get().first()
      let n  = _pos-cnt.get().first()
      let num-str = str(ch) + "." + str(n)
      if name != none and name != "" and name != [] {
        strong(strings.postulate + " " + num-str + " (" + name + ")")
      } else {
        strong(strings.postulate + " " + num-str)
      }
    },
    title-style: (color: white, weight: "bold"),
    body-style:  (color: black),
    shadow: (offset: 2pt, color: frame-color.lighten(70%)),
    {
      set text(style: "italic")
      body
      h(1fr)
      text(fill: frame-color, "♥")
    }
  )
}

/// Proposition environment (blue/third color)
#let proposition(name: none, theme: theme-blue, lang: "en", body) = {
  _pro-cnt.step()
  let frame-color = theme.third
  let back-color  = theme.third.lighten(90%)
  let strings = if lang == "cn" {(proposition: "命题")} else {(proposition: "Proposition")}
  showybox(
    frame: (
      border-color: frame-color,
      title-color:  frame-color,
      body-color:   back-color,
      radius: 3pt,
      thickness: 0.5pt,
    ),
    title: context {
      let ch = counter(heading.where(level: 1)).get().first()
      let n  = _pro-cnt.get().first()
      let num-str = str(ch) + "." + str(n)
      if name != none and name != "" and name != [] {
        strong(strings.proposition + " " + num-str + " (" + name + ")")
      } else {
        strong(strings.proposition + " " + num-str)
      }
    },
    title-style: (color: white, weight: "bold"),
    body-style:  (color: black),
    shadow: (offset: 2pt, color: frame-color.lighten(70%)),
    {
      set text(style: "italic")
      body
      h(1fr)
      text(fill: frame-color, "♠")
    }
  )
}

// ---------------------------------------------------------------------------
// Example / Exercise / Problem environments
// ---------------------------------------------------------------------------

/// Example environment (numbered per chapter)
#let example(theme: theme-blue, lang: "en", body) = {
  _exa-cnt.step()
  let color = theme.main
  let label = if lang == "cn" { "例题" } else { "Example" }
  block(
    width: 100%,
    above: 8pt,
    below: 8pt,
    {
      context {
        let ch = counter(heading.where(level: 1)).get().first()
        let n  = _exa-cnt.get().first()
        text(fill: color, weight: "bold", label + " " + str(ch) + "." + str(n) + "　")
      }
      body
    }
  )
}

/// Exercise environment (numbered per chapter)
#let exercise(theme: theme-blue, lang: "en", body) = {
  _exr-cnt.step()
  let color = theme.main
  let label = if lang == "cn" { "✏ 练习" } else { "✏ Exercise" }
  block(
    width: 100%,
    above: 8pt,
    below: 8pt,
    {
      context {
        let ch = counter(heading.where(level: 1)).get().first()
        let n  = _exr-cnt.get().first()
        text(fill: color, weight: "bold", label + " " + str(ch) + "." + str(n) + "　")
      }
      body
    }
  )
}

/// Problem environment (numbered per chapter)
#let problem(theme: theme-blue, lang: "en", body) = {
  _prb-cnt.step()
  let color = theme.main
  let label = if lang == "cn" { "问题" } else { "Problem" }
  block(
    width: 100%,
    above: 8pt,
    below: 8pt,
    {
      context {
        let ch = counter(heading.where(level: 1)).get().first()
        let n  = _prb-cnt.get().first()
        text(fill: color, weight: "bold", label + " " + str(ch) + "." + str(n) + "　")
      }
      body
    }
  )
}

// ---------------------------------------------------------------------------
// Proof / Note / Solution / Remark / Assumption / Conclusion / Property
// ---------------------------------------------------------------------------

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

/// Note environment (starts with ⚠ symbol)
#let note(lang: "en", body) = {
  let label = if lang == "cn" { "笔记　" } else { "Note　" }
  block(
    width: 100%,
    above: 6pt,
    below: 6pt,
    {
      text(fill: rgb(200, 0, 0), "⚠ ")
      text(weight: "bold", fill: rgb(255, 134, 24), label)
      set text(style: "italic")
      body
    }
  )
}

/// Solution environment
#let solution(lang: "en", body) = {
  let label = if lang == "cn" { "解　" } else { "Solution　" }
  block(
    width: 100%,
    above: 6pt,
    below: 6pt,
    {
      text(weight: "bold", fill: rgb(0, 166, 82), label)
      set text(style: "italic")
      body
    }
  )
}

/// Remark environment
#let remark(lang: "en", body) = {
  let label = if lang == "cn" { "注　" } else { "Remark　" }
  block(
    width: 100%,
    above: 6pt,
    below: 6pt,
    {
      text(weight: "bold", fill: rgb(255, 134, 24), label)
      body
    }
  )
}

/// Assumption environment
#let assumption(lang: "en", body) = {
  let label = if lang == "cn" { "假设　" } else { "Assumption　" }
  block(
    width: 100%,
    above: 6pt,
    below: 6pt,
    {
      text(weight: "bold", fill: rgb(0, 174, 247), label)
      set text(style: "italic")
      body
    }
  )
}

/// Conclusion environment
#let conclusion(lang: "en", body) = {
  let label = if lang == "cn" { "结论　" } else { "Conclusion　" }
  block(
    width: 100%,
    above: 6pt,
    below: 6pt,
    {
      text(weight: "bold", fill: rgb(0, 174, 247), label)
      set text(style: "italic")
      body
    }
  )
}

/// Property environment
#let property(lang: "en", body) = {
  let label = if lang == "cn" { "性质　" } else { "Property　" }
  block(
    width: 100%,
    above: 6pt,
    below: 6pt,
    {
      text(weight: "bold", fill: rgb(0, 174, 247), label)
      set text(style: "italic")
      body
    }
  )
}

// ---------------------------------------------------------------------------
// Introduction environment (chapter overview box)
// ---------------------------------------------------------------------------

/// Introduction box at the start of a chapter
#let introduction(title: none, theme: theme-blue, lang: "en", items) = {
  let color = theme.structure
  let display-title = if title != none and title != "" and title != [] { title } else if lang == "cn" { "内容提要" } else { "Introduction" }
  block(
    width: 100%,
    above: 10pt,
    below: 10pt,
    stroke: (top: 0.5pt + color, bottom: 0.5pt + color),
    fill: color.lighten(90%),
    radius: 3pt,
    inset: 10pt,
    {
      block(
        fill: color,
        radius: (top: 3pt),
        inset: (x: 10pt, y: 5pt),
        width: 100%,
        text(fill: white, weight: "bold", display-title)
      )
      v(6pt)
      grid(
        columns: (1fr, 1fr),
        gutter: 4pt,
        ..items.map(item => {
          text(fill: color, "◼ ") + item
        })
      )
    }
  )
}

// ---------------------------------------------------------------------------
// Problem Set environment (chapter-end exercises)
// ---------------------------------------------------------------------------

/// Problem set at end of chapter
#let problemset(title: none, theme: theme-blue, lang: "en", items) = {
  let color = theme.structure
  let display-title = if title != none and title != "" and title != [] { title } else if lang == "cn" { "练习" } else { "Exercises" }
  v(10pt)
  align(center, {
    text(fill: color, size: 16pt, weight: "bold",
      "❧ " + display-title + " ❧"
    )
  })
  v(6pt)
  enum(
    numbering: "1.",
    ..items
  )
}

// ---------------------------------------------------------------------------
// Version history helpers
// ---------------------------------------------------------------------------

/// Date change entry for version history
#let datechange(date, description, changes) = {
  block(
    width: 100%,
    above: 8pt,
    {
      line(length: 100%, stroke: 0.4pt + luma(150))
      grid(
        columns: (auto, 1fr),
        gutter: 8pt,
        text(fill: rgb(60, 113, 183), weight: "bold", date),
        text(style: "italic", description),
      )
      v(4pt)
      enum(
        numbering: "①",
        ..changes
      )
    }
  )
}

// ---------------------------------------------------------------------------
// Utility: question (FAQ style)
// ---------------------------------------------------------------------------

/// FAQ question style
#let question(body) = {
  set text(style: "italic")
  body
  linebreak()
}
