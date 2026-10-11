// ─── Citation helpers (FOM style) ─────────────────────────────────────────────
// Style: footnote with Author (Year), p. X.
// Zotero → Better BibTeX → refs.bib → #bibliography("refs.bib", style: "apa")
//
// Usage in text:
//   #cf(<key>, page: "5")                  → footnote: Vgl. Author (Year), p. 5.
//   #cf(<key>)                             → footnote: Vgl. Author (Year).
//   #quot(<key>, page: "5")               → footnote: Author (Year), p. 5. (verbatim)
//   #cf-multi((<a>, "3"), (<b>, "7"))      → footnote: Vgl. A (Year), p. 3; B (Year), p. 7.
//
// Source lines below figures (do NOT appear in figure list):
//   caption: [Title]                        ← title only in caption
//   #fig-based-on-note(<key>, page: "47")  ← source line directly after figure
//   #fig-source-note(<key>, page: "47")    ← alternative: "Quelle:"
//   #fig-note[n = 5; own survey.]          ← arbitrary annotation

// Format page reference
#let _page(page) = if page != none [, S.~#page] else []

// Paraphrase footnote (cf.)
#let cf(key, page: none) = {
  "\u{2060}"
  footnote[Vgl. #cite(key, form: "prose")#_page(page).]
}

// Direct quote footnote (verbatim, without "Vgl.")
#let quot(key, page: none) = {
  "\u{2060}"
  footnote[#cite(key, form: "prose")#_page(page).]
}

// Multiple sources in one footnote
#let cf-multi(..entries) = {
  "\u{2060}"
  footnote[Vgl. #entries.pos().enumerate().map(((i, e)) => {
    let (key, page) = if e.len() == 2 { e } else { (e.first(), none) }
    [#cite(key, form: "prose")#_page(page)]
  }).join([; ]).]
}

// Closing German quotation mark — use when " appears directly before #cf/#quot
#let cq = "\u{201C}"

// Figure source (inline, for body text or as part of caption)
#let fig-source(key, page: none) = [Quelle: #cite(key, form: "prose")#_page(page).]

// Figure based on (inline)
#let fig-based-on(key, page: none) = [In Anlehnung an #cite(key, form: "prose")#_page(page).]

// ─── Source lines directly below figures ──────────────────────────────────────
// Do NOT appear in figure list — they are placed outside the caption.
// Usage: keep caption clean, place source line directly below <label>.

#let fig-note(body) = block(
  above: 0pt,
  below: 2.2em,
  width: 100%,
  align(center,
    text(size: 9pt, style: "italic", weight: "regular")[#body]
  )
)

#let fig-source-note(key, page: none) = fig-note[
  Quelle: #cite(key, form: "prose")#_page(page).
]

#let fig-based-on-note(key, page: none) = fig-note[
  In Anlehnung an #cite(key, form: "prose")#_page(page).
]
