// ============================================================================
// PLANTILLA DE DOCUMENTOS EMEORG
// ============================================================================


// ----------------------------------------------------------------------------
// PALETA
// ----------------------------------------------------------------------------

#let ink        = luma(0)   // Texto
#let gray-dark  = luma(80)  // Subtítulos
#let gray-mid   = luma(120) // Metadatos
#let gray-light = luma(200) // Divisores


// ----------------------------------------------------------------------------
// ETIQUETA
// ----------------------------------------------------------------------------

#let eme-badge(content) = box(
  fill: ink,
  inset: (
    x: 10pt,
    y: 5pt,
  ),
  radius: 2pt,
)[
  #text(
    size: 8.5pt,
    weight: "bold",
    fill: white,
  )[
    #content
  ]
]


// ----------------------------------------------------------------------------
// ESTADO
// ----------------------------------------------------------------------------

#let show-guidance-state = state("emeorg-show-guidance", true)


// ----------------------------------------------------------------------------
// INSTRUCCIONES
// ----------------------------------------------------------------------------

#let guidance(content) = context {
  if show-guidance-state.get() {
    text(
      size: 9pt,
      fill: gray-mid,
      style: "italic",
    )[
      #content
    ]
  }
}


// ----------------------------------------------------------------------------
// ANOTACIONES
// ----------------------------------------------------------------------------

#let eme-note(title: "Nota", content) = block(
  width: 100%,
  above: 0.8em,
  below: 0.8em,
  inset: (x: 12pt, y: 10pt),
  stroke: (left: 2.5pt + ink),
  fill: luma(248),
)[
  #text(size: 9pt, weight: "semibold", fill: ink)[#title]
  #v(4pt)
  #text(size: 9.5pt, weight: "regular", fill: gray-dark)[#content]
]


// ----------------------------------------------------------------------------
// CONTADOR DE SECCIONES
// ----------------------------------------------------------------------------

#let section-counter = counter("emeorg-section")


// ----------------------------------------------------------------------------
// AUTORES
// ----------------------------------------------------------------------------

#let format-authors(authors) = {
  if authors.len() == 0 {
    ""
  } else if authors.len() == 1 {
    authors.at(0)
  } else if authors.len() == 2 {
    authors.at(0) + " & " + authors.at(1)
  } else {
    let first = authors.slice(0, authors.len() - 1).join(", ")
    let last = authors.at(authors.len() - 1)

    first + " & " + last
  }
}


// ----------------------------------------------------------------------------
// DOCUMENTO
// ----------------------------------------------------------------------------

#let unnumbered-h1(body) = heading(level: 1, numbering: none, body)

