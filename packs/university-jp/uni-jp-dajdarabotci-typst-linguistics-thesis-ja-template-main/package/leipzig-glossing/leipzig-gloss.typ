/*
  Copyright (C) 2023 Gregory Shuflin
  Licensed under the MIT License.

  Original Project: typst-leipzig-glossing
  https://code.everydayimshuflin.com/greg/typst-lepizig-glossing
  Original Source:
  https://code.everydayimshuflin.com/greg/typst-lepizig-glossing/src/commit/92559deb83ba27e2fcc72c7bdf547b5a68d665e6

  See the LICENSE file in this directory for the full license text.
  Modified by Dai Miyanishi (2026):
  - Changed numbering format to "(1)", "(1a)"
  - Removed `label-supplement` on subexample
  - Changed the layout method from stack to grid for position accuracy
*/

#import "abbreviations.typ"

// ╭─────────────────────╮
// │ Interlinear glosses │
// ╰─────────────────────╯

#let build-gloss(item-spacing, formatters, gloss-line-lists) = {
  assert(gloss-line-lists.len() > 0, message: "Gloss line lists cannot be empty")

  let len = gloss-line-lists.at(0).len()

  for line in gloss-line-lists {
    assert(line.len() == len)
  }

  assert(
    formatters.len() == gloss-line-lists.len(),
    message: "The number of formatters and the number of gloss line lists should be equal",
  )

  let make-item-box(..args) = {
    box(stack(dir: ttb, spacing: 0.5em, ..args))
  }

  for item-index in range(0, len) {
    let args = ()
    for (line-idx, formatter) in formatters.enumerate() {
      let formatter-fn = if formatter == none {
        x => x
      } else {
        formatter
      }

      let item = gloss-line-lists.at(line-idx).at(item-index)
      args.push(formatter-fn(item))
    }
    make-item-box(..args)
    if item-index < len - 1 {
      h(item-spacing)
    }
  }
}

// Typesets the internal part of the interlinear glosses. This function does not deal with the external matters of numbering and labelling; which are handled by `example()`.
#let gloss(
  header: none,
  header-style: none,
  source: (),
  source-style: none,
  transliteration: none,
  transliteration-style: none,
  morphemes: none,
  morphemes-style: none,
  additional-lines: (), //List of list of content
  translation: none,
  translation-style: none,
  item-spacing: 1em,
) = {
  assert(
    type(source) == array,
    message: "source needs to be an array; perhaps you forgot to type `(` and `)`, or a trailing comma?",
  )

  if morphemes != none {
    assert(
      type(morphemes) == array,
      message: "morphemes needs to be an array; perhaps you forgot to type `(` and `)`, or a trailing comma?",
    )
    assert(source.len() == morphemes.len(), message: "source and morphemes have different lengths")
  }

  if transliteration != none {
    assert(transliteration.len() == source.len(), message: "source and transliteration have different lengths")
  }

  let gloss-items = {
    if header != none {
      if header-style != none {
        header-style(header)
      } else {
        header
      }
      linebreak()
    }

    let formatters = (source-style,)
    let gloss-line-lists = (source,)

    if transliteration != none {
      formatters.push(transliteration-style)
      gloss-line-lists.push(transliteration)
    }

    if morphemes != none {
      formatters.push(morphemes-style)
      gloss-line-lists.push(morphemes)
    }

    for additional in additional-lines {
      formatters.push(none) //TODO fix this
      gloss-line-lists.push(additional)
    }

    build-gloss(item-spacing, formatters, gloss-line-lists)

    if translation != none {
      linebreak()

      if translation-style == none {
        translation
      } else {
        translation-style(translation)
      }
    }
  }
  align(left)[#gloss-items]
}



// ╭─────────────────────╮
// │ Linguistic examples │
// ╰─────────────────────╯

#let example-count = counter("example-count")

#let example(
  label: none,
  label-supplement: [example],
  gloss-padding: 1em,
  left-padding: 0.5em,
  numbering: false,
  breakable: false,
  num-pattern: "(1)",
  sub-num-pattern: "a.",
  ..args,
) = {
  let add-subexample(subexample, count) = {
    let subexample-internal = subexample
    if "label" in subexample-internal {
      let _ = subexample-internal.remove("label")
    }
    if "label-supplement" in subexample-internal {
      let _ = subexample-internal.remove("label-supplement")
    }
    [
      #figure(
        kind: "subexample",
        numbering: it => [#example-count.display("(1")#std.numbering("a)", count)],
        outlined: false,
        supplement: it => {
          if "label-supplement" in subexample { return subexample.label-supplement } else { return none }
        },
        grid(
          columns: 2,
          column-gutter: left-padding,
          std.numbering(sub-num-pattern, count), gloss(..subexample-internal),
        ),
      ) #if "label" in subexample { std.label(subexample.label) }
    ]
  }

  if numbering {
    example-count.step()
  }

  let example-number = if numbering {
    [#context example-count.display(num-pattern)]
  } else {
    none
  }
  let cells = ()
  if args.pos().len() == 1 {
    cells.push(
      (example-number, gloss(..arguments(..args.pos().at(0)))),
    )
  } else {
    let row = args.pos().len()
    if "header" in args.named() {
      row += 1
      cells.push(args.named().header)
    }
    cells.insert(0, grid.cell(rowspan: row, example-number))
    for (i, subexample) in args.pos().enumerate(start: 1) {
      cells.push(
        add-subexample(subexample, i),
      )
    }
  }
  [
    #show figure: set align(left)
    #figure(
      kind: "example",
      numbering: it => [#example-count.display("(1)")],
      outlined: false,
      supplement: label-supplement,
      grid(
        columns: 2,
        row-gutter: 1em,
        inset: ((left: gloss-padding), (left: left-padding)),
        ..cells.flatten()
      ),
    ) #if label != none { std.label(label) }
  ]
}

#let numbered-example = example.with(numbering: true)
