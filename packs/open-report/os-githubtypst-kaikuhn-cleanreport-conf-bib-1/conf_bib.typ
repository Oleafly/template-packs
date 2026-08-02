
// apply bib config

#let conf_bib(body) = {
  
  // heading
  // show heading.where(level: 1): it => {
  //   set text(fill: blue.darken(30%))
  //   it
  //   v(1em)
  // }

  // format entries
  show bibliography: set text(size: 10pt)

  body
}