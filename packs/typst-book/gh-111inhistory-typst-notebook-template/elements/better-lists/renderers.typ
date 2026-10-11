/// Renderer implementations for better-lists element variants.
#import "/utils/anchor.typ": anchor-helper
#import "/utils/content-utils.typ": sequence, split-first-paragraph

// Tracks the current parent numbering path.
// `enum` stores real numbers, while `list` uses `0` as a placeholder.
#let parents = state("__list-enum-internal", ())
// A shared series keeps list instance IDs unique across renderer styles.
#let better-list-counter = counter("__better-list")

/// Collect tight nested item nodes and rebuild them as an explicit container.
#let tight-rest(rest, kind) = {
  if rest == none {
    return none
  }

  let items = ()
  if repr(rest.func()) == "item" {
    items.push(rest)
  } else if rest.func() == sequence {
    for part in rest.children {
      if repr(part.func()) == "item" {
        items.push(part)
      } else if part.func() != [ ].func() {
        return rest
      }
    }
  } else {
    return rest
  }

  if items.len() == 0 {
    return none
  }

  if kind == "enum" {
    enum(..items.map(item => enum.item(item.body)))
  } else {
    list(..items.map(item => list.item(item.body)))
  }
}

/// Render first-line-indent lists and enums without a grid layout.
#let first-line-indent(kind, settings) = it => context {
  let item-spacing = it.spacing
  let indent = it.indent
  let body-indent = it.body-indent
  let marker = none
  let number = none
  let delta = 1
  let level = parents.get().len() + 1

  set par(spacing: item-spacing, first-line-indent: 0em)
  better-list-counter.step()

  if kind == "list" {
    let marker-level = level - 1
    let pattern = it.marker
    marker = if type(pattern) == array {
      pattern.at(calc.rem-euclid(marker-level, pattern.len()))
    } else if type(pattern) == function {
      pattern(marker-level)
    } else {
      pattern
    }
  } else {
    number = if it.start != auto {
      it.start
    } else if (
      it.children.first().has("number") and it.children.first().number != auto
    ) {
      it.children.first().number
    } else if it.reversed {
      it.children.len()
    } else {
      1
    }
    delta = if it.reversed { -1 } else { 1 }
  }

  let ret = []
  for child in it.children {
    let parent-part = if kind == "enum" {
      number = if child.has("number") and child.number != auto {
        child.number
      } else {
        number
      }
      let num = numbering(it.numbering, ..parents.get(), number)
      if settings.post-numbering != none {
        num = settings.post-numbering(num)
      }
      num
    } else {
      marker
    }

    let align = if kind == "enum" {
      settings.numbering-align
    } else {
      settings.marker-align
    }
    let left-back-len = if align == "right" {
      body-indent + measure(parent-part).width
    } else {
      indent - body-indent
    }

    let child-parent = if kind == "enum" { number } else { 0 }
    let split = split-first-paragraph(child.body)
    let body = if it.tight {
      {
        // Tight children are emitted as bare item nodes by Typst.
        parents.update(arr => arr + (child-parent,))
        text(
          {
            h(indent)
            h(-left-back-len)
            parent-part
            h(body-indent)
            split.first
          },
          cjk-latin-spacing: none,
        )
        tight-rest(split.rest, kind)
        parents.update(arr => arr.slice(0, -1))
      }
    } else {
      {
        parents.update(arr => arr + (child-parent,))
        par(
          first-line-indent: (all: true, amount: indent),
        )[
          #set text(cjk-latin-spacing: none)
          #{
            h(-left-back-len)
            parent-part
            h(body-indent)
            split.first
          }
        ]
        set par(first-line-indent: (amount: indent, all: true))
        split.rest
        parents.update(arr => arr.slice(0, -1))
      }
    }

    if kind == "enum" {
      number += delta
    }
    if level > 1 {
      ret += pad(left: indent, body) + parbreak()
    } else {
      ret += body + parbreak()
    }
  }
  ret
}

