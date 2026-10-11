// ##############################################
// #                                            #
// #           DO NOT EDIT THIS CODE            #
// #       Instructions are in `main.typ`       #
// #                                            #
// #  ┌──────────────────────────────────────┐  #
// #  │   Unless you know what you are doing │  #
// #  │   and want to edit this template.    │  #
// #  └──────────────────────────────────────┘  #
// #                                            #
// ##############################################
//
// Copyright (c) 20?? Fachschaft Mathematik / Informatik am KIT
// Copyright (c) 2015 Moritz Klammler <moritz.klammler@student.kit.edu>
// Copyright (c) 2025 Lukas Löring <lukas.loering@student.kit.edu>
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this  software and  associated documentation  files (the  "Software"), to
// deal in the  Software without restriction, including  without limitation the
// rights to use, copy, modify,  merge, publish, distribute, sublicense, and/or
// sell copies of the  Software, and to permit persons to  whom the Software is
// furnished to do so, subject to the following conditions:
// The above copyright  notice and this permission notice shall  be included in
// all copies or substantial portions of the Software.
// THE SOFTWARE IS  PROVIDED "AS IS", WITHOUT WARRANTY OF  ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING  BUT NOT  LIMITED TO  THE WARRANTIES  OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS  OR COPYRIGHT  HOLDERS BE  LIABLE FOR  ANY CLAIM,  DAMAGES OR  OTHER
// LIABILITY,  WHETHER IN  AN ACTION  OF CONTRACT,  TORT OR  OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

#import "helpers.typ": *

// Use this if a field has no value or cannot be provided.
#let N-A = "N/A"

