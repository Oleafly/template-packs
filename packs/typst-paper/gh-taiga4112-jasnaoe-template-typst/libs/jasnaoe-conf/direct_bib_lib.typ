#let (
  bibliography-list,
  bib-item,
  use-bib-item-ref,
) = {
  let title-default = "Bibliography"
  let numbering-default = "[1]"
  let figure-kind = "bx-bib-item"
  let end-mark = <bx-bib-end>

  let bib-counter = counter(figure.where(kind: figure-kind))
  let max-key-width = state("bx-max-key-width", 0pt)

  let get-numbering(list-num, fig-num) = {
    // When the numbering for listing is given, it is used.
    // Otherwise the figure.numbering is applied,
    // but adjust it if it is at default.
    if list-num != auto { list-num }
    else if fig-num == "1" { "[1]" }
    else { fig-num }
  }

  let get-auto-key-width() = {
    let marks = query(selector(end-mark).after(here()))
    if marks.len() == 0 { return max-key-width.final() }
    max-key-width.at(marks.first().location())
  }

  // Makes the key string.
  let format-key(num, count, key, supplement) = {
    // If key is not given, count should be shown.
    let val = if key != none { key } else { count }
    // Delegate if numbering is a function.
    if type(num) == function {
      return num(val, supplement)
    }

    // Parse the pattern.
    let pos = none
    let cs = num.codepoints()
    let pos = cs.position(c => {
      c in "1aAiI" or not ("2" in numbering(c + "1", 2, 1))
    })
    if pos == none { return num } // abnormal

    // Replace the counter symbol with the real value.
    if type(val) == int {
      val = numbering(cs.at(pos), val)
    }
    if supplement != none {
      val = { val; ", "; supplement }
    }
    cs.at(pos) = val
    cs.join("")
  }

  // Prints the bibliography list.
  let bibliography-list(
    title: title-default,
    heading-level: 1,
    numbering: auto,
    key-width: auto,
    body-indent: 0.65em,
    spacing: auto,
    adjust-spacing: auto,
    body,
  ) = {
    let use-adjuster = (
      if adjust-spacing != auto { adjust-spacing == true }
      else { spacing == auto }
    )

    // Print the heading.
    if heading-level != none {
      let head = heading(level: heading-level, numbering: none, title)
      let centered_head = block(width: 100%, align(center, head))
      if use-adjuster {
        block(below: 0pt, centered_head)
      } else {
        centered_head
      }
    }

    // The figure (i.e. bib-item) is laid out here.
    show figure.where(kind: figure-kind): it => {
      assert(it.body.func() == metadata)

      let width = (
        if key-width != auto { key-width }
        else { get-auto-key-width() }
      )

      let count = it.counter.get().at(0)
      let data = it.body.value
      let numbering = get-numbering(numbering, it.numbering)
      let key = format-key(numbering, count, data.key, none)
      let kbox = box(width: width, {key; h(1fr)})
      let entry = enum(
        numbering: _ => kbox, // simply show the result
        body-indent: body-indent,
        tight: true,
        enum.item(count, data.body),
      )
      align(start + top, (
        if spacing == auto {
          block(entry)
        } else {
          block(entry, above: spacing, below: spacing)
        }
      ))

      let metric = measure(key)
      max-key-width.update(val => calc.max(val, metric.width))
    }

    if use-adjuster {
      block(height: 0pt)
    }

    max-key-width.update(0pt)
    body
    [#metadata(none)#end-mark]
  }

  // The helper for bib-item.
  let do-bib-item(key, label, body) = {
    // Make a figure with the data.
    let fig = figure(
      kind: figure-kind,
      supplement: key,
      outlined: false,
      metadata((
        key: key,
        body: body,
      )),
    )
    // Then output with the label.
    [#fig#label]

    if key != none {
      bib-counter.update(v => v - 1) // no increment
    }
  }

  // A Bibliography entry.
  let bib-item(
    key: none,
    ..args, // [label,] body
  ) = {
    args = args.pos()
    assert(
      args.len() >= 1,
      message: "missing argument in 'bib-item': body",
    )
    assert(
      args.len() <= 2,
      message: "unexpected argument in 'bib-item'",
    )

    let (lbl, body) = if (args.len() == 1) {
      (none,) + args
    } else { args }
    assert(
      lbl == none or type(lbl) == label,
      message: "'label' must be none or label, found " + str(type(lbl)),
    )
    do-bib-item(key, lbl, body)
  }

  let use-bib-item-ref(
    numbering: numbering-default,
    body,
  ) = {
    show figure.where(kind: figure-kind): set figure(
      numbering: numbering,
    )
    show ref: it => {
      let el = it.element
      if not (el != none and
          el.func() == figure and el.kind == figure-kind) {
        return it
      }

      let count = bib-counter.at(el.location()).at(0)
      let sup = it.supplement
      if sup == auto { sup = none }
      format-key(el.numbering, count, el.supplement, sup)
    }

    body
  }

  ( // export
    bibliography-list,
    bib-item,
    use-bib-item-ref,
  )
}