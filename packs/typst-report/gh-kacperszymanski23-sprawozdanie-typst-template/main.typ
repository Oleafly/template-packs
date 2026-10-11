// --- PRO TIP: IKONY -----------------------------------------------
// Jeśli chcesz używać ikon w tym sprawozdaniu to używaj ikon NerdFonts są bardzo przydatne.
// Link do ikon https://www.nerdfonts.com
// ------------------------------------------------------------------

// --- PRO TIP: ZNAKI SPECJALNE -------------------------------------
// Unikaj dodawania surowych znaków specjalnych w tekście, ponieważ Typst dostarcza lepsze rozwiązanie.
//
// Znaki takie jak: "–", "−", "—" powinny być zastąpione przez "-"
// lub "--" dla długich pauz albo "---" dla jeszcze dłuższych.
//
// Znaki takie jak "÷", "×" i podobne powinny być zastąpione przez "div", "times"
// (lub odpowiadająca im syntax w jezyku matematycznym) i zamienione w równanie.
// Przykład użycia: 4 × 10 --> $4 times 10$
//
// Znaki alfabetu greckiego takie jak "σ" powinny zostać zastąpione przez "sigma" i zamienione w równanie.
// Przykład użycia: σ --> $sigma$
//
// Symbole strzałek np. "→" powinny zostać zastąpione przez np. "#sym.arrow.r"
//
// Postępuj w ten sam sposob z pozostałymi znakami specjalnymi.
// Więcej informacji na temat znaków  i symboli w Typst znajduje się w dokumentacji.
// Link do dokumentacji: https://typst.app/docs
// -----------------------------------------------------------------

// --- PRO TIP: GRAFIKI --------------------------------------------
// Jak chcesz wyświetlać grafiki w tym sprawozdaniu to użyj funkcji #figure.
//
// Pamiętaj że Typst nie kompresuje, ani nie zmienia rozmiaru grafik
// musisz więc musisz to zrobic samemu, inaczej po kompilacji otrzymasz 30MiB+ plik PDF.
//
// REKOMENDOWANE ROZWIAZANIE: Alternatywnie możesz przekonwertować kotowy plik PDF przy uzyci komendy:
// gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="OUTPUT.pdf" main.pdf
//
// REKOMENDOWANE ROZWIAZANIE: Polecam używać plików .svg tak często jak tylko możesz, bo w ten sposób unikniesz problem z kompresją.
// ------------------------------------------------------------------

#import "template.typ": *

// Wypełnij pola swoimi danymi.
#show: report.with(
  title: "Temat ćwiczenia - Badanie właściwości X",
  authors: ((name: "Jan Kowalski"), (name: "Anna Nowak")),
  course: "Nazwa przedmiotu",
  group: "L4",
  lecturer-name: "Mariusz Garota",
  academic-title: "dr inż.",
  date-format: "[day].[month].[year]",
)


// ════════════════════════════════════════════════════════════════
//  1. CEL ĆWICZENIA
//     Krótki opis celu, zakresu i środowiska pracy (kilka zdań).
//     TODO: zamień na własny opis celu ćwiczenia.
// ════════════════════════════════════════════════════════════════
= Cel ćwiczenia
TODO - opisz zwięźle cel ćwiczenia: co ma być osiągnięte, w jakim środowisku (np. MATLAB, C++, Python, VHDL, matematyka dyskretna) oraz jaki jest zakres zadań.


// ════════════════════════════════════════════════════════════════
//  2. CZĘŚĆ TEORETYCZNA
//     Wprowadzenie do zagadnienia: definicje, wzory, algorytmy.
//     Usuń podsekcje, które nie dotyczą Twojego tematu.
// ════════════════════════════════════════════════════════════════
= Część teoretyczna

// ── 2.1 ─────────────────────────────────────────────────────────
// TODO: opisz zagadnienie teoretyczne będące podstawą ćwiczenia.
== Opis zagadnienia

TODO - opisz problem, metodę lub algorytm będący tematem ćwiczenia.

