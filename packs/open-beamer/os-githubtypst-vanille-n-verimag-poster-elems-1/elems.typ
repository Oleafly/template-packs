#let make-box-with-boxed-title(title, body, width: 100%, palette: (:), title-align: (:)) = {
  import "@preview/showybox:2.0.4": showybox
  showybox(
    width: width,
    frame: (
      radius: (top-right: 2cm),
      border-color: palette.title,
      thickness: 5pt,
      title-color: palette.title,
      body-color: palette.body,
      title-inset: (x: 3cm, y: 5mm),
    ),
    above: 10mm,
    below: 10mm,
    title-style: (
      boxed-style: (
        anchor: title-align,
        radius: (top-right: 2cm),
      ),
    ),
    shadow: (offset: 8pt),
    title: title,
    body,
  )
}

#let make-box(style: "unimpl", ..params) = {
  let fun = (
    "boxed": make-box-with-boxed-title,
  ).at(style)
  fun(..params)
}

#let make-boxes(..args) = {
  let boxes = {
    (:)
    for (key, params) in args.named().boxes {
      ("" + key: (title, body, ..extra) => {
        make-box(title, body, ..params)
      })
    }
  }
  boxes
}

#let author(
  capitalize-last: false,
  groups: (:),
  first: [Firstname],
  last: [Lastname],
  group: "default",
  note: [],
) = context {
  set text(
    size: groups.at(group).size * text.size,
    fill: groups.at(group).color,
  )
  let last = if capitalize-last { upper(last) } else { last }
  [#super[#note]#first #last]
}
