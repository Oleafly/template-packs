// Contains general macros to be used across the template

#let uqHeaderSize = 26pt
#let topPadding = 4em
#let bottomPadding = 1em

#let uqHeaderNoChapter(it) = {
    align(right)[
        #v(topPadding)

        #text(uqHeaderSize)[* #it.body * ]

        #v(bottomPadding)
    ]
}

#let uqHeaderChapter(it) = {
    align(right)[
        #v(topPadding)

        #text(uqHeaderSize * 2)[* #counter(heading).display("1") *]

        #v(-40pt)

        #text(uqHeaderSize)[ #it.body ]

        #v(bottomPadding)
    ]
}

#let appendices(content) = {
    set heading(numbering: (..numbers) => {
        return "Appendix " + numbering("A.1", ..numbers)
    })
    show heading.where(level: 1): it => {
        v(topPadding)
        text(uqHeaderSize)[* #counter(heading).display(it.numbering) #it.body *]
        v(bottomPadding)
    }
    counter(heading).update(0)
    content
}

// source: https://github.com/Pablo-Gonzalez-Calderon/chic-header-package/blob/f0522bac01edbe1a54f144d48f0e25c5ff75e650/lib/functions.typ#L220
/*
 * chic-heading-name
 *
 * Returns the next heading name in the `dir` direction. The
 * heading must has a lower or equal level than `level`. If
 * there're no more headings in that direction, and `fill` is
 * ``true``, then headings are seek in the other direction.
 *
 * Parameters:
 * - dir: Direction for searching the next heading: "next" (get
 *        the next heading from the current page) or "prev" (get
 *        the previous heading from the current page).
 * - fill: If there's no headings in the `dir` direction, try to
 *         get a heading in the opposite direction.
 * - level: Up to what level of headings should this function
 *          search
 */
#let chic-heading-name(dir: "next", fill: false, level: 2) = context {
  let loc = here()
  let headings = array(()) // Array for storing headings

  // Get all the headings in the given direction
  if dir == "next" {
    headings = query(
      selector(heading).after(loc)
    ).rev()
  } else if dir == "prev" {
    headings = query(
      selector(heading).before(loc)
    )
  }

  // If no headings were found, try the other direction if `fill` is true
  if headings.len() == 0 and fill {
    if dir == "next" {
      headings = query(
        selector(heading).before(loc)
      )
    } else if dir == "prev" {
      headings = query(
        selector(heading).after(loc)
      ).rev()
    }
  }

  // Now, get the proper heading (i.e. right ``level`` value)
  // until the headings array is empty
  let found = false
  let return-heading = none
  while not found and headings.len() > 0 {
    return-heading = headings.pop()

    // Check the level of the fetched heading
    if return-heading.level <= level {
      found = true
    }
  }

  if found {
    return return-heading.body
  } else {
    return
  }
}

#let fancy-header() = context {
    // https://forum.typst.app/t/how-to-determine-if-the-current-page-has-a-heading-of-level-1/4185
    let current-page = here().page() // Get number of page
    let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == current-page)

    if (not has-heading) {
        smallcaps(chic-heading-name(level: 1, dir: "prev"))
        v(-5pt)
        line(length: 100%)
    }
}
