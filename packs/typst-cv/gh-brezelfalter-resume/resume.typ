#import "versions/template-example.typ": *

#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm),
)

#set text(
  size: 12pt,
  font: "Arial",
)

#grid(
  columns: (28%, 0pt, 72%),
  column-gutter: 20pt,
  row-gutter: 14pt,

  // left corner
  image(personal_details.picture_file, height: 6cm),

  // line at left side of middle column
  grid.vline(stroke: (paint: rgb("#4a7ebb"), thickness: 1.5pt)),
  [],

  // right corner
  [
    = #personal_details.first_name #personal_details.last_name
    #personal_details.date_of_birth \

    #personal_details.street #personal_details.number \
    #personal_details.postal_code #personal_details.city \

    *Tel.:* #personal_details.phone \
    *Email:* #personal_details.email \
  ],

  ..for entry in entries {
    entry
  },
)
