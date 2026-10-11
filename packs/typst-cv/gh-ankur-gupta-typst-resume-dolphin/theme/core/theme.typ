#import "navbar.typ": JOHNDOE, navbar

#let detailed_cv(url: none, top_padding: -0.5em, align_value: right, text_size: 0.85em) = {
  if url == none {
    pad(top: top_padding, align(align_value, text(size: text_size, "Detailed CV available on request.")))
  } else {
    pad(top: top_padding, align(align_value, text(size: text_size, [Detailed CV available #link(url, "here").])))
  }
}

#let google_scholar_footer(url: none, top_padding: -0.5em, align_value: right, text_size: 0.85em) = {
    pad(top: top_padding, align(align_value, text(size: text_size, [See  #link(url, "Google Scholar")])))
}

#let compact_resume(url: none, top_padding: 1em, align_value: right, text_size: 1em) = {
  if url == none {
    pad(top: top_padding, align(align_value, text(size: text_size, "Compact résumé available on request.")))
  } else {
    pad(top: top_padding, align(align_value, text(size: text_size, [Compact résumé available #link(url, "here").])))
  }
}

#let template(
  tight: true,
  me: JOHNDOE,
  summary: [],
  body: []
) = {
  set text(size: 10pt)
  set page(paper: "us-letter", margin: (x: 4em, y: 4em))
  show link: set text(blue)

  show heading: it => {
    if tight == true [
      #pad(top: -0.5em, bottom: -1em, [#smallcaps(text(weight: "regular", size: 0.85em, it.body))])
      #line(length: 100%, stroke: 0.2pt)
    ] else [
      #pad(top: 0.25em, bottom: -1em, [#smallcaps(text(weight: "regular", size: 0.85em, it.body))])
      #line(length: 100%, stroke: 0.2pt)
    ]
  }

  grid(
    columns: (3.1fr, 1.1fr), column-gutter: 0.3fr,
    [
      #text(size: 2em, weight: "bold", smallcaps(me.name)) \
      #if me.location != none [
        #text(style: "italic", size: 0.9em, me.location) \
      ] else [
        \
      ]
      #par(justify: true, text(0.9em, summary))
    ],
    [
      #set text(size: 0.9em)
      #navbar(me: me)
    ]
)
  body
}
