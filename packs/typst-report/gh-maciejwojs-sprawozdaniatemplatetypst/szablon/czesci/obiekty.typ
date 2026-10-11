// Rysunek, tabela, listing i odsyłacz w tekście.

#import "kod.typ": blok-kodu

#let _podpis(it, nazwa) = {
  if it.caption == none { return }
  set text(size: 10.5pt)
  set par(leading: 0.35em, spacing: 0pt, first-line-indent: 0pt, justify: false)
  let cialo = it.caption.body
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.35em,
    align: (left, left),
    text(weight: "bold")[
      #nazwa
      #context { counter(figure.where(kind: it.kind)).display(it.numbering) }.
    ],
    cialo,
  )
}

#let pokaz-figure(it, nazwa, podpis-nad: false) = {
  set par(first-line-indent: 0pt, justify: false)
  block(above: 14pt, below: 14pt, breakable: true)[
    #if podpis-nad [
      #align(center, _podpis(it, nazwa))
      #v(9pt)
      #align(center, it.body)
    ] else [
      #align(center, it.body)
      #v(6pt)
      #align(center, _podpis(it, nazwa))
    ]
  ]
}

#let numer-w-sekcji(n) = context {
  let rozdzial = counter(heading).get().first()
  numbering("1.1", rozdzial, n)
}

// Odsyłacz do rysunku, tabeli albo listingu: numer i strona.
// Rysunek dostaje przedrostek „Rysunek”. `nazwa: none` zostawia sam numer.
#let odnosnik(etykieta, nazwa: auto) = link(
  etykieta,
  context {
    let el = query(etykieta).first()
    let rodzaj = el.kind
    let roz = counter(heading).at(el.location()).first()
    let n = counter(figure.where(kind: rodzaj)).at(el.location()).first()
    let strona = counter(page).at(el.location()).first()
    let przedrostek = if nazwa != auto {
      nazwa
    } else if rodzaj == image {
      "Rysunek"
    } else {
      none
    }
    if przedrostek != none {
      [#przedrostek #roz.#n (s. #strona)]
    } else {
      [#roz.#n (s. #strona)]
    }
  },
)

#let rysunek(tresc, tytul) = figure(
  tresc,
  kind: image,
  supplement: [Rys.],
  caption: tytul,
)

#let tabela(tytul, tresc) = figure(
  tresc,
  kind: table,
  supplement: [Tab.],
  caption: tytul,
)

#let listing(podpis, ..args, plik: none, jezyk: none, numeracja: auto, kolory: (:)) = {
  let kod = if args.pos().len() > 0 {
    args.pos().first()
  } else {
    args.named().at("kod", default: none)
  }
  let surowe = if plik != none {
    read(plik)
  } else if kod != none {
    kod
  } else {
    panic("listing wymaga kodu albo argumentu plik")
  }
  let zrodlo = if type(surowe) == str { surowe } else { surowe.text }
  let lang = if jezyk != none {
    jezyk
  } else if plik == none and type(surowe) != str {
    surowe.lang
  } else {
    none
  }
  figure(
    blok-kodu(zrodlo, jezyk: lang, numeracja: numeracja, kolory: kolory),
    kind: "listing",
    supplement: [Listing],
    caption: podpis,
  )
}

// Ścieżka od katalogu głównego projektu, z ukośnikiem na początku: "/kod/main.cpp".
#let listing-plik(sciezka, podpis, jezyk: none, numeracja: auto, kolory: (:)) = listing(
  podpis,
  read(sciezka),
  jezyk: jezyk,
  numeracja: numeracja,
  kolory: kolory,
)
