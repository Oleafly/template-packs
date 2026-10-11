#import "attach.typ": _attach-markers
#import "header.typ": _header, _footer
#import "markers.typ": _correctexam-config, _reset-counters
#import "utils.typ": _normalize-mode

#let correctexam(
  body,
  lang: "fr",
  mode: "withid",
  lastname-boxes: 19,
  firstname-boxes: 19,
  id-boxes: 8,
  box-width: 0.78cm,
  box-height: 0.88cm,
  box-gap: 0.5mm,
  box-stroke: 0.35pt + luma(180),
  marker-top-offset: 0.55cm,
  paper: "a4",
  margin: (top: 4.5cm, bottom: 1.7cm, left: 1.3cm, right: 1.3cm),
  font: "Libertinus Serif",
  font-size: 11pt,
  corner-radius: 3.6mm,
) = {
  let normalized_mode = _normalize-mode(mode)
  let identity_rows = if normalized_mode == "anonymous" {
    1
  } else if normalized_mode == "noid" {
    2
  } else {
    3
  }
  // Use the margin as-is — header-ascent (default 30%) provides the buffer
  // between header content and body, matching the prototype approach.
  let effective_margin = margin

  let cfg = (
    lang: lang,
    mode: normalized_mode,
    lastname_boxes: lastname-boxes,
    firstname_boxes: firstname-boxes,
    id_boxes: id-boxes,
    box_width: box-width,
    box_height: box-height,
    box_gap: box-gap,
    box_stroke: box-stroke,
    marker_top_offset: marker-top-offset,
    paper: paper,
    margin: effective_margin,
    font: font,
    font_size: font-size,
    corner_radius: corner-radius,
  )

  [
    #_correctexam-config.update(cfg)
    #_reset-counters()

    #set page(
      paper: paper,
      margin: effective_margin,
      header: _header(cfg),
      footer: _footer(cfg),
    )
    #set text(font: font, size: font-size)
    #set par(justify: true)

    #body

    #_attach-markers()
  ]
}
