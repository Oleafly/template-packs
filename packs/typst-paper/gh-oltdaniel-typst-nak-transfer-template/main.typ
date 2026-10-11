#import "lib/lib.typ": *

// Register abbreviations and glossary
#import "dependencies.typ": make-glossary, print-glossary, register-glossary
#show: make-glossary
// Abbreviations
#import "abbreviations.typ": abbreviations-entry-list
#register-glossary(abbreviations-entry-list)
// Glossary
#import "glossary.typ": glossary-entry-list
#register-glossary(glossary-entry-list)

// Initialize template
#show: nak_tl.with(
  language: "de",
  title: "typst Vorlage für eine Transferleistung",
  author: "Max Mustermann",
  matriculation-number: 12345,
  transfermodule-number: 1,
  centurion: "Technische Informatik/IT-Engineering, T22",
  show-header-always: false,
  use-sans: false,
  before-content: {
    // Print abbreviations
    pagebreak(weak: true)
    heading(translations.abbreviations, numbering: none)
    print-glossary(
      abbreviations-entry-list,
      disable-back-references: true,
    )
  },
  after-content: {
    // Print glossary
    pagebreak(weak: true)
    heading(translations.glossary, numbering: none)
    print-glossary(
      glossary-entry-list,
      disable-back-references: true,
    )

    // Print bibliography
    pagebreak(weak: true)
    bibliography(
      "bibliography.bib",
      style: "ieee",
      title: translations.bibliography,
    )

    // Appendix
    pagebreak(weak: true)
    print-appendix({
      include "appendix.typ"
    })
  },
)

// --- Include content here ---
= Einführung in diese Vorlage

== Zitieren
#lorem(50) @nocera_software_2023

#lorem(30) @nocera_software_2023 @moskala_android_2017 @WinNT

== Abkürzungen und Glossar
@cpu #lorem(30)

@cpu:pl #lorem(30)

@ram #lorem(10)

== Codeblöcke

=== Inline-Code
Das Hinzufügen von `rbx` zu `rcx` ergibt
das gewünschte Ergebnis.

Was in Rust ```rust fn main()``` ist,
wäre in C ```c int main()```.

=== Codeblock
Dies ist ein Beispiel für einen einfachen Codeblock:
```rust
fn main() {
    println!("Hallo Welt!");
}
```

== Mathematik

Gesamte verdrängte Erde durch glazialen Fluss:

$
  7.32 beta +
  sum_(i=0)^nabla
  (Q_i (a_i - epsilon)) / 2
$

#pagebreak()

= Abbildungen

== Bilder

#lorem(50)

#figure(
  image("res/Hochschulleben.png", width: 60%),
  caption: "Hochschulleben",
) <hochschulleben>

Wie @hochschulleben zeigt, handelt es sich um einen Berg. #lorem(30)

== Tabellen

#figure(
  table(
    columns: 4,
    table.header([Kriterium], [Gewichtung], [Lösung 1], [Lösung 2]),
    [Funktionale Eignung], [9.4%], [5], [3],
    [Leistungseffizienz], [16.9%], [5], [3],
    [Kompatibilität], [6.0%], [5], [4],
    [Benutzerfreundlichkeit], [5.8%], [4], [5],
    [Zuverlässigkeit], [18.9%], [5], [4],
    [Sicherheit], [23.3%], [4], [5],
    [Wartbarkeit], [14.0%], [3], [5],
    [Portabilität], [5.7%], [4], [5],
    table.cell(colspan: 2)[Gesamtpunktzahl], [4.372], [4.225],
  ),
  caption: [Ein allgemeineres Tabellenbeispiel],
) <tabelle-generisch>

@tabelle-generisch zeigt ein Beispiel für die Standard-Typst-Tabelle mit einer Zelle, die sich über 2 Spalten erstreckt.

#pagebreak()

= Allgemeine Funktionen

Eine einfache Aufzählung lässt sich in Typst mit + beginnen

Dies ist eine weitere Zeile

#lorem(20)

Hier ist etwas zusätzlicher Blindtext, um die Seite zu füllen Hier ist etwas zusätzlicher Blindtext, um die Seite zu füllen Hier ist etwas zusätzlicher Blindtext, um die Seite zu füllen, wie man sehen kann. Dies ist ein Verweis auf den Anhang mit dem Code-Listing.

- Normale Liste.
  - Text
  - Mathematik
  - Layout

Hier ein Text, der einige wichtige Dinge erklärt, aber es gibt etwas, das eine Fußnote benötigt, zum Beispiel das Wort abcd#footnote([abcd steht für "die Nordakademie", siehe #link("https://nordakademie.de")]). Wenn wir innerhalb des Textes einen Link hinzufügen wollen, #link("https://nordakademie.de")[können wir das tun].
