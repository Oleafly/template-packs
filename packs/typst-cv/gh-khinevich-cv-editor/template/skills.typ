#import "basic-resume.typ": _accent

#let render-skills(data: none) = {
  let d = if data != none { data } else { yaml("skills.yml") }

  [== Skills]

  context {
    let ac = _accent.get()

    let render-item(cat) = {
      if "sub" in cat {
        [#text(fill: rgb(ac))[*#cat.label:*] #list(..cat.sub.map(s => [#s]))]
      } else {
        [#text(fill: rgb(ac))[*#cat.label:*] #cat.text]
      }
    }

    // Split items into groups at spacer-before markers
    let groups = ()
    let current = ()
    for cat in d.items {
      if cat.at("spacer-before", default: false) and current.len() > 0 {
        groups = groups + (current,)
        current = (cat,)
      } else {
        current = current + (cat,)
      }
    }
    if current.len() > 0 { groups = groups + (current,) }

    for (i, group) in groups.enumerate() {
      if i > 0 { v(0.65em) }
      list(..group.map(cat => render-item(cat)))
    }
  }
}
