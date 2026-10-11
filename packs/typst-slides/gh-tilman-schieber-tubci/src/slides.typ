// Presentation slides, built on polylux.
#import "@preview/polylux:0.4.0"
#import "colors.typ": tub-rgb
#import "core.typ": band, config, cover, slant, theme-fill, tub-logo

#let _margin = 14mm
#let _title-size = 24pt
#let _small-size = 14pt

// "Seite 3", or "Page 3" in an English deck.
#let _page-label = context {
  if config.get().lang == "de" [Seite] else [Page]
  [ ]
  polylux.toolbox.slide-number
}

#let _sublogo(width, inset) = context {
  let sublogo = config.get().sublogo
  if sublogo != none {
    set image(width: width)
    place(bottom + right, pad(inset, sublogo))
  }
}

// Line at the bottom of a slide: page number, then the footer text.
// Lives in the page footer, which is laid out after the slide has counted.
#let _footer-line(with-footer: true) = place(bottom + left, dy: -5mm, {
  set text(fill: white, size: _small-size)
  _page-label
  if with-footer { h(1cm); context config.get().footer }
})

/// Highlights text in TU red.
#let alert(body) = context text(fill: config.get().palette.red, body)

/// Presentation setup, use as `#show: tub-slides.with(..)`.
///
/// - theme: gradient or colour name, or any colour/gradient
/// - footer: text shown next to the page number
/// - sublogo: content, usually `image("..")` of a white institute logo
#let tub-slides(
  aspect-ratio: "16-9",
  theme: "blue-violet",
  footer: none,
  sublogo: none,
  lang: "de",
  font: "Muli",
  body,
) = {
  config.update(cfg => cfg + (theme: theme, lang: lang, footer: footer, sublogo: sublogo))

  set page(
    paper: "presentation-" + aspect-ratio,
    margin: (x: _margin, top: 10mm, bottom: 28mm),
    footer-descent: 0pt,
    footer: _footer-line(),
    background: {
      context band(theme-fill(config.get(), auto), 87% * page.height, page.height, slant-top: true)
      _sublogo(15mm, 2mm)
    },
  )
  set text(font: font, size: 18pt, fill: tub-rgb.dark-gray, lang: lang)
  set par(leading: 0.5em)
  set list(marker: [–])
  show heading: set text(size: 1em, weight: "bold")
  show heading: set block(below: 0.8em)

  body
}

/// Opening slide with the long logo, an optional picture and the title.
#let title-slide(title: none, subtitle: none, picture: none, theme: auto) = {
  // Fractions of the page height: end of the white top, start of the theme.
  let (white-end, theme-top) = (20%, 54%)
  set page(
    margin: (x: _margin, top: 8mm, bottom: 10mm),
    footer: none,
    background: context {
      let h = page.height
      let fill = theme-fill(config.get(), theme)
      if picture == none {
        band(fill, white-end * h, h, slant-top: true)
      } else {
        place(top + left, dy: white-end * h, cover(picture, page.width, (theme-top - white-end + slant) * h))
        band(white, 0pt, white-end * h, slant-bottom: true)
        band(fill, theme-top * h, h, slant-top: true)
      }
      _sublogo(22mm, 5mm)
    },
  )
  polylux.slide({
    place(top + right, tub-logo(width: 60mm))
    set text(fill: white)
    place(bottom + left, block(width: 85%, {
      par(leading: 0.4em, text(size: 28pt, weight: "bold", title))
      if subtitle != none { par(subtitle) }
    }))
  })
}

/// A regular content slide.
#let slide(title: none, body) = polylux.slide({
  place(top + right, tub-logo(kind: "short", width: 25mm))
  block(
    width: 100% - 32mm,
    height: 19mm,
    below: 8mm,
    align(horizon, alert(text(size: _title-size, weight: "bold", title))),
  )
  body
})

/// A slide filled with the theme, for one statement, formula or figure.
#let focus-slide(title: none, theme: auto, body) = {
  set page(
    fill: none,
    margin: (x: _margin, top: 10mm, bottom: 16mm),
    footer: _footer-line(with-footer: false),
    background: context band(theme-fill(config.get(), theme), 0pt, page.height),
  )
  set text(fill: white)
  polylux.slide({
    if title != none {
      block(height: 19mm, align(horizon, text(size: _title-size, weight: "bold", title)))
    }
    align(center + horizon, text(size: 1.5em, body))
  })
}

/// Announces a new part of the talk.
#let section-slide(title) = {
  polylux.toolbox.register-section(title)
  focus-slide(align(left, text(size: 28pt, weight: "bold", title)))
}
