// data.typ — add all abbreviations and formula symbols here

// ─── ABBREVIATIONS ────────────────────────────────────────────────────────────
// Usage in text:  #gl("key")   → "Long Form (SHORT)" on first use, "SHORT" after
//                 #glh("key")  → always "SHORT" (use in headings to avoid TOC trigger)
//                 #gll("key")  → "lowercase long form (SHORT)" on first use
//
// Entry format:
//   (
//     key: "mykey",           // unique identifier, use in #gl("mykey")
//     short: "MY",            // abbreviation shown in text and list
//     long: "My Long Form",   // written out on first use
//     lower: "my long form"   // optional — required only if you use #gll("mykey")
//   ),

#let glossary = (
  (
    key: "eu",
    short: "EU",
    long: "European Union",
    lower: "european union"
  ),
  // Add more entries here …
)


// ─── FORMULA SYMBOLS ──────────────────────────────────────────────────────────
// Usage in equations: #gls("key")  → always short form, marks key as used
//
// Entry format:
//   (
//     key: "myvar",
//     short: $x_i$,                    // Typst math expression
//     long: [Description of the symbol],
//     lower: [lowercase description],   // optional
//     unit: "kg"                        // string key from si() dict, or Typst math, or "none"
//   ),

#let symbols = (
  (
    key: "example_var",
    short: $x_i$,
    long: [Value of parameter $i$],
    lower: [value of parameter $i$],
    unit: "none"
  ),
  // Add more entries here …
)
