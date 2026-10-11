#let value(en: "", de: "") = {
  context {
    if text.lang == "en" {
      return en
    }

    if text.lang == "de" {
      return de
    }

    return "Unknown language"
  }
}

#let translations = (
  cover-title: value(
    en: "Theory/Practice Transfer Paper",
    de: "Transferleistung Theorie/Praxis"
  ),

  matriculation-number: value(
    en: "Matriculation number",
    de: "Matrikelnummer"
  ),

  transfermodule-topic: value(
    en: "Accepted topic",
    de: "Freigegebenes Thema"
  ),

  centurion: value(
    en: "Bachelor's programme, centuria",
    de: "Studiengang, Zenturie"
  ),

  list-of-figures: value(
    en: "List of Figures",
    de: "Abbildungsverzeichnis"
  ),

  list-of-tables: value(
    en: "List of Tables",
    de: "Tabellenverzeichnis"
  ),

  abbreviations: value(
    en: "Abbreviations",
    de: "Abkürzungsverzeichnis",
  ),

  bibliography: value(
    en: "Bibliography",
    de: "Literaturverzeichnis"
  ),

  appendix: value(
    en: "Appendix",
    de: "Anhang"
  ),

  glossary: value(
    en: "Glossary",
    de: "Glossar"
  )
)