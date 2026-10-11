//Config vars
#set list(indent: 1em)
#let par_space = 0.5em
#let sep_space = par_space + 0.2em
#let photo_size = 11em
#let colum_gutter = 3em
#let row_gutter = 1.5em

#let icon = (name, raise: false) => box(
  baseline: if raise { 0.03em } else { 0.15em },
  inset: (right: 0.5em),
  image(
    height: 1em,
    "assets/svg/" + name + ".svg"
  )
)

#let template(doc, color, name, photo, profile, personal_info) = {
    set page(margin: (x: 1.5cm, y: 1cm))
    set text(font: "Arial", size: 11pt)
    set par(justify: true, leading: 0.5em)
    set table(inset: 0pt,stroke: none)
  

  show heading.where(level: 1): i => {
    set align(left)
    let title = smallcaps(i.body)

    set block(above: 1em)
      set text(weight: "light", size: 1.2em, fill: rgb(0, 0, 0))
      stack(
        dir: ttb,
        spacing: 2mm,
        title,
        line(length: 100%, stroke: color + 2pt)
    )
  }

  show heading.where(level: 2): i => {
    set align(left)
    let title = smallcaps(i.body)
    set block(above: 0.8em)
    set text(weight: "light", size: 1.1em, fill: color)
    title
  }

  align(left)[
    #smallcaps(text(size: 2.5em, fill: color)[#name]) \
  ]
  

    table(
      columns: 2,
      column-gutter: colum_gutter,
      row-gutter: row_gutter,
      [
        #align(left)[
        = #icon("person") Personal Profile
        #text("A skilled software developer with a track record of creating and maintaining high-quality software. Enthusiastic to learn new technologies and skills. Currently seeking a new professional challenge.")
        ]
         #table(
          columns: 2,
          column-gutter: colum_gutter,
          row-gutter: 1em,
          ..personal_info.map(pi => (
             [
              #icon(pi.service) #pi.display
             ]
          )).flatten()
        )
      ],
      [
        #align(right)[
      #{
        if photo != none {
            linebreak()
            image("assets/img/" + photo, width: photo_size, height: photo_size)
        }
    }
  ]
    ]
    )

    doc
}

// Format start and end dates.
#let format_date(start_date: none, end_date: none) = {
  let date = {
    if end_date == none {
        start_date
      } else if start_date == none {
        end_date
      } else {
        start_date + " - " + end_date
      }
  }

  [*#date*]
}

// Format locations.
#let format_location(location) = {
  [_#block(above: sep_space, icon("location") +  location )_]
}

// General entry that is split into a left and right half (for experience and education).
#let cv_entry(left_content: none, right_content: none) = {
    grid(
    columns: (11fr, 6fr),
    column-gutter: 1cm,
    {
      set align(left)
      left_content
    },
    {
      set align(right)
      right_content
    }
  )
}

// Entry for education.
#let education_entry(degree, university, degree_title: none, description: none, start_date: none, end_date: none, location: none) = {
  cv_entry(
    left_content:  {
      if degree_title != none {
        [*#degree_title*] + " "
      } + [*#degree*] + [ _(#university)_ ] + block(above: sep_space, par[#description])
    },
    right_content:  {
      format_date(start_date: start_date, end_date: end_date)

      if location != none {
        "\n" + format_location(location)
      }
    }
  )
}

// Entry for work.
#let work_entry(role, company, tasks: none, start_date: none, end_date: none, location: none) = {
  cv_entry(
    left_content: {
      [*#role*] + block(above: sep_space, text[_(#company)_])

      if tasks != none {
        let tasks_list = []

        for task in tasks {
          tasks_list += [- #task]
        }

        tasks_list
      }
    },
    right_content:  {
      format_date(start_date: start_date, end_date: end_date)

      if location != none {
        "\n" + format_location(location)
      }
    }
  )
}

// Entry for skills
#let skill_entry(skills) = {
  [== Technologies]

   table(
    columns: 4,
    gutter: 1fr,
    column-gutter: colum_gutter,
    row-gutter: row_gutter,
    align: left + horizon,

    ..skills.map(s => (
      [ #icon(s.icon, raise: if s.keys().contains("raise") { s.raise } else { false }) #s.name]
    )).flatten()
  )
}

// Entry for references
#let references_entry(refs) = {
    table(
    columns: (auto, 1fr, auto),
    column-gutter: colum_gutter,
    row-gutter: row_gutter,

    ..refs.map(r => (
      [ #r.name ],
      [ #r.role ],
      [
        #if r.email != none {[
          #icon("envelope") #link("mailto:" + r.email)
        ]}
        \
        #if r.phone != none {[
          #icon("phone") #link("tel:" + r.phone)
        ]}

      ],
    )).flatten()
  )
}

#let interests_entry(interests) = {
    table(
        columns: 2,
        column-gutter: colum_gutter,
        row-gutter: row_gutter,
        ..interests.map( i => (
            [ #i.name],
            [ #i.description]
        )).flatten()
    )
}

#let misc_entry(miscellaneous) = {
  table(
    columns: (auto, 1fr),
    column-gutter: colum_gutter,
    row-gutter: 1em,

    ..miscellaneous.map(m => (
      [ - #m.label ],
      [ #m.value ],
    )).flatten()
  )
}

#let languages_entry(languages) = {
  [== Natural Languages ]
  table(
    columns: (auto, 1fr, auto),
    column-gutter: 1em,
    align: horizon,
    row-gutter: 1em,

    ..languages.map(l => {
      (
        [ #l.name ],
        [
          #let level = 0

          #while level < 10 {
            level = level + 1

            let color = if (level > l.level) {
              luma(227)
            } else {
              luma(0)
            }

            box(
              fill: color,
              height: .3em,
              width: 1fr,
            )
          }
        ],
        [ #l.acquisition ]
      )
    }).flatten()
  )
}