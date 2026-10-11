// ─── Declaration of independent work ──────────────────────────────────────────
// No page number, not in table of contents.

#let declaration(meta) = {
  set page(numbering: none, header: none, footer: none)
  pagebreak(weak: true)

  heading(outlined: false, numbering: none)[Eigenständigkeitserklärung]

  v(1em)

  let multi = meta.authors.len() > 1

  [
    Hiermit #if multi [versichern wir] else [versichere ich],
    dass #if multi [wir] else [ich] die angemeldete Prüfungsleistung in allen Teilen
    eigenständig ohne Hilfe von Dritten anfertigen und keine anderen als die in der
    Prüfungsleistung angegebenen Quellen und zugelassenen Hilfsmittel verwenden
    #if multi [werden] else [werde].
    Sämtliche wörtlichen und sinngemäßen Übernahmen inklusive KI-generierter Inhalte
    #if multi [werden wir] else [werde ich] kenntlich machen.

    Diese Prüfungsleistung hat zum Zeitpunkt der Abgabe weder in gleicher noch in
    ähnlicher Form, auch nicht auszugsweise, bereits einer Prüfungsbehörde zur Prüfung
    vorgelegen; hiervon ausgenommen sind Prüfungsleistungen, für die in der
    Modulbeschreibung ausdrücklich andere Regelungen festgelegt sind.

    #if multi [Uns] else [Mir] ist bekannt, dass die Zuwiderhandlung gegen den Inhalt
    dieser Erklärung einen Täuschungsversuch darstellt, der das Nichtbestehen der Prüfung
    zur Folge hat und daneben strafrechtlich gem. § 156 StGB verfolgt werden kann.
    Darüber hinaus ist #if multi [uns] else [mir] bekannt, dass
    #if multi [wir] else [ich] bei schwerwiegender Täuschung exmatrikuliert und mit einer
    Geldbuße bis zu 50.000 EUR nach der für #if multi [uns] else [mich] gültigen
    Rahmenprüfungsordnung belegt werden #if multi [können] else [kann].

    #if multi [Wir erklären uns] else [Ich erkläre mich] damit einverstanden, dass diese
    Prüfungsleistung zwecks Plagiatsprüfung auf die Server externer Anbieter hochgeladen
    werden darf. Die Plagiatsprüfung stellt keine Zurverfügungstellung für die
    Öffentlichkeit dar.
  ]

  v(3cm)

  line(length: 100%, stroke: 0.5pt)
  v(0.2em)
  grid(
    columns: (1fr, 1fr),
    [Ort, Datum],
    [#meta.authors.map(a => a.name).join(", ")],
  )
}
