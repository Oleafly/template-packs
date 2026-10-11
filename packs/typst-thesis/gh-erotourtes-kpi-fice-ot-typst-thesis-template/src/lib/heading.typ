#import "lib.typ": body_par_indent, body_par_leading, body_text_size

#let plain_heading_text(body) = {
  let value = repr(body)
  if value.starts-with("[") and value.ends-with("]") {
    value.slice(1, -1)
  } else if value.starts-with("sequence([") {
    value.split("],").first().slice("sequence([".len())
  } else {
    value
  }
}

#let heading_config(
  level: none,
  it: none,
  number_level_one: false,
) = {
  let size = if level == 1 {
    18pt
  } else if level == 2 {
    16pt
  } else {
    14pt
  }
  let heading_indent = body_text_size * (body_par_indent / 1em)

  if level == 1 {
    let should_number = (
      it.numbering != none and number_level_one
    )

    let heading_number = if should_number {
      counter(heading).at(it.location()).map(value => str(value)).join(".")
    } else {
      []
    }

    let heading_body = text(size: size, weight: "bold", hyphenate: false)[
      #heading_number#if should_number [ ]#upper(plain_heading_text(it.body))
    ]

    block(width: 100%, above: body_par_leading, below: body_par_leading)[
      #align(center)[#heading_body]
    ]
  } else {
    let heading_number = if it.numbering != none {
      counter(heading).at(it.location()).map(value => str(value)).join(".")
    } else {
      []
    }

    let heading_body = text(size: size, weight: "bold", hyphenate: false)[
      #heading_number#if it.numbering != none [ ]#it.body
    ]

    block(width: 100%, above: body_par_leading, below: body_par_leading)[
      #pad(left: heading_indent)[#heading_body]
    ]
  }
}
