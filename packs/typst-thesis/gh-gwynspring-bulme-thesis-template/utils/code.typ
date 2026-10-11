#let code(caption: [], lang: "cpp", body) = {
  let lines = body.split("\n")
  let lines = if lines.len() > 0 and lines.first() == "" {
    lines.slice(1)
  } else {
    lines
  }
  let lines = if lines.len() > 0 and lines.last() == "" {
    lines.slice(0, lines.len() - 1)
  } else {
    lines
  }

  let numbered = lines
    .enumerate()
    .map(((i, line)) => (
      align(left, text(fill: gray, size: 7pt)[#(i + 1)]),
      raw(line, lang: lang),
    ))
    .join()

  figure(
    block(
      fill: luma(245),
      inset: 1em,
      radius: 4pt,
      width: 100%,
      align(left, grid(
        columns: (2em, 1fr),
        row-gutter: 4pt,
        ..numbered,
      )),
    ),
    caption: caption,
    kind: "codeblock",
    supplement: [Code],
  )
}

#let code_cpp(caption: [], body) = code(
  caption: caption,
  lang: "cpp",
  body,
)

#let code_py(caption: [], body) = code(
  caption: caption,
  lang: "py",
  body,
)

#let code_yaml(caption: [], body) = code(
  caption: caption,
  lang: "yaml",
  body,
)