/// Render block-indent lists and enums using one local grid template.
#let block-indent(kind, settings) = it => context {
  let item-spacing = it.spacing
  let indent = it.indent
  let body-indent = it.body-indent
  let connector = if settings.connector == none {
    (enabled: false, position: 0pt, stroke: none)
  } else {
    assert(
      type(settings.connector) == dictionary,
      message: "connector must be a dictionary or none, found " + repr(type(settings.connector)),
    )
    settings.connector
  }

  let marker = none
  let number = none
  let delta = 1
  if kind == "list" {
    let level = parents.get().len()
    let pattern = it.marker
    marker = if type(pattern) == array {
      pattern.at(calc.rem-euclid(level, pattern.len()))
    } else if type(pattern) == function {
      pattern(level)
    } else {
      pattern
    }
  } else {
    number = if it.start != auto {
      it.start
    } else if (
      it.children.first().has("number") and it.children.first().number != auto
    ) {
      it.children.first().number
    } else if it.reversed {
      it.children.len()
    } else {
      1
    }
    delta = if it.reversed { -1 } else { 1 }
  }

  better-list-counter.step()
  let prefix = "_better-list-" + str(better-list-counter.get().first()) + "-"
  let (create: body-create, findpos: body-pos) = anchor-helper(prefix + "body-")
  let (create: label-create, findpos: label-pos) = anchor-helper(prefix + "label-")

  set par(spacing: item-spacing, first-line-indent: 0em)

  let cells = ()
  for (i, child) in it.children.enumerate() {
    let parent-part = if kind == "enum" {
      number = if child.has("number") and child.number != auto {
        child.number
      } else {
        number
      }
      let num = numbering(it.numbering, ..parents.get(), number)
      if settings.post-numbering != none {
        num = settings.post-numbering(num)
      }
      num
    } else {
      marker
    }
    let label = parent-part + h(body-indent)
    let child-parent = if kind == "enum" { number } else { 0 }
    let align = if kind == "enum" {
      settings.numbering-align
    } else {
      settings.marker-align
    }
    let body = {
      parents.update(arr => arr + (child-parent,))
      let split = split-first-paragraph(child.body)
      text(split.first, top-edge: "ascender")
      split.rest
      parents.update(arr => arr.slice(0, -1))
    }

    cells.push(grid.cell(colspan: 4, inset: 0pt)[#label-create(i)])
    cells.push(grid.cell(
      colspan: 3,
      align: if align == "right" { right + top } else { left + top },
    )[
      #box[#context {
        let body-at = body-pos(i)
        let label-at = label-pos(i)
        let drop = if body-at.page == label-at.page {
          body-at.y - label-at.y - measure(label).height
        } else {
          0pt
        }
        v(drop)
        label
      }]
    ])
    cells.push(grid.cell(rowspan: 2, inset: 0pt, align: left + top)[
      #set text(cjk-latin-spacing: none)
      #sym.zws#body-create(i)#body
    ])
    cells.push([])
    cells.push(grid.cell(
      stroke: if connector.enabled { connector.stroke },
      inset: 0pt,
    )[])
    cells.push([])

    if i < it.children.len() - 1 {
      cells.push(grid.cell(colspan: 4, inset: 0pt)[#parbreak()#sym.zws])
    }
    if kind == "enum" {
      number += delta
    }
  }

  let left-gap = if connector.enabled {
    indent - connector.position
  } else {
    indent
  }
  let right-gap = if connector.enabled { connector.position } else { 0pt }
  grid(
    columns: (left-gap, 0pt, right-gap, 1fr),
    rows: ((0pt, auto, auto, item-spacing) * (it.children.len() - 1) + (0pt, auto, auto)),
    align: left + top,
    ..cells,
  )
}

/// Dispatch table keyed by renderer type name.
#let renderers = (
  block-indent: (
    enum: settings => block-indent("enum", settings),
    list: settings => block-indent("list", settings),
  ),
  first-line-indent: (
    enum: settings => first-line-indent("enum", settings),
    list: settings => first-line-indent("list", settings),
  ),
)
