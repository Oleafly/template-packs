// An implementation of the LaTeX `nameref` function in Typst
// Example usage: #nameref(<ch:literature:review>)
#let nameref(label) = {
  context {
    // Search for item referenced by the label
    let elems = query(label)
    if (elems.len() == 0) {
      panic("#nameref: label <" + str(label) + "> not found")
    } else if (elems.len() > 1) {
      panic("#nameref: label <" + str(label) + "> is not unique")
    }

    let item = elems.first()
    let linkText

    if (item.func() == heading) { // Normal heading detected
      if (item.body == none or not item.body.has("text")) {
        panic("#nameref: heading referenced by <" + str(label) + "> has no name")
      }
      linkText = item.body.text

    } else if (item.func() == figure) { // Figure detected
      if (not item.has("caption") and not item.caption != none) {
        panic("#nameref: figure referenced by <" + str(label) + "> has no caption to be displayed")
      }
      let itemBody = item.caption.body

      if (itemBody.has("text")) { // Only one caption
        linkText = item.caption.body.text
      } else if (itemBody.has("children")) { // Multiple captions separated by a double space
        // Use first caption
        let firstChild = itemBody.children.at(0)

        if (not firstChild.has("text")) {
          panic("#nameref: figure referenced by <" + str(label) + "> has multiple captions but first caption is empty")
        }
        linkText = firstChild.text
      } else {
        panic("#nameref: figure referenced by <" + str(label) + "> has unsupported caption to be displayed")
      }

    } else {
      panic("#nameref: item referenced by <" + str(label) + "> is not a heading or figure")
    }
    let link = link(label, linkText)
    link
  }
}

// Output code samples with line numbers
// Example usage: #displaycode(read("../figures/BubbleSort.java"), "java", textsize: 9pt)
#let displaycode(file,lang, textsize: 10pt) = {
  show raw: it => {
    set par(justify: false)
    let line_count = 0
    set text(size: textsize)
    align(
      left,
      block(
        radius: 1em,
        fill: luma(246),
        width: auto,
        inset: 1em,
        for line in it.lines {
          box(width: 0pt, align(right, str(line_count + 1) + h(2em)))
          line
          linebreak()
          line_count += 1;
        }
      )
    )
  }
  raw(file, lang: lang)
}
