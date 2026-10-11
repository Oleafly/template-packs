#import "/szablon/template.typ": rysunek, tabela, listing, blok-kodu, odnosnik

= Tutorial

Ten rozdział pokazuje, jak wypełnić szablon dokumentacji zespołowego przedsięwzięcia inżynierskiego. Przy pisaniu właściwej pracy zastępuje się go rozdziałem „Ogólne określenie wymagań”. Zostawia się rozdziały o analizie problemu, projektowaniu, implementacji i wnioskach, a potem literaturę oraz spisy rysunków, tabel i listingów.

== Plik główny

Dane projektu wpisuje się w `main.typ`, w wywołaniu `praca`. Wpisuje się pola, które mają być inne niż w szablonie. Nazwa uczelni, wydział, katedra oraz napis „DOKUMENTACJA PROJEKTU” są w `szablon/template.typ`. Nagłówek strony bierze nazwę uczelni w jednej linii. Stopka składa się z rodzaju dokumentu i przedmiotu, na przykład „DOKUMENTACJA PROJEKTU - ZESPOŁOWE PRZEDSIĘWZIĘCIE INŻYNIERSKIE”.

#blok-kodu("#show: praca.with(
  tytul: [Tytuł projektu\\ z drugą linią],
  przedmiot: [ZESPOŁOWE PRZEDSIĘWZIĘCIE INŻYNIERSKIE],
  autorzy: (
    \"Imię Nazwisko\",
    \"Imię2 Nazwisko2\",
  ),
  prowadzacy: [mgr inż. Imię Nazwisko],
)", jezyk: "typ")

Tytuł łamie się znakiem `\` wewnątrz nawiasu kwadratowego. Autorzy to lista napisów. Pusty napis jest pomijany, więc lista może mieć dowolną długość. Rok na stronie tytułowej jest rokiem kompilacji. Inny rok podaje się argumentem `rok: [2026]`.

Dla sprawozdania laboratoryjnego dopisuje się `dokument: [SPRAWOZDANIE]`. Stopka zaczyna się wtedy od tego napisu, a przedmiot zostaje wspólny ze stroną tytułową. Szkic z datą włącza `draft: true`.

== Ustawienia składu

Słownik `knobs` zmienia stronnicowanie, kolor łączy i blok kodu. Wpisuje się tylko pola, które mają się różnić od domyślnych. Pozostałe zostają.

Domyślne stronnicowanie to `"n-z-n"`, czyli zapis „2 z 13”. Sam numer strony włącza `"prosty"`. Łącza są w kolorze tekstu, bo `kolor-linku` ma wartość `none`. Inny kolor podaje się na przykład jako `kolor-linku: blue`.

Blok kodu domyślnie numeruje linie, ma tło `#f2f2eb` i nie ma ramki. W `knobs.kod` zmienia się `numeracja`, `tlo`, `kolor-tekstu`, `kolor-numeru`, `kolor-slowa`, `kolor-komentarza`, `kolor-napisu`, `ramka` i `kolor-ramki`. Jeden listing może to nadpisać argumentami `numeracja` i `kolory`, bez zmiany reszty dokumentu.

#blok-kodu("#let knobs = (
  stronnicowanie: \"prosty\",
  kolor-linku: none,
  kod: (
    numeracja: false,
    ramka: true,
    kolor-ramki: rgb(\"#000000\"),
  ),
)
#show: praca.with(
  // tytuł, przedmiot, autorzy, prowadzący
  knobs: knobs,
)", jezyk: "typ")

Czcionka tekstu to Liberation Sans, a kodu Liberation Mono. Margines wewnętrzny ma 3,5 cm, a zewnętrzny, górny i dolny po 2,5 cm. Interlinii, nagłówka i stopki nie zmienia się w plikach rozdziałów.

== Rozdziały

Nowy rozdział to katalog `praca/<nazwa>/` z plikiem `rozdzial.typ` oraz wiersz `#include` w `main.typ`, za spisem treści i przed bibliografią. Na początku pliku rozdziału importuje się funkcje szablonu.

#blok-kodu("#import \"/szablon/template.typ\": rysunek, tabela, listing, odnosnik

= Tytuł rozdziału

Tekst akapitu.

== Tytuł podrozdziału", jezyk: "typ")

Nagłówek rozdziału to jeden znak `=`, podrozdział to `==`, a kolejny poziom to `===`. Na końcu tytułu nie stawia się kropki. Rysunek, tabelę i listing wstawia się po zdaniu, które do nich odsyła. Rozdział nie może składać się z samych obiektów.

Pliki programu trzyma się w katalogu `kod/`. Bibliografia jest w `praca/literatura.bib`.

== Kompilacja

W Codespace oraz lokalnie w VS Code i Cursor skrót Ctrl+Shift+B otwiera zadania z `.vscode/tasks.json`:

+ „compile PDF with typst” uruchamia `typst compile main.typ` i tworzy `main.pdf`,
+ „cleanup ” usuwa `main.pdf`,
+ „compile PDF with typst - docker” składa dokument obrazem Dockera, bez lokalnego pakietu `typst`.

Codespace tworzy się na GitHubie: Code, potem Create Codespace on main. Obraz z `.devcontainer` zawiera program `typst`. W edytorze są rozszerzenia Tinymist i Typst LSP, więc `main.typ` ma podświetlenie składni.

