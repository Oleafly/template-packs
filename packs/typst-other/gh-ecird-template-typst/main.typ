#import "./template.typ": * // Import du template

#show: front_header.with( // Appel de la fonction, rajouter les arguments souhaités

  uptitle: [Surtitre],
  title: [Titre],
  subtitle: [Sous-titre],

  authors: (
    (
      name: "Auteur 1",
      affiliation: "Filière 1",
      year: "Année 1",
      class: "Classe 1",
      email: "auteur1@tata.web"
    ),
    (
      name: "Auteur 2",
      affiliation: "Filière 2",
      year: "Année 2",
      class: "Classe 2",
      email: "auteur2@toto.fr"
    )
  ),
  
  //big_logo: "/assets/logo_crown.svg",
  little_logo: "./assets/logo_dog_cat.svg",
  front-image: "./assets/front_rose.svg",

  header-title: "En-tête 1",
  header-middle: [En-tête 2],
  header-subtitle: "En-tête 3",

  date: "01/02/2058"
)

/*
 * Tables
 */

#outline(indent: auto)

//#heading(numbering: none)[Table des figures] <fig_outline>
//#outline(target: figure.where(kind: image), title: none)

//#heading(numbering: none)[Table des tableaux]
//#outline(target: figure.where(kind: table), title: none)

//#heading(numbering: none)[Table des équations]
//#outline(target: figure.where(kind: "equation"), title: none)

//#heading(numbering: none)[Table des listages]
//#outline(target: figure.where(kind: raw), title: none)

#pagebreak()

/*Le reste du document*/

= Titre 1


#pagebreak()

/*Bibliographie*/

#bibliography("bibs.yaml", style: "ieee")

#pagebreak()

/*Glossaire*/

#heading(numbering: none)[Glossaire]

/ Terme: Une définition de ce terme.
