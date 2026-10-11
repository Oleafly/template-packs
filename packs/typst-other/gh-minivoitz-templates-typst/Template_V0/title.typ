//----------------------------------------------------------//
//----------------------------------------------------------//
//Parameters to change
#let chemin_logo_entreprise = "Photos/Logos/logo_entreprise.png"
#let chemin_logo_ecole = "Photos/Logos/logo_ecole.png"
#let nom_entreprise = [Nom de l'entreprise]
#let nom_ecole = [Ecole des Mines de Saint-Etienne (EMSE)]
#let titre_rapport = [*Sujet du stage*]
#let date_debut = [(date de debut)]
#let date_fin = [(date de fin)]
#let titre_stage = [*Stage technique (2A)*]
#let nom_auteur = "NOM Prénom Auteur"
#let tuteur_entreprise = [NOM Prénom]
#let tuteur_academique = [NOM Prénom]
//----------------------------------------------------------//
//----------------------------------------------------------//

//Logos entreprise et ecole
#grid(
  columns: (auto, 1fr, auto),
  align: center,
  image(chemin_logo_entreprise, height: 6em, alt: "Entreprise d'acceuil"),
  "",
  image(chemin_logo_ecole, height: 6em, alt: "Ecole"),
  nom_entreprise,
  "",
  nom_ecole,
)

//Titre
#align(center + horizon, {
  line(length:100%, stroke:2pt)
  v(10pt)
  text(20pt, titre_rapport)
  v(10pt)
  line(length:100%, stroke:2pt)
  //Date du stage
  v(10pt)
  [Du #date_debut au #date_fin]
})



#align(bottom, {
  //Type de rapport
  underline(align(center)[#titre_stage])
  //Auteur
  v(20pt)
  align(center)[#nom_auteur]
  v(50pt)
  //Encadrants
  grid(
    columns: (1fr, 1fr),
    align: (left, right),
    rows: 1.5em,
    underline[Tuteur entreprise :],
    underline[Tuteur académique :],
    tuteur_entreprise,
    tuteur_academique,
  )
})