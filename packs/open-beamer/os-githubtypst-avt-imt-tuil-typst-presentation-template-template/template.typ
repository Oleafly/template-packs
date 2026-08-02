#import "@preview/touying:0.6.1": *
#import themes.university: *



// redefine title page
#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
  )
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  let body = {
    if info.logo != none {
      place(right, text(fill: self.colors.primary, info.logo))
    }
    std.align(
      center + horizon,
      {
        block(
          inset: 0em,
          breakable: false,
          {
            text(size: 1.5em, fill: self.colors.primary, info.title)
            if info.subtitle != none {
              parbreak()
              text(size: 1.0em, fill: self.colors.primary, info.subtitle)
            }
          },
        )
        set text(size: .8em)
        grid(
          columns: (1fr,) * calc.min(info.authors.len(), 3),
          column-gutter: 1em,
          row-gutter: 1em,
          ..info.authors.map(author => text(
            fill: self.colors.neutral-darkest,
            author,
          ))
        )
        v(1em)
        if info.institution != none {
          parbreak()
          text(size: .9em, info.institution)
        }
        if info.date != none {
          parbreak()
          text(size: .8em, utils.display-info-date(self))
        }
      },
    )
  }
  touying-slide(self: self, body)
})



#let theme(
  title: none,
  subtitle: none,
  author: none,
  date: datetime.today(),
  body
) = {

  show: university-theme.with(
    aspect-ratio: "16-9",
    config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,
      institution: image("imgs/logo.svg", width: 6cm) + linebreak() + "Audiovisuelle Technik (AVT)",
      //logo: image("imgs/logo.svg", width: 6cm), //  emoji.school,
      header: utils.display-current-heading(level: 2, style: auto),
    ),
    config-colors(
      primary: rgb(255, 121, 0),
      secondary: rgb(0, 51, 89),
      tertiary: rgb(0, 51, 89),
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb(0, 51, 89),
    )
  )
  set text(
    fill: rgb(0, 51, 89),
    font: "Arial"
  )

  // other TOC entries in regular with adapted filling
  show outline.entry.where(level: 2).or(outline.entry.where(level: 3)): it => {
    set text(size: 14pt)
    link(
      it.element.location(),  // make entry linkable
      it.indented(
          it.prefix(),
          it.body() + "  " +
            box(width: 1fr, repeat([.], gap: 2pt), baseline: 30%) +
            "  " + it.page(),
      )
    )
  }

  show heading.where(level: 2): set text(weight: "regular")


  body
}