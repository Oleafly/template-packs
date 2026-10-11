#import "@preview/tidy:0.4.3"
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#codly(languages: codly-languages)

#set page(
    paper: "a4",
    margin: (top: 25mm, bottom: 25mm, left: 25mm, right: 25mm),
  )
#set text(lang: "pl")
#set text(
    font: "New Computer Modern",
    size: 12pt
)
#show math.equation: set text(font: "New Computer Modern Math")
#set par(first-line-indent: 0pt, justify: true)
#set page(numbering: "1")
#set document(title: [Instrukcja do szablonu prezentacji SGH], author: "Piotr Kuszewski")

#title()
Piotr Kuszewski, marzec 2026

= Przygotowanie prezentacji 

Prezentacja jest normalnym dokumentem Typst. Włączenie pakietu `touying`, a następnie załadowanie szablonu prezentacji SGH sprawi, że kolejne strony wyjściowego pliku pdf będą sformatowane jako slajdy. Minimalna prezentacja może mieć strukturę zgodną z kodem poniżej. Niektóre fragmenty kodu zostały wstawione jako komentarz. Można usunąć znaki `//` i włączyć dodatkowe opcje.

```typst
#import "@preview/touying:0.7.4": *
#import "@preview/sgh-presentation:0.1.2": *

#set text(lang: "pl") // Logo SGH zmienia się po zmianie języka: "pl", "en"

#show: sgh-presentation-theme.with(
  config-info(
    title: [Prezentacja],
    //subtitle: [coś jeszcze],
    author: [Ijon Tichy],
    //institution: [SGH],
    date: [Marzec 2026],
  ),
  // footer: [Dodatkowe informacje w stopce],
  // footer-progress: true, // Odkomentuj jeśli chcesz mieć pasek postępu na dole 
  // aspect-ratio: "4-3",   // Odkomentuj jeśli chcesz mieć slajdy w formacie 4:3, a nie 16:9
)

// Jeśli chcesz numerować równania...
#set math.equation(numbering: "(1)")

#title-slide()

= Sekcja

== Pierwszy slajd
Treść pierwszego slajdu.

== Drugi slajd
Treść drugiego slajdu.

= Druga sekcja

== Trzeci slajd
Treść trzeciego slajdu.
```

Kluczowe jest skonfigurowanie szablonu przez wywołanie `#show: sgh-presentation-theme.with(...)` a następnie wstawienie slajdu tytułowego przez `#title-slide()`. Kolejne slajdy można tworzyć procedurą `#slide` opisaną dalej, ale najprostszym rozwiązaniem jest stosowanie sekcji pierwszego poziomu (`=`) do oznaczenia sekcji dokumentu, które wyróżnione slajdem z dużym tytułem. Każdy kolejny slajd można rozpoczynać jako sekcję drugiego poziomu (`==`). Taka sekcja będzie rozkładana na wiele slajdów, jeśli jej treść nie zmieści się na jednym slajdzie.

= Fonty

Szablon prezentacji SGH wymaga dodatkowych fontów. Jeśli korzystamy z Typst bezpośrednio na naszym komputerze, a nie przez http://typst.app , musimy je zainstalować samodzielnie. Standardowym fontem prezentacyjnym w oficjalnym szblonie PowerPoint SGH jest Open Sans. Ten font jest dostępny za darmo na stronie Google. Niestety ten font powoduje pewne problemy w Typst ze względu na niezdefiniowanie w foncie niektórych krojów pisma. Dobrą alternatywą dla Open Sans, która jest publicznie dostępny font Lato. Jest to font bezszeryfowy o wysokiej czytelności i neutralnym, ale przyjaznym charakterze, co czyni go uniwersalnym wyborem dla prezentacji.

= Opis procedur zawartych w szablonie

#let docs = tidy.parse-module(read("sgh-presentation.typ"), name: none)
#tidy.show-module(docs)

