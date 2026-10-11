= Термины и определения

#let entries = {
  (
    (
      short: "Тест",
      desc: lorem(45),
    ),
    (short: "Тест2", desc: lorem(30))
  )
}

#table(
  columns: (0.4fr, 1fr),
  stroke: 0.05em,
  inset: 0.6em,
  table.header()[*Термин*][*Определение*],
  ..for entry in entries.sorted(key: x => x.short) {
    ([#entry.short], [#entry.desc])
  },
)