// importy funkcji pomocniczych, strony tytułowej
// można dodatkowo zaimportować funkcje
// #large, #Large, #LARGE i #huge itp. odpowiadające tym z LaTeXa.
// Użycie: #large[Tekst do wpisania]

#import "helper.typ":  title_page, doublepagebreak, noindent, pagesetup, startnumbering

// Tu można zmienić font i jego wielkość
/*
Tex gyre heros - hevletica
Tex gyre termes - times new roman
tex gyre cursor - courier
*/
#set text(
  lang:"pl",
  font: "TeX Gyre Heros",
  size: 12pt,
)
// Ustawienia strony, paragrafów etc.
#show: pagesetup


// Funkcja strony tytułowej, proszę uzupełnić swoimi danymi.
#title_page(
  type: "magisterska/inżynierska",
  name: "Imię i nazwisko",
  title_pl: "Tytuł po polsku",
  title_en: "Tytuł po angielsku",
  index: 123456,
  degree: "Informatyka",
  form: "stacjonarne / niestacjonarne",
  level: "I/II",
  supervisor: "Imię i nazwisko promotora"
)

#show: startnumbering //reset licznika, numeracja od spisu treści
#outline(depth: 2) //spis treści, bez nagłówków trzeciego stopnia
#doublepagebreak() // strona tytułowa zacznie się od prawej strony
#set heading(numbering: "1.1") // włączenie numerowania

= Wstęp

[Wstęp powinien przedstawiać ogólne informacje na temat, którego dotyczy praca, historię  i zakres zastosowań. We wstępie nie powinno być rysunków, tabel i wzorów. Przykład poniżej]
W ostatnim czasie obserwuje się intensywny rozwój [tutaj proszę podać ogólne wprowadzenie do tematu pracy]. Niestety [tutaj proszę wpisać wady i niedogodności istniejącego rozwiązania (oprogramowania/metody/ urządzenia/projektu).]. W związku z powyższym, ciekawym wydaje się [tutaj proszę wpisać nawiązanie do tematu (porównanie, opracowanie, itd.)].

= Cel pracy i zakres pracy

== Cel pracy
[Pierwszy akapit dotyczy sformułowania problematyki i dziedziny pracy. W drugi akapicie opisuje się część teoretyczną – jej cele, a w trzecim  części praktycznej. Przykład poniżej.]

Celem niniejszej pracy jest [Proszę opisać krótko cel przewodni części praktycznej, np. analiza istniejących metod i technik, eksperymentalne badania różnych rozwiązań, zaprojektowanie i wykonanie programu lub systemu komputerowego].

== Zakres pracy

Zakres pracy obejmuje:

- zebranie wiadomości z zakresu [Proszę wpisać tematykę],
- porównanie [Proszę wpisać jakie istniejące rozwiązania jakie porównano],
- opracowanie [Proszę wpisać co opracowano w pracy], 
- realizację [Proszę wpisać co zrealizowano w pracy].


W rozdziale 1 pracy opisano... . Rozdział drugi zawiera natomiast....

// można rozdziały podzielić na pojedyncze pliki.
= Przegląd dostępnych rozwiązań

[Każdy rozdział powinien mieć zdanie wstępu przed przejściem do podrozdziału. Rysunki powinny być wyśrodkowane, numerowane i powinny mieć odwołania do literatury lub oznaczenie że zostały opracowane samodzielnie.]


#figure(
  image("images/logo_wimii.png", width: 70%),
  kind: image,
  caption: [Logo Wydziału Inżynierii Mechanicznej i Informatyki ],
  //placement: auto, // można dać lub nie w zależności jak ułoży się tekst., jak widać w tym przypadku nie warto.
) <fig:logo>

#figure(
  image("images/logo_wimii.png", width: 70%),
  kind: image,
  caption: [Logo Wydziału Inżynierii Mechanicznej i Informatyki ]
) <fig:logo2>

Kod umożliwiający wstawienie rysunku pokazano na @lis:rysunek

#figure(
  ```typst
#figure(
  image("images/logo_wimii.png", width: 70%),
  kind: image,
  caption: [Logo Wydziału Inżynierii Mechanicznej i Informatyki ]
) <fig:logo>
  ```,
  kind: "code",
  caption: [Wstawienie rysunku]
) <lis:rysunek>

Do dowolnego rysunku można się odwołać w tekście (np. "na Rysunku @fig:logo[] widać" lub "@fig:logo przedstawia") 

#figure(
  ```
  (np. "na Rysunku @fig:logo[] widać" lub "@fig:logo przedstawia") 
  ```,
  kind: "code",
  caption: [Odwołanie do rysunku]
)

Tabele muszą mieć podpis i numerację u góry:
#figure(  
  table(
    columns: 3,
    table.header([A], [B], [C]),
    [1], [2], [3],
    [4], [5], [6],
  ),
  kind: table,
  caption: [Przykładowa tabela]
) <tab:przykladowa>

Kod umożliwiający wstawienie tabeli pokazano w Kodzie @lis:tabela[].

#figure(
```
#figure(  
  table(
    columns: 3,
    table.header([A], [B], [C]),
    [1], [2], [3],
    [4], [5], [6],
  ),
  kind: table,
  caption: [Przykładowa tabela]
) <tab:przykladowa>
```,
  kind: "code",
  caption: [Wstawienie tabeli]
) <lis:tabela>

