#let achivements = yaml("achivements.yaml")

== 個人開発・学習・その他活動

#for achivement in achivements {
  heading(level:3, achivement.key_name)
  // 2. 各itemに対して行データを作成
  let cells = ()
  for item in achivement.items {
    cells.push(table.cell(colspan: 2, fill: luma(222), text(weight: 700, item.title)))
    let descRowspan = 1
    if "tech-stack" in item.keys() {
      descRowspan = 2
    }
    cells.push(table.cell(rowspan: descRowspan, [
      #item.description
      #if "urls" in item.keys() {
        let urls = ()
        for url in item.urls {
          urls.push(text(weight: 400, url.title))
          urls.push(url.url)
        }

        table(
          columns: (1fr, 3.2fr),
          rows: auto,
          stroke: 0pt,
          inset: (x: 1pt, y: 4pt),
          ..urls
        )
      }

    ]))
    cells.push(item.date)
    if "tech-stack" in item.keys() {
      cells.push(table.cell(colspan: 1, [
        #text(weight: 700, "【使用技術・環境】")
        #linebreak()
        #item.tech-stack
      ]))
    }
  }

  // 3. 作成した行データでテーブルを表示
  table(
    columns: (6fr, 1.5fr),
    rows: auto,
    stroke: 0.5pt,
    inset: 6pt,
    ..cells
  )
}
