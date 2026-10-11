#let palette-state = state("palette", (:))

#let apply-palette(cc, body) = {
  palette-state.update(cc)
  body
}

#let structure(it) = {
  context{
    let cc = palette-state.get()
    text(fill: cc.primary, strong(it))
  }
}

#let alert(it) = {
  context{
    let cc = palette-state.get()
    text(fill: cc.secondary, strong(it))
  }
}

#let beamer-like-block = (title, body, title-fg, title-bg, body-bg, body-fg) => {
  block(below: 0.5em)[
    #block(fill: title-bg, inset: 0.7em, width: 100%, below: 0pt, radius: (top: 8pt, bottom: 0pt))[#text(
      fill: title-fg,
      size: 1.05em,
    )[#strong[#title]]]
    #block(fill: body-bg, inset: 0.7em, width: 100%, radius: (top: 0pt, bottom: 8pt))[#text(fill: body-fg)[#body]]
  ]
}

#let structure-block(title, body) = {
  context {
    let cc = palette-state.get()
    beamer-like-block(
      title,
      body,
      cc.neutral-darkest,
      cc.primary-lighter,
      cc.primary-lightest,
      cc.neutral-darkest,
    )
  }
}
#let alert-block(title, body) = {
  context {
    let cc = palette-state.get()
    beamer-like-block(
      title,
      body,
      cc.neutral-darkest,
      cc.secondary-lighter,
      cc.secondary-lightest,
      cc.neutral-darkest,
    )
  }
}
#let example-block(title, body) = {
  context {
    let cc = palette-state.get()
    beamer-like-block(
      title,
      body,
      cc.neutral-darkest,
      cc.tertiary-lighter,
      cc.tertiary-lightest,
      cc.neutral-darkest,
    )
  }
}


#let beamer-like-colorbox = (body, body-fg, body-bg) => {
  block(fill: body-bg, inset: 0.7em, width: 100%, below: 0.5em, radius: 8pt)[#text(fill: body-fg)[#body]]
}
#let structure-colorbox(body) = {
  context {
    let cc = palette-state.get()
    beamer-like-colorbox(
      body,
      cc.neutral-darkest,
      cc.primary-lightest,
    )
  }
}
#let alert-colorbox(body) = {
  context {
    let cc = palette-state.get()
    beamer-like-colorbox(
      body,
      cc.neutral-darkest,
      cc.secondary-lightest,
    )
  }
}
#let example-colorbox(body) = {
  context {
    let cc = palette-state.get()
    beamer-like-colorbox(
      body,
      cc.neutral-darkest,
      cc.tertiary-lightest,
    )
  }
}
