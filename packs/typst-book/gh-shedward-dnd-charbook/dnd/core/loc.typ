#let supportedLang = ("en", "ru")
#let defaultLang = "en"

#let setLocale(lang) = [
  #metadata(lang) <locale>
]

#let _locData = json("/resources/data/localization.json")

#let _applySubstitutions(template, subs) = {
  let parts = (template,)
  for (k, v) in subs {
    let marker = "{" + k + "}"
    let newParts = ()
    for part in parts {
      if type(part) == str {
        let segments = part.split(marker)
        for i in range(segments.len()) {
          if segments.at(i) != "" { newParts.push(segments.at(i)) }
          if i < segments.len() - 1 { newParts.push(v) }
        }
      } else {
        newParts.push(part)
      }
    }
    parts = newParts
  }
  parts.join()
}

#let loc(key, subs: (:)) = context {
  let records = query(<locale>)
  let locale = if records.len() > 0 { records.first().value } else { defaultLang }
  let entry = _locData.at(key, default: none)
  if entry == none { panic("Missing localization key: " + key) }
  let template = entry.at(locale, default: entry.at(defaultLang))
  if subs == (:) { template } else { _applySubstitutions(template, subs) }
}
