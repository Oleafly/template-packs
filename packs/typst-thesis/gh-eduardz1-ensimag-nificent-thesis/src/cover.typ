/// Balances text, useful for headings, captions, centered text, or others.

/// Balances lines of text while keeping the minimum amount of lines possible.
/// Works by shrinking the width of the text until it can't be shrunk anymore.
///
/// Unbalanced text:
/// #example(```
///   #rect(width: 25em, lorem(10))
/// ```)
///
/// Balanced text:
/// #example(```
///   #rect(width: 25em, balance(lorem(10)))
/// ```)
///
/// -> content
#let balance(
  /// The text to balance. -> content
  body,
  /// Maximum number of iterations to perform. -> int
  max-iterations: 20,
  is-figure: false,
  /// The precision to which to balance. -> length
  precision: 0.1em,
) = context layout(size => {
  set text(hyphenate: par.justify) if text.hyphenate == auto
  let lead = par.leading.to-absolute()
  let line-height = measure(body).height + lead
  let initial-size = measure(width: size.width, body)
  let initial-lines = (initial-size.height + lead) / line-height

  let high = initial-size.width
  let low = high * (1 - (1 / initial-lines)) / 2

  let extra-lines = initial-lines
  for i in range(0, max-iterations) {
    let candidate = high - (high - low) / (extra-lines + 1)
    set par(justify: false)
    let (height, width) = measure(width: candidate, body)
    if height > initial-size.height {
      low = candidate
      extra-lines = (height - initial-size.height) / line-height
    } else {
      high = width
      if measure(width: width - precision, body).height > initial-size.height {
        break
      }
      high -= precision.to-absolute()
    }
    if high - low < precision.to-absolute() {
      break
    }
  }

  // set linebreak(justify: true) if par.justify and is-figure

  block(width: high, body)
})

/// Generates the cover page for the thesis.
/// -> content
#let cover(
  /// The specialization -> str
  specialization: "",
  /// The thesis' title. -> str
  title: "",
  /// The date of the thesis defense. -> datetime
  defense-date: datetime.today(),
  /// The candidate's name. -> str
  name: "",
  /// The lab in which you perfomed the research project. -> str
  lab: "",
  /// The supervisor (or multiple supervisors) of the thesis. -> str | list(str)
  supervisor: "",
  /// The list of members of the jury. -> dictionary
  jury: (
    president: "",
    members: "",
  ),
) = {
  set align(center + horizon)

  grid(
    columns: 3,
    image("assets/uga-logo.svg", height: 10%),
    h(1fr),
    image("assets/inp-logo.svg", height: 10%),
  )

  v(0.2fr)

  block[
    #let jb = linebreak(justify: true)
    Master of Science in Informatics at Grenoble #jb
    #text([Master Informatique, Université Grenoble Alpes], lang: "fr") #jb
    Specialization #specialization
  ]

  v(1fr)
  {
    set par(justify: false)
    box(
      width: 15cm,
      balance(smallcaps(text(title, size: 2em, weight: "bold"))),
    )
  }

  v(0.2fr)

  smallcaps(text(name, size: 1.2em, weight: "bold", hyphenate: false))

  v(0.5fr)

  defense-date.display("[month repr:long] [day], [year]")

  v(0.5fr)

  [
    Master research project performed at

    #lab
  ]

  v(0.2fr)

  [
    Under the supervision of

    #supervisor
  ]

  v(1fr)

  [
    Defended before a jury composed of

    #jury.president, President

    #for member in jury.members [
      #member\
    ]
  ]

  pagebreak(to: "odd", weak: true)
}


#import "@preview/libra:0.1.0"
#set heading(numbering: "1.1")
#show outline.entry.where(level: 1): it => {
  if it.element.func() != heading {
    return it
  }

  v(2em, weak: true)
  link(it.element.location(), strong(it.indented(it.prefix(), {
    (libra.balance(it.body()) + h(1fr) + it.page())
  })))
}

#outline()

= Test
== Test
