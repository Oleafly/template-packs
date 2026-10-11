// Spis treści, literatura i spisy rysunków, tabel oraz listingów.
// Każdy zaczyna własną stronę. `wlaczony: false` pomija dany spis.

#let spis-tresci(tytul: [Spis treści], wlaczony: true) = {
  if not wlaczony { return }
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: false)[#tytul]
  outline(title: none, depth: 4)
}

#let bibliografia(
  tytul: [Literatura],
  plik: "/literatura.bib",
  wlaczony: true,
) = {
  if not wlaczony { return }
  pagebreak(weak: true)
  heading(level: 1)[#tytul]
  bibliography(plik, title: none, style: "ieee")
}

#let _spis(tytul, cel, wlaczony: true) = {
  if not wlaczony { return }
  pagebreak(weak: true)
  heading(level: 1, numbering: none)[#tytul]
  outline(title: none, target: cel)
}

#let spis-rysunkow(tytul: [Spis rysunków], wlaczony: true) = _spis(
  tytul,
  figure.where(kind: image),
  wlaczony: wlaczony,
)
#let spis-tabel(tytul: [Spis tabel], wlaczony: true) = _spis(
  tytul,
  figure.where(kind: table),
  wlaczony: wlaczony,
)
#let spis-listingow(tytul: [Spis listingów], wlaczony: true) = _spis(
  tytul,
  figure.where(kind: "listing"),
  wlaczony: wlaczony,
)
