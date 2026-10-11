#set text(font: "Source Sans 3", size: 10pt)
// TODO HIER ANPASSUNGEN VORNEHMEN
#let name = [Max Mustermann] // Vorname Nachname
#let studiengang = [Maschinenbau]
#let matrikel = [MAB 0000]
#let matrikelnummer = [00000000]
#let thema = [Das Thema der Arbeit]
#let abgabedatum = [00.00.0000]
#let master = false // für Bachelor auf false setzen
#let abschluss = ([Engineering], [Eng]) // Abschluss setzen
#let erstprüfer = [Prof. Dr. Erstprüfer]
#let zweitprüfer = [Prof. Dr. Zweitprüfer]

// Hilsfunktion für die Felder mit Linie darunter
#let textfeld(inhalt, unterschrift, breite: auto) = {
  grid(
    columns: breite,
    row-gutter: 0pt,

    pad(inhalt, bottom: 0.5em),
    grid.hline(stroke: 0.5pt),
    pad(text(unterschrift, size: 0.8em, fill: black.lighten(30%)), top: 1em),
  )
}


#page(margin: (left: 2.5cm, right: 1.5cm))[
  #place(
    top + right,
    dx: 2%,
    dy: -6%,
    image("../assets/HSA Deckblatt Logo.jpg", width: 65%),
  )


  // Linke Seite
  #place(left + top, block(width: 48%, {
    v(44%)
    textfeld(name, [Vorname Nachname], breite: 100%)
    v(3%)
    textfeld([#studiengang, #matrikel, #matrikelnummer], [Studiengang, Matrikel, Matrikelnummer], breite: 100%)
  }))

  // Rechte Seite
  #place(
    right + top,
    block(
      width: 48%,
      {
        v(35%)
        grid(
          columns: 100%,
          align: left,
          gutter: 0.5em,
          text(
            font: "Montserrat",
            weight: "semibold",
            fill: red,
            size: 18pt,
            if master [Masterarbeit] else [Bachelorarbeit],
          ),
          pad(
            left: 0.2em,
          )[zur Erlangung des akademischen Grades\ #if master [Master of #abschluss.at(0) (M. #abschluss.at(1).)] else [Bachelor of #abschluss.at(0) (B. #abschluss.at(1).)]],
        )

        v(15%)

        // Unterer Teil: Thema
        grid(
          columns: 100%,
          align: left,
          gutter: 0.6em,
          [Thema:],
          text(
            weight: "bold",
            thema
          ),
        )
        v(1fr)
        align(left, textfeld(
          erstprüfer,
          [Vorsitzende(r) der Masterprüfungskommission/1. Prüfer(in)],
          breite: 100%,
        ))
        v(1%)
        align(left, textfeld(zweitprüfer, [2. Prüfer(in)], breite: 100%))
        v(2%)
        align(left, textfeld(abgabedatum, [Abgabe am], breite: 100%))
      },
    ),
  )

]
