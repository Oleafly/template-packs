#let current_heading() = {
  let headings_selector = selector(heading.where(level: 1))
  let headings = query(headings_selector)
  let heading = headings.rev().find(h => h.location().page() <= here().page())
  heading
}

#let chapter(
  alphabet_header: false,
  doc,
) = {
  let title = "OK"


  set page(
    header: context {
      let heading = current_heading()
      if heading == none {
        // no-op
      } else {
        let title = heading.body.text
        let h_loc = heading.location().page()
        if (h_loc == here().page()) {
          // no-op
        } else {
          box(
            stroke: (
              bottom: black,
            ),
            inset: (
              bottom: 6pt,
            ),
          )[
            #title
            #h(1fr)
            #counter(page).display()
          ]
        }
      }
    },
  )


  v(110pt)

  let chapter_i = counter("chapter")
  chapter_i.step()
  context {
    let heading = current_heading()
    let first_letter = heading.body.text.at(0)
    let chapter_num = chapter_i.display("1")

    align(right)[
      #block[
        #text(size: 120pt, font: "Nimbus Sans", weight: "bold", fill: rgb("#b3b3b3"))[
          #if alphabet_header [#first_letter] else [#chapter_num]
        ]
      ]
    ]
  }


  doc
}
