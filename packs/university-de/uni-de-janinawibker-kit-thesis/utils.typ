#import "@preview/drafting:0.2.2": inline-note

// TODO: customize these values to your liking
// TODO: don't forget to include the proper font in the fonts/ directory 
#let serif-font = "Libertinus Serif"
#let monospace-font = "Meslo LG S"

#let line-highlight-color = rgb("#f2e8fc")

#let citation-color = color.hsl(312deg, 55%, 50%)

#let load-bibliography(main: false) = {
  counter("bibs").step()
  
  context if main {
    [#bibliography("bibliography.yml") <main-bib>]
  } else if query(<main-bib>) == () and counter("bibs").get().first() == 1 {
    // This is the first bibliography, and there is no main bibliography
    bibliography("bibliography.yml")
  }
}

#let get-title-from-bibliography(label-of-citation, short: false) = {
  let bib = yaml("bibliography.yml")
  let title = bib.at(str(label-of-citation)).title
  
  if short {
    assert(
      type(title) != str and "short" in title and "value" in title,
      message: "title cannot be a string, must be a dict with a 'value' and 'short' fields",
    )
    return title.short
  } else if type(title) == str {
    return title
  } else {
    return title.value
  }
}

#let cite-superscript(..args) = {
  cite(..args, style: "vancouver-superscript")
}

#let cite-abbr(label-of-citation, suffix: none, style: "normal", fill: citation-color, enclosing: true) = {
  let short-title = get-title-from-bibliography(label-of-citation, short: true)
  
  // cannot make the whole thing a link, but we can add a suffix which uses a specific citation style which is then in turn a clickable link
  // this is really hacky and a proper solution would be nice, but it works and I don't want to write ~500 lines of xml for a custom citation style
  if suffix == none {
    suffix = cite-superscript(label-of-citation)
  }
  
  if enclosing {
    text(style: style)[\[#short-title#text(fill: fill)[#suffix]\]]
  } else {
    text(style: style)[#short-title#text(fill: fill)[#suffix]]
  }
}

#let cite-title(label-of-citation, include-citation: true, style: "italic", ..args) = {
  let title = get-title-from-bibliography(label-of-citation)
  
  if include-citation {
    [#text(style: style, ..args)[#title] #cite(label-of-citation)]
  } else {
    text(style: style, ..args)[#title]
  }
}

#let chapter-ref(label, style: "italic", fill: citation-color, ..args) = context {
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading {
      let num = numbering(
        el.numbering,
        ..counter(heading).at(el.location()),
      )
      text(style: style, ..args)[#link(el.location(), [#text(fill: fill)[#num] #el.body])]
    }
  }
  
  ref(label)
}

#let TODO(color: red, font: monospace-font, body) = inline-note(
  rect: rect.with(inset: 0.5em, radius: 0.2em),
  fill: color.lighten(90%),
  stroke: color,
)[
  #text(font: font, size: 10pt)[*\/\/ TODO*: #body]
]

#let todo(color: red, font: monospace-font, body) = inline-note(
  rect: box.with(inset: 0.2em, baseline: 2pt, radius: 0.2em, outset: (y: 1pt)),
  fill: color.lighten(90%),
  stroke: color,
)[
  #text(font: font, size: 9pt)[*TODO*: #body]
]

#let zebraw = {
  import "@preview/zebraw:0.5.5": zebraw
  zebraw.with(
    numbering: false,
    lang: false,
    background-color: white,
    highlight-color: line-highlight-color,
  )
}
