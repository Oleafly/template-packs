#import "me.typ": make_me_bold

#let format_author_name(name) = {
  if name != none {
    let parts = name.split(",").map(s => s.trim())
    let first = parts.first()
    let second = parts.slice(1).map(s => upper(s).first()).join()
    if first != none {
      if second != none {
        (first, second).join(", ").trim()
      } else {
        (first, ).join().trim()
      }
    } else {
      if second != none {
        (second, ).join().trim()
      } else {
        none
      }
    }
  }
}

#let format_authors_array(authors) = {
  authors.map(a => make_me_bold(format_author_name(a))).filter(a => a != none).join(", ")
}
