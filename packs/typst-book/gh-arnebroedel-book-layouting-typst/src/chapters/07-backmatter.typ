// chapters/07-backmatter.typ — Anhang

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener
#import "../components/tables.typ": long-table, styled-table
#import "@preview/in-dexter:0.7.2": make-index

#chapter-opener(
  title: [Anhang],
  lead: [Glossar, Komponentenverzeichnis und weiterführende Literatur.],
)

== Glossar

#styled-table(
  columns: (auto, 1fr),
  table.header(
    text(fill: white, weight: "bold", size: type-scale.small)[Begriff],
    text(fill: white, weight: "bold", size: type-scale.small)[Definition],
  ),
  [*Advance Organizer*],
  [Einführende Übersicht, die neues Wissen an vorhandenes Vorwissen anknüpft.],

  [*Cognitive Load*],
  [Kognitive Belastung des Arbeitsgedächtnisses beim Lernen. Unterschieden in intrinsische, extrinsische und lernbezogene Belastung.],

  [*Didaktische Reduktion*],
  [Vereinfachung komplexer Inhalte für den Lernprozess, ohne den Kern zu verfälschen.],

  [*Evidenzbasierte Medizin*],
  [Integration individueller klinischer Expertise mit externer wissenschaftlicher Evidenz.],

  [*Formatives Assessment*],
  [Lernbegleitende Prüfung zur Steuerung des Lernprozesses (im Gegensatz zur summativen Abschlussprüfung).],

  [*Leading*],
  [Zeilenabstand — gemessen von Grundlinie zu Grundlinie. Optimal bei 120–145 % der Schriftgröße.],

  [*Peer Teaching*],
  [Studierende vermitteln sich gegenseitig Lerninhalte. Fördert sowohl Lehrende als auch Lernende.],

  [*PBL*],
  [Problem-Based Learning — problemorientiertes Lernen in kleinen Gruppen.],

  [*PRISMA*],
  [Preferred Reporting Items for Systematic Reviews and Meta-Analyses — Leitlinie für systematische Übersichtsarbeiten.],

  [*Serifenschrift*],
  [Schriftart mit kleinen Querstrichen (Serifen) an den Buchstabenenden. Verbessert die Leserlichkeit im Fließtext.],

  [*Token-System*],
  [Zentrale Definition von Designwerten (Farben, Abstände, Schriften), die im gesamten Dokument wiederverwendet werden.],

  [*Typografische Hierarchie*],
  [Visuelles System abgestufter Schriftgrößen und -gewichte zur Strukturierung von Informationen.],
)

== Komponentenverzeichnis

