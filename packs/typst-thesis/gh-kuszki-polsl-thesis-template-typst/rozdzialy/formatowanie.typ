#import "../libs.typ": *

= Formatowanie pracy

Styl formatowania został określony w pliku `thesis.typ`, stąd nie ma potrzeby ręcznego formatowania kolejnych fragmentów pracy. Numerowanie wzorów, tabel, rysunków i rozdziałów, generowanie bibliografii oraz spisu treści odbywa się automatycznie. Zmiana danych strony tytułowej odbywa się na drodze edycji pliku `main.typ`. Zadanie autora sprowadza się zatem jedynie do wprowadzenia treści pracy.

== Wklejanie rysunków

Standardowo rysunki wklejane są do dokumentu pomiędzy akapitami. Przykład takiego rozwiązania przedstawia rysunek~@fig:rys_1. Rysunki można wstawiać również w ten sposób, że są one otoczone tekstem, stosując bibliotekę `meander`. Nie zaleca się jednak takiego rozwiązania, chyba że rysunek jest bardzo mały, a jego opis zwięzły. Numerowanie rysunków jest automatyczne, a odwoływanie się do nich możliwe jest stosując ```typst @nazwa_rysunku```, przy czym nazwa ta wskazywana jest podczas wstawiania rysunku.

#figure(
  caption: [Przykładowy rysunek (źródło: https://github.com/Kuszki/Phd)]
)[
  #image("../obrazki/schemat_adc.pdf") 
]
<fig:rys_1>

Rysunki należy sporządzać w formacie wektorowym (np. stosując program `LibreOffice`). Wykresy generowane przez programy `GNU Octave` oraz `MATLAB` mogą być eksportowane do formatu `SVG`. Natywne w `Typst` obsługiwane są obrazy w formatach: `PNG`, `JPG`, `GIF`, `SVG`, `PDF`, `WEBP`. Wszystkie pliki z rozszerzeniami `.odg`, znajdujące się w folderze `obrazki`, będą automatycznie skonwertowane do formatu `PDF` podczas uruchamiania skryptu `build.sh`. Należy unikać stosowania obrazków w formacie rastrowym (np. `JPEG` lub `PNG`), chyba że stanowią one zdjęcie.

== Wklejanie tabel

Sporządzanie tabel w `Typst` jest znacznie bardziej przystępne, niż w przypadku systemu składu `LaTeX`. Rozwiązanie to odwdzięcza się również jednolitym wyglądem oraz sporą możliwością automatyzacji formatowania danych. Automatyczne formatowanie tabel, które zawierają wartości liczbowe, jest możliwe przy użyciu biblioteki `zero`. Niestety omawiana biblioteka nie wspiera obecnie zmiany ustawień lokalizacji. Ogromną zaletą `Typst` w stosunku do `LaTeX` jest wbudowana możliwość importu danych do tabeli z pliku. Tabele~@tab:tab_1 oraz~@tab:tab_2 stanowią przykłady, gdzie zamieszczono wyniki eksperymentów.

#figure(
  caption: [Przykład tabeli, gdzie kolejne symbole oznaczają rozkład: $(n)$~normalny, $(u)$~jednostajny, $(t)$~trójkątny, $(d)$~dwumodalny (źródło: https://github.com/Kuszki/Phd)]
)[
  #table(
    columns: 5,
    $s_(a,b)$ , $n$ , $u$ , $t$ , $d$,
    $n$       , [0,0000]       , [0,1561]       , [0,0250]       , [0,2988]       ,
    $u$       , [0,1561]       , [0,3356]       , [0,1773]       , [0,5337]       ,
    $t$       , [0,0250]       , [0,1773]       , [0,0419]       , [0,3504]       ,
    $d$       , [0,2988]       , [0,5337]       , [0,3504]       , [0,7136]       ,
  )
]
<tab:tab_1>

#figure(
  caption: [Przykład tabeli, gdzie kolejne symbole oznaczają rozkład: $(n)$~normalny, $(u)$~jednostajny, $(t)$~trójkątny, $(d)$~dwumodalny (źródło: https://github.com/Kuszki/Phd)]
)[
  #table(
    columns: 10,
    [], $U_(a), #unit("milli volt")$ , $U_(b), #unit("milli volt")$ , $U_(c), #unit("milli volt")$ , $U_(d), #unit("milli volt")$ , $U_(s), #unit("milli volt")$ , $delta_(a), #unit("percent")$ , $delta_(b), #unit("percent")$ , $delta_(c), #unit("percent")$ , $delta_(d), #unit("percent")$ ,
    $S_(2,0)$ , [75,01] , [74,00] , [74,10] , [77,32] , [72,87] , [+2,94] , [+1,55] , [+1,69] , [+6,11] ,
    $S_(2,1)$ , [68,19] , [68,44] , [68,43] , [71,52] , [67,09] , [+1,64] , [+2,01] , [+2,00] , [+6,60] ,
    $T_(2,0)$ , [57,29] , [56,26] , [55,91] , [57,58] , [53,89] , [+6,31] , [+4,40] , [+3,75] , [+6,85] ,
    $T_(2,1)$ , [58,86] , [55,59] , [55,60] , [59,47] , [54,92] , [+7,17] , [+1,22] , [+1,24] , [+8,28] ,
    $T_(1,0)$ , [47,31] , [43,61] , [43,37] , [46,09] , [43,76] , [+8,11] , [−0,34] , [−0,89] , [+5,32] ,
    $T_(1,1)$ , [47,31] , [43,60] , [43,37] , [46,08] , [43,74] , [+8,16] , [−0,32] , [−0,85] , [+5,35] ,
    $T_(1,2)$ , [47,31] , [43,60] , [43,37] , [46,08] , [43,76] , [+8,11] , [−0,37] , [−0,89] , [+5,30] ,
    $T_(1,3)$ , [44,79] , [43,64] , [43,39] , [45,43] , [43,17] , [+3,75] , [+1,09] , [+0,51] , [+5,24] ,
  )
]
<tab:tab_2>

Podobnie, jak w przypadku obrazków, tabele numerowane są automatycznie, a odnosić się do nich można stosując ```typst @nazwa_tabeli```. W przypadku potrzeby umieszczania długich tabel (takich, w które mogą przechodzić na kolejne strony) zaleca się podejście opisane w dokumentacji `Typst`. Standardowo nie ma potrzeby rozciągania tabeli, jeśli ta nie zajmuje pełnej szerokości strony. Jeżeli jednak pożądany jest taki efekt, zaleca się stosowanie odpowiedniej opcji podczas tworzenia tabeli.

== Wstawianie równań

Równania można wstawiać stosując środowisko ```typst $...$```. W ten sposób są one automatycznie numerowane oraz centrowane. Równanie należy traktować tak, jakby były częścią zdania:
$ f(x) = a x + b, $ <eq:rownanie_1>
po czym to zdanie jest kontynuowane. Równania można również umieszczać jedno pod drugim:
$ f_1(x) = 123 x + 321, $ <eq:rownanie_2>
$ f_2(x) = 8 x + 7, $ <eq:rownanie_3>
a dodatkowo stosować można różnego rodzaju funkcje aby uzyskać odpowiedni format równania, przykładowo:
$ 
f(x, y) = cases(
  1 "jeżeli" (x dot y)/2 <= 0,
  2 "jeżeli" x != 2137,
  3 "jeżeli" x in NN,
  4 "w pozostałych przypadkach",
).
$ <eq:rownanie_4>

Do równań należy odwoływać się stosując ich nazwę, identycznie jak w przypadku tabel i rysunków. Przykładowo odnieść się można do równania~@eq:rownanie_1, równania~@eq:rownanie_3 oraz równania~@eq:rownanie_4. Nawiasy w odnośnikach wstawiane są automatycznie.

Istotnym problemem w `Typst` jest fakt, że w obecnej wersji wstawianie równania powoduje przerwanie akapitu. Oznacza to dodatkowe, niepotrzebne odstępy, a także problemy z wcięciem akapitu. Należy dodatkowo pamiętać, że równania w systemie składu `Typst` nie są kompatybilne z tymi, pisanymi w systemie składu `LaTeX`. Stanowi to problem podczas migracji dokumentu. Zaznaczyć w tym miejscu warto również fakt, że narzędzia sztucznej inteligencji bardzo słabo radzą sobie obecnie ze sporządzaniem równań w `Typst` -- są one bowiem przystosowane do stosowania składu `TeX`. Ostatecznie system składu `LaTeX` oferuje znacznie lepsze możliwości formatowania równań.

Jeżeli podczas pisania tekstu istnieje konieczność wstawiania symbolu lub fragmentu równania, to należy taki symbol wstawić pomiędzy znaki dolara, gdzie np. ```typst $x^2 cos(alpha)$``` zamieni się na $x^2 cos(alpha)$. Jeżeli natomiast w tekście występują wielkości wraz z ich wartościami i jednostkami, zaleca się stosowanie biblioteki `unify`. Wtedy przykładowo stosować można rozwiązania gdzie:
 - ```typst $U = qty("12,3", "micro volt")$``` zamieni się na $U = qty("12,3", "micro volt")$,
 - ```typst $a = qty("10", "meter per second squared")$``` zamieni się na $a = qty("10", "meter per second squared")$,
 - ```typst #qty("+-0,25", "percent")``` zamieni się na #qty("+-0,25", "percent"),
 - ```typst #qty("1,29 +- 0,16", "ohm")``` zamieni się na #qty("1,29 +- 0,16", "ohm"),
 - ```typst #num(100000)``` zamieni się na #num(100000),
 - ```typst #num("1,124e-7")``` zamieni się na #num("1,124e-7").
Powyższe zapisy mogą być zatem stosowane zarówno bezpośrednio w tekście, jak i w trybie matematycznym. Niestety, podobnie jak w przypadku biblioteki `equate`, biblioteka `unify` nie wspiera w obecnej wersji polskiej lokalizacji ustawianej globalnie.

Podczas pisania równań wszystkie wprowadzane litery traktowane są jako zmienne. Stąd ```typst $x y z$``` zamienia się na $x y z$ (spacje nie są wstawiane). W odróżnieniu od systemu składu `LaTeX`, w systemie `Typst` nie stosuje się specjalnego znaku do wprowadzania symboli specjalnych oraz funkcji. Zmienne automatycznie formatowane są z użyciem kursywy, co jest poprawnym działaniem. Podobnie indeksy górne ```typst $x^n$``` i dolne ```typst $x^n$``` pisane są kursywą (kolejno $x^n$ oraz $x_i$). Jeżeli jednak indeksy te nie są związane z wielkością fizyczną, powinny być pisane czcionką prostą. Wtedy stosuje się np. ```typst $x_("max")$```, co zamienia się na $x_("max")$. W przypadku, gdy analizowana wielkość jest macierzą lub wektorem, jej symbol zapisuje się kursywą wraz z pogrubieniem. Wtedy stosować należy zapis ```typst $bold(X)$```, co zamienia się na $bold(X)$.

== Cytowanie literatury

Bibliografię przygotować należy w formacie `BibLaTeX` i umieścić ją w pliku `bibliografia.bib`, który znajduje się w katalogu `dodatki`. Większość stron internetowych, na których znaleźć można książki i artykuły, posiada przycisk "cytuj", po którego naciśnięciu generuje się gotowy do skopiowania wpis bibliograficzny.

Podczas pisania tekstu, w celu przywołania pozycji literatury, należy stosować zapis ```typst @pozycja```. Spis cytowanej literatury wygeneruje się automatycznie dla wszystkich zacytowanych pozycji. Plik `bibliografia.bib` może zatem zawierać nadmiarowe pozycje, które nie są używane, przy czym pozycje te nie zostaną uwzględnione w spisie. Spis zostanie posortowany zgodnie z kolejnością przywoływania pozycji, przy czym działanie to można zmienić w ustawieniach szablonu, parametrem `bibstyle`. Cytując wiele pozycji jednocześnie nie trzeba samodzielnie dbać o kolejność cytować -- kolejne pozycje zostaną posortowane i zgrupowane, zależnie od stosowanego stylu bibliografii.

Przykładem cytowania jest~@ksiazka_1 oraz~@rozdzial_ksiazki_2. Dla wielokrotnego cytowania przykładem jest @materialy_konferencyjne_3 @artykul_4 @raport_5 oraz @ksiazka_1 @teza_8 @materialy_konferencyjne_3 @artykul_4 @raport_5 @instrukcja_6. Kolejne przykłady to @instrukcja_6 oraz @strona_7 @teza_8. Jeżeli w wymagane jest umieszczenie fragmentu tekstu w cudzysłowie, należy zastosować cudzysłów lub apostrof bezpośrednio w tekście -- zamieniony on zostanie na odpowiedni dla regionu format.

Standardowo praca inżynierska powinna zawierać około kilkunastu pozycji literatury. Mogą to być artykuły naukowe, noty aplikacyjne urządzeń oraz ich dokumentacje techniczne, książki, materiały konferencyjne oraz w ostateczności strony internetowe. O ile odwoływanie się do stron internetowych jest dopuszczalne, to nie powinno się nadużywać tego typu pozycji.

== Wstawianie kodu źródłowego

Fragmenty kodu źródłowego mogą być wstawiane w tekście w ten sam sposób, jak w przypadku języka `Markdown`. Można jednak uzyskać dodatkowe efekty formatowania stosując bibliotekę `codly`. Istnieje również opcja wklejania fragmentu kodu z pliku źródłowego, stosując ```typst #raw(read("plik"), lang: "język", block: true)```. Przykłady stanowią listingi~@lst:python oraz~@lst:typst. Dodatkowe formatowanie fragmentów kodu zapewnia biblioteka `codly`.

#figure(
  caption: [Przykładowy kod `C++`],
)[
  ```cpp
  #include <stdio>
  
  int main(int argc, char *argv[])
  {
    std::cout << "Wincy żółtego!" << std::endl;
    return 2137;
  }
  ```
]
<lst:python>

