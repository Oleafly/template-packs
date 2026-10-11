// ============================================================
// Generic report example — uses every component in theme.typ.
// All content below is placeholder text (no real project data).
//
// Compile:
//   export HTTPS_PROXY=http://127.0.0.1:7897   # only needed the first time,
//                                              # to fetch codly / fletcher
//   typst compile --root .. examples/generic-report.typ
// ============================================================

#import "../theme.typ": *

#report(
  doc-title: [Generic report title],
  doc-date: [2026-01-01],
  doc-footer: [Typst Report Kit],
)[

  // ============ Cover ============
  #cover(
    kicker: [Section title · placeholder label],
    title: [Generic report title],
    sub: [
      Placeholder subtitle line one#linebreak()
      Placeholder subtitle line two#linebreak()
      Placeholder subtitle line three
    ],
    core-label: [Positioning],
    core: [
      Lorem-like placeholder Chinese text 用于占位，说明本页的用途。这一段模拟封面上的定位说明卡片，长度可长可短，超出会自动换行。
    ],
    meta: [
      your-org · your-name#linebreak()
      2026-01-01 · placeholder meta line
    ],
  )

  // ============ Body ============
  #pagebreak()

  = Section title one

  这里是占位正文，Lorem ipsum dolor sit amet, consectetur adipiscing elit。这一段用于演示正文排版：两端对齐、暖色墨字、9.5pt 字号，行距 0.75em，适合连续阅读。

  == Subsection title

  #card(title: [Callout title], type: "green")[
    Placeholder callout body 占位文本，用于重点提示与信息分组。
  ]

  #card(title: [Caution], type: "cream")[
    Placeholder caution body 占位文本，用于提醒与待确认事项。
  ]

  #verdict[Verdict strip placeholder — 一句话结论占位。]

  == Status legend

  状态标记：#badge(level: "ok")[Confirmed] #h(2mm) #badge(level: "warn")[Pending] #h(2mm) #badge(level: "red")[Blocked] #h(2mm) #badge(level: "unk")[Unknown]

  = Section title two

  == Placeholder table

  #table(
    columns: (1.6fr, 1fr, 1fr),
    [Item], [Owner], [Status],
    [Placeholder row one], [your-name], [#badge(level: "ok")[Confirmed]],
    [Placeholder row two], [your-name], [#badge(level: "warn")[Pending]],
    [Placeholder row three], [your-name], [#badge(level: "unk")[Unknown]],
  )

  == Checklist

  #check-item(checked: true)[Placeholder task one — already done]
  #check-item(checked: true)[Placeholder task two — already done]
  #check-item(checked: false)[Placeholder task three — still open]

  == Timeline

  #timeline((
    ("2026-01", "Placeholder milestone"),
    ("2026-03", "Placeholder milestone"),
    ("2026-06", "Placeholder milestone"),
    ("2026-09", "Placeholder milestone"),
  ))

  == Flowchart

  #diagram(
    spacing: (16mm, 10mm),
    node((0, 0), [Start], stroke: 0.6pt + border, fill: surface-2, corner-radius: 1.5mm, inset: 2.5mm),
    node((1, 0), [Process], stroke: 0.6pt + border, fill: surface-2, corner-radius: 1.5mm, inset: 2.5mm),
    node((2, 0), [Decision], stroke: 0.6pt + border, fill: accent-soft, corner-radius: 1.5mm, inset: 2.5mm),
    node((3, 0), [End], stroke: 0.6pt + accent, fill: accent-soft, corner-radius: 1.5mm, inset: 2.5mm),
    edge((0, 0), (1, 0), "->"),
    edge((1, 0), (2, 0), "->"),
    edge((2, 0), (3, 0), "->"),
  )

  = Section title three

  == Code block

  ```python
  # Placeholder code — demonstrates the codly code-block styling.
  def placeholder(value: int) -> int:
      return value
  ```

  == Quote

  #quote[
    Placeholder quote body — 引用块占位文本，演示奶油底 + 琥珀色左边条的引用样式。
  ]

  == Notes on usage

  - Change any token at the top of `theme.typ` to re-skin the whole document.
  - `#report(numbered: false)` switches off level-1 heading numbering (book style).
  - `#cover(decoration: "disc")` swaps the three accent rules for a pale disc.
]
