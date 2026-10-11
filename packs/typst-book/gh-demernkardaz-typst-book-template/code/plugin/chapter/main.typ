#let pre-title = () => include "../../../book/pre-title.typ"
#let title = () => include "../../../book/title.typ"
#let frontmatter = () => include "../../../book/frontmatter.typ"

#let read(..args) = {
  let items = args.pos()
  let i = 0
  while i < items.len() {
    let number = str(i + 1)
    let name = items.at(i)

    include(
      "../../../book/chapters/[" + str(number) + "] " + name + ".typ"
    )
    i = i + 2
  }
}

#pagebreak()
