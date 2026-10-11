#import "libs.typ": outrageous

  #let custom-numbering() = body => {
  show heading.where(level: 1): it => {
    let figures = (image, table, raw).map(kind => figure.where(kind: kind))
    let counters = (..figures, math.equation).map(counter)

    for c in counters {
      c.update(0)
    }

    it
  }
  set figure(numbering: n => {
    let ch = counter(heading).get().first()
    std.numbering("1.1", ch, n)
  })

  set math.equation(numbering: n => {
    let ch = counter(heading).get().first()
    std.numbering("1.1", ch, n)
  })
  body
}

/// Shows the outlines for the three kinds of figures, if such figures exist.
///
/// -> content
#let outlines(
  /// The figures outline title
  /// -> content
  figures: none,
  /// The tables outline title
  /// -> content
  tables: none,
  /// The listings outline title
  /// -> content
  listings: none,
) = {
  assert.ne(figures, none, message: "List of figures title not set")
  assert.ne(tables, none, message: "List of tables title not set")
  assert.ne(listings, none, message: "List of listings title not set")

  let kinds = (
    (image, figures),
    (table, tables),
    (raw, listings),
  )

  show outline.entry: outrageous.show-entry.with(
    ..outrageous.presets.outrageous-figures,
  )

  for (kind, title) in kinds {
    context if query(figure.where(kind: kind)).len() != 0 {
      title
      outline(title: none, target: figure.where(kind: kind))
    }
  }
}