#import "basic-resume.typ": work

#let render-experience(data: none) = {
  let entries = if data != none { data } else { yaml("experience.yml") }

  for (i, entry) in entries.enumerate() {
    if i > 0 { v(0.6em) }

    block(breakable: false)[
      #work(
        title: entry.title + " | " + entry.role,
        company: entry.company,
        location: entry.location,
        dates: entry.timeframe,
      )

      #let render-bullet(b) = {
        if type(b) == str {
          [#b]
        } else {
          let pre = b.at("text", default: "")
          let lt = b.at("link-text", default: "")
          let lu = b.at("link-url", default: "")
          let suf = b.at("suffix", default: "")
          let sub = b.at("sub", default: ())
          let body = [#pre#if lt != "" { link(lu)[#lt] }#suf]
          if sub.len() > 0 {
            [#body #list(..sub.map(s => [#s]))]
          } else {
            body
          }
        }
      }
      #let bullets = entry.at("bullets", default: ())
      #let items = bullets.map(b => render-bullet(b))
      #if "technologies" in entry {
        items.push([Technologies: *#entry.technologies*])
      }
      #if items.len() > 0 {
        list(..items)
      }
    ]
  }
}
