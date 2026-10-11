// TU Berlin corporate colours and gradients ("Verläufe").

#let _palette(c, space) = {
  let grad(a, b) = gradient.linear(c.at(a), c.at(b), angle: -45deg, space: space)
  c + (
    gradients: (
      orange-red: grad("orange", "red"),
      red-violet: grad("red", "violet"),
      blue-green: grad("blue", "green"),
      blue-violet: grad("blue", "violet"),
    ),
  )
}

/// Screen palette. Colours by name plus a `gradients` dictionary.
#let tub-rgb = _palette(
  (
    red: rgb(196, 13, 30),
    black: rgb(0, 0, 0),
    dark-gray: rgb(67, 67, 67),
    light-gray: rgb(178, 178, 178),
    orange: rgb(255, 108, 0),
    violet: rgb(144, 19, 254),
    blue: rgb(31, 144, 204),
    green: rgb(73, 203, 64),
  ),
  rgb,
)

/// Print palette with the same keys as `tub-rgb`.
#let tub-cmyk = _palette(
  (
    red: cmyk(20%, 100%, 100%, 0%),
    black: cmyk(0%, 0%, 0%, 100%),
    dark-gray: cmyk(0%, 0%, 0%, 80%),
    light-gray: cmyk(0%, 0%, 0%, 40%),
    orange: cmyk(0%, 70%, 95%, 0%),
    violet: cmyk(75%, 80%, 0%, 0%),
    blue: cmyk(75%, 30%, 0%, 0%),
    green: cmyk(64%, 0%, 95%, 0%),
  ),
  cmyk,
)

#let tub-colors = tub-rgb
#let tub-gradients = tub-rgb.gradients

// Turns a theme into a fill: a gradient or colour name is looked up in
// `palette`, anything else (a colour, a gradient) is used as given.
#let resolve-theme(theme, palette) = {
  if type(theme) != str {
    theme
  } else if theme in palette.gradients {
    palette.gradients.at(theme)
  } else if theme != "gradients" and theme in palette {
    palette.at(theme)
  } else {
    let names = palette.gradients.keys() + palette.keys().filter(k => k != "gradients")
    panic("unknown theme \"" + theme + "\", valid themes are: " + names.join(", "))
  }
}
