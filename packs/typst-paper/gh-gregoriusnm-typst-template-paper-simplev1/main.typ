#set page(numbering: "1")

#let title = [This Is A Typst Template]
#let chaptername() = context {
  let here_loc = here()
  let headings =query(heading.where(level:1).before(here_loc))
  let h = headings.last()
  if h == none { "" } else { h.body }}

#set text(font: "New Computer Modern", size: 13pt)
#set page(margin: (x:2cm, y:3cm), header: context {
  align(center)[*#title*]
  line(length: 100%,)})
#set page(
  footer: context { line(length: 100%)
    grid(columns: (1fr, 1fr),
    align(left)[#chaptername()],
    align(right)[#counter(page).display()],)})
    
// End of Styling

= Heading 1

#lorem(100) /*Lorem here is just giving the Lorem text, remove and replace the Lorem with your own content - needs.*/
\ \ #lorem(100) \
\ #lorem(100)

#pagebreak()

= Heading 2
#lorem(100)
== Thanks For Taking Interest!
\ #lorem(150)
=== Truly A Beautiful Life
#lorem(100)
