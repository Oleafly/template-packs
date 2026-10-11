
#let diploma(title: "Diploma title", 
  logo: "default.png", 
  background: "background.png", 
  graduate: (name: "Name", id: "CC.19283718", code: "1234"), 
  institution: (primaryText: "texto con el rango de fechas", signature: "signature.png", sigFirstText: "Institution signature data.", sigSecondText: "a secondary text"), 
  doc) = {
  set document(
    title: title
  )
  set page(
    paper: "us-letter",
    margin: (x: 2cm, y: 2cm),
    flipped: true,
    background: {
    image(background)
  }
  )
  set text(
    font: "Liberation Serif",
    size: 15pt,
  ) 
  set par(
    spacing: 10pt
  )
  align(center)[#image(logo, width:130pt)]
  v(10pt)
  align(center)[Otorga a]
  v(20pt)
  align(center)[#text(size: 25pt)[#graduate.name]]
  align(center)[#text(size: 15pt)[#graduate.id]]
  v(10pt)
  align(center)[el diploma en]
  v(20pt)
  align(center)[#text(size: 35pt)[#title]]
  v(10pt)
  align(center)[código: \[ #graduate.code \]]
  v(20pt)
  align(center)[#text(size: 20pt)[#institution.primaryText]]
  align(center+bottom)[En constancia firma:]
  align(center+bottom)[#image(institution.signature, width:150pt)]
  align(center+bottom)[#institution.sigFirstText#parbreak()#institution.sigSecondText]
}
