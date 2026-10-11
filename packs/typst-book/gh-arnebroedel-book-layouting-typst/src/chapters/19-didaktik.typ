// chapters/19-didaktik.typ — Didaktische Bausteine

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, clinical-case-spread, section-break
#import "../components/blocks.typ": callout
#import "../components/inline.typ": evidence-badge, loe-badge, qty, qty-range
#import "@preview/in-dexter:0.7.2": index
#import "../components/layouts.typ": margin-note, margin-setup
#import "../components/didactics.typ": (
  cave, clinical-case, clinical-pearl, ddx-box, definition, excursus, learning-objectives, memo, mnemonic,
  summary-box,
)
#import "../components/tables.typ": cspan, long-table, reference-table, score-table
#import "../components/exam.typ": mc-question, solution-key

#chapter-opener(
  title: [Didaktische Bausteine],
  lead: [
    Ein medizinisches Lehrbuch lebt von seinen didaktischen Elementen:
    Lernziele strukturieren, Merksätze verdichten, klinische Fälle
    veranschaulichen, Warnhinweise schützen. Dieses Kapitel stellt den
    Autoren-Baukasten vor — wiederverwendbare Komponenten für genau diese
    Aufgaben.
  ],
)

#learning-objectives(items: (
  [die didaktischen Box-Typen und ihren Einsatzzweck unterscheiden],
  [klinische Tabellen (Scores, Normwerte) korrekt einsetzen],
  [Selbsttests mit Lösungsschlüssel und Randnotizen gestalten],
))

// ════════════════════════════════════════════════════════════════
== Didaktische Boxen

Jede Box trägt eine farbcodierte Kennung und folgt dem zentralen
Design-Token-System. So bleibt das Erscheinungsbild über das gesamte Buch
konsistent — und dennoch sind die Typen auf einen Blick unterscheidbar.

#definition(term: [Arterielle Hypertonie#index[Hypertonie]])[
  Dauerhaft erhöhter arterieller Blutdruck mit Praxiswerten ab
  #qty[140/90][mmHg]. Sie ist der wichtigste behandelbare Risikofaktor
  für kardiovaskuläre Erkrankungen. Der Normalbereich des systolischen
  Drucks liegt etwa bei #qty-range[100][130][mmHg].
]

#memo(title: [Zeit ist Muskel])[
  Beim ST-Hebungsinfarkt (STEMI)#index[Myokardinfarkt] sollte die
  _Door-to-Balloon_-Zeit #qty[90][Minuten] nicht überschreiten — jede
  Minute Ischämie kostet Myokard.
]

#clinical-pearl[
  Bei jedem unklaren Thoraxschmerz lohnt der Blick auf die _Wells-Kriterien_:
  Sie schätzen die klinische Vortestwahrscheinlichkeit einer
  Lungenembolie#index[Lungenembolie] und steuern die weitere Diagnostik.
]

#cave(title: [Kontraindikation])[
  Betablocker sind bei dekompensierter Herzinsuffizienz und höhergradigem
  AV-Block kontraindiziert. Vor Therapiebeginn EKG und klinischen Status
  prüfen.
]

#mnemonic(phrase: [„IHST"])[
  Die vier klassischen Infarktzeichen im EKG: *I*schämie (T-Negativierung),
  *H*ebung (ST-Strecke), *S*penkung, *T*erminale Veränderungen.
]

#excursus(title: [Aus der Geschichte])[
  René Laënnec erfand 1816 das Stethoskop, weil es ihm unangenehm war, das
  Ohr direkt auf die Brust einer Patientin zu legen. Die Auskultation
  revolutionierte die körperliche Untersuchung.
]

#ddx-box(title: [Differenzialdiagnose Thoraxschmerz])[
  Akutes Koronarsyndrom, Lungenembolie, Aortendissektion, Perikarditis,
  Pneumothorax, Refluxösophagitis, muskuloskelettaler Schmerz.
]

Empfehlungen lassen sich mit Evidenz-Badges auszeichnen:
Die Gabe von ASS beim akuten Koronarsyndrom ist eine starke Empfehlung
#evidence-badge("A") auf hohem Evidenzniveau #loe-badge(1). Demgegenüber
beruht manche Praxisempfehlung nur auf Expertenkonsens #evidence-badge("D")
#loe-badge(5).

#section-break()

// ════════════════════════════════════════════════════════════════
== Klinische Tabellen

