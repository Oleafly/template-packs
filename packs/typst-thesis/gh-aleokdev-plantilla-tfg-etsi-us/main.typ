#import "template/lib.typ": tfg_etsi_us_template, pre-content, main-content, post-content, index,first-letter

#set text(font: ("Times New Roman", "Tinos"))

#show: tfg_etsi_us_template.with(
  // El título del TFG
  "Formato de Publicación de la Escuela Técnica Superior de Ingeniería",
  // El grado de la titulación, e.g. Ingeniería Industrial
  "Ingeniería de las Tecnologías de Telecomunicación",
  // Nombre y apellidos del autor
  "Nombre Apellidos",
  // Nombre y apellidos del tutor (o tutores)
  "Nombre Apellidos",
  // Título del tutor, p.ej. Profesor Asociado
  "Profesor Titular",
  // Nombre del departamento asociado
  "Dpto. Teoría de la Señal y Comunicaciones",
  // Año del TFG (Por defecto el año de compilación del archivo)
  // year: 2024
  // Activar el modo de desarrollo o no, por ahora sólo muestra la fecha del documento en la esquina superior derecha de la cubierta.
  dev-mode: true
  )


#pre-content[
  // El contenido de aquí usa numeración romana de páginas y los títulos
  // definidos no están numerados. Usado para índice, agradecimientos,
  // introducción, abstracto/resumen, ...
  = Agradecimientos
  #lorem(100)
  #pagebreak(to: "odd")

  = Resumen
  #lorem(100)
  #pagebreak(to: "odd")


  = Abstract
  #lorem(100)
  #pagebreak(to: "odd")

  // Ejemplo de uso de Índices personalizados
  #index(title:[Índice reducido hasta nivel 2],target:(heading.where(level: 1).or(heading.where(level: 2))))
  #pagebreak(to: "odd")

  #index(title:[Índice reducido hasta nivel 3],target:(heading.where(level: 1).or(heading.where(level: 2)).or(heading.where(level: 3))))
  #pagebreak(to: "odd")

  #index(title:[Índice sin reducir],target:(heading))
  #pagebreak(to: "odd")
]
#main-content[
  // Las páginas de aquí junto a los títulos definidos usan numeración arábiga
  // comenzando desde 1. Usado para el contenido principal del TFG
  = Capítulo
  // Ejemplo de uso de la función first-letter
  #first-letter([#lorem(50)])
  #pagebreak(to: "odd")

  == Subsección
  #lorem(50)
  #pagebreak(to: "odd")

  === Subsección2
  #lorem(50)
  
  #figure(table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  [A], [A], [A],
  [B], [B], [B],
  ),caption:  "Tabla de prueba")

  ==== Subsección3
  #lorem(50)
  #figure(image("template/figures/Logo.svg",width: 16%),caption:"Imagen de prueba")

  #pagebreak(to: "odd")
]
#post-content[
  // El contenido de aquí continúa con la numeración de páginas anterior, pero

  // Ejemplo de uso de Índice personalizados para figuras y tablas
  #index(title:[Índice de Figuras],target:(figure.where(kind:image)))
  #pagebreak(to: "odd")

  #index(title:[Índice de Tablas],target:(figure.where(kind:table)))
  #pagebreak(to: "odd")

  // los títulos definidos no están numerados. Usado para glosario,
  // bibliografía, índice de figuras...
  = Bibliografía
  #lorem(100)
  #pagebreak(to: "odd")
  // Recordar usar la función bibliography para la bibliografía.
  // Para mantener la lista de referencias se puede usar software como Mendeley.
  // #bibliography("referencias.bib")
]


