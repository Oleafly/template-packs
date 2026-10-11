// Bibliography helper.
//
// Typst prints only cited entries by default. Keep `full: false` so the
// bibliography cannot silently include works that do not appear in the text.

#let print-references(
  path: "../refs.bib",
  title: "参考文献",
  style: "../lib/numeric-brackets-spaced.csl",
) = {
  set text(lang: "en")
  bibliography(path, title: title, style: style, full: false)
}
