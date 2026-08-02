#let screenshot-placeholder(description, file-name) = {
  align(center)[
    #rect(width: 90%, height: 60pt, fill: luma(240), radius: 4pt, stroke: 1pt + luma(150))[
      #align(center + horizon)[
        *Screenshot richiesto*: #description \
        Salvare in: `assets/#file-name`
      ]
    ]
    #text(style: "italic", size: 9pt)[Figura: #description]
  ]
}
