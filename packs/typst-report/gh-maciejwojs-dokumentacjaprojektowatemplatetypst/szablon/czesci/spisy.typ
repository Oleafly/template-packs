// Spis treści, literatura i spisy rysunków, tabel oraz listingów.

#let spis-tresci(tytul: [Spis treści]) = {
  heading(level: 1, numbering: none, outlined: false)[#tytul]
  outline(title: none, depth: 4)
}

#let bibliografia(tytul: [Literatura], plik: "/praca/literatura.bib") = {
  heading(level: 1)[#tytul]
  bibliography(plik, title: none, style: "ieee")
}

#let _spis(tytul, cel) = {
  heading(level: 1, numbering: none)[#tytul]
  outline(title: none, target: cel)
}

#let spis-rysunkow(tytul: [Spis rysunków]) = _spis(tytul, figure.where(kind: image))
#let spis-tabel(tytul: [Spis tabel]) = _spis(tytul, figure.where(kind: table))
#let spis-listingow(tytul: [Spis listingów]) = _spis(tytul, figure.where(kind: "listing"))
