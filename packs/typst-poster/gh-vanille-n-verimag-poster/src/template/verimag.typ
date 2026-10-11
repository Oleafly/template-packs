#let palette = {
  let base = (
    // Primary colors of Verimag
    red: (
      xdk: rgb("8B1A10"),
      dk: rgb("E13B21"), // from the logo
      mid: rgb("ED8A7B"),
      lt: rgb("F8CDC7"), // from the website
      xlt: rgb("FCEBE8"), // from the website
    ),
    blue: (
      xdk: rgb("003454"), // from the website
      dk: rgb("1E5C85"),
      mid: rgb("BBCFE2"),
      lt: rgb("E6EDF4"), // from the logo
      xlt: rgb("F4F8FB"),
    ),
    gray: (
      xdk: rgb("45464A"), // from the website
      dk: rgb("6C6C70"),
      mid: rgb("B3B2B2"), // from the website
      lt: rgb("D9D9D9"),
      xlt: rgb("ECECEC"), // from the website
    ),
    // Auxiliary colors
    yellow: (
      xdk: rgb("A29134"),
      dk: rgb("C9B84D"),
      mid: rgb("FFFD82"),
      lt: rgb("FFFBC2"),
      xlt: rgb("FFFDE8"),
    ),
    green: (
      xdk: rgb("234B3A"),
      dk: rgb("3E6E59"),
      mid: rgb("66A182"),
      lt: rgb("A7C8B5"),
      xlt: rgb("DDEBE2"),
    ),
    purple: (
      xdk: rgb("632C45"),
      dk: rgb("A3627C"),
      mid: rgb("EEABC4"),
      lt: rgb("F6D6E1"),
      xlt: rgb("FAEEF3"),
    ),
    brown: (
      xdk: rgb("4C3627"),
      dk: rgb("694A38"),
      mid: rgb("9E7B66"),
      lt: rgb("C7A593"),
      xlt: rgb("E8D7CB"),
    ),
  )
  (
    :
    //primary: base.red,
    //secondary: base.blue,
    //filler: base.gray,
    //auxiliary: (base.yellow, base.green, base.purple),
    ..base,
  )
}

#let build-page(..params) = doc => {
  let params = params.named()
  let flipped = {
    let orientation = params.dimensions.orientation
    if not (orientation in ("portrait", "landscape")) {
      panic("orientation should be either 'portrait' or 'landscape', not '" + orientation + "'")
    }
    orientation == "landscape"
  }

  let palette = params.palette

  let logos = table(
    align: center + horizon,
    columns: (30%, 25%, 25%),
    stroke: none,
    inset: 1cm,
    image("/assets/logos/uga.svg"),
    image("/assets/logos/cnrs.svg"),
    image("/assets/logos/inp.svg"),
  )

  let header = {
    rect(
      width: 100%,
      height: 100%,
      fill: palette.header,
      {
        show: align.with(center + horizon)
        set text(
          size: params.font.size.title * params.font.size.base,
          fill: palette.title,
        )
        place(top + left, {
          box(inset: 2cm, {
            image("/assets/logos/verimag.svg", height: 100%)
          })
        })
        place(bottom + right, {
          box(inset: 2cm, {
            set text(
              size: params.font.size.authors * params.font.size.base,
            )
            for author in params.authors {
              [#author\ ]
            }
          })
        })
        params.title
      }
    )
  }

  let footer = {
    rect(
      width: 100%,
      height: 100%,
      fill: palette.footer,
      {
        grid(columns: (1fr, 1%, 1fr), align: (right, center, left),
          box(inset: 1cm, {
            params.footnote
          }),
          line(end: (0pt, 100%), stroke: palette.border),
          logos,
        )
      },
    )
  }

  set text(
    size: params.font.size.body * params.font.size.base,
    font: params.font.family,
  )

  set page(
    paper: "a0",
    flipped: flipped,
    header: header,
    header-ascent: 0pt,
    footer: footer,
    footer-descent: 0pt,
    margin: (
      x: 0pt,
      bottom: params.dimensions.footer,
      top: params.dimensions.header,
    ),
  )
  box(
    height: 100%,
    fill: palette.body,
    stroke: (right: none, left: none, rest: palette.border + 5pt),
    inset: params.dimensions.margin,
    doc,
  )
}

