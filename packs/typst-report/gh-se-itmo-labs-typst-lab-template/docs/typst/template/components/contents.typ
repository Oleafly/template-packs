// Содержание строится автоматически из заголовков документа.
// Сам заголовок "Содержание" исключён из списка через outlined: false.
#let contents-page(config: (:)) = {
  heading(level: 1, outlined: false)[#config.labels.contents]
  v(4mm)
  outline(title: none, depth: config.toc_depth)
}
