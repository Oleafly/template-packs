// **************************************************************************
//
//  Template 'caratula' para Typst (migrado desde LaTeX v0.3)
//  Para componer carátulas de TPs del DC - UBA
//
// **************************************************************************

// Función principal para crear la carátula
#let caratula(
  materia: none,
  submateria: none,
  titulo: none,
  subtitulo: none,
  grupo: none,
  fecha: none,
  integrantes: (),
  logo-adicional: none,
  body
) = {
  
  // Validación de datos requeridos
  assert(materia != none, message: "Falta proveer la materia")
  assert(titulo != none, message: "Falta proveer el título")
  assert(integrantes.len() > 0, message: "Debe haber al menos un integrante")
  
  set document(title: titulo, author: integrantes.map(i => i.nombre))
  
  // Página de carátula
  page(
    margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 2.5cm),
    [
      // Header con logos
      #grid(
        columns: (1fr, auto),
        align: (left, right),
        [
          #if logo-adicional != none {
            image(logo-adicional, height: 2cm)
          }
        ],
        [
          // Logo DC (si existe el archivo logo_dc.jpg en tu proyecto)
          #image("logo_dc.jpg", height: 3cm)
        ]
      )
      
      #v(3cm)
      
      // Título principal
      #text(size: 24pt, weight: "bold")[#titulo]
      
      #if subtitulo != none {
        v(-1.0em)
        text(size: 16pt, weight: "bold")[#subtitulo]
      }
      
      #line(length: 100%, stroke: 1pt)
      
      // Fecha y materia
      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#text(size: 12pt)[#fecha]],
        [#text(size: 12pt)[#materia]]
      )
      
      #if submateria != none {
        align(right)[#text(size: 11pt)[#submateria]]
      }
      
      #v(2em)
      
      // Grupo (si existe)
      #if grupo != none {
        align(center)[
          #text(weight: "bold")[#grupo]
        ]
        v(1em)
      }
      
      // Tabla de integrantes
      #align(center)[
        #table(
          columns: (auto, auto, auto),
          align: (col, row) => {
            // Center align the header cells
            if row == 0 or col == 1 {return center} 
            else {return left}
          },
          stroke: 0.5pt,
          inset: 10pt,
          
          // Header
          table.header(
            [*Integrante*], [*LU*], [*Correo electrónico*]
          ),
          
          // Filas de integrantes
          ..integrantes.map(int => (
            int.nombre,
            int.lu,
            raw(int.email)
          )).flatten()
        )
      ]
      
      #v(1fr)
      
      // Footer con logo UBA e información
      #grid(
        columns: (55%, 45%),
        align: (left, left),
        column-gutter: 1em,
        [
          // Logo UBA (si existe el archivo logo_uba.jpg)
          #image("logo_uba.jpg", width: 85%)
        ],
        align(bottom)[
          #text(weight: "bold", font: "Liberation Sans")[Facultad de Ciencias Exactas y Naturales] \
          #text(font: "Liberation Sans")[Universidad de Buenos Aires] \
          #v(0.5em)
          #text(size: 8pt)[
            Ciudad Universitaria - (Pabellón I/Planta Baja) \
            Intendente Güiraldes 2160 - C1428EGA \
            Ciudad Autónoma de Buenos Aires - Rep. Argentina \
            Tel/Fax: (54 11) 4576-3359 \
            http://www.fcen.uba.ar
          ]
        ]
      )
    ]
  )
  
  // Contenido del documento
  body
}


// Ejemplo de uso:
// #show: caratula.with(
//   materia: "Organización del Computador II",
//   submateria: "Primer Cuatrimestre de 2024",
//   titulo: "Trabajo Práctico 1",
//   subtitulo: "Subtítulo del TP",
//   grupo: "Grupo 42",
//   fecha: "17 de Noviembre de 2025",
//   integrantes: (
//     (nombre: "Juan Pérez", lu: "123/45", email: "jperez@example.com"),
//     (nombre: "María García", lu: "678/90", email: "mgarcia@example.com"),
//   ),
//   // logo-adicional: "logo_orga2.png", // opcional
// )
//
// = Introducción
// Contenido del documento...