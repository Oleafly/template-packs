// chapters/21-diagramme.typ — Medizinische Diagramme & Schemata

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, side-note
#import "../components/diagrams.typ": cycle-diagram, pathway-diagram
#import "../components/pedigree.typ": pedigree
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Medizinische Diagramme & Schemata],
  lead: [
    Jenseits von Messdaten lebt das Fachbuch von erklärenden Schemata:
    Kreisläufe, Signalwege, Stammbäume, Strukturformeln und Zeitverläufe.
    Dieses Kapitel bündelt die entsprechenden Komponenten und Pakete.
  ],
)

// ════════════════════════════════════════════════════════════════
== Kreisläufe und Signalwege

Viele physiologische Prozesse sind zyklisch. Das Zyklusdiagramm ordnet
die Phasen im Kreis an und schließt den Pfeilfluss:

#figure(
  cycle-diagram(([Systole], [Aus-\ wurf], [Diastole], [Füllung])),
  caption: [Vereinfachter Herzzyklus als geschlossenes Zyklusdiagramm.],
  alt: "Zyklusdiagramm mit vier im Kreis angeordneten Phasen — Systole, Auswurf, Diastole, Füllung — verbunden durch Pfeile im Uhrzeigersinn.",
)

Lineare Kaskaden — etwa das
Renin-Angiotensin-Aldosteron-System#index[Renin-Angiotensin-Aldosteron-System]
— zeigt das Pathway-Diagramm; eine Hemmung wird als flacher Pfeilkopf
dargestellt:

#figure(
  pathway-diagram(
    ([Angio-\ tensinogen], [Angio-\ tensin I], [Angio-\ tensin II], [Aldo-\ steron]),
    inhibit: (2,),
  ),
  caption: [RAAS-Kaskade; der rote Riegel markiert die ACE-Hemmung (Angiotensin I → II).],
  alt: "Pathway-Diagramm der RAAS-Kaskade von Angiotensinogen über Angiotensin I und II zu Aldosteron; der Schritt von Angiotensin I zu II ist als Hemmung markiert.",
)

#side-note(title: [Hemmung vs. Aktivierung])[
  Pfeilspitzen (`>`) stehen für Aktivierung/Umwandlung, der flache Riegel
  für eine Hemmung — die Konvention biochemischer Signalwege.
]

#section-break()

// ════════════════════════════════════════════════════════════════
== Stammbäume (Pedigree)

In der Humangenetik visualisiert der Stammbaum#index[Stammbaum (Pedigree)]
Erbgänge. Quadrate stehen für männliche, Kreise für weibliche Personen;
ausgefüllte Symbole sind betroffen:

#figure(
  pedigree(
    (
      (id: "f1", col: 0, row: 0, sex: "m", affected: true, label: [I-1]),
      (id: "m1", col: 1.4, row: 0, sex: "f", affected: false, label: [I-2]),
      (id: "c1", col: 0, row: 1, sex: "f", affected: true, label: [II-1]),
      (id: "c2", col: 1.4, row: 1, sex: "m", affected: false, label: [II-2]),
      (id: "c3", col: 2.8, row: 1, sex: "m", affected: true, label: [II-3]),
    ),
    (
      (type: "mate", a: "f1", b: "m1"),
      (type: "child", parents: ("f1", "m1"), child: "c1"),
      (type: "child", parents: ("f1", "m1"), child: "c2"),
      (type: "child", parents: ("f1", "m1"), child: "c3"),
    ),
  ),
  caption: [Autosomal-dominanter Erbgang über zwei Generationen.],
  alt: "Stammbaum über zwei Generationen: betroffener Vater und gesunde Mutter mit drei Kindern, von denen zwei betroffen sind.",
)

#callout(title: [Erbgang erkennen], tone: "info")[
  Bei autosomal-dominantem Erbgang sind in jeder Generation Betroffene zu
  finden, und betroffene Eltern geben das Merkmal an etwa die Hälfte der
  Kinder weiter — wie hier dargestellt.
]

#section-break()

// ════════════════════════════════════════════════════════════════
== Strukturformeln mit Alchemist

Chemische Skelettformeln entstehen mit dem Paket _Alchemist_ (auf CeTZ
aufbauend). Bindungen und Fragmente werden deklarativ aneinandergereiht:

#{
  import "@preview/alchemist:0.1.8": skeletize, molecule, single, double

  figure(
    skeletize({
      molecule("H_3C")
      single()
      molecule("CH_2")
      single()
      molecule("OH")
    }),
    caption: [Ethanol als Skelettformel — erstellt mit Alchemist.],
    alt: "Skelettformel von Ethanol: eine Kohlenstoffkette mit endständiger Hydroxygruppe.",
  )

  figure(
    skeletize({
      molecule("H_2C")
      double()
      molecule("CH_2")
    }),
    caption: [Ethen mit Doppelbindung.],
    alt: "Skelettformel von Ethen: zwei Kohlenstoffatome, verbunden durch eine Doppelbindung.",
  )
}

#section-break()

// ════════════════════════════════════════════════════════════════
== Zeitverläufe mit Timeliney

Therapie- und Krankheitsverläufe lassen sich als Gantt-artige Zeitleiste
darstellen. Das Paket _Timeliney_ gruppiert Aufgaben über Phasenspalten:

#{
  import "@preview/timeliney:0.4.0"

  figure(
    timeliney.timeline(
      show-grid: true,
      {
        import timeliney: group, headerline, task, taskgroup
        headerline(group(([*Akutphase*], 2)), group(([*Rehabilitation*], 2)))
        headerline(group(..range(4).map(n => strong("Woche " + str(n + 1)))))
        taskgroup(title: [*Behandlung*], {
          task("Akutbehandlung", (0, 1), style: (stroke: 6pt + palette.danger))
          task("Mobilisation", (1, 2.5), style: (stroke: 6pt + palette.warning))
          task("Rehabilitation", (2, 4), style: (stroke: 6pt + palette.primary))
        })
      },
    ),
    caption: [Therapieverlauf als Zeitleiste — erstellt mit Timeliney.],
    alt: "Gantt-artige Zeitleiste über vier Wochen mit den Phasen Akutbehandlung, Mobilisation und Rehabilitation.",
  )
}

#callout(title: [Werkzeugkasten komplett], tone: "success")[
  Mit Zyklus-, Pathway-, Pedigree-, Struktur- und Zeitdiagrammen deckt das
  System die wichtigsten schematischen Darstellungen des medizinischen
  Fachbuchs ab.
]
