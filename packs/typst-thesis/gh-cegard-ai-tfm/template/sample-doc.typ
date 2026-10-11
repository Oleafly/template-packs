// Simple UNIR Document Example
// Import the UNIR template
#import "../unir_ia_tfm.typ": *

#show: tfmia.with(
  title: "Título de mi TFG",
  authors: [Mi nombre],
  director: [Nombre de mi director],
  resumen: lorem(abstract_length),
  abstract: lorem(abstract_length),
  pclave: lorem(6).replace(" ", ", ").replace(",,", ","),
  kwords: lorem(6).replace(" ", ", ").replace(",,", ","),
  logo: image("logo_unir.png", width: 85%),
  city: "Bogotá",
  date: "15 de octubre de 2025",
)

= Introducción