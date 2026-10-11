#let titlepage(
  title: "Demo Title",
  work_type: "Masterarbeit",
  subtitle: "",
  left_image: "",
  right_image:"",
  image_height: 2cm,
  author: "Stefan Maier",
  matrikelnummer: "12345678",
  dualer_partner: "ZF-Lifetec",
  betreuer: "Prof. Dr. Mustermann",
  pruefer: "Prof. Dr. Musterfrau",
  bearbeitungszeitraum: "01.01.2023 - 01.02.2023"

  ) = {

    //Größendefinitionen
    let TITLE_SIZE = 20pt
    let SUBTITLE_SIZE = 14pt
    let REGULAR_SIZE = 12pt
    let DEFAULT_VERTICAL_SPACING = 12mm
    let SMALL_VERTICAL_SPACING = 3mm
    let HINFÜHRUNG_ABSCHLUSSART = "für die Prüfung zum (Modul)"
    let ABSCHLUSSART = "Master of Science (M.Sc.)"

    let HOCHSCHULE_1 = "am Center for Advanced Studies"
    let HOCHSCHULE_2 = "der Dualen Hochschule Baden-Württemberg"


    // Bilder für die Titelseite vor dem Titel
    stack(dir: ltr,
    spacing: 1fr,
      if left_image != "" {
        image(left_image, height: image_height)
      }else{
        v(image_height)
      },
      if right_image != "" {
        image(right_image, height: image_height)
      }else{
        v(image_height)
      }
    )

    v(DEFAULT_VERTICAL_SPACING)

    // Titel
    align(center, text(weight: "bold", TITLE_SIZE, title))

    if subtitle != "" {
      // Untertitel
      align(center, text(weight: "bold", SUBTITLE_SIZE, subtitle))
    }

    v(DEFAULT_VERTICAL_SPACING)

    //Art der Arbeot
    if work_type != "" {
      align(center, text(weight: "bold", SUBTITLE_SIZE, work_type))
    }

    v(DEFAULT_VERTICAL_SPACING)

    //Abschlussart Hinleitung
    align(center, text(weight: "regular", REGULAR_SIZE, HINFÜHRUNG_ABSCHLUSSART))

    v(SMALL_VERTICAL_SPACING)

    // Abschlussart
    align(center, text(weight: "bold", REGULAR_SIZE, ABSCHLUSSART))

    v(DEFAULT_VERTICAL_SPACING)

    // Name der Hochschule
    align(center, text(weight: "regular", REGULAR_SIZE, HOCHSCHULE_1))
    align(center, text(weight: "regular", REGULAR_SIZE, HOCHSCHULE_2))

    v(DEFAULT_VERTICAL_SPACING+10mm)

    // Tabelle mit nötigen Informationen
    table(
      align: (left,right),
      columns:(1fr,1fr),
      row-gutter: 1.2mm, // damit die Zeilen nicht zu eng beieinander sind
      stroke: none,
      // Name des Autors
      text(weight: "bold", REGULAR_SIZE, "Vorname und Nachname:"),
      text(weight: "regular", REGULAR_SIZE, author),
      // Matrikelnummer
      text(weight: "bold", REGULAR_SIZE, "Matrikelnummer:"),
      text(weight: "regular", REGULAR_SIZE, matrikelnummer),
      // Bearbeitungszeitraum
      text(weight: "bold", REGULAR_SIZE, "Bearbeitungszeitraum:"),
      text(weight: "regular", REGULAR_SIZE, bearbeitungszeitraum),
      // Dualer Partner
      text(weight: "bold", REGULAR_SIZE, "Duale Partner:"),
      text(weight: "regular", REGULAR_SIZE, dualer_partner),
      //Betreuer/Prüferin
      text(weight: "bold", REGULAR_SIZE, "Betreuer*in/Prüfer*in:"),
      text(weight: "regular", REGULAR_SIZE, betreuer),
      //Prüferin
      text(weight: "bold", REGULAR_SIZE, "Prüfer*in:"),
      text(weight: "regular", REGULAR_SIZE, pruefer),


    )


    //Seitenumbruch damit Titelseite auf eigener Seite bleibt.
    pagebreak()
    }