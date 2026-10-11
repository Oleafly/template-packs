// Praca dyplomowa — plik główny.
// Kompilacja: typst compile main.typ
//
// Uzupełnij dane na stronie tytułowej, potem edytuj rozdziały w praca/.
// Każdy rozdział: praca/<rozdzial>/rozdzial.typ oraz praca/<rozdzial>/sources/.
// Obraz z rozdziału: #rysunek(image("sources/nazwa.png", width: 12cm), [Tytuł]) <etykieta>
// Ścieżka sources/ jest liczona od pliku rozdziału, nie od main.typ.
// Szablon składu jest w szablon/, bibliografia w praca/literatura.bib.
// Streszczenie i słowa kluczowe trafiają do ASAP, nie do tego pliku.
// Egzemplarz archiwalny drukuje się dwustronnie, bez oprawy.

#import "szablon/template.typ": (
  praca, bibliografia, spis-tresci, spis-tabel, spis-rysunkow, spis-zalacznikow,
)

#show: praca.with(
  tytul: "Tytuł pracy dyplomowej",
  autor: "Jan Kowalski",
  kierunek: "Informatyka",
  nr-albumu: "12345",
  promotor: "dr inż. Anna Nowak",
  wydzial: "Wydział Nauk Inżynieryjnych",
  miejscowosc: "Nowy Sącz",
  rok: "2026",
)

#spis-tresci()

#include "praca/wstep/rozdzial.typ"
#include "praca/01-przeglad/rozdzial.typ"
#include "praca/02-cel-i-zakres/rozdzial.typ"
#include "praca/03-metodyka/rozdzial.typ"
#include "praca/04-podsumowanie/rozdzial.typ"

#bibliografia()
#spis-tabel()
#spis-rysunkow()
#spis-zalacznikow()

#include "praca/zalaczniki/01-pomiary/zalacznik.typ"
