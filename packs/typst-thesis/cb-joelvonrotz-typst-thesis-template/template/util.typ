#let numbering-by-section(n, format: "1.1.") = numbering(format, counter(heading).get().first(), n)

#let header(body) = block(width: 100%, text(font: "Libertinus Sans", body))
#let footer(body) = block(width: 100%, text(font: "Libertinus Sans", body))

#let position-less-equal(a,b) = {
  if a.page <= b.page {
    (a.y <= b.y)
  }
}

#let get-current-heading(level: 1) = {
  query(selector(heading.where(level: level))).filter(it => it.location().page() <= here().page()).dedup(key: it => it.location().page()).last()
}
