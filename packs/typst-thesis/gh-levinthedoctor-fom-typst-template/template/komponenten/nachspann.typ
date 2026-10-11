// =============================================================================
// FOM-Template: Nachspann – Anhang und Literaturverzeichnis
// (Leitfaden 2.6 und 2.8)
// =============================================================================

#import "../styles.typ": literatur-zeilenabstand, literatur-eintragsabstand
#import "zitieren.typ": _zitierweise

// Anhang (Leitfaden 2.8): eröffnet den Anhang mit unnummerierter Überschrift.
// Die Seitennummerierung läuft arabisch weiter (im Leitfaden ausdrücklich
// zugelassene Variante, die der Leitfaden selbst verwendet).
#let anhang(body, titel: "Anhang") = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: true, titel)
  body
}

// Einzelner Anhangsabschnitt: "Anhang 1: Verwendeter Fragebogen" usw.
// Die Bestandteile des Anhangs sind getrennt zu bezeichnen (Leitfaden 2.8).
#let _anhang-zaehler = counter("fom-anhang")
#let anhang-abschnitt(titel, body) = {
  _anhang-zaehler.step()
  // Die Nummer wird hier fest in den Überschriftentext übernommen, damit sie
  // auch im Inhaltsverzeichnis korrekt erscheint.
  context {
    let nummer = _anhang-zaehler.get().first()
    heading(level: 2, numbering: none, outlined: true)[Anhang #nummer: #titel]
  }
  body
}

// Literaturverzeichnis (Leitfaden 2.6).
//   - Format der Einträge über die mitgelieferten CSL-Stile
//     (template/csl/fom-chicago.csl, fom-harvard.csl bzw. fom-apa.csl),
//     passend zur in main.typ gewählten Zitierweise. "apa" (APA 7th Edition)
//     ist kein Bestandteil des Leitfadens, sondern eine zusätzliche Option.
//   - Einfacher Zeilenabstand innerhalb der Einträge, Abstand zwischen den
//     Einträgen, hängender Einzug ab der zweiten Zeile.
//   - Internetquellen (Leitfaden 2.6: "am Ende des Literaturverzeichnisses
//     separat aufzuführen") auf zwei Wegen:
//     a) ohne `internetquellen`: alle Quellen stehen in einer Liste, die
//        CSL-Stile sortieren Einträge vom CSL-Typ "webpage" über das Makro
//        `typ-rang` geschlossen ans Ende – aber ohne eigene Überschrift.
//     b) mit `internetquellen: "/literatur/internetquellen.bib"`: eigener
//        Abschnitt mit der Zwischenüberschrift "Internetquellen". Seit Typst
//        0.15 sind mehrere `bibliography`-Aufrufe pro Dokument erlaubt; damit
//        ist die frühere Einschränkung (nur eine Bibliographie) aufgehoben.
//        Voraussetzung: Die Internetquellen stehen ausschließlich in der
//        zweiten Datei – ein Schlüssel darf nicht in beiden Dateien liegen.
// `datei` und `internetquellen` sind je ein einzelner Pfad oder eine Liste von
// Pfaden – Pfade mit führendem "/" beziehen sich auf das Projektverzeichnis.
//
// `zusaetzlich` nimmt Zitierschlüssel auf, die im Verzeichnis stehen sollen,
// ohne im Text belegt zu sein – typischerweise der Herausgeberband zu einem
// zitierten Sammelwerkbeitrag. Typst nimmt sonst nur zitierte Werke auf
// (`bibliography(full: false)` ist Vorgabe); `cite(..., form: none)` meldet den
// Eintrag an die Bibliographie, ohne irgendetwas zu setzen. Beispiel:
//   #literaturverzeichnis(zusaetzlich: (<wernerCyberneticsStateArt2017>,))
#let literaturverzeichnis(
  datei: "/literatur/literatur.bib",
  internetquellen: none,
  zusaetzlich: (),
  titel: "Literaturverzeichnis",
  titel-internetquellen: "Internetquellen",
  stil: auto,
) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: true, titel)
  set par(justify: false, leading: literatur-zeilenabstand, spacing: literatur-eintragsabstand)
  context {
    let zitierweise = if stil == auto { _zitierweise.get() } else { stil }
    let csl = if zitierweise == "harvard" {
      "/template/csl/fom-harvard.csl"
    } else if zitierweise == "apa" {
      "/template/csl/fom-apa.csl"
    } else {
      "/template/csl/fom-chicago.csl"
    }
    // Setzt nichts, meldet die Werke aber an die Bibliographie an.
    for schluessel in zusaetzlich {
      cite(schluessel, form: none)
    }
    bibliography(datei, title: none, style: csl)
    if internetquellen != none {
      // `outlined: false`: Die Zwischenüberschrift gliedert nur das
      // Literaturverzeichnis selbst und gehört nicht als eigener Punkt ins
      // Inhaltsverzeichnis (Leitfaden 2.2 kennt sie nicht als Bestandteil).
      heading(level: 2, numbering: none, outlined: false, titel-internetquellen)
      bibliography(internetquellen, title: none, style: csl)
    }
  }
}
