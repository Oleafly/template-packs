= Обозначения и сокращения

#let entries = {
  (
    (short: "Tecт", desc: lorem(30)),
    (short: "Tecт2", desc: lorem(20))
  )
}

#table(
  columns: (0.4fr, 1fr),
  stroke: 0.05em,
  inset: 0.6em,
  table.header()[*Сокращение*][*Расшифровка сокращения*],
  ..for entry in entries.sorted(key: x => x.short) {
    ([#entry.short], [#entry.desc])
  },
)