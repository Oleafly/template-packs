#let balanced-cols(n-cols, gutter: 11pt, body) = layout(bounds => context {
  // Measure the height of the container of the text if it was single 
  // column, full width
  let textHeight = measure(box(
    width: (bounds.width - (n-cols - 1) *  gutter) / n-cols,
    body
  )).height

  // Recompute the height of the new container. Add a few points to avoid the 
  // second column being longer than the first one
  let balanced-height = (1/n-cols) * textHeight + 0.5 * text.size

  box(
    height: balanced-height, 
    columns(n-cols, gutter: gutter, body)
  )
})

// from https://github.com/typst/typst/issues/6644
#let pdf-number-pages(filename) = {
        let data = read(filename, encoding: none)
        let dict-start-pattern = bytes("<<")
        let type-pattern = bytes("/Type")
        let type-pages-pattern-one = bytes("/Type /Pages")
        let type-pages-pattern-two = bytes("/Type/Pages")
        let count-pattern = bytes("/Count")

        let last-dict-start-idx = 0
        let page-count = -1
        for idx in range(data.len()-50) {
            if data.at(idx) == 60 and data.slice(idx, count: dict-start-pattern.len()) == dict-start-pattern {
                last-dict-start-idx = idx
            } else if data.at(idx) == 47 and data.slice(idx, count: type-pattern.len()) == type-pattern {
                if data.slice(idx, count: type-pages-pattern-one.len()) == type-pages-pattern-one or data.slice(idx, count: type-pages-pattern-two.len()) == type-pages-pattern-two {
                    // we are in the pdf object that defines the total page number
                    for idx in range(last-dict-start-idx, data.len()-50) {
                        if data.at(idx) == 47 and data.slice(idx, count: count-pattern.len()) == count-pattern {
                            let idx-count-start = idx + count-pattern.len()
                            // now find the next "/" or ">"
                            for idx in range(idx-count-start, data.len()-50) {
                                if data.at(idx) == 47 or data.at(idx) == 62 {
                                    page-count = int(str(data.slice(idx-count-start, idx)).trim())
                                    break
                                }
                            }
                            break
                        }
                    }
                    break
                  }
            }

        }
        page-count
    }



// adapted from https://forum.typst.app/t/how-can-i-insert-content-from-a-pdf-into-my-document/476
#let import-pdf(pdf_path) = {
  let nb_pages = pdf-number-pages(pdf_path)
  //reset styles for the pages here
  set page(numbering: none, footer: none, header: none, /* ... */)
  for p in range(1, nb_pages+1) {
    // using `page` to ensure each included page is it's own page
    // using `page.background` to ensure we use the margins too
    page(background: image(pdf_path,
  page: p ))[]
  
  }
}
