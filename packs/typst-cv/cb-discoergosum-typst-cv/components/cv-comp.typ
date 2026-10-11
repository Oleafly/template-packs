#import "gen-comp.typ": header
#let metadata = toml("../meta.toml")

#let accent-color = rgb(metadata.style.accent_color)
#let base-color = rgb(metadata.style.base_color)


#let cv-header = context {
  grid(
    columns: (1fr, auto),
    header,
    if metadata.layout.show_photo {
      box(
        image("../" + metadata.personnal.infos.photo),
        radius: eval(metadata.style.photo_radius),
        clip: true,
        height: measure(header).height,
      )
    },
  )
}

#let section(title) = {
  v(eval(metadata.layout.spaceing.section))

  if metadata.style.section.smallcaps {
    smallcaps(text(
      size: 1.6em,
      weight: "bold",
      font: metadata.style.accent_font,
      title,
    ))
  } else {
    text(
      size: 1.6em,
      weight: "bold",
      font: metadata.style.accent_font,
      title,
    )
  }

  h(0.15em)
  box(width: 1fr, line(stroke: 0.08em, length: 100%))
}

#let introduction(title: "Titel", body: "Introduction Text") = {
  section(title)
  par(
    justify: true,
    body,
  )
}

#let import-modules(modules) = {
  for module in modules {
    include {
      "../modules/" + module + ".typ"
    }
  }
}

#let skill(type: "Type", info: "Info") = {
  let type-style(str) = {
    align(right, text(weight: "bold", str))
  }

  grid(
    columns: (17%, 1fr),
    inset: 0pt,
    column-gutter: 1em,
    type-style(type), info,
  )
  v(eval(metadata.layout.spaceing.skill))
}

// das ist fuer die bullet point. TODO: das muss noch anders werden
#let spacing-bullet = eval(metadata.layout.spaceing.entry.des_entry)

#let entry(
  title: "Title",
  organization: "Organization",
  date: "Date",
  location: "Location",
  description: "Description",
) = {
  let title-style(str) = {
    text(size: 1em, weight: "bold", str)
  }

  let date-style(str) = {
    align(
      right,
      text(weight: "medium", fill: accent-color, style: "oblique", str),
    )
  }

  let organization-style(str) = {
    text(size: 0.8em, fill: accent-color, weight: "medium", str)
  }

  let location-style(str) = {
    align(
      right,
      text(size: 0.8em, weight: "medium", fill: base-color.lighten(45%), style: "oblique", str),
    )
  }

  let entry-description-style(str) = {
    if str != "" {
      text(
        fill: base-color.lighten(10%),
        {
          v(eval(metadata.layout.spaceing.entry.description))
          str
        },
      )
    }
  }

  v(eval(metadata.layout.spaceing.entry.before))
  grid(
    columns: (1fr, auto),
    row-gutter: eval(metadata.layout.spaceing.entry.organization),
    title-style(title), date-style(date),
    organization-style(organization), location-style(location),
  )
  entry-description-style(description)
}

