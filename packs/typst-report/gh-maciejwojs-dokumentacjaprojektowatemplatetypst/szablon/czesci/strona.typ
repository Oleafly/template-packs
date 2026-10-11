// Strona tytułowa, nagłówek i stopka.

#import "wspolne.typ": font-sans, stan-knobs

#let _miesiace = (
  "stycznia", "lutego", "marca", "kwietnia", "maja", "czerwca",
  "lipca", "sierpnia", "września", "października", "listopada", "grudnia",
)

#let _dzisiaj() = {
  let d = datetime.today()
  [#d.day() #_miesiace.at(d.month() - 1) #d.year()]
}

#let _linie(wartosc) = {
  if type(wartosc) == array { wartosc } else { (wartosc,) }
}

#let w-linii(wartosc) = {
  let linie = _linie(wartosc)
  let wynik = ()
  for (i, linia) in linie.enumerate() {
    if i > 0 { wynik.push[ ] }
    wynik.push(linia)
  }
  wynik.join()
}

#let _pod-soba(wartosc) = {
  let linie = _linie(wartosc)
  for (i, linia) in linie.enumerate() {
    if i > 0 { linebreak() }
    linia
  }
}

#let bez-pustych(lista) = lista.filter(a => a.trim() != "")

// Kursywa na środku i linia 0,4 pt.
#let naglowek(tekst) = {
  set text(font: font-sans, size: 10pt, style: "italic", hyphenate: false)
  set par(leading: 0.2em, spacing: 0pt, first-line-indent: 0pt, justify: false)
  align(center, tekst)
  v(0.35em)
  line(length: 100%, stroke: 0.4pt)
}

// `sposob`: "prosty" albo "n-z-n". Wołać wewnątrz `context`.
#let _numer-strony(sposob) = {
  let biezacy = counter(page).display()
  if sposob == "prosty" {
    biezacy
  } else if sposob == "n-z-n" or sposob == "n z N" {
    [#biezacy z #counter(page).final().first()]
  } else {
    panic("Nieznany sposób stronnicowania: " + str(sposob) + ". Użyj \"prosty\" albo \"n-z-n\".")
  }
}

// `stronnicowanie`: "prosty" (sam numer) albo "n-z-n". `auto` bierze wartość z knobs.
#let stopka(opis, stronnicowanie: auto) = {
  set text(font: font-sans, hyphenate: false)
  set par(leading: 0.15em, spacing: 0pt, first-line-indent: 0pt, justify: false)
  line(length: 100%, stroke: 0.4pt)
  v(0.35em)
  align(center)[
    #text(size: 10pt)[#opis]
    #v(0.2em)
    #context {
      let sposob = if stronnicowanie == auto {
        stan-knobs.get().stronnicowanie
      } else {
        stronnicowanie
      }
      text(size: 12pt, _numer-strony(sposob))
    }
  ]
}

#let strona-tytulowa(
  uczelnia: ([AKADEMIA NAUK STOSOWANYCH], [W NOWYM SĄCZU]),
  wydzial: [Wydział Nauk Inżynieryjnych],
  katedra: [Katedra Informatyki],
  rodzaj: [DOKUMENTACJA PROJEKTOWA],
  przedmiot: [ZESPOŁOWE PRZEDSIĘWZIĘCIE INŻYNIERSKIE],
  tytul: [Tytul projektu],
  autorzy: (),
  prowadzacy: [mgr inż. Nikodem Bulanda],
  miejscowosc: [Nowy Sącz],
  rok: auto,
  draft: false,
) = {
  set par(leading: 0.35em, spacing: 0.45em, first-line-indent: 0pt, justify: false)
  set text(hyphenate: false)
  let osoby = bez-pustych(autorzy)
  let rok-napis = if rok == auto { str(datetime.today().year()) } else { rok }

  v(0.5in)
  align(center, text(size: 20.74pt, _pod-soba(uczelnia)))
  v(0.55in)
  align(center, text(size: 14.4pt)[#wydzial \ #katedra])
  v(0.6in)
  align(center)[
    #text(size: 24.88pt)[#rodzaj]
    #v(0.2em)
    #text(size: 14.4pt)[#przedmiot]
  ]
  v(0.8in)
  align(center, text(size: 17.28pt, weight: "bold", tytul))

  if draft {
    v(0.6em)
    align(center)[
      #rect(inset: (x: 14pt, y: 8pt), stroke: 0.8pt)[
        #align(center)[
          #text(size: 17pt)[UWAGA -- TO JEST DRAFT]
          #v(0.45em)
          #text(size: 14pt)[Wydruk z #_dzisiaj()]
        ]
      ]
    ]
  }

  v(1fr)
  align(right)[
    #block(width: auto)[
      #set align(left)
      #set par(leading: 0.45em, spacing: 0.2em)
      #text(size: 14.4pt)[Autorzy:]
      #for osoba in osoby [
        #linebreak()
        #text(size: 14.4pt)[#osoba]
      ]
      #v(1.1em)
      #text(size: 12pt)[Prowadzący:]
      #linebreak()
      #text(size: 12pt)[#prowadzacy]
    ]
  ]
  v(0.75in)
  align(center, text(size: 14.4pt)[#miejscowosc #rok-napis])
}
