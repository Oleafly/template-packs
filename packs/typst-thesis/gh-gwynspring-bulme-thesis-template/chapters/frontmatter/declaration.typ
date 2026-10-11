#import "./../../metadata.typ": *

#let image_dir = "../../img/"

#let declaration_person(name, photo) = {
  grid(
    columns: (1fr, 1fr),
    column-gutter: 2cm,

    [
      Graz, den #datetime.today().display("[day].[month].[year]")

      #v(2cm)

      #line(length: 7cm, stroke: 0.6pt + black)
      #v(0.3cm)
      Unterschrift:

      #v(0.4cm)
      #name
    ],

    [
      #align(center + horizon)[
        #box(
          width: 4cm,
          height: 6cm,
          stroke: 0.6pt + gray,
          inset: 0pt,
          image(image_dir + photo, width: 4cm, height: 6cm, fit: "cover"),
        )
      ]
    ],
  )
}

Hiermit versichere ich, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen Hilfsmittel als die angegebenen benützt habe. Die Stellen, die anderen Werken (gilt ebenso für Werke aus elektronischen Datenbanken oder aus dem Internet) wörtlich oder sinngemäß entnommen sind, habe ich unter Angabe der Quelle und Einhaltung der Regeln wissenschaftlichen Zitierens kenntlich gemacht. Diese Versicherung umfasst auch in der Arbeit verwendete bildliche Darstellungen, Tabellen, Skizzen und Zeichnungen. Für die Erstellung der Arbeit habe ich auch folgende Hilfsmittel generativer KI-Tools zu folgendem Zweck verwendet: [describe your AI tool usage here]. Die verwendeten Hilfsmittel wurden vollständig und wahrheitsgetreu inkl. Produktversion und Prompt ausgewiesen (siehe @chap:prompt).

#v(0.8cm)

#for (i, c) in meta.candidates.enumerate() {
  declaration_person(c.name, c.photo)

  if i < meta.candidates.len() - 1 {
    v(2.5cm)
  }
}
