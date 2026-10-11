#import "./lib.typ": diploma

#show: diploma.with(
  title: "Gestión de contenidos y conocimientos comunitarios en la web",
  logo: "default.png", //path a el logo por defecto
  background: "background.png", //path a la imagen de fondo por defecto
  graduate: (
    name: "Perenseje Insolito",
    id: "CC.19283718",
    code: "1234" //este será el checksum del archivo  
  ),
  institution: (
  primaryText: "por su importante participación en la formación del 20 de Febrero al 22 de Marzo de 2025.",
  signature: "signature.png",
  sigFirstText: "Maestro Experto, PhD.",
  sigSecondText: "CEO, Universal S.A.S."
)
)
