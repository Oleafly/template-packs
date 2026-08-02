#import "@preview/fontawesome:0.1.0": *
#import "@preview/metalogo:1.1.0": LaTeX

#let primary_color = rgb("#2b4277") // darker blue
#let secondary_color = rgb("#677fb2") // lighter blue
#let gray_color = rgb("#7c7c7c") // light gray

#let sans_serif_font = "Fira Sans"
#let code_font = "Fira Code"

#let contact_info(services) = {
  let glyph(icon) = {
    box(baseline: 2.5pt, height: 11pt, text(icon, size: 10pt))
    h(3pt)
  }

  set text(weight: "bold", font: code_font, fill: primary_color, size: 8pt)

  services.map(service => {
    glyph(service.icon)

    if "display" in service.keys() {
      link(service.link, service.display)
    } else {
      link(service.link)
    }
  }).join(h(10pt))
}

#let header_info(name, links, occupation, tagline, image_path, compiled_date) = {
  set text(font: sans_serif_font)
  let date = text(size: 8pt, weight: "regular", fill: gray_color, compiled_date)
  grid(
    columns: (6fr, 1fr),
    gutter: 15pt,
    align(start + horizon, {
      [= #name]
      v(2pt)
      {
        show link: body => text(body, fill: primary_color)
        occupation; [ -- ]; text(style: "italic", tagline)
      }

      v(-5pt)
      date // TODO: try moving date to contact_info

      v(0pt)
      contact_info(links)
    }),
    align(end + horizon, image(image_path, height: 8%))
  )
}

#let experience(image_path, name, company_name, period, location) = {
  set table( inset: 0pt, stroke: none)
  set align(horizon)
  set text(font: sans_serif_font)
  let row_spacing = 4pt
  let right_text_font_size = 9pt

  v(5pt)

  table(
    columns: (20pt, 1fr),
    column-gutter: 5pt,
    image(image_path),
    table(
      columns: (1fr, auto),
      {
        set par(justify: false)

        text(weight: "bold", name)
      },
      {
        set align(right + bottom)
        set text(right_text_font_size, weight: "light")

        period; h(3pt); text(fill: secondary_color, fa-calendar(10pt))
      },
      {
        v(row_spacing)
        text(style: "italic", company_name)
      },
      {
        set text(right_text_font_size, weight: "light")
        set align(right)

        v(row_spacing)
        location; h(3pt); text(fill: secondary_color, fa-location-dot(10pt))
      },
    )
  )

  v(-5pt)
}

#let skill(name, rating) = {
  let max_rating = 5

  let circles = range(0, max_rating).map(i => {
    let color = secondary_color
    if i >= rating {
      color = rgb("#c0c0c0") // gray
    }

    box(circle(radius: 4pt, fill: color))
  }).join(h(4pt))

  name; h(1fr); text(baseline: 1.3pt)[#circles]; [\ ]
}

#let bubble(content) = {
  box(
    fill: secondary_color,
    inset: 4pt,
    radius: 6pt,
    text(weight: "semibold", fill: white, font: sans_serif_font , content)
  )
}

#let list_interests(interests) = {
  set par(leading: 5pt, justify: false)
  interests.map(interest => bubble(interest)).join(h(4pt))
}

#let footer(content) = [
  #set align(center)
  #set text(6.5pt, fill: gray_color, font: code_font)

  #show link: body => underline(text(body, fill: secondary_color, weight: "bold"))

  #line(length: 100%, stroke: 0.5pt + gray_color)
  #fa-chevron-right() #content
]

#let programming_skills(header, languages_header, other_technologies_header) = {
  [== #header]

  [=== #languages_header]

  skill("Rust", 4)
  skill("Go", 3)
  skill("TypeScript/JavaScript", 5)
  skill("Lua", 4)
  skill("Python", 3)
  skill("Java", 4)
  skill("Elixir", 2)
  skill("Haskell", 2)
  skill("SQL", 2)
  skill("HTML/CSS", 4)
  skill("C/C++", 2)
  skill("C#", 2)
  skill("Typst", 3)
  skill(LaTeX, 4)

  [=== #other_technologies_header]

  skill("Linux", 4)
  skill("Neovim/Vim", 5)
  skill("Git", 5)
  skill("OpenAPI/Swagger", 3)
  skill("Jest", 5)
  skill("Microsoft Azure", 3)
  skill("Serverless", 3)
  skill("Protobuf", 2)
  skill("AWS", 2)
  skill("Docker", 2)
  skill("Kubernetes", 2)
  skill("OAuth 2.0", 1)
  skill("HTMX", 1)
  skill("Phoenix", 2)
}

#let cv(
  name: "",
  links: (),
  occupation: "",
  tagline: [],
  compiled_date: "",
  left_column: [],
  right_column_header: "",
  languages_header: "",
  other_technologies_header: "",
  right_column: [],
  footer_content: []
) = {
  set text(9.8pt)
  set page(margin: (x: 32pt, y: 35pt), footer: footer(footer_content))
  set par(justify: true)

  show heading.where(level: 2): it => text(fill: primary_color, [
    #v(5pt)
    #{it.body}
    #v(-7pt)
    #line(length: 100%, stroke: 1pt + primary_color)
  ])
  show heading.where(level: 4): it => text(fill: primary_color, it.body)
  show heading: it => text(font: sans_serif_font, it)

  header_info(name, links, occupation, tagline, "images/profile.png", compiled_date)

  v(-8pt)

  grid(
    columns: (1fr, 0.40fr),
    gutter: 15pt,
    {
      show link: body => underline(text(body, fill: secondary_color))
      left_column
    },
    {
      show link: body => underline(text(body, fill: primary_color))
      programming_skills(right_column_header, languages_header, other_technologies_header)
      right_column
    },
  )
}
