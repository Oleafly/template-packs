#import "utils.typ": _cm

#let _correctexam-config = state("correctexam-config", (
  lang: "fr",
  mode: "withid",
  lastname_boxes: 19,
  firstname_boxes: 19,
  id_boxes: 8,
  box_width: 0.78cm,
  box_height: 0.88cm,
  box_gap: 0.5mm,
  box_stroke: 0.35pt + luma(180),
  marker_top_offset: 0.55cm,
  paper: "a4",
  margin: (top: 4.5cm, bottom: 1.7cm, left: 1.3cm, right: 1.3cm),
  font: "Libertinus Serif",
  font_size: 11pt,
  corner_radius: 3.6mm,
))

#let _exercise-counter = counter("correctexam-exercise")
#let _question-counter = counter("correctexam-question")
#let _sub-counter = counter("correctexam-sub")

#let _reset-counters() = {
  _exercise-counter.update(0)
  _question-counter.update(0)
  _sub-counter.update(1)
}

#let _emit-marker(key, w, h, type: none, extra: (:), y-shift: 0pt) = context {
  let pos = here().position()
  let base = (
    key: key,
    x: _cm(pos.x),
    y: _cm(pos.y + y-shift + h),
    w: _cm(w),
    h: _cm(h),
    p: pos.page,
  )
  let payload = if type == none { base + extra } else { base + (type: type) + extra }
  [#metadata(payload) <correctexam-meta>]
}

#let _collect-markers() = query(<correctexam-meta>).map(e => e.value)
