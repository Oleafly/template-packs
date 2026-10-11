// Brochures and flyers: title page, picture pages, back page.
#import "colors.typ": tub-rgb, tub-cmyk
#import "core.typ": band, config, cover, slant, theme-fill, tub-logo

// Sizes the CI prescribes per paper format.
#let formats = (
  a4: (
    margin: 15mm,
    logo-scale: 1,
    offset: 6mm,
    title: 28pt,
    subtitle: 13pt,
    info: 9pt,
    heading: 23pt,
    subheading: 13pt,
    body: 9pt,
    badge: 18pt,
  ),
  a5: (
    margin: 10mm,
    logo-scale: 0.75,
    offset: 5mm,
    title: 18pt,
    subtitle: 9pt,
    info: 7pt,
    heading: 15pt,
    subheading: 10pt,
    body: 8pt,
    badge: 13pt,
  ),
)

/// The TU Berlin claim, in German and optionally English.
#let tub-claim(bilingual: true) = context {
  set text(fill: config.get().palette.red)
  text(weight: "bold", lang: "de")[Wir haben die Ideen für die Zukunft.\ Zum Nutzen der Gesellschaft.]
  if bilingual {
    parbreak()
    text(weight: "regular", lang: "en")[We’ve got the brains for the future.\ For the benefit of society.]
  }
}

/// Document setup, use as `#show: tub-brochure.with(..)`.
///
/// - paper: "a4" or "a5"
/// - theme: gradient or colour name, or any colour/gradient
/// - cmyk: use the print palette instead of RGB
/// - numbering: page numbering pattern for inner pages, e.g. "1"
#let tub-brochure(
  paper: "a4",
  theme: "blue-green",
  cmyk: false,
  lang: "de",
  font: "Muli",
  numbering: none,
  body,
) = {
  assert(paper in formats, message: "paper must be one of: " + formats.keys().join(", "))
  let format = formats.at(paper)
  let palette = if cmyk { tub-cmyk } else { tub-rgb }
  config.update(cfg => cfg + (palette: palette, theme: theme, lang: lang, format: format))

  set page(paper: paper, margin: format.margin, numbering: numbering)
  set text(font: font, size: format.body, weight: "semibold", fill: palette.dark-gray, lang: lang)
  set par(leading: 0.4em, spacing: 0.9em)
  show heading: set block(above: 1.4em, below: 0.8em)
  show heading.where(level: 1): set text(size: format.heading, weight: "bold")
  show heading.where(level: 2): set text(size: format.subheading, weight: "semibold")
  show heading.where(level: 3): set text(size: format.body, weight: "bold")

  body
}

// The format of the surrounding document, a4 if there is none.
#let _format() = {
  let format = config.get().format
  if format == none { formats.a4 } else { format }
}

/// Cover page: logo, optional picture and a themed area with the title.
///
/// - picture: content, usually `image("..")`; cropped to fit
/// - logos: partner logos shown at the bottom
#let title-page(
  title: none,
  subtitle: none,
  info: none,
  picture: none,
  logos: (),
  theme: auto,
) = {
  // Fractions of the page height where the picture and the themed area begin.
  let picture-top = 15%
  let theme-top = if picture == none { 17% } else { 55% }

  let background = context {
    let (h, offset) = (page.height, _format().offset)
    if picture != none {
      let y = picture-top * h - offset
      place(top + left, dy: y, cover(picture, page.width, (theme-top - picture-top) * h + 2 * offset))
      band(white, 0pt, y, slant-bottom: true)
    }
    band(theme-fill(config.get(), theme), theme-top * h - offset, h, slant-top: true)
  }

  page(background: background, numbering: none, context {
    let (cfg, format) = (config.get(), _format())
    let plain = theme-fill(cfg, theme) == white
    place(top + right, tub-logo(width: format.logo-scale * 50mm))
    place(top + left, dy: theme-top + 5%, {
      set text(fill: if plain { cfg.palette.dark-gray } else { white }, weight: "semibold")
      set par(leading: 0.5em, spacing: 0.9em)
      par(text(size: format.title, weight: "bold", fill: if plain { cfg.palette.red } else { white }, title))
      if subtitle != none { par(text(size: format.subtitle, subtitle)) }
      if info != none { par(text(size: format.info, info)) }
    })
    place(bottom + left, stack(dir: ltr, spacing: 0.5em, ..logos))
  })
}

/// Inner page that opens with a full-bleed picture above the text.
///
/// - height: share of the page the picture takes
/// - badge: short text for a round eye-catcher ("Störer") on the picture
#let picture-page(picture, height: 50%, badge: none, body) = {
  pagebreak(weak: true)
  context {
    let (cfg, format) = (config.get(), _format())
    let (w, h, margin) = (page.width, page.height, format.margin)
    // Drawn from the page corner, so only this page gets the picture.
    place(top + left, dx: -margin, dy: -margin, block(width: w, height: h, {
      place(top + left, cover(picture, w, height * h))
      band(white, (height - slant) * h, height * h + 1pt, slant-top: true)
      if badge != none {
        let radius = 1.2 * margin
        place(top + right, dx: -0.4 * margin, dy: (height - slant) * h - 1.7 * radius, circle(
          radius: radius,
          fill: cfg.palette.red,
          align(center + horizon, text(fill: white, size: format.badge, badge)),
        ))
      }
    }))
    v(height * h - margin + 1.5em)
  }
  body
}

/// Back cover: claim and contact details in the bottom left corner.
#let back-page(claim: true, bilingual: true, logo: false, contact) = page(numbering: none, {
  if logo { place(top + right, context tub-logo(width: _format().logo-scale * 50mm)) }
  place(bottom + left, block(width: 60%, {
    set text(size: 0.9em)
    if claim { tub-claim(bilingual: bilingual); parbreak() }
    contact
  }))
})
