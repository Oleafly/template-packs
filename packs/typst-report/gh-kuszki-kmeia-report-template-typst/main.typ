// Import szablonu oraz dodatkowych bibliotek:
#import "report.typ": *

// Konfiguracja szablonu:
#show: setup.with(

  topic: "Szablon sprawozdania",    // Nazwa ćwiczenia
  foreman: "dr inż. Łukasz Dróżdż", // Prowadzący ćwiczenie
  field: "Elektrotechnika",         // Nazwa kierunku studiów
  study: "ElekE / V",               // Kod studiów oraz numer semestru
  subject: "SI5TCIM21O",            // Kod przedmiotu z systemu USOS
  section: "I / 3",                 // Numer grupy dziekańskiej oraz sekcji
  date: "06.02.2026",               // Data wykonania ćwiczenia
  year: "2025/2026",                // Rok Akademicki

  // Nazwa laboratorium oraz jednostki organizacyjnej:
  lab: "Laboratorium Techniki Cyfrowej i Mikroprocesorowej",
  institute: "Katedra Metrologii, Elektroniki i Automatyki",

  // Autorzy sprawozdania:
  authors: (
    ("Gal Anonim"),     // autor pierwszy
    ("Pan Paweł"),      // autor drugi
    ("Wiesław Paleta"), // autor trzeci
  ),
  
)

// Opcjonalne załączniki do pliku PDF - można w ten sposób załączyć kartę 
// pomiarową oraz inne pliki, w przypadku gdy sprawozdanie jest oddawane
// jedynie w wersji elektronicznej - o ile prowadzący na to pozwala

#pdf.attach("main.typ",
  relationship: "source",
  mime-type: "text/x-typst",
  description: "Plik źródłowy dokumentu",
)

#pdf.attach("report.typ",
  relationship: "supplement",
  mime-type: "text/x-typst",
  description: "Plik szablonu dokumentu",
)

// Główna część sprawozdania:

= Cel ćwiczenia

Omówienie celu wykonywanego ćwiczenia, bez obszernego wstępu teoretycznego. Należy przedstawić, w jakim celu ćwiczenie zostało przeprowadzone, jakie zależności w nim zbadano oraz jakie jest jego uzasadnienie merytoryczne i praktyczne.

= Program zadań zrealizowanych w trakcie wykonywania ćwiczenia

Należy wskazać przebieg ćwiczenia oraz wykonane czynności w porządku chronologicznym.

= Spis przyrządów

Należy wskazać przyrządy, które wykorzystano do realizacji programu ćwiczenia. W tym miejscu nie należy umieszczać urządzeń/przyrządów będących obiektami badań.

= Schematy układów zastosowanych przy realizacji celu ćwiczenia

Należy wskazać układ połączeń, stosowany podczas wykonywania ćwiczenia. Jeżeli podczas ćwiczenia układ ten ulegał zmianie, należy omówić wszystkie wersje stosowanych układów.

= Opisy obiektów badań

Należy omówić, jaki obiekt był przedmiotem badań. Jeżeli badano kilka obiektów, należy je omówić z osobna. Należy wskazać znamionowe parametry obiektu.

= Szkice lub zdjęcia układu przyrządów zastosowanych w ćwiczeniu

Jeżeli zostanie to uznane za stosowne, w sprawozdaniu umieścić można fotografie wykonane podczas realizacji ćwiczenia. Należy pamiętać, że nie mogą one zastąpić schematów oraz spisu urządzeń.

= Warunki przeprowadzenia pomiarów

Należy wskazać warunki przeprowadzania eksperymentu, istotne z punktu widzenia jego przeprowadzania (między innymi warunki środowiskowe).

= Wzory i definicje niezbędne w opisie realizowanych zadań

Należy wskazać stosowane podczas opracowywania wyników pomiarów wzory oraz zależności, bez nieistotnych wyprowadzeń oraz wylewnego opisu teoretycznego. Wzory należy numerować i traktować jak część zdania:
$
y(t) = sum _(i=1) ^(infinity) A_(i) sin(omega_(i) t + phi_(i)),
$ <eq:rownanie_1>
gdzie $A_i$ jest amplitudą, $phi_i$ fazą oraz $omega_i$ pulsacją przebiegu $y(t)$.

= Wyniki pomiarów zestawione w tabelach łącznie z wynikami obliczeń wielkości wyznaczanych

W sprawozdaniu należy umieścić wyniki zrealizowanych pomiarów oraz obliczeń. Wyniki te należy umieszczać w postaci tabelarycznej, wraz z opisem zlokalizowanym nad tabelą.