#figure(
  caption: [Przykładowy kod Typst],
)[
  #raw(read("../main.typ").split("\n").slice(0, 36).join("\n"), lang: "typst", block: true)
]
<lst:typst>

== Uwagi techniczne

Szablon wykorzystuje system składu `Typst` oraz bibliografię w formacie `BibLaTeX`, stąd pliki źródłowe powinny być kodowane w `UTF-8`. Dzielenie wyrazów jest domyślnie wyłączone, natomiast bękarty, wdowy, sieroty i szewcy są automatycznie eliminowane. Niestety, stosowany system składu wciąż jest w fazie rozwoju, podobnie jak zastosowane w niniejszym szablonie biblioteki. Oznacza to, że mogą wystąpić problemy z niektórymi funkcjami oraz umiędzynaradawianiem dokumentu.

Standardowo odstęp pomiędzy akapitami wynosi #qty("12", "pt") i nie jest on dodatkowo korygowany, jak ma to miejsce w `LaTeX`. System składu `Typst` nie zakłada takiej możliwości w przyszłości, stąd ogólna jakość składu może być nieco gorsza, niż w przypadku stosowania `LaTeX`. Wcięcie pierwszego wiersza akapitu wynosi #qty("32", "pt"), natomiast w chwili sporządzania szablonu nie jest ono prawidłowo obsługiwane przez kompilator. Podczas cytowania literatury oraz odnoszenia się do rysunków, tabel i równań sugeruje się stosować nierozdzielające spacje (znak tyldy).

