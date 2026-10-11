// ─── Abbreviation management ───────────────────────────────────────────────────
// Usage in text:
//   #abbr("SME", "Small and Medium Enterprises")
//     → first occurrence:  "Small and Medium Enterprises (SME)"
//     → each subsequent:   "SME"
//
// Abbreviation list in main.typ:
//   #abbrev-list()   → renders all collected abbreviations alphabetically

#let _abbrevs      = state("abbrevs", (:))    // short → long
#let _abbrevs-seen = state("abbrevs-seen", ()) // already introduced abbreviations

// Use in text
#let abbr(short, long, german: none) = {
  // Register abbreviation (idempotent)
  _abbrevs.update(d => { d.insert(short, long); d })
  // Write out at first occurrence, then only abbreviation
  context {
    if short not in _abbrevs-seen.get() {
      _abbrevs-seen.update(s => s + (short,))
      if german != none {
        [#long (#short, dt.: #german)]
      } else {
        [#long (#short)]
      }
    } else {
      short
    }
  }
}

// Render abbreviation list (replaces the manual list in main.typ)
#let abbrev-list() = context {
  let dict = _abbrevs.final()
  for short in dict.keys().sorted() {
    block(above: 0pt, below: 1.1em, width: 100%)[
      #short #box(width: 1fr, align(bottom, repeat[.])) #dict.at(short)
    ]
  }
}
