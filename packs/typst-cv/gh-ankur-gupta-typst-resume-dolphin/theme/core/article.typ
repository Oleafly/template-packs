#import "utils.typ": fill_instance_with_default, linkify_doi
#import "author.typ": format_authors_array
#import "bib.typ": filter_items_by_tag, fill_items

#let ARTICLE = (
    authors: none,
    title: none,
    journal: none,
    volume: none,
    issue: none,
    pages: none,
    year: none,
    publisher: none,
    editors: none,
    doi: none,
    url: none,
    note: none,
    fulltext_label: none,
    fulltext_url: none,
    tag: none
)

#let article(a) = {
  let fa = fill_instance_with_default(a, default: ARTICLE)
  // Construct parts and then join
  let parts = (format_authors_array(fa.authors), )

  if fa.title != none {
    parts.push(". " + fa.title)
  }

  if fa.journal != none {
    parts.push([. #text(style: "italic", fa.journal)])
  }

  if fa.volume != none {
    if fa.issue != none {
      parts.push([, #fa.volume (#fa.issue)])
    } else {
      parts.push([, #fa.volume])
    }
  }

  if fa.pages != none {
    parts.push([, #fa.pages])
  }

  if fa.year != none {
    parts.push(", " + str(fa.year))
  }

  if fa.editors != none {
    parts.push(". Editors: " + format_authors_array(fa.editors))
  }

  if fa.publisher != none {
    parts.push(". " + fa.publisher)
  }

  if fa.doi != none {
    parts.push(". " + link(linkify_doi(fa.doi), fa.doi))
  }

  if fa.url != none {
    parts.push(". " + link(fa.url, "URL"))
  }

  if fa.fulltext_url != none {
    if fa.fulltext_label != none {
      parts.push(". Full text available at " + link(fa.fulltext_url, fa.fulltext_label))
    } else {
      parts.push(". Full text available at " + link(fa.fulltext_url, "here"))
    }
  }

  parts.push(".")
  let line = parts.join()
  line
}

#let articles(filename, tag: none) = {
  filter_items_by_tag(fill_items(filename, ARTICLE), article, tag: tag)
}
