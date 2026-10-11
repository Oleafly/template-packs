#let headings-on-odd-page(it) = {
  show heading.where(level: 1): it => {
    {
      set page(header: none, numbering: none)
      pagebreak(to: "odd")
    }
    it
  }
  it
}

#let entries-from-yaml(file) = {
  let acronyms = file
  // Initializing the glossary.
  let entries = ()
  for (key, value) in acronyms {
    if not "short" in value or not "long" in value {
      panic("Acronym must have a short and long form, for key: " + str(key))
    }

    entries.push(
      (
        key: key,
        short: eval(mode: "markup", value.short),
        long: eval(mode: "markup", value.long)
      )
    )
  }

  entries
}