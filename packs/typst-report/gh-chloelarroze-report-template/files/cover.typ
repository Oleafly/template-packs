/***********************/
/* TEMPLATE DEFINITION */
/***********************/

/* HANDLING DATE DISPLAY */

#let translate_month(month) = {
  // Construction mapping for months
  let t = (:)
  let fr-month-s = ("Janv.", "Févr.", "Mars", "Avr.", "Mai", "Juin",
    "Juill.", "Août", "Sept.", "Oct.", "Nov.", "Déc.")
  let fr-months-l = ("Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
    "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre")
  for i in range(12) {
    let idate = datetime(year: 0, month: i + 1, day: 1)
    let ml = idate.display("[month repr:long]")
    let ms = idate.display("[month repr:short]")
    t.insert(ml, fr-months-l.at(i))
    t.insert(ms, fr-month-s.at(i))
  }

  // Translating month
  let fr_month = t.at(month)
  fr_month
}

#let display-date(date, short-month) = {
  context {
    // Récupération du mois avec option court/long
    let repr = if short-month { "short" } else { "long" }
    let month = date.display("[month repr:" + repr + "]")

    // Traduction en français si besoin
    if text.lang == "fr" {
      month = translate_month(month)
    }

    // Affiche le jour, le mois, puis l’année
    [#str(date.day()) #month #str(date.year())]
  }
}


/* MAIN COVER DEFINITION */
#let cover(
  title,
  author,
  date-start,
  date-end,
  subtitle: none,
  logo: none,
  short-month: false,
  logo-horizontal: true,
  tutor: none,
  promo: none,
  confidentiality: none 
) = {
  set page(fill : gradient.linear(rgb("f1efff"), rgb("f1efff")), background: move(dx: 0pt, dy: -13%, image("./../assets/blason.svg")))
  //possibilité d'ajouter un gradient ici (juste changer la couleur)
  set text(font: "New Computer Modern Sans", hyphenate: false, fill: rgb("5f259f"))
  set align(center)

  v(50mm)

  set text(size: 24pt, weight: "bold")
  upper(title)

  v(50mm)

  if subtitle != none {
    set text(size: 20pt)
    subtitle
  }

  v(1.5fr)
  
  set text(size: 18pt, weight: "regular")
  display-date(date-start, short-month); [ \- ]; display-date(date-end, short-month)

  image("./../assets/filet-court.svg")

  // 👇 Nouveau bloc d'infos
  if tutor != none or promo != none or confidentiality != none {
    v(0.5fr)
    set text(size: 12pt)

    v(1fr)

  if tutor != none {
    set text(size: 12pt)
    "Tuteur de stage : " + tutor
  }
   v(0.2fr)
  
  if promo != none {
    "Promotion : " + promo
  }
   v(1fr)
  
  }

  v(1fr)

  let logo-height = if (logo-horizontal) { 20mm } else { 30mm }
  let path-logo = if (logo-horizontal) { "./../assets/logomiones_black.png" } else { "./../assets/logo-x.svg" }

  set image(height: logo-height)

  if (logo != none) {
    grid(
      columns: (1fr, 1fr), align: center + horizon,
      logo, image(path-logo)
    )
  } else {
    grid(
      columns: (1fr), align: center + horizon,
      image(path-logo)
    )
  }
  
  v(2fr)
   set text(size: 16pt)
  smallcaps(author)
  
  v(1fr)
   if confidentiality != none {
    set text(style: "italic", size: 10pt)
    confidentiality
  }
}



/********************/
/* TESTING TEMPLATE */
/********************/

#set text(lang: "fr")

#cover(
  [A very long title over multiple lines automatically],
  "Jane Doe",
  datetime.today(),
  datetime.today(),
  subtitle: "Je n'ai pas de stage mais je suis trkl",
  logo-horizontal: true,
  tutor: "Jean Dupont",
  promo: "EI23",
  confidentiality: "Ce document est confidentiel et ne doit pas être diffusé."
)
