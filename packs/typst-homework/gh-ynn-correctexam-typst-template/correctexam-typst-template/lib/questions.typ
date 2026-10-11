#import "i18n.typ": _i18n, _points-label
#import "markers.typ": _correctexam-config, _exercise-counter, _question-counter, _sub-counter, _emit-marker, _collect-markers
#import "utils.typ": _paper-size-cm

#let total-pages() = context {
  counter(page).final().first()
}

#let exam-title(title, subtitle: ()) = {
  v(0.25cm)
  align(center)[
    #text(weight: "bold", size: 20pt)[#title]
    #if subtitle.len() > 0 [
      #v(0.2cm)
      #for line in subtitle [
        #text(size: 11pt)[#line]
        #linebreak()
      ]
    ]
  ]
  v(0.35cm)
}

#let exercise(points, title: none) = context {
  let ex = _exercise-counter.get().first() + 1
  _exercise-counter.step()
  _sub-counter.update(1)

  let cfg = _correctexam-config.get()
  let suffix = if title == none { [] } else { [-- #title] }

  [
    #v(0.3cm)
    #text(weight: "bold", size: 13pt)[
      #_i18n(cfg.lang, "exercise") #h(0.3em) #ex #suffix
      #h(0.6em)
      (#_points-label(cfg.lang, points))
    ]
    #v(0.2cm)
  ]
}

#let question(body, label: none) = context {
  let q = _question-counter.get().first() + 1
  _question-counter.step()
  _sub-counter.update(1)

  let cfg = _correctexam-config.get()
  let q-prefix = _i18n(cfg.lang, "question-prefix")
  let anchor = figure(
    kind: "question",
    supplement: [#q-prefix],
    numbering: "1",
    caption: none,
    outlined: false,
  )[]

  [
    #place(hide[
      #if label == none {
        anchor
      } else {
        [#anchor #label]
      }
    ])
    #text(weight: "bold")[#(q-prefix + "." + str(q))]
    #h(0.35em)
    #body
    #v(0.2cm)
  ]
}

#let _answer-line(line-spacing, dot-color) = {
  block(width: 100%, height: line-spacing)[
    #if dot-color != white [
      #align(bottom + left)[
        #line(
          length: 100%,
          stroke: (paint: dot-color, thickness: 0.35pt, dash: "dotted"),
        )
      ]
    ]
  ]
}

#let _answer-column(width, lines, line-spacing, dot-color, height: auto) = {
  let effective-lines = if height == auto { int(calc.max(lines, 1)) } else { 0 }

  box(
    width: width,
    height: height,
    inset: (x: 0.16cm, y: 0.2cm),
    stroke: (paint: black, thickness: 0.4pt),
  )[
    #if effective-lines > 0 [
      #stack(
        spacing: 0pt,
        ..range(effective-lines).map(_ => _answer-line(line-spacing, dot-color)),
      )
    ]
  ]
}

#let answer-box(lines: 3, height: auto, columns: 1, line-spacing: 1.5em, dot-color: black) = context {
  let q = _question-counter.get().first()
  let sub = _sub-counter.get().first()
  let ex = _exercise-counter.get().first()
  let key = "correctexam-answer-" + str(q) + "-" + str(sub) + "-" + str(ex)

  [
    #layout(size => {
      let safe-cols = int(calc.max(columns, 1))
      let zone-width = size.width
      let col-width = zone-width / safe-cols
      let zone = stack(
        dir: ltr,
        spacing: 0pt,
        ..range(safe-cols).map(_ => _answer-column(
          col-width,
          lines,
          line-spacing,
          dot-color,
          height: height,
        )),
      )
      let zone-height = measure(zone).height

      [
        #_emit-marker(key, zone-width, zone-height)
        #zone
      ]
    })
    #_sub-counter.step()
    #v(0.35cm)
  ]
}

#let answer-content(body) = context {
  let q = _question-counter.get().first()
  let sub = _sub-counter.get().first()
  let ex = _exercise-counter.get().first()
  let key = "correctexam-answer-" + str(q) + "-" + str(sub) + "-" + str(ex)

  [
    #layout(size => {
      let zone = box(
        width: size.width,
        inset: (x: 0.16cm, y: 0.14cm),
        stroke: (paint: black, thickness: 0.4pt),
      )[
        #body
      ]
      let zone-height = measure(zone).height

      [
        #_emit-marker(key, size.width, zone-height)
        #zone
      ]
    })
    #_sub-counter.step()
    #v(0.35cm)
  ]
}

#let inline-answer(chars: 10) = context {
  let q = _question-counter.get().first()
  let sub = _sub-counter.get().first()
  let ex = _exercise-counter.get().first()
  let key = "correctexam-answer-" + str(q) + "-" + str(sub) + "-" + str(ex)
  let safe-chars = int(calc.max(chars, 1))
  let width = safe-chars * 0.45cm + 0.3cm
  let height = 0.68cm

  [
    #box(
      width: width,
      height: height,
      inset: 0pt,
      fill: luma(245),
      stroke: (paint: gray, thickness: 0.35pt),
      baseline: 35%,
    )[
      #_emit-marker(key, width, height)
    ]
    #hide(_sub-counter.step())
  ]
}

#let question-block(body, answer, label: none) = {
  block(breakable: false)[
    #question(label: label)[#body]
    #answer
  ]
}

#let _panic-if(issues) = {
  if issues.len() > 0 {
    panic("correctexam validation failed:\n" + issues.join("\n"))
  }
}

#let validate-exam() = context {
  let markers = _collect-markers()
  let cfg = _correctexam-config.get()
  let bounds = _paper-size-cm(cfg.paper)

  let keys = (:)
  let answer-count = 0
  let question-ids = (:)
  let issues = ()

  for marker in markers {
    let key = marker.key
    if keys.at(key, default: false) {
      issues.push("duplicate key: " + key)
    } else {
      keys.insert(key, true)
    }

    if marker.x < 0 or marker.y < 0 or marker.w <= 0 or marker.h <= 0 {
      issues.push("invalid coordinates for key: " + key)
    }

    if marker.x + marker.w > bounds.w + 0.001 {
      issues.push("marker exceeds page width: " + key)
    }

    if marker.y > bounds.h + 0.001 {
      issues.push("marker exceeds page height: " + key)
    }

    if marker.p < 1 {
      issues.push("invalid page number for key: " + key)
    }

    let chunks = key.split("-")
    if chunks.len() >= 5 and chunks.at(0) == "correctexam" and chunks.at(1) == "answer" {
      answer-count += 1
      let qid = int(chunks.at(2))
      question-ids.insert(str(qid), true)
    }
  }

  if answer-count == 0 {
    issues.push("no answer markers were emitted")
  }

  if cfg.mode == "withid" or cfg.mode == "noid" {
    if not keys.at("correctexam-lastname", default: false) {
      issues.push("missing identity marker: correctexam-lastname")
    }
    if not keys.at("correctexam-firstname", default: false) {
      issues.push("missing identity marker: correctexam-firstname")
    }
  }

  if cfg.mode == "withid" or cfg.mode == "anonymous" {
    if not keys.at("correctexam-stdid", default: false) {
      issues.push("missing identity marker: correctexam-stdid")
    }
  }

  let q-seq = question-ids.keys().map(k => int(k)).sorted()
  for i in range(q-seq.len()) {
    if q-seq.at(i) != i + 1 {
      issues.push("non-contiguous question numbering in answer markers")
      break
    }
  }

  _panic-if(issues)
}
