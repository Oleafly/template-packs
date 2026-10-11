#import "/components/Link.typ": Link, LinkEmpty
#import "/components/Smallcaps.typ": Smallcaps
#import "./AuthorLinks.typ": AuthorLinks
#import "@preview/fontawesome:0.5.0": *

#let GetDebugOpts(debug: false) = {
  return (
    stroke: if debug { black } else { none },
  )
}

#let Resume(
  author: (
    name: "John Smith",
    github: none,
    linkedin: none,
    email: none,
    phone: none,
    location: none,
  ),
  content: (
    preamble: none,
    core: none,
    side: none,
    postamble: none,
  ),
  debug: true,
) = {
  let D = if type(debug) == bool {
    GetDebugOpts(debug: debug)
  } else { debug }

  /**
   * User config
   */
  let title = (
    weight: "extrabold",
    size: 18pt,
    tracking: 0.1em,
  )

  let h1 = (
    weight: "bold",
    fill: if debug { blue } else { black },
    size: 12pt,
    tracking: 0.1em,
  )

  let h2 = (
    weight: "regular",
    fill: if debug { red } else { black },
    size: 10pt,
  )

  let h3 = (
    style: "italic",
    weight: "regular",
    fill: if debug { green } else { black },
    size: 10pt,
  )

  let h4 = (
    weight: "regular",
    fill: if debug { orange } else { black },
    size: 10pt,
  )

  let p = (
    weight: "light",
    font: ("Open Sans", "Tahoma", "Helvetica"),
    size: 10pt,
  )

  let grid-gutter = 1.5em

  let profile-size = .75in
  let profile-path = "/data/profile.jpg"

  /**
   * Settings
   */
  set page(margin: (x: 0.5in, y: 0.5in))

  set text(..p)

  show heading.where(level: 1): h => {
    set text(..h1)
    Smallcaps(h.body, tracking: h1.tracking)
    v(-1em)
    line(length: 100%, stroke: 0.5pt + black)
  }

  show heading.where(level: 2): h => {
    set text(..h2)
    h.body
    linebreak()
  }

  show heading.where(level: 3): h => {
    set text(..h3)
    h.body
    linebreak()
  }

  show heading.where(level: 4): h => {
    set text(..h4)
    h.body
    linebreak()
  }
  /**
   * Name and profile pic
   */
  let cell-profile = box(
    width: profile-size,
    height: profile-size,
    radius: 50%,
    stroke: D.stroke,
    clip: true,
    pad(
      left: -3%,
      top: 0%,
      image(
        profile-path,
        width: 100%,
        height: 100%,
      ),
    ),
  )

  grid(
    rows: (title.size),
    columns: (auto, 1fr, profile-size),
    align: (left, center, center),
    stroke: D.stroke,
    gutter: grid-gutter,

    grid.cell({
      set text(..title)
      Smallcaps(author.name, tracking: title.tracking)
    }),

    grid.cell(AuthorLinks(author)),

    grid.cell(
      cell-profile,
      inset: (y: -profile-size / 4),
    )
  )

  /**
   * Body
   */
  content.preamble

  grid(
    rows: auto,
    // columns: (1fr, 2fr) // right-dominant
    columns: (2fr, 1fr), // left-dominant
    stroke: D.stroke,
    gutter: grid-gutter,

    content.core,
    content.side,
  )

  content.postamble
}
