// Contact labels carry the meaning; their icons are decorative PDF artifacts.
#let icon(source) = pdf.artifact(box(
  baseline: 0.125em,
  image(source, height: 0.9em),
))

// `path` retains this file's directory when passed to the image helper.
#let fa-home = icon(path("../img/fa/fa-home.svg"))
#let fa-email = icon(path("../img/fa/fa-envelope.svg"))
#let fa-github = icon(path("../img/fa/fa-github.svg"))
#let fa-linkedin = icon(path("../img/fa/fa-linkedin.svg"))
#let fa-phone = icon(path("../img/fa/fa-phone-alt.svg"))
#let fa-weixin = icon(path("../img/fa/fa-weixin.svg"))
