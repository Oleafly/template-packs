// components/legal.typ — Berufs- und Rechtskunde
//
// Token-gebundene Bausteine für die Darstellung juristischer Inhalte in
// einem Fachbuch: Normzitate (§/Art.), wörtliche Gesetzeskästen mit
// Absatz-/Satz-/Nummern-Gliederung, Randnummern-Kommentar, Rechtsprechungs-
// kästen, Legaldefinitionen, Prüfungsschemata (Gutachtenstil),
// Tatbestand→Rechtsfolge-Anatomie, Normenhierarchie und ein
// Abkürzungsverzeichnis. Alles nativ (Typst 0.15), Farben/Labels aus
// theme.typ (`legal`). Pakete wie rich-counters, theorion, glossarium oder
// citrus könnten Teile ersetzen — bewusst nativ für Token-Bindung und
// Konfliktfreiheit (vgl. die didaktische Box-Familie).

#import "../styles/theme.typ": fonts, legal, palette, space, type-scale

// ── Intern: Label-Chip (wie didactics._label-chip) ─────────────
#let _legal-chip(color, label) = box(
  fill: color,
  inset: (x: 6pt, y: 2pt),
  radius: 3pt,
  text(fill: white, weight: "bold", size: type-scale.tiny, font: fonts.sans, tracking: 0.5pt, upper(label)),
)

// ── Intern: generischer Rechts-Kasten ──────────────────────────
#let _legal-box(kind, header, body, breakable: true) = {
  let meta = legal.at(kind)
  let color = meta.color
  block(
    width: 100%,
    inset: (left: space.lg + 4pt, rest: space.md),
    fill: color.lighten(94%),
    stroke: (left: 3pt + color),
    radius: (right: 4pt),
    breakable: breakable,
    above: space.lg,
    below: space.lg,
    {
      block(below: space.sm, {
        _legal-chip(color, meta.label)
        if header != none { h(space.sm); header }
      })
      body
    },
  )
}

// ── Normzitat (inline) ─────────────────────────────────────────
// Formatiert eine Fundstelle: norm(p: 203, abs: 1, satz: 2, gesetz: "StGB")
// → „§ 203 Abs. 1 Satz 2 StGB"; art statt p für Artikel.
#let norm(p: none, art: none, abs: none, satz: none, hs: none, nr: none, lit: none, gesetz: none) = {
  let parts = ()
  if p != none { parts.push("§ " + str(p)) }
  if art != none { parts.push("Art. " + str(art)) }
  if abs != none { parts.push("Abs. " + str(abs)) }
  if satz != none { parts.push("Satz " + str(satz)) }
  if hs != none { parts.push("Hs. " + str(hs)) }
  if nr != none { parts.push("Nr. " + str(nr)) }
  if lit != none { parts.push("lit. " + str(lit)) }
  if gesetz != none { parts.push(gesetz) }
  // zusammenhalten (kein Umbruch innerhalb des Zitats)
  box(text(font: fonts.sans, weight: "medium", parts.join(sym.space.nobreak)))
}

// ── Paragraf-Pille (inline, hervorgehoben) ─────────────────────
#let paragraf(body, color: legal.norm.color) = box(
  fill: color.lighten(86%),
  stroke: 0.5pt + color,
  inset: (x: 4pt, y: 2pt),
  radius: 3pt,
  baseline: 20%,
  text(size: type-scale.tiny, fill: color.darken(8%), weight: "bold", font: fonts.sans, body),
)

