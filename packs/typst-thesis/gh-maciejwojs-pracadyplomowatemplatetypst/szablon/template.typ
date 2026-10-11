// Szablon pracy dyplomowej
// Wydział Nauk Inżynieryjnych, Akademia Nauk Stosowanych w Nowym Sączu.
//
// Układ i formatowanie według „Zasad pisania prac dyplomowych” (2026)
// oraz wzoru strony tytułowej (załącznik B / wzór 2022–2023).
//
// Czcionka wymagana: Times New Roman. Gdy nie jest zainstalowana,
// używana jest Liberation Serif (zgodna metrycznie).
// Kod programu: Courier New, z zapasową Liberation Mono.

#let font-serif = ("Times New Roman", "Liberation Serif")
#let font-mono = ("Courier New", "Liberation Mono")

// --- odstępy ---------------------------------------------------------------
//
// Wiersz tekstu ma wysokość dokładnie 1 em (0,8 em nad linią bazową,
// 0,2 em pod nią), więc `par.leading` to krok wiersza minus 1 em.
// Krok wiersza liczy się jak w edytorze tekstu: mnożnik interlinii razy
// naturalna wysokość wiersza Times New Roman (1,15 em, z metryk czcionki).
// Wartości są w em, więc skalują się z rozmiarem czcionki: ta sama interlinia
// pojedyncza daje poprawny odstęp w kodzie 10 pkt i w podpisach 11 pkt.
#let wiersz-gora = 0.8em
#let wiersz-dol = -0.2em
#let wysokosc-wiersza = 1.15em
#let odstep(mnoznik) = mnoznik * wysokosc-wiersza - 1em

#let interlinia = odstep(1.5)
#let interlinia-pojedyncza = odstep(1)
// Pusty wiersz między blokami: zwykły odstęp plus jeden wiersz 1,5.
#let wolna-linia = interlinia + 1.5 * wysokosc-wiersza

#let zrodla-rys = state("zrodla-rys", ())

// --- strona tytułowa -------------------------------------------------------

#let strona-tytulowa(
  tytul,
  autor,
  kierunek,
  nr-albumu,
  promotor,
  wydzial,
  miejscowosc,
  rok,
) = {
  set par(leading: 0.2em, spacing: 0.2em, first-line-indent: 0pt, justify: false)
  set text(fill: black, weight: "bold", hyphenate: false)

  align(center)[
    #v(0.6cm)
    #text(18pt)[AKADEMIA NAUK STOSOWANYCH\ W NOWYM SĄCZU]

    #v(1.15cm)
    #text(18pt)[#upper(wydzial)]

    #v(1.7cm)
    #text(16pt)[PRACA DYPLOMOWA]

    #v(1.35cm)
    #text(16pt)[#upper(tytul)]

    #v(1fr)

    #align(center)[
      #block(width: auto)[
        #set align(left)
        #set par(leading: 0.55em, spacing: 0.15em)
        #text(14pt)[Autor: #autor] \
        #text(12pt)[Kierunek: #kierunek] \
        #text(12pt)[Nr albumu: #nr-albumu]
      ]
    ]

    #v(1.15cm)
    #text(12pt)[Promotor: #promotor]

    #v(1.25cm)
    #align(center)[
      #grid(
        columns: (auto, 7.4cm),
        column-gutter: 0.45em,
        align: (right + bottom, center),
        text(12pt)[Akceptacja promotora:],
        [
          #line(length: 100%, stroke: (thickness: 0.6pt, dash: "dotted"))
          #v(2pt)
          #text(8pt, weight: "regular")[data i podpis]
        ],
      )
    ]

    #v(1fr)
    #text(14pt)[#upper(miejscowosc) #rok]
    #v(0.2cm)
  ]
}

// --- rysunki, tabele, wzory, cytaty ---------------------------------------

// Podpis pod rysunkiem: „Rysunek N. Tytuł”, źródło kursywą 10 pkt.
// Etykietę dopina się za wywołaniem: `#rysunek(...) <nazwa>`.
#let rysunek(tresc, tytul, zrodlo: "opracowanie własne") = figure(
  {
    zrodla-rys.update(lista => lista + (zrodlo,))
    tresc
  },
  kind: image,
  supplement: [Rysunek],
  caption: tytul,
)

