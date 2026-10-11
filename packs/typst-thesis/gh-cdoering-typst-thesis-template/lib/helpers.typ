// =============================================================================
// HILFSFUNKTIONEN
//
// WICHTIG — Pfade: Typst loest Pfade in image(), csv(), read() und include()
// relativ zu der Datei auf, in der der Aufruf steht. Ein Helfer, der einen
// Pfad als Zeichenkette entgegennimmt, wuerde ihn also relativ zu DIESER
// Datei aufloesen und nicht relativ zum aufrufenden Kapitel.
//
// Deshalb nehmen alle Helfer hier bereits gelesene Daten oder fertigen
// Content entgegen, niemals Pfade:
//
//   FALSCH:  #csv-table("../data/generated/x.csv", caption: [...])
//   RICHTIG: #csv-table(csv("../data/generated/x.csv"), caption: [...])
// =============================================================================

#import "../config.typ": cfg
#import "i18n.typ": t

// --- Symbolverzeichnis -------------------------------------------------------
#let symtable(rows) = {
  grid(
    columns: (5.5em, 1fr),
    column-gutter: 1.5em,
    row-gutter: 0.39em,
    ..rows.map(r => (eval(r.at(0), mode: "math"), r.at(1))).flatten()
  )
}

#let symgroup(title, first: false) = block(
  above: if first { 0pt } else { 0.65em },
  below: 0.4em,
  text(weight: "bold", size: cfg.font_size + 0.5pt, title),
)

// --- Tabelle aus CSV-Daten ---------------------------------------------------
// data: bereits gelesenes Array, z. B. csv("../data/generated/x.csv")
// Die erste Zeile wird als Kopfzeile gesetzt.
#let csv-table(data, caption: none, label: none, align: left) = {
  let header = data.first()
  let rows = data.slice(1)
  let fig = figure(
    table(
      columns: header.len(),
      align: align,
      table.header(..header.map(h => strong(h))),
      ..rows.flatten()
    ),
    caption: caption,
  )
  if label != none { [#fig#label] } else { fig }
}

// --- Quelltext ---------------------------------------------------------------
// Eigene figure-Art, damit Listings ein eigenes Verzeichnis bekommen koennen.
#let listing-kind = "listing"

#let code-listing(body, caption: none, label: none) = {
  let fig = figure(
    block(
      width: 100%,
      fill: luma(248),
      stroke: 0.5pt + luma(200),
      radius: 3pt,
      inset: 8pt,
      align(left, body),
    ),
    caption: caption,
    kind: listing-kind,
    supplement: t.listing,
  )
  if label != none { [#fig#label] } else { fig }
}

// --- Querformat --------------------------------------------------------------
// Fuer breite Tabellen, die im Hochformat nicht lesbar umbrechen -- typisch
// im Anhang. Der Block beginnt auf einer neuen Seite; nachfolgender Inhalt
// laeuft automatisch wieder im Hochformat weiter.
//
//   #landscape[
//     #csv-table(csv("../data/generated/breit.csv"), caption: [...])
//   ]
//
// Hinweis: Folgt unmittelbar Fliesstext ohne eigene Ueberschrift, beginnt
// dieser noch auf der Querformatseite. In dem Fall ein #pagebreak() nach dem
// Block setzen.
#let landscape(body, margin: 1.5cm, size: 9pt) = {
  pagebreak()
  set page(flipped: true, margin: margin)
  set text(size: size)
  body
}

// --- Anhangnummerierung ------------------------------------------------------
// A, B, C, ... beziehungsweise A.1, A.2, ...
// Ueber numbering() statt einer festen Buchstabenliste, damit auch mehr als
// 26 Anhaenge fehlerfrei nummeriert werden.
#let appendix-numbering(..nums) = {
  let values = nums.pos()
  let prefix = numbering("A", values.first())
  if values.len() == 1 { prefix } else { prefix + "." + str(values.at(1)) }
}
