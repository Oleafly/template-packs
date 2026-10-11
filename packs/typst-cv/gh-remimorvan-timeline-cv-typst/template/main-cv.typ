#import "../timeline-cv.typ": *
#let metadata = toml("./metadata.toml")
#let lang = sys.inputs.at("lang", default: none)
#if lang != none {
  metadata.language = lang
}

#let import_sections(lang, sections, spread: true) = {
  for id in range(sections.len()) {
    if (id > 0) {
      v(2em)
      if (spread) { v(1fr) }
    }
    block(include {
      "./" + lang + "/" + sections.at(id) + ".typ"
    })
  }
}

#let side = [
  #import_sections(
    metadata.language,
    ("presentation", "awards", "skills", "languages", "associations"),
    spread: false,
  )
]
#let main = [
  #import_sections(
    metadata.language,
    ("experience", "education", "softwares"),
    spread: true,
  )
]
#show: cv.with(
  data: metadata,
  side: side,
  main: main,
)
