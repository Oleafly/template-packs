#let tab10-blue = rgb("#1f77b4")
#let tab10-orange = rgb("#ff7f0e")
#let tab10-green = rgb("#2ca02c")
#let tab10-red = rgb("#d62728")
#let tab10-purple = rgb("#9467bd")
#let tab10-brown = rgb("#8c564b")
#let tab10-pink = rgb("#e377c2")
#let tab10-gray = rgb("#7f7f7f")
#let tab10-olive = rgb("#bcbd22")
#let tab10-cyan = rgb("#17becf")

#let neutral = rgb(black)
#let primary = tab10-blue
#let secondary = tab10-orange
#let tertiary = rgb("#555555")

#let neutral-light = neutral
#let neutral-lighter = white.darken(2%)
#let neutral-lightest = white
#let neutral-dark = neutral
#let neutral-darker = neutral
#let neutral-darkest = black

#let primary-light = primary
#let primary-lighter = primary.saturate(80%).lighten(70%)
#let primary-lightest = primary.saturate(80%).lighten(85%)
#let primary-dark = primary
#let primary-darker = primary.saturate(100%).darken(10%)
#let primary-darkest = primary.saturate(100%).darken(30%)

#let secondary-light = secondary
#let secondary-lighter = secondary.saturate(80%).lighten(70%)
#let secondary-lightest = secondary.saturate(80%).lighten(85%)
#let secondary-dark = secondary
#let secondary-darker = secondary.saturate(100%).darken(10%)
#let secondary-darkest = secondary.saturate(100%).darken(30%)

#let tertiary-light = tertiary
#let tertiary-lighter = tertiary.saturate(0%).lighten(70%)
#let tertiary-lightest = tertiary.saturate(0%).lighten(85%)
#let tertiary-dark = tertiary
#let tertiary-darker = tertiary.saturate(100%).darken(10%)
#let tertiary-darkest = tertiary.saturate(100%).darken(30%)

#let colorconfig = (
  neutral: neutral,
  primary: primary,
  secondary: secondary,
  tertiary: tertiary,
  neutral-lighter: neutral-lighter,
  neutral-light: neutral-light,
  neutral-lightest: neutral-lightest,
  neutral-darker: neutral-darker,
  neutral-dark: neutral-dark,
  neutral-darkest: neutral-darkest,
  primary-lighter: primary-lighter,
  primary-light: primary-light,
  primary-lightest: primary-lightest,
  primary-darker: primary-darker,
  primary-dark: primary-dark,
  primary-darkest: primary-darkest,
  secondary-lighter: secondary-lighter,
  secondary-light: secondary-light,
  secondary-lightest: secondary-lightest,
  secondary-darker: secondary-darker,
  secondary-dark: secondary-dark,
  secondary-darkest: secondary-darkest,
  tertiary-lighter: tertiary-lighter,
  tertiary-light: tertiary-light,
  tertiary-lightest: tertiary-lightest,
  tertiary-darker: tertiary-darker,
  tertiary-dark: tertiary-dark,
  tertiary-darkest: tertiary-darkest,
)