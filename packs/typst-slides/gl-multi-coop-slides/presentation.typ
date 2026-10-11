#import "multi_template.typ": *

#let doc_title = "Typst: alternative à Latex"
#let author = "Erica Delagnier"
#let client_logo = "assets/logo-CLIENT.png"

#show: doc => multi_mise_en_page(
  doc_title, doc, author: author, client_logo: client_logo
)

= Théorie 
 
== Typst c'est quoi ? 

#quote(
  attribution: "Github - Typst", 
  [A markup-based typesetting system that is powerful and easy to learn.]
)

Licence : Apache-2.0

Language : Rust

Export : PDF (par défaut), HTML (en construction avec un focus sur la structure)

= Pratique 

== Comment s'en servir ?
#double_column(
  [
    localement avec Codium
    #image(height: 200pt, "assets/image.png")
  ], 
  [
    en ligne sur leur webapp
    #image(height: 200pt, "assets/image-1.png")
  ]
)

== En ligne de commande 

#quote(
  [``` typst compile fichier.typ ```]
)

== Points forts : 

- bonne documentation
- grande bibliothéque de templates et de librairies
- facilité de création des templates
- facilité d'utilisation pour des mise en page même complexe

== Cas d'usage : Erasmus +

Génération dynamique de PDF en récupérant des données GRIST pour les intégrer dans un document Typst

Création d'un template réutilisable permettant de facilement créer de nouveaux documents.

