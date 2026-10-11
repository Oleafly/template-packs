
#let theme-color = state("theme-color", none)
#let lightgreen = rgb("6AA84F")
#let darkred = rgb("980000")
#let darkblue = rgb("0C343D")
#let lightgray = rgb("999999")

#let _theme-colors = (
  bluey: rgb("3059AB"),
  reddy: rgb("980000"),
  greeny: rgb("6AA84F"),
  dusky: rgb("1F4289"),
  darky: black,
)

//************************************************************************\\

#let _resize-text(body) = layout(size => {
  let font-size = text.size
  let (height,) = measure(
    block(width: size.width, text(size: font-size)[#body]),
  )

  let max_height = size.height

  while height > max_height {
    font-size -= 0.2pt
    height = measure(
      block(width: size.width, text(size: font-size)[#body]),
    ).height
  }

  block(
    height: height,
    width: 100%,
    text(size: font-size)[#body],
  )
})

//************************************************************************\\

#let _divider(color: none) = {
  let color = if color == none {lightgreen} else {color}
  block(
    width: 100%,
    inset: (left: -2.5cm, right: -2.5cm), // Extend beyond page margins
    line(
      length: 100%,
      stroke: 5pt + color
    )
  )
}

//************************************************************************\\

#let _slide-header(title) = {
  if title != none {
    block(
      width: 100%,
      height: 2.5cm,
      fill: white, // Transparent background for the title block (no fill, just text)
      inset: 10pt,
      text(rgb("980000"), weight: "bold", size: 24pt, align(center)[#title]) // Centered red title
    )
  } else {
    [] // No header if title is none
  }
}

//************************************************************************\\

#let _make-frontpage(
  title,
  subtitle,
  authors,
  info,
  theme,
) = {

  let theme-color = (if theme in _theme-colors { _theme-colors.at(theme) } else {lightgreen})

  set align(start + top)
  set page(      
    footer: {
    set align(right)
    set text(fill: lightgray, size: 12pt, weight: "bold")  // Adjust color and size as needed
    place(
      bottom + right,
      dx: 30pt,  // Small offset from right edge
      dy: -20pt,  // Small offset from bottom edge
      [#text(weight: "bold")[MeDA] #counter(page).display("1")]  // Displays page number
    )
  })
  v(4.5cm)
  // Title (large, bold)
  text(35pt, weight: "bold")[#title]

  v(-.95cm)

  // Subtitle
  let _subtitle = []
  if subtitle != none {
    _subtitle += text(20pt, weight: "regular")[#subtitle]
  }

  // Author and info content
  let subtext = []
  if authors != none {
    subtext += (text(14pt, weight: "bold")[#authors])
  }
  if info != none {
    subtext += (text(11pt, weight: "regular", fill: rgb("434343"))[#v(-.25cm) #info])
  }

  // Divider
  _divider(color: theme-color)

  v(-.5cm)

  // Subtitle
  [#_subtitle]

  v(.1cm)

  // Place a grid containing subtext and logo side by side at the specified position
  place(
    dx: 12cm, // Horizontal offset from left
    dy: 2.5cm,  // Vertical offset from top
    grid(
      columns: (auto, auto), // Two columns: one for text, one for logo
      gutter: 2cm, // Space between text and logo
      align(left + horizon)[#subtext],
      align(right + horizon)[ // Right-align the logo
        #figure(
          grid(
            columns: 2,
            gutter: 2mm,
            image("NTU.jpeg", width: 1cm),
            image("MeDA.png", width: 4cm), 
          )
        )
      ]
    )
  )
}