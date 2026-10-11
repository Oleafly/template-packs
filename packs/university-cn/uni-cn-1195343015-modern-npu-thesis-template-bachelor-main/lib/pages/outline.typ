#import "../deps.typ": outrageous

// 目录页
#let outline-page(
  title: none,
  indent: none,
  weight: none,
  fill: none,
  vspace: none,
  gap: none,
) = {
  [
    #heading(level: 1, outlined: false, title)

    #set outline(indent: level => indent.slice(0, calc.min(level + 1, indent.len())).sum())
    #show outline.entry: entry => {
      let entry-page-number = counter(page).at(entry.element.location()).first()
      let in-mainmatter-or-later = query(
        selector(label("__nwpu_mainmatter_start__")).before(entry.element.location()),
      ).len() > 0
      let page-display = if not in-mainmatter-or-later {
        numbering("I", entry-page-number)
      } else {
        numbering("1", entry-page-number)
      }
      let is-abstract = entry.element.body == [*Abstract*]

      outrageous.show-entry(
        entry,
        font: (auto,),
        font-weight: weight,
        fill: fill,
        vspace: vspace,
        gap: gap,
        fill-right-pad: 0em,
        fill-align: false,
        body-transform: (level, prefix, body) => {
          if is-abstract { [ABSTRACT] }
        },
        page-transform: (level, page) => {
          set text(weight: "regular")
          page-display
        },
      )
    }

    #outline(title: none, depth: 3)
  ]
}
