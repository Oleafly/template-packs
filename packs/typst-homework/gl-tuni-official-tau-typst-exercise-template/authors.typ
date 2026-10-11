//
// authors.typ
//
// Write the list of authors into the list of authors
// in this file using the imported authorFn. The list is
// imported in the main file for you.
//

#import "template.typ": authorFn

#let authors = (
  authorFn(
    name: "Firstname Lastname",
    organization: "Tampere University",
    email: "email@tuni.fi"
  ),
)
