// Touying theme reproducing the official UNN (Lobachevsky University) ITMM
// defense-presentation template. The slide canvas is 720 x 405 pt, identical
// to the pptx, so every coordinate from src/geometry.typ transfers 1:1.

#import "@preview/touying:0.7.4": *
#import "@preview/tiaoma:0.3.0": qrcode
#import "colors.typ": unn-colors
#import "geometry.typ": unn-geom

// Full-slide backdrop of the title layout: blue gradient background plus
// the white-logo overlay (both are full-slide images in the pptx).
#let title-backdrop = {
  place(top + left, image(
    "../assets/title-bg.png",
    width: 100%,
    height: 100%,
    fit: "stretch",
  ))
  place(top + left, image(
    "../assets/logo-strip-white.png",
    width: 100%,
    height: 100%,
    fit: "stretch",
  ))
}

/// Default content slide: white background with blue logos on top, the
/// current level-2 heading as the slide title, right-aligned slide number.
///
/// - title (auto, content): overrides the displayed slide title.
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  title: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let g = unn-geom.content
  let chrome = {
    place(top + left, image(
      "../assets/content-bg.png",
      width: 100%,
      height: 100%,
      fit: "stretch",
    ))
    place(top + left, dx: g.title.x, dy: g.title.y, box(
      width: g.title.width,
      height: g.title.height,
      align(left + horizon, text(
        size: g.title.size,
        weight: "bold",
        fill: self.colors.primary,
        if title == auto {
          utils.display-current-heading(level: 2, depth: 2)
        } else {
          title
        },
      )),
    ))
    place(top + left, dx: g.page-num.x, dy: g.page-num.y, box(
      width: g.page-num.width,
      height: g.page-num.height,
      align(right + horizon, text(
        size: g.page-num.size,
        fill: unn-colors.page-num,
        // The physical page counter matches the pptx numbering (the title
        // slide is page 1) and, unlike the touying slide counter, resolves
        // correctly inside the page background.
        context counter(page).display(),
      )),
    ))
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      fill: white,
      margin: g.margin,
      background: chrome,
    ),
  )
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})

/// Title slide of the official template. All fields default to `self.info`
/// set via `config-info`; extra keys `supervisor`, `specialty`, `program`
/// are picked up from there as well.
#let title-slide(
  config: (:),
  author-label: [Выполнил:],
  supervisor-label: [Научный руководитель:],
  specialty-label: [Направление подготовки:],
  program-label: [Программа:],
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(margin: 0pt),
    config,
  )
  let info = self.info + args.named()
  let field(key) = info.at(key, default: none)
  let g = unn-geom.title
  // A labelled text block of the title layout: label line + value lines.
  let labelled(label, value) = {
    label
    linebreak()
    value
  }
  let body = {
    set text(fill: white)
    title-backdrop
    // The divider is a picture in the pptx (media/image1.png stretched to
    // the shape extent): a faint full-width line with brighter dashes in
    // the middle. Placing the asset mirrors it exactly.
    place(top + left, dx: g.divider.x, dy: g.divider.y, image(
      "../assets/divider.png",
      width: g.divider.width,
      height: g.divider.height,
      fit: "stretch",
    ))
    place(top + left, dx: g.subtitle.x, dy: g.subtitle.y, box(
      width: g.subtitle.width,
      text(size: g.subtitle.size, field("subtitle")),
    ))
    place(top + left, dx: g.title.x, dy: g.title.y, box(
      width: g.title.width,
      text(size: g.title.size, field("title")),
    ))
    place(top + left, dx: g.author.x, dy: g.author.y, box(
      width: g.author.width,
      text(size: g.author.size, labelled(author-label, field("author"))),
    ))
    if field("supervisor") != none {
      place(top + left, dx: g.supervisor.x, dy: g.supervisor.y, box(
        width: g.supervisor.width,
        text(
          size: g.supervisor.size,
          labelled(supervisor-label, field("supervisor")),
        ),
      ))
    }
    if field("specialty") != none {
      place(top + left, dx: g.specialty.x, dy: g.specialty.y, box(
        width: g.specialty.width,
        text(
          size: g.specialty.size,
          labelled(specialty-label, field("specialty")),
        ),
      ))
    }
    if field("program") != none {
      place(top + left, dx: g.program.x, dy: g.program.y, box(
        width: g.program.width,
        text(size: g.program.size, labelled(program-label, field("program"))),
      ))
    }
    if field("date") != none {
      place(top + left, dx: g.date.x, dy: g.date.y, box(
        width: g.date.width,
        text(size: g.date.size, utils.display-info-date(self)),
      ))
    }
  }
  touying-slide(self: self, body)
})

