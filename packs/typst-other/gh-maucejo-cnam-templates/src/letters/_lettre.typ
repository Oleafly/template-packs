#import "../common/_colors.typ": *
#import "../common/_utils.typ": *

#let cnam-lettre(
  composante: "cnam",
  type: none,
  surtitre: none,
  destinataire: none,
  expediteur: none,
  objet: none,
  lieu: none,
  date: none,
  signature: none,
  body
) = {
  let logo-height = 4.08cm
  let decx = -0.073cm
  let decy = 0.085cm
  if composante != "cnam" {
    logo-height = 10cm
    decx = 0cm
    decy = 0cm
  }

  set heading(numbering: "1.1.")
  show heading.where(level: 1): it => {
    set text(size: 14pt, fill: primary.dark-blue)

    it
    v(0.5em)
  }

  set text(font: "Crimson Pro", size: 12pt, lang: "fr", ligatures: false)

  set par(justify: true)

  let footer = {
    grid(
      columns: (1fr, 1fr),
      align: left,
      [#h(-2.5cm) #context counter(page).at(here()).first()], [#place(right + horizon, dx: -0.75cm, block(over-title(title: ("Conservatoire national", "des arts et métiers"), size: 12pt, color: primary.dark-blue)))]
    )
  }
  set page(
    paper: "a4",
    footer: footer,
    margin: (top: 2.5cm, bottom: 2.5cm, left: 5cm, right: 2.5cm)
  )

  if type != none and surtitre == none {
    if type == "lettre-officielle" {
      surtitre = ("Lettre", "officielle")
    } else if type == "courrier-interne" {
      surtitre = ("Courrier", "interne")
    } else if type == "note-service" {
      surtitre = ("Note", "de service")
    } else if type == "note-cadrage" {
      surtitre = ("Note", "de cadrage")
    }
  } else if surtitre == none {
    surtitre = ("En-tête", "personnalisable")
  }

  let en-tete = {
    grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [#place(dx: - 2.5cm, over-title(title: surtitre, size: 20pt, color: primary.dark-blue))], [#place(right, dx: decx, dy: decy, image("../resources/logo/" + composante + ".png", width: logo-height))]
    )
  }

  place(top, dy: -1.5cm, en-tete)

  v(2cm)

  if destinataire != none {
    let dest = block[
      #set align(left)

      #destinataire.nom
      #linebreak()
      #destinataire.adresse
    ]

    move(dx: 7cm, dest)
    v(3em)
  }

  let lieu-date = ()
  if lieu != none {
   lieu-date.push(lieu)
  }

  if date != none {
    lieu-date.push(date)
  }

  if lieu != none and date != none {
    lieu-date.join(", le ")
    v(1em)
  } else if lieu != none {
    lieu
    v(1em)
  } else if date != none {
    [Le #date]
    v(1em)
  }

  if objet != none {
    let obj = text(weight: "semibold", [*Objet : *])

    obj + objet
    v(1em)
  }

  body

  v(2em)
  if expediteur != none {
    let sign = {
      [*Contact*]
      linebreak()
      expediteur.nom
      linebreak()
      expediteur.adresse
      linebreak()
      expediteur.telephone
      linebreak()
      expediteur.mail

      signature
    }

    move(dx: -2cm, sign)
  }
}