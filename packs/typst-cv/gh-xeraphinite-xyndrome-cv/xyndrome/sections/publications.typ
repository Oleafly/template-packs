#import "../components/ui.typ": authors-component, link-with-icon
#import "../icons.typ": pdf-icon

#let journal-counter = counter("journal")
#let conference-counter = counter("conference")
#let preprint-counter = counter("preprint")
#let patent-counter = counter("patent")
#let software-counter = counter("software")
#let spectral-numbering(body) = text(font: "Spectral", body)
#let latin-span = regex("[A-Za-z0-9][A-Za-z0-9 ./,&()\\-]*")
#let spectral-english(body) = context {
  show latin-span: set text(font: "Spectral")
  body
}

#let year-text(value) = {
  if value == none or value == "" {
    ""
  } else if type(value) == datetime {
    value.display("[year]")
  } else {
    let normalized = str(value).trim()
    if normalized.contains(",") {
      normalized.split(",").at(-1).trim()
    } else if normalized.contains("-") {
      normalized.split("-").at(0).trim()
    } else {
      normalized
    }
  }
}

#let paper(
  authors: (),
  title: "",
  venue: "",
  published: "",
  metadata: "",
  citation: none,
  DOI: none,
  icon: none,
  tldr: none,
  type: "journal",
  pdf: none,
) = {
  let author_text = authors-component(authors: authors, format: "full")
  let published-year = year-text(published)

  let (pub_counter, prefix) = if type == "journal" {
    (journal-counter, "J")
  } else if type == "conference" {
    (conference-counter, "C")
  } else if type == "preprint" {
    (preprint-counter, "P")
  } else {
    (journal-counter, "J")
  }

  pub_counter.step()
  let number = context pub_counter.display()
  let publication-text = if citation != none {
    citation
  } else {
    [#author_text#{ if published-year != "" [ (#published-year)] }. #emph(title). _#{ venue }_.]
  }

  pad(
    bottom: 0.6em,
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.8em,
      align(top)[#text(weight: "bold")[#spectral-numbering([\[#prefix#number\]])]],
      align(left)[
        #publication-text
        #{ if metadata != "" [#h(0.35em) #metadata.] }
        #{ if DOI != none [DOI: #link("https://doi.org/" + DOI)[#DOI]] }
        #{ if pdf != none [#h(0.5em) #link-with-icon(icon: pdf-icon, url: pdf, text: `PDF`)] }
        #{ if icon != none [
          #h(0.5em)
          #if type(icon) == array { icon.join(h(0.5em)) } else { icon }
        ] }
        #{ if tldr != none [
          #v(0.2em)
          #text(style: "italic", size: 0.9em, fill: rgb("#555555"))[*TL;DR:* #tldr]
        ] }
      ],
    ),
  )
}

#let patent(
  number: "",
  title: "",
  inventors: (),
  filed: "",
  status: "",
  country: "",
  icon: none,
) = {
  let inventor_text = authors-component(authors: inventors, format: "full")
  let year = year-text(filed)

  patent-counter.step()
  let pat_number = context patent-counter.display()

  pad(
    bottom: 0.1em,
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.8em,
      align(top)[#text(weight: "bold")[#spectral-numbering([\[P#{pat_number}\]])]],
      align(left)[
        #spectral-english([
          #inventor_text, #year. #emph(title). #country #spectral-numbering([#number]).
        ])
        #{ if icon != none [
          #h(0.5em)
          #if type(icon) == array { icon.join(h(0.5em)) } else { icon }
        ] }
      ],
    ),
  )
}

#let copyright(
  title: "",
  year: "",
  status: "",
  country: "",
  holders: (),
  icon: none,
) = {
  let holder_text = authors-component(authors: holders, format: "full")

  software-counter.step()
  let number = context software-counter.display()

  pad(
    bottom: 0.1em,
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.8em,
      align(top)[#text(weight: "bold")[#spectral-numbering([\[S#number\]])]],
      align(left)[
        #spectral-english([
          #holder_text (#year). #emph(title). #status, #country.
        ])
        #{ if icon != none [
          #h(0.5em)
          #if type(icon) == array { icon.join(h(0.5em)) } else { icon }
        ] }
      ],
    ),
  )
}