/// Focus slide: the blue title backdrop with a single centered message.
#let focus-slide(
  config: (:),
  size: 28pt,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(margin: 0pt),
    config,
  )
  let slide-body = {
    title-backdrop
    place(top + left, dy: unn-geom.thanks.y, box(
      width: 100%,
      align(center, text(size: size, weight: "bold", fill: white, body)),
    ))
  }
  touying-slide(self: self, slide-body)
})

/// Section slide: a focus slide sized like the closing slide of the
/// template, for manual use between parts of the talk.
#let section-slide(config: (:), body) = focus-slide(
  config: config,
  size: unn-geom.thanks.size,
  body,
)

/// Closing slide of the template (slide 27 of the pptx): centered bold
/// "Спасибо за внимание!" on the title backdrop, optional contact line.
///
/// - qr (none, str): when set, a QR code with this data is placed on a
///   white rounded card above the contact line.
#let thanks-slide(
  config: (:),
  contact: none,
  qr: none,
  qr-size: 80pt,
  body: [Спасибо за внимание!],
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(margin: 0pt),
    config,
  )
  let g = unn-geom.thanks
  let message = text(size: g.size, weight: "bold", fill: white, body)
  let slide-body = {
    title-backdrop
    if qr == none and contact == none {
      // The bare template slide: the message keeps its pptx position.
      place(top + left, dy: g.y, box(width: 100%, align(center, message)))
    } else {
      // With extras the whole message + QR + contact block is centered
      // vertically on the slide.
      let parts = (message,)
      if qr != none {
        parts.push(box(
          fill: white,
          radius: 8pt,
          inset: 8pt,
          qrcode(qr, width: qr-size, options: (
            fg-color: self.colors.primary,
          )),
        ))
      }
      if contact != none {
        parts.push(text(size: 13pt, fill: white, contact))
      }
      place(center + horizon, stack(
        spacing: 14pt,
        ..parts.map(p => align(center, p)),
      ))
    }
  }
  touying-slide(self: self, slide-body)
})

/// UNN ITMM theme entry point.
///
/// Example:
///
/// ```typst
/// #show: unn-theme.with(config-info(
///   title: [Тема работы],
///   author: [студент гр. 0000 И.И. Иванов],
///   supervisor: [д.ф.-м.н. П.П. Петров],
///   specialty: [01.03.02 Прикладная математика и информатика],
///   program: [Системный анализ],
///   date: datetime(year: 2026, month: 6, day: 1),
/// ))
/// ```
#let unn-theme(
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      width: unn-geom.slide.width,
      height: unn-geom.slide.height,
      fill: white,
      margin: unn-geom.content.margin,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: none,
      slide-level: 2,
      datetime-format: "[day].[month].[year]",
    ),
    config-methods(
      init: (self: none, body) => {
        set text(
          font: "Arial",
          size: 21pt,
          fill: unn-colors.text,
          lang: "ru",
          hyphenate: false,
        )
        set par(justify: false)
        set list(marker: (
          text(fill: unn-colors.accent-blue)[•],
          text(fill: unn-colors.accent-blue)[‣],
        ))
        show heading: set text(fill: self.colors.primary)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: unn-colors.primary,
      secondary: unn-colors.accent-blue,
      tertiary: unn-colors.green,
      neutral-lightest: white,
      neutral-darkest: unn-colors.text,
    ),
    ..args,
  )
  body
}
