// ═══════════════════════════════════════════════════════════════════════════
// UTILS — small helpers used across the document
// ═══════════════════════════════════════════════════════════════════════════

// ── A cross-reference that survives a single-chapter preview ───────────────
//
// `@sec:results` fails to compile when the chapter that defines the label is
// not part of the document — which is exactly what happens in preview.typ.
// `xref` emits a real link when the target exists and falls back to plain text
// when it does not:
//
//     ... as discussed in #xref(<sec:results>, [Chapter 3]) ...
//
// That tolerance is right while previewing one chapter and wrong in the
// finished thesis, where a silent fallback hides a typo in a label. So the
// behaviour is switchable: main.typ turns strict mode on and a missing label
// becomes a compile error, preview.typ leaves it off and gets the fallback.
//
//     #strict-xref.update(true)     // in main.typ
//
// A single call can always overrule the document-wide setting with
// `#xref(<some:label>, [text], strict: false)` — useful for the one reference
// that legitimately points outside this document.
#let strict-xref = state("strict-xref", false)

#let xref(label, fallback, strict: auto) = context {
  if query(label).len() > 0 {
    ref(label)
  } else if (if strict == auto { strict-xref.get() } else { strict }) {
    // The error is reported at this line rather than at the call site — that
    // is how `panic` inside a `context` block behaves — so the message names
    // the label and the fallback text: search your .typ files for either.
    panic(
      "xref: nothing in this document is labelled <"
        + str(label)
        + ">. Search your sources for it and fix the spelling, include the "
        + "chapter that defines it, or pass strict: false to this one call. "
        + "(Its fallback text is "
        + repr(fallback)
        + ".)",
    )
  } else {
    fallback
  }
}

// ── List of symbols ────────────────────────────────────────────────────────
//
// A heading for one group of symbols, not numbered and not in the table of
// contents (there would be far too many entries otherwise).
#let symbol-group(title) = heading(level: 2, numbering: none, outlined: false, title)

// A three-column symbol table: symbol | meaning | unit.
//
//     #symbol-table(
//       [$r$], [radial position],  [cm],
//       [$t$], [time],             [s],
//     )
//
#let symbol-table(..rows) = {
  set text(size: 0.9em)
  table(
    columns: (auto, 1fr, auto),
    align: (x, _) => if x == 0 { center + horizon } else { left + horizon },
    inset: (x: 6pt, y: 4pt),
    // Nothing thinner than 0.25 pt: hairlines print unevenly or drop out
    // altogether. `uv run tools/check-print.py` flags any that creep back in.
    stroke: (_, y) => if y == 0 { (bottom: 0.6pt) } else { (bottom: 0.4pt + luma(190)) },
    table.header([Symbol], [Meaning], [Unit]),
    ..rows.pos()
  )
}

// ── Text replacements for the running head ─────────────────────────────────
//
// Long chapter titles do not fit into a page header. `shorten` applies a list
// of regex replacements to whatever you pass it:
//
//     #let short = shorten.with(replacements: (
//       ("(?i)analytical ultracentrifugation", "AUC"),
//     ))
//     header-right: running-section(transform: short),
//
#let shorten(body, replacements: ()) = {
  let result = body
  for (pattern, replacement) in replacements {
    result = {
      show regex(pattern): replacement
      result
    }
  }
  result
}
