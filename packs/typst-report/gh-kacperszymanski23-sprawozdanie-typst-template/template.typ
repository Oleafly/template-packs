// ╔══════════════════════════════════════════════════════════════╗
// ║   W.I.P. SZABLON SPRAWOZDANIA - Politechnika Krakowska       ║
// ║   PLIK: template.typ                                         ║
// ║   Szablon dokumentu importuj ten plik w swoim sprawozdaniu   ║
// ║   Nie zmieniaj tego pliku!                                   ║
// ╚══════════════════════════════════════════════════════════════╝

// ── JAK UŻYWAĆ ───────────────────────────────────────────────────
//
//  1. Uzupełnij pola TODO w sekcji STRONA TYTUŁOWA poniżej.
//  2. Zastąp przykładowe akapity własną treścią.
//  3. Użyj  #eq($...$)                    dla ponumerowanych równań.
//  4. Użyj  #code-block(lang: "...")[`...`]  dla fragmentów kodu.
//  5. Użyj  #warn-box[...]                dla ostrzeżeń.
//  6. Użyj  #info-box[...]                dla notatek informacyjnych.
//  7. Użyj  #tip-box[...]                 dla wskazówek i podpowiedzi.
//  8. Użyj  #note-box[...]                dla dodatkowych notatek.
//  9. Użyj  #figure(image("ścieżka/do/obrazu.jpg", width: 80%), caption: [...])
//           dla wszystkich rysunków, zrzutów ekranu i innych grafik.
//  10. Kompiluj:  typst compile main.typ
//
// ─────────────────────────────────────────────────────────────────

// --- PALETA KOLORÓW ---
#let navy = rgb("#013571")
#let navy2 = rgb("#2b4f6f")
#let navy3 = rgb("#3b6080")
#let navy4 = rgb("#4b7092")
#let gold = rgb("#c8973a")
#let navy-bg = rgb("#e8eef5")
#let stripe = rgb("#f4f7fb")
#let warn-bg = rgb("#fff8e6")
#let warn-br = rgb("#e0a020")
#let info-bg = rgb("#eef4fb")
#let info-br = navy
#let tip-bg = rgb("#eef8f0")
#let tip-br = rgb("#2e7d32")
#let note-bg = rgb("#f8f9fa")
#let note-br = rgb("#a1a1a1")


// --- RAMKI RÓŻNE ---
#let generic-box(body, fill-bg, fill-br, label) = block(
  fill: fill-bg,
  stroke: (left: 3pt + fill-br, rest: 0.4pt + fill-br),
  inset: 10pt,
  radius: (right: 4pt),
  width: 100%,
  breakable: false,
  stack(dir: ttb, spacing: 6pt, text(fill: fill-br, weight: "bold", size: 1.1em)[#label], body),
)

#let warn-box(body) = generic-box(
  body,
  warn-bg,
  warn-br,
  " Uwaga",
)

#let info-box(body) = generic-box(
  body,
  info-bg,
  info-br,
  " Informacja",
)

#let tip-box(body) = generic-box(
  body,
  tip-bg,
  tip-br,
  " Wskazówka",
)

#let note-box(body) = generic-box(
  body,
  note-bg,
  note-br,
  "󰠮 Notatka",
)

// --- RAMKA Z KODEM ---
#let code-block(
  body,
  lang: "CODE",
  font-size: 9.5pt,
  font-family: "Fira Code",
  syntax-theme: auto,
  current-line-number: 1,
) = block(
  width: 100%,
  inset: 10pt,
  radius: 4pt,
  fill: rgb("#1e2330"),
  stroke: (left: 3pt + gold),
  breakable: true,
)[
  #grid(
    columns: (1fr, auto),
    [], text(size: 8pt, fill: gold, font: font-family)[#lang],
  )
  #set text(font: font-family, size: font-size)
  #show raw: set text(fill: rgb("#e0e8f4"), ligatures: true, font: font-family)
  #show raw.where(block: true): code => {
    show raw.line: line => {
      let line-number = line.number + current-line-number - 1
      let num-str = if line-number < 10 { $"  "$ + str(line-number) } else { str(line-number) }
      text(fill: gray)[#num-str]
      h(1em)
      line.body
    }
    code
  }
  #set raw(theme: syntax-theme)
  #body
]

