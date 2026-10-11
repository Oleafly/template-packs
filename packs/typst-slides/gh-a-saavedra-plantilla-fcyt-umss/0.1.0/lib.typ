// lib.typ - Plantilla oficial FCyT UMSS

#let fcyt-theme(
  titulo: none,
  subtitulo: none,
  autor: none,
  tema: "claro", // "claro", "oscuro" o "gris"
  aspect-ratio: "16-9",
  body
) = {
  // 1. Diccionario de colores centralizado
  let paleta = (
    oscuro: (fondo: rgb("#000814"), texto: rgb("#FFF3B0"), titulo: rgb("#FFFFFF"), acento: rgb("#00B4D8")),
    gris:   (fondo: rgb("#E9ECEF"), texto: rgb("#001D3D"), titulo: rgb("#1A1A1A"), acento: rgb("#0077B6")),
    claro:  (fondo: rgb("#FFFFFF"), texto: rgb("#212121"), titulo: rgb("#002D62"), acento: rgb("#D9480F")),
  ).at(tema)

  // 2. Configuración de página
  set page(
    paper: "presentation-" + aspect-ratio,
    fill: paleta.fondo,
    margin: (x: 2cm, y: 1.5cm),
  )

  // 3. Configuración de texto y reglas
  set text(font: "DejaVu Sans", fill: paleta.texto, size: 24pt, lang: "es")

  // Títulos de diapositivas (Nivel 2) con salto de página
  show heading.where(level: 2): it => {
    pagebreak(weak: true)
    set text(fill: paleta.titulo, size: 28pt)
    it.body
    v(-0.3em)
    line(length: 100%, stroke: 2pt + paleta.acento)
    v(0.5em)
  }

  // Títulos de sección (Nivel 1) para separadores
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set align(center + horizon)
    set text(fill: paleta.titulo, size: 36pt)
    it.body
    v(0.2em)
    line(length: 80%, stroke: 3pt + paleta.acento)
  }

  // 4. Portada (Slide de título)
  if titulo != none {
    align(center + horizon)[
      #text(fill: paleta.titulo, size: 40pt, weight: "bold", titulo)
      #if subtitulo != none {
        v(0.5em)
        text(fill: paleta.acento, size: 26pt, subtitulo)
      }
      #v(2em)
      #if autor != none { text(size: 20pt, autor) }
    ]
  }

  body
}

// --- COMPONENTES PARA EL USUARIO (Exportados) ---

#let formula_box(tema, body) = {
  let color_acento = if tema == "oscuro" { rgb("#00B4D8") } else if tema == "gris" { rgb("#0077B6") } else { rgb("#D9480F") }
  align(center, block(
    fill: color_acento.lighten(92%),
    stroke: (left: 6pt + color_acento),
    inset: 1.2em, radius: 4pt, width: 95%,
    text(fill: black, body)
  ))
}

#let diagrama_box(tema, txt) = {
  let color_acento = if tema == "oscuro" { rgb("#00B4D8") } else if tema == "gris" { rgb("#0077B6") } else { rgb("#D9480F") }
  rect(fill: color_acento, stroke: 1pt + black, radius: 5pt, inset: 10pt, text(fill: white, weight: "bold", txt))
}