#long-table(
  columns: (auto, 1fr, auto),
  table.header(
    text(fill: white, weight: "bold", size: type-scale.small)[Komponente],
    text(fill: white, weight: "bold", size: type-scale.small)[Beschreibung],
    text(fill: white, weight: "bold", size: type-scale.small)[Datei],
  ),
  [callout],
  [Semantischer Hinweiskasten (info, success, warning, danger)],
  [blocks.typ],
  [card],
  [Erhöhte Inhaltskarte mit Akzentleiste],
  [blocks.typ],
  [blockquote],
  [Formatiertes Zitat mit Quellenangabe],
  [blocks.typ],
  [pull-quote],
  [Großes Editorial-Zitat],
  [blocks.typ],
  [side-note],
  [Ergänzende Randbemerkung],
  [blocks.typ],
  [code-block],
  [Codedarstellung mit optionalem Titel],
  [blocks.typ],
  [key-concept],
  [Hervorgehobene Begriffsdefinition],
  [blocks.typ],
  [badge],
  [Farbiges Inline-Label],
  [inline.typ],
  [tag],
  [Umrandetes Kategorie-Label],
  [inline.typ],
  [highlight-text],
  [Hintergrund-Hervorhebung],
  [inline.typ],
  [kbd],
  [Tastaturkürzel-Anzeige],
  [inline.typ],
  [icon-text],
  [Symbol-Text-Kombination],
  [inline.typ],
  [sidebar-layout],
  [Zwei-Spalten-Layout mit Seitenleiste],
  [layouts.typ],
  [magazine-layout],
  [Hero + mehrspaltig],
  [layouts.typ],
  [scientific-paper],
  [Akademisches Paper-Layout],
  [layouts.typ],
  [comparison-layout],
  [Seite-an-Seite-Vergleich],
  [layouts.typ],
  [adaptive-layout],
  [Breitenabhängiges Layout],
  [layouts.typ],
  [gallery-grid],
  [Dynamisches Grid mit Farbrotation],
  [grids.typ],
  [feature-grid],
  [Feature-Karten mit Icon],
  [grids.typ],
  [stats-grid],
  [Statistik-Kennzahlen],
  [grids.typ],
  [comparison-grid],
  [Vorher-Nachher-Grid],
  [grids.typ],
  [styled-table],
  [Tabelle mit Header und Zebrastreifen],
  [tables.typ],
  [comparison-table],
  [Vergleichstabelle],
  [tables.typ],
  [book-cover],
  [Ganzseitige Buchcover],
  [spreads.typ],
  [chapter-opener],
  [Dekorativer Kapitelstart],
  [spreads.typ],
  [section-break],
  [Visueller Abschnittstrenner],
  [spreads.typ],
  [part-page],
  [Ganzseitiger Teiltrenner],
  [spreads.typ],
  [feature-spread],
  [Zwei-Seiten-Spread (Doppelseite)],
  [spreads.typ],
  [clinical-case-spread],
  [Fall/Diskussion über zwei Seiten],
  [spreads.typ],
  [learning-objectives],
  [Lernziele-Box mit Checkliste],
  [didactics.typ],
  [summary-box],
  [Zusammenfassung / „In Kürze"],
  [didactics.typ],
  [memo],
  [Merksatz / Key Point],
  [didactics.typ],
  [definition],
  [Formale Begriffsdefinition],
  [didactics.typ],
  [clinical-pearl],
  [Praxistipp / Clinical Pearl],
  [didactics.typ],
  [cave],
  [Cave / Red-Flag-Warnung],
  [didactics.typ],
  [excursus],
  [Exkurs / Vertiefung],
  [didactics.typ],
  [mnemonic],
  [Eselsbrücke mit Merkphrase],
  [didactics.typ],
  [ddx-box],
  [Differenzialdiagnose-Box],
  [didactics.typ],
  [clinical-case],
  [Strukturierter klinischer Fall],
  [didactics.typ],
  [mc-question / solution-key],
  [MCQ-Selbsttest mit Lösungsschlüssel],
  [exam.typ],
  [evidence-badge / loe-badge],
  [Empfehlungsgrad / Evidenzlevel],
  [inline.typ],
  [qty / qty-range],
  [Wert + Einheit, Bereichsangabe],
  [inline.typ],
  [score-table],
  [Score-Tabelle mit Summe],
  [tables.typ],
  [reference-table],
  [Normwert-Tabelle mit Abweichung],
  [tables.typ],
  [long-table / cspan / rspan],
  [Mehrseitige Tabelle, Zell-Spanning],
  [tables.typ],
  [margin-note / margin-setup],
  [Kollisionsfreie Randnotizen],
  [layouts.typ],
  [bar-chart / box-plot],
  [Balkendiagramm, Box-Plot],
  [charts.typ],
  [km-curve / roc-curve],
  [Kaplan-Meier, ROC-Kurve],
  [charts.typ],
  [percentile-chart / forest-plot],
  [Perzentilkurven, Forest-Plot],
  [charts.typ],
  [cycle-diagram / pathway-diagram],
  [Zyklus-, Pathway-Diagramm],
  [diagrams.typ],
  [pedigree],
  [Stammbaum (Genetik)],
  [pedigree.typ],
)

== Literaturverzeichnis

#set text(size: type-scale.small)

+ Bloom, B. S. (1956). _Taxonomy of Educational Objectives: The
  Classification of Educational Goals._ Longman.

+ Hattie, J. (2009). _Visible Learning: A Synthesis of Over 800
  Meta-Analyses Relating to Achievement._ Routledge.

+ Kolb, D. A. (1984). _Experiential Learning: Experience as the
  Source of Learning and Development._ Prentice Hall.

+ Mayer, R. E. (2009). _Multimedia Learning._ 2nd ed., Cambridge
  University Press.

+ Miller, G. A. (1956). The Magical Number Seven, Plus or Minus Two.
  _Psychological Review_, 63(2), 81–97.

+ Ruder, E. (1967). _Typographie: Ein Gestaltungslehrbuch._
  Niggli Verlag.

+ Sackett, D. L. et al. (1996). Evidence-Based Medicine: What It Is
  and What It Isn't. _BMJ_, 312(7023), 71–72.

+ Sweller, J. (1988). Cognitive Load During Problem Solving: Effects
  on Learning. _Cognitive Science_, 12(2), 257–285.

#set text(size: type-scale.body)

== Index

Das Stichwortverzeichnis wird automatisch aus den im Fließtext gesetzten
`index`-Markierungen erzeugt (Paket `@preview/in-dexter`).

#columns(2, make-index(title: none, outlined: false))
