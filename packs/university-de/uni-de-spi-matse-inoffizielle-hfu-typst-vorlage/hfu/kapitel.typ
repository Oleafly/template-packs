// Kopfzeile, Trennblätter und Kapitelgerüst.
//
// Eigenes Modul, damit `layout.typ` und `versicherung.typ` darauf zugreifen können, ohne sich gegenseitig zu importieren.

#import "config.typ" as cfg

// Jedes Kapitel hinterlegt den Text, der ab dieser Position in der Kopfzeile stehen soll.
// Die Kopfzeile verwendet die letzte Marke auf oder vor der aktuellen Seite.
// Metadaten werden bewusst anstelle von `state` verwendet, damit das Ergebnis nicht von Typsts Seitenreihenfolge abhängt.
#let kopfzeile-marke(inhalt) = [#metadata(inhalt)<hfu-kopf>]

// Diese Marke wird überall gesetzt, wo der Seitenzähler neu beginnt.
// Die Kopfzeile wird oben auf der Seite gesetzt, der Zähler aber erst im Seiteninhalt zurückgesetzt.
// Ohne die Marke zeigte die erste Seite eines Abschnitts noch den alten Zählerstand.
#let seitenzahl-neustart() = [#metadata(none)<hfu-seitenreset>]

// §1.2.5: Die Hauptkapitelüberschrift steht innen und die Seitenzahl außen.
// Ein horizontaler Strich grenzt die Kopfzeile ab.
#let kopfzeile() = context {
  let seite = here().page()

  let marken = query(<hfu-kopf>).filter(m => m.location().page() <= seite)
  let kapitel = if marken.len() > 0 { marken.last().value } else { none }

  // Auf Seiten mit Zählerneustart den Stand hinter dem Neustart ablesen.
  let neustarts = query(<hfu-seitenreset>).filter(m => m.location().page() == seite)
  let ort = if neustarts.len() > 0 { neustarts.first().location() } else { here() }

  let muster = ort.page-numbering()
  let nummer = if muster != none { numbering(muster, ..counter(page).at(ort)) }

  if kapitel == none and nummer == none { return }

  set text(size: cfg.groesse.kopfzeile, weight: "bold")

  // Ungerade Seiten liegen rechts und ihr innerer Rand liegt links; bei geraden Seiten ist es umgekehrt.
  // Die Seitenzahl bekommt nur ihre natürliche Breite, damit lange Kapitelüberschriften nicht mit ihr kollidieren.
  let (spalten, links, rechts) = if calc.odd(seite) {
    ((1fr, auto), kapitel, nummer)
  } else {
    ((auto, 1fr), nummer, kapitel)
  }

  stack(
    spacing: 0.35em,
    grid(
      columns: spalten,
      column-gutter: 1em,
      align: (left, right),
      [#links], [#rechts],
    ),
    line(length: 100%, stroke: 0.5pt),
  )
}

// Eine vollständig leere Seite: ohne Kopfzeile, ohne Seitenzahl.
#let leerseite() = page(header: none, footer: none, numbering: none, [])

// §2.2, §2.11, §2.13: leeres Trennblatt zwischen bestimmten Bestandteilen.
#let trennblatt() = {
  pagebreak()
  leerseite()
}

// §1.2.3: Hauptkapitel beginnen immer auf der rechten Seite.
//
// Die dabei entstehende Füllseite trägt wie bei einem Word-Abschnittswechsel auf eine ungerade Seite Kopfzeile und Seitenzahl.
// Eine vollständig leere Füllseite müsste ihre Notwendigkeit selbst über `context here().page()` bestimmen.
// Diese Entscheidung würde die Seitenzahlen der nachfolgenden Kapitel und damit die nächste Paritätsentscheidung verschieben.
// `pagebreak(to: "odd")` überlässt die Parität dem Satzsystem und bleibt dadurch deterministisch.
#let auf-rechte-seite() = pagebreak(to: "odd", weak: true)

// Kapitel des Vorspanns wie Vorwort, Abstract und Verzeichnisse tragen keine Kapitelnummer.
// Sie beginnen anders als Hauptkapitel auf einer beliebigen Seite, da sich die Rechtsseitenpflicht aus §1.2.3 auf Hauptkapitel bezieht.
#let vorspann-kapitel(titel, body, im-inhaltsverzeichnis: true) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: im-inhaltsverzeichnis, titel)
  kopfzeile-marke(titel)
  body
}

// Kapitel ohne Nummer im arabisch nummerierten Teil beginnen standardmäßig auf der rechten Seite.
// Die englische Fassung der Versicherung folgt laut den Richtlinienseiten 13 und 14 direkt auf die deutsche.
// Sie setzt deshalb `rechte-seite: false`.
#let unnummeriertes-kapitel(titel, body, rechte-seite: true) = {
  if rechte-seite { auf-rechte-seite() } else { pagebreak(weak: true) }
  heading(level: 1, numbering: none, outlined: true, titel)
  kopfzeile-marke(titel)
  body
}
