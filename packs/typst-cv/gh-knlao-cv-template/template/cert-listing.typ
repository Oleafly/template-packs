#import "scripts/pageref.typ": pageref
#import "styles.typ": *

#let cert-listing(data) = {
  show table.cell.where(y: 0): set text(weight: "bold")
  set table(fill: (_, y) => if y == 0 {theme-1})
  table(
    columns: (10%, 50%, 25%, 15%),
    rows: (5%),
    align: (center+horizon, center+horizon, center+horizon, center+horizon),
    table.header([年份], [比赛/证书名称], [奖项/性质], [对应页码]), table.hline(),
    ..for (category, items) in data {
      (
        table.cell(colspan: 4, fill: theme-2)[
          #heading(level: 2, category)
        ],
      )
      let light = table.cell.with(fill: highlight)
      for (id, year, name, award) in items {
        let id = id.replace("#", "")
        if id.contains("*") {
          (light[#year], light[#name], light[#award], light[#pageref(label(id.replace("*", "")))],)
        } else {
          ([#year], [#name], [#award], [#pageref(label(id))],)
        }
      }
    }
  )
}
