#import "utils.typ": *

#let font = "Arial"
#let theme-color = state("theme-color", none)
#let sections = state("sections", ())
#let darkred = rgb("980000")
#let darkblue = rgb("0C343D")
#let lightgray = rgb("999999")

#let typslides(
  ratio: "16-9",
  theme: "bluey",
  body,
) = {
  theme-color.update(_theme-colors.at(theme))

  set text(font: font)

  set page(paper: "presentation-" + ratio, fill: white, margin: (top: 1in, bottom: 0.3in))


  show ref: it => (
    context {
      text(fill: theme-color.get())[#it]
    }
  )

  show link: it => (
    context {
      text(fill: theme-color.get())[#it]
    }
  )

  set footnote.entry(indent: 0em)
  show footnote.entry: set text(size: 10pt)

  show footnote: it => (
    context {
      text(fill: black)[#it]
    }
  )

  set enum(numbering: (it => context text(fill: black)[*#it.*]))

  body
}

//*************************************** Aux functions ***************************************\\

#let stress(body) = (
  context {
    text(fill: theme-color.get(), weight: "semibold")[#body]
  }
)

#let bluey(body) = (text(fill: rgb("3059AB"))[#body])
#let greeny(body) = (text(fill: rgb("6AA84F"))[#body])
#let reddy(body) = (text(fill: rgb("980000"))[#body])
#let dusky(body) = (text(fill: rgb("1F4289"))[#body])

//***************************************************\\

#let framed(
  title: none,
  back-color: none,
  content,
) = (
  context {
    let w = auto

    set block(
      inset: (x: .6cm, y: .6cm),
      breakable: false,
      above: .1cm,
      below: .1cm,
    )

    if title != none {
      set block(width: 100%)
      stack(
        block(
          fill: theme-color.get(),
          inset: (x: .6cm, y: .55cm),
          radius: (top: .2cm, bottom: 0cm),
          stroke: 1.5pt,
        )[
          #text(weight: "semibold", fill: white)[#title]
        ],
        block(
          fill: {
            if back-color != none {
              back-color
            } else {
              white
            }
          },
          radius: (top: 0cm, bottom: .2cm),
          stroke: 1.5pt,
          content,
        ),
      )
    } else {
      stack(
        block(
          width: auto,
          fill: if back-color != none {
            back-color
          } else {
            white
          },
          radius: (top: .2cm, bottom: .2cm),
          stroke: 1.5pt,
          content,
        ),
      )
    }
  }
)

//**************************************** Front Slide ****************************************\\

#let front-slide(
  title: none,
  subtitle: none,
  authors: none,
  info: none,
  theme: "none"
) = (
  context {
    _make-frontpage(
      title,
      subtitle,
      authors,
      info,
      theme,
    )
  }
)

//**************************************** Title Slide ****************************************\\

#let title-slide(
  text-color: white,
  text-size: 36pt,
  body,
) = (
  context {
    set page(
      fill: darkblue,
      footer: {
        set align(right)
        set text(fill: lightgray, size: 12pt, weight: "bold")  // Adjust color and size as needed
        place(
          bottom + right,
          dx: 30pt,  // Small offset from right edge
          dy: -20pt,  // Small offset from bottom edge
          [#text(weight: "bold")[MeDA] #counter(page).display("1")]  // Displays page number
        )
      }
    )

    // Create a two-tone background
    place(
      top + left,
      rect(
        width: 100% + 2 * 1in,  // Extends beyond page width by margin amount
        height: 50% + 0.5in,      // Extends height to account for top margin
        fill: white,
        inset: 0pt,              // No internal padding
        outset: 0pt              // No external padding
      ),
      dx: -1in,  // Offset to align with left edge
      dy: -1in   // Offset to align with top edge
    )

    set text(
      weight: "semibold",
      size: text-size,
      fill: darkblue,
      font: font,
    )

    // Position text in the middle of the upper half
    set align(center)
    v(5%)  // Move to center of upper half (25% from top = middle of upper 50%)
    _resize-text(body)
  }
)

//*********************************** End of Title Slide ****************************************\\

#let end-slide(
  text-color: white,
  text-size: 40pt,
  body,
) = (
  context {
    set page(
      fill: darkblue,
      footer: {
        set align(right)
        set text(fill: lightgray, size: 12pt, weight: "bold")  // Adjust color and size as needed
        place(
          bottom + right,
          dx: 30pt,  // Small offset from right edge
          dy: -20pt,  // Small offset from bottom edge
          [#text(weight: "bold")[MeDA] #counter(page).display("1")]  // Displays page number
        )
      }
    )

    set text(
      weight: "semibold",
      size: text-size,
      fill: text-color,
      font: font,
    )

    set align(center + horizon)

    _resize-text(body)
  }
)

//****************************************** Slide ********************************************\\

#let slide(
  title: none,
  back-color: white,
  body,
) = (
  context {
    set page(
      fill: back-color,
      footer: {
        set align(right)
        set text(fill: lightgray, size: 12pt, weight: "bold")  // Adjust color and size as needed
        place(
          bottom + right,
          dx: 30pt,  // Small offset from right edge
          dy: -20pt,  // Small offset from bottom edge
          [#text(weight: "bold")[MeDA] #counter(page).display("1")]  // Displays page number
        )
      },
      background: place(
        _slide-header(title),
      ),
    )

    set list(
      marker: (
        text(black, [•]),    // Level 1: black dot
        text(black, [◦]),    // Level 2: white dot (open circle)
        text(black, [▪]),    // Level 3: square
      )
    )

    set enum(numbering: (it => context text(fill: black)[*#it.*]))

    set text(size: 16pt)
    set par(justify: true, leading:1em)
    set align(start + top)

    v(0cm) // avoids header breaking if body is empty
    body
  }
)

//**************************************** Blank slide ****************************************\\

#let blank-slide(body) = (
  context {
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
      }
    )

    set list(
      marker: (
        text(black, [•]),    // Level 1: black dot
        text(black, [◦]),    // Level 2: white dot (open circle)
        text(black, [▪]),    // Level 3: square
      )
    )

    set enum(numbering: (it => context text(fill: black)[*#it.*]))

    set text(size: 16pt)
    set par(justify: true, leading: 1em)
    set align(start + top)
    body
  }
)

//**************************************** Bibliography ***************************************\\

#let bibliography-slide(
  bib-call,
  title: "References",
) = (
  context {
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
      },
      background: place(
        _slide-header(title),
      ),
    )
    set text(size: 14pt)
    set par(justify: true, leading: 1em)
    set align(start + top)

    set bibliography(
      title: none,
    )

    v(0cm) // avoids header breaking if body is empty
    bib-call
  }
)