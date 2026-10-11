#import "@preview/touying:0.6.3": *
#import "@preview/cuti:0.4.0": *
#import themes.stargazer: *

#let szu-logo-red = image("asset/szu-logo.svg")
#let szu-logo-gold = image("asset/szu-logo-gold.svg")
#let szu-standard-red = rgb(149, 0, 64)

#let szu-first-red = rgb(171, 18, 98)
#let szu-second-red = rgb(226, 87, 143)
#let szu-third-red = rgb(243, 168, 187)

#let szu-first-gold = rgb(191, 157, 90)
#let szu-second-gold = rgb(227, 183, 103)
#let szu-third-gold = rgb(239, 219, 192)

#let szu-first-blue = rgb(0, 65, 196)
#let szu-second-blue = rgb(25, 110, 255)
#let szu-third-blue = rgb(156, 219, 255)

#let szu-first-cyan = rgb(0, 135, 84)
#let szu-second-cyan = rgb(25, 255, 130)
#let szu-third-cyan = rgb(158, 255, 217)

#let szu-theme(
  aspect-ratio: "16-9",
  lang: "zh",
  font: (:),
  title: [Shenzhen University Slides based on Touying and Typst],
  subtitle: [基于 Touying 的深圳大学 Typst 幻灯片模板],
  author: [深小荔],
  date: datetime.today(),
  institution: [深圳大学],
  ..args,
  body,
) = {
  show: stargazer-theme.with(
    // Lang and font configuration
    lang: "zh",
    // Basic information
    config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,
      institution: institution,
      logo: szu-logo-red,
    ),
    config-colors(
      primary: szu-first-red,
      secondary: szu-second-red,
      tertiary: szu-third-red,
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
  )

  set heading(numbering: "1.1.1.1")

  show: if (lang == "zh") { show-cn-fakebold }

  body
}
