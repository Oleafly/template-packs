// Theorem-like environments: a hairline left rule and a small accent label.
//
// Only the label reads the accent, and it is the only part inside `context`.
// The body stays outside so `#pause` and `#uncover` keep working within a
// statement, and so statements work in captions, tables and columns.

#import "tokens.typ": *
#import "components.typ": accent-state

#let _frame(label, body) = block(
  width: 100%,
  breakable: false,
  inset: (left: 16pt, y: 3pt),
  stroke: (left: 1.5pt + rule),
  {
    block(below: 0.55em, text(size: size.small, label))
    body
  },
)

#let _heading(kind, number, title, fill: none) = {
  let name = kind + if number != none { " " + str(number) }
  if fill == none {
    context text(fill: accent-state.get(), weight: 600, name)
  } else {
    text(fill: fill, weight: 600, name)
  }
  if title != none {
    h(0.6em)
    text(fill: ink-muted, title)
  }
}

// One factory for every kind.
//
// - number: Optional, set by hand (`number: 2`, `number: "A.1"`) to match the
//   paper. There are no automatic counters: a talk rarely shows every result.
#let _statement(kind) = (title: none, number: none, body) => _frame(
  _heading(kind, number, title),
  body,
)

#let assumption = _statement("Assumption")
#let definition = _statement("Definition")
#let proposition = _statement("Proposition")
#let theorem = _statement("Theorem")
#let lemma = _statement("Lemma")
#let corollary = _statement("Corollary")
#let remark = _statement("Remark")
#let example = _statement("Example")

/// Proof, with a neutral label and a closing tombstone.
#let proof(title: none, body) = _frame(
  _heading("Proof", none, title, fill: ink-muted),
  body + h(1fr) + text(fill: ink-subtle, sym.square.stroked),
)
