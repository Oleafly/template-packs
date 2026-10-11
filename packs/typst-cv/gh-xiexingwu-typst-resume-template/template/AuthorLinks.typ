#import "/components/Link.typ": Link, LinkEmpty

#let AuthorLinks(
  author,
) = {
  let links = (
    if author.github != none {
      Link(
        icon: "github",
        "https://github.com/" + author.github,
        author.github,
      )
    },
    if author.linkedin != none {
      Link(
        icon: "linkedin-in",
        "https://linkedin.com/in/" + author.linkedin,
        author.linkedin,
      )
    },
    if author.email != none {
      Link(
        icon: "envelope",
        "mailto:" + author.email,
        author.email,
      )
    },
    if author.phone != none {
      LinkEmpty(
        icon: "phone",
        author.phone,
      )
    },
    if author.location != none {
      LinkEmpty(
        icon: "location-dot",
        author.location,
      )
    },
  )

  links.insert(calc.quo(links.len(), 2), linebreak())
  return links.join(h(1em))
}
