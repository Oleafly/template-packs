#import "locales/en.typ": labels as en-labels
#import "locales/zh.typ": labels as zh-labels

#let _locales = (
  "en": en-labels,
  "zh": zh-labels,
)

#let available-locales() = _locales.keys()

#let locale-labels(locale: "en") = {
  _locales.at(locale, default: _locales.at("en"))
}
