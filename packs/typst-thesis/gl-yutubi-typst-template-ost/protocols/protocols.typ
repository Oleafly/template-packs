#import "../lib/lib.typ": colors, heading-size-depth-5, text-size
#import "@preview/cmarker:0.1.2"

// Enter file names of the protocol markdown files here
#let protocols = (
  "YYYY_MM_DD.md",
)

#show heading: it => {
  text(size: heading-size-depth-5, it.body)
  linebreak()
}

#show heading.where(level: 2): it => {
  text(size: text-size, it.body)
  linebreak()
}

#show heading.where(level: 3): it => {
  text(size: text-size, it.body)
  linebreak()
}

#set heading(outlined: false)

#show strong: it => {
  text(size: heading-size-depth-5, weight: 600, it.body)
}

#show link: it => {
  highlight(
    [
      #underline(offset: 0.7mm, stroke: colors.link-underline, it)
    ],
    fill: colors.table,
  )
}

#show ref: it => {
  highlight(
    [
      #underline(offset: 0.7mm, stroke: colors.link-underline, it)
    ],
    fill: colors.table,
  )
}

#for (i, file) in protocols.enumerate() {
  box(
    pad(5mm, cmarker.render(read(file))),
    fill: colors.table,
  )

  if i != protocols.len() {
    v(5mm)
  }
}
