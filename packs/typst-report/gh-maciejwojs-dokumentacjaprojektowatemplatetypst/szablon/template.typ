// Wejście szablonu. Rozdziały importują ten plik.
// Import z innego pliku nie jest widoczny na zewnątrz, więc nazwy są tu powtórzone.
//
// czesci/wspolne.typ — czcionki i knobs
// czesci/strona.typ — strona tytułowa, nagłówek, stopka
// czesci/kod.typ — blok kodu
// czesci/obiekty.typ — rysunek, tabela, listing, odsyłacz
// czesci/spisy.typ — spis treści, literatura, spisy obiektów
// czesci/praca.typ — marginesy, numeracja i reguły dokumentu

#import "czesci/wspolne.typ" as wspolne
#import "czesci/strona.typ" as strona
#import "czesci/kod.typ" as kod
#import "czesci/obiekty.typ" as obiekty
#import "czesci/spisy.typ" as spisy
#import "czesci/praca.typ" as dokument

#let font-sans = wspolne.font-sans
#let font-mono = wspolne.font-mono
#let knobs-domyslne = wspolne.knobs-domyslne
#let stan-knobs = wspolne.stan-knobs

#let naglowek = strona.naglowek
#let stopka = strona.stopka
#let strona-tytulowa = strona.strona-tytulowa

#let blok-kodu = kod.blok-kodu

#let rysunek = obiekty.rysunek
#let tabela = obiekty.tabela
#let listing = obiekty.listing
#let listing-plik = obiekty.listing-plik
#let odnosnik = obiekty.odnosnik
#let numer-w-sekcji = obiekty.numer-w-sekcji

#let spis-tresci = spisy.spis-tresci
#let bibliografia = spisy.bibliografia
#let spis-rysunkow = spisy.spis-rysunkow
#let spis-tabel = spisy.spis-tabel
#let spis-listingow = spisy.spis-listingow

#let praca = dokument.praca
