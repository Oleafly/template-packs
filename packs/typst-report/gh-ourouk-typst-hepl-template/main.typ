#import  "template/template.typ":  *

#show: project.with(
  main-title: "Typst",
  sub-title: "Use a Template",
  fullTitlePage: false,
  authors: (
    (
      first-name: "Andrea",
      last-name: "Spelgatti",
      cursus: "M. Ing. Ind. - G. Electrique Informatique",
    ),
  ),
  bibliography-file: "../ref.bib",
)

= Utiliser dans visual Studio Code
#link("https://marketplace.visualstudio.com/items?itemName=mgt19937.typst-preview")
Permet de prévisualiser facilement les fichiers .typ dans Visual Studio Code.
= Include
== Image
#image("template/figures/g2.svg")
== Code block
```IOS
  access-list 10 deny 192.168.1.0 0.0.0.255
  access-list 10 permit 192.168.1.100 0.0.0.0
```
== Bibliographie
= Remerciement
Merci à Guilain Ernotte de l'ULiège pour sa template original
- #cite(<azSpecificationsFonctionnellesExemples2023>)
