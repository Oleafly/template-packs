#import "@preview/scienceicons:0.1.0": email-icon, github-icon, linkedin-icon, website-icon

// Reusable renderers for a profile (facts) and a curated entrypoint (selection
// and ordering). Import this file as a module and call its public functions.
#let default-theme = (
  "accent-color": "#773d8f",
  font: "New Computer Modern",
  "empty-items-spacing": 0.65em,
)

#let resolve-theme(theme) = default-theme + theme

#let generic-one-by-two(
  left: "",
  right: "",
) = [
  #left #h(1fr) #right \
]

#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
  accent-color: default-theme.at("accent-color"),
) = [
  #top-left #h(1fr) #top-right \
  #text(rgb(accent-color), bottom-left) #h(1fr) #emph(bottom-right) \
]

#let normalized-url(url) = {
  if url.starts-with("mailto:") or url.contains("://") { url } else { "https://" + url }
}

#let contact-item(text, url: "") = {
  let prefix = ""
  if "github" in url {
    prefix = [#github-icon() ]
  } else if "linkedin" in url {
    prefix = [#linkedin-icon() ]
  } else if "mailto:" in url {
    prefix = [#email-icon() ]
  } else if url != "" {
    prefix = [#website-icon() ]
  }

  if url == "" {
    [#prefix#text]
  } else {
    [#prefix#link(normalized-url(url))[#text]]
  }
}

#let contact-list(contacts) = {
  set align(center)
  contacts.map(it => contact-item(
    it.text,
    url: if "url" in it { it.url } else { "" },
  )).join(" | ")
}

#let subtitle(content, accent-color) = {
  set align(center)
  set text(
    size: 12pt,
    weight: 500,
    fill: rgb(accent-color),
  )
  pad(
    bottom: -10pt,
    content,
  )
}

#let header(profile, theme: (:)) = {
  let theme = resolve-theme(theme)
  let accent-color = theme.at("accent-color")

  if "author" in profile [= #profile.author]
  if "subtext" in profile and profile.subtext != "" [#subtitle(profile.subtext, accent-color)]
  if "contacts" in profile and profile.contacts.len() > 0 {
    contact-list(profile.contacts)
  }
}

#let entry-title(entry) = {
  if "url" in entry and entry.url != "" {
    [*#entry.title* (#link(normalized-url(entry.url))[#entry.url])]
  } else {
    [*#entry.title*]
  }
}

#let render-entry(entry, accent-color, empty-items-spacing) = {
  let right = if "right" in entry { entry.right } else { "" }
  let subtitle = if "subtitle" in entry { entry.subtitle } else { "" }
  let subright = if "subright" in entry { entry.subright } else { "" }

  if subtitle != "" or subright != "" {
    generic-two-by-two(
      top-left: entry-title(entry),
      top-right: right,
      bottom-left: subtitle,
      bottom-right: subright,
      accent-color: accent-color,
    )
  } else {
    generic-one-by-two(
      left: entry-title(entry),
      right: right,
    )
  }

  let items = if "items" in entry { entry.items } else { () }
  for item in items [- #eval(item, mode: "markup")]
  if items.len() == 0 { v(empty-items-spacing) }
}

// Renders an Experience-style section. When ids is supplied, it also
// determines the selected entries' display order.
#let entries(section, ids: none, theme: (:)) = {
  if not ("entries" in section) or section.entries.len() == 0 { return }
  let theme = resolve-theme(theme)
  let accent-color = theme.at("accent-color")
  let empty-items-spacing = theme.at("empty-items-spacing")

  [== #section.title]
  if ids == none {
    for (_, entry) in section.entries {
      render-entry(entry, accent-color, empty-items-spacing)
    }
  } else {
    for id in ids {
      render-entry(section.entries.at(id), accent-color, empty-items-spacing)
    }
  }
}

// Renders a Skills-style section whose named groups contain short lists.
#let groups(section) = {
  if not ("groups" in section) or section.groups.len() == 0 { return }
  [== #section.title]
  for (name, values) in section.groups {
    [- *#name:* #values.join(", ")]
  }
}

#let setup(doc, theme: (:)) = {
  let theme = resolve-theme(theme)
  let accent-color = theme.at("accent-color")

  set page(
    paper: "us-letter",
    margin: 0.5in,
  )

  set text(
    font: theme.font,
    size: 10pt,
    lang: "en",
    ligatures: false,
    fill: rgb(0, 0, 0, 88%),
  )

  show heading.where(level: 1): it => {
    set align(center)
    set text(
      size: 20pt,
      weight: 700,
      fill: rgb(0, 0, 0),
    )
    pad(
      top: -20pt,
      it,
    )
  }

  show heading.where(level: 2): it => {
    set text(
      size: 12pt,
      weight: 500,
    )
    pad(
      top: -6pt,
      bottom: -10pt,
      [#smallcaps(it)],
    )
    line(length: 100%, stroke: 1pt)
  }

  show strong: it => {
    set text(
      fill: rgb(0, 0, 0),
    )
    it
  }

  show link: it => {
    set text(fill: rgb(accent-color))
    underline(it)
  }

  doc
}
