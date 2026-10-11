// =============================================================================
// Lernzettel: Deckblatt
// =============================================================================
// Nimmt alle Angaben als benannte Argumente entgegen und importiert nichts aus
// Config/Author.typ oder Config/Topic.typ – so bleibt das Deckblatt auch
// einzeln testbar. Die Werte reicht #lernzettel(...) aus main.typ durch.

#import "../Config/Styles.typ": accent, primary

#let deckblatt(
  titel: [],
  subtitel: none,
  subject: none,
  description: none,
  autor: "",
  datum: none,
) = {
  page(numbering: none, header: none, footer: none, {
    set par(justify: false)

    v(1fr)

    // Fachbereich als kleine Zeile über dem Titel
    if subject != none and subject != "" {
      text(size: 1em, weight: "bold", fill: accent, tracking: 1.5pt, upper(subject))
      v(0.6em, weak: true)
    }

    text(size: 2.4em, weight: "bold", fill: primary, titel)

    if subtitel != none and subtitel != "" {
      v(0.4em, weak: true)
      text(size: 1.3em, fill: primary.lighten(35%), subtitel)
    }

    // Akzentbalken als Trennung zwischen Titel und Beschreibung
    v(1em, weak: true)
    block(width: 25%, height: 3pt, fill: accent)

    if description != none and description != "" {
      v(1.2em, weak: true)
      block(width: 85%, text(size: 1.05em, fill: primary.lighten(20%), description))
    }

    v(1fr)

    // Fußbereich: Autor und Datum
    line(length: 100%, stroke: 0.5pt + primary.lighten(70%))
    v(0.6em, weak: true)
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      text(weight: "bold", fill: primary, autor),
      text(fill: primary.lighten(30%), if datum == none { [] } else { [#datum] }),
    )
  })
}
