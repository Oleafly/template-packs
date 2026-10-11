#let buildMainHeader(mainHeadingContent) = {
  align(center, smallcaps(mainHeadingContent))
  line(length: 100%)
}

#let buildSecondaryHeader(mainHeadingContent, secondaryHeadingContent) = {
  smallcaps(mainHeadingContent)
  h(1fr) 
  emph(secondaryHeadingContent)
  line(length: 100%)
}


#let abstract_style(body) = {
  align(center, text(weight: "bold",size:14pt)[#smallcaps("Abstract")])
  pad(x: 2em)[
    #set par(justify: true, first-line-indent: 2pt)
    #body
  ]
  v(1em)
}

// To know if the secondary heading appears after the main heading
#let isAfter(secondaryHeading, mainHeading) = {
  let secHeadPos = secondaryHeading.location().position()
  let mainHeadPos = mainHeading.location().position()
  if secHeadPos.at("page") > mainHeadPos.at("page") {
    true
  } else if secHeadPos.at("page") == mainHeadPos.at("page") {
    secHeadPos.at("y") > mainHeadPos.at("y")
  } else {
    false
  }
}

#let getHeader()  =  {
  let loc = here()
  // Find if there is a level 1 heading on the current page
  let nextMainHeading = query(selector(heading).after(loc))
    .find(headIt => headIt.location().page() == loc.page() and headIt.level == 1)
  if (nextMainHeading != none) {
    buildMainHeader(nextMainHeading.body)
  } else {
    // Find the last previous level 1 heading
    let lastMainHeading = query(selector(heading).before(loc))
      .filter(headIt => headIt.level == 1)
      .last()
    // Find any previous secondary headings (> level 1)
    let previousSecondaryHeadingArray = query(selector(heading).before(loc))
      .filter(headIt => headIt.level > 1)
    let lastSecondaryHeading = if (previousSecondaryHeadingArray.len() != 0) {
        previousSecondaryHeadingArray.last()
      } else {
        none
      }
    // Check if the last secondary heading comes after the last main heading
    if (lastSecondaryHeading != none and isAfter(lastSecondaryHeading, lastMainHeading)) {
      buildSecondaryHeader(lastMainHeading.body, lastSecondaryHeading.body)
    } else {
      buildMainHeader(lastMainHeading.body)
    }
  }
}


#let project(
  title: "",
  abstract: [],
  authors: (),
  logo: "笔记本.jpg",
  body
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set text(font: ("New Computer Modern","Songti SC"),size: 10pt)
  // show math.equation: it => set text(weight: 400)
  set heading(numbering: "1.1")
  set par(justify: true)

// Logo
  // if logo != none{
  //   v(1em)
  //   align(center, image(logo, width: 50%))
  //   v(3em)
  // } else {
  //   v(0.75fr)
  // }
  // Title page.
  // v(0.25fr)
  v(0.6fr)
  align(center,text(2em, weight: 700, title))

  // Author information.
  pad(
    top: 0.7em,
    grid(
      columns: (1fr),
      gutter: 1em,
      ..authors.map(author => 
        align(center,
          [
            _#author.name _ \ 
            _#author.email _ \ 
            _#author.affiliation _\ 
            _#author.phone _
          ]
        )
      )
    )
  )
  v(1fr)
  pagebreak()

  v(1fr)
  abstract_style[#abstract]
  v(1fr)
  pagebreak()
  outline(depth: 3)

  // Main body.
  set page(numbering: "1", number-align: center, margin: auto)
  set par(first-line-indent: 20pt)
  //set page(header: context getHeader())
  //counter(page).update(1)
  body
}
