#import "@preview/touying:0.6.1": *
#import "@preview/numbly:0.1.0": numbly
#import "vorlage/hs-anhalt.typ": *

#set text(lang: "de")

#show: hsa-theme.with(
  aspect-ratio: "16-9",
  header: [Fachbereich],
  footer: [Name, Anlass],
  config-info(
    author: ("Autor 1", "Autor 2"),
    title: [Titel],
    subtitle: [Untertitel]
  ),
  config-common(handout: false),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

// Titelfolie erzeugen
#title-slide()

// Inhaltsverzeichnis
#text([Inhalt], size: 30pt, weight: "semibold")
#components.adaptive-columns(outline(indent: 1em, title: none))

= Einführung
== Touying
Diese Vorlage verwendet das #link("https://touying-typ.github.io/docs/intro", [Touying]) Paket zur *Formatierung*.

== Abschnitte
Nutzt man Unterabschnitte, so werden diese automatisch eingeblendet.

== Folienbereich
#rect(width: 100%, height: 100%, align(center + horizon)[Dieser Bereich steht zur Bearbeitung zur Verfügung.])

= Zitation
Die Quellen befinden sich als `.bib` Datei innerhalb von `zotero.bib`. Über den Zitationsschlüssel und `@` fügt man Referenzen ein. @2020SciPy-NMeth Diese werden automatisch dem Literaturverzeichnis beigefügt.

= Spalten
#grid(
  columns: (1fr, 1fr),
  [Linke Seite], [Rechte Seite],
)
oder `table` um die Ränder sichtbar zu machen. Sehr hilfreich als visuelle Indikation des Layouts bevor man wieder zu `grid` wechselt.
#table(
  columns: (1fr, 1fr),
  [Linke Seite], [Rechte Seite],
)

= Code

#raw(
  lang: "rust",
  block: true,
  `pub fn main() {
  println!("Hello, world!");
}`.text,
)

= Animationen
== `Pause`
First #pause Second

#pause

Third

== `meanwhile`
First

#pause

Second

#meanwhile

Third

#pause

Fourth

== weitere
Fortgeschrittenere Animationen gibt es in der #link("https://touying-typ.github.io/docs/dynamic/complex", [Touying Dokumentation])
