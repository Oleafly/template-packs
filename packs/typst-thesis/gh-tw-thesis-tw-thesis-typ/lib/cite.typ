#import "util.typ": spread

// natbib equivalents
#let c(key, supplement: none) = cite(label(key), supplement: supplement, form: "prose")   // \citet
#let cp(key, supplement: none) = cite(label(key), supplement: supplement)                 // \citep
#let ca(key) = cite(label(key), form: "author")                                           // \citeauthor
#let cy(key) = cite(label(key), form: "year")                                             // \citeyear

// APA terms are English; keep the list out of the CJK locale
#let references(cfg) = {
  let b = cfg.bibliography
  text(lang: "en", region: "US")[
    #bibliography(
      b.path,
      title: spread(b.title, gap: cfg.layout.title-spread),
      style: b.style,
      full: b.full,
    )
  ]
}
