#import "../utils.typ": rich

#let summary-block(section) = {
  if section != none {
    for item in section.values() {
      let entry = if type(item) == str { (summary: item) } else { item }
      let text = entry.at("summary", default: none)
      if text != none and text != "" {
        set par(leading: 0.75em)
        par(justify: true)[#rich(text)]
      }
    }
  }
}
