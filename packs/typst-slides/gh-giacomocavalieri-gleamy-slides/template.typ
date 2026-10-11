// --- VARIABLES ---------------------------------------------------------------

#let faded = color.rgb("#8E8E8E")

#let off-white = color.rgb("#fefefc")

#let black = color.rgb("#1e1e1e")

#let faff-pink = color.rgb("#ffaff3")

// --- RULES TO MAKE STUFF LOOK GOOD

#set text(font: "Open Sauce One", size: 1.5em)

#set page(paper: "a5", flipped: true)

#show heading.where(level: 1): set text(size: 1.3em)

#show page: it => {
  let emph_fill = if it.fill == faff-pink { black } else { faff-pink }
  show emph: set text(weight: "black", fill: emph_fill)
  it
}

// --- CODE RULES --------------------------------------------------------------

// We add Gleam's syntax to the supported ones
// and a code theme that's good on dark backgrounds.
#set raw(
  syntaxes: "gleam.sublime-syntax",
  theme: "gleam.tmTheme",
)

#let fade-code-lines(lines-to-show, code-lines) = {
  if lines-to-show == "all" {
    code-lines.join("\n")
  } else if type(lines-to-show) == int {
    fade-code-lines((lines-to-show,), code-lines)
  } else {
    code-lines.map(line => {
      if line.number - 1 not in lines-to-show {
        text(fill: faded, line.text)
      } else { line }
    }).join("\n")
  }
}

// When we run into a Gleam code block we change
// its background to dark and the default color
// to an off-white color so that the highligh theme
// looks good.
#show raw.where(block: true): it => {
  let first-line = it.lines.first().text
  let content = if first-line.starts-with("{") and first-line.ends-with("}") {
    let lines-to-show = first-line
      .trim("{").trim("}")
      .split(regex("\s*,\s*"))
      .map(it => {
        if it.contains("-") {
          let (start, end) = it.split("-")
          range(int(start), int(end) + 1)
        } else {
          (int(it))
        }
      })
      .flatten()

    fade-code-lines(lines-to-show, it.lines.slice(1))
  } else {
    // Normal text block, no need to hide anything
    it
  }

  text(fill: off-white, block(
    width: 100%,
    fill: black,
    inset: 1em,
    radius: 10%,
    content,
  ))
}

// --- BUILDING A SLIDE --------------------------------------------------------

#let slide(title: none, style: "light", ..fragments) = {
  let background = if style == "light" { off-white }
               else if style == "dark" { black }
               else if style == "pink" { faff-pink }
               else { panic("not a valid style") }

  let font-color = if style == "light" { black }
               else if style == "dark" { off-white }
               else if style == "pink" { black }
               else { panic("not a valid style") }

  if fragments.pos().len() == 1 {
    // A slide with a single fragment
    page(fill: background, text(fill: font-color)[
      #if title != none [== #title]
      #align(horizon, fragments.pos().at(0))
    ])
  } else {
    // A fragmented slide
    let shown = ()
    let hidden = fragments.pos().rev()
    for fragment in fragments.pos() {
      shown.push(fragment)
      let _ = hidden.pop()
      slide(title: title, style: style)[
        #for elem in shown { [ #elem #parbreak() ] }
        #for elem in hidden.rev() { hide[ #elem #parbreak() ] }
      ]
    }
  }
}

#let slide-code-fragments(title: none, fragments, code) = {
  for fragment in fragments {
    show raw: it => fade-code-lines(fragment, it.lines)
    slide(title: title, style: "dark", code)
  }
}

#let quote(from: none, content) = {
  let quote = heading(
    level: 1,
    outlined: false,
    bookmarked: false,
    content,
  )

  if from == none { quote } else {
    let name = text(
      style: "italic",
      size: .8em,
      align(left, "- " + from),
    )
    stack(dir: ttb, spacing: 1em, quote, name)
  }
}
