/// Get the chapter number of the current page (requires context)
/// 
/// -> int
#let get_chapter_number() = {
  // Get the current chapter number
  // Note that this number may not be the same as the chapter number of the current page,
  // because the background renders before counting the heading. 
  let chapter_number = counter(heading).get().at(0)
  // Get the heading after the current location
  let next_chapters = query(
    heading.where(level: 1, outlined: true).after(here()),
  )

  if next_chapters.len() > 0 {
    let next_chapter_loc = next_chapters.first().location()
    // If the next chapter is on the same page as current page,
    // Set the chapter number to the next chapter number
    if here().page() == next_chapter_loc.page() {
      chapter_number = counter(heading).at(next_chapter_loc).at(0)
    }
  }
  chapter_number
}

/// Convert various types to string
///
/// -> str
#let to_string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to_string).join()
  } else if it.has("body") {
    to_string(it.body)
  } else if it == [ ] {
    " "
  }
}

/// Limit the text to a certain length (in number of characters)
/// If the text is longer than the limit, it will be truncated with "..."
/// 
/// -> str
#let wrap_text(
  text, limit: 30
) = {
  let texts = to_string(text).trim().split(" ")
  let truncated = ""
  let l = 0
  let add_ellipsis = false
  for t in texts {
    if l + t.len() > limit {
      add_ellipsis = true
      break
    }
    l += t.len()
    truncated += t + " "
  }
  truncated.trim() + if add_ellipsis { "..." } else { "" }
}

/// Find the level-1 heading of current page (requires context)
/// 
/// -> content | none 
#let get_chapter_name_in_current_page() = {
  let chapters = query(
    heading.where(level: 1, outlined: true)
  )
  chapters = chapters.sorted(key: it => it.location().page()).rev()
  for chapter in chapters {
    if here().page() >= chapter.location().page() {
      return chapter
    }
  }
  none
}

/// Get the chapter name of the current page (requires context)
///
/// -> str
#let get_chapter_name(limit: 50) = {
  let chapter = get_chapter_name_in_current_page()
  if chapter == none {
    return ""
  }
  wrap_text(chapter.body, limit: limit)
}

/// Get the heading name of the current page (requires context)
///
/// -> content
#let get_heading_name(
  supplement: "1.1",
) = {
  // Find all level 2 headings that are outlined
  let results = query(
    heading.where(level: 2, outlined: true)
  )
  // If no results, return none
  if results.len() == 0 {
    return none
  }
  // Sort the results by page number
  results = results.sorted(key: it => it.location().page())
  // Find the last heading that is on or before the current page
  let i = -1
  for r in results {
    i += 1
    if here().page() == r.location().page() {
      break
    }
    if here().page() < r.location().page() {
      i -= 1
      break
    }
  }
  if i < 0 {
    return none
  }
  // Get the heading at the found index
  let r = if i < results.len() { results.at(i) } else { results.last() }
  // Format the heading name with its numbering
  // e.g., "1.1 Introduction"
  [#numbering(supplement, ..counter(heading).at(r.location())) #r.body]
}