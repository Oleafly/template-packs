/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#let ex = 5pt

#let frontmatter-heading = heading.with(numbering: none, outlined: false, bookmarked: true)

#let normalize-multivalue(value) = {
  if value == none { return none }
  if type(value) == array { return value }
  return (value,)
}

#let heading-number(c) = {
  if c.numbering == none { return none }
  return numbering(c.numbering,..counter(heading).at(c.location()))
}

#let current-heading(level: 1) = {
  let before = query(selector(heading.where(level: level)).before(here()))
  before = if before.len() > 0 { before.last() } else { none }
  let after = query(selector(heading.where(level: level)).after(here()))
  after = if after.len() > 0 { after.first() } else { none }

  if level == 1 {
    let isChapterPage = after != none and after.location().page() == here().page() or after == none and before != none and before.location().page() == here().page()
    if not isChapterPage and before != none { return before }
    return none
  } else {
    let chap = current-heading()
    if chap == none or before == none { return none }
    let chap-num = counter(heading).at(chap.location()).at(0)
    let heading-chap-num = counter(heading).at(before.location()).at(0)
    if chap-num == heading-chap-num and chap.numbering == before.numbering { return before }
  }
}
