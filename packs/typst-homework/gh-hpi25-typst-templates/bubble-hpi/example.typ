#import "template.typ": *

#set outline(title: "Table of contents")

#show: bubble.with(
  title: "Bubble HPI template",
  subtitle: "Simple and colorful template for HPI",
  authors: "Authors",
  affiliation: "Affiliation",
  // date: datetime.today().display(),
  year: "Year",
  class: "Class",
  other: ("Made with Typst", "https://typst.com"),
  // logo: image("assets/logo_full.svg"), //set the logo
)

// Edit this content to your liking

= Introduction

This is a simple template that can be used for a report.

= Features
== Colorful items

- These bullet
- points
- are colored

+ It also
+ works with
+ numbered lists!

== Customized items


Figures are customized but this is settable in the template file. You can of course reference them  : @ref.

#figure(caption: [Code example], ```rust
fn main() {
  println!("Hello Typst!");
}
```)<ref>

#pagebreak()

= Enjoy !

#lorem(100)