Wzory powinny mieć numerację
$ e = m c^2 $

Kod umożliwiający wstawienie wzoru w Kodzie @lis:wzor[].

#figure(
  ```
$ e = m c^2 $
  ```,
  kind:"code",
  caption: [Wstawienie wzoru]
) <lis:wzor>

Odwołania do literatury umieszcza się następująco: @handmade-ohp, a same pozycje literatury należy umieścić
w pliku .bib lub #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md")[.yaml]. Proszę o zapoznanie się z różnymi przykładami(linki, artykuły, książki) w pliku bibliography.bib.

#figure(
  ```
@Article{overhead-usage,
    title={Overhead projector use in televising geography},
    author={David E. Christensen},
    DOI={10.1080/00221346408985098},
    date={1964-10},
    journal={Journal of Geography},
    pages={319-322},
    volume={63},
    number={7},
    year={1964}
}
  ```,
  kind: "code",
  caption: [Dodanie artykułu do listy lektur]
)

#noindent[Cytowanie powinno wyglądać w sposób następujący @slp-made @powerpoint-1987.]

#noindent[Każda lista punktowana powinna wyglądać następująco:]

- każdy punkt powinien rozpoczynać się z małej litery,
- każdy punkt oprócz ostatniego powinien kończyć się przecinkiem,
- ostatni punkt powinien kończyć się kropką.

Każda lista numerowana powinna wyglądać następująco:

+ Każdy punkt powinien rozpoczynać się z wielkiej litery.
+ Każdy kolejny punkt powinien kończyć się kropką.

== Rozwiązanie A

[Każdy podrozdział powinien mieć zdanie wstępu przed przejściem do podrozdziału. Rysunki powinny być wyśrodkowane, numerowane i powinny mieć odwołania do literatury lub oznaczenie że zostały opracowane samodzielnie.]
W niniejszym podrozdziale opisano...

== Rozwiązanie B

== Rozwiązanie C

== Podsumowanie przeglądu

= Omówienie zagadnienia

== Podrozdział X

=== Podrozdział Xa

Test nagłówka trzeciego stopnia.

== Podrozdział Y

== Podrozdział Z

= Opis wykorzystanych narzędzi

== Technologia I

== Technologia II

== Technologia III

== Narzędzie I

== Narzędzie II

== Narzędzie III

= Założenia projektowe

== Wymagania funkcjonalne

W celu stworzenia wymagań funkcjonalnych i niefunkcjonalnych proszę posłużyć się wykładem dra Roberta Dyji #link("https//icis.pcz.pl/~dyja/pliki/IO/wyklad02.pdf")[(link)].

== Wymagania niefunkcjonalne

W celu stworzenia wymagań funkcjonalnych i niefunkcjonalnych proszę posłużyć się wykładem dra Roberta Dyji   #link("https://icis.pcz.pl/~dyja/pliki/IO/wyklad02.pdf")[(link)].

== Diagram przypadków użycia

== Diagram klas

== Schemat bazy danych

== Projekt interfejsu

= Prezentacja projektu

== Działanie ...

== Działanie ...

== Działanie ...

= Opis wybranych rozwiązań programistycznych

== Rozwiązanie ...

== Rozwiązanie ...

== Rozwiązanie ...

= Podsumowanie
[Dyskusja nad dalszym rozwojem pracy. Wnioski. Omówienie wyników. Co zrobiono w pracy i jakie uzyskano wyniki? Czy i w jakim zakresie praca stanowi nowe ujęcie problemu? Sposób wykorzystania pracy (publikacja, udostępnienie instytucjom, materiał źródłowy dla studentów). Co uważa autor za własne osiągnięcia?”. Dodatkowo warto zaznaczyć czy udało się osiągnąć założony cel pracy.] 	
#noindent[W ramach niniejszej pracy:]

- zebrano wiadomości z zakresu [Proszę wpisać tematykę],
- porównano [Proszę wpisać jakie istniejące rozwiązania porównano],
- opracowano [Proszę wpisać co opracowano w pracy],
- zrealizowano [Proszę wpisać co zrealizowano w pracy].


#noindent[W niniejszej pracy zrealizowano:]
- [Proszę wpisać zaletę rozwiązania],
- [Proszę wpisać zaletę rozwiązania],
- [Proszę wpisać zaletę rozwiązania].


#noindent[Rezultaty uzyskane w ramach pracy można wykorzystać:]
- [Proszę wpisać potencjalną możliwość zastosowania],
- [Proszę wpisać potencjalną możliwość zastosowania],
- [Proszę wpisać potencjalną możliwość zastosowania].

Rekapitulując można stwierdzić, że zrealizowane w ramach niniejszej pracy

#doublepagebreak()

#bibliography("bibliography.bib", title: "Literatura", style: "pcz.csl")

#set heading(numbering: none) // wyłączenie numerowania

= Spis rysunków
#outline(target: figure.where(kind: image), title: none)
= Spis tabel
#outline(target: figure.where(kind: table), title: none)
= Spis kodów
#outline(target: figure.where(kind: "code"), title: none)



= Streszczenie

Opis tego co zawarto w każdym rozdziale.

= Summary

Opis tego co zawarto w każdym rozdziale w języku angielskim.

= Słowa kluczowe

Wypisanie kilku słów kluczowych związanych z pracą.

