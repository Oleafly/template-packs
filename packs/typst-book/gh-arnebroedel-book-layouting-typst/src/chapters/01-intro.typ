// chapters/01-intro.typ — Einleitung

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge, icon-text, kbd, tag
#import "@preview/in-dexter:0.7.2": index

// Chapter opener creates the heading — do NOT add = Title
#chapter-opener(
  title: [Einleitung],
  lead: [Warum dieses Buch entstand, für wen es geschrieben ist und wie
    Sie den größten Nutzen daraus ziehen.],
)

== Warum dieses Buch?

Die medizinische Ausbildung befindet sich im Wandel. Während die Inhalte —
Anatomie, Physiologie, Pathologie — seit Jahrzehnten konstant bleiben, hat
sich die Art und Weise, wie wir diese Inhalte vermitteln, grundlegend
verändert. Digitale Medien, interaktive Lernplattformen und
evidenzbasierte Didaktik#index[Didaktik] eröffnen Möglichkeiten, die vor einer Generation
undenkbar waren.

Doch mit neuen Möglichkeiten kommen neue Herausforderungen. Die bloße
Verfügbarkeit von Technologie garantiert keine Verbesserung der Lehre.
Entscheidend ist die gestalterische Qualität der Materialien: Wie werden
Informationen strukturiert? Welche visuelle Hierarchie#index[Visuelle Hierarchie] unterstützt den
Lernprozess#index[Lernprozess]? Wie können komplexe Zusammenhänge so dargestellt werden,
dass sie das Arbeitsgedächtnis#index[Arbeitsgedächtnis] nicht überlasten?

Dieses Buch verbindet die Prinzipien moderner medizinischer Didaktik mit
den Werkzeugen des typografischen Satzsystems Typst#index[Typst], um Ihnen zu zeigen,
wie hochwertige Lehrmaterialien entstehen.

== Für wen ist dieses Buch?

Dieses Werk richtet sich an alle, die medizinische Lehrmaterialien#index[Lehrmaterialien] erstellen
oder verbessern möchten:

#card(title: "Zielgruppen")[
  #icon-text(sym.arrow.r, [*Dozierende* an medizinischen Fakultäten]) \
  #icon-text(sym.arrow.r, [*Curriculum-Entwickler* im klinischen Bereich]) \
  #icon-text(sym.arrow.r, [*Fachautoren* medizinischer Lehrbücher]) \
  #icon-text(sym.arrow.r, [*Studierende* mit Interesse an Wissenschaftskommunikation])
]

Vorkenntnisse in #badge[Typst] sind hilfreich, aber nicht zwingend
erforderlich. Grundlegende Konzepte werden eingeführt, bevor sie
angewendet werden.

#section-break()

== Wie Sie dieses Buch nutzen

#callout(title: "Lesehinweis", tone: "info")[
  Jedes Kapitel kann unabhängig gelesen werden. Für den größten
  Lernerfolg empfehlen wir jedoch die sequenzielle Lektüre, da
  spätere Kapitel auf früheren Konzepten aufbauen.
]

Das Buch gliedert sich in zwei Teile: *Teil I* behandelt die
Grundlagen — Typografie, Dokumentstruktur und die gestalterischen
Prinzipien, die jedem guten Lehrmaterial zugrunde liegen. *Teil II*
zeigt die praktische Umsetzung mit Komponenten, Layouts und
fortgeschrittenen Techniken.

Jedes Kapitel folgt dem Muster #badge(color: palette.accent)[Problem] →
#badge(color: palette.info)[Technik] → #badge(color: palette.success)[Ergebnis]:
Zuerst wird ein didaktisches Problem identifiziert, dann die technische
Lösung vorgestellt und schließlich das Ergebnis demonstriert.

== Konventionen in diesem Buch

#key-concept(term: "Evidenzbasierte Didaktik")[
  Alle in diesem Buch vorgestellten Gestaltungsprinzipien basieren auf
  Erkenntnissen der kognitiven Psychologie und der medizinischen
  Ausbildungsforschung. Wo immer möglich, werden konkrete Studien
  und Effektstärken zitiert.
]

Dieses Buch verwendet verschiedene visuelle Konventionen#index[Konventionen], um
unterschiedliche Informationstypen zu kennzeichnen:

#card(title: "Visuelle Wegweiser")[
  #icon-text(sym.circle.filled, [*Farbcodierung*: Wichtige Begriffe werden
    durch #tag(color: palette.primary)[Primärfarbe] hervorgehoben,
    Warnungen durch #tag(color: palette.danger)[Signalfarbe].]) \
  #icon-text(sym.circle.filled, [*Tastenkürzel*: Technische Anweisungen
    nutzen die Darstellung #kbd[Strg]+#kbd[S] für Eingaben.]) \
  #icon-text(sym.circle.filled, [*Fachbegriffe*: Neue Konzepte werden
    bei erster Erwähnung mit #badge[Definition] markiert.]) \
  #icon-text(sym.circle.filled, [*Querverweise*: Hinweise auf verwandte
    Kapitel helfen bei der Vernetzung der Inhalte.])
]

#side-note(title: "Über die Sprache")[
  Medizinische Fachsprache ist präzise, aber nicht immer leicht zugänglich.
  Wir bemühen uns um eine Balance zwischen fachlicher Korrektheit und
  allgemeiner Verständlichkeit. Ein Glossar im Anhang erläutert die
  wichtigsten Fachbegriffe.
]

#pull-quote(attribution: "Richard Feynman, Physiker")[
  Wenn du es nicht einfach erklären kannst, hast du es nicht
  gut genug verstanden.
]

Mit diesem didaktischen Grundverständnis beginnen wir im nächsten
Kapitel mit den Fundamenten guter Gestaltung: der Typografie#index[Typografie].
