#import "@preview/showybox:2.0.1": showybox

#let custom_outline() = locate(loc => {
  heading(numbering: none)[目次]
  let headings = query(heading, loc)
  let toc = ()

  let _ = headings.remove(0)

  for h in headings {
    let padd = h.level * 1em - 1em
    let page = counter(page).at(h.location())
    
    let ch = if h.level == 1 {
      strong(counter("h").display("1."))
    } else {
      counter("h").display("1.")
    }
    
    let heading = if h.level == 1 {
      strong(h.body)
    } else {
      h.body
    }
    
    toc.push(
      {
        if h.level == 1 [
          #v(1.2em)
        ] else [
          #v(0.7em)
        ]
      } + 
      box[#pad(left: padd)[#link(h.location())[#{counter("h").step(level: h.level)}#ch#sym.space.third#heading]]] + 
      " " +
      box(width: 1fr)[
        #if h.level != 1 [
          #repeat(" .")
        ]
        ] + 
      [ #page.join()]
    )
  }

  stack(dir: ttb, ..toc)
})

#let set_date(is_date, fontsize) = {
  if is_date == true {
    align(
      center, 
      text(
        size: fontsize, 
        datetime.today().display("[year]年[month]月[day]日")
      )
    )
  } 
}

#let set_author(authors, fontsize) = {
  pad(
    top: 1em,
    bottom: 0em,
    left: 4em,
    right: 4em,
    grid(
      columns: (1fr,) * calc.min(2, authors.len()),
      gutter: 1%,
      ..authors.map(author => 
      align(
        center, 
        text(size: fontsize, author)
      )),
    ),
  )
}

#let project(
  title: "",
  authors: (),
  date: false,
  titlepage: false,
  bibfile: "",
  body
  ) = {

  let body_font = (
    "Latin Modern Roman",
    "Harano Aji Mincho"
  )

  let math_font = ("Latin Modern Math")

  set document(author: authors, title: title)
  
  set page(
    margin: (
      left: 25mm,
      right: 25mm,
      top: 30mm,
      bottom: 30mm
    ),
    numbering: "1",
    number-align: center,
  )
  
  set text(
    font: body_font,
    lang: "ja",
    region: "JP"
  )

  set figure(supplement: it => {
    if it.func() == table {
      "表"
    } else if it.func() == image {
      "図"
    } else {
      "図" // どうしよ
    }}
  )

  show math.equation: set text(
    weight: 400,
    font: math_font,
  )

  set math.equation(
    supplement: "式",
    numbering: "(1)",
  )

  // Start of document
  if titlepage == true {
    v(0.4fr)
    align(center)[
      #block(
        text(size: 2.5em, weight: 600, title)
      )
    ]
    v(0.05fr)
    set_author(authors, 1.6em)
    v(0.05fr)
    set_date(date, 1.4em)
    v(0.6fr)
    pagebreak()

    custom_outline()
    pagebreak()
  } else {
    // Title
    align(center)[
      #block(
        text(size: 2.0em, weight: 600, title)
      )
    ]
    set_author(authors, 1.5em)
    set_date(date, 1.4em)
    h(4em)
  }

  // Spacing between Japanese and English text
  show regex(
    "[\\P{latin}&&[[:^ascii:]]][\\p{latin}[[:ascii:]]]|[\\p{latin}[[:ascii:]]][\\P{latin}&&[[:^ascii:]]]"
  ) : it => {
    let a = it.text.match(regex("(.)(.)"))
    a.captures.at(0)+h(0.25em)+a.captures.at(1)
  }

  show par: set block(
    above: 0.5em,
    below: 1em,
  )

  show math.equation: set block(
    above: 1.5em,
    below: 1.5em,
  )

  show heading: set block(
    above: 0.5em,
    below: 0.5em,
  )

  show enum: set block(
    above: 1.05em,
    below: 1.05em,
  )

  show list: set block(
    above: 1.05em,
    below: 1.05em,
  )

  show math.equation: it => {
    h(0.2em) + it + h(0.2em)
  }

  show figure: set block(
    above: 1em,
    below: 1.5em,
  )

  // Set heading styles.
  set heading(numbering: "1.1 ")
  show heading: set text(
    weight: 640,
  )

  // Set 字下げ
  set par(
    first-line-indent: 1em,
    justify: true,
    leading: 1em,
  )

  show heading: it => {
    it
    par(text(size: 0pt, ""))
  }

  body

  
  if bibfile != "" {
    heading([参考文献])
    bibliography(bibfile, title: none)
  }
}

// box
#let cbox(title,txt) = showybox(
  title-style: (
    weight: 800,
    color: red.darken(15%),
    sep-thickness: 0pt,
    align: center
  ),
  frame: (
    title-color: red.lighten(80%),
    border-color: red.darken(30%),
    thickness: (left: 1pt),
    radius: 2pt
  ),
  title: title,
)[
  #txt
]

#let LaTeX = text(
  font: "Latin Modern Roman", 
  [
    L#h(-0.35em)#text(size: 0.725em, baseline: -0.25em)[A]#h(-0.125em)T#h(-0.175em)#text(baseline: 0.225em)[E]#h(-0.125em)X
  ]
)

// convert csv to table
//
// example
// #csv2table(csv("data/Pb_data.csv"), [鉛の厚みとエネルギースペクトルの関係], label: ("厚さ(cm)",$A$,$mu "(keV)"$,$sigma$,$I$))
//
#let csv2table(csv, caption, label: none, digits: 2) = {
  let csv_label = csv.first()
  let len = csv_label.len()

  let csved =()
  for row in csv.slice(1) {
    for s in row {
      if regex("\d+\.\d+") in s {
        let n = float(s)
        let round_n = calc.round(n, digits: digits)
        let str_n = str(round_n)
        csved = csved + (str_n,)
      } else {
        csved = csved + (s,)
      }
    }
  }

  let labeled = ()
  if label == none {
    for csv_l in csv_label {
      labeled = labeled + (strong(csv_l),)
    }
    figure(
      table(
        columns: (1fr, ) * len,
        ..labeled,
        ..csved,
      ),
      caption: caption,
    )
  } else {
    for l in label {
      labeled = labeled + (strong(l),)
    }
    figure(
      table(
        columns: (1fr, ) * len,
        ..labeled,
        ..csved,
      ),
      caption: caption,
    )
  }
}
