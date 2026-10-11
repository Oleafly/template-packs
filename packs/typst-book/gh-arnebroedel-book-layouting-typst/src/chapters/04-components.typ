// chapters/04-components.typ — Komponenten-Bibliothek

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": blockquote, callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge, highlight-text, icon-text, kbd, tag
#import "../components/grids.typ": feature-grid, gallery-grid
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Bausteine für Lehrmaterialien],
  lead: [Eine systematische Übersicht aller verfügbaren Komponenten —
    von Hinweiskästen bis zu interaktiven Elementen.],
)

== Semantische Hinweiskästen

Hinweiskästen#index[Hinweiskasten] (Callouts#index[Callout]) transportieren Informationen unterschiedlicher
Dringlichkeit. Die farbliche Kodierung#index[Farbliche Kodierung] ermöglicht eine sofortige
Einordnung durch den Leser.

#callout(title: "Wechselwirkung", tone: "info")[
  Acetylsalicylsäure (ASS) verstärkt die Wirkung oraler Antikoagulanzien.
  Bei gleichzeitiger Gabe ist eine engmaschige INR-Kontrolle erforderlich.
]

#callout(title: "Diagnose bestätigt", tone: "success")[
  Die histopathologische Untersuchung bestätigt die Verdachtsdiagnose
  eines gut differenzierten Adenokarzinoms, Stadium T1N0M0.
]

#callout(title: "Dosierungsgrenze", tone: "warning")[
  Die maximale Tagesdosis von Paracetamol beträgt 4 g bei Erwachsenen.
  Bei Leberinsuffizienz ist die Dosis auf 2 g zu reduzieren.
]

#callout(title: "Kontraindikation", tone: "danger")[
  Metformin ist bei einer GFR < 30 ml/min kontraindiziert.
  Absetzen vor jodhaltiger Kontrastmittelgabe!
]

#section-break()

== Karten und Zitate

Karten#index[Karte] eignen sich für abgeschlossene Informationseinheiten, die
visuell vom Fließtext#index[Fließtext] abgehoben werden sollen.

#card(title: "Fallbeispiel: Akuter Myokardinfarkt")[
  *Patient:* 58-jähriger Mann, Raucher, bekannte Hyperlipidämie. \
  *Symptome:* Retrosternaler Druckschmerz seit 2 Stunden, Ausstrahlung
  in linken Arm, Dyspnoe, Kaltschweißigkeit. \
  *EKG:* ST-Hebung in II, III, aVF. \
  *Diagnose:* Akuter inferiorer STEMI. \
  *Therapie:* Notfall-PCI innerhalb von 90 Minuten.
]

#blockquote(attribution: "Hippokratischer Eid, ca. 400 v. Chr.")[
  Ich werde ärztliche Verordnungen treffen zum Nutzen der Kranken nach
  meiner Fähigkeit und meinem Urteil, hüten aber werde ich mich davor,
  sie zum Schaden und in unrechter Weise anzuwenden.
]

#pull-quote(attribution: "William Osler, 1849–1919")[
  Der gute Arzt behandelt die Krankheit; der große Arzt behandelt
  den Patienten, der die Krankheit hat.
]

== Ergänzende Elemente

#side-note(title: "Etymologie")[
  Das Wort _Diagnose_ stammt aus dem Griechischen: _dia_ (durch) und
  _gnosis_ (Erkenntnis) — wörtlich: „Durcherkenntnis" oder
  „Unterscheidung".
]

#key-concept(term: "Evidenzbasierte Medizin (EBM)")[
  Die Integration individueller klinischer Expertise mit der bestmöglichen
  externen Evidenz aus systematischer Forschung, unter Berücksichtigung
  der Werte und Präferenzen des individuellen Patienten.
  Eingeführt von David Sackett in den 1990er Jahren.
]

#code-block(title: "ICD-10 Klassifikation — Beispiel")[
  ```
  I21.0  Akuter transmuraler Myokardinfarkt der Vorderwand
  I21.1  Akuter transmuraler Myokardinfarkt der Hinterwand
  I21.2  Akuter transmuraler Myokardinfarkt an sonstigen Lokalisationen
  I21.3  Akuter transmuraler Myokardinfarkt, nicht näher bezeichnet
  I21.4  Akuter subendokardialer Myokardinfarkt
  I21.9  Akuter Myokardinfarkt, nicht näher bezeichnet
  ```
]

#section-break()

== Inline-Komponenten

Inline-Elemente#index[Inline-Element] fügen sich nahtlos in den Fließtext ein und reichern
ihn mit semantischer Information#index[Semantische Information] an.

Fachgebiete können als Badges markiert werden: #badge[Kardiologie]
#badge(color: palette.accent)[Neurologie]
#badge(color: palette.info)[Pädiatrie]
#badge(color: palette.success)[Chirurgie]. Schwierigkeitsstufen
erscheinen als Tags: #tag[Grundlagen] #tag(color: palette.warning)[Fortgeschritten]
#tag(color: palette.danger)[Expertenwissen].

Im Fließtext können Schlüsselbegriffe#index[Schlüsselbegriff] wie
#highlight-text[Differenzialdiagnose] oder
#highlight-text[Randomisierte kontrollierte Studie] hervorgehoben
werden, ohne den Lesefluss zu unterbrechen.

Softwarehinweise nutzen Tastatur-Elemente: Drücken Sie #kbd[Strg+F]
zur Volltextsuche oder #kbd[Strg+P] zum Drucken.

Statusanzeigen: #icon-text(sym.checkmark, [Befund validiert])
#h(space.md)
#icon-text(sym.excl, [Ausstehend])

== Grid-Übersichten#index[Grid]

=== Medizinische Fachgebiete

#gallery-grid(
  column-count: 3,
  (
    [*Innere Medizin*\ Diagnostik und Therapie internistischer Erkrankungen],
    [*Chirurgie*\ Operative Versorgung und minimal-invasive Verfahren],
    [*Neurologie*\ Erkrankungen des zentralen und peripheren Nervensystems],
    [*Pädiatrie*\ Medizinische Betreuung von Kindern und Jugendlichen],
    [*Radiologie*\ Bildgebende Diagnostik und interventionelle Verfahren],
    [*Anästhesiologie*\ Narkose, Intensiv- und Schmerzmedizin],
  ),
)

=== Didaktische Vorteile

#feature-grid(
  column-count: 3,
  (
    (
      icon: sym.star,
      title: [Verständlichkeit],
      body: [Komplexe Sachverhalte werden durch visuelle Strukturierung zugänglich.],
    ),
    (icon: sym.arrow.t, title: [Effizienz], body: [Lesezeit und kognitive Belastung werden messbar reduziert.]),
    (icon: sym.checkmark, title: [Nachhaltigkeit], body: [Strukturiertes Wissen wird langfristig besser behalten.]),
  ),
)
