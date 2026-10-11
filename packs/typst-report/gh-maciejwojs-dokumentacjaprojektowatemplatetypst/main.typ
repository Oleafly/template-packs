// Dokumentacja projektowa — plik główny.
// Kompilacja: typst compile main.typ
//
// Dane projektu są argumentami `praca`. Nagłówek, stopka i strona tytułowa
// powstają z nich w szablonie. Rozdziały: praca/<rozdzial>/rozdzial.typ.
// Bibliografia: praca/literatura.bib.
// Listing z pliku: #listing([Opis], plik: "/kod/plik.cpp", jezyk: "cpp") <etykieta>

#import "szablon/template.typ": (
  praca, spis-tresci, bibliografia, spis-rysunkow, spis-tabel, spis-listingow,
)

// Tylko różnice wobec domyślnych. `dokument` to „DOKUMENTACJA PROJEKTU”.
// Stronnicowanie: "n-z-n" albo "prosty".
#let knobs = (
  stronnicowanie: "prosty",
  kod: (
    numeracja: false,
    ramka: true,
    kolor-ramki: rgb("#000000"),
  ),
)

#show: praca.with(
  tytul: [Tytul projektu\ z zastosowaniem GitHub...],
  przedmiot: [ZESPOŁOWE PRZEDSIĘWZIĘCIE INŻYNIERSKIE],
  autorzy: (
    "Imie Nazwisko",
    "Imie2 Nazwisko2",
    "Imie3 Nazwisko",
  ),
  prowadzacy: [mgr inż. Jan Kowalski],
  knobs: knobs,
)

#spis-tresci()

#include "praca/01-wymagania/rozdzial.typ"
#include "praca/02-analiza/rozdzial.typ"
#include "praca/03-projektowanie/rozdzial.typ"
#include "praca/04-implementacja/rozdzial.typ"
#include "praca/05-wnioski/rozdzial.typ"

#bibliografia()
#spis-rysunkow()
#spis-tabel()
#spis-listingow()
