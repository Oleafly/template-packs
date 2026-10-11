// Marginesy, czcionka, numeracja i reguły całego dokumentu.

#import "wspolne.typ": font-sans, font-mono, knobs-domyslne, polacz, stan-knobs
#import "strona.typ": bez-pustych, naglowek, stopka, strona-tytulowa, w-linii
#import "kod.typ": kod-w-akapicie
#import "obiekty.typ": numer-w-sekcji, pokaz-figure

#let praca(
  uczelnia: ([AKADEMIA NAUK STOSOWANYCH], [W NOWYM SĄCZU]),
  wydzial: [Wydział Nauk Inżynieryjnych],
  katedra: [Katedra Informatyki],
  rodzaj: [DOKUMENTACJA PROJEKTOWA],
  dokument: [DOKUMENTACJA PROJEKTU],
  przedmiot: [ZESPOŁOWE PRZEDSIĘWZIĘCIE INŻYNIERSKIE],
  tytul: [Tytul projektu\ z zastosowaniem GitHub...],
  autorzy: (
    "Imie Nazwisko",
    "Imie2 Nazwisko2",
    "Imie3 Nazwisko",
    "Imie4 Nazwisko3",
    "Imie5 Nazwisko4",
  ),
  prowadzacy: [mgr inż. Nikodem Bulanda],
  miejscowosc: [Nowy Sącz],
  rok: auto,
  draft: false,
  nazwa-rysunku: [Rys.],
  nazwa-tabeli: [Tab.],
  nazwa-listingu: [Listing],
  knobs: (:),
  body,
) = {
  let ustawienia = polacz(knobs-domyslne, knobs)
  stan-knobs.update(ustawienia)
  let kolor-linku = ustawienia.kolor-linku
  let osoby = bez-pustych(autorzy)

  set document(
    title: if type(tytul) == str { tytul } else { "Dokumentacja projektowa" },
    author: osoby.join(", "),
  )
  set text(lang: "pl", region: "pl", font: font-sans, size: 12pt, fill: black, hyphenate: true)

  set page(
    paper: "a4",
    binding: left,
    margin: (inside: 3.5cm, outside: 2.5cm, top: 2.5cm, bottom: 2.5cm),
    header: none,
    footer: none,
    numbering: none,
  )

  strona-tytulowa(
    uczelnia: uczelnia,
    wydzial: wydzial,
    katedra: katedra,
    rodzaj: rodzaj,
    przedmiot: przedmiot,
    tytul: tytul,
    autorzy: autorzy,
    prowadzacy: prowadzacy,
    miejscowosc: miejscowosc,
    rok: rok,
    draft: draft,
  )
  pagebreak()

  set page(
    header: naglowek(w-linii(uczelnia)),
    footer: stopka(
      [#dokument - #przedmiot],
      stronnicowanie: ustawienia.stronnicowanie,
    ),
  )

  set par(
    leading: 6.85pt,
    spacing: 3pt,
    justify: true,
    first-line-indent: (amount: 1.5em, all: false),
    linebreaks: "optimized",
  )
  set heading(numbering: "1.1.1.1.")
  set outline(depth: 4, indent: auto)
  set figure(numbering: numer-w-sekcji, gap: 0.65em)
  set math.equation(numbering: n => context {
    let rozdzial = counter(heading).get().first()
    numbering("(1.1)", rozdzial, n)
  })
  set table(stroke: 0.5pt, inset: (x: 6pt, y: 4pt), align: center)
  set list(indent: 1.5em, body-indent: 0.5em, spacing: 3pt)
  set enum(indent: 1.5em, body-indent: 0.5em, spacing: 3pt, numbering: "1)")
  set footnote.entry(separator: line(length: 4cm, stroke: 0.4pt))
  set bibliography(title: none, style: "ieee")
  set smartquote(quotes: "„”", alternative: true)

  show link: it => if kolor-linku == none { it } else { text(fill: kolor-linku, it) }
  show ref: it => if kolor-linku == none { it } else { text(fill: kolor-linku, it) }
  show cite: it => if kolor-linku == none { it } else { text(fill: kolor-linku, it) }

  show heading: set text(font: font-sans, weight: "bold", hyphenate: false)
  show heading: set par(first-line-indent: 0pt, justify: false)
  show heading.where(level: 1): set text(size: 17.28pt)
  show heading.where(level: 1): set block(above: 14pt, below: 10pt, sticky: true)
  show heading.where(level: 2): set text(size: 14.4pt)
  show heading.where(level: 2): set block(above: 10pt, below: 6pt, sticky: true)
  show heading.where(level: 3): set text(size: 12pt)
  show heading.where(level: 3): set block(above: 8pt, below: 4pt, sticky: true)
  show heading.where(level: 4): set text(size: 12pt)
  show heading.where(level: 4): set block(above: 8pt, below: 4pt, sticky: true)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    if it.numbering != none {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: "listing")).update(0)
      counter(math.equation).update(0)
    }
    it
  }

  show outline: set text(size: 12pt, font: font-sans)
  show outline.entry: set par(first-line-indent: 0pt, justify: false, leading: 0.45em, spacing: 0pt)
  show outline.entry: set block(above: 3pt, below: 3pt)
  show outline.entry: it => {
    let naglowek-rozdzialu = it.element.func() == heading and it.level == 1
    let figura = it.element.func() == figure
    set text(weight: if naglowek-rozdzialu { "bold" } else { "regular" })
    let prefix = if figura {
      context {
        let loc = it.element.location()
        let rodzaj = it.element.kind
        let roz = counter(heading).at(loc).first()
        let n = counter(figure.where(kind: rodzaj)).at(loc).first()
        let nazwa = if rodzaj == image {
          nazwa-rysunku
        } else if rodzaj == table {
          nazwa-tabeli
        } else {
          nazwa-listingu
        }
        [#nazwa #roz.#n]
      }
    } else {
      it.prefix()
    }
    if naglowek-rozdzialu { v(5pt) }
    link(it.element.location(), it.indented(prefix, it.inner()))
  }

  show footnote.entry: set text(size: 10pt)
  show footnote.entry: set par(leading: 0.35em, spacing: 0.3em, first-line-indent: 0pt, justify: false)

  show raw.where(block: true): set text(font: font-mono, size: 1em)
  show raw.where(block: false): it => kod-w-akapicie(it.text)
  show math.equation.where(block: true): set block(above: 12pt, below: 12pt)
  show math.equation: set text(weight: "regular")

  show figure.where(kind: image): it => pokaz-figure(it, nazwa-rysunku, podpis-nad: false)
  show figure.where(kind: table): it => pokaz-figure(it, nazwa-tabeli, podpis-nad: true)
  show figure.where(kind: "listing"): it => pokaz-figure(it, nazwa-listingu, podpis-nad: false)

  show bibliography: set par(justify: false, first-line-indent: 0pt, leading: 0.45em, spacing: 0.65em)
  show bibliography: set text(size: 12pt, fill: black)
  show list: set par(first-line-indent: 0pt)
  show enum: set par(first-line-indent: 0pt)

  body
}
