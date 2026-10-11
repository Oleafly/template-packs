#import "@preview/icu-datetime:0.2.2" as icu

#let fsr-einladung(
  sitzungsdatum: none,
  zeit: "16:00",
  raum: none,
  autor: "",
  sitzungstyp: "ordentlichen", // "ordentlichen" oder "außerordentlichen"
  logo: "fsr-logo.png",
  email: "fsr16@uni-kassel.de",
  tops: (),
  einleitungstext: none,
  online-link: "https://discord.com",
  online-text: "online auf Discord"
) = {
  set document(title: "Einladung zur Sitzung des FSR")
  set page(paper: "a4", margin: 2.5cm)
  set text(font: ("Liberation Sans", "Arial", "Helvetica",), fallback: true, size: 12pt, lang: "de")
  set par(justify: false)

  align(center, image(logo, width: 100%))
  v(1.5em)

  [
    *An die Mitglieder der Fachschaft* \
    Wilhelmshöher Allee 71 – 73 \
    D-34121 Kassel
  ]

  align(right, [*#link("mailto:" + email)[#email]*])

  v(0.5em)
  text(size: 10pt)[#icu.fmt(datetime.today(), locale: "de", length: "long")]

  v(0.8em)

  [Guten Tag,]
  v(0.8em)
  if einleitungstext != none {
    einleitungstext
  } else {
    [
      Hiermit laden wir Sie herzlich zur nächsten #sitzungstyp Sitzung des FSR ein.
      Die Sitzung wird am *#sitzungsdatum.display("[day].[month].[year]")*, um
      *#zeit Uhr* #if raum != none ["in *Raum #raum*"] else [#link(online-link)[#online-text]] stattfinden.
    ]
  }
  v(1em)

  [Nachfolgend die Tagesordnung:]
  v(0.3em)
  for (i, punkt) in tops.enumerate(start: 1) {
    let num = if i < 10 { "0" + str(i) } else { str(i) }
    block(below: 0.5em)[*TOP #num:* #punkt]
  }

  v(1em)
  [
    Mit freundlichen Grüßen,
  ]
  v(0.1em)
  [
    #autor, Vorsitzende:r des FSR \
    #link("mailto:" + email)[#email]
  ]
}
