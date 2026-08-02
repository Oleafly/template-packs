#let caratula(
  universidad: "",
  facultad:"",
  titulo: "",
  tipo_de_documento: "",
  laboratorio: "",
  autor: "",
  director: "",
  codirector: "",
  lugar: "Buenos Aires, " + datetime.today().display("[Year]"),
  logo-path: "../imagenes/logofcen.pdf", // Ruta al logo de Exactas
) = {

  // Configuración de página limpia (sin números de página en la portada)
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
    numbering: none,
  )
  
  set text(lang: "es", size: 12pt, font: "New Computer Modern")
  
  // Contenido centrado
  align(center)[
    // 1. Logo de la facultad 

    #v(-1cm)
    #if logo-path != none {
      // Ajustamos el ancho a los 2.6cm que tenías en LaTeX
      image(logo-path, width: 5cm)
    }
    
    #v(0.5cm)
    
    // 2. Encabezado institucional
    #text(size: 14pt)[
      #smallcaps[#universidad] \ \
      #smallcaps[#facultad]
    ]
    
    // Espacio gigante antes del título (los 7.0cm de tu LaTeX)
    #v(1cm)
    
    // 3. Título de la Tesis
    #text(size: 26pt, weight: "bold")[#titulo]
    
    #v(2cm)
    
    // 4. Tipo de documento y Carrera
    #text(size: 14pt)[#tipo_de_documento]
    
    #v(2cm)
    
    // 5. Autor
    #text(size: 16pt)[#autor]
  ]
  

  
  // 6. Directores y ubicación (abajo a la izquierda)
  align(center)[
    #text(size: 12pt)[
      *Director:* #director \
      #v(0.2cm)
      #if codirector != none [
        *Codirector:* #codirector \
        #v(0.2cm)
      ]
      #lugar
    ]
  ]
  
  // Saltamos de página para que empiece el documento real
  pagebreak()
}