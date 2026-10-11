#import "../core/core.typ": *

#let quests = {
  let headerCell(colspan: 1, body) = grid.cell(
    colspan: colspan,
    align: left,
    tableHeader(body)
  )
  let emptyCell = grid.cell([])

  let questFrame(fromLines: 2, goalLines: 5, rewardLines: 1) = [
    #framed(
      fitting: expand-h,
      insets: (top: paddings(1), bottom: 0pt, rest: paddings(2))
    )[
      #grid(
        columns: (1fr),
        rows: paddings(2),
        stroke: innerRowStrokes(),
        headerCell(loc("ui.quests.goal")), emptyCell,
        ..((emptyCell,) * goalLines),
        headerCell(loc("ui.quests.from")),
        ..((emptyCell,) * fromLines),
        headerCell(loc("ui.quests.reward")), emptyCell,
        ..((emptyCell,) * rewardLines)
      )
    ]

    #place(
      top + left,
      dx: -paddings(1),
      dy: paddings(1.1),
      rhombus(
        width: paddings(2),
        stroke: strokes.normal,
        fill: white
      ),
    )

    #place(
      bottom + left,
      dx: -paddings(1.5),
      dy: -paddings(4),
      rhombus(
        width: paddings(3),
        stroke: strokes.normal,
        fill: white
      ),
    )
  ]

  page(
    header: section(loc("ui.pages.quests"))
  )[
    #grid(
      columns: (1fr, 1fr),
      rows: 1fr,
      stroke: none,
      gutter: paddings(2),
      ..((questFrame(),) * 6),
    )
  ]
}
