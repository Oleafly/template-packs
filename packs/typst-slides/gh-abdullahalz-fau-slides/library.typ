
#import "@preview/polylux:0.4.0": *

// Mutable Variables depending on department
#let _primary_color = state("primary", rgb("#002f6c"))
#let _bg = state("background", "images/fau.png")
#let _logos = state("logos", (image("images/fau-text-blue.png"),))
#let _section_logos = state("section_logos", ())
#let _date = state("date", datetime.today().display())
#let _department = state("department", "Tech")

// Constant Variables
#let _sidebar-width = 14.4mm
#let _line_thick = 2mm
#let _line_thin = 0.5mm
#let _foot_height = 9mm
#let _fau_header_font = 25pt
#let _departments = (
  tech: (color: rgb("#779fb5"), bg: "images/Tech.jpg", name: "Technische Fakultät"),
  rw: (color: rgb("#c8102e"), bg: "images/RW.jpg", name: "Fachbereich Rechtswissenschaft"),
  phil: (color: rgb("#ffb81c"), bg: "images/Phil.jpg", name: "Philosophische Fakultät und \nFachbereich Theologie", size: 18pt),
  nat: (color: rgb("#43b02a"), bg: "images/Nat.jpg", name: "Naturwissenschaftliche Fakultät"),
  med: (color: rgb("#00a3e0"), bg: "images/Med.jpg", name: "Medizinische Fakultät"),
)



#let _get_kennung() = context {
  let d = lower(_department.get())
  let config = _departments.at(d, default: none)
  set text(size: _fau_header_font)
  let base = text(stroke: white, "Friedrich-Alexander-Universität\n")

  if config != none {
    let size = config.at("size", default: _fau_header_font)
    set text(size: size) if size != _fau_header_font
    [#base#text(stroke: white, config.name)]
  } else {
    [#base#text(stroke: white, "Erlangen-Nürnberg")]
  }
}

#let _set_department(d) = {
  let d = lower(d)
  let config = _departments.at(d, default: (color: rgb("#002f6c"), bg: "images/FAU.jpg"))
  _primary_color.update(config.color)
  _bg.update(config.bg)
  _department.update(d)
}

#let _footer(content) = context {
  let primary = _primary_color.get()
  set text(size: 11pt)
  stack(
    dir: ttb,
    spacing: 5pt,
    line(length: page.width, stroke: _line_thin + primary.darken(20%)),
    stack(
      place(
        box(
          width: 50% * (100% - _sidebar-width),
          height: _foot_height - _line_thin,
          text(
            content,
          ),
        ),
      ),
      place(
        right,
        box(
          width: 50% * (100% - _sidebar-width),
          height: _foot_height - _line_thin,
          text({
            _date.get()
            h(2em)
            [#toolbox.slide-number/#toolbox.last-slide-number]
          }),
        ),
      ),
    ),
  )
}

#let _header_bg = context {
  let faulogo = "images/fau-text-white.png"
  let logos = _section_logos.get()
  let logos = if logos.len() > 0 { logos } else { _logos.get().slice(1) }
  show: toolbox.full-width-block.with(inset: 1pt)
  stack(
    dir: ttb,
    spacing: 0pt,
    stack(
      dir: rtl,
      image(faulogo, height: 80pt),
      ..logos.map(logo => align(horizon, box(
        height: 50pt,
        logo,
      ))),
      h(1fr),
      place(
        dx: _sidebar-width,
        dy: -70pt,
        text(size: 30pt, _get_kennung()),
      ),
    ),
    line(
      length: page.width - _sidebar-width,
      start: (_sidebar-width, 0%),
      stroke: _line_thick + _primary_color.get().darken(20%).saturate(30%),
    ),
  )
}

#let _header = toolbox.next-heading(heading => {
  context {
    let logos = _logos.get()
    let primary = _primary_color.get()
    show: toolbox.full-width-block.with(inset: 1pt)
    stack(
      dir: ttb,
      spacing: 10pt,
      box(
        inset: (x: 6pt),
        stack(
          dir: rtl,
          spacing: 10pt,
          ..logos.map(logo => box(
            height: 2em,
            align(horizon, logo),
          )),
          h(1fr),
          align(right + horizon, text(size: 1.2em, weight: "bold", fill: primary, [#h(4%) #heading])),
        ),
      ),
      line(
        length: page.width - _sidebar-width,
        start: (_sidebar-width, 0%),
        stroke: _line_thick + primary.darken(20%).saturate(30%),
      ),
    )
  }
})

#let new-logo(logo) = {
  _logos.update(logos => logos + (logo,))
}

#let new-section-logo(logo) = {
  _section_logos.update(logos => logos + (logo,))
}

#let top-slide(
  title: "Title",
  subtitle: "Subtitle",
  author: "Author¹",
  institution: "¹Institution",
  
) = context {
  let bg = _bg.get()
  let primary = _primary_color.get()
  let date = _date.get()
  slide[
    #set page(
      header-ascent: -2.2em,
      header: _header_bg,
      footer: text(size: .6em)[#date],
      margin: 2em,
      background: image(bg),
    )
    #set text(fill: white)
    #text(size: 40pt)[#title]

    #text(size: 20pt)[#subtitle]
    #v(20pt)

    #set text(size: 16pt)
    #author
    #v(1em)
    #set text(size: 14pt)
    #institution
  ]
}

#let section(name) = context {
  slide()[
    #set page(
      header: _header_bg,
      footer: none,
      background: image(_bg.get()),
    )
    #set text(size: 50pt, fill: white)
    #align(center + horizon)[#name]
  ]
}

#let setup(
  footer: "FAU Slides",
  fill: white,
  font: "Fira Sans",
  math-font: "Fira Math",
  code-font: "Fira Code",
  text-size: 23pt,
  department: "FAU",
  date: datetime.today().display(),
  body,
) = context {
  _set_department(department)
  _date.update(date)

  let color = _primary_color.get()

  set page(
    paper: "presentation-16-9",
    fill: fill,
    margin: (top: 3em, bottom: _foot_height, left: _sidebar-width, right: 1em),
    footer: _footer(footer),
    header: _header,
  )
  set text(
    font: font,
    size: text-size,
    fill: fill.negate(),
  )
  set strong(delta: 100)
  show math.equation: set text(font: math-font)
  show raw: set text(font: code-font)
  set align(horizon)

  show heading: it => context {
    set text(fill: color)
    it
  }
  show heading.where(level: 1): _ => none
  body
}