Scores, Normwerte und Medikationspläne sind das tabellarische Rückgrat des
Fachbuchs. Die Score-Tabelle summiert Punkte und hebt das Ergebnis hervor:

#figure(
  score-table(
    (
      ([Augen öffnen — spontan (4), auf Ansprache (3), auf Schmerz (2), keine (1)], 4),
      ([Verbale Antwort — orientiert (5) … keine (1)], 5),
      ([Motorische Antwort — befolgt Aufforderung (6) … keine (1)], 6),
    ),
    total: 15,
    total-label: [Glasgow Coma Scale],
  ),
  caption: [Glasgow Coma Scale — Score-Tabelle mit hervorgehobener Summe.],
)

Normwert-Tabellen markieren Abweichungen farblich — erhöhte, erniedrigte
und kritische Werte sind sofort erkennbar:

#figure(
  reference-table((
    (param: [Natrium], value: [148 mmol/l], range: [135–145], flag: "high"),
    (param: [Kalium], value: [4.1 mmol/l], range: [3.5–5.1], flag: "normal"),
    (param: [Hämoglobin], value: [9.2 g/dl], range: [12–16], flag: "low"),
    (param: [Laktat], value: [6.8 mmol/l], range: [0.5–2.2], flag: "crit"),
    (param: [CRP], value: [4 mg/l], range: [< 5], flag: "normal"),
  )),
  caption: [Laborwerte mit automatischer Abweichungsmarkierung.],
)

Mehrseitige Tabellen wiederholen ihre Kopfzeile; verbundene Zellen
gliedern Gruppen:

#figure(
  long-table(
    columns: (auto, 1fr, auto, auto),
    table.header([*Nr.*], [*Wirkstoff*], [*Dosis*], [*Frequenz*]),
    table.cell(colspan: 4, fill: palette.bg-muted, text(weight: "bold", font: fonts.sans)[Antihypertensiva]),
    [1], [Ramipril], [5 mg], [1×/d],
    [2], [Amlodipin], [10 mg], [1×/d],
    table.cell(colspan: 4, fill: palette.bg-muted, text(weight: "bold", font: fonts.sans)[Antikoagulation]),
    [3], [Apixaban], [5 mg], [2×/d],
  ),
  caption: [Medikationsplan mit Gruppenüberschriften (verbundene Zellen).],
)

#section-break()

// ════════════════════════════════════════════════════════════════
== Selbsttest

Multiple-Choice-Fragen registrieren ihre Lösung automatisch; der
Lösungsschlüssel am Ende sammelt alle Antworten in Dokumentreihenfolge.

#mc-question(
  [Welcher Labormarker ist beim akuten Myokardinfarkt am spezifischsten?],
  ([CK-MB], [Troponin T], [LDH], [Myoglobin]),
  answer: 2,
  explanation: [Troponin T ist hochspezifisch für myokardiale Schädigung.],
)

#mc-question(
  [Welche Erstmaßnahme ist beim STEMI entscheidend?],
  ([Abwartendes Vorgehen], [Rasche Reperfusion], [Alleinige ASS-Gabe], [Sofortige Entlassung]),
  answer: 2,
)

#solution-key()

#section-break()

// ════════════════════════════════════════════════════════════════
== Randnotizen

Ab hier wird die Randspalte für _Tufte_-artige Marginalien aktiviert.
Randnotizen stehen kollisionsfrei am äußeren Seitenrand und eignen sich
für Begriffsklärungen, Quellen und Seitenkommentare.

#show: margin-setup

Die #strong[Lungenembolie] entsteht meist durch eine tiefe
Beinvenenthrombose, deren Thromben sich lösen und die Pulmonalarterien
verlegen.#margin-note(title: [Merke])[Troponin steigt erst 3–4 h nach
Symptombeginn — ein früh negativer Wert schließt einen Infarkt nicht aus.]
Die klinische Präsentation reicht von milder Dyspnoe bis zum
obstruktiven Schock.#margin-note[Der _Wells-Score_ schätzt die
Vortestwahrscheinlichkeit und steuert, ob ein D-Dimer oder direkt eine
CT-Angiografie sinnvoll ist.]

