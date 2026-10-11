#import "@preview/datify:1.0.0": custom-date-format

#let data-file = sys.inputs.at("data-file", default: "./data/acme.sample.yaml")
#let (person, company, notice) = yaml(data-file)

#let (recipient,) = company
#let salutation = if recipient.gender == "woman" [Madame] else if recipient.gender == "man" [Monsieur] else [Madame, Monsieur]

#set document(
  author: person.name,
  title: [Notification de démission],
)

#set page(
  footer: context [
    #set align(center)
    #set text(10pt)
    #counter(page).display(
      "1 / 1",
      both: true,
    )
  ],
)

#set text(
  lang: "fr",
  size: 12pt,
  font: "Roboto",
)

#block[
  #person.name\
  #person.address#person.postal_code #person.city
]

#align(end)[
  #company.name\
  #recipient.name\
  #recipient.position\
  #recipient.address
]

#v(1em)

#if notice.keys().contains("serial") [
  Lettre recommandée avec accusé de réception n°#notice.serial
] else [
  Lettre remise en main propre en deux exemplaires contre décharge.
]

#v(1em)

#align(end)[
  À #person.city, le #custom-date-format(datetime.today(), pattern: "long", lang: "fr")
]

_#underline[Objet] : #context(document.title)._
#v(2em)

#salutation,

Je souhaite par la présente vous signifier ma démission.

#if notice.negociate == "no" [
  Dès lors, mon départ sera effectif à l’expiration de mon préavis (d’une durée de #notice.duration).
] else [
  Bien que mon départ soit conditionné au respect d’un préavis (d’une durée de #notice.duration),
  je souhaiterais négocier une date de départ anticipée et ainsi être libéré de l’exécution de
  #if notice.negociate == "all" [la totalité] else [d’une partie] de celui-ci.
]

À l’expiration de mon contrat de travail, je vous demanderai de bien vouloir rendre accessibles les documents suivants : certificat de travail, reçu pour solde de tout compte, attestation France Travail.

Je me tiens à votre disposition pour déterminer une date de départ effective au regard de ma situation.

Veuillez agréer, #salutation, l’expression de ma considération distinguée.

#v(3em)
#align(end)[
  #person.name
  #if person.keys().contains("signature") [
    #image(person.signature, width: 2.75cm)
  ]
]
