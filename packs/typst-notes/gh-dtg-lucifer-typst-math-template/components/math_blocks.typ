// components/math_blocks.typ
// Complete suite of mathematical environments modeled after Charlie's LaTeX template (cmt.sty)

#import "boxes.typ": badge-box, continuation-box, frame-box, left-bar-box, ribbon-box
#import "theme.typ": resolve-palette

/// Smart helper to format title with environment prefix without duplication
#let _format-env-title(prefix, title) = {
  if title == none or title == "" {
    prefix
  } else if type(title) == str {
    if title == prefix or title.starts-with(prefix + " ") or title.starts-with(prefix + ":") {
      title
    } else {
      prefix + ": " + title
    }
  } else {
    [#prefix: #title]
  }
}

/// Definition environment (Charlie's signature dark red tab badge box)
#let definition(
  title: "Definition",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Definition", title)
    badge-box(
      title: display-title,
      tag: tag,
      body,
      tab-fill: p.definition.header-bg,
      tab-fg: p.definition.header-fg,
      stroke: p.definition.border,
      fill: p.definition.bg,
      text-color: p.definition.text,
      theme: theme,
    )
  }
}

/// Shorthand for Charlie's \dfn{title}{body}
#let dfn(title, body, tag: none, theme: none) = {
  definition(title: title, tag: tag, body, theme: theme)
}

/// Shorthand for Charlie's \dfnc
#let dfnc(title, body, tag: none, theme: none) = {
  definition(title: title, tag: tag, body, theme: theme)
}

/// Example environment (Charlie's teal outline box with sharp corners)
#let example(
  title: "Example",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Example", title)
    frame-box(
      title: display-title,
      tag: tag,
      body,
      border-color: p.example.border,
      bg-color: p.example.bg,
      title-color: p.example.title,
      text-color: p.example.text,
      theme: theme,
    )
  }
}

/// Shorthand for Charlie's \ex{title}{body}
#let ex(title, body, tag: none, theme: none) = {
  example(title: title, tag: tag, body, theme: theme)
}

/// Theorem environment (Royal navy blue left-bar box)
#let theorem(
  title: "Theorem",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Theorem", title)
    left-bar-box(
      title: display-title,
      tag: tag,
      body,
      bar-color: p.theorem.bar,
      bg-color: p.theorem.bg,
      title-color: p.theorem.title,
      theme: theme,
    )
  }
}

/// Shorthand for Charlie's \thm{title}{body}
#let thm(title, body, tag: none, theme: none) = {
  theorem(title: title, tag: tag, body, theme: theme)
}

/// Theorem continuation box (Charlie's \thmcon{body} / Theoremcon environment)
/// Continuation box without re-stating the theorem title
#let thmcon(body, theme: none) = {
  context {
    let p = resolve-palette(theme-override: theme)
    continuation-box(
      body,
      bar-color: p.theorem.bar,
      bg-color: p.theorem.bg,
      text-color: p.text,
      theme: theme,
    )
  }
}

#let theorem-continuation = thmcon

/// Proposition environment (Midnight navy left-bar box)
#let proposition(
  title: "Proposition",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Proposition", title)
    left-bar-box(
      title: display-title,
      tag: tag,
      body,
      bar-color: p.proposition.bar,
      bg-color: p.proposition.bg,
      title-color: p.proposition.title,
      theme: theme,
    )
  }
}

/// Shorthands for Charlie's \mprop and \prop
#let mprop(title, body, tag: none, theme: none) = {
  proposition(title: title, tag: tag, body, theme: theme)
}
#let prop = mprop

/// Lemma environment (Terracotta left-bar box)
#let lemma(
  title: "Lemma",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Lemma", title)
    left-bar-box(
      title: display-title,
      tag: tag,
      body,
      bar-color: p.lemma.bar,
      bg-color: p.lemma.bg,
      title-color: p.lemma.title,
      theme: theme,
    )
  }
}

/// Shorthand for Charlie's \mlemma
#let mlemma(title, body, tag: none, theme: none) = {
  lemma(title: title, tag: tag, body, theme: theme)
}

/// Corollary environment (Purple/plum left-bar box)
#let corollary(
  title: "Corollary",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Corollary", title)
    left-bar-box(
      title: display-title,
      tag: tag,
      body,
      bar-color: p.corollary.bar,
      bg-color: p.corollary.bg,
      title-color: p.corollary.title,
      theme: theme,
    )
  }
}

/// Shorthand for Charlie's \cor
#let cor(title, body, tag: none, theme: none) = {
  corollary(title: title, tag: tag, body, theme: theme)
}

/// Claim environment (Green left-bar box)
#let claim(
  title: "Claim",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Claim", title)
    left-bar-box(
      title: display-title,
      tag: tag,
      body,
      bar-color: p.claim.bar,
      bg-color: p.claim.bg,
      title-color: p.claim.title,
      theme: theme,
    )
  }
}

/// Shorthand for Charlie's \clm
#let clm(title, body, tag: none, theme: none) = {
  claim(title: title, tag: tag, body, theme: theme)
}