// Podpis nad tabelą, w dwóch wierszach, bez kropki po numerze.
// Źródło pod tabelą, kursywą 10 pkt. Treść tabeli: 10 pkt, bez pogrubień.
#let tabela(tytul, tresc, zrodlo: "opracowanie własne", uwagi: none) = figure(
  {
    set text(size: 10pt, weight: "regular")
    set par(leading: interlinia-pojedyncza, spacing: interlinia-pojedyncza, first-line-indent: 0pt, justify: false)
    tresc
    if zrodlo != none {
      align(center, text(size: 10pt, style: "italic")[Źródło: #zrodlo])
    }
    if uwagi != none {
      align(left, text(size: 10pt, style: "normal")[#uwagi])
    }
  },
  kind: table,
  supplement: [Tabela],
  caption: tytul,
)

// Odsyłacze w tekście, w przypadku wymaganym przez wytyczne.
// „jak pokazano na #rys(<schemat>)” → „jak pokazano na rysunku 1”.
#let rys(etykieta) = ref(etykieta, supplement: [rysunku])
#let tab(etykieta) = ref(etykieta, supplement: [tabeli])

// Równanie z objaśnieniem symboli. Sam wzór numeruje się z prawej strony.
// Wywołanie: `#wzor(objasnienia: [gdzie: $I$ -- natężenie prądu [A].])[$ I = U / Z $ <ozn>]`
// Odstępy między blokami Typst łączy do większej wartości, dlatego wzór
// z objaśnieniem dostaje mniejszy odstęp dolny, a wolna linia idzie pod objaśnienie.
#let wzor(rownanie, objasnienia: none) = {
  if objasnienia == none {
    return rownanie
  }
  show math.equation.where(block: true): set block(below: interlinia)
  rownanie
  set par(first-line-indent: 0pt, justify: false, leading: interlinia, spacing: interlinia)
  block(inset: (left: 0.75cm), above: interlinia, below: wolna-linia)[#objasnienia]
}

// Cytat od 40 słów: blok wcięty o 0,75 cm, bez cudzysłowu.
#let cytat(tresc, odsylacz: none) = {
  set par(first-line-indent: (amount: 0.375cm, all: true), justify: true, leading: interlinia, spacing: interlinia)
  block(inset: (left: 0.75cm), above: interlinia, below: interlinia)[
    #tresc
    #if odsylacz != none [ #odsylacz]
  ]
}

// Załącznik zaczyna się od nowej strony. Spis budowany jest automatycznie.
#let zalacznik(tytul, tresc) = {
  figure(
    [],
    kind: "zalacznik",
    supplement: [Załącznik],
    numbering: "1",
    caption: tytul,
  )
  tresc
}

#let bibliografia(
  plik: "/praca/literatura.bib",
  zrodla-internetowe: "/praca/netografia.bib",
) = {
  heading(level: 1, numbering: none)[Bibliografia]
  bibliography(plik, title: none, style: "/szablon/style/ans-harvard.csl")
  heading(level: 2, numbering: none, outlined: true)[Źródła internetowe]
  set par(justify: false)
  bibliography(zrodla-internetowe, title: none, style: "/szablon/style/ans-harvard.csl")
}

#let spis-tresci() = {
  heading(level: 1, numbering: none, outlined: false)[Spis treści]
  outline(title: none, depth: 3)
}

#let _spis(tytul, cel) = context {
  if query(cel).len() > 0 {
    heading(level: 1, numbering: none)[#tytul]
    outline(title: none, target: cel)
  }
}

#let spis-tabel() = _spis([Spis tabel], figure.where(kind: table))
#let spis-rysunkow() = _spis([Spis rysunków], figure.where(kind: image))
#let spis-zalacznikow() = _spis([Spis załączników], figure.where(kind: "zalacznik"))

// --- dokument --------------------------------------------------------------