#let eme-doc(
  kind: "Documento",
  title: "Sin título",
  question: none,
  authors: (),
  date: "—",
  justify: true,
  toc: false,
  show-guidance: true,
  body,
) = {

  section-counter.update(0)
  show-guidance-state.update(show-guidance)


  // ==========================================================================
  // PÁGINA
  // ==========================================================================

  set page(
    paper: "a4",

    margin: (
      top: 24mm,
      bottom: 24mm,
      left: 24mm,
      right: 24mm,
    ),

    // Encabezado
    header: context {
      let current = counter(page).get().first()

      if current > 1 [
        #block(below: 8pt)[
          #grid(
            columns: (1fr, auto),
            column-gutter: 1em,

            [
              #text(
                size: 8.5pt,
                weight: "medium",
                fill: gray-dark,
              )[
                #title
              ]
            ],

            [
              #align(right)[
                #text(
                  size: 8.5pt,
                  weight: "regular",
                  fill: gray-mid,
                )[
                  #kind
                ]
              ]
            ],
          )
        ]

        #line(
          length: 100%,
          stroke: 0.5pt + gray-light,
        )
      ]
    },

    // Pie de página
    footer: context {
      let current = counter(page).get().first()

      if current > 1 [
        #block(below: 7pt)[
          #line(
            length: 100%,
            stroke: 0.5pt + gray-light,
          )
        ]

        #align(center)[
          #text(
            size: 8pt,
            weight: "medium",
            fill: gray-mid,
          )[
            #counter(page).display(
              "1 / 1",
              both: true,
            )
          ]
        ]
      ]
    },
  )


  // ==========================================================================
  // TIPOGRAFÍA
  // ==========================================================================

  set text(
    font: "Inter",
    size: 10.5pt,
    weight: "regular",
    lang: "es",
    fill: ink,
    hyphenate: justify,
  )

  set par(
    justify: justify,
    leading: 0.68em,
    spacing: 1em,
  )

  set list(
    indent: 0.4em,
    body-indent: 0.5em,
    spacing: 0.65em,
  )

  set enum(
    indent: 0.4em,
    body-indent: 0.5em,
    spacing: 0.65em,
  )


  // ==========================================================================
  // TÍTULOS
  // ==========================================================================

  set heading(
    numbering: "1.",
  )

  // H1
  show heading.where(level: 1): it => {
    if it.numbering == none {
      block(
        above: 2.2em,
        below: 0.9em,
      )[
        #text(
          size: 20pt,
          weight: "bold",
          tracking: -0.02em,
          fill: ink,
        )[
          #it.body
        ]
      ]
    } else {
      section-counter.step()

      block(
        above: 2.2em,
        below: 0.9em,
      )[
        #grid(
          rows: (
            auto,
            auto,
          ),
          row-gutter: 6pt,

          [
            #eme-badge[
              SECCIÓN #context section-counter.display("1")
            ]
          ],

          [
            #text(
              size: 20pt,
              weight: "bold",
              tracking: -0.02em,
              fill: ink,
            )[
              #it.body
            ]
          ],
        )
      ]
    }
  }

  // H2
  show heading.where(level: 2): it => {
    block(
      above: 1.7em,
      below: 0.6em,
    )[
      #text(
        size: 13.5pt,
        weight: "semibold",
        tracking: -0.01em,
        fill: ink,
      )[
        #it.body
      ]
    ]
  }

  // H3
  show heading.where(level: 3): it => {
    block(
      above: 1.2em,
      below: 0.5em,
    )[
      #text(
        size: 11.5pt,
        weight: "medium",
        fill: gray-dark,
      )[
        #it.body
      ]
    ]
  }


  // ==========================================================================
  // TABLAS
  // ==========================================================================

  set table(
    inset: (
      x: 10pt,
      y: 7pt,
    ),

    align: left,

    stroke: (x, y) => if y == 0 {
      (
        bottom: 0.5pt + ink,
      )
    } else {
      none
    },
  )

  // Encabezado
  show table.cell.where(y: 0): set text(
    size: 8.5pt,
    weight: "semibold",
    fill: ink,
  )

  // Líneas superior e inferior
  show table: it => {
    block(
      above: 0.8em,
      below: 0.8em,
    )[
      #context {
        let size = measure(it)

        stack(
          spacing: 0pt,

          line(
            length: size.width,
            stroke: 0.8pt + ink,
          ),

          it,

          line(
            length: size.width,
            stroke: 0.8pt + ink,
          ),
        )
      }
    ]
  }


  // ==========================================================================
  // FIGURAS
  // ==========================================================================

  set figure(
    numbering: "1",
  )

  show figure.where(kind: image): set figure(
    supplement: "Figura",
  )

  show figure.where(kind: table): set figure(
    supplement: "Tabla",
  )

  show figure: set align(center)

  show figure: it => {
    block(
      above: 2em,
      below: 2em,
    )[
      #it
    ]
  }

  // Pie de figura
  show figure.caption: it => {
    block(
      above: 10pt,
    )[
      #text(
        size: 8.5pt,
        weight: "semibold",
        fill: ink,
      )[
        #it.supplement
        #context it.counter.display(it.numbering)
      ]

      #text(
        size: 8.5pt,
        weight: "regular",
        fill: gray-mid,
      )[
        #it.separator#it.body
      ]
    ]
  }


  // ==========================================================================
  // REFERENCIAS
  // ==========================================================================

  show ref: it => {
    if it.element != none and (it.element.func() == figure) [
      #text(
        weight: "semibold",
        fill: ink,
      )[
        #it
      ]
    ] else [
      #it
    ]
  }


  // ==========================================================================
  // ÉNFASIS Y ENLACES
  // ==========================================================================

  show strong: set text(
    weight: "bold",
    fill: ink,
  )

  show link: set text(
    weight: "medium",
    fill: ink,
  )

  show link: underline


  // ==========================================================================
  // PORTADA
  // ==========================================================================

  {
    set par(justify: false)
    grid(
      columns: (1fr,),
      rows: (
        auto,
        1fr,
        auto,
      ),

      // Logo
      [
        #image(
          "assets/logo.svg",
          width: 30mm,
        )
      ],

      // Identidad del documento
      [
        #grid(
          columns: (1fr,),
          rows: (
            1fr,
            auto,
            5fr,
          ),

          [],

          [
            #grid(
              columns: (1fr,),
              rows: (
                auto,
                auto,
                auto,
              ),
              row-gutter: 0.8em,

              // Tipo
              [
                #eme-badge[
                  #upper(kind)
                ]
              ],

              // Título
              [
                #set text(hyphenate: false)
                #set par(leading: 0.5em)

                #text(
                  size: 40pt,
                  weight: "bold",
                  fill: ink,
                )[
                  #title
                ]
              ],

              // Pregunta
              [
                #if question != none [
                  #text(
                    size: 13pt,
                    weight: "medium",
                    fill: gray-dark,
                  )[
                    #question
                  ]
                ]
              ],
            )
          ],

          [],
        )
      ],

      // Autores y fecha
      [
        #grid(
          columns: (1fr,),
          rows: (
            auto,
            auto,
          ),
          row-gutter: 0.8em,

          [
            #line(
              length: 100%,
              stroke: 0.75pt + ink,
            )
          ],

          [
            #grid(
              columns: (
                1fr,
                auto,
              ),
              column-gutter: 2em,

              [
                #text(
                  size: 8.5pt,
                  weight: "medium",
                  fill: gray-dark,
                )[
                  #format-authors(authors)
                ]
              ],

              [
                #align(right)[
                  #text(
                    size: 8.5pt,
                    weight: "regular",
                    fill: gray-mid,
                  )[
                    #date
                  ]
                ]
              ],
            )
          ],
        )
      ],
    )
  }


  // ==========================================================================
  // CONTENIDO
  // ==========================================================================

  pagebreak()

  if toc {
    unnumbered-h1[Contenido]

    outline(
      title: none,
      indent: 1.2em,
    )

    pagebreak()
  }

  body
}