// =============================================================
// styles.typ – Custom Environments, Callouts, Theoreme
// Entspricht: Theorem-Definitionen aus setup.tex + style.tex
// =============================================================

#import "colors.typ": *

// =============================================================
// 1. THEOREM-ÄHNLICHE UMGEBUNGEN
//    (Definition, Beispiel, Satz, Lemma)
// =============================================================

// Zähler für Definitionen (kapitelbasiert)
#let def-counter = counter("definition")

// Hilfsfunktion: nummerierte Box mit farbigem Rand
#let _theorem-box(
  title: none,
  label-text: "Definition",
  accent-color: primary,
  body,
) = {
  def-counter.step()
  let num = context def-counter.display()
  block(
    width: 100%,
    inset: (left: 10pt, right: 10pt, top: 8pt, bottom: 8pt),
    stroke: (left: 3pt + accent-color),
    fill: accent-color.lighten(92%),
    radius: (right: 4pt),
  )[
    #text(weight: "bold", fill: accent-color)[
      #label-text #num#if title != none [: #title]
    ]
    #v(4pt)
    #body
  ]
}

/// Definition-Umgebung (blau)
#let definition(title: none, body) = _theorem-box(
  title: title,
  label-text: "Definition",
  accent-color: primary,
  body,
)

/// Beispiel-Umgebung (grün)
#let beispiel(title: none, body) = _theorem-box(
  title: title,
  label-text: "Beispiel",
  accent-color: success,
  body,
)

/// Satz-Umgebung (dunkelblau)
#let satz(title: none, body) = _theorem-box(
  title: title,
  label-text: "Satz",
  accent-color: info,
  body,
)

/// Lemma-Umgebung (lila)
#let lemma(title: none, body) = _theorem-box(
  title: title,
  label-text: "Lemma",
  accent-color: rgb(102, 51, 153),
  body,
)

// =============================================================
// 1b. ABBILDUNG MIT BILDQUELLE
//     Quelle erscheint unter dem Bild, aber NICHT im Abbildungsverzeichnis.
//     Verwendung:
//       #img(
//         image("pfad.jpg", width: 50%),
//         caption: [Beschreibung],
//         source: [@img:quellenkey],
//       ) <label>
// =============================================================

#let img(
  path,
  caption: none,
  source: none,
  format: auto,
  width: auto,
  height: auto,
  alt: none,
  page: 1,
  fit: "cover",
  scaling: auto,
  icc: auto,
  ..args,
) = {
  figure(
    image(
      "../media/" + path,
      format: format,
      width: width,
      height: height,
      alt: alt,
      page: page,
      fit: fit,
      scaling: scaling,
      icc: icc,
    ),
    caption: [
      #caption
      #if source != none {
        [#v(0.4em, weak: true) #align(center, text(size: 9pt, style: "italic")[Quelle: #source]) <hide-in-outline>]
      }
    ],
    ..args,
  )
}

// =============================================================
// 1c. TABELLE MIT QUELLE
//     Verwendung:
//       #tbl(
//         table(...),
//         caption: [Beschreibung],
//         source: [@quellenkey],
//       ) <label>
// =============================================================

#let tbl(
  body,
  caption: none,
  source: none,
  ..args,
) = {
  figure(
    body,
    caption: [
      #caption
      #if source != none {
        [#v(0.4em, weak: true) #align(center, text(size: 9pt, style: "italic")[Quelle: #source]) <hide-in-outline>]
      }
    ],
    kind: table,
    supplement: "Tabelle",
    ..args,
  )
}

// =============================================================
// 2. CALLOUT-BOXEN
//    (Wichtig, Hinweis, Tipp)
// =============================================================

#let _callout(icon: "!", color: warning, prefix: "Wichtig", body) = block(
  width: 100%,
  inset: (left: 10pt, right: 10pt, top: 8pt, bottom: 8pt),
  stroke: (left: 3pt + color),
  fill: color.lighten(90%),
  radius: (right: 4pt),
)[
  #text(weight: "bold", fill: color)[#icon #prefix:]
  #h(4pt)
  #body
]

/// Wichtig-Box (orange)
#let important(body) = _callout(
  icon: "⚠",
  color: warning,
  prefix: "Wichtig",
  body,
)

/// Hinweis-Box (cyan)
#let note(body) = _callout(
  icon: "ℹ",
  color: info,
  prefix: "Hinweis",
  body,
)

/// Tipp-Box (primary)
#let tip(body) = _callout(
  icon: "💡",
  color: primary,
  prefix: "Tipp",
  body,
)

// =============================================================
// 3. CODE-LISTING UMGEBUNG
//    Entspricht: \begin{listing}...\end{listing} mit minted
// =============================================================

