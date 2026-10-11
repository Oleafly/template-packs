// Function to define the header of the resume
#let header(name, contacts) = {
  text(size: 25pt, align(center, [#name]))
  v(8pt, weak: true)
  text(
    align(
      center,
      [
        #(
          contacts
            .map(contact => {
              if contact.at("type", default: none) == "email" {
                link("mailto:" + contact.url)[#contact.display]
              } else {
                link(contact.url)[#contact.display]
              }
            })
            .join([ | ])
        )
      ],
    ),
  )
  v(25pt, weak: true)
}

// Function definition to render the roles
#let role(name, company, location, start, end) = {
  grid(columns: (auto, 1fr), [#text(strong(name), size: 12pt), #company -- #location], grid.cell(
      align(right, [#start\-#end]),
    ))
}

// Function to define the section of the resume
#let section(body) = {
  text(size: 15pt)[#body]
  v(4pt, weak: true)
  line(length: 100%, stroke: 1pt)
  v(6pt, weak: true)
}

#let experience(designation, company, location, start, end, pointers) = {
  role(designation, company, location, start, end)
  for pointer in pointers {
    [- #pointer #linebreak()]
  }
}

// Function to render the academic entries
#let academic(name, degree, subject, start, end) = {
  grid(columns: (auto, 1fr), [*#name* - #degree in #subject], grid.cell(align(right, [#start\-#end])))
}
