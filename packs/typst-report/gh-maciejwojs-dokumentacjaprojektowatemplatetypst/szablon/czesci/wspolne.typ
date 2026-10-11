// Czcionki i przełączniki wspólne dla całego szablonu.

#let font-sans = ("Liberation Sans")
#let font-mono = ("Liberation Mono", "DejaVu Sans Mono", "Courier New")

// W main.typ można podać tylko zmieniane pola.
#let knobs-domyslne = (
  stronnicowanie: "n-z-n",
  kolor-linku: none,
  kod: (
    numeracja: true,
    tlo: rgb("#f2f2eb"),
    kolor-tekstu: black,
    kolor-numeru: rgb("#808080"),
    kolor-slowa: rgb("#0000ff"),
    kolor-komentarza: rgb("#009900"),
    kolor-napisu: rgb("#9400d1"),
    ramka: false,
    kolor-ramki: rgb("#aaaaaa"),
  ),
)

#let stan-knobs = state("zpi-knobs", knobs-domyslne)

#let polacz(bazowe, nadpisane) = {
  let wynik = bazowe
  for (klucz, wartosc) in nadpisane.pairs() {
    if (
      type(wartosc) == dictionary
        and klucz in bazowe
        and type(bazowe.at(klucz)) == dictionary
    ) {
      wynik.insert(klucz, polacz(bazowe.at(klucz), wartosc))
    } else {
      wynik.insert(klucz, wartosc)
    }
  }
  wynik
}
