#import "template/lib.typ": prune
#import "@preview/colorful-boxes:1.4.1": colorbox

#let contribution(body) = {
  block(breakable: false)[
    #colorbox(
      title: text(font: "New Computer Modern")[Contribution],
      radius: 2pt,
      width: auto,
      box-colors: (
        prune: (stroke: prune, fill: white, title: white),
      ),
      color: "prune",
    )[
      #body
      #v(2pt)
    ]
  ]
}

#let definition(title: "Definition", body) = {
  block(breakable: false)[
    #colorbox(
      title: text(font: "New Computer Modern")[#title],
      radius: 2pt,
      width: auto,
      box-colors: (
        blue: (stroke: rgb(0, 102, 204), fill: white, title: white),
      ),
      color: "blue",
    )[
      #body
      #v(2pt)
    ]
  ]
}

#let insight(title: "Key Insight", body) = {
  block(breakable: false)[
    #colorbox(
      title: text(font: "New Computer Modern")[#title],
      radius: 2pt,
      width: auto,
      box-colors: (
        orange: (stroke: rgb(255, 153, 51), fill: white, title: white),
      ),
      color: "orange",
    )[
      #body
      #v(2pt)
    ]
  ]
}
#let advice(title: "Advice", body) = {
  block(breakable: false)[
    #colorbox(
      title: text(font: "New Computer Modern")[#title],
      radius: 2pt,
      width: auto,
      box-colors: (
        orange: (stroke: rgb("#33ffd3"), fill: white, title: white),
      ),
      color: "orange",
    )[
      #body
      #v(2pt)
    ]
  ]
}


#let example_box(title: "Example", body) = {
  block(breakable: false)[
    #colorbox(
      title: text(font: "New Computer Modern")[#title],
      radius: 2pt,
      width: auto,
      box-colors: (
        green: (stroke: rgb(0, 153, 76), fill: white, title: white),
      ),
      color: "green",
    )[
      #body
      #v(2pt)
    ]
  ]
}

#let theorem(title: "Theorem", body) = {
  block(breakable: false)[
    #colorbox(
      title: text(font: "New Computer Modern")[#title],
      radius: 2pt,
      width: auto,
      box-colors: (
        red: (stroke: rgb(204, 0, 0), fill: white, title: white),
      ),
      color: "red",
    )[
      #body
      #v(2pt)
    ]
  ]
}

#let future_work(title: "Future Work", body) = {
  block(breakable: false)[
    #colorbox(
      title: text(font: "New Computer Modern")[#title],
      radius: 2pt,
      width: auto,
      box-colors: (
        purple: (stroke: rgb(128, 0, 128), fill: rgb(250, 245, 255), title: white),
      ),
      color: "purple",
    )[
      #body
      #v(2pt)
    ]
  ]
}
