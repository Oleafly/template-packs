#import "lib.typ": (
  body_text_size, font_main, page_margin, page_outline_stroke, page_size,
)
#import "theme.typ": document_text_rules

#let footer_slot(footer: none, height: none) = {
  if footer == none {
    none
  } else {
    box(height: height)[
      #align(bottom)[#footer]
    ]
  }
}

#let cover_page(body, right: none) = page(
  width: page_size.width,
  height: page_size.height,
  margin: (
    left: page_margin.left,
    right: if right == none { page_margin.left } else { right },
    top: page_margin.left,
    bottom: page_margin.left,
  ),
  numbering: none,
)[
  #set text(font: font_main, body_text_size)
  #body
]

#let standard_page(
  body,
  background: none,
  footer: none,
  footer_space: auto,
) = context {
  let footer_height = if footer == none {
    0mm
  } else if footer_space == auto {
    measure(footer).height
  } else {
    footer_space
  }

  page(
    width: page_size.width,
    height: page_size.height,
    margin: (
      left: page_margin.left,
      right: page_margin.right,
      top: page_margin.top,
      bottom: page_margin.bottom + footer_height,
    ),
    background: background,
    footer: footer_slot(footer: footer, height: footer_height),
    footer-descent: 0mm,
    numbering: none,
  )[
    #show: document_text_rules
    #body
  ]
}

#let pad_margins = (
  left: 10mm,
  right: 10mm,
  top: 10mm,
  bottom: 10mm,
)

#let bordered_page(body, footer: none, footer_space: auto) = {
  standard_page(
    background: place(
      top + left,
      dx: page_margin.left,
      dy: page_margin.top,
    )[
      #box(
        width: page_size.width - page_margin.left - page_margin.right,
        height: page_size.height - page_margin.top - page_margin.bottom,
        stroke: page_outline_stroke,
      )
    ],
    footer: footer,
    footer_space: footer_space,
  )[
    #pad(
      left: pad_margins.left,
      right: pad_margins.right,
      top: pad_margins.top,
      bottom: pad_margins.bottom,
    )[
      #body
    ]
  ]
}