Die Diagnostik folgt einem klaren Pfad: Bei niedriger oder mittlerer
Vortestwahrscheinlichkeit wird zunächst das D-Dimer bestimmt; ein
negativer Wert schließt eine Lungenembolie mit hoher Sicherheit
aus.#margin-note(title: [Cave])[Ein erhöhtes D-Dimer ist unspezifisch — es
steigt auch bei Infektion, Trauma, Schwangerschaft und im hohen Alter.] Bei
hoher Wahrscheinlichkeit oder instabilen Patienten erfolgt direkt die
CT-Pulmonalisangiografie als Goldstandard.#margin-note[Bei
Kontrastmittel-Kontraindikation ist die Ventilations-Perfusions-Szintigrafie
eine Alternative.]

Therapeutisch steht die Antikoagulation im Vordergrund — bei
hämodynamischer Instabilität die systemische Thrombolyse.#margin-note[Direkte
orale Antikoagulanzien (DOAK) haben Vitamin-K-Antagonisten in vielen
Situationen abgelöst.] Auch längere Erläuterungen lassen sich so in die
Randspalte auslagern, ohne den Lesefluss des Haupttextes zu stören; die
Notizen stapeln sich automatisch und kollisionsfrei in der Reihenfolge
ihres Auftretens.

// ── Klinischer-Fall-Spread ──
#clinical-case-spread(
  title: [Fallbeispiel: Akute Lungenembolie],
  anamnese: [58-jährige Frau; seit zwei Stunden plötzlicher,
    atemabhängiger Thoraxschmerz und zunehmende Dyspnoe. Zustand nach
    Kniegelenksoperation vor 10 Tagen mit anschließender Immobilisation.
    Keine kardiale Vorgeschichte, Nichtraucherin, orale Kontrazeption.],
  befund: [Wache, deutlich dyspnoische Patientin. Tachykardie 112/min,
    Tachypnoe 24/min, Blutdruck 105/70 mmHg, SpO#sub[2] 89 % unter
    Raumluft. Gestaute Halsvenen, betonter zweiter Herzton; Beine ohne
    eindeutige Schwellung.],
  diagnose: [Akute Lungenembolie, CT-angiografisch gesichert (zentrale
    Füllungsdefekte beidseits) mit Rechtsherzbelastung im Echo.],
  therapie: [Sofortige therapeutische Antikoagulation; bei
    hämodynamischer Verschlechterung systemische Thrombolyse.],
  left-extra: [
    #v(space.md)
    #text(weight: "bold", font: fonts.sans, fill: palette.primary-dark)[Laborbefunde]
    #reference-table((
      (param: [D-Dimer], value: [4.8 mg/l], range: [< 0.5], flag: "crit"),
      (param: [Troponin T], value: [42 ng/l], range: [< 14], flag: "high"),
      (param: [SpO#sub[2]], value: [89 %], range: [≥ 95], flag: "low"),
      (param: [Herzfrequenz], value: [112/min], range: [60–100], flag: "high"),
    ))
  ],
  discussion: [
    Die postoperative Immobilisation ist ein klassischer Risikofaktor der
    venösen Thromboembolie. Der atemabhängige Thoraxschmerz mit Dyspnoe und
    Hypoxämie lenkt den Verdacht früh auf die Lungenembolie.

    Pathophysiologisch führt die Verlegung der Pulmonalarterien zu einer
    akuten Druckbelastung des rechten Ventrikels. Echokardiografische
    Zeichen der Rechtsherzbelastung und ein erhöhtes Troponin markieren die
    intermediär- bis hochrisiko-Konstellation und beeinflussen die
    Therapieentscheidung.

    Entscheidend bleibt die strukturierte Risikostratifizierung:
    Wells-Score zur Vortestwahrscheinlichkeit, D-Dimer als Ausschlusstest
    bei niedriger Wahrscheinlichkeit und die CT-Angiografie als Goldstandard
    der Bildgebung.
  ],
  right-extra: [
    #memo[Bei postoperativer Dyspnoe mit Hypoxämie immer an eine
    Lungenembolie denken — die unbehandelte Letalität ist hoch.]
    #text(weight: "bold", font: fonts.sans, fill: palette.primary-dark)[Take-home-Points]
    - Wells-Score steuert die Vortestwahrscheinlichkeit.
    - D-Dimer nur bei niedriger/mittlerer Wahrscheinlichkeit sinnvoll.
    - CT-Angiografie ist der bildgebende Goldstandard.
    - Therapie: Antikoagulation; bei Instabilität Thrombolyse.
  ],
)
