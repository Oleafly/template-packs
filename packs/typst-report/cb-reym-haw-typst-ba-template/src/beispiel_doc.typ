#import "../lib.typ": declaration-page, departments, thesis

#show: thesis.with(
  title: [Handreichung zur Formatierung von Bachelorarbeiten an der HAW],
  author: "Marlene Mustermann",
  erstprüfer: "Prof. Dr. Vera Musterfrau",
  zweitprüfer: "Prof. Dr. Heinz Musterdorf",
  department: departments.design,
  abstract-de: [
    Diese Arbeit beschreibt die Formatierung von Bachelorarbeiten am Department
    Medientechnik der HAW Hamburg. Die Zusammenfassung sollte etwa 150 bis 250
    Wörter umfassen und den Inhalt der Arbeit kurz beschreiben.
  ],
  abstract-en: [
    This thesis describes the formatting of bachelor theses at the Department
    of Media Technology at HAW Hamburg. The abstract should be about 150 to 250
    words and briefly describe the content of the thesis.
  ],
)

= Allgemeines

#lorem(30)

```rust
fn main() {
    println!("Hello World");
}

#[cfg(test)]
mod test {

    #[test]
    fn my_test() {
        assert_eq!(2, 1 + 1);
    }
}
```

#lorem(20)

#figure(caption: [Durchfallquoten Mathematik])[
  #table(
    columns: 5,
    align: left,
    stroke: none,

    table.hline(),

    text(fill: gray.darken(10%))[_Fntasiewerte_],

    [Jahr \ 2018], [\ 2019], [\ 2020], [\ 2021],

    [Sommersemester], [Sommersemester],
  )
]

#lorem(50)

= Die einzelnen Teile der Arbeit

== Überschrift 2
=== Überschrift 3
== Überschrift 4

= Typographie

#lorem(50)
#bibliography("./demo.bib", title: "Literatur", full: true)

#declaration-page(title: [Handreichung zur Formatierung von Bachelorarbeiten an der HAW])
