// Mini table of contents for the current chapter
// Shows headings within the current level 1 heading (chapter)

#import "template/lib.typ": prune

#let minitoc(
  title: [Contents],
  depth: 3,
  indent: 1.5em,
  fill: repeat[.],
  show-title: true,
) = {
  context {
    // Get all headings in the document
    let all-headings = query(heading)

    // Find the current chapter (level 1 heading before current position)
    let current-loc = here()
    let before-headings = query(selector(heading).before(current-loc))

    // Find the most recent level 1 heading (chapter)
    let chapter-headings-before = before-headings.filter(h => h.level == 1)

    if chapter-headings-before.len() == 0 {
      return
    }

    let current-chapter = chapter-headings-before.last()
    let chapter-loc = current-chapter.location()

    // Find the next level 1 heading (next chapter) to define the boundary
    let after-chapter-headings = query(selector(heading).after(chapter-loc))
    let next-chapters = after-chapter-headings.filter(h => h.level == 1 and h.location() != chapter-loc)
    let next-chapter = if next-chapters.len() > 0 { next-chapters.first() } else { none }

    // Get all headings in the current chapter
    let chapter-headings = if next-chapter != none {
      all-headings.filter(h => {
        let h-loc = h.location()
        let h-pos = h-loc.position()
        let chapter-pos = chapter-loc.position()
        let next-pos = next-chapter.location().position()

        // Heading must be after chapter start and before next chapter
        // and not be the chapter heading itself, and within depth
        let in-depth = h.level > 1 and h.level <= depth
        let after-chapter = (
          h-pos.page > chapter-pos.page or (h-pos.page == chapter-pos.page and h-pos.y > chapter-pos.y)
        )
        let before-next = h-pos.page < next-pos.page or (h-pos.page == next-pos.page and h-pos.y < next-pos.y)

        in-depth and after-chapter and before-next
      })
    } else {
      // No next chapter, get all remaining headings after current chapter
      all-headings.filter(h => {
        let h-loc = h.location()
        let h-pos = h-loc.position()
        let chapter-pos = chapter-loc.position()

        let in-depth = h.level > 1 and h.level <= depth
        let after-chapter = (
          h-pos.page > chapter-pos.page or (h-pos.page == chapter-pos.page and h-pos.y > chapter-pos.y)
        )

        in-depth and after-chapter
      })
    }

    // If no headings found, return nothing
    if chapter-headings.len() == 0 {
      return
    }

    // Build the mini table of contents
    block(
      width: 100%,
      inset: (x: 1em, y: 0.5em),
      stroke: (left: 2pt + prune),
    )[
      #if show-title [
        #text(weight: "bold", size: 12pt, fill: prune)[#title]
        #v(0.5em)
      ]

      #for entry in chapter-headings [
        #let level = entry.level
        #let indent-amount = (level - 2) * indent
        #let page-num = entry.location().page()
        #let numbering-val = if entry.numbering != none {
          numbering(entry.numbering, ..counter(heading).at(entry.location()))
        } else {
          none
        }

        #box(width: 100%)[
          #h(indent-amount)
          #link(entry.location())[
            #text(fill: black)[
              #if numbering-val != none [#numbering-val ]
              #entry.body
            ]
            #box(width: 1fr, fill)
            #text(fill: black)[#page-num]
          ]
        ]
        #v(0.3em)
      ]
    ]
  }
}
