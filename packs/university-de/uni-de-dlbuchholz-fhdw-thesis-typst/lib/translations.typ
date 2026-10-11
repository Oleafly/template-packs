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
  bachelor-thesis: value(
    en: "Bachelor thesis",
    de: "Bachelorarbeit",
  ),

  master-thesis: value(
    en: "Master thesis",
    de: "Masterarbeit",
  ),

  faculty-of: value(
    en: "Faculty of",
    /*de: "Fakultät",*/
    de: "Studiengang"
  ),

  department-of: value(
    en: "Department of",
    /*de: "Department",*/
    de: "Bachelor of Science (B.Sc.)",
  ),

  bachelor-thesis-submitted-for-examination-in-bachelors-degree: value(
    en: "Bachelor thesis submitted for examination in Bachelor's degree",
    de: "Bachelorarbeit eingereicht im Rahmen der Bachelorprüfung",
  ),

  master-thesis-submitted-for-examination-in-masters-degree: value(
    en: "Master thesis submitted for examination in Master's degree",
    de: "Masterarbeit eingereicht im Rahmen der Masterprüfung",
  ),

  in-the-study-course: value(
    en: "in the study course",
    de: "im Studiengang"
  ),

  at-the-department: value(
    en: "at the Department",
    de: "am Department"
  ),

  at-the-faculty-of: value(
    en: "at the Faculty of",
    de: "der Fakultät"
  ),

  at-university-of-applied-science-hamburg: value(
    en: "at University of Applied Science Hamburg",
    de: "der Fachhochschule für die Wirtschaft Hannover"
  ),

  supervising-examiner: value(
    en: "Supervising examiner",
    de: "Betreuender Prüfer",
  ),

  second-examiner: value(
    en: "Second examiner",
    de: "Zweitgutachter",
  ),

  submitted: value(
    en: "Submitted",
    de: "Eingereicht am",
  ),

  list-of-figures: value(
    en: "List of Figures",
    de: "Abbildungsverzeichnis"
  ),

  list-of-tables: value(
    en: "List of Tables",
    de: "Tabellenverzeichnis"
  ),

  listings: value(
    en: "Listings",
    de: "Listings"
  ),

  declaration-of-independent-processing: value(
    en: "Declaration of Independent Processing",
    de: "Erklärung der Selbstständigkeit",
  ),

  declaration-of-independent-processing-content: value(
    en: "I hereby certify that I wrote this work independently without any outside help and only used the resources specified. Passages taken literally or figuratively from other works are identified by citing the sources.",
    de: "Hiermit versichere ich, dass ich die vorliegende Bachelorarbeit selbständig verfasst und keine anderen als die angegebenen Quellen verwendet habe. Alle Textstellen und andere Inhalte wie Bilder, Quellcode oder Daten, die wörtlich oder sinngemäß aus anderen Quellen entnommen sind, habe ich eindeutig mit korrekten Quellenangaben versehen. Über Zitierrichtlinien bin ich schriftlich informiert worden. Diese Arbeit wurde bisher in gleicher oder ähnlicher Form, auch nicht in Teilen, keiner anderen Prüfungsbehörde vorgelegt.",
  ),

  place: value(
    en: "Place",
    de: "Ort",
  ),

  date: value(
    en: "Date",
    de: "Datum",
  ),

  signature: value(
    en: "Original Signature",
    de: "Unterschrift im Original"
  ),
)