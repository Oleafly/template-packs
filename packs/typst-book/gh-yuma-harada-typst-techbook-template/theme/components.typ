#import "@preview/pintorita-neo:0.1.0" as pintorita
#import "colors.typ": border, ink, surface, surface-strong
#import "typography.typ": sans-font

#let code-block(
  source,
  lang: none,
  caption: none,
) = {
  let code = raw(
    source,
    block: true,
    lang: lang,
  )

  if caption == none {
    code
  } else {
    figure(
      code,
      kind: raw,
      caption: caption,
    )
  }
}

#let callout(
  title,
  body,
  background: none,
  frame-stroke: 0.5pt + border,
  accent-stroke: 0.5pt + border,
  title-weight: "bold",
) = block(
  width: 100%,
  breakable: true,
  above: 0.7em,
  below: 0.7em,
  fill: background,
  stroke: (
    top: frame-stroke,
    right: frame-stroke,
    bottom: frame-stroke,
    left: accent-stroke,
  ),
  inset: (x: 9pt, y: 7pt),
  radius: 3pt,
  [
    #text(
      font: sans-font,
      weight: title-weight,
      fill: ink,
    )[#title]

    #v(0.35em)
    #body
  ],
)

#let note(body) = callout(
  [注記],
  body,
  background: none,
  frame-stroke: 0.5pt + border,
  accent-stroke: 0.5pt + border,
)

#let tip(body) = callout(
  [ヒント],
  body,
  background: surface,
  frame-stroke: 0.5pt + border,
  accent-stroke: 3pt + ink,
  title-weight: "black",
)

#let warning(body) = callout(
  [注意],
  body,
  background: surface-strong,
  frame-stroke: 1pt + ink,
  accent-stroke: 3pt + ink,
  title-weight: "black",
)

#let diagram(
  body,
  caption: none,
) = {
  let centered-body = align(center, body)

  if caption == none {
    centered-body
  } else {
    figure(
      centered-body,
      kind: image,
      caption: caption,
    )
  }
}

#let er-diagram(
  source,
  caption: none,
  alt: none,
  width: 100%,
) = {
  let body = pintorita.render(
    source,
    style: "default",
    font: sans-font,
    width: width,
    alt: alt,
  )

  if caption == none {
    align(center, body)
  } else {
    figure(
      align(center, body),
      kind: image,
      caption: caption,
    )
  }
}