#let eq-counter = counter("equations")
#let eq(body) = {
  eq-counter.step()
  grid(
    columns: (1fr, auto),
    align: (center, right),
    $ #body $,
    context {
      set text(size: 9pt, fill: luma(120))
      v(0.25em)
      [(#eq-counter.display("1"))]
    },
  )
}

// Styl zapisu matematycznego
#set math.mat(delim: "[")
#set math.vec(delim: "[")


// --- GŁÓWNA FUNKCJA SZABLONU ---
#let report(
  title: "Brak tytułu",
  authors: (name: "Brak Autora"),
  department: "Wydział Inżynierii Elektrycznej i Komputerowej",
  type-of-study: "studia stacjonarne",
  field-of-study: "Informatyka w Inżynierii Komputerowej",
  course: "Nazwa przedmiotu",
  group: "Grupa",
  lecturer-name: "Imię Nazwisko",
  academic-title: "Tytuł",
  date: datetime.today(),
  date-format: auto,
  font: "Noto Sans",
  body,
) = {
  // Przygotowanie autorów
  let authors-string = if authors.len() > 1 {
    authors.map(author => author.name).join(", ")
  } else {
    authors.values().at(0)
  }

  // Metadane
  set document(title: title, author: authors-string, date: date)

  // Układ strony
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.8cm, left: 2cm, right: 2cm),
    numbering: "1",
    number-align: right,
    footer: context {
      set text(size: 8.5pt, fill: luma(130))
      line(length: 100%, stroke: 0.4pt + luma(180))
      v(2pt)
      grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        [#course · #title], [], [Strona #counter(page).display("1") / #counter(page).final().first()],
      )
    },
  )

  // Styl tekstu
  set text(font: font, size: 11pt, lang: "pl")
  set par(leading: 0.65em, justify: true)

  // Nagłówki
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    v(1.4em)
    block(width: 100%, below: 0pt)[
      #box(fill: navy, width: 4pt, height: 1.15em, radius: 1pt)
      #v(-2.1em)
      #h(8pt)
      #text(size: 13pt, weight: "bold", fill: navy, it.body)

    ]
    v(0.15em)
    line(length: 100%, stroke: 1pt + gold)
    v(0.45em)
  }
  show heading.where(level: 2): it => {
    v(0.9em)
    text(size: 11.5pt, weight: "bold", fill: navy2, it)
    v(0.25em)
  }
  show heading.where(level: 3): it => {
    v(0.6em)
    text(size: 11pt, weight: "bold", style: "italic", fill: navy3, it)
    v(0.2em)
  }

  // Styl tabeli
  set table(
    stroke: (x, y) => {
      if y == 0 { (bottom: 1.5pt + navy) } else { (bottom: 0.4pt + luma(200)) }
    },
    fill: (x, y) => {
      if y == 0 { navy-bg } else if calc.odd(y) { stripe }
    },
    inset: (x: 7pt, y: 6pt),
  )
  show table.cell.where(y: 0): set text(weight: "bold", fill: navy)

  show figure.caption: it => {
    set text(size: 9.5pt, style: "italic", fill: luma(80))
    it
  }

  // --- STRONA TYTUŁOWA ---
  align(center)[
    #v(0.4cm)

    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      image("pk_logo.svg", width: 2.5cm), image("weik_logo.svg", width: 2.5cm),
    )

    #v(0.35cm)

    #line(length: 100%, stroke: 2pt + navy)
    #v(2pt)

    #line(length: 100%, stroke: 1pt + gold)
    #v(0.4cm)

    #block(width: 100%)[
      #table(
        columns: (1fr, 1fr, 1fr, 1fr),
        stroke: 0.5pt + luma(160),
        inset: 8pt,

        table.header(
          table.cell(
            colspan: 4,
            fill: navy,
            align: center,
            text(fill: white, weight: "bold")[POLITECHNIKA KRAKOWSKA\ ]
              + text(fill: rgb("#c8d8ea"), size: 10pt)[#department],
          ),
          table.cell(colspan: 4, fill: navy, align: center, text(
            fill: rgb("#d8e8f4"),
            size: 10pt,
          )[#course, #type-of-study]),
        ),

        table.cell(fill: luma(248))[*Kierunek:*], table.cell(fill: none)[#field-of-study],
        table.cell(rowspan: 2, fill: luma(248))[*Prowadzący:*],
        table.cell(rowspan: 2, fill: none)[#academic-title #lecturer-name],
        table.cell(fill: luma(248))[*Grupa:*], table.cell(fill: none)[#group],
        table.cell(fill: luma(248))[*Data:*], table.cell(fill: none)[#date.display(date-format)],
        table.cell(fill: luma(248))[*Ocena:*], table.cell(fill: none)[],
        table.cell(fill: luma(248))[*Temat:*], table.cell(fill: none, colspan: 3)[#title],
        table.cell(fill: luma(248))[*#(if authors.len() > 1 { "Skład zespołu:" } else { "Wykonał:" })*],
        table.cell(fill: none, colspan: 3)[#(authors-string)],
      )
    ]
    #v(6pt)
    #line(length: 100%, stroke: 1pt + gold)
    #v(2pt)
    #line(length: 100%, stroke: 2pt + navy)
  ]
  v(1cm)

  body
}
