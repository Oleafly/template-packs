#let breakable_text(text) = {
  text
    .replace(".", ".\u{200B}")
    .replace("@", "@\u{200B}")
    .replace("-", "-\u{200B}")
}

#let dhbw_header = {
  set text(font: "Libertinus Serif")
  context {
    grid(
      stroke: none,
      columns: (1fr, 1fr),
      row-gutter: 2pt,
      grid.hline(stroke: .50pt + black),
      align(
        left,
        grid(
          stroke: none,
          columns: 2,
          column-gutter: 0.5em,
          image("dhbw_logo.svg", height: 1.7cm),
          place(
            dy: 10.5pt,
            text(
              size: 26.5pt,
              weight: 300,
              font: "Roboto",
              stretch: 70%,
              fallback: false,
              //kerning: true,
              tracking: -.6pt,
              //fill: rgb(r, g, b, a)

              fill: rgb(93, 105, 113, 100%),
              stroke: rgb(93, 105, 113, 100%) + 0.5pt,
              "Karlsruhe",
            ),
          ),
        ),
      ),

      align(
        right + bottom,
        box(
          inset: (bottom: 3pt),
          text(size: 2.3em, weight: "extralight", [Informatik]),
        ),
      ),
      grid.hline(stroke: .50pt + black),
      if counter(page).get().first() == 1 {
        grid.cell(
          colspan: 2,
          place(
            dy: 5pt,
            grid(
              rows: 2,
              row-gutter: 3pt,
              box(
                stroke: (0.4pt + black),
                width: 100%,
                fill: rgb("#bbbbbb"),
                inset: 0.4em,
                grid(
                  columns: (1fr, 1fr),
                  text(
                    size: 1.0em,
                    weight: "bold",
                    font: "Roboto",
                    [Anmeldung einer Projektarbeit],
                  ),
                  align(
                    right + bottom,
                    text(
                      size: 0.8em,
                      [Stand #datetime(day: 11,month: 4,year: 2024).display("[day].[month].[year]")],
                    ),
                  ),
                ),
              ),
              text(
                size: 0.8em,
                weight: "thin",
                [
                  Studiengang Informatik, DHBW Karlsruhe\
                  Erzbergerstraße 121, 76133 Karlsruhe
                ],
              )
            ),
          ),
        )
      }
    )
  }
}


#let anmeldung(
  student: "",
  student_email: "",
  student_kurs: "",
  student_matrikel_nummer: "",
  titel: "",
  dualer_partner: "",
  anschrift: "",
  betreuer_name: "",
  betreuer_akademischer_titel: "",
  betreuer_telefon_nummer: "",
  betreuer_email: "",
  problemstellung: "",
  geplantes_vorgehen: "",
  literatur: "",
  module: "",
  sprache: "",
  datum: "",
) = {
  set page(
    margin: (top: 4cm, bottom: 2cm, left: 2cm, right: 2cm),
    header: align(bottom, box(height: 2cm, dhbw_header)),
    footer: text(
      size: 0.8em,
      grid(
        columns: (auto, 1fr),
        align(left + bottom, text("TINF-Themenmitteilung-2024-04-11")),
        align(right + bottom, [Seite #context {counter(page).display("1")}]),
      ),
    ),
  )
  set text(font: "Roboto")
  v(0.7cm)
  text(
    size: 1em,
    [
      Bitte die ausgefüllte Anmeldung in Ihren Moodle-Kursraum als PDF-Datei hochladen.
    ],
  )
  let modules = (
    "Projektarbeit IIa (Modul T3_2000, Praxisprojekt II, 3. Semester)",
    "Projektarbeit IIb (Modul T3_2000, Praxisprojekt II, 4. Semester)",
    "Große Projektarbeit II (Modul T3_2000, Praxisprojekt II, 3. - 4. Semester)",
    "Projektarbeit III (Modul T3_3000, Praxisprojekt III, 5. Semester)",
    "Studienarbeit (Modul T_3101, 5. - 6. Semester)",
    "Bachelorarbeit (Modul T_3300, 6. Semester)",
  )
  v(0.2pt)
  box(
    inset: (left: 2em),
    align(
      left,
      for i in modules {
        if i == module {
          [
            #box(
              width: 0.75em,
              height: 0.75em,
              stroke: 1.1pt + black,
              radius: 1pt,
              //fill: black,
              align(
                center + horizon,
                text(weight: "bold", size: 1.3em, sym.crossmark),
              ),
            ) #text(weight: "bold", size: 1.0em, i)\
          ]
        } else {
          [
            #box(
              width: 0.75em,
              height: 0.75em,
              stroke: 1.1pt + black,
              radius: 1pt,
            ) #text(weight: "bold", size: 1.0em, i)\
          ]
        }
      },
    ),
  )

  v(0.3cm)
  let table_data = (
    [#align(horizon, [*Titel der Arbeit*])],
    [#titel],
  )
  table_data.push(
    align(
      horizon,
      text(
        weight: "bold",
        [Motivation,\ Problemstellung,\ Erwartetes Ergebnis],
      ),
    ),
  )
  table_data.push([#problemstellung])
  table_data.push(align(horizon, [*Geplantes Vorgehen*]))
  table_data.push([#geplantes_vorgehen])
  table_data.push(align(horizon, [*Literaturliste*]))
  table_data.push([#bibliography("literatur.bib", title: "", full: true)])
  table_data.push([*Sprache der\ Ausarbeitung*])
  table_data.push(align(horizon, [#sprache]))
  table_data.push([*Datum der Erstellung\ der Themenmitteilung*])
  table_data.push(align(horizon, [#datum.display("[day].[month].[year]")]))

  let dual_table = table(
    columns: (auto, 1fr),
    rows: (auto, auto, auto, auto, 1fr),
    stroke: none,
    table.vline(x: 0, stroke: .50pt + black),
    table.vline(x: 1, position: end, stroke: .50pt + black),
    table.vline(x: 1, position: start, stroke: .50pt + black),
    table.hline(stroke: .50pt + black),
    [Dualer Partner], [#dualer_partner],
    table.hline(stroke: .50pt + black),
    [Betreuer/in], [#betreuer_name],
    [akad. Titel/Studium], [#betreuer_akademischer_titel],
    [Email], [#breakable_text(betreuer_email)],
    [Tel.], [#betreuer_telefon_nummer],
    table.hline(stroke: .50pt + black),
  )

  context {
    grid(
      rows: (4cm, auto, auto),
      row-gutter: 1.5em,
      grid(
        columns: 2,
        column-gutter: 1em,
        stroke: none,
        table(
          columns: (auto, auto),
          rows: (auto, auto, 1fr),
          stroke: none,
          table.vline(x: 0, stroke: .50pt + black),
          table.vline(x: 1, position: end, stroke: .50pt + black),
          table.vline(x: 1, position: start, stroke: .50pt + black),
          table.hline(stroke: .50pt + black),
          [Kurs], [#student_kurs],
          table.hline(stroke: .50pt + black),
          [Student/in], [#student],
          [Email], [#breakable_text(student_email)],
          table.hline(stroke: .50pt + black),
        ),
        dual_table,
      ),
      table(
        columns: (auto, 1fr),
        stroke: .50pt + black,
        ..table_data,
      ),
      [
        - Die Freigabe der Projektarbeitsthemen erfolgt durch die Studiengangsleitung. Wenn Sie nicht kurzfristig eine Rückmeldung erhalten gilt das Thema als freigegeben.
        - Studienarbeiten werden durch den Betreuer freigegeben.
        - Bachelorarbeiten werden durch den Prüfungsausschuss freigegenben.
      ],
    )
  }
}
