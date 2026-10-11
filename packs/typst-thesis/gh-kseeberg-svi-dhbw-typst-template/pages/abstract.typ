#import "../template.typ": authors, company, course-name, date, title

#heading(outlined: false, "Abstract")
#context {
  set par(justify: true, leading: 1.25em, spacing: 1.25em)
  set text(size: 12pt)
  table(
    columns: (4fr, 11fr),
    inset: (x: 0em, y: 0.75em),
    stroke: none,
    table.header(
      [#text(weight: "bold", "Titel:")], [#title],

      [#text(weight: "bold", "Verfasser:")], [#authors.join(", ")],
      [#text(weight: "bold", "Kurs:")], [#course-name],
      [#text(weight: "bold", "Unternehmen:")], [#company],
    ),
  )

  [
    // Lorem löschen!
    #lorem(200)

    // Als kleine Unterstützung sind hier ein paar Tipps für das Schreiben des Abstracts:
    // Jeweils maximal 1-2 Sätze. Im Präsens schreiben. Vorgehensweise wird im Perfekt verfasst. Keinen Bezug auf Literatur nehmen und nicht zitieren.

    // Gliederung:
    // 1. Einführung in das Thema
    // 2. Motivation + Relevanz
    // 3. Forschungslücke
    // 4. Ziel der Arbeit
    // 5. Methode
    // 6. Ergebnisse
    // 7. Interpretation
  ]
}

#pagebreak()
