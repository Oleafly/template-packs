// =============================================================================
// FOM-Template: Sperrvermerk und Eigenständigkeitserklärung
// (Leitfaden 1.3 und 2.10 / Anhang 8)
// =============================================================================

// Sperrvermerk (Leitfaden 1.3): nur bei Arbeiten mit unternehmensinternen
// Daten. Wird vom Template nach den Verzeichnissen vor dem Textteil
// eingefügt, erhält eine römische Seitenzahl und erscheint im
// Inhaltsverzeichnis. Wortlaut gemäß Muster im Leitfaden.
#let sperrvermerk(ort: "", datum: "", englisch: false) = {
  pagebreak(weak: true)
  if englisch {
    heading(level: 1, numbering: none, outlined: true, "Confidentiality Clause")
    [
      The following assignment contains confidential data relating to internal
      company matters of the company named in the assignment. Therefore, the
      publication of the thesis is not permitted. Outside the university, the
      thesis may only be published with the prior written consent of the
      company.
    ]
  } else {
    heading(level: 1, numbering: none, outlined: true, "Sperrvermerk")
    [
      Die vorliegende Abschlussarbeit enthält unternehmensinterne Daten des in
      der Arbeit genannten Unternehmens. Aus diesem Grund ist die
      Veröffentlichung der Arbeit nicht erlaubt. Die Arbeit darf außerhalb der
      Hochschule nur mit der ausdrücklichen Genehmigung des Unternehmens
      veröffentlicht werden.
    ]
  }
  v(3em)
  [(#ort, #datum) #h(1fr) (Eigenhändige Unterschrift)]
}

// Eigenständigkeitserklärung (Leitfaden 2.10, Wortlaut gemäß Anhang 8).
// Hinweis des Leitfadens: Sie muss der Prüfungsleistung nicht zwingend
// beigefügt werden, da sie bereits bei der Prüfungsanmeldung bestätigt wird.
// Sie erhält KEINE Seitenzahl und erscheint NICHT im Inhaltsverzeichnis
// (Leitfaden 1.2 Nr. 10 bzw. 2.2).
#let eigenstaendigkeitserklaerung(ort: "", datum: "") = {
  pagebreak(weak: true)
  set page(numbering: none)
  heading(level: 1, numbering: none, outlined: false, "Eigenständigkeitserklärung")

  [
    Hiermit versichere ich, dass ich die angemeldete Prüfungsleistung in allen
    Teilen eigenständig ohne Hilfe von Dritten anfertigen und keine anderen
    als die in der Prüfungsleistung angegebenen Quellen und zugelassenen
    Hilfsmittel verwenden werde. Sämtliche wörtlichen und sinngemäßen
    Übernahmen inklusive KI-generierter Inhalte werde ich kenntlich machen.

    Diese Prüfungsleistung hat zum Zeitpunkt der Abgabe weder in gleicher noch
    in ähnlicher Form, auch nicht auszugsweise, bereits einer Prüfungsbehörde
    zur Prüfung vorgelegen; hiervon ausgenommen sind Prüfungsleistungen, für
    die in der Modulbeschreibung ausdrücklich andere Regelungen festgelegt
    sind.

    Mir ist bekannt, dass die Zuwiderhandlung gegen den Inhalt dieser
    Erklärung einen Täuschungsversuch darstellt, der das Nichtbestehen der
    Prüfung zur Folge hat und daneben strafrechtlich gem. § 156 StGB verfolgt
    werden kann. Darüber hinaus ist mir bekannt, dass ich bei schwerwiegender
    Täuschung exmatrikuliert und mit einer Geldbuße bis zu 50.000 EUR nach der
    für mich gültigen Rahmenprüfungsordnung belegt werden kann.

    Ich erkläre mich damit einverstanden, dass diese Prüfungsleistung zwecks
    Plagiatsprüfung auf die Server externer Anbieter hochgeladen werden darf.
    Die Plagiatsprüfung stellt keine Zurverfügungstellung für die
    Öffentlichkeit dar.
  ]

  v(4em)
  grid(
    columns: (1fr, 1fr),
    column-gutter: 3em,
    align(left)[
      #line(length: 100%, stroke: 0.5pt)
      #if ort != "" or datum != "" [#ort, #datum] else [Ort, Datum]
    ],
    align(left)[
      #line(length: 100%, stroke: 0.5pt)
      Unterschrift
    ],
  )
}
