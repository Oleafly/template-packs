#let template(fontsize: 11pt,
              fonttype: "Fira Sans",
              doc
) = {
  set page(
    paper: "a4",
    margin: (left: 2.5cm, right: 2.5cm, top: 2cm, bottom: 3cm),
    number-align: center,
    numbering: "1",
    footer: context [
      #counter(page).display("1/1", both: true)
    ]
  )
  set par(justify: true)
  set text(font: fonttype, size: fontsize, weight: "light")
  show heading.where(level: 1): it => block(width: 100%)[
    #grid(
      columns: (0.35fr, 1fr),
      gutter: 15pt,
      [#align(horizon, line(length: 100%, stroke: 4pt + white.lighten(10%)))],
      [
        #set align(left)
        #set text(14pt, weight: "regular", fill: eastern.lighten(10%))
        #smallcaps(it.body)
      ]
    )
    #v(10pt)
  ]
  columns(1, doc)
}

#let iconbox(field: none, icon: none, sep: none) = {
  box(height: 10pt, image(icon), baseline: 20%) + " " + field + sep
}

#let headerblock(foto: none,
                 firstname: none,
                 lastname: none,
                 address: none,
                 phone: (field: none, icon: none),
                 email: (field: none, icon: none),
                 github: (field: none, icon: none),
                 orcid: (field: none, icon: none),
                 linkedin: none
) = {
  v(-40pt)
  block(
    fill: gradient.linear(eastern.lighten(20%), olive.lighten(60%)),
    outset: (x: 100pt, y: 20pt),
    [
      #grid(
        columns: (0.35fr, 1.2fr),
        // First column
        align(left + top)[
          #box(image(foto, width: 100%), radius: 100%, clip: true)
        ],
        // Second column
        [
          #align(right + horizon)[
            #text(size: 42pt, fill: white, weight: 300)[#firstname ]
            #text(size: 42pt, fill: white, weight: 400)[#lastname]\
            #v(6pt)
            #text(size: 10pt, fill: white, weight: 400)[#address]\
            #text(size: 10pt, fill: white, weight: 400)[
              #iconbox(
                field: phone.field,
                icon: phone.icon,
                sep: " | "
              )
            ]
            #text(size: 10pt, fill: white, weight: 400)[
              #iconbox(
                field: email.field,
                icon: email.icon,
              )
            ]
            #text(size: 10pt, fill: white, weight: 400)[
              #iconbox(
                field: github.field,
                icon: github.icon,
                sep: " | "
              )
            ]\
            #text(size: 10pt, fill: white, weight: 400)[
               #iconbox(
                field: orcid.field,
                icon: orcid.icon
              )
            ]
          ]
        ]
      )
    ]
  )
  v(22pt)
}

#let cventry(year: "",
             title: "",
             institution: "",
             city: "",
             country: "",
             optional: none,
             description: none,
             descriptionlabel: "Description"
) = {
  grid(
    columns: (0.35fr, 1fr),
    gutter: 15pt,
    align(right + top)[#year],
    align(left + bottom)[
      #text(title, weight: "regular"),
      #text(institution, style: "italic"),
      #city,
      #if (optional != none) {
        [#country, ]
        [#optional]
      } else {
        [#country#linebreak()]
      }
      #if (description != none) {
        [#text([#descriptionlabel: ], size: 10pt, style: "italic") #text(description, size: 10pt)]
      }
    ]
  )
}

#let cvitem(key: "",
            value: "",
) = {
  grid(
    columns: (0.35fr, 1fr),
    gutter: 15pt,
    align(right + top)[#key],
    align(left + bottom)[#value]
  )
}