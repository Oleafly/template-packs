// chapters/12-beyond-flow.typ — Jenseits des Standardflusses

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge, icon-text, tag
#import "../components/grids.typ": feature-grid, gallery-grid
#import "../components/layouts.typ": comparison-layout
#import "../components/tables.typ": styled-table
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Jenseits des Standardflusses],
  lead: [
    Typsts natives Layout-System (mit `grid`, `place` und `columns`) deckt die meisten typografischen Bedürfnisse ab. Manche fortgeschrittene Designmuster — wie absolute Annotationen, flexibles Wrapping oder ikonografische Interfaces — erfordern jedoch Community-Erweiterungen.
  ],
)

// ════════════════════════════════════════════════════════════════
== Absolute Annotationen im Textfluss mit Pinit

#import "@preview/pinit:0.2.2": *

Während Typst mit `place` Elemente relativ zum Layout platzieren kann, ermöglicht Pinit#index[Pinit] das "Anpinnen" von Positionen direkt im Textfluss#index[Textfluss], um später absolute Annotationen darauf zu referenzieren.

#figure(
  card()[
    #v(3.5em)

    #box(width: 100%, align(left)[
      #text(size: 1.25em)[
        Ein wichtiges Detail: #pin(1)Macrolid-Antibiotika#pin(2)
      ]
    ])

    #pinit-highlight(1, 2, fill: palette.danger.transparentize(80%), radius: 3pt)

    #pinit-point-from(
      (1, 2),
      pin-dx: 0pt,
      pin-dy: 8pt,
      body-dx: 0pt,
      body-dy: -10pt,
      offset-dx: 120pt,
      offset-dy: 60pt,
      fill: palette.danger.darken(10%),
    )[
      #block(inset: (left: 35pt))[
        #text(size: 1.1em, fill: palette.danger.darken(10%), weight: "bold")[
          Kontraindikation!
        ] \
        #text(size: 0.9em, fill: palette.danger.darken(20%))[
          Massive CYP3A4-Interaktion.
        ]
      ]
    ]
    #box()

    #v(10em)
  ],
  caption: [Ein mit Pinit annotierter Text. Der Pfeil positioniert sich absolut und entflieht dem Raster.],
)

#callout(tone: "info")[
  Pinit entflieht dem Standardfluss — die Annotation ist absolut positioniert, unabhängig davon, wie sich der umgebende Text aufgrund von Seitenumbrüchen oder Margenanpassungen verschiebt.
]

// ════════════════════════════════════════════════════════════════
== Flexbox-Wrapping für Typst mit Biceps

#import "@preview/biceps:0.0.1": *

Typsts natives `grid` erfordert feste Spalten- oder Zeilendefinitionen. Wenn Sie Elemente unterschiedlicher Breite verteilen möchten, die sich wie in CSS Flexbox#index[Flexbox] mit `flex-wrap: wrap` auf neue Zeilen umbrechen sollen, ist Biceps#index[Biceps] das richtige Werkzeug.

#figure(
  card()[
    // biceps might export "flex" or "biceps"
    // we use `flexwrap` according to the docs
    #flexwrap(
      main-spacing: 8pt,
      cross-spacing: 12pt,
      badge(color: palette.primary)[Kardiologie],
      badge(color: palette.info)[Neurologie],
      badge(color: palette.success)[Allgemeinmedizin],
      badge(color: palette.warning)[Radiologie],
      badge(color: palette.danger)[Notfallmedizin],
      badge(color: palette.accent)[Pädiatrie],
      badge(color: palette.primary)[Gastroenterologie],
    )
  ],
  caption: [Biceps verteilt die Badges automatisch auf mehrere Zeilen basierend auf ihrer individuellen Breite.],
  alt: "Mehrere verschieden breite Fachgebiets-Badges, die wie bei CSS-Flexbox automatisch auf mehrere Zeilen umbrechen.",
)

#side-note(title: [Im Vergleich zum Grid])[
  Ein natives `grid(columns: (1fr, 1fr, 1fr))` erzwingt gleich breite Spalten. Biceps hingegen respektiert die intrinsische Breite der Elemente und bricht flexibel um.
]

// ════════════════════════════════════════════════════════════════
== Icon-Integration mit Fontawesome

#import "@preview/fontawesome:0.6.1": *

// fontawesome 0.6.x nutzt standardmäßig die Font-Awesome-7-Maps/-Fonts.
// Das Repo bündelt die FA6-Fonts (fonts/), daher deterministisch auf FA6 pinnen —
// vermeidet die FA7-Font-Abhängigkeit im Build und hält den Build reproduzierbar.
#fa-version("6")

Für professionelle, ikonografische Layouts (z. B. in Lebensläufen oder Dashboards) bietet das Fontawesome#index[Fontawesome]-Paket eine direkte Integration der bekannten Icon#index[Icon]-Bibliothek.

#figure(
  card()[
    #grid(
      columns: (1fr, 1fr),
      row-gutter: 12pt,
      icon-text(fa-stethoscope(fill: palette.primary), [Stethoskop]),
      icon-text(fa-heart-pulse(fill: palette.danger), [Herzschlag]),

      icon-text(fa-user-doctor(fill: palette.info), [Facharzt]),
      icon-text(fa-file-medical(fill: palette.primary), [Patientenakte]),

      icon-text(fa-hospital(fill: palette.primary.darken(20%)), [Klinikum]),
      icon-text(fa-truck-medical(fill: palette.warning), [Krankenwagen]),

      icon-text(fa-virus(fill: palette.danger.darken(20%)), [Virologie]),
      icon-text(fa-pills(fill: palette.success), [Medikation]),
    )
  ],
  caption: [Auswahl an medizinischen Icons, gerendert über das Fontawesome-Paket.],
)

#callout(tone: "warning")[
  Die eingebauten `sym.*` Zeichen in Typst enthalten *keine* UI- oder Anwendungs-Icons (wie sie in Kapitel 8 erwähnt werden). Fontawesome schließt diese Lücke perfekt.
]

#side-note(title: [Zusammenhang])[
  Kapitel 08 erwähnt Fontawesome bereits in der Schnellreferenz — hier zeigen wir die vollständige Integration im Layout.
]
