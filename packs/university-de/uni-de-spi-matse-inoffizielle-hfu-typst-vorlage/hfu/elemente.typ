// Bausteine für die Kapiteldateien: Abbildungen, Tabellen, Quellcode, Querformat und Monatsberichte.
// Pfade werden mit führendem "/" angegeben, zum Beispiel "/bilder/…" oder "/code/…".
// Typst löst solche Pfade gegen die Projektwurzel und nicht gegen die aufrufende Datei auf.
// Dadurch funktionieren sie aus jedem Unterordner gleich.

#import "config.typ" as cfg

// §2.6 und §2.7: Der Quellenverweis steht direkt unterhalb der Beschriftung.
// Nach §3.7 gehört er nicht zum Titel und damit nicht ins Verzeichnis.
// Deshalb ist er kein Teil der `caption`, sondern eine eigene Zeile darunter.
#let mit-quelle(figur, quelle, zusammenhalten: false) = {
  if quelle == none { return figur }

  block(breakable: not zusammenhalten, {
    show figure: set block(below: 0.3 * cfg.zeile)
    figur
    align(cfg.figur-ausrichtung, text(size: cfg.groesse.beschriftung)[Quelle: #quelle])
  })
}

// §2.6: Jede Abbildung wird beschriftet, die Beschriftung steht unterhalb.
#let abbildung(inhalt, caption: none, quelle: none, alt: none) = {
  assert(
    caption != none,
    message: "hfu-vorlage: Jede Abbildung benötigt nach §2.6 eine `caption`.",
  )
  mit-quelle(
    figure(inhalt, caption: caption, kind: image, alt: alt),
    quelle,
    zusammenhalten: true,
  )
}

// §2.7: Tabellen werden ausschließlich abgesetzt eingebunden und unterhalb beschriftet.
// Tabelle 2 legt für den Tabelleninhalt 10 pt fest.
#let tabelle(caption: none, quelle: none, ..args) = {
  assert(
    caption != none,
    message: "hfu-vorlage: Jede Tabelle benötigt nach §2.7 eine `caption`.",
  )
  mit-quelle(
    figure(
      {
        set text(size: cfg.groesse.tabelle)
        table(..args)
      },
      caption: caption,
      kind: table,
    ),
    quelle,
    zusammenhalten: true,
  )
}

// Zeilennummern nur in Quellcode-Listings, nicht in Code im Fließtext.
#let mit-zeilennummern(body) = {
  show raw.line: zeile => {
    box(width: 1.8em, align(right, text(fill: luma(140), str(zeile.number))))
    h(0.8em)
    zeile.body
  }
  body
}

// Quellcode aus einem Raw-Block:
//   #quellcode(```python …```, caption: [Titel])
#let quellcode(inhalt, caption: none, zeilennummern: true) = figure(
  block(
    width: 100%,
    fill: luma(248),
    stroke: 0.5pt + luma(210),
    inset: 0.8em,
    align(left, {
      // Quellcode wird einzeilig gesetzt.
      // Der 1,5-zeilige Abstand des Fließtextes (§1.3.2) würde Listings unnötig auseinanderziehen.
      set par(leading: cfg.zeile-einfach - 1em, justify: false)
      if zeilennummern { mit-zeilennummern(inhalt) } else { inhalt }
    }),
  ),
  caption: caption,
  kind: "hfu-code",
  supplement: [Quellcode],
)

// Quellcode aus einer Datei in `code/` bleibt separat ausführbar und wird nicht in die Arbeit kopiert.
// Beispiel: #quellcode-datei(path("/code/beispiel.py"), lang: "python", caption: [Titel])
// `path` löst den Pfad bereits im aufrufenden Projekt auf.
// Dadurch funktioniert er später auch bei einem Import der Vorlage als Typst-Paket.
#let quellcode-datei(pfad, lang: none, caption: none, zeilennummern: true) = quellcode(
  // Abschließende Zeilenumbrüche würden sonst als leere nummerierte Zeilen im Listing erscheinen.
  raw(read(pfad).trim(regex("[\\r\\n]+"), at: end), lang: lang, block: true),
  caption: caption,
  zeilennummern: zeilennummern,
)

// §1.2.1: Für große Tabellen und Abbildungen ist Querformat zulässig.
#let querformat(body) = page(flipped: true, body)

// §2.13: Die Monatsberichte sind Bestandteil des Anhangs.
// Sie werden als PDF-Seiten eingebunden, damit die Kopfzeile der Arbeit erhalten bleibt.
// Bei einem späteren Paketimport muss `pfad` im Nutzerprojekt mit `path(…)` erzeugt werden.
// Dadurch wird die Datei nicht relativ zum Paket gesucht.
#let monatsbericht(pfad, titel: none, seiten: (1,)) = {
  assert(
    type(seiten) == array and seiten.len() > 0,
    message: "hfu-vorlage: `seiten` muss mindestens eine PDF-Seitennummer enthalten.",
  )

  if titel != none {
    heading(level: 2, numbering: none, titel)
  }

  for seite in seiten {
    align(center, image(pfad, page: seite, width: 100%))
    pagebreak(weak: true)
  }
}
