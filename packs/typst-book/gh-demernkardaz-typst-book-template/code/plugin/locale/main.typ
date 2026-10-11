#import "../../utils/lib.typ": resolve-path
#import "../meta/main.typ": property

#let _supported = ("en", "ru")
#let _locale = {
  let loc = property("locale").slice(0, 2)
  if _supported.contains(loc) { loc } else { "en" }
}

#let _locales-en = yaml("../../../settings/locale/en.yml")
#let _locales = if _locale == "en" {
  _locales-en
} else {
  yaml("../../../settings/locale/" + _locale + ".yml")
}

#let get(name, fallback: none) = {
  let val = resolve-path(_locales, name)
  if val != none { val } else {
    let en-val = resolve-path(_locales-en, name)
    if en-val != none { en-val } else { fallback }
  }
}
