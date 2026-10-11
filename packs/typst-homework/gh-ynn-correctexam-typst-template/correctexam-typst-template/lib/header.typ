#import "i18n.typ": _i18n-map
#import "markers.typ": _emit-marker

#let _corner-dot(radius) = circle(radius: radius, fill: black)

#let _identity-row-count(cfg) = {
  if cfg.mode == "anonymous" {
    1
  } else if cfg.mode == "noid" {
    2
  } else {
    3
  }
}

#let _identity-header-height(cfg) = {
  let rows = _identity-row-count(cfg)
  rows * cfg.box_height + calc.max(rows - 1, 0) * 0.08cm
}

#let _id-row(
  count,
  box-width,
  box-height,
  box-gap,
  box-stroke,
  marker-key: none,
  emit-marker: false,
) = {
  let safe-count = calc.max(count, 1)
  let row-width = safe-count * box-width + calc.max(safe-count - 1, 0) * box-gap

  // Use stack(dir: ltr) like the prototype - no wrapping block
  stack(
    dir: ltr,
    spacing: box-gap,
    ..range(safe-count).map(i => {
      if i == 0 and emit-marker and marker-key != none {
        // First box emits the marker
        box(width: box-width, height: box-height, inset: 0pt, stroke: box-stroke)[
          #context {
            let pos = here().position()
            _emit-marker(marker-key, row-width, box-height)
          }
        ]
      } else {
        box(width: box-width, height: box-height, inset: 0pt, stroke: box-stroke)[]
      }
    }),
  )
}

#let _id-header(cfg, page-num) = context {
  let txt = _i18n-map(cfg.lang)
  let emit = page-num == 1
  let rows = if cfg.mode == "anonymous" {
    ((
      label: txt.anonymousid,
      key: "correctexam-stdid",
      count: cfg.id_boxes,
    ),)
  } else if cfg.mode == "noid" {
    (
      (
        label: txt.lastname,
        key: "correctexam-lastname",
        count: cfg.lastname_boxes,
      ),
      (
        label: txt.firstname,
        key: "correctexam-firstname",
        count: cfg.firstname_boxes,
      ),
    )
  } else {
    (
      (
        label: txt.lastname,
        key: "correctexam-lastname",
        count: cfg.lastname_boxes,
      ),
      (
        label: txt.firstname,
        key: "correctexam-firstname",
        count: cfg.firstname_boxes,
      ),
      (
        label: txt.studentid,
        key: "correctexam-stdid",
        count: cfg.id_boxes,
      ),
    )
  }

  layout(size => {
    let label_col_width = rows.fold(0pt, (acc, row) => {
      let w = measure(text(weight: "bold", size: 8.5pt, row.label)).width
      if w > acc { w } else { acc }
    })

    let col_gap = 0.2cm
    let available_for_boxes = calc.max(size.width - label_col_width - col_gap, 0pt)

    let cells = rows.map(row => {
      let safe_count = calc.max(row.count, 1)
      let max_box_width = calc.max(
        (available_for_boxes - calc.max(safe_count - 1, 0) * cfg.box_gap) / safe_count,
        0.2cm,
      )
      let row_box_width = calc.min(cfg.box_width, max_box_width)

      (
        [#box(height: cfg.box_height, inset: 0pt)[#align(right + horizon)[#text(weight: "bold", size: 8.5pt)[#row.label]]]],
        [#align(left)[#_id-row(
          row.count,
          row_box_width,
          cfg.box_height,
          cfg.box_gap,
          cfg.box_stroke,
          marker-key: row.key,
          emit-marker: emit,
        )]],
      )
    }).flatten()

    box(width: 100%)[
      #move(dx: -0.32cm)[
        #grid(
          columns: (label_col_width, 1fr),
          column-gutter: col_gap,
          row-gutter: 0.08cm,
          ..cells,
        )
      ]
    ]
  })
}

#let _header(cfg) = context {
  let page-num = counter(page).get().first()
  let odd = calc.rem(page-num, 2) == 1

  [
    // Corner dots use place() so they are out of flow (like prototype)
    #place(top + left, dx: 0cm, dy: 0.21cm)[#_corner-dot(cfg.corner_radius)]
    #place(top + right, dx: 0cm, dy: 0.21cm)[#_corner-dot(cfg.corner_radius)]
    // Vertical space to skip past the corner dots area
    #v(1.18cm)
    #if odd [
      #align(center + top)[#_id-header(cfg, page-num)]
    ]
  ]
}

#let _footer(cfg) = context {
  let current = counter(page).get().first()
  let total = counter(page).final().first()

  grid(
    columns: (1fr, auto, 1fr),
    align: (left, center, right),
    [#align(left + bottom)[#_corner-dot(cfg.corner_radius)]],
    [#text(size: 10pt)[#current / #total]],
    [#align(right + bottom)[#_corner-dot(cfg.corner_radius)]],
  )
}
