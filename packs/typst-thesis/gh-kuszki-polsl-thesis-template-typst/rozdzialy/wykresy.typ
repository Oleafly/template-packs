#import "../libs.typ": *

= Generowanie wykresów

Wykresy powinny być wykonane starannie i z zachowaniem odpowiedniej czytelności. Należy zatem generować je w wyspecjalizowanym do tego celu programie i zapisywać do pliku w formacie grafiki wektorowej. Proponuje się w tym celu program `GNU Octave` lub `gnuplot`. Odpowiednio wykonany rysunek powinien być spójny z resztą dokumentu, co osiągnięto w przypadku rysunku~@fig:octave, stosując przykładowy skrypt~@lst:octave.

#figure(
  caption: [Przykładowy rysunek wygenerowany w programie `GNU Octave`]
)[
  #image("../obrazki/plot_demo.pdf")
]
<fig:octave>

Przedstawiony skrypt tworzy w pierwszej linii nowy wykres, przy czym gdy skrypt zostaje wywołany z terminala wykres ten jest ukrywany (taki zabieg ułatwia wsadowe generowanie wykresów). Następnie ustalane są wymiary wykresu (linie 5--7) oraz korygowana jest jego pozycja tak, aby wypełniał on cały obszar rysunku (linia 10). W kolejnych liniach (11--15) ustalane są parametry czcionki, przy czym z nieznanych dla autora niniejszego szablonu powodów, dla rozmiaru #qty("11", "pt") wynikowy plik cechuje się czcionką o rozmiarze #qty("12", "pt") (najprawdopodobniej występuje błąd w programie `GNU Octave`, związany ze skalowaniem obrazu).

#figure(
  caption: [Przykładowy skrypt programu `GNU Octave` generujący rysunek~@fig:octave]
)[
  #raw(read("../skrypty/plot_demo.m"), lang: "matlab", block: true)
]
<lst:octave>

Po wygenerowaniu danych wykres jest sporządzany oraz formatowane są jego elementy. W opisach stosować można większość podstawowych funkcji `LaTeX` do formatowania tekstu. Można również zastosować wartość `latex` dla opcji `interpreter` formatując kolejne elementy wykresu. Szczegóły opisuje #link("https://docs.octave.org/latest")[dokumentacja] programu `GNU Octave`. Znaki specjalne wstawiać można bezpośrednio w edytorze tekstu, stosując kodowanie `UTF-8`. Można także wstawiać je stosując ich nazwy, identycznie jak podczas edycji równań. Wygenerowany w omawiany sposób wykres jest spójny z resztą dokumentu i wygląda profesjonalnie. Niestety w przeciwieństwie do systemu składu `LaTeX`, stosując `Typst` nie ma możliwości eksportu wykresów do formatu `tikz`.

Wykresy można generować również w programie `gnuplot`, gdzie przykładowy skrypt przedstawiono w listingu~@lst:gnuplot. Stosować w tym celu można terminal `svg`. Niestety system składu `Typst` nie wspiera rysunków w formacie `tikz`, stąd stosowanie programu `gnuplot` jest ograniczone. Alternatywą dla wskazanego formatu jest `cetz`, natomiast nie oferuje on tylu możliwości i wciąż jest w wersji rozwojowej. Stosowanie terminala `svg` w `gnuplot` pozwala osiągnąć większość formatów wewnątrz wykresu, natomiast nie jest ono wygodne z uwagi na konieczność ręcznego wprowadzania formatów.

#figure(
  caption: [Przykładowy skrypt programu `gnuplot` generujący rysunek~@fig:gnuplot]
)[
  #raw(read("../skrypty/plot_demo.gnuplot"), lang: "gnuplot", block: true)
]
<lst:gnuplot>

#figure(
  caption: [Przykładowy rysunek wygenerowany w programie `gnuplot`]
)[
  #image("../obrazki/gnuplot_demo.svg")
]
<fig:gnuplot>

Ostatnim proponowanym rozwiązaniem jest ręczne generowanie wykresów bezpośrednio w treści dokumentu, stosując bibliotekę `cetz` lub bibliotekę `lilaq`. Takie rozwiązanie zapewnia jakość porównywalną do stosowania programu `gnuplot` i terminala `tikz`, przy czym wymaga wprowadzenia treści wykresu ręcznie. Przykład wykresu, który generowany jest na podstawie listingu~@lst:cetz przedstawia rysunek~@fig:cetz, przy czym osiągnięty efekt jest podobny do rysunku~@fig:gnuplot.

#figure(
  caption: [Przykładowy rysunek wygenerowany w bibliotece `cetz`]
)[
  #canvas({
    plot.plot(
      size: (14, 7),                      // rozmiar wykresu (cm)
      x-tick-step: calc.pi/4,             // krok osi X
      x-format: plot.formats.multiple-of, // format osi X
      y-tick-step: 0.5,                   // krok osi Y
      y-min: -1.5,                        // zakres
      y-max: 1.5,                         // osi Y
      legend: "inner-north-east",         // pozycja legendy
      x-grid: true,                       // siatka osi X
      y-grid: true,                       // siatka osi Y
    {
      plot.add(                                   // dodaj wykres:
        domain: (-1.1 * calc.pi, +1.1 * calc.pi), //   dziedzina
        label: $sin(x)$,                          //   etykieta
        calc.sin                                  //   funkcja
      )
    })
  })
]
<fig:cetz>

#figure(
  caption: [Przykładowy skrypt programu `gnuplot` generujący rysunek~@fig:cetz],
)[
  ```typst
  #figure(
    caption: [Przykładowy rysunek wygenerowany w bibliotece `cetz`]
  )[
    #canvas({
      plot.plot(
        size: (14, 7),                      // rozmiar wykresu (cm)
        x-tick-step: calc.pi/4,             // krok osi X
        x-format: plot.formats.multiple-of, // format osi X
        y-tick-step: 0.5,                   // krok osi Y
        y-min: -1.5,                        // zakres
        y-max: 1.5,                         // osi Y
        legend: "inner-north-east",         // pozycja legendy
        x-grid: true,                       // siatka osi X
        y-grid: true,                       // siatka osi Y
      {
        plot.add(                                   // dodaj wykres:
          domain: (-1.1 * calc.pi, +1.1 * calc.pi), //   dziedzina
          label: $sin(x)$,                          //   etykieta
          calc.sin                                  //   funkcja
        )
      })
    })
  ] <fig:cetz>
  ```
]
<lst:cetz>

Generowanie wykresów w programie `GNU Octave` jest najprostszym z przedstawionych rozwiązań, gdzie dodatkowo program ten pozwala na przeprowadzanie skomplikowanych symulacji i obliczeń. Program `gnuplot` również umożliwia generowanie wykresów dobrej jakości, gdzie jednocześnie możliwe jest wykonywanie różnych operacji i obliczeń na danych, które mogą być wczytywane z plików. Stosowanie biblioteki `cetz` lub `lilaq` zapewnia doskonałą jakość wykresów i grafów, natomiast wymaga wprowadzania ich bezpośrednio w kodzie `Typst` lub wczytywania treści skryptu z pliku.

Dobór stosowanego rozwiązania powinien być zatem rozważony pod kątem łatwości użycia danego narzędzia oraz zapewnianych przez niego możliwości. Istotne jest jednak, aby wszystkie wykresy w pracy były jednolite -- najlepiej zatem stosować konsekwentnie jedno z rozwiązań.
