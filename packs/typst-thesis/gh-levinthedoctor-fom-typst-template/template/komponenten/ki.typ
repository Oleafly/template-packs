// =============================================================================
// FOM-Template: Kenntlichmachung von KI-Nutzung (Leitfaden 1.6 und 2.9)
// =============================================================================
// Der Leitfaden verlangt zwei Ebenen der Transparenz:
//
// 1. LOKALER NACHWEIS im Text für unverändert oder überarbeitet übernommene
//    KI-Inhalte (Textgenerierung, Paraphrasierung, Übersetzung) mit System,
//    Version und Datum der Kommunikation – je nach Zitierweise als Fußnote
//    (Chicago) oder in Klammern im Fließtext (Harvard):
//      #ki-nachweis(system: "ChatGPT", version: "3.5", datum: "01.11.2023")
//        Chicago:  Fußnote "Vgl. ChatGPT, Version 3.5, Zugriff am 01.11.2023."
//        Harvard:  "(vgl. ChatGPT, Version 3.5, Zugriff am 01.11.2023)"
//      Für originalgetreue Übernahmen: `vgl: false` (ohne "Vgl.").
//
// 2. SUMMARISCHES KI-HILFSMITTELVERZEICHNIS als Bestandteil der Arbeit
//    (Leitfaden 2.9). Nicht aufzuführen: Rechtschreibprüfung, Taschenrechner.

#import "../styles.typ": abstand-vor-ueberschrift, abstand-nach-ueberschrift
#import "zitieren.typ": _zitierweise

// Lokaler Nachweis einer KI-Übernahme im Text (Leitfaden 1.6).
#let ki-nachweis(system: "ChatGPT", version: none, datum: none, vgl: true) = context {
  let angabe = {
    system
    if version != none [, Version #version]
    if datum != none [, Zugriff am #datum]
  }
  if _zitierweise.get() == "chicago" {
    footnote[#if vgl [Vgl. ]#angabe.]
  } else {
    [(#if vgl [vgl. ]#angabe)]
  }
}

// Summarisches KI-Hilfsmittelverzeichnis (Leitfaden 2.9).
// `eintraege` ist eine Liste von Dictionaries:
//   (
//     tool: "ChatGPT", version: "4o",
//     nutzung: "Paraphrasierung einzelner Textpassagen",
//     teile: "Kapitel 2.1", datum: "01.11.2023",
//   )
// `version`, `nutzung`, `teile` und `datum` sind optional; der Leitfaden verlangt
// mindestens Tool und (falls vorhanden) Version; `datum` ist das Datum der
// Kommunikation, das Leitfaden 1.6 zusätzlich zu System und Version nennt.
#let ki-hilfsmittelverzeichnis(eintraege, titel: "KI-Hilfsmittelverzeichnis") = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: true, titel)
  if eintraege.len() == 0 {
    [Bei der Erstellung dieser Arbeit wurden keine KI-Anwendungen eingesetzt.]
  } else {
    table(
      columns: (1fr, auto, 1.6fr, 1fr, auto),
      stroke: 0.5pt,
      inset: 6pt,
      align: left + horizon,
      table.header([*KI-Tool*], [*Version*], [*Art der Nutzung*], [*Betroffene Teile*], [*Datum*]),
      ..eintraege
        .map(e => (
          [#e.at("tool", default: "")],
          [#e.at("version", default: "–")],
          [#e.at("nutzung", default: "–")],
          [#e.at("teile", default: "–")],
          [#e.at("datum", default: "–")],
        ))
        .flatten(),
    )
  }
}