// TODO: zastąp placeholder własnym rysunkiem, schematem lub diagramem.
#figure(
  rect(width: 80%, height: 5cm, fill: luma(220), stroke: 0.5pt)[
    #align(center + horizon)[
      #text(fill: luma(120), style: "italic")[TODO - wstaw rysunek / schemat blokowy / diagram]
    ]
  ],
  caption: [TODO - Podpis rysunku (np. schemat algorytmu, diagram przepływu danych, graf).],
)

TODO - kontynuuj opis teoretyczny.

// ── 2.2 ─────────────────────────────────────────────────────────
// TODO: podaj wzory, definicje lub twierdzenia niezbędne do zadania.
// TODO: usuń tę podsekcję, jeśli temat nie wymaga wzorów formalnych.
== Wzory i definicje

TODO - wprowadź niezbędne wzory lub definicje:

#eq($T(n) = O(n log n)$)

#eq($"TODO" = frac("TODO", "TODO")$)


TODO - skomentuj wzory i definicje.


#note-box[
  #text[TODO - tekst notatki, np. przykłady, zależności, etc.]
]

// ════════════════════════════════════════════════════════════════
//  3. REALIZACJA ZADANIA
//     Opis implementacji: środowisko, podejście, kod źródłowy.
//     TODO: dostosuj podsekcje do specyfiki swojego zadania.
// ════════════════════════════════════════════════════════════════
= Realizacja zadania

// ── 3.1 ─────────────────────────────────────────────────────────
// TODO: wymień narzędzia, środowisko i wersje oprogramowania.
== Środowisko i narzędzia

Do realizacji zadania użyto następujących narzędzi:

+ *TODO - Środowisko / IDE* - TODO krótki opis (wersja, system operacyjny).
+ *TODO - Język / platforma* - TODO (np. MATLAB R2024b, GCC 14, Vivado 2023, Python 3.12).
+ *TODO - Biblioteki / toolboxy* - TODO krótki opis bibliotek zewnętrznych.

// ── 3.2 ─────────────────────────────────────────────────────────
// TODO: opisz strukturę rozwiązania, podział na moduły i przyjęte podejście.
== Opis rozwiązania

TODO - opisz architekturę rozwiązania, wybrane podejście algorytmiczne lub strukturę projektu (np. podział na funkcje, moduły, pliki).

#info-box[
  TODO - wpisz istotną uwagę dotyczącą implementacji lub przyjętych założeń upraszczających.
]

// ── 3.3 ─────────────────────────────────────────────────────────
// TODO: wstaw kod źródłowy i opisz jego działanie.
// TODO: zmień wartość lang: na właściwy język ("C++", "MATLAB", "VHDL", "Python" itp.).
// TODO: zamień txt na właściwy język w bloku aby umożliwić podświetlanie składni.
== Kod źródłowy

#code-block(lang: "TODO - język", syntax-theme: "Agila Monokai Extended.tmtheme")[
  ```txt
  // TODO - wstaw swój kod źródłowy
  // Sugerowana struktura:
  //   1. Deklaracje / inicjalizacja
  //   2. Główny algorytm / logika
  //   3. Wypisanie lub zwrócenie wyników
  ```
]

TODO - opisz działanie kodu: co robi każda funkcja / procedura, jakie struktury danych zostały zastosowane i dlaczego.

// TODO: dodaj kolejne bloki kodu jeśli zadanie składa się z kilku modułów.
// TODO: usuń ten blok, jeśli zadanie wymaga tylko jednego fragmentu kodu.
#code-block(lang: "TODO - język", syntax-theme: "Agila Monokai Extended.tmtheme")[
  ```txt
  // TODO - kod funkcji pomocniczej lub kolejnego modułu / pliku
  ```
]

#warn-box[
  TODO - wpisz ostrzeżenie dotyczące kodu lub środowiska, np. wymagane zależności, specyficzne ustawienia kompilatora lub ograniczenia implementacji.
]