// --- Template Entry Point ---
#let protocol-template(data, it) = [

  // How wide the logo is shown in the headaer
  #let logo-size = 20mm
  // How much space in inserted in the 2-column parts of the layout
  #let horizontal-gutter = 5mm
  // How large the cornered box is drawn for the barcode
  #let barcode-height = 25mm
  // How much space is inserted, for fields which will be filled out.
  // To accomdate someone filling out the template by hand, 10mm is chosen as a default
  #let line-height = 10mm
  // The margins of the page. Uses only 10mm to optimize use of space.
  #let page-margin = 10mm
  // The base font size. All other font sizes are relative to this one.
  #let font-size = 10pt

  // --- Page Setup and Type Setting ---
  #set text(lang: "de", font: "New Computer Modern", size: font-size)
  #set page(
    "a4",
    margin: page-margin,
    footer: align(end)[$#sym.arrow.r.hook$ *Rückseite bitte nicht vergessen!*],
  )
  #set par(justify: true)

  // --- Header ---
  #grid(
    columns: (logo-size, 1fr),
    align: horizon,
    gutter: horizontal-gutter,
    image("fsmi-logo.svg", width: logo-size),
    [
      #set text(1.4em)
      Fragebogen der Fachschaft zu\
      *mündlichen Prüfungen*\
      im Informatikstudium
    ],
  )
  #v(5mm)
  // --- Intro Text and Barcode ---
  #grid(
    columns: (1fr, 1fr),
    // Separates the barcode Text from the corner box
    row-gutter: 3mm,
    column-gutter: horizontal-gutter,
    [], align(center, text(size: 0.9em, "Barcode:")),
    [
      Dieser Fragebogen gibt den Studierenden, die nach dir die Prüfung ablegen
      wollen, einen Einblick in Ablauf und Inhalt der Prüfung.\
      Das erleichtert die Vorbereitung. Bitte verwende zum Ausfüllen einen schwarzen Stift.
      Das erleichtert das Einscannen.\
      Vielen Dank für deine Mitarbeit!],
    corner-stroke-block(height: barcode-height),
  )

  // --- Candidate and Exam Metadata ---

  // Spacing
  #v(line-height)

  #grid(
    columns: (1fr, 1fr),
    gutter: horizontal-gutter,
    stack(
      dir: ttb,
      kv-or-dots([Dein Studiengang:], value: studiengang(data)),
      [
        // Default block spacing
        #v(1.2em)
        Prüfungsart:\
        #if data.fachart == "W" { ballot-check } else { ballot }  Wahlpflichtfach\
        #if data.fachart == "V" { ballot-check } else { ballot } Vertiefungsfach\
        #if data.fachart == "E" { ballot-check } else { ballot } Ergänzungsfach
      ],
      v(line-height),
      kv-or-dots([Welches?], value: data.prüfungsfach),
    ),

    grid(
      column-gutter: horizontal-gutter,
      row-gutter: line-height,
      align: bottom,
      columns: (auto, 1fr),
      [Prüfungsdatum:],
      [
        #if data.prüfungsdatum != none {
          emph(localized-date(data.prüfungsdatum))
        } else {
          dots
        }
      ],

      [Prüfer(in):], or-dots(prüferIn-or-beisitzerIn(data.prüferIn)),
      [Beisitzer(in):], or-dots(prüferIn-or-beisitzerIn(data.beisitzerIn)),
    ),
  )

  #v(5mm)
  // --- Veranstaltungen Mapping ---
  #let veranstaltungen = if data.veranstaltungen == none {
    // Provide a 4x4 template, if the user prints out the template as is
    (
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
    )
  } else {
    data
      .veranstaltungen
      .map(it => (it.titel, it.dozentIn, it.jahr, it.besuch))
      .flatten()
      .map(it => [
        #text(style: "italic", it)
      ])
  }

  // --- Veranstaltungen Table ---
  *Prüfungsfächer und Vorbereitung*:
  #table(
    columns: (1fr, 1fr, 1fr, 1fr),
    rows: (auto, line-height),
    table.header("Veranstaltung", "Dozent(in)", "Jahr", "regelmäßig besucht?"),
    ..veranstaltungen,
  )

  // --- Grading and Duration ---
  #v(10mm)
  #grid(
    columns: (1fr, 1fr),
    gutter: horizontal-gutter,
    row-gutter: line-height,
    kv-or-dots("Note:", value: data.note),
    kv-or-dots("Prüfungsdauer:", value: data.dauer),
    grid.cell(colspan: 2, kv-or-dots("War diese Note angemessen?", value: data.fairness)),
  )

  // --- First Free Question: Prüfungsstil ---
  #v(5mm)
  #free-question(
    [Wie war der Prüfungsstil des Prüfers/der Prüferin?],
    subtitle: [Prüfungsatmosphäre, (un)klare Fragestellungen, Frage nach Einzelheiten oder eher größeren Zusammenhängen, kamen häufiger Zwischenfragen oder ließ er/sie dich erzählen, wurde dir weitergeholfen, wurde in Wissenslücken gebohrt?],
    body: data.prüfungsstil,
  )

  // --- Second Page: Open Questions ---
  #set page(footer: none)
  #grid(
    columns: (1fr, 1fr),
    rows: (1fr, 1fr, 1fr, auto),
    column-gutter: horizontal-gutter,
    free-question([Hat sich der Besuch/Nichtbesuch der Veranstaltung für dich gelohnt?], body: data.besuch-gelohnt),
    free-question([Kannst du ihn/sie weiterempfehlen? Warum?], body: data.empfehlung.begründung, subtitle: [
      #if data.empfehlung.ja == true { ballot-check } else { ballot }  ja\
      #if data.empfehlung.ja == false { ballot-check } else { ballot }  nein\
    ]),
    free-question(
      [Wie lange und wie hast du dich alleine oder mit anderen auf die Prüfung vorbereitet?],
      body: data.vorbereitung,
    ),
    free-question(
      [Fanden vor der Prüfung Absprachen zu Form oder Inhalt statt? Wurden sie eingehalten?],
      body: data.absprachen,
    ),
    free-question([Welche Tipps zur Vorbereitung kannst du geben?], body: data.vorbereitung-tipps, subtitle: [
      Wichtige/unwichtige Teile des Stoffes, gute Bücher/Skripte, Lernstil, ...
    ]),
    free-question([Kannst du Ratschläge für das Verhalten in der Prüfung geben?], body: data.verhalten-rat),
    grid.cell(colspan: 2, [
      === Inhalte der Prüfung (bitte auf weitere Blätter):
      - Schreibe bitte möglichst viele Fragen und Antowrten auf.
      - Wo wurde nach Herleitungen oder Beweisen gefragt oder sonstwie nachgehakt?
      - Worauf wollte der Prüfer/Prüferin hinaus?
      - Welche Fragen gehörten nicht zum eigentlichen Stoff?
      #v(5mm)
    ]),
  )

  // --- Page Break and Content Injection ---
  #pagebreak(weak: true)
  #it
]
