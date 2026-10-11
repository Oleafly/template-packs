#set page("a0", margin: 4mm)
#set text(lang: "en", font: "Marianne")

#let france2030red = rgb(191, 18, 56)
#let france2030blue = rgb("#010093")

#let footer() = {
  align(
    center,
    grid(
      columns: (auto, auto, auto, auto, auto),
      column-gutter: 200pt,
      rows: 110pt,
      [#image("img/logo/Logotype-rouge-bleu.png")],
      [#image("img/logo/ANR-logo-2021-complet.jpg")],
      [#image("img/logo/LOGO CEA_ORIGINAL.png")],
      [#image("img/logo/LOGO_CNRS_2019_BLEU.png")],
      [#image("img/logo/Inria_logo_rouge.png")],
    ),
  )
}

#let header(title, projet, author: [], right-block: []) = {
  let logo-block = rect(
    width: 500pt,
    height: 100%,
    fill: white,
    align(center)[
      #image("img/logo/FR2030_Cybersecurite_Couleur.png", width: 60%)
      #set text(fill: france2030blue)
      #v(-20pt) // Reduce vertical space between image and project name
      #text(40pt)[*#projet* \ ]
    ],
  )
  let author-block = rect(width: 100%, height: 100%, fill: white)[
    #set align(right)
    #set text(32pt)
    #author
  ]

  grid(
    columns: (30%, 1fr),
    rows: 230pt,
    logo-block, author-block,
  )

  rect(width: 100%, height: 100pt, stroke: none)[
    #set align(center)
    #set text(fill: france2030blue)
    #text(70pt)[*#title* \ ]
  ]
}

#show heading.where(level: 1): it => [#box(
    width: 100%,
    fill: luma(92%),
    inset: 16pt,
  )[
    #set text(
      fill: france2030red,
      bottom-edge: "descender",
      size: 40pt,
      weight: "regular",
    )
    #set align(center + horizon)
    #it
  ]]

#show heading.where(level: 2): it => [#box(
    width: 100%,
    inset: 20pt,
  )[
    #set text(
      fill: france2030blue,
      bottom-edge: "descender",
      size: 40pt,
      weight: "regular",
    )
    #set align(center + horizon)
    #it
  ]]

#set par(leading: .5em)
#set list(
  marker: (
    box(text(france2030red, sym.triangle.filled.small.r)),
    box(text(france2030red, sym.square.filled.tiny)),
  ),
)
#show terms.item: t => [- #text(france2030red, [#t.term#h(.15em, weak: true):]) #t.description]

#let note(content) = {
  text(blue, box[#content])
}
#let redtext(content) = {
  text(france2030red, box[#content])
}

#let eqcolumns(n, gutter: 4%, content) = {
  set text(20pt)
  layout(size => [
    #let (height,) = measure(block(width: (1 / n) * size.width * (1 - float(gutter) * n), content))
    #block(height: height / n, columns(n, gutter: gutter, content))
  ])
}

//////////////////////////////
#let authors = [
  #set align(center + horizon)
  #set text(weight: "light")
  #table(
    columns: 1,
    stroke: none,
    column-gutter: 20pt,
    row-gutter: 15pt,
    [Firstname Lastname¹, Firstname Lastname², Firstname Lastname³],
    [Firstname Lastname¹, Firstname Lastname², Firstname Lastname³],
    [¹: Affiliation, ²: Affiliation, ³: Affiliation],
  )
]

#show figure.caption: it => [
  #set text(24pt)
  #it.body
]

#header("Title", "PEPR project", author: authors, right-block: [])