Lokalnie, po instalacji pakietu `typst`, w katalogu projektu uruchamia się:

#blok-kodu("typst compile main.typ", jezyk: "bash")

Gdy pakietu nie ma w systemie, to samo robi Docker:

#blok-kodu("docker run --rm -v \"$(pwd):/data\" -w /data ghcr.io/typst/typst compile main.typ", jezyk: "bash")

== Wydanie na GitHubie

Plik `.github/workflows/compile-to-pdf.yaml` uruchamia się po wypchnięciu tagu gita, którego nazwa zaczyna się od `v`, na przykład `v1.0.0`. Akcja instaluje program `typst`, kompiluje `main.typ` i tworzy wydanie z załączonym `main.pdf`. Nazwa wydania jest nazwą tagu.

#blok-kodu("git tag v1.0.0
git push origin v1.0.0", jezyk: "bash")

Tag bez prefiksu `v` tej akcji nie uruchamia. Wypchnięcie samego commita też nie.

== Rysunki

Rysunek wstawia funkcja `rysunek`. Plik graficzny podaje się przez `image`. Ścieżka liczy się od pliku rozdziału, a szerokość podaje się przy `image`. Etykieta za wywołaniem, w nawiasie ostrym, służy do odesłania.

#blok-kodu("#rysunek(
  image(\"sources/nazwa.png\", width: 12cm),
  [Opis rysunku],
) <id-rysunku>

#odnosnik(<id-rysunku>)", jezyk: "typ")

`odnosnik` przy rysunku dopisuje słowo „Rysunek”, numer w obrębie rozdziału i stronę. #odnosnik(<id-rysunku>) jest rysunkiem złożonym w Typst, bez osobnego pliku.

#rysunek(
  rect(width: 100%, height: 2.4cm, stroke: 0.6pt, inset: 8pt)[
    #align(center + horizon)[Opis tego, co jest na rysunku]
  ],
  [Opis tego, co jest na rysunku],
) <id-rysunku>

Podpis stoi pod rysunkiem. W spisie rysunków trafia ten sam opis.

== Tabele

Tabelę wstawia funkcja `tabela`. Pierwszy argument to podpis, drugi to tabela Typst. W tekście przed odsyłaczem pisze się słowo „Tabela”, bo `odnosnik` podaje sam numer i stronę.

#blok-kodu("#tabela(
  [Opis tabeli],
  table(
    columns: 2,
    stroke: 0.5pt,
    align: center,
    [A], [B],
  ),
) <id-tabeli>

Tabela #odnosnik(<id-tabeli>)", jezyk: "typ")

Tabela #odnosnik(<tablica001>) podaje napięcie i prąd. W komórce może stać wzór.

#tabela(
  [Tabelka przykładowa],
  table(
    columns: 2,
    stroke: 0.5pt,
    align: center,
    [$U_n$], [$I_(z w)$],
    [$k V$], [$%$],
    [7.2], [100],
  ),
) <tablica001>

Podpis stoi nad tabelą.

== Listingi

Krótki fragment zapisany w pliku rozdziału wstawia się funkcją `listing`. Język podaje argument `jezyk`, żeby włączyć kolory składni. W tekście przed odsyłaczem pisze się „Kod”.

#blok-kodu("#listing([Opis], ```cpp
int main() { return 0; }
```, jezyk: \"cpp\") <id-kodu>

Kod #odnosnik(<id-kodu>)", jezyk: "typ")

Kod #odnosnik(<listing-krotki>) zwraca zero.

#listing([Krótki program], ```cpp
int main() { return 0; }
```, jezyk: "cpp") <listing-krotki>

Dłuższy plik z katalogu `kod` wczytuje argument `plik`. Ścieżka zaczyna się ukośnikiem i jest liczona od katalogu głównego projektu. Jeden listing może wyłączyć numerację linii albo podać własne kolory: `numeracja: false`, `kolory: (tlo: rgb("#eeeeee"))`.

#blok-kodu("#listing(
  [Opis pliku],
  plik: \"/kod/main.cpp\",
  jezyk: \"cpp\",
) <id-pliku>", jezyk: "typ")

Kod #odnosnik(<listing-cpp2>) zapisuje prostą stronę HTML.

#listing([Przykładowy kod z pliku], plik: "/kod/main.cpp", jezyk: "cpp") <listing-cpp2>

Plik z polskimi znakami wczytuje się tak samo. Kod #odnosnik(<prompt>) pokazuje wywołanie rysunku i zestaw liter.

#listing([Opis promptu], plik: "/kod/prompt.txt") <prompt>

== Literatura

Źródło podaje się w zdaniu przez `cite`, z kluczem z pliku `praca/literatura.bib`. Pozycja wchodzi do literatury tylko wtedy, gdy tekst ją cytuje. Styl numerów jest w szablonie.

#blok-kodu("@book{legierski,
  author = {Legierski, Tadeusz and Wyrwał, Janusz},
  title = {Programowanie Sterowników PLC},
  year = {1998},
}

Książkę przywołuje się tak: #cite(<legierski>).", jezyk: "typ")

Książkę przywołuje się tak: #cite(<legierski>). Stronę internetową przywołuje się tak: #cite(<www1>).
