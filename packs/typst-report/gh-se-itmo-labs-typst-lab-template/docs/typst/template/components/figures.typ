// Единая обёртка для изображений и других иллюстраций.
// width ограничивает ширину всего рисунка, caption создаёт подпись и номер.
#let report-figure(
  body,
  caption: none,
  width: 100%,
  supplement: [Рисунок],
) = {
  figure(
    box(width: width, body),
    caption: caption,
    supplement: supplement,
  )
}
