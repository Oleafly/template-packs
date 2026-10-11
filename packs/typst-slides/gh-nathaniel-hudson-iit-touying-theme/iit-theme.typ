#import "@preview/touying:0.7.3": *

// Import Theorion to enable theorems and other environments:
// https://typst.app/universe/package/theorion/
#import "@preview/theorion:0.6.0": *

#let serif-font = ("Source Serif 4", "Source Serif", "Georgia")
#let sans-font = ("Source Sans Pro", "Source Sans", "Arial")
#import cosmos.clouds: *

// ========================================================================= //

// Define custom highlighting functions.

#let hl-primary(body) = touying-fn-wrapper((self: none, body) => {
  text(fill: self.colors.primary, body)
}, body)

#let hl = hl-primary

#let hl-secondary(body) = touying-fn-wrapper((self: none, body) => {
  text(fill: self.colors.primary, body)
}, body)

#let hl-red(body) = touying-fn-wrapper((self: none, body) => {
  text(fill: self.colors.red, body)
}, body)

#let hl-green(body) = touying-fn-wrapper((self: none, body) => {
  text(fill: self.colors.green, body)
}, body)

#let hl-blue(body) = touying-fn-wrapper((self: none, body) => {
  text(fill: self.colors.blue, body)
}, body)


// ========================================================================= //

/**
 * This function implements footer style with a PROGRESS BAR in our slides. 
 */
#let my-footer(self) = {

  let width = self.page.at("width", default: 254mm)   // 254mm = default Touying slide width
  let height = self.page.at("height", default: 143mm)
  let margin = self.page.at("margin")

  // Text footer content
  place(
    right, 
    dx: -margin.x,
    block(
      width: 100%, 
      height: 100%,
      align(
        right + horizon,
        text(
          size: 12pt, 
          font: sans-font,
          weight: "regular",
          fill: self.colors.secondary,
          // utils.display-current-heading(depth: 1)
          context utils.slide-counter.display() + " / " + utils.last-slide-number
        )
      )
    )
  )

  // Progress bar pinned to the bottom
  place(
    bottom, 
    dy: 1pt, // without this, the progress bar roughly *one* pixel above the bottom of the slide
    components.progress-bar(
      height: 3pt,
      self.colors.secondary,        // filled (completed) colour
      self.colors.primary-light,  // unfilled (remaining) colour
    )
  )
}

// ========================================================================= //

#let slide(
    show-section-in-slide-titles: false, 
    title: auto, ..args
) = touying-slide-wrapper(self => {

  let width = self.page.at("width", default: 254mm)   // 254mm = default Touying slide width
  let height = self.page.at("height", default: 143mm)
  let margin = self.page.at("margin")

  if title != auto {
    self.store.title = title
  }
  
  if title != none {
    let header(self) = {
      set align(top)
      show: components.cell.with(fill: self.colors.primary, inset: 1em)
      set align(horizon)
      set text(
        font: serif-font,
        fill: self.colors.neutral-lightest, 
        weight: "bold",
        size: 1.25em,
      )
      set text()
      if self.store.title != none {
        utils.call-or-display(self, self.store.title)
      } else {
        utils.display-current-heading(level: 2)
      }

      // Only show the SECTION title in the title bar of the slide if this is desired.
      if show-section-in-slide-titles {
        h(1fr)
        text(
          font: sans-font,
          weight: "regular",
          size: 0.75em,
          "(" + utils.display-current-heading(level: 1) + ")"
        )
      }
    }

    let footer = my-footer
    self = utils.merge-dicts(
      self,
      config-page(
        header: header,
        footer: footer,
      ),
    ) 
  }


  set par(justify: true)

  touying-slide(self: self, setting: body => align(horizon, body), ..args)
})

// ========================================================================= //

#let title-slide(..args) = touying-slide-wrapper(self => {
  
  let info = self.info + args.named()
  let width = self.page.at("width", default: 254mm)   // 254mm = default Touying slide width
  let height = self.page.at("height", default: 143mm)
  let margin = self.page.at("margin")

  let body = {
    // Title Block
    place(
      dx: -margin.x,
      dy: -margin.y,
      block(
        fill: self.colors.primary,
        width: width + 2.05 * margin.x,
        height: (height + 2 * margin.y) * 0.5,
        inset: (x: 3em, y: 1em),
        align(
          bottom + left,
          text(
            size: 2em, 
            fill: self.colors.white, 
            font: serif-font,
            weight: "bold", 
            info.title,
          ),
        ),
      )
    )

    // Subtitle Block
    place(
      dy: (height * 0.5) + 1em,
      block(
        fill: self.colors.white,
        if info.subtitle != none { 
          text(
            font: sans-font,
            size: 1.5em,
            weight: "bold",
            info.subtitle,
          )
        }
      )
    )

    // Author and Date Block
    place(
      dy: (height * 0.9),
      block(
        fill: self.colors.white,
        height: height * 0.05,
        if info.subtitle != none { 
          text(
            font: sans-font,
            weight: "regular",
            [#info.author~~$bullet$~~#info.date.display("[month repr:long] [day], [year]")],
          )
        }
      )
    )

    // Illinois Tech Logo
    place(
      dy: (height * 0.9),
      block(
        height: height * 0.05,
        width: 100%,
        align(
          right,
          image("static/iit_red_logo.png", height: height * 0.05),
        )
      )
    )

  }
  touying-slide(self: self, body)
})

// ========================================================================= //

#let new-section-slide(self: none, body) = touying-slide-wrapper(self => {

  let width = self.page.at("width", default: 254mm)   // 254mm = default Touying slide width
  let height = self.page.at("height", default: 143mm)
  let margin = self.page.at("margin")

  let main-body = {

    // Visual Block
    place(
      dx: -margin.x,
      dy: -margin.y,
      block(
        fill: self.colors.primary,
        width: (width + 2 * margin.x) / 3,
        height: (height + 2 * margin.y),
      )
    )

    // Text Block
    place(
      dx: (-2 * margin.x + width) / 3 + 1em,
      dy: -margin.y,
      block(
        width: (width + 2 * margin.x) / 3 * 2,
        height: (height + 2 * margin.y),
        inset: 2em,
        align(
          left + horizon,
          text(
            font: serif-font,
            fill: self.colors.primary,
            weight: "bold",
            size: 2em,
            utils.display-current-heading(level: 1),
          )
        )
      )
    )

  }
  touying-slide(self: self, main-body)
})

// ========================================================================= //

#let focus-slide(body) = touying-slide-wrapper(self => {

  let width = self.page.at("width", default: 254mm)   // 254mm = default Touying slide width
  let height = self.page.at("height", default: 143mm)
  let margin = self.page.at("margin")
  
  self = utils.merge-dicts(self, config-page(fill: self.colors.primary))

  set text(fill: self.colors.neutral-lightest, size: 2em, weight: "bold", font: serif-font)
  touying-slide(
    self: self,
    align(center + horizon, body)
  )
})

// ========================================================================= //

// Define the highlight helpers
#let primary-highlight(body) = text(fill: rgb("#E63946"), weight: "bold", body)
#let secondary-highlight(body) = text(fill: rgb("#457B9D"), style: "italic", body)

#let iit-theme(
  aspect-ratio: "16-9",
  footer: none,
  show-section-in-slide-titles: false,
  ..args,
  body,
) = {
  // Set defaults for text.
  set text(font: sans-font, size: 20pt)

  // Setup basic use of the Cosmos themes for Theorion.
  show figure.where(kind: "theorem"): it => block(breakable: false, it)
  show: show-theorion

  // Define the slide styles.
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      footer: my-footer,
    ),
    config-common(
      default-preamble: self => {
        set align(horizon)
      },
      slide-fn: slide.with(
        show-section-in-slide-titles: show-section-in-slide-titles, 
      ),
      new-section-slide-fn: new-section-slide,
    ),
    config-info(
      date: datetime.today(),
    ),
    config-methods(
      // alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: rgb("#CC0000"),
      secondary: rgb("FF9900"),
      tertiary: rgb("#F0F0F0"),
      black: rgb("#000000"),
      gray: rgb("#76777B"),
      white: rgb("FFFFFF"),
      // Additional colors for highlighting.
      red: rgb("#cc0000"),
      green: rgb("00aa00"),
      blue: rgb("#0066cc"),
    ),
    config-store(
      title: none,
      footer: footer,
    ),
    ..args,
  )

  body
}