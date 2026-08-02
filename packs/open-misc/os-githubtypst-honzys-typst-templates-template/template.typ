#let lineThickness = 0.7pt
#let fillColor = rgb(50,50,150)
#let fillSize = 0.9em

#let duha(
  title: "",
  subtitle: "",
  author: "",
  body,
) = {
  // Set the document's basic properties.
  set document(author: author, title: title)

  // Set body font family.
  set text(lang: "cs", 12pt)
  show heading: it => {
    if (it.level == 1) {
      v(0.3em)
      text(upper(it.body), weight: "bold", size: 12pt)
      v(-0.2em)
    }
    if (it.level == 2) {
      text(it.body, weight: "bold", size: 12pt)
      v(0.2em)
    }
  }

  // Set styles
  show link: it => underline(text(fill: rgb("#114499"), it))
  show heading.where(level:1): it => it + v(0.5em)
  set list(marker: ("●", "o", "o", "o"), body-indent: 1em, indent: 1em)

  set page(
    margin: (
      top: 1.5cm,
      bottom: 1.5cm,
      left: 2.0cm,
      right: 1.5cm
    ),
    paper: "a4",
    header: [
      #place(top + left, dx: -2.0cm, dy: 0cm, rect(width: 0.2cm, height: 297mm, fill: rgb("#f80304")))
      #place(top + left, dx: -1.8cm, dy: 0cm, rect(width: 0.2cm, height: 297mm, fill: rgb("#f1d405")))
      #place(top + left, dx: -1.6cm, dy: 0cm, rect(width: 0.2cm, height: 297mm, fill: rgb("#67a601")))
      #place(top + left, dx: -1.4cm, dy: 0cm, rect(width: 0.2cm, height: 297mm, fill: rgb("#0c5e73")))
      #place(top + right, dx: 0.5cm, dy: 1.1cm, image(width: 4cm, height: 1.5cm, fit: "stretch", "media/logo.png"))
    ],
  )

  set par(justify: false)

  body
}

#let title(title, subtitle: "") = { 
  upper(text(weight: "bold", size: 18pt, title))
  v(-1em)
  upper(text(weight: "bold", subtitle))
  v(0.6em)
}

#let field(title, to: 100%, lines: 1, lastLineTo: -1%, newline: false, content: "") = {
  if (type(title) == str) {
    title = title.trim()
  }
  if (content == none) {
    content = ""
  }

  if (lastLineTo < 0% or lastLineTo > to) {
    lastLineTo = to
  }

  text("")
  
  context {    
    let x = here().position().x
    
    if ((not type(title) == str) or title.len() > 0) {
      box(title, height: 0.6em)
      h(0.5em)
      x += 0.5em
      x += measure(title).width
    } else {
      text(".", size: 0pt)
    }
    
    if (not newline) {
      box(
        height: 0.8em,
        {
          v(1em)
          box(
            box(
              par(
                leading: 0.85em,
                {
                  h((x - page.margin.left).length)
                  text(str(content), size: fillSize, fill: fillColor)
                }
              ),
              width: (page.width - page.margin.left - page.margin.right) * to,
              height: 1.45em * lines - (1.4em - 1em),
              clip: true,
              inset: (top: 0.2em),
            ),
            inset: (top: -1em, left: -(x - page.margin.left).length),
            width: calc.max(((page.width - page.margin.left - page.margin.right) * to - (x - page.margin.left)).length.to-absolute(), 1em.to-absolute()),
            height: lineThickness,
            fill: black,
          )
        },
      )
    }

    let i = 1

    if (newline) {
      i = 0
    }
    
    while i < lines {
      let w = to
      if (i == lines - 1) {
        w = lastLineTo
      }
      
      let cont = ""
      if (newline) {
        cont = box(
          par(
            leading: 0.85em,
            {
              text(".", size: 0pt)
              text(str(content), size: fillSize, fill: fillColor)
            }
          ),
          width: (page.width - page.margin.left - page.margin.right) * to,
          height: 1.4em * lines - (1.4em - 0.8em),
          clip: true
        )
      }
      
      box(
        height: 0.8em,
        {
          v(1em)
          box(
            cont,
            inset: (top: -0.8em, left: 0.2em, right: 0.2em),
            width: w,
            height: lineThickness,
            fill: black,
          )
        },
      )
      i += 1
    }
  }

  if (to < 100% or (lines > 1 and lastLineTo < 100%)) {
    h(0.3em)
  }
}

#let options(title, options: (), selected: "") = {
  title = title.trim()
  
  context {
    let x = here().position().x
    
    if (title.len() > 0) {
      box(title, height: 0.6em)
      h(0.5em)
      x += 0.5em
      x += measure(title).width
    } else {
      text(".", size: 0pt)
    }

    for (key, value) in options {
      let content = {
        box(
          {
            if (selected == key) {
              place(
                line(
                  start: (0%, 0%),
                  end: (100%, 100%),
                  stroke: (
                    paint: fillColor,
                    thickness: 0.8pt
                  )
                )
              )
              place(
                line(
                  start: (100%, 0%),
                  end: (0%, 100%),
                  stroke: (
                    paint: fillColor,
                    thickness: 0.8pt
                  )
                )
              )
            }
          },
          width: 0.7em,
          height: 0.7em,
          stroke: (paint: black, thickness: lineThickness),
        )
        h(0.4em)
        key
      }
      place(content, dx: value - measure(content).width, dy: -1.5em)
    }
  }
}

#let separator() = {
  line(
    stroke: (
      paint: black,
      thickness: lineThickness,
      dash: "loosely-dotted"
    ),
    length: 100%
  )
}

#let form(content) = {
  show par: it => {
    it
    v(-0.3em)
  }
  content
}

#let credentials(fields: (), width: 30%, spacing: 1em) = {
  table(
    columns: (width, auto),
    align: top,
    inset: 0pt,
    row-gutter: spacing,
    stroke: none,
    ..fields.pairs().map(pair => (text(upper(pair.at(0)), weight: "bold"), pair.at(1))).flatten()
  )
}

#let signature(content, length: 30%) = {
  align(center + top, [
    #v(2em)
    #line(start: (0pt, 0em), end: (length, 0em), stroke: (paint: black, thickness: lineThickness))
    #v(-0.8em)
    #text(content, size: 0.9em)
  ])
}

#let format-datetime(time) = {
  if (time.len() >= 10) {
    datetime(
      year: int(time.split("-").at(0)),
      month: int(time.split("-").at(1)),
      day: int(time.split("-").at(2).slice(0, 2))
    ).display("[day]. [month]. [year]")
  }
}

#let format-phone(phone) = {
  let s = str(phone)
  if (s.len() == 9) {
    s.slice(0, count: 3) + " " + s.slice(3, count: 3) + " " + s.slice(6, count: 3)
  }
}

#let optional(object, value) = {
  object.at(value, default: "")
}