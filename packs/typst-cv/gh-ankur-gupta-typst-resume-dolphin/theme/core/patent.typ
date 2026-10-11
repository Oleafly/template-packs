#import "utils.typ": fill_instance_with_default
#import "author.typ": format_authors_array
#import "bib.typ": fill_items, filter_items_by_tag

#let PATENT = (
    authors: none,
    assignee: none,
    title: none,
    url: none,
    serial_number: none,
    granted_date: none,
    application_date: none,
    tag: none
)

#let patent(p) = {
  let fp = fill_instance_with_default(p, default: PATENT)

  // Construct parts and then join
  let parts = (format_authors_array(fp.authors), )

  if fp.assignee != none {
    parts.push(", " + fp.assignee)
  }

  if fp.title != none {
    parts.push(". " + fp.title)
  }

  if fp.url != none {
    if fp.serial_number != none {
      parts.push(". " + link(fp.url, fp.serial_number))
    } else {
      parts.push(". " + link(fp.url, "URL"))
    }
  } else {
    parts.push(". " + fp.serial_number)
  }

  if fp.granted_date != none {
    parts.push([, granted #text(style: "italic", fp.granted_date)])
  } else if fp.application_date != none {
    parts.push([, pending #text(style: "italic", fp.application_date)])
  }

  parts.push(".")
  let line = parts.join()
  line
}

#let patents(filename, tag: none) = {
  filter_items_by_tag(fill_items(filename, PATENT), patent, tag: tag)
}
