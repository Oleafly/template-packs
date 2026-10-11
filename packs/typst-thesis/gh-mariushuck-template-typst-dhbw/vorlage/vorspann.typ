// =====================================================================
// vorspann.typ — Titelblatt, Sperrvermerk, Ehrenwörtliche Erklärung,
//                Gleichstellungsklausel
//
// Diese Seiten sind NICHT nummeriert und stehen NICHT im
// Inhaltsverzeichnis.
//
// Beide Funktionen erwarten den `angaben`-Satz aus main.typ. Hier ist
// nichts zu ändern, wenn eine neue Arbeit beginnt — nur dort.
// =====================================================================

#import "dhbw.typ": LEADING_EINZEILIG, ZEILENABSTAND

// ---------------------------------------------------------------------
// Titelblatt
// ---------------------------------------------------------------------
//
// Aufbau: alles zentriert, fett sind ausschließlich das Thema und die Art
// der Arbeit. Angabenblock als Zweispalter, links rechtsbündig gegen die
// Spaltengrenze, rechts linksbündig. Der Satz füllt das obere Blattdrittel
// bis etwa zur Mitte, der Rest bleibt frei.
//
// Pflichtangaben laut DHBW: Hochschule, Fakultät, Studiengang, Thema, Art
// der Arbeit, Prüfungszweck, Verfasser, Kurs, Partnerunternehmen,
// wissenschaftliche Betreuung, Abgabedatum sowie der Hinweis auf den
// Sperrvermerk, soweit vorhanden. Das DHBW-Muster (Anhang der Hinweise)
// ist ausdrücklich nur ein Vorschlag; die Reihenfolge hier weicht davon ab
// und ergänzt die betriebliche Betreuung, für die das Muster kein Feld
// vorsieht.
#let titelblatt(angaben) = {
  set par(justify: false, leading: ZEILENABSTAND, spacing: 16pt)
  set text(hyphenate: false)

  // Logos. Mit Partnerlogo nebeneinander, zentriert, an der Unterkante
  // ausgerichtet; ohne Partnerlogo steht das Hochschullogo allein.
  align(center)[
    #if angaben.partner-logo != none [
      #grid(
        columns: (auto, auto),
        column-gutter: 0.5cm,
        align: bottom,
        image("logos/dhbw-karlsruhe.jpeg", width: 6.3cm),
        image(angaben.partner-logo, width: 2.7cm),
      )
    ] else [
      #image("logos/dhbw-karlsruhe.jpeg", width: 6.3cm)
    ]
  ]

  v(1.03cm)

  align(center)[
    #angaben.fakultaet

    #angaben.studiengang
  ]

  v(0.43cm)

  // Thema der Arbeit — eine Stufe größer als der Fließtext, fett.
  //
  // `titel-zeilen` ist der von Hand gesetzte Umbruch. Er lohnt sich, sobald
  // Typst an einer unschönen Stelle trennt (etwa nach einer Präposition);
  // bei leerer Liste bricht Typst selbst um.
  let titelzeilen = if angaben.titel-zeilen.len() > 0 {
    angaben.titel-zeilen
  } else {
    (angaben.titel,)
  }
  align(center)[
    #text(size: 14pt, weight: "bold")[
      #set par(spacing: 21pt)
      #titelzeilen.map(z => [#z]).join(parbreak())
    ]
  ]

  v(0.57cm)

  align(center)[#text(weight: "bold")[#angaben.art]]

  // Prüfungszweck: kleiner als der Fließtext, nicht fett
  align(center)[#text(size: 11pt)[#angaben.zweck]]

  // Hinweis auf den Sperrvermerk. Die DHBW-Hinweise führen ihn unter den
  // Pflichtangaben des Titelblatts ("Hinweis auf Sperrvermerk, soweit
  // vorhanden").
  //
  // Als echter Text und nicht als Grafik — so ist er im PDF durchsuchbar
  // und kopierbar.
  //
  // STELLSCHRAUBEN: `size`, `weight` und `fill`. Nicht fett und 16 pt hält
  // den Schriftzug bewusst unter dem Thema, das mit 14 pt fett der
  // Blickfang bleiben soll. Wer an der Größe dreht, muss den Abstand
  // darunter nachmessen — die Zeilenhöhe geht in den sichtbaren Abstand
  // ein.
  if angaben.sperrvermerk {
    v(0.6cm)
    align(center)[
      #text(size: 16pt, fill: rgb(237, 110, 37), tracking: 0.4pt)[Sperrvermerk]
    ]
    // Auf denselben optischen Wert eingestellt wie der Abstand oberhalb:
    // 1,015 cm zwischen Unterkante und Oberkante der Nachbarzeile. Die
    // beiden v()-Werte unterscheiden sich (0,60 gegen 0,63 cm), weil hier
    // drei Schriftgrößen aufeinandertreffen — 11 pt darüber, 16 pt der
    // Schriftzug, 12 pt darunter.
    v(0.63cm)
  } else {
    // Ohne Schriftzug bleibt derselbe optische Abstand wie unter den Logos.
    v(1.03cm)
  }

  // Pflichtangaben, zweispaltig statt mit Tabulatoren.
  // Beschriftungen rechtsbündig, Werte linksbündig — die Trennung zwischen
  // beiden liegt exakt auf der Mittelachse des Satzspiegels, also genau
  // unter der Mitte der zentrierten Zeilen darüber.
  //
  // Erreicht wird das durch ZWEI GLEICH BREITE Spalten (`1fr, 1fr`) über die
  // volle Textbreite: jede Spalte erhält (15 cm − Abstand) / 2, wodurch der
  // Zwischenraum zwangsläufig mittig liegt — bei 3,5 cm linkem Rand also bei
  // 3,5 + 7,5 = 11,0 cm. Das gilt für jeden Wert von `column-gutter`; die
  // Zentrierung kann durch eine Änderung des Abstands nicht kaputtgehen.
  // Eine feste Spaltenbreite mit `pad` davor wäre dagegen bei jeder
  // Änderung nachzurechnen.
  let SPALTENABSTAND = 0.5cm
  let angaben-zeile(label, wert) = grid(
    columns: (1fr, 1fr),
    align: (right, left),
    column-gutter: SPALTENABSTAND,
    label, wert,
  )

  // "Verfasserin/Verfasser" und "Wissenschaftlich betreut von" sind der
  // Wortlaut des DHBW-Musters und geschlechtsneutral — anders als
  // "Wissenschaftlicher Betreuer", das der Vorgabe geschlechtergerechter
  // Formulierung widerspricht. Zeilen mit `none` entfallen.
  let zeilen = (
    ("Verfasserin/Verfasser:", angaben.verfasser),
    ("Kurs:", angaben.kurs),
    ("Partnerunternehmen:", angaben.partnerunternehmen),
    ("Wissenschaftlich betreut von:", angaben.betreuung-wiss),
    ("Betrieblich betreut von:", angaben.betreuung-betrieb),
  ).filter(((label, wert)) => wert != none)

  grid(
    columns: (1fr, 1fr),
    align: (right, left),
    row-gutter: 18pt,
    column-gutter: SPALTENABSTAND,
    ..zeilen.map(((label, wert)) => (label, wert)).flatten(),
  )

  v(26pt)

  angaben-zeile([Abgabedatum:], angaben.abgabedatum)

  pagebreak()
}

// ---------------------------------------------------------------------
// Sperrvermerk, Ehrenwörtliche Erklärung, Gleichstellungsklausel
//
// Jede Erklärung steht auf einem eigenen Blatt: "Nach dem Titelblatt wird
// ein Blatt mit dem Text des Sperrvermerks eingeordnet."
// ---------------------------------------------------------------------

#let erklaerungen(angaben) = {
  // Die Absatzüberschriften dieser Seiten sind bewusst KEINE `heading`,
  // damit sie nicht im Inhaltsverzeichnis auftauchen. Größe und Abstände
  // entsprechen aber genau denen eines Unterkapitels (14 pt fett, 18 pt
  // Abstand nach unten), damit der Vorspann nicht aus dem Bild fällt.
  let ueberschrift(t) = block(above: 0pt, below: 18pt)[
    #set par(leading: LEADING_EINZEILIG)
    #text(size: 14pt, weight: "bold")[#t]
  ]

  // Wortlaut des Sperrvermerks aus den DHBW-Hinweisen. Ob ein Sperrvermerk
  // nötig ist, entscheidet der Duale Partner.
  if angaben.sperrvermerk {
    ueberschrift[Sperrvermerk]

    [
      Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen außerhalb des
      Prüfungsprozesses und des Evaluationsverfahrens zugänglich gemacht werden, sofern keine
      anderslautende Genehmigung des Dualen Partners vorliegt.
    ]

    pagebreak()
  }

  ueberschrift[Ehrenwörtliche Erklärung]

  [
    Ich versichere hiermit, dass ich die vorliegende Arbeit selbstständig verfasst und keine
    anderen als die angegebenen Quellen und Hilfsmittel verwendet habe und diese Arbeit bei keiner
    anderen Prüfung mit gleichem oder vergleichbarem Inhalt vorgelegt habe und diese bislang nicht
    veröffentlicht wurde.
  ]

  v(1.6cm)

  // Unterschrift. Die abzugebende PDF-Fassung muss eine eingescannte
  // eigenhändige Unterschrift tragen.
  //
  // SO GEHT ES: Unterschrift auf weißes Papier, abfotografieren oder
  // scannen, freistellen (weißer/transparenter Hintergrund) und als
  // `logos/unterschrift.png` ablegen. Dann die Zeile unten einkommentieren.
  // Solange die Datei fehlt, steht dort nur die Linie — das PDF ist damit
  // NICHT abgabefertig.
  grid(
    columns: (1fr, 1fr),
    row-gutter: 4pt,
    [#angaben.ort, #angaben.abgabedatum],
    align(left)[
      // #box(width: 6cm)[#place(bottom + left, dy: 2pt, image("logos/unterschrift.png", height: 1.4cm))]
      #box(width: 6cm, line(length: 100%, stroke: 0.5pt))
    ],
    [],
    align(left)[(Unterschrift)],
  )

  // Gleichstellungsklausel auf einem eigenen Blatt
  pagebreak()

  ueberschrift[Gleichstellungsklausel]

  [
    Zur besseren Lesbarkeit wird in dieser Arbeit das generische Maskulinum verwendet. Die in
    dieser Arbeit verwendeten Personenbezeichnungen beziehen sich -- sofern nicht anders kenntlich
    gemacht -- auf alle Geschlechter.
  ]
}