Stosowany w `Typst` format pisania równań jest formatem niezgodnym z `LaTeX`. Warto zauważyć, że między z uwagi na krótki czas życia, dostępne narzędzia, między innymi `ChatGPT`, mogą mieć problemy z poprawnym tworzeniem równań. Istnieją specjalne narzędzia, które umożliwiają wstawianie równań `LaTeX` w `Typst`.

Zwyczajowo w tego typu pracach wszystkie równania, rysunki, tabele, listingi itp. numeruje się względem rozdziału (tj. dodaje się numeracje `rozdział.obiekt`). Z uwagi na fakt, że prace magisterskie i projekty inżynierskie cechują się objętością nieprzekraczającą około 50 stron, w proponowanym szablonie nie stosuje się takiego numerowania -- można jednak je wprowadzić.

Stosując parametr szablonu `print: true` wygenerowany dokument będzie przeznaczony do wydruku. Spowoduje to dodanie dodatkowych pustych stron, w ten sposób aby spis treści oraz metryka pracy znajdowały się na prawej stronie. W trybie `print` wewnętrzny margines zostanie również przesunięty o #qty("0.5", "cm"), co umożliwi zbindowanie pracy. Należy zauważyć, że numeracja stron rozdziałów pracy nie zmieni się. Aby zminimalizować objętość pracy, szablon nie wprowadza funkcji `openright` i nie wymusza rozpoczęcia rozdziałów na nowej stronie. Nie zaleca się stosowania tego rozwiązania, ponieważ poza nadmiarem papieru, modyfikuje ono numeracje stron dokumentu. Istnieje jednak możliwość dopasowania szablonu do stosowania tej opcji.
