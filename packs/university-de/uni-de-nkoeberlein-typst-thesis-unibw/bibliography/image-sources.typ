// =============================================================
// image-sources.typ – parst image-sources.bib automatisch
//
// Diese Datei NICHT bearbeiten.
// Bildquellen pflegen in: bibliography/image-sources.bib
//
// Unterstützte Felder: author, title, url, year, note
// BibTeX-Typen: @online, @misc, @article – alle werden gelesen
// =============================================================

#let _parse-bib(content) = {
  let entries    = ()
  // Jeder Eintrag: @type{key, felder...}
  // Body: entweder reine Zeichen oder {einfach geklammerte Werte}
  let entry-re = regex("@\\w+\\{\\s*([^,\\s]+)\\s*,((?:[^{}]|\\{[^{}]*\\})*)\\}")
  let field-re  = regex("(\\w+)\\s*=\\s*\\{([^}]*)\\}")

  for m in content.matches(entry-re) {
    let key    = m.captures.at(0).trim()
    let body   = m.captures.at(1)
    let fields = (:)

    for f in body.matches(field-re) {
      fields.insert(f.captures.at(0).trim(), f.captures.at(1).trim())
    }

    entries.push((
      key:    key,
      author: fields.at("author",  default: none),
      title:  fields.at("title",   default: none),
      url:    fields.at("url",     default: none),
      year:   if "year" in fields { int(fields.at("year")) } else { none },
      note:   fields.at("note",    default: none),
    ))
  }
  entries
}

#let image-sources-data = _parse-bib(read("image-sources.bib"))