// ── Norm-Gliederung: Absatz / Satz / Nummer / Buchstabe ────────
// Wörtliche Wiedergabe mit hängendem Einzug. Nummern werden explizit
// übergeben (originalgetreues Zitieren).
#let absatz(nr, body) = block(
  above: space.xs,
  below: space.xs,
  grid(
    columns: (auto, 1fr),
    column-gutter: space.sm,
    text(weight: "bold", font: fonts.sans)[(#nr)],
    body,
  ),
)

#let nummer(nr, body) = pad(
  left: space.md,
  block(
    above: space.xs,
    below: space.xs,
    grid(columns: (auto, 1fr), column-gutter: space.xs, text[#nr.], body),
  ),
)

#let buchstabe(l, body) = pad(
  left: space.lg + space.sm,
  block(
    above: space.xs,
    below: space.xs,
    grid(columns: (auto, 1fr), column-gutter: space.xs, text[#l)], body),
  ),
)

// ── Gesetzeskasten (wörtlicher Normtext) ───────────────────────
#let gesetzeskasten(norm-id: none, titel: none, quelle: none, breakable: true, body) = _legal-box(
  "norm",
  {
    text(weight: "bold", font: fonts.sans, size: type-scale.lead)[#norm-id]
    if titel != none {
      text(font: fonts.sans, fill: palette.text-muted)[ — #titel]
    }
  },
  {
    set par(justify: true)
    text(font: fonts.serif)[#body]
    if quelle != none {
      v(space.sm)
      align(right, text(size: type-scale.tiny, fill: palette.text-light, font: fonts.sans)[#quelle])
    }
  },
  breakable: breakable,
)

// ── Legaldefinition ────────────────────────────────────────────
#let legaldefinition(term: none, fundstelle: none, breakable: false, body) = _legal-box(
  "definition",
  {
    text(weight: "bold", font: fonts.sans)[#term]
    if fundstelle != none {
      text(size: type-scale.tiny, fill: palette.text-muted, font: fonts.sans)[ #h(2pt) (#fundstelle)]
    }
  },
  body,
  breakable: breakable,
)

// ── Rechtsprechung (Entscheidungskasten) ───────────────────────
#let rechtsprechung(
  gericht: none,
  datum: none,
  az: none,
  fundstelle: none,
  leitsatz: none,
  breakable: true,
  body,
) = _legal-box(
  "case",
  {
    text(weight: "bold", font: fonts.sans)[#gericht]
    if datum != none { text(font: fonts.sans, fill: palette.text-muted)[, #datum] }
  },
  {
    if az != none or fundstelle != none {
      block(below: space.sm, text(size: type-scale.tiny, fill: palette.text-muted, font: fonts.sans, {
        if az != none [Az. #az]
        if az != none and fundstelle != none [ #sym.dot.c ]
        if fundstelle != none [#fundstelle]
      }))
    }
    if leitsatz != none {
      block(below: space.sm, text(style: "italic", font: fonts.serif)[#sym.quote.l.double#leitsatz#sym.quote.r.double])
    }
    if body != none { body }
  },
  breakable: breakable,
)

// ── Prüfungsschema / Gutachten (gestufte Liste) ────────────────
// schritte: array von (label, body) — z. B. (label: [I.], body: [...]).
#let pruefungsschema(titel: [Prüfungsschema], schritte: (), breakable: true) = _legal-box(
  "scheme",
  text(weight: "bold", font: fonts.sans)[#titel],
  {
    for (i, s) in schritte.enumerate() {
      block(
        above: if i == 0 { 0pt } else { space.sm },
        grid(
          columns: (auto, 1fr),
          column-gutter: space.sm,
          text(weight: "bold", fill: legal.scheme.color, font: fonts.sans)[#s.label],
          s.body,
        ),
      )
    }
  },
  breakable: breakable,
)

// Gutachtenstil: die vier kanonischen Schritte vorgeformt.
#let gutachten(titel: [Gutachten], obersatz: none, definition: none, subsumtion: none, ergebnis: none) = pruefungsschema(
  titel: titel,
  schritte: (
    (label: [Obersatz], body: obersatz),
    (label: [Definition], body: definition),
    (label: [Subsumtion], body: subsumtion),
    (label: [Ergebnis], body: ergebnis),
  ),
)

// ── Tatbestand → Rechtsfolge (Anatomie einer Norm) ─────────────
#let tatbestand-rechtsfolge(tatbestand: none, rechtsfolge: none) = {
  let panel(tone, label, body) = block(
    width: 100%,
    fill: tone.lighten(92%),
    stroke: (left: 3pt + tone),
    radius: (right: 4pt),
    inset: space.sm,
    {
      block(below: space.xs, _legal-chip(tone, label))
      body
    },
  )
  block(
    above: space.lg,
    below: space.lg,
    grid(
      columns: (1fr, auto, 1fr),
      column-gutter: space.sm,
      align: horizon,
      panel(legal.norm.color, "Tatbestand (Wenn)", tatbestand),
      text(size: type-scale.h2, fill: legal.norm.color)[#sym.arrow.r.double],
      panel(legal.practice.color, "Rechtsfolge (Dann)", rechtsfolge),
    ),
  )
}

// ── Normenhierarchie (Stufenpyramide) ──────────────────────────
// stufen: array von (label, note) von OBEN (höchstrangig) nach UNTEN.
#let normenhierarchie(stufen) = {
  let n = stufen.len()
  let color = legal.norm.color
  block(
    above: space.lg,
    below: space.lg,
    breakable: false,
    align(center, stack(
      spacing: 4pt,
      ..stufen
        .enumerate()
        .map(((i, s)) => {
          let w = 42% + (i / (n - 1)) * 54%
          let c = color.lighten(i / n * 55%)
          block(
            width: w,
            fill: c,
            radius: 3pt,
            inset: (x: space.sm, y: space.xs),
            {
              align(center, text(fill: white, weight: "bold", font: fonts.sans, size: type-scale.small)[#s.label])
              if s.at("note", default: none) != none {
                align(center, text(fill: white.transparentize(15%), font: fonts.sans, size: type-scale.tiny)[#s.note])
              }
            },
          )
        }),
    )),
  )
}

// ── Randnummern-Kommentar ──────────────────────────────────────
// Juristischer Kommentar mit fortlaufenden Randnummern (Rn.) im linken
// Steg. `randnummer(body)` zählt automatisch hoch.
#let _rn-counter = counter("randnummer")

#let randnummer-reset() = _rn-counter.update(0)

#let randnummer(body) = {
  _rn-counter.step()
  block(
    above: space.sm,
    below: space.sm,
    grid(
      columns: (7mm, 1fr),
      column-gutter: space.sm,
      align(right + top, context text(
        size: type-scale.tiny,
        fill: legal.norm.color,
        weight: "bold",
        font: fonts.sans,
      )[#_rn-counter.display()]),
      body,
    ),
  )
}

// ── Abkürzungsverzeichnis ──────────────────────────────────────
// entries: array von (kurz, lang). columns: 1 oder 2 (nebeneinander).
#let abkuerzungen(entries, columns: 2) = {
  let render-col(items) = grid(
    columns: (auto, 1fr),
    row-gutter: space.xs,
    column-gutter: space.sm,
    ..items
      .map(e => (
        text(weight: "bold", font: fonts.sans, fill: legal.norm.color)[#e.kurz],
        text(size: type-scale.small)[#e.lang],
      ))
      .flatten(),
  )
  block(
    above: space.lg,
    below: space.lg,
    if columns == 2 {
      let half = calc.ceil(entries.len() / 2)
      grid(
        columns: (1fr, 1fr),
        column-gutter: space.xl,
        render-col(entries.slice(0, half)),
        render-col(entries.slice(half)),
      )
    } else {
      render-col(entries)
    },
  )
}
