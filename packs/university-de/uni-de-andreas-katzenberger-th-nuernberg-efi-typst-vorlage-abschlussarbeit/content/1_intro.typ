#import "../lib.typ": *

= Introduction <ch:intro>

// Wichtig: Sektionen sollten nicht einfach übernommen werden, sondern sinnvoll gestaltet werden
// Hier stelle ich eine beispielhafte Unterteilung vor, die meist sinnvoll ist, ggf. aber auch nicht vollständig alles abdeckt

== Motivation <s-ch:motivation>
Erkläre hier die Bedeutung der Arbeit indem du den Leser auf das Thema sanft hinleitest.
Belege auch hier schon Behauptungen und Informationen mit Quellen.
Leite über zur Arbeit, um vom allgemeinen Überblick und der Bedeutung zur eigentlichen Arbeit zu kommen.

== Context <s-ch:context>
Erkläre hier den Hintergrund und die Bedingungen für die Arbeit.
Beispielsweise sollte bei der Weiterentwicklung eines Systems das bisherige System vorgestellt werden (wenn möglich auch mit Bildern oder Grafiken).
Verweise auch auf mögliche Vorgängerarbeiten und zeige, was dir an Möglichkeiten zur Verfügung stehen (oder auch, was das Unternehmen ausschließt).
Hier eine beispielhafte Einbindung eines Bildes. Im besten Fall verwendet man Vektorgrafiken anstelle von png/jpg.
In Typst kann neben dem Dateityp pdf auch der svg-Dateityp simpel eingebunden werden.

#fig-image(
  "figures/01_Introduction/01_Programmablauf_Schema.pdf",
  width: 100%,
  caption: [Schema Programmablauf],
  label: <fig:schemaProgrammablauf>,
)

== Scope and Approach <s-ch:scopeAndApproach>
Erkläre hier den Umfang der Arbeit (inklusive Ziel), mögliche vertiefende Gebiete und die angewandten Methoden.
Dabei kann man auch ganz kurz gefasst der rote Faden des Inhaltsverzeichnisses erklärt werden (also was den Leser erwarten wird).
