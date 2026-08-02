#let apply-template(body, name: "", class: "", term: "", title: "") = {
  set page(
  paper: "us-letter",
  header: [
    #text(class)
    #h(1fr)
    #text(term)\
    #text(title)
    #h(1fr)
    #text(name)
    #line(length: 100%)
  ],
  margin: (
    left: 1cm,
    right: 1cm,
  ),
  numbering: "1",
)
set enum(full: true, numbering: (..n) => {
  let a = n.pos().len()
  while a > 3{
    a -= 3
  }
	let format = if a > 2 {"i)"} else if a > 1 {"a."} else {"1."}
	numbering(format, n.pos().last())
})

  body
}