/// Inline / lightweight claim (Charlie's \iclm / iclaim environment)
#let iclm(title: "Claim", body, theme: none) = {
  context {
    let p = resolve-palette(theme-override: theme)
    v(4pt)
    [#text(weight: "bold", fill: p.claim.bar)[#title:] #body]
    v(4pt)
  }
}

#let iclaim = iclm

/// Exercise environment (Teal left-bar box)
#let exercise(
  title: "Exercise",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Exercise", title)
    left-bar-box(
      title: display-title,
      tag: tag,
      body,
      bar-color: p.exercise.bar,
      bg-color: p.exercise.bg,
      title-color: p.exercise.title,
      theme: theme,
    )
  }
}

/// Shorthand for Charlie's \mer
#let mer(title, body, tag: none, theme: none) = {
  exercise(title: title, tag: tag, body, theme: theme)
}

/// Remark environment (Subtle gray left-bar box)
#let remark(
  title: "Remark",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Remark", title)
    left-bar-box(
      title: display-title,
      tag: tag,
      body,
      bar-color: p.remark.bar,
      bg-color: p.remark.bg,
      title-color: p.remark.title,
      theme: theme,
    )
  }
}

/// Shorthand for Charlie's \rmk
#let rmk(title, body, tag: none, theme: none) = {
  remark(title: title, tag: tag, body, theme: theme)
}

/// Question environment (Muted blue ribbon box)
#let question(
  title: "Question",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Question", title)
    ribbon-box(
      title: display-title,
      tag: tag,
      body,
      ribbon-color: p.question.ribbon,
      border-color: p.question.border,
      bg-color: p.question.bg,
      text-color: p.question.text,
      theme: theme,
    )
  }
}

/// Shorthand for Charlie's \qs
#let qs(title, body, tag: none, theme: none) = {
  question(title: title, tag: tag, body, theme: theme)
}

/// Solution environment (Muted forest green ribbon box or inline format)
#let solution(
  title: "Solution",
  tag: none,
  body,
  boxed: true,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Solution", title)
    if boxed {
      ribbon-box(
        title: display-title,
        tag: tag,
        body,
        ribbon-color: p.solution.ribbon,
        border-color: p.solution.border,
        bg-color: p.solution.bg,
        text-color: p.solution.text,
        theme: theme,
      )
    } else {
      v(6pt)
      block(width: 100%)[
        #text(weight: "bold", style: "italic", fill: p.solution.ribbon)[#display-title:]
        #h(4pt)
        #body
      ]
    }
  }
}

/// Shorthand for Charlie's \sol
#let sol(body, title: "Solution", boxed: false, theme: none) = {
  solution(title: title, body, boxed: boxed, theme: theme)
}

/// Shorthand for Charlie's \solbox (boxed solution)
#let solbox(body, title: "Solution", theme: none) = {
  solution(title: title, body, boxed: true, theme: theme)
}

/// Proof environment with custom heading and QED tombstone symbol
#let proof(
  title: "Proof",
  qed: true,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    v(6pt)
    block(
      width: 100%,
      inset: (left: 4pt),
      breakable: true,
      {
        text(weight: "bold", style: "italic", fill: p.text)[#title: ]
        body
        if qed {
          h(1fr)
          box(
            stroke: 0.8pt + p.text,
            width: 6pt,
            height: 6pt,
            baseline: 0%,
          )
        }
      }
    )
  }
}

/// Shorthand for Charlie's \pf and \myproof
#let pf(body, title: "Proof", theme: none) = {
  proof(title: title, body, theme: theme)
}
#let myproof = pf

/// Wrong concept / Warning concept box (Charlie's \wconc and \wc)
#let wrong-concept(
  title: "Wrong Concept",
  tag: none,
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let display-title = _format-env-title("Wrong Concept", title)
    badge-box(
      title: display-title,
      tag: tag,
      body,
      tab-fill: p.wrong-concept.border,
      tab-fg: rgb("#ffffff"),
      stroke: p.wrong-concept.border,
      fill: p.wrong-concept.bg,
      text-color: p.wrong-concept.text,
      theme: theme,
    )
  }
}

#let concept = wrong-concept
#let wconc = wrong-concept
#let wc(title, body, tag: none, theme: none) = {
  wrong-concept(title: title, tag: tag, body, theme: theme)
}

/// Charlie's \circled{1} helper for circled numbers using SF Mono
#let circled(n) = {
  context {
    let p = resolve-palette()
    box(
      baseline: -10%,
      circle(
        radius: 4.8pt,
        stroke: 0.65pt + p.text,
        fill: none,
        align(
          center + horizon,
          text(
            size: 6.5pt,
            weight: "bold",
            font: ("SF Mono", "DejaVu Sans Mono"),
            fill: p.text,
            str(n)
          )
        )
      )
    )
  }
}

/// Circled numbering helper for list enums: set enum(numbering: circled-num)
#let circled-num(n) = [#circled(n)#h(3pt)]

/// Numbered list using circled numbers ONLY (no default 1., 2. text numbering)
#let clist(..items) = {
  set enum(numbering: circled-num)
  enum(..items)
}
