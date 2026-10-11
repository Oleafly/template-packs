#import "template.typ": template, split_content

// Usage:
// Set title to the short form of project title if applicable, and full_title for the whole thing.
// Set name to your name
// Set roll number to your roll no
// Set guide_name to the Name of your guide
// Set guide_designation to the Designation of your guide
// Presently, there is one change I have made, that that you cannot include the name of your company mentor in the certificate on page 3, because eh
// If you want a dedication page, set dedication_text as true, and make this your first page in the document. END THE PAGE WITH AN explicit pagebreak()
// The next important page is the acknowledgments page. Write howmuchever you want, but to indicate that it is over, use an explicit pagebreak
// The next important page is the abstact. Write howmuchever you want, but to indicate that it is over, use an explicit pagebreak
// The Table of Content should be filled automatically
// If you have content for the list of symbols, set list_of_symbols as true. 
// Every section will be considered a new chapter. You may name them as you wish
#show: template.with(
  title: "The Trials and Tribulations of Trevor ",
  name: "Trevor"
  )

// Dedication page
I dedicate this to your mom

#pagebreak()

//Acknowledgments Page

It gives me a sense of fulfillment to write few words to acknowledge people…

#pagebreak()

// Abstract Page

/ Keywords: High energy ball milling; Spark plasma sintering; Densification mechanisms; Transmission electron microscopy.

The present work ...

#pagebreak()

= List of symbols


#table(columns: (1fr, 1fr),  ..(split_content("|")[
  $F$ | Force |
  $F_x$ | Horizontal Force | ...
]))

#pagebreak()

= Introduction

== Introduction

A final destination like thing!

#lorem(100)

= Literature Review

== Introduction
#lorem(100)

// Wrap images in figures so that it is present in the table of content
#figure(
  image("images/weird_image.png"),
  caption: "Endoscopic Capsule"
)

= References

= Appendix