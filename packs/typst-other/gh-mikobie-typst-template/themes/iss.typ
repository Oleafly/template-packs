// This theme contains ideas from the former "bristol" theme, contributed by
// https://github.com/MarkBlyth
#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.0"
#import "@preview/showybox:2.0.4": showybox

#let iss-left-footer = state("iss-left-footer", [])
#let iss-right-footer = state("iss-right-footer", toolbox.slide-number)
#let iss-short-title = state("iss-short-title", none)
#let iss-logo-header = state("iss-logo-header", none)
#let iss-color = state("iss-color", blue)
#let iss-logo = state("iss-logo", image("png/uw.png"))
#let m-cell = block.with(
  width: 100%,
  height: 100%,
  above: 0pt,
  below: 0pt,
  breakable: false
)


#let iss-theme(
  aspect-ratio: "16-9",
  short-title: none,
  left-footer: [],
  logo: image("png/uw.png"),
  logo-header: none,
  color: blue,
  body
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
  )
  set text(size: 25pt)
  show footnote.entry: set text(size: .6em)

  iss-left-footer.update(left-footer)
  iss-color.update(color)
  iss-short-title.update(short-title)
  iss-logo.update(logo)
  iss-logo-header.update(logo-header)

  body
}


#let title-slide(
  title: none,
  subtitle: none,
  authors: (),
  date: none,
  secondlogo: none,
  funding: none,
) = {
  let content = context{
    let color = iss-color.get()
    let logo = iss-logo.get()
    let authors = if type(authors) in (str, content) {
      ( authors, )
    } else {
      authors
    }

    v(5%)
    align(center + horizon)[
    #grid(columns: (5%, 1fr, 5%),
    [],
    {
      showybox(
        frame: (
          border-color: color,
          title-color: color,
          body-color: color,
        ),
        body-style: (
          align: center,
          color: white,
          weight: "thin",
        ),
        sep: (
          thickness: 0pt,
        ),
        title-style:(
          color: white,
          weight: "extrabold",
          align: center
        ),
        shadow: (
          offset: (x: 2pt, y: 3pt),
          color: color.lighten(80%)
        ),
        title: [
          #show: text.with(size: 32pt)
          #title],
        [#if subtitle != none {
          [ 
            #show: text.with(size: 20pt)
            #subtitle
          ]

        }
        ]
      )
    },
    []
    )
    #v(5%)
    #set text(size: .8em)
    #grid(
      columns: (1fr,) * calc.min(authors.len(), 3),
      column-gutter: 1em,
      row-gutter: 1em,
      block(..authors, width: 70%)
    )
    #if secondlogo == none{
      grid(columns: (5%, 1fr, 5%),
        [],
          {
            set align(center + horizon)
            set image(height: 3em)
            logo
          },
        []
      )
    } else {
    grid(columns: (5%, 1fr, 5%, 1fr, 5%),
      [],
      {  set align(bottom + right)
        set image(height: 3em)
        logo
      },
      [],
      { set align(bottom + left)
        set image(height: 3em)
        secondlogo
      },
      []
    )
    }

      #v(1em)
      #date
      #v(2em)
      #grid(columns: (5%, 1fr,5%),
      [],
      [#text(size: 14pt)[
        #funding
        ]
      ],
      []
      )
    ]
  }
  content
  counter("logical-slide").update(n=>n+1)
}

#let slide(title: none, body) = {
  let header = context {
    let color = iss-color.get()
    let logo-header = iss-logo-header.get()
    set align(top)
    if title != none and logo-header != none {
      grid(columns: (1fr, 7%),
      {
        show: m-cell.with(fill: color, inset: 2em, width: 100%)
        set align(horizon)
        set text(fill: white, size: 1.2em)
        strong(title)

      },
      {
        set align(horizon + center)
        logo-header
      })
    } else if title != none { 
        show: m-cell.with(fill: color, inset: 2em, width: 100%)
        set align(horizon)
        set text(fill: white, size: 1.2em)
        strong(title)
    } else {[]}
  }

  let footer = context {
    let color = iss-color.get()
    let short-title = iss-short-title.get()
    let left-footer = iss-left-footer.get()
    set align(bottom)
    {
      set align(horizon + center)
      set text(fill: white, size: .5em)
      grid(columns: (1fr, 3fr, 7%),
      {
        show: m-cell.with(fill: color.lighten(20%), inset: .5em)
        left-footer
      },
      {
        show: m-cell.with(fill: color, inset: .5em)
        short-title
      },
      {
        show: m-cell.with(fill: color.darken(20%), inset: .5em)
        [#toolbox.slide-number / #toolbox.last-slide-number]
      }
      )
    }
  }

  set page(
    margin: ( top: 4em, bottom: 2em, x: 0em ),
    header: header,
    footer: footer,
    footer-descent: 1em,
    header-ascent: 1.5em,
  )

  let body = pad(x: .0em, y: .5em, body)


  let content = {
    grid(columns: (4%, 1fr, 4%),
    [],
    body,
    [])
  }
  content
  counter("logical-slide").update(n=>n+1)
}

#let focus-slide(background: teal, foreground: white, body) = {
  set page(fill: background, margin: 2em)
  set text(fill: foreground, size: 1.5em)
  let content = { v(.1fr); body; v(.1fr) }
  content
  counter("logical-slide").update(n=>n+1)
}

#let new-section-slide(name) = {
  set page(margin: 2em)
  let content = context {
    let color = iss-color.get()
    set align(center + horizon)
    show: block.with(stroke: ( bottom: 1mm + color ), inset: 1em,)
    set text(size: 1.5em)
    strong(name)
    //utils.register-section(name)
  }
  content
  counter("logical-slide").update(n=>n+1)
}
