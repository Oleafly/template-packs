// chapters/25-rechtskunde.typ — Berufs- und Rechtskunde

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout
#import "../components/didactics.typ": cave, memo
#import "../components/tables.typ": comparison-table
#import "../components/legal.typ": (
  abkuerzungen, absatz, buchstabe, gesetzeskasten, gutachten, legaldefinition, norm, normenhierarchie,
  nummer, paragraf, pruefungsschema, randnummer, randnummer-reset, rechtsprechung, tatbestand-rechtsfolge,
)
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Berufs- und Rechtskunde: Recht im klinischen Alltag],
  lead: [
    Heilberufe handeln in einem dichten Netz aus Gesetzen, Verordnungen
    und Berufsordnungen. Ein Fachbuch muss Normtexte deshalb genauso
    sorgfältig darstellen wie Befunde — wörtlich, korrekt zitiert und
    didaktisch erschlossen. Dieses Kapitel zeigt den Baukasten dafür:
    vom Normzitat über den Gesetzeskasten bis zum Gutachten.
  ],
)

Juristische Darstellung folgt eigenen Konventionen. Eine Norm wird
_wörtlich_ wiedergegeben, ihre Fundstelle _präzise_ zitiert, ihre
Struktur (Absatz, Satz, Nummer, Buchstabe) sichtbar gemacht und ihr
Inhalt in Tatbestand und Rechtsfolge zerlegt. Die Komponenten dieses
Kapitels (`src/components/legal.typ`) bilden das token-gebunden ab.

#callout(tone: "info", title: [Werkzeuge im Typst-Ökosystem])[
  Vieles ließe sich mit Paketen lösen: `@preview/rich-counters` für die
  automatische §→Absatz→Satz-Zählung, `@preview/theorion` oder
  `@preview/great-theorems` für nummerierte Definitions-/Fallblöcke,
  `@preview/glossarium` bzw. `@preview/abbr` für das
  Abkürzungsverzeichnis, `@preview/citrus` für CSL-basierte juristische
  Zitate (Falltypen) und die native `bibliography(style: "oscola.csl")`.
  Hier ist alles bewusst _nativ_ gebaut — token-gebunden und
  konfliktfrei, wie die didaktische Box-Familie.
]

== Normen richtig zitieren#index[Normzitat]

Eine Fundstelle benennt Vorschrift, Gliederungsebene und Gesetz. Im
Gesetzesrecht zählt das Paragraphenzeichen #paragraf[§], im
Verfassungs- und Europarecht der #paragraf[Art.]. Darunter gliedern
#index[Absatz]_Absatz_ (1), _Satz_, _Halbsatz_ (Hs.), _Nummer_ (Nr.)
und _Buchstabe_ (lit.). Beispiele, einheitlich gesetzt mit `norm(…)`:

#block(inset: (left: space.md), {
  set par(spacing: space.sm)
  [• Strafrecht: #norm(p: 203, abs: 1, satz: 1, gesetz: "StGB") \ ]
  [• Zivilrecht: #norm(p: 630, abs: 2, gesetz: "BGB")#h(2pt) (Behandlungsvertrag) \ ]
  [• Verfassungsrecht: #norm(art: 12, abs: 1, gesetz: "GG")#h(2pt) (Berufsfreiheit) \ ]
  [• Mit Nummer und Buchstabe: #norm(p: 6, abs: 1, nr: 1, lit: "a", gesetz: "IfSG")]
})

#memo(title: [Zitiergrundsatz])[
  Immer von der speziellsten zur allgemeinsten Ebene und mit
  amtlichem Gesetzeskürzel: „§ 203 Abs. 1 Satz 1 Nr. 1 StGB". Das
  Kürzel steht am Ende, nie in Klammern.
]

== Der Gesetzestext im Kasten#index[Gesetzeskasten]

Der wörtliche Normtext gehört in einen abgesetzten Kasten — mit
amtlicher Überschrift, sichtbarer Absatzgliederung und Quellenangabe.

#gesetzeskasten(
  norm-id: norm(p: 203, gesetz: "StGB"),
  titel: [Verletzung von Privatgeheimnissen],
  quelle: [StGB, Auszug — Hervorhebung der Gliederung durch die Darstellung],
)[
  #absatz(1)[
    Wer unbefugt ein fremdes Geheimnis, namentlich ein zum persönlichen
    Lebensbereich gehörendes Geheimnis, offenbart, das ihm als
    #nummer(1)[Arzt, Zahnarzt, Tierarzt, Apotheker oder Angehörigen
      eines anderen Heilberufs, der für die Berufsausübung oder die
      Führung der Berufsbezeichnung eine staatlich geregelte Ausbildung
      erfordert,]
    #nummer(2)[Berufspsychologen mit anerkannter Ausbildung,]
    anvertraut worden oder sonst bekannt geworden ist, wird mit
    Freiheitsstrafe bis zu einem Jahr oder mit Geldstrafe bestraft.
  ]
  #absatz(2)[
    Ebenso wird bestraft, wer unbefugt ein fremdes Geheimnis verwertet,
    das ihm unter den Voraussetzungen des Absatzes 1 bekannt geworden ist.
  ]
]

