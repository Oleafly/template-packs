// Wiederverwendbare Hilfsfunktionen für das gesamte Dokument.

/// Erstellt eine Abbildung oder Tabelle mit Quellenangabe unterhalb des Inhalts.
///
/// ```typst
/// #qfigure(image("/img/bild.jpg"), [Beschreibung], [Quelle])<key>
/// ```
///
/// - content (content): Der anzuzeigende Inhalt (z.B. `image("....jpg",args)` oder `table([..][..])`).
/// - caption (String): Beschriftung der Abbildung/Tabelle.
/// - source (String): Quellenangabe, wird unter dem Inhalt angezeigt.
#let qfigure(content, caption, source) = figure(
  stack(
    content,
    v(6pt),
    align(
      left,
      text(
        size: 10pt,
      )[Quelle: #source],
    ),
  ),
  caption: caption,
)

#let anhang(body) = {
  show figure: set figure(kind: "anhang")
  body
}

// Prüft ob ein Glossareintrag im Dokument referenziert wird
#let has-gloss-ref(key) = {
  let cap = upper(key.first()) + key.slice(1)
  let labels = (
    key,
    cap,
    key + ":pl",
    cap + ":pl",
    key + ":short",
    key + ":long",
  )
  labels.any(lbl => query(ref.where(target: label(lbl))).len() > 0)
}

// ── Abkürzungsverzeichnis-Stil (zentral anpassbar) ─────────────────────────
#let abk_short_width = 2cm

// Benutzerdefinierte Darstellung für eine Glossarzeile (links: Kurzform, rechts: Langform).
#let abk_print_entry(
  entry,
  show-all: false,
  disable-back-references: false,
  deduplicate-back-references: false,
  minimum-refs: 1,
  description-separator: ": ",
  user-print-title: none,
  user-print-description: none,
  user-print-back-references: none,
) = {
  let key = entry.at("key")
  let cap = upper(key.first()) + key.slice(1)
  // Zählt alle unterstützten Kurzverweise, die einen Eintrag als verwendet markieren.
  let labels = (key, cap, key + ":pl", cap + ":pl", key + ":short", key + ":long")
  let refs = labels.map(l => query(ref.where(target: label(l))).len()).sum()
  if show-all or refs >= minimum-refs {
    let short = if "short" in entry { entry.at("short") } else { key }
    let long = if "long" in entry { entry.at("long") } else { short }
    
    grid(
      columns: (abk_short_width, 1fr),
      column-gutter: 0.5em,
      short, long,
    )
  }
}
