#import "@preview/headcount:0.1.0": dependent-numbering, reset-counter
#import "figure-and-reference-config.typ": display-counter-at

#let create-outline(title, target) = {
  show outline.entry.where(level: 1): set text(weight: "regular")
  show outline.entry.where(level: 1): set outline.entry(fill: pad(left: 0.2em, right: 1em, repeat(gap: 0.50em, ".")))

  show outline.entry: it => {
    link(
      it.element.location(),
      it.indented(
        context display-counter-at(it.element.kind, it.element.location(), "1.1."),
        it.inner(),
      ),
    )
  }


  heading(title, numbering: none)
  outline(title: none, target: target)
}