#align(
  center,
  block(width: 100% - 30pt)[
    #set text(32pt)
    #set align(left)
    #set par(justify: true)
    #box[#grid(
        columns: (49.5%, 49.5%),
        gutter: 1%,
        stroke: (paint: france2030red, thickness: 2pt),
        [
          == Subsection
          Some text with a figure and a reference @TypstDocumentation.
          #figure(
            image("img/sphx_glr_bar_colors_001.png", width: 50%),
            caption: [You can use citations in captions too @TypstDocumentation],
          )

        ],
        [
          == Subsection
          #figure(
            image("img/sphx_glr_fill_002.png", width: 90%),
            caption: [Two semantically equivalent SQL attacks.],
          )
          #h(10pt)
          #box(
            width: 95%,
            [
              Objectives:
              #list(
                spacing: 25pt,
                [
                  #lorem(10)
                ],
                [ #lorem(10) ],
              )
            ],
          )
          // For nice red boxes that fits to text or caption figure, we use this hack of manally adding vertical space.
          #v(20pt)
        ],
      )

    ]#box[#grid(
        columns: (49.5%, 49.5%),
        gutter: 1%,
        stroke: france2030red + 2pt,
        inset: 10pt,
        [
          == Subsection
          #box(inset: (left: 30pt, right: 40pt))[
            #lorem(50)
          ]
        ],
        [
          == Subsection
          #grid(
            columns: (52%, 45%),
            inset: 10pt,
            [
              #box(
                inset: (top: 70pt, left: 50pt),
                [
                  #list(
                    spacing: 25pt,
                    [
                      First item
                    ],
                    [
                      Second item
                    ],
                    [
                      Third item
                    ],
                  )
                ],
              )
            ],
            [
              #figure(
                image("img/sphx_glr_bar_colors_001.png", height: 8%),
                caption: [Yet the same figure.],
              )
            ],
          )
        ],
      )]
    #box[
      #grid(
        columns: (49.5%, 49.5%),
        gutter: 1%,
        stroke: france2030red + 2pt,
        [
          == Subsection side by side text and figure
          #grid(
            columns: (50%, 50%),
            [
              #box(
                inset: (right: 10pt, top: 100pt),
                [
                  #list(spacing: 20pt, [First item], [Second item], [Third item])
                ],
              )
            ],
            [
              #figure(
                image("img/sphx_glr_bar_colors_001.png", height: 11%),
                caption: [Another caption],
              )
              // For nice red boxes that fits to text or caption figure, we use this hack of manally adding vertical space.
              #v(20pt)
            ],
          )

        ],
        [
          == Subsection
          #block(inset: (left: 20pt, right: 40pt))[
            #lorem(30)
          ]

        ],
      )
    ]#box[#grid(
        columns: (49.5%, 49.5%),
        gutter: 1%,
        inset: 10pt,
        stroke: france2030red + 2pt,
        [
          == Subsection, a figure under text
          #box(inset: 10pt)[
            #lorem(10)
          ]

          #figure(
            image("img/sphx_glr_bar_colors_001.png", height: 12%),
            caption: [A caption],
          )
        ],
        [
          == Subsection with table
          #box(
            width: 100%,
            [
              #h(10pt)
              #list(
                spacing: 30pt,
                [First item on a list],
                [Second item on a list],
                [Third item on a list],
              )
            ],
          )

          #set align(center)
          #set text(28pt)
          #figure(
            table(
              stroke: (_, y) => (x: 0pt, top: if y <= 1 { 1pt }, bottom: if y == 5 { 1pt }),
              columns: 6,
              row-gutter: 5pt,
              align: center,
              [Column1], [Column2], [Column3], [Column4], [Column5], [Column6],
              [1], [2], [3], [4], [5], [6],
              [7], [8], [9], [10], [11], [12],
              [13], [14], [15], [16], [17], [18],
              [19], [20], [21], [22], [23], [24],
              [25], [26], [27], [28], [29], [30],
            ),
            caption: [Dummy Table Description.],
          )
        ],
      )]#box[#grid(
        columns: (49%, 49%),
        gutter: 1%,
        [
          == Future work
          #list(
            spacing: 30pt,
            [
              First item
            ],
            [
              Second item
            ],
            [
              Third item
            ],
          )
        ],
        [
          == Bibliography

          #set par(justify: true)
          #eqcolumns(2)[
            #bibliography("bib.bib", title: none, style: "ieee")
          ]
        ],
      )]
  ],
)

#v(1fr)
#footer()
