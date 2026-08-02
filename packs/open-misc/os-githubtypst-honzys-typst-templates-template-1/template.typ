#let kucharka(
  title: "",
  subtitle: "",
  author: "",
  highlight: 0,
  body,
) = {
  // Set the document's basic properties.
  set document(author: author, title: title)

  // Set body font family.
  set text(lang: "cs", 12pt)
  show heading: it => {
    if (it.level == 1) {
      v(0.3em)
      text(upper(it.body), weight: "bold", size: 18pt)
      v(-0.2em)
    }
    if (it.level == 2) {
      text(it.body, weight: "bold", size: 15pt)
      v(-0.3em)
    }
  }

  // Set styles
  show link: it => underline(text(fill: rgb("#114499"), it))
  set list(marker: ("●", "o", "o", "o"), body-indent: 1em, indent: 1em)

  set page(
    margin: (
      top: 1.5cm,
      bottom: 1.5cm,
      left: 1.5cm,
      right: 1.5cm
    ),
    paper: "a4",
  )

  set par(justify: false)

  body
}

#let peopleAmounts = (1, 5, 10, 15, 20, 30, 40, 50, 60, 70, 80)
#let highlight = 70

#let ingredient(name, amount, unit, people) = {
  let perPerson = amount / people
  // Add table cells for each amount of people.
  (name, 
  ..peopleAmounts.map(it => {
    let total = it * perPerson
    let color = white
    if (it == highlight) {
      color = rgb("#ffe98f")
    }
    table.cell(str(perPerson * it) + " " + unit, fill: color)
  }))
}

#let recipe(name, ingredients, instructions) = {
  heading(name, depth: 1)
  heading("Suroviny", depth: 2)
  let content = ()
  if (type(ingredients.at(0)) == "array") {
    content = ingredients.map(it => ingredient(..it)).flatten()
  } else {
    content = ingredient(..ingredients)
  }
  table(
    columns: (2fr, ..peopleAmounts.map(it => 1fr)),
    table.header(
      [*Surovina*],
      ..peopleAmounts.map(it => {
        let color = white
        if (it == highlight) {
          color = rgb("#ffd321")
        }
        table.cell([*#str(it)*], fill: color)
      })
    ),
    ..content
  )
  heading("Postup", depth: 2)
  instructions
}