#let titelblatt(
    pruefungsform: "",
    kursname: "",
    studiengang: "",
    titel: "",
    author: "",
    matrikel: "",
    betreuertyp: "",
    betreuer: "",
    date: datetime.today(),
  ) = {
  set page(numbering: none)
  


  // ── Titelblatt ─────────────────────────────────────────
  align(center)[
    #set par(leading: 2em)
    // Logo
    #v(1fr)
    #image("/img/logo.jpg", width: 7cm)
    #v(1fr)
    // Prüfungsform, Kursname
    #text[#pruefungsform]\
    #if titel == "" {
      text(size: 16pt, weight: "bold")[#kursname]
      linebreak()
    } else {
      text[#kursname]
      linebreak()
    }
    #v(1fr)
    // Bezeichnung des Studiengangs, Name der Hochschule
    #text[Studiengang: #studiengang]\
    #text[IU Internationale Hochschule]\
    #v(1fr)
    // Titel der Arbeit
    #if titel != "" {
      text(size: 16pt, weight: "bold")[#titel]
      linebreak()
      v(1fr)
    }
    // Name der studierenden Person, Matrikelnummer
    #text[#author]\
    #text[Matrikelnummer: #matrikel]\
    #v(1fr)
    // betreuenden Person, Abgabedatum
    #text[#betreuertyp: #betreuer]\
    #text[Abgabedatum: #date.display("[day].[month].[year]")]
    #v(2fr)
  ]
}
