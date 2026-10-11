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

#let _ramka-draft() = align(center)[
  #rect(inset: (x: 14pt, y: 8pt), stroke: 0.8pt)[
    #align(center)[
      #text(size: 17pt)[UWAGA -- TO JEST DRAFT]
      #v(0.45em)
      #text(size: 14pt)[Wydruk z #_dzisiaj()]
    ]
  ]
]

// Zwykły napis z treści Typsta, do metadanych PDF.
#let jako-tekst(wartosc) = {
  if wartosc == none or wartosc == auto { return "" }
  let rodzaj = type(wartosc)
  if rodzaj == str { return wartosc }
  if rodzaj == int or rodzaj == float or rodzaj == version { return str(wartosc) }
  if rodzaj == array {
    return wartosc.map(jako-tekst).filter(s => s.trim() != "").join(" ")
  }
  if rodzaj != content { return "" }
  let pola = wartosc.fields()
  if "text" in pola and type(pola.text) == str { return pola.text }
  if "children" in pola {
    let wynik = ""
    for dziecko in pola.children {
      let kawalek = jako-tekst(dziecko)
      if kawalek == "" {
        if wynik.len() > 0 and not wynik.ends-with(" ") { wynik += " " }
      } else {
        wynik += kawalek
      }
    }
    return wynik
  }
  if "body" in pola { return jako-tekst(pola.body) }
  if "child" in pola { return jako-tekst(pola.child) }
  ""
}

// Zapis przedmiotu na stronie tytułowej: "mala" albo "pierwsza".
#let _przedmiot-na-stronie(przedmiot, zapis) = {
  let tekst = jako-tekst(przedmiot).trim()
  if zapis == "mala" {
    lower(tekst)
  } else if zapis == "pierwsza" {
    let maly = lower(tekst)
    if maly.len() == 0 { maly } else { upper(maly.at(0)) + maly.slice(1) }
  } else {
    panic(
      "Nieznany zapis przedmiotu: " + str(zapis) + ". Użyj \"mala\" albo \"pierwsza\".",
    )
  }
}

#let _strona-rich(
  uczelnia,
  wydzial,
  katedra,
  rodzaj,
  przedmiot,
  tytul,
  osoby,
  prowadzacy,
  miejscowosc,
  rok-napis,
  draft,
) = {
  v(1.2cm)
  align(center, text(size: 16pt, _pod-soba(uczelnia)))
  v(0.6cm)
  align(center, text(size: 12pt)[#wydzial \ #katedra])
  v(1.1cm)
  align(center)[
    #text(size: 18pt, weight: "bold")[#rodzaj]
    #v(0.35em)
    #text(size: 12pt)[#przedmiot]
  ]
  v(0.9cm)
  align(center, text(size: 14pt, weight: "bold", tytul))

  if draft {
    v(0.6em)
    _ramka-draft()
  }

  v(1.4cm)
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
  v(1.2cm)
  align(center, text(size: 12pt)[#miejscowosc #rok-napis])
}

#let _wiersze-proste = (
  ([Uczelnia], "uczelnia"),
  ([Wydział], "wydzial"),
  ([Katedra], "katedra"),
  ([Rodzaj], "rodzaj"),
  ([Przedmiot], "przedmiot"),
  ([Tytuł], "tytul"),
  ([Autorzy], "autorzy"),
  ([Prowadzący], "prowadzacy"),
  ([Miejscowość], "miejscowosc"),
  ([Rok], "rok"),
)

#let _wartosc-komorki(dane, wartosc) = {
  if type(wartosc) == str and wartosc in dane {
    dane.at(wartosc)
  } else if type(wartosc) == array {
    let czesci = wartosc.map(w => _wartosc-komorki(dane, w))
    for (i, czesc) in czesci.enumerate() {
      if i > 0 { linebreak() }
      czesc
    }
  } else {
    wartosc
  }
}

#let _tabela-z-wierszy(wiersze, dane) = {
  let komorki = ()
  for wiersz in wiersze {
    komorki.push(text(weight: "bold", wiersz.at(0)))
    komorki.push(_wartosc-komorki(dane, wiersz.at(1)))
  }
  table(
    columns: (4.5cm, 1fr),
    align: (right + horizon, left + horizon),
    inset: (x: 8pt, y: 6pt),
    stroke: 0.5pt,
    ..komorki,
  )
}

// `tabela`: auto, lista wierszy albo funkcja `(dane) => table(...)`.
#let _strona-prosta(dane, tabela, draft) = {
  v(1fr)
  align(center)[
    #if type(tabela) == function {
      tabela(dane)
    } else {
      let wiersze = if tabela == auto { _wiersze-proste } else { tabela }
      _tabela-z-wierszy(wiersze, dane)
    }
  ]
  if draft {
    v(0.8em)
    _ramka-draft()
  }
  v(2fr)
}

#let strona-tytulowa(
  uczelnia: ([AKADEMIA NAUK STOSOWANYCH], [W NOWYM SĄCZU]),
  wydzial: [Wydział Nauk Inżynieryjnych],
  katedra: [Katedra Informatyki],
  rodzaj: [SPRAWOZDANIE],
  dokument: [SPRAWOZDANIE],
  przedmiot: [ZESPOŁOWE PRZEDSIĘWZIĘCIE INŻYNIERSKIE],
  tytul: [Tytul projektu],
  autorzy: (),
  prowadzacy: [mgr inż. Nikodem Bulanda],
  miejscowosc: [Nowy Sącz],
  rok: auto,
  draft: false,
  sposob: "rich",
  tabela: auto,
  przedmiot-zapis: "pierwsza",
) = {
  set par(leading: 0.35em, spacing: 0.45em, first-line-indent: 0pt, justify: false)
  set text(hyphenate: false)
  let osoby = bez-pustych(autorzy)
  let rok-napis = if rok == auto { str(datetime.today().year()) } else { rok }
  let przedmiot-napis = _przedmiot-na-stronie(przedmiot, przedmiot-zapis)

  if sposob == "rich" {
    _strona-rich(
      uczelnia,
      wydzial,
      katedra,
      rodzaj,
      przedmiot-napis,
      tytul,
      osoby,
      prowadzacy,
      miejscowosc,
      rok-napis,
      draft,
    )
  } else if sposob == "prosty" {
    let dane = (
      uczelnia: w-linii(uczelnia),
      wydzial: wydzial,
      katedra: katedra,
      rodzaj: rodzaj,
      dokument: dokument,
      przedmiot: przedmiot-napis,
      tytul: tytul,
      autorzy: {
        for (i, osoba) in osoby.enumerate() {
          if i > 0 { linebreak() }
          osoba
        }
      },
      prowadzacy: prowadzacy,
      miejscowosc: miejscowosc,
      rok: rok-napis,
    )
    _strona-prosta(dane, tabela, draft)
  } else {
    panic("Nieznana strona tytułowa: " + str(sposob) + ". Użyj \"rich\" albo \"prosty\".")
  }
}
