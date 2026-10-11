#import "../utils/style.typ": *
#import "../config/appendix.typ": (
  appendix, creative-output-descriptor, reset-appendix-counter,
)

#let appendix-page(ctx, metadata) = {
  let style = ctx.style
  let locale = ctx.locale
  let appendices = metadata.at("appendices", default: ())

  // Reset counter at start
  reset-appendix-counter()

  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
    numbering: "A",
  )

  // Render each appendix
  for app in appendices {
    let title = app.at("title", default: "")
    let content = app.at("content", default: [])
    let creative = app.at("creative", default: none)

    appendix(title, [
      #set par(justify: true, first-line-indent: 1.5em)
      #set text(size: 12pt, font: style.fonts.serif, lang: locale)
      #content

      #if creative != none {
        creative-output-descriptor(
          medium: creative.at("medium", default: none),
          dimensions: creative.at("dimensions", default: none),
          duration: creative.at("duration", default: none),
          description: creative.at("description", default: none),
        )
      }
    ])
  }
}