#let praca(
  tytul: "Tytuł pracy dyplomowej",
  autor: "Imię Nazwisko",
  kierunek: "nazwa kierunku",
  nr-albumu: "000000",
  promotor: "tytuł Imię Nazwisko",
  wydzial: "Wydział Nauk Inżynieryjnych",
  miejscowosc: "Nowy Sącz",
  rok: "2026",
  body,
) = {
  set document(title: tytul, author: autor)
  set text(
    lang: "pl",
    region: "pl",
    font: font-serif,
    size: 12pt,
    fill: black,
    hyphenate: true,
  )
  // Pojedyncze spójniki nie zostają na końcu wiersza.
  show regex("\\b[aiouwzAIOUWZ] "): it => it.text.replace(" ", "\u{00A0}")

  // Strona tytułowa i pusta strona odwrotna (druk dwustronny).
  // Spis treści wypada wtedy na stronie 3.
  set page(
    paper: "a4",
    binding: left,
    margin: (inside: 3cm, outside: 2cm, top: 2cm, bottom: 2cm),
    header: none,
    footer: none,
    numbering: none,
  )

  strona-tytulowa(
    tytul,
    autor,
    kierunek,
    nr-albumu,
    promotor,
    wydzial,
    miejscowosc,
    str(rok),
  )
  pagebreak()
  pagebreak()

  set page(
    footer: context {
      set text(size: 10pt, weight: "regular")
      align(right, counter(page).display("1"))
    },
  )

  set text(top-edge: wiersz-gora, bottom-edge: wiersz-dol)
  set par(
    leading: interlinia,
    spacing: interlinia,
    justify: true,
    first-line-indent: (amount: 0.75cm, all: true),
    linebreaks: "optimized",
  )
  set heading(numbering: "1.1.1")
  set outline(depth: 3, indent: auto)
  set figure(numbering: "1", gap: 0.6em)
  set figure.caption(separator: [. ])
  set math.equation(numbering: "(1)", supplement: [])
  set list(indent: 0.75cm, body-indent: 0.45em, spacing: interlinia, marker: ([•], [–], [·]))
  set enum(indent: 0.75cm, body-indent: 0.45em, spacing: interlinia, numbering: "1)")
  set table(stroke: 0.5pt, inset: (x: 6pt, y: 2pt), align: center)
  set quote(block: true)
  set smartquote(quotes: "„”", alternative: true)
  set bibliography(title: none, style: "/szablon/style/ans-harvard.csl")

  show link: set text(fill: black)
  show ref: set text(fill: black)
  show heading: set text(hyphenate: false)
  show heading: set par(first-line-indent: 0pt, justify: false, hanging-indent: 0pt)
  show heading.where(level: 1): set text(size: 16pt, weight: "bold")
  // Odstęp przed i po tytule dodaje się do zwykłej interlinii, jak w edytorze tekstu.
  show heading.where(level: 1): set block(above: interlinia + 12pt, below: interlinia + 12pt, sticky: true)
  show heading.where(level: 2): set text(size: 14pt, weight: "bold")
  show heading.where(level: 2): set block(above: interlinia + 6pt, below: interlinia + 6pt, sticky: true)
  show heading.where(level: 3): set text(size: 14pt, weight: "bold")
  show heading.where(level: 3): set block(above: interlinia + 6pt, below: interlinia + 6pt, sticky: true)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  show outline: set text(size: 12pt)
  show outline.entry: set par(
    first-line-indent: 0pt,
    justify: false,
    leading: interlinia,
    spacing: interlinia,
  )
  show outline.entry: set block(above: interlinia, below: interlinia)
  // Wykazy rysunków, tabel i załączników: 11 pkt. Po numerze rysunku kropka.
  show outline.entry: it => {
    if it.element.func() != figure {
      it
    } else {
      let rodzaj = it.element.kind
      let prefix = if rodzaj == image or rodzaj == "zalacznik" {
        [#it.prefix().]
      } else {
        it.prefix()
      }
      set text(size: 11pt)
      set par(leading: interlinia, spacing: interlinia, first-line-indent: 0pt)
      link(it.element.location(), it.indented(prefix, it.inner()))
    }
  }

  show footnote.entry: set text(size: 10pt)
  show footnote.entry: set par(
    leading: interlinia-pojedyncza,
    spacing: interlinia-pojedyncza,
    first-line-indent: 0pt,
    justify: false,
  )

  show raw: set text(font: font-mono, size: 10pt)
  show raw.where(block: true): it => {
    set par(leading: interlinia-pojedyncza, spacing: interlinia-pojedyncza, first-line-indent: 0pt, justify: false)
    set text(hyphenate: false)
    block(
      width: 100%,
      inset: (x: 8pt, y: 6pt),
      fill: luma(247),
      stroke: 0.4pt + luma(170),
      breakable: true,
      above: wolna-linia,
      below: wolna-linia,
      it,
    )
  }

  show math.equation.where(block: true): set block(above: wolna-linia, below: wolna-linia)
  show math.equation: set text(weight: "regular")

  show figure.where(kind: image): it => {
    set par(first-line-indent: 0pt, justify: false, leading: interlinia-pojedyncza, spacing: interlinia-pojedyncza)
    let nawias-l = "\u{005B}"
    let nawias-p = "\u{005D}"
    block(above: wolna-linia, below: wolna-linia, breakable: false)[
      #align(center, it.body)
      #v(6pt)
      #align(center)[
        #text(size: 11pt)[
          Rysunek
          #context counter(figure.where(kind: image)).display().
          #it.caption.body
        ]
      ]
      #context {
        let n = counter(figure.where(kind: image)).get().first()
        let lista = zrodla-rys.get()
        if n > 0 and n <= lista.len() and lista.at(n - 1) != none {
          let podpis = [źródło: #lista.at(n - 1)]
          align(center, text(size: 10pt, style: "italic")[#nawias-l#podpis#nawias-p])
        }
      }
    ]
  }

  // Długa tabela może przejść na kolejną stronę; nagłówek powtarza `table.header`.
  show figure.where(kind: table): set block(breakable: true)
  show figure.where(kind: table): it => {
    set par(first-line-indent: 0pt, justify: false, leading: interlinia-pojedyncza, spacing: interlinia-pojedyncza)
    block(above: wolna-linia, below: wolna-linia)[
      #align(right, text(size: 11pt)[
        Tabela #context counter(figure.where(kind: table)).display() \
        #it.caption.body
      ])
      #v(6pt)
      #align(center)[#it.body]
    ]
  }

  show figure.where(kind: "zalacznik"): it => {
    pagebreak(weak: true)
    set text(size: 16pt, weight: "bold", hyphenate: false)
    set par(first-line-indent: 0pt, justify: false)
    block(above: interlinia + 12pt, below: interlinia + 12pt, sticky: true)[
      Załącznik #context counter(figure.where(kind: "zalacznik")).display(). #it.caption.body
    ]
  }

  show bibliography: set par(
    justify: false,
    first-line-indent: 0pt,
    leading: interlinia,
    spacing: interlinia,
  )
  show bibliography: set text(size: 12pt)

  show table: set text(size: 10pt, weight: "regular")
  show list: set par(first-line-indent: 0pt)
  show enum: set par(first-line-indent: 0pt)

  body
}
