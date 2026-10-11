#import "utils.typ": fill_instance_with_default
#import "author.typ": format_authors_array
#import "bib.typ": fill_items, filter_items_by_tag

#let CONFERENCE = (
    authors: none,
    title: none,
    venue: none,
    location: none,
    year: none,
    url: none,
    tag: none
)

#let conference(c) = {
  let fc = fill_instance_with_default(c, default: CONFERENCE)

  // Construct parts and then join
  let parts = (format_authors_array(fc.authors), )

  if fc.title != none {
    parts.push(". " + fc.title)
  }

  if fc.venue != none {
    parts.push([. #text(style: "italic", fc.venue)])
  }

  if fc.year != none {
    parts.push(", " + str(fc.year))
  }

  if fc.location != none {
    parts.push([. #text(style: "italic", fc.location)])
  }

  if fc.url != none {
    parts.push(". " + link(fc.url, "URL"))
  }

  parts.push(".")
  let line = parts.join()
  line
}

#let conferences(filename, tag: none) = {
  filter_items_by_tag(fill_items(filename, CONFERENCE), conference, tag: tag)
}
