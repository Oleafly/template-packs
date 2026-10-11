/// #mail
///
/// - email (str): the email address of the author
/// -> (block): a block containing the email address
#let mail(email) = {
  text(size: 1.2em)[#raw(email)]
}

/// 
/// - name (str): the name of the author
/// -> (block): a block containing the name of the author
#let first_author(name) = {
  strong(name)
}

/// #author_list
///
/// - authors (list of tuples): a list of tuples containing names and emails
/// -> (block): a block containing the authors' information
#let author_list(authors, logo: none, width: 35%) = block[
  #table(
    inset: (0em, 0em), column-gutter: 1em, row-gutter: 0.75em, stroke: none, columns: (auto, 4fr), align: (left, left),
    ..authors.map((record) => (record.at(0), mail(record.at(1)))).flatten()
  )
  #if logo != none {
    place(right)[
      #figure(image(logo, width: width))
    ]
  }
  #v(1em)
]

/// 
///
/// - title (str): the title of block
/// - icon (): optional icon
/// - color (): the color of the block 
/// - content (): the content of the block
/// -> 
#let feature-block(title, icon: "", color: rgb("#23373b"), content) = {
  block(
    width: 100%,
    inset: (x: 1em, y: 1em),
    fill: color.lighten(90%),
    radius: 1em,
    stroke: (
      paint: color.lighten(50%), 
      thickness: 1pt,
      dash: "solid"
    ),
    [
      #text(weight: "bold", size: 20pt)[#icon #title]
      #v(-0.55em)
      #line(length: 100%, stroke: (paint: color.lighten(50%), thickness: 1.5pt))
      #v(-0.55em)
      #content
    ]
  )
}
