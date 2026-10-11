// Theorem environments: shared numbering, margin labels, and references.

#import "settings.typ": settings
#import "theme.typ": theorem-style
#import "layout.typ": place-side

// Width of the colored bar that marks an environment in the outer margin.
#let theorem-bar = 4pt

// All environments share one counter, numbered `<section>.<subsection>.<n>`.
#let thm-counter = counter("theorem")

// Render one environment: a margin bar, a label, and the body.
#let theorem-render(env, title, number, body, theme-key: "theorem") = context {
  let s = settings.get()
  let style = theorem-style(s.theme, theme-key)

  let label = block(
    width: s.side.width,
    text(
      fill: style.label,
      font: s.fonts.sans,
      [*#env #number*\ #if title != none { title }],
    ),
  )

  // The bar overshoots the block by half a grid step on each side.
  let overshoot = s.texts.step / 2
  block(
    block([#place-side(label) #body], width: s.body.width, breakable: true),
    width: 100%,
    breakable: true,
    outset: (
      left: s.side.half-gutter,
      right: s.side.half-gutter,
      top: overshoot,
      bottom: overshoot,
    ),
    stroke: (left: (paint: style.paint, thickness: theorem-bar)),
  )
}

// Installed by `init` via `show: theorem-rules.with(...)`: suppresses the default
// figure layout, restarts numbering each section, and formats `@thm` / `@thm[!]`.
#let theorem-rules(it, base-level: 1, pattern: "1.1.1") = {
  show figure.where(kind: "theorem"): it => align(left, it.body)

  thm-counter.update((1,))

  // Restart numbering, keeping the heading numbers as a prefix.
  show heading: it => {
    it
    if it.numbering != none and it.level <= base-level {
      context {
        thm-counter.update(counter(heading).get() + (1,))
      }
    }
  }

  show ref: it => {
    let el = it.element
    if el != none and el.func() == figure and el.kind == "theorem" {
      let location = el.location()
      if it.supplement == [!] and el.caption != none {
        return link(location, el.caption.body)
      }
      return link(
        location,
        [#el.supplement #numbering(pattern, ..thm-counter.at(location))],
      )
    }
    it
  }

  it
}

// Environments take either `[body]` or `[title][body]`.
#let split-arguments(args, name) = {
  if args.len() == 1 {
    (none, args.at(0))
  } else if args.len() == 2 {
    (args.at(0), args.at(1))
  } else {
    panic(
      name + " expects 1 or 2 positional arguments, got " + str(args.len()) + ".",
    )
  }
}

// Build an environment function. `theme-key` selects its stroke from the theme.
#let make-environment(full-name, short-name, theme-key) = (..args) => {
  let (title, body) = split-arguments(args.pos(), full-name)
  figure(
    kind: "theorem",
    supplement: full-name,
    caption: title,
    outlined: false,
  )[
    #context {
      let s = settings.get()
      thm-counter.step(level: s.headings.thm.base + 1)
      theorem-render(
        short-name,
        title,
        numbering(s.headings.thm.numbering, ..thm-counter.get()),
        body,
        theme-key: theme-key,
      )
    }
  ]
}

#let theorem = make-environment("Theorem", "THM", "theorem")
#let proposition = make-environment("Proposition", "PROP", "proposition")
#let corollary = make-environment("Corollary", "COR", "corollary")
#let lemma = make-environment("Lemma", "LEM", "lemma")
#let definition = make-environment("Definition", "DEF", "definition")
#let example = make-environment("Example", "EX", "example")
#let remark = make-environment("Remark", "REM", "remark")

#let proof(..args) = context {
  let (title, body) = split-arguments(args.pos(), "Proof")
  let s = settings.get()
  let half-gutter = s.side.half-gutter
  block(
    width: 100%,
    breakable: true,
    outset: (
      left: half-gutter,
      right: half-gutter,
      top: s.texts.ascender,
      bottom: 0pt,
    ),
  )[
    _#if title != none { [#title] } else { [Proof] }._ #body #h(1fr) $square$
  ]
}
