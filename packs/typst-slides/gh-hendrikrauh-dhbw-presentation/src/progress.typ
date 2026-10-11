#import "@preview/touying:0.7.4": utils
#import "palette.typ": *

/// Placed on the title slide: the footer progress skips these pages.
#let title-marker = [#metadata((kind: "dhbw-title")) <dhbw-title>]

/// Placed on a chapter slide (`chapter-slide`): skipped like the title slide.
#let chapter-marker = [#metadata((kind: "dhbw-chapter")) <dhbw-chapter>]

/// Progress of the current page: `(items, current-index)` or `none` (deck
/// without level-1 headings, or an appendix page). Call inside `context`.
#let _progress-data() = {
  let sections = query(heading.where(level: 1, outlined: true))
  let current-page = here().page()
  let topics = query(heading.where(level: 1))
  let in-appendix = topics.any(it => (
    not it.outlined and it.location().page() <= current-page
  ))
  if sections == () or in-appendix {
    none
  } else {
    // Every level-1 heading closes the previous topic, appendix included.
    let boundaries = topics.map(it => it.location().page())
    // Skip slides before the first topic and the transition pages.
    let first-page = sections.first().location().page()
    let skip-pages = (
      query(<dhbw-title>).map(it => it.location().page())
        + query(<dhbw-chapter>).map(it => it.location().page())
    )
    let slides = query(<touying-metadata>).filter(it => (
      utils.is-kind(it, "touying-new-slide")
        and it.location().page() >= first-page
        and it.location().page() not in skip-pages
    ))
    if slides == () {
      none
    } else {
      // one group of slides per topic
      let groups = ()
      for section in sections {
        let start = section.location().page()
        let end = boundaries
          .filter(page => page > start)
          .at(0, default: calc.inf)
        groups.push(slides.filter(slide => {
          let page = slide.location().page()
          page >= start and page < end
        }))
      }

      // flatten to (slide, group index) keeping the document order
      let items = ()
      for (index, group) in groups.enumerate() {
        for slide in group {
          items.push((slide, index))
        }
      }

      let current-index = -1
      for (index, pair) in items.enumerate() {
        if pair.first().location().page() <= current-page {
          current-index = index
        }
      }
      (items, current-index)
    }
  }
}

/// Progress rendered as dots, grouped by topic: one dot per logical slide
/// (`#pause` subslides share it), red = current, grey = visited, faint = to
/// come, other topics dimmed. Every dot links to its slide.
///
/// Returns `none` before the first topic or on an appendix page.
///
/// - active, visited, future (color, auto): dot colours.
/// - radius (length): dot radius.
/// - gap, group-gap (length): gaps inside and between topics.
#let progress-dots(
  active: auto,
  visited: auto,
  future: auto,
  radius: .2em,
  gap: .5em,
  group-gap: 1.3em,
) = context {
  let active = if active == auto { dhbw-red } else { active }
  let visited = if visited == auto { dhbw-gray } else { visited }
  let future = if future == auto { dhbw-gray-faint } else { future }

  let data = _progress-data()
  let current-page = here().page()
  if data == none {
    none
  } else {
    let (items, _) = data
    let current-group = -1
    for (index, pair) in items.enumerate() {
      if pair.first().location().page() <= current-page {
        current-group = pair.last()
      }
    }

    let parts = ()
    let last-group = -1
    for (index, pair) in items.enumerate() {
      let (slide, group) = pair
      if last-group != -1 {
        parts.push(h(if group == last-group { gap } else { group-gap }))
      }
      last-group = group

      let page = slide.location().page()
      let next-page = if index + 1 < items.len() {
        items.at(index + 1).first().location().page()
      } else {
        calc.inf
      }
      let state = if current-page < page {
        "future"
      } else if current-page < next-page {
        "active"
      } else {
        "visited"
      }
      let in-focus = group == current-group
      let fill = if state == "active" {
        active
      } else if state == "visited" {
        if in-focus { visited } else { visited.lighten(45%) }
      } else {
        if in-focus { future } else { future.lighten(35%) }
      }
      parts.push(link(slide.location(), box(circle(
        radius: radius,
        fill: fill,
      ))))
    }
    parts.sum()
  }
}

/// Slide number in red as a footer indicator: every logical slide after the
/// title counts, chapter slides count silently, `#pause` subslides keep the
/// number of their slide (the dots count per topic, so the two can differ).
///
/// Returns `none` before the first counted slide.
///
/// - fill (color, auto): colour of the number.
#let slide-number(fill: auto) = context {
  let fill = if fill == auto { dhbw-red } else { fill }
  let current-page = here().page()
  let title-pages = query(<dhbw-title>).map(it => it.location().page())
  let slides = query(<touying-metadata>).filter(it => (
    utils.is-kind(it, "touying-new-slide")
      and it.location().page() not in title-pages
  ))
  if slides == () {
    none
  } else {
    let current-index = -1
    for (index, slide) in slides.enumerate() {
      if slide.location().page() <= current-page {
        current-index = index
      }
    }
    if current-index < 0 { none } else {
      text(fill: fill, weight: "semibold", str(current-index + 1))
    }
  }
}
