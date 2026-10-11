#import "/layout/fonts.typ": *

#let cover(
  titulo: "",
  ciudad: "",
  nombreAlumno: "",
  nombreProfesor: "",
  nombreCorreferente: "",
  mesExamen: "",
  anioExamen: "",
) = {
  set page(
    paper: "us-letter",
    margin: (top: 2.5cm, bottom: 3cm, left: 3cm, right: 3cm),
    numbering: none,
  )
  set text(font: fonts.body, size: 12pt, lang: "es")

  align(center)[
    #text(size: 18pt)[UNIVERSIDAD TÉCNICA FEDERICO SANTA MARÍA]
    \
    #text(size: 16pt)[DEPARTAMENTO DE INFORMÁTICA]
    \
    #text(size: 16pt)[#upper(ciudad) – CHILE]

    #v(1.5cm)

    #image("/figures/utfsm_logo.jpg", width: 4.41cm, height: 3.34cm)

    #v(1.5cm)

    #text(size: 20pt)[\u{201C}#upper(titulo)\u{201D}]

    #v(1fr)

    #text(size: 16pt)[#upper(nombreAlumno)]

    #v(1fr)

    #text(size: 16pt)[MEMORIA PARA OPTAR AL TÍTULO DE]
    \
    #text(size: 16pt)[INGENIERO CIVIL EN INFORMÁTICA]

    #v(1.5cm)

    #text(size: 14pt)[Profesor Guía: #nombreProfesor]
    \
    #text(size: 14pt)[Profesor Correferente: #nombreCorreferente]

    #v(2.5cm)

    #text(size: 14pt)[#mesExamen - #anioExamen]
  ]
}