Die amtliche Überschrift ist kursiv neben das Normzitat gesetzt; die
Absätze tragen ihre Klammernummern im hängenden Einzug, die Nummern
rücken eine Stufe ein. Artikel funktionieren identisch:

#gesetzeskasten(
  norm-id: norm(art: 12, gesetz: "GG"),
  titel: [Berufsfreiheit],
  quelle: [Grundgesetz, Auszug],
)[
  #absatz(1)[
    Alle Deutschen haben das Recht, Beruf, Arbeitsplatz und
    Ausbildungsstätte frei zu wählen. Die Berufsausübung kann durch
    Gesetz oder auf Grund eines Gesetzes geregelt werden.
  ]
]

== Anatomie einer Norm: Tatbestand und Rechtsfolge#index[Tatbestand]

Jede vollständige Rechtsnorm verknüpft einen _Tatbestand_ (die
Voraussetzungen) mit einer _Rechtsfolge_ (die Konsequenz) — das
Wenn-Dann der Norm.

#tatbestand-rechtsfolge(
  tatbestand: [Unbefugtes Offenbaren eines fremden, anvertrauten
    Geheimnisses durch einen Angehörigen eines Heilberufs
    (#norm(p: 203, abs: 1, gesetz: "StGB"))],
  rechtsfolge: [Freiheitsstrafe bis zu einem Jahr oder Geldstrafe —
    Strafbarkeit als Offizialdelikt auf Antrag],
)

== Der Behandlungsvertrag#index[Behandlungsvertrag]

Das Patientenrechtegesetz hat den Behandlungsvertrag 2013 in den
#norm(p: 630, gesetz: "BGB")-Komplex (§§ 630a–630h BGB) kodifiziert.

#gesetzeskasten(
  norm-id: norm(p: 630, gesetz: "BGB"),
  titel: [Vertragstypische Pflichten beim Behandlungsvertrag],
  quelle: [BGB, Auszug],
)[
  #absatz(1)[
    Durch den Behandlungsvertrag wird derjenige, welcher die
    medizinische Behandlung eines Patienten zusagt (Behandelnder), zur
    Leistung der versprochenen Behandlung, der andere Teil (Patient) zur
    Gewährung der vereinbarten Vergütung verpflichtet, soweit nicht ein
    Dritter zur Zahlung verpflichtet ist.
  ]
  #absatz(2)[
    Die Behandlung hat nach den zum Zeitpunkt der Behandlung
    bestehenden, allgemein anerkannten fachlichen Standards zu erfolgen,
    soweit nicht etwas anderes vereinbart ist.
  ]
]

#legaldefinition(term: [Facharztstandard], fundstelle: [zu #norm(p: 630, abs: 2, gesetz: "BGB")])[
  Der „allgemein anerkannte fachliche Standard" verlangt das Maß an
  Kenntnis und Können, das von einem gewissenhaften Facharzt im
  jeweiligen Fachgebiet zum Behandlungszeitpunkt erwartet wird — ein
  objektiver, dynamischer Sorgfaltsmaßstab.
]

== Rechtsprechung lesen#index[Rechtsprechung]

