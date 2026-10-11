#import "../template.typ": entry-table, section-title
#import "03_list-of-figures.typ": figure-number

#let list_of_tables(config) = {
  section-title(config, [List of Tables])

  context {
    let rows = query(figure.where(kind: table)).map(t => (
      link(t.location(), figure-number(table, t)),
      link(t.location(), t.caption.body),
      link(t.location(), str(counter(page).at(t.location()).first())),
    ))

    entry-table(("Table No.", "Description", "Page No."), rows)
  }
}
