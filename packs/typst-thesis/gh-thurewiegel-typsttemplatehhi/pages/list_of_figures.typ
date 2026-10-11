#context {
  if query(figure.where(kind: image)).len() > 0 {
    heading("List of Figures", numbering: none)

    set outline.entry(fill: grid(
      columns: 2,
      gutter: 0pt,
      repeat[~.], h(11pt),
    ))

    outline(
      title: none,
      indent: auto,
      target: figure.where(kind: image),
    )
  }
}
