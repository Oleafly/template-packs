// ═══════════════════════════════════════════════════════════════════════════
// BLOCKS — callout boxes and draft notes you can use inside the text
// ═══════════════════════════════════════════════════════════════════════════

#import "theme.typ": theme-state

// ── A tinted callout box in the accent colour ──────────────────────────────
//
//     #note[Sedimentation coefficients are reported in svedbergs.]
//     #note(title: "Convention")[...]
//
#let note(body, title: none) = context {
  let th = theme-state.get()
  block(
    fill: th.accent-bg,
    radius: 2pt,
    inset: (x: 8pt, y: 7pt),
    width: 100%,
    breakable: true,
    {
      if title != none {
        text(fill: th.accent, weight: "bold", font: th.font-sans, title)
        v(8pt, weak: true)
      }
      set text(fill: th.accent)
      body
    },
  )
}

// ── Draft notes ────────────────────────────────────────────────────────────
//
// Use `#todo[...]` for anything you still have to do or check, and
// `#mark[..]` for a quick doubt inside a sentence. Two independent switches,
// both set in main.typ, decide what happens to them:
//
//     #show-todos.update(true)     // true  ⇒ highlighted in the PDF
//                                  // false ⇒ invisible, but still counted
//     #strict-todos.update(true)   // true  ⇒ any note left is a compile error
//
// So the three settings that make sense are: show them while writing
// (true / false), hide them for a clean draft to send out (false / false),
// and refuse to build at all while any remain, for the version you hand in
// (either / true).
#let show-todos = state("show-todos", true)
#let strict-todos = state("strict-todos", false)

// Every note also drops an invisible marker into the document. That is what
// makes `check-todos()` able to count notes it cannot see — hiding a note must
// not hide the fact that it is still there.
#let draft-note-marker(kind) = [#metadata(kind)<thesis-draft-note>]

#let todo(body, title: "TODO") = {
  draft-note-marker("todo")
  context {
    if not show-todos.get() { return }
    block(
      width: 100%,
      breakable: true,
      radius: 1pt,
      inset: (x: 8pt, y: 6pt),
      fill: rgb("#fbf3d6"),
      stroke: (left: 2.5pt + rgb("#c99a2e")),
      {
        if title != none {
          text(weight: "bold", size: 0.85em, fill: rgb("#8a6a1a"), upper(title))
          linebreak()
        }
        body
      },
    )
  }
}

// The inline sibling of `todo`, for a quick remark in the middle of a
// sentence: `... the value is #mark[which value?] and therefore ...`
#let mark(body) = {
  draft-note-marker("mark")
  context {
    if not show-todos.get() { return }
    highlight(fill: rgb("#fbf3d6"), text(fill: rgb("#8a6a1a"), body))
  }
}

// Reports every draft note still in the document, in one error rather than
// one error per note — you fix them in a single pass instead of recompiling
// after each. `thesis()` calls this at the very end of the document, so
// turning `strict-todos` on in main.typ is all you have to do.
#let check-todos() = context {
  if not strict-todos.get() { return }

  let notes = query(<thesis-draft-note>)
  if notes.len() == 0 { return }

  let count(kind) = notes.filter(it => it.value == kind).len()
  let kinds = ("todo", "mark")
    .map(k => (count(k), k))
    .filter(((n, _)) => n > 0)
    .map(((n, k)) => str(n) + " " + k + if n > 1 { "s" } else { "" })
    .join(" and ")
  let pages = notes.map(it => str(it.location().page())).dedup().join(", ")

  panic(
    "strict-todos: "
      + kinds
      + " still in the thesis, on page(s) "
      + pages
      + ". Resolve them and delete the #todo / #mark calls, or set "
      + "strict-todos to false in main.typ while you are still writing. "
      + "(Set show-todos to true to see them highlighted in the PDF.)",
  )
}
