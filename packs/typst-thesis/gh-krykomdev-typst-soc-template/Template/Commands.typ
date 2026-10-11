#import "Config.typ": * 

#let code(content, caption: "", label: none) = {
  let fig = figure(
    content,
    caption: caption,
    kind: "code",
    supplement: code-block-label,
  )
  if label != none and label != "" {
    [#fig #std.label(label)]
  } else {
    fig
  }
}

#let code-input(content, lang: "", caption: "", label: none) = {
  code(raw(read(content), block: true, lang: lang), caption: caption, label: label)
}

#let img(src, caption: "", label: none) = {
  let fig = figure(
    image("../" + src),
    caption: caption,
    kind: "image",
  )
  if label != none and label != "" {
    [#fig #std.label(label)]
  } else {
    fig
  }
}

#let tbl(header: (), columns: auto, ..rows, caption: "", label: none) = {
  let cols = columns
  if cols == auto and header.len() > 0 {
    cols = header.len()
  }
  let fig = figure(
    table(
      columns: cols,
      table.header(..header),
      ..rows
    ),
    caption: caption,
    kind: "table",
  )
  if label != none and label != "" {
    [#fig #std.label(label)]
  } else {
    fig
  }
}

/* // TODO: fix
#let config-appendix() = {
  h1-pagebreak.update(false)
  h1-reset.update(false)

  heading(numbering: none, outlined: true)[Přílohy]

  set heading(numbering: "A.1")
  counter(heading).update(0)
  counter(figure.where(kind: image)).update(0)  // reset číslování obrázků
  counter(figure.where(kind: table)).update(0)  // reset číslování tabulek
  counter(figure.where(kind: "code")).update(0) // reset číslování kódových bloků
  counter(math.equation).update(0)              // reset číslování rovnic

  set figure(numbering: (..nums) => {
    numbering("A.1", 1, ..nums)
  })
}
*/