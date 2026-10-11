#import "../template.typ": entry-table, section-title

// Figure numbers are chapter-scoped (`2.3`), and the numbering function on
// `figure` reads the heading counter, which resolves to zero out here in the
// front matter. So the number is rebuilt from both counters sampled at the
// figure's own location instead of being asked for.
#let figure-number(kind, element) = {
  let chapter = counter(heading).at(element.location()).first()
  let index = counter(figure.where(kind: kind)).at(element.location()).first()
  str(chapter) + "." + str(index)
}

#let list_of_figures(config) = {
  section-title(config, [List of Figures])

  context {
    let rows = query(figure.where(kind: image)).map(f => (
      link(f.location(), figure-number(image, f)),
      link(f.location(), f.caption.body),
      link(f.location(), str(counter(page).at(f.location()).first())),
    ))

    entry-table(("Figure No.", "Description", "Page No."), rows)
  }
}
