#show link: underline
#set page(
  paper: "us-letter",
  margin: 0pt,
  background: image("images/cover.jpg", width: 101%),
)
#v(26cm)
#h(7cm)
#place(left, dx: 4.5cm)[
  #set text(font: "Roboto", size: 10pt)
  #align(center)[
    *CONFIDENCIAL* \
    Copyright © Desec Security \
    #link("(https://www.desecsecurity.com)")
  ]
]