// ════════════════════════════════════════════════════════════════
//  4. WYNIKI I ANALIZA
//     Prezentacja wyników: zrzuty ekranu, tabele, wykresy.
//     TODO: dostosuj liczbę podsekcji do objętości wyników.
// ════════════════════════════════════════════════════════════════
= Wyniki i analiza

// ── 4.1 ─────────────────────────────────────────────────────────
// TODO: wstaw zrzut ekranu, wydruk konsoli lub wykres.
== Wyniki działania programu

// TODO: zastąp placeholder własnym zrzutem ekranu lub wydrukiem konsoli.
#figure(
  rect(width: 90%, height: 6cm, fill: luma(30), stroke: 0.5pt)[
    #align(center + horizon)[
      #text(fill: luma(160), style: "italic")[TODO - wstaw zrzut ekranu / wydruk konsoli / wykres]
    ]
  ],
  caption: [TODO - Wynik działania programu dla danych wejściowych: TODO.],
)

TODO - opisz i zinterpretuj uzyskane wyniki; odnieś się do oczekiwań teoretycznych.

// ── 4.2 ─────────────────────────────────────────────────────────
// TODO: uzupełnij tabelę własnymi danymi testowymi.
// TODO: dostosuj kolumny do specyfiki zadania (np. dodaj kolumnę „Czas wykonania [ms]").
== Tabela wyników

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, center, center),
    table.header([Dane wejściowe], [Wynik oczekiwany], [Wynik uzyskany]),
    [TODO - przypadek testowy 1], [TODO], [TODO],
    [TODO - przypadek testowy 2], [TODO], [TODO],
    [TODO - przypadek testowy 3], [TODO], [TODO],
  ),
  caption: [Zestawienie wyników testów.],
  kind: table,
)

// ── 4.3 ─────────────────────────────────────────────────────────
// TODO: użyj tej tabeli do porównania wariantów, parametrów lub złożoności.
// TODO: usuń tę podsekcję, jeśli nie porównujesz kilku wariantów.
== Tabela zbiorcza / porównawcza

#figure(
  table(
    columns: (2fr, 1fr, 1fr, 1fr),
    align: (left, center, center, center),
    table.header([Parametr], [Wariant A], [Wariant B], [Wariant C]),
    [TODO - parametr 1], [TODO], [TODO], [TODO],
    [TODO - parametr 2], [TODO], [TODO], [TODO],
    [TODO - parametr 3], [TODO], [TODO], [TODO],
  ),
  caption: [TODO - Tabela zbiorcza porównująca warianty rozwiązania lub dane eksperymentalne.],
  kind: table,
)

#tip-box[
  TODO - wpisz obserwację analityczną, np. który wariant jest najefektywniejszy i dlaczego, lub jakie wnioski wynikają z zestawienia wyników.
]

// ════════════════════════════════════════════════════════════════
//  5. PODSUMOWANIE I WNIOSKI
//     Ocena wyników, wnioski merytoryczne, napotkane trudności.
//     TODO: napisz co najmniej 2-3 merytoryczne wnioski.
// ════════════════════════════════════════════════════════════════
= Podsumowanie i wnioski

*1. TODO - Tytuł wniosku pierwszego:*

TODO - opisz wniosek wynikający z ćwiczenia.

*2. TODO - Tytuł wniosku drugiego:*

TODO - opisz drugi wniosek merytoryczny.

*3. TODO - Napotkane trudności / źródła rozbieżności:*

// TODO: usuń tę podsekcję, jeżeli w zadaniu nie wystąpiły żadne trudności.

- *TODO - Trudność 1:* - opis problemu i sposób jego rozwiązania.
- *TODO - Trudność 2:* - opis problemu i sposób jego rozwiązania.
- *TODO - Ewentualne rozbieżności wyników:* TODO - wyjaśnij, dlaczego wyniki różnią się od oczekiwanych (jeśli dotyczy).


// ════════════════════════════════════════════════════════════════
//  6. SPIS TREŚCI
// ════════════════════════════════════════════════════════════════

#pagebreak()

#outline()
