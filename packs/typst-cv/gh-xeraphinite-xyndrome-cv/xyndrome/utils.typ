/// Shared non-visual helper functions.
#import "components/ui.typ": link_with_icon
#import "icons.typ": github-icon

#let normalize-markup(text) = text
  .replace("link-with-icon", "link_with_icon")
  .replace("github-line-icon", "github-icon")
  .replace("precision@k", "precision\\@k")
  .replace("@k", "\\@k")

#let eval-scope = (
  link_with_icon: link_with_icon,
  "link-with-icon": link_with_icon,
  "github-line-icon": github-icon,
)

#let rich(text) = if text == none or text == "" {
  none
} else {
  eval(normalize-markup(text), mode: "markup", scope: eval-scope)
}

#let bullet-list(lines) = if lines == none or lines.len() == 0 {
  []
} else {
  let normalized = lines.map(line => normalize-markup(line))
  eval("- " + normalized.join("\n- "), mode: "markup", scope: eval-scope)
}

#let opt-text(value) = if value == none or value == "" { none } else { value }
#let has-text(value) = value != none and value != ""

#let to-length(value, fallback) = {
  if value == none { fallback }
  else if type(value) == int or type(value) == float { value * 1pt }
  else { value }
}

/// Parse a length from a TOML value.
/// - Strings like "1.25cm", "12pt", "0.5in" are evaluated as Typst lengths.
/// - Numbers are treated as pt (same as to-length).
/// - none falls back to the given fallback.
#let parse-length(value, fallback) = {
  if value == none { fallback }
  else if type(value) == int or type(value) == float { value * 1pt }
  else if type(value) == str { eval(value) }
  else { value }
}

#let format-people(people, aliases: ()) = {
  let resolved = if aliases == none { () } else { aliases }
  if type(people) == array {
    people.map(person => {
      if type(person) == dictionary {
        let name = person.at("name")
        let bold = person.at("bold", default: false)
        if bold or resolved.contains(name) { strong(name) } else { name }
      } else {
        if resolved.contains(person) { strong(person) } else { person }
      }
    })
  } else {
    if resolved.contains(people) { strong(people) } else { people }
  }
}
