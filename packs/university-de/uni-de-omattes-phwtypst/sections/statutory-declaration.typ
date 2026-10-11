#import "../config/sections.typ": lower_roman_section
#import "../config/meta.typ": document_meta, colors, typography

#let statutory_declaration() = {
  lower_roman_section(
    "Eidesstattliche Erklärung",
    [
      Hiermit erkläre ich, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Alle Ausführungen, die anderen Schriften wörtlich oder sinngemäß entnommen wurden, sind kenntlich gemacht.

      #v(1cm) Die Arbeit wurde bisher in gleicher oder ähnlicher Form oder auszugsweise noch nicht im Rahmen einer anderen Prüfung vorgelegt. #v(2.5cm)

      #table(
        columns: (1fr, 1fr),
        stroke: none,
        align: (left, left),
        column-gutter: 2cm,
        [
          #document_meta.location, den #document_meta.submission_date.display("[day].[month].[year]")

          #line(length: 100%)

          #v(0.2cm)

          #text(size: typography.header_footer_size, fill: colors.subtle)[
            Ort, Datum
          ]

        ],
        [
          #text(fill: rgb(0, 0, 0, 0))[""]

          #line(length: 100%)

          #v(0.2cm)

          #text(size: typography.header_footer_size, fill: colors.subtle)[
            #document_meta.authors.at(0).name
          ]

        ],
      )
    ],
    reset_counter: false,
  )
}
