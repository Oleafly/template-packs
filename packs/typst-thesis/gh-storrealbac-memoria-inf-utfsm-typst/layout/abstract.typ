#let abstract-page(
  resumen: "",
  palabrasClave: "",
  resumenIngles: "",
  palabrasClaveIngles: "",
) = {
  // RESUMEN
  text(size: 16pt, weight: "bold")[RESUMEN]

  v(0.3cm)

  [*Resumen---*#resumen]

  v(0.3cm)

  [*Palabras Clave---*#palabrasClave]

  v(1.2cm)

  // ABSTRACT
  text(size: 16pt, weight: "bold")[ABSTRACT]

  v(0.3cm)

  [*_Abstract---_*#resumenIngles]

  v(0.3cm)

  [*_Keywords---_*#palabrasClaveIngles]
}