Gerichtsentscheidungen konkretisieren die Normen. Ein
Rechtsprechungskasten nennt Gericht, Datum, Aktenzeichen und Fundstelle
und hebt den Leitsatz hervor.

#rechtsprechung(
  gericht: [BGH],
  datum: [Urteil vom 28.01.2014],
  az: [VI ZR 143/13],
  fundstelle: [NJW 2014, 1527],
  leitsatz: [Die Aufklärung muss so rechtzeitig erfolgen, dass dem
    Patienten eine wohlüberlegte, freie Entscheidung über seine
    Einwilligung in den Eingriff möglich bleibt.],
)[
  Die Entscheidung verankert das Aufklärungsgespräch als
  Wirksamkeitsvoraussetzung der Einwilligung
  (#norm(p: 630, abs: 2, gesetz: "BGB"), #norm(p: "630e", gesetz: "BGB")): Ohne
  rechtzeitige Aufklärung ist die Einwilligung unwirksam und der
  Eingriff rechtswidrig.
]

== Randnummern: der juristische Kommentar#index[Randnummer]

Kommentarliteratur nummeriert ihre Sinnabschnitte mit fortlaufenden
_Randnummern_ (Rn.) im Steg, auf die präzise verwiesen werden kann.

#randnummer-reset()
#randnummer[
  Die ärztliche Schweigepflicht (#norm(p: 203, gesetz: "StGB"),
  berufsrechtlich § 9 MBO-Ä) schützt das Vertrauensverhältnis zwischen
  Patient und Behandelndem und gilt grundsätzlich auch über den Tod des
  Patienten hinaus.
]
#randnummer[
  Sie ist nicht absolut. Befugt — und damit straflos — ist die
  Offenbarung insbesondere bei wirksamer _Einwilligung_ des Patienten,
  bei gesetzlichen _Offenbarungspflichten_ (etwa der Meldepflicht nach
  dem IfSG) sowie im _rechtfertigenden Notstand_ (#norm(p: 34, gesetz: "StGB")).
]
#randnummer[
  Der rechtfertigende Notstand verlangt eine Güterabwägung: Das
  geschützte Interesse (z. B. Leib und Leben Dritter) muss das
  beeinträchtigte Geheimhaltungsinteresse _wesentlich_ überwiegen.
]

== Im Gutachtenstil prüfen#index[Gutachten]

Die Subsumtion eines Sachverhalts unter eine Norm folgt dem
_Gutachtenstil_: Obersatz, Definition, Subsumtion, Ergebnis.

#gutachten(
  titel: [Strafbarkeit nach #norm(p: 203, abs: 1, gesetz: "StGB")],
  obersatz: [Die Ärztin A könnte sich durch die Weitergabe der Diagnose
    an den Arbeitgeber des Patienten P nach #norm(p: 203, abs: 1, gesetz: "StGB")
    strafbar gemacht haben.],
  definition: [Ein Geheimnis ist jede Tatsache, die nur einem
    beschränkten Personenkreis bekannt ist und an deren Geheimhaltung
    der Betroffene ein schutzwürdiges Interesse hat. Die Diagnose ist
    ein solches, der Ärztin in ihrer Berufsrolle anvertrautes Geheimnis.],
  subsumtion: [A hat die Diagnose ohne Einwilligung des P und ohne
    gesetzliche Befugnis an einen Dritten weitergegeben; sie handelte
    damit _unbefugt_ und offenbarte das Geheimnis.],
  ergebnis: [A hat sich nach #norm(p: 203, abs: 1, gesetz: "StGB") strafbar
    gemacht (Strafantrag vorausgesetzt, #norm(p: 205, gesetz: "StGB")).],
)

Für wiederkehrende Prüfungen lohnt ein abstraktes _Prüfungsschema_:

#pruefungsschema(
  titel: [Wirksame Einwilligung in den Heileingriff],
  schritte: (
    (label: [I.], body: [_Einwilligungsfähigkeit_ — natürliche Einsichts-
      und Urteilsfähigkeit des Patienten (nicht die Geschäftsfähigkeit).]),
    (label: [II.], body: [_Aufklärung_ — rechtzeitig, mündlich und
      verständlich über Art, Umfang, Folgen, Risiken und Alternativen
      (#norm(p: "630e", gesetz: "BGB")).]),
    (label: [III.], body: [_Freiwilligkeit_ — ohne Zwang, Täuschung oder
      Drohung erklärt.]),
    (label: [IV.], body: [_Reichweite_ — die Einwilligung deckt nur den
      aufgeklärten Eingriff; Erweiterungen bedürfen erneuter Einwilligung.]),
  ),
)

== Die Normenhierarchie#index[Normenhierarchie]

Normen stehen in einem Rangverhältnis: Höherrangiges Recht bricht
niederrangiges. Für Heilberufe reicht die Kette vom Grundgesetz bis zur
Berufsordnung der Landesärztekammer.

#normenhierarchie((
  (label: [Grundgesetz (GG)], note: [Verfassung — Art. 12 Berufsfreiheit]),
  (label: [Förmliche Bundesgesetze], note: [BGB, StGB, IfSG, BÄO, SGB V]),
  (label: [Rechtsverordnungen], note: [ÄApprO, BtMVV]),
  (label: [Satzungen], note: [Berufsordnung der Ärztekammern (MBO-Ä)]),
))

== Meldepflichten nach dem IfSG#index[Meldepflicht]

Das Infektionsschutzgesetz durchbricht die Schweigepflicht durch
gesetzliche Meldepflichten an das Gesundheitsamt — namentlich
(personenbezogen) oder nichtnamentlich.

#comparison-table(
  headers: ([Norm], [Gegenstand], [Beispiele], [Frist]),
  rows: (
    ([§ 6 IfSG], [Krankheit (Verdacht, Erkrankung, Tod)], [Masern, Diphtherie, Cholera, Tuberkulose], [unverzüglich, längstens 24 h]),
    ([§ 7 Abs. 1 IfSG], [Erregernachweis (namentlich)], [Salmonella, SARS-CoV-2, Hepatitis-Viren], [unverzüglich, längstens 24 h]),
    ([§ 7 Abs. 3 IfSG], [Erregernachweis (nichtnamentlich)], [HIV, Treponema pallidum, Echinococcus], [binnen zwei Wochen]),
  ),
)

#cave[
  Wer meldepflichtige Tatsachen nicht, nicht richtig oder nicht
  rechtzeitig meldet, handelt ordnungswidrig (#norm(p: 73, gesetz: "IfSG"))
  — die Meldepflicht ist zugleich Rechtfertigungsgrund für die
  Durchbrechung der Schweigepflicht.
]

== Abkürzungsverzeichnis Recht#index[Abkürzungsverzeichnis]

Ein juristisches Abkürzungsverzeichnis erschließt die Kürzel der
zitierten Vorschriften.

#abkuerzungen((
  (kurz: [GG], lang: [Grundgesetz]),
  (kurz: [BGB], lang: [Bürgerliches Gesetzbuch]),
  (kurz: [StGB], lang: [Strafgesetzbuch]),
  (kurz: [IfSG], lang: [Infektionsschutzgesetz]),
  (kurz: [BÄO], lang: [Bundesärzteordnung]),
  (kurz: [ÄApprO], lang: [Approbationsordnung für Ärzte]),
  (kurz: [MBO-Ä], lang: [(Muster-)Berufsordnung für Ärzte]),
  (kurz: [SGB V], lang: [Sozialgesetzbuch Fünftes Buch]),
  (kurz: [BtMG], lang: [Betäubungsmittelgesetz]),
  (kurz: [PatRG], lang: [Patientenrechtegesetz]),
  (kurz: [DSGVO], lang: [Datenschutz-Grundverordnung]),
  (kurz: [TPG], lang: [Transplantationsgesetz]),
))

#section-break()

#memo(title: [Kerngedanke])[
  Gute juristische Darstellung trennt sauber: _Wortlaut_ (Gesetzeskasten),
  _Auslegung_ (Definition, Kommentar mit Randnummern), _Anwendung_
  (Gutachten) und _Rang_ (Normenhierarchie). Wer diese Ebenen sichtbar
  hält, macht Recht nachvollziehbar — und prüfbar.
]