/// Code-Listing mit Beschriftung.
/// Body ist ein Raw-Block mit Sprachangabe (``` ```lang ... ``` ```).
/// Das Styling (Rahmen, Zeilennummern) übernimmt automatisch template.typ.
/// Verwendung:
///   #code-listing(caption: [Mein Python-Skript])[
///     ```python
///     def hello():
///         print("Hallo!")
///     ```
///   ]
#let code-listing(caption: none, body) = figure(
  body,
  caption: caption,
  kind: raw,
  supplement: "Code",
)

// =============================================================
// 4. FUSSNOTEN-HILFSFUNKTIONEN
// =============================================================

/// Quellen-Fußnote: fügt "Quelle: ..." ein
#let sourcefootnote(source) = footnote[_Quelle:_ #source]

/// Anmerkung des Verfassers als Fußnote
#let authornote(note) = footnote[_Anmerkung des Verfassers:_ #note]

/// Übersetzung durch den Verfasser als Fußnote
#let transnote(note) = footnote[_Übersetzung durch den Verfasser:_ #note]

// =============================================================
// 5. TEXT-HILFSFUNKTIONEN
// =============================================================

/// Farbige Hervorhebung mit primary-Farbe
#let textprimary(body) = text(fill: primary, body)
#let textsecondary(body) = text(fill: secondary, body)
#let textaccent(body) = text(fill: accent, body)

/// Grauer Hintergrund wie \highlight{}
#let highlight(body) = box(
  fill: verylightgray,
  inset: (x: 3pt, y: 1pt),
  radius: 2pt,
  body,
)

// =============================================================
// 6. ABKÜRZUNGSVERZEICHNIS-HILFSFUNKTIONEN
//    (Typst-Alternative zu LaTeX glossaries)
// =============================================================

/// Erstellt eine formatierte Abkürzungszeile für das Verzeichnis
#let abbr-entry(short, long, description: none) = (
  table.cell(text(weight: "bold", fill: headingcolor, short)),
  long,
  if description != none { description } else { "" },
)

// =============================================================
// 7. BILDQUELLEN-SYSTEM (Römische Ziffern)
//    Ersetzt Alexandria/@img:-Zitierweise.
//
//    Zitieren:   source: [#imgcite("key")]
//    Verzeichnis: #print-img-sources(image-sources-data)
// =============================================================

/// Interner State: Reihenfolge der zitierten Bildquellen
#let img-cite-order = state("img-cite-order", ())

/// Bildquellen-Zitat – rendert [I], [II], … als internen Link zum Bildquellenverzeichnis
#let imgcite(key) = {
  img-cite-order.update(order => {
    if order.contains(key) { order } else { order + (key,) }
  })
  context {
    let order = img-cite-order.final()
    let idx   = order.position(k => k == key)
    let num   = if idx == none { [?] } else { [#numbering("I", idx + 1)] }
    link(label("img-src-" + key), [\[#num\]])
  }
}

/// Bildquellenverzeichnis mit römischen Ziffern
/// Übergabe: image-sources-data aus bibliography/image-sources.typ
/// full: true → alle Quellen anzeigen, auch nicht zitierte
#let print-img-sources(sources, full: false) = {
  heading(level: 1, numbering: none, outlined: true)[Bildquellenverzeichnis]
  context {
    let order = img-cite-order.final()
    let keys = if full { sources.map(s => s.key) } else { order }

    for (i, key) in keys.enumerate() {
      let entry = sources.find(s => s.key == key)
      if entry == none { continue }

      let num = numbering("I", i + 1)
      let author = entry.at("author", default: none)
      let title  = entry.at("title",  default: none)
      let year   = entry.at("year",   default: none)
      let url    = entry.at("url",    default: none)
      let note   = entry.at("note",   default: none)

      let body = {
        if author != none { [#author. ] }
        if title  != none { emph(title) + [. ] }
        if year   != none { [#str(year). ] }
        if url    != none { [URL: ] + link(url, [#url]) + [.] }
        if note   != none { [ #note.] }
      }

      // Anker für internen Link aus imgcite-Zitaten
      [#metadata(key)#label("img-src-" + key)]
      block(above: 0.8em, below: 0em,
        grid(
          columns: (2.8em, 1fr),
          gutter: 0pt,
          align: (right, left),
          text(weight: "bold")[\[#num\]],
          pad(left: 0.8em, body),
        )
      )
    }
  }
}

/// Abkürzungsverzeichnis als Tabelle darstellen
#let abbr-table(entries) = table(
  columns: (auto, 1fr, 2fr),
  stroke: none,
  inset: (x: 6pt, y: 5pt),
  table.header(
    text(weight: "bold", fill: headingcolor)[Abkürzung],
    text(weight: "bold", fill: headingcolor)[Bedeutung],
    text(weight: "bold", fill: headingcolor)[Beschreibung],
  ),
  ..entries.flatten(),
)
