/*
|              ██         
| ████▄ ▄███▄ ▀██▀▀ ▄█▀█▄ 
| ██ ██ ██ ██  ██   ██▄█▀ 
| ██ ██ ▀███▀  ██   ▀█▄▄▄ 
| 
| Ce fichier est basé sur du code précédemment écrit par @DACC4 et @samuelroland.
| Dépot original: https://github.com/DACC4/HEIG-VD-typst-template-for-TB
| 
*/

#let config = (

    global: (
      confidential: true,
      text_lang: "fr"
    ),

    information: (
      title: "Exemple de titre",
      subtitle: "Exemple de sous-titre",
      academic_years: "2025-26",
      departement: (
        court: "TIC",
        long: "Technologies de l'information et de la communication (TIC)",
      ),
      filiere: (
        court: "ISC",
        long: "Informatique et systèmes de communication (ISC)",
      ),
      orientation: (
        court: "ISC-S",
        long: "Sécurité informatique (ISC-S)",
      ),
      author: (
        name: "firstname lastname",
        feminine_form: true,
      ),
      supervisor: (
        name: "Prof. Bli Bla",
        feminine_form: true,
      ),
      industry_contact: (
        name: "Nom",
        address: [
          Rue XY\
          1400 Yverdon-les-Bains
        ],
        industry_name: "EntrepriseZ",
      ),
      resume_publiable: [
        #lorem(100)\
        \
        #lorem(50)
      ]
    ),
    bibliography: (
      content: read("bibliography.yaml", encoding: none),
      style: "ieee"
    ),
  )