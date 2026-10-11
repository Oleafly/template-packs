#let normalize-author-entry(entry) = {
  (
    name: entry.at("name", default: []),
    affiliation: entry.at("affiliation", default: []),
    email: entry.at("email", default: []),
  )
}

#let normalize-authors(authors: ()) = {
  if type(authors) != array or not authors.all(entry => type(entry) == dictionary) {
    panic("metadata.authors must be an array of author dictionaries; replace content or tuple input with authors: ((name: [Alice], affiliation: [Institute], email: \"alice@example.com\"),), or use authors: () for no authors")
  }
  authors.map(normalize-author-entry)
}

#let render-author-inline(entry) = {
  let parts = ()
  if entry.at("name", default: []) != [] { parts.push(entry.at("name", default: [])) }
  if entry.at("affiliation", default: []) != [] { parts.push(entry.at("affiliation", default: [])) }
  if entry.at("email", default: []) != [] { parts.push(entry.at("email", default: [])) }
  if parts.len() == 0 {
    []
  } else {
    parts.join($at$)
  }
}

#let render-author-poster-inline(entry, author-size: 44pt, email-size: 34pt) = {
  let base-parts = ()
  let name = entry.at("name", default: [])
  let affiliation = entry.at("affiliation", default: [])
  let email = entry.at("email", default: [])
  if name != [] { base-parts.push(name) }
  if affiliation != [] { base-parts.push(affiliation) }
  let base = if base-parts.len() == 0 {
    []
  } else {
    text(size: author-size)[#base-parts.join($at$)]
  }
  if email == [] {
    base
  } else if base == [] {
    text(size: email-size)[#email]
  } else {
    [#base #text(size: email-size)[#email]]
  }
}

#let render-author-names(authors) = {
  let rendered = authors
    .map(author => author.at("name", default: []))
    .filter(part => part != [])
  if rendered.len() == 0 {
    []
  } else {
    rendered.join(linebreak())
  }
}

#let render-authors-inline(authors) = {
  let rendered = authors.map(render-author-inline).filter(part => part != [])
  if rendered.len() == 0 {
    []
  } else {
    rendered.join(linebreak())
  }
}

#let render-poster-authors-inline(authors, author-size: 44pt, email-size: 34pt) = {
  let rendered = authors.map(author => render-author-poster-inline(author, author-size: author-size, email-size: email-size)).filter(part => part != [])
  if rendered.len() == 0 {
    []
  } else {
    rendered.join(" / ")
  }
}

#let render-author-affiliations(authors) = {
  let rendered = authors
    .map(author => author.at("affiliation", default: []))
    .filter(part => part != [])
  if rendered.len() == 0 {
    []
  } else {
    rendered.join(linebreak())
  }
}

#let render-author-emails(authors) = {
  let rendered = authors
    .map(author => author.at("email", default: []))
    .filter(part => part != [] and part != "")
  if rendered.len() == 0 {
    []
  } else {
    rendered.join(linebreak())
  }
}

#let render-slide-title-author(entry) = {
  let parts = ()
  let name = entry.at("name", default: [])
  let email = entry.at("email", default: [])
  let affiliation = entry.at("affiliation", default: [])
  if name != [] and name != "" {
    parts.push(name)
  }
  if email != [] and email != "" {
    parts.push(if type(email) == str { raw(email) } else { email })
  }
  if affiliation != [] and affiliation != "" {
    parts.push(affiliation)
  }
  if parts.len() == 0 {
    []
  } else {
    parts.join(h(0.6em))
  }
}

#let render-slide-title-authors(authors) = {
  authors.map(render-slide-title-author).filter(part => part != [])
}

#let authors-for-js(authors) = {
  let mapped = authors.map(author => (
    author.at("name", default: []),
    author.at("affiliation", default: []),
    author.at("email", default: []),
  ))
  if mapped.len() == 0 {
    ""
  } else if mapped.len() == 1 {
    mapped.at(0)
  } else {
    mapped
  }
}

#let normalize-metadata(config) = {
  if "author" in config {
    panic("metadata.author is no longer supported; replace author: [Alice] with authors: ((name: [Alice],),); add affiliation and email to the dictionary if needed")
  }
  let authors = normalize-authors(
    authors: config.at("authors", default: ()),
  )

  (
    title: config.at("title", default: []),
    subtitle: config.at("subtitle", default: []),
    authors: authors,
    author-names: render-author-names(authors),
    authors-inline: render-authors-inline(authors),
    poster-authors-inline: render-poster-authors-inline(authors),
    affiliations-inline: render-author-affiliations(authors),
    author-emails-inline: render-author-emails(authors),
    slide-title-authors: render-slide-title-authors(authors),
    authors-js: authors-for-js(authors),
    date: config.at("date", default: auto),
    summary: config.at("summary", default: []),
    abstract: config.at("abstract", default: []),
    venue: config.at("venue", default: []),
    acknowledgements: config.at("acknowledgements", default: []),
    logo: config.at("logo", default: []),
    logo-position: config.at("logo-position", default: "right-bottom"),
    logo-relative-width: config.at("logo-relative-width", default: none),
    bibliography: config.at("bibliography", default: none),
  )
}