Stosując system składu `Typst` istnieje możliwość automatycznego formatowania danych w tabelach oraz wczytywania ich zawartości z pliku. Jest to bardzo wygodny sposób, ponieważ dane te mogą być wykorzystywane zarówno w arkuszu kalkulacyjnym, programie stosowanym do tworzenia wykresów oraz bezpośrednio w dokumencie. Przykłady tabel przedstawiono poniżej.

#figure(
  caption: [Przykład tabeli, gdzie kolejne symbole oznaczają rozkład: $(n)$~normalny, $(u)$~jednostajny, $(t)$~trójkątny, $(d)$~dwumodalny (źródło: https://github.com/Kuszki/Phd)]
)[
  #table(
    columns: 10,
    [], $U_(a), unit("mV")$ , $U_(b), unit("mV")$ , $U_(c), unit("mV")$ , $U_(d), unit("mV")$ , $U_(s), unit("mV")$ , $delta_(a), unit("percent")$ , $delta_(b), unit("percent")$ , $delta_(c), unit("percent")$ , $delta_(d), unit("percent")$ ,
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
<tab:tab_1>

#figure(
  caption: [Przykład tabeli wczytanej z pliku `sample.csv`]
)[
  #ztable(
    columns: 4,
    format: (auto, auto, auto, (exponent: "sci")),
    table.header([Liczba kwantów $n_q$] , [Napięcie $U_("min")$, #unit("V")] , [Napięcie $U_("max")$, #unit("V")] , [Wariancja $sigma^2$, #unit("micro volt squared")]),
    ..for (.., nq, umax, umin, var) in csv("wyniki/sample.csv", delimiter: ";").slice(1) {
      (
        [#int(nq.trim())], 
        [#float(umin.trim())], 
        [#float(umax.trim())], 
        [#float(var.trim())]
      )
    }
  )
]
<tab:tab_2>

Dla tabeli @tab:tab_2 zastosowano bibliotekę `zero` do formatowania wartości komórek, które wczytano z pliku `sample.csv`. Przykład pokazuje w jaki sposób parsować dane z pliku `CSV`, pomijać nieistotne kolumny oraz zmieniać ich kolejność. Istnieje również możliwość wykonywania obliczeń na wczytanych danych oraz dodawania nowych kolumn bezpośrednio w dokumencie.

= Rejestracje lub szkice  obrazów ekranów oscyloskopu czy monitora

Jeżeli podczas ćwiczenia rejestrowano przebiegi za pomocą oscyloskopu, to najistotniejsze z nich umieścić można w sprawozdaniu. Załączane obrazy powinny być zretuszowane oraz powinny cechować się odpowiednią jakością.

#figure(
  caption: [Przykład obrazu wczytanego z pliku `sample.png`]
)[
  #image("obrazki/sample.png", width: 15cm)
]
<fig:obrazek_1>

= Przykładowe obliczenia

Sprawozdanie może zawierać przykłady wykonanych obliczeń. Należy wtedy wskazać równanie, zgodnie z którym wyznaczano wartość omawianej wielkości oraz podstawić do niego dane. Należy pamiętać również o jednostkach, przykładowo:
$
R = U / I = #qty("1,12", "volt") / #qty("0,58", "ampere") = #qty("1,93", "ohm").
$ <eq:rownanie_2>
Niestety w obecnej wersji biblioteka `unify` nie wspiera globalnej możliwości ustalenia separatora dziesiętnego na przecinek.

= Wykresy zależności pomiędzy mierzonymi i obliczonymi wielkościami

Często wyniki pomiaru prezentowane są postaci wykresów. Także w tym przypadku wykres powinien zawierać informację o niepewności przedstawionych na nim wyników pomiaru. Na rysunku @fig:lilaq przedstawiono przykładowy wykres charakterystyki prądowo-napięciowej,  sporządzony na podstawie danych zestawionych w tabeli @tab:tab_3, które wczytano z pliku `measures.csv`. Charakterystyczne słupki reprezentują złożone niepewności pomiaru obu wielkości. Podpis pod rysunkiem powinien informować o sposobie interpretacji słupków niepewności.

#figure(
  caption: [Przykład tabeli wczytanej z pliku `sample.csv`, gdzie $Delta_"gr"$ oznacza błąd graniczny]
)[
  #set-round(mode: "uncertainty", precision: 2)
  #ztable(
    columns: 4,
    format: (auto, auto, auto, auto),
    table.header([Prąd, #unit("ampere")], [$Delta_"gr" (I)$, #unit("ampere")] , [Napięcie, #unit("V")] , [$Delta_"gr" (U)$, #unit("volt")]),
    ..for (i, u, di, du) in csv("wyniki/measures.csv", delimiter: ";").slice(1) {
      (
        [#float(i.trim())] + "+-" + [#{float(di.trim()) / calc.sqrt(3)}], 
        [#float(di.trim())],
        [#float(u.trim())] + "+-" + [#{float(du.trim()) / calc.sqrt(3)}], 
        [#float(du.trim())],
      )
    }
  )
]
<tab:tab_3>

#figure(
  caption: [Charakterystyka $U(I)$ wraz z błędami granicznymi],
)[
  #let (x, y, ex, ey) = lq.load-txt(read("wyniki/measures.csv"), delimiter: ";")

  #let px = lq.linspace(0, 5.5)
  #let py = px.map(x => 2.0 * x + 0.0)
  
  #lq.diagram(
    width: 15cm,
    height: 7cm,
    legend: (position: top + left),
    xlabel: [Natężenie prądu, #unit("ampere")],
    ylabel: [Wartość napięcia, #unit("volt")],
    xlim: (0, 5.5), 
    ylim: (0, 11),
    lq.plot(
      px, py,
      mark: none,
      stroke: 1pt,
      color: blue,
      label: [Regresja]
    ),
    lq.plot(
      x, y,
      xerr: ex,
      yerr: ey,
      stroke: none,
      color: red,
      mark: "x",
      mark-size: 8pt,
      label: [Pomiary],
    ),
  )
] <fig:lilaq>
  
= Wnioski

Sprawozdanie musi zawierać wnioski wyciągnięte podczas realizacji ćwiczenia i opracowywania wyników pomiarów. Wnioski muszą odnosić się do zagadnień zrealizowanych podczas ćwiczenia oraz komentować uzyskane wyniki. Należy unikać ogólnikowych sformułowań typu "podczas ćwiczenia nauczyliśmy się wykonywać ćwiczenie".

= Zestawienie tytułów dokumentów

Należy wymienić załączniki do sprawozdania, takie jak karta pomiarowa oraz dodatkowe dokumenty, wskazane przez prowadzącego ćwiczenie.

= Uwagi końcowe

Na podstawie oficjalnego szablonu sprawozdania dostępnego na #link("https://www.polsl.pl/re2/materialy/")[stronie internetowej] Katedry Metrologii, Elektroniki i Automatyki:
+ Sprawozdanie sporządzane jest jedno dla sekcji studentów, chyba że inaczej ustali prowadzący ćwiczenie.
+ Jeżeli student odrabia ćwiczenie z inną sekcją musi sporządzić własne sprawozdanie.
+ Do sprawozdania musi być podłączony jako załącznik protokół z ćwiczenia podpisany przez prowadzącego ćwiczenie
+ Zamieszczone tabele i rysunki muszą być ponumerowane i zatytułowane.
+ W tabelach muszą być zaznaczone nazwy wielkości i ich miary.
+ Wykresy muszą być ponumerowane i zatytułowane. Osie wykresów powinny zawierać nazwy wielkości lub parametrów i ich miary.
+ Przekładowa forma sprawozdania jest podana powyżej.
+ Sprawozdanie można  sporządzać w rękopisie lub w formie wydruku z komputera. 

Należy zaznaczyć, że wskazane sekcje niniejszego szablonu stanowią ogólne wytyczne do sporządzania sprawozdań. Ostatecznie to prowadzący ćwiczenie wskazuje w jaki sposób powinno zostać przygotowane sprawozdanie oraz jakie elementy powinno zawierać.

Jeżeli na końcu dokumentu pojawić ma się bibliografia, to należy w opcjach szablonu wskazań nazwę pliku zawierającego spis bibliograficzny. Wszystkie pozycje zawarte we wskazanym pliku staną automatycznie wymienione w spisie. Więcej porad oraz przykładów formatowania dokumentu w systemie składu `Typst` zawarto w #link("https://github.com/Kuszki/PolSl-Thesis-Template-Typst")[szablonie pracy dyplomowej].

Niniejszy szablon dostępny jest na licencji `GNU LGPL v2.1`. Stosowanie, modyfikowanie i rozpowszechnianie niniejszego szablonu jest dozwolone w dowolnym celu, przy czym sam szablon traktowany jest jak zewnętrzna biblioteka. Szablon dostępny jest w publicznym #link("https://github.com/Kuszki/KMEiA-Report-Template-Typst")[repozytorium] w serwisie #link("https://github.com")[GitHub]. Uwagi odnośnie szablonu zgłaszać można na #link("mailto:lukasz.drozdz@polsl.pl")[adres mailowy autora].
