// /template/langs/i18n.typ
// Internationalization dispatcher — data-driven from manifest.yaml
// Author: Sam Dinh
// Version: 0.5.0
// License: MIT
//
// Available languages are defined entirely by:
//   1. A YAML data file in this directory:  <bcp47-lowercase>.yaml
//   2. An entry in manifest.yaml listing the code and any aliases
//
// To add a new language — no Typst code changes needed:
//   1. Create template/langs/<bcp47-lowercase>.yaml with all label keys
//   2. Add an entry to manifest.yaml (code + aliases)
//
// Usage:
//   #import "langs/i18n.typ": i18n-labels, i18n-supported-languages
//   #let labels = i18n-labels("vi")       // short alias
//   #let labels = i18n-labels("vi-vn")    // full BCP 47
//   labels.toc  // => "Mục Lục"

// MARK: Load registry from manifest

#let _manifest = yaml("manifest.yaml")

// Build registry: map every canonical code AND alias → its label dict
#let _registry = {
  let reg = (:)
  for entry in _manifest.languages {
    let code   = entry.code
    let labels = yaml(code + ".yaml")
    reg.insert(code, labels)
    for alias in entry.at("aliases", default: ()) {
      reg.insert(alias, labels)
    }
  }
  reg
}

// Canonical fallback code (first language listed in manifest)
#let _fallback = _manifest.languages.first().code

// MARK: Public API

/// Returns the label dictionary for the given language code.
/// Accepts canonical BCP 47 lowercase codes ("vi-vn"), short codes ("vi"),
/// or alternate casing ("zh-Hant"). Falls back to the first language in
/// manifest.yaml (typically en-us) if the code is not found.
///
/// - lang (str): Language code
/// -> dictionary
#let i18n-labels(lang) = {
  if lang in _registry {
    _registry.at(lang)
  } else {
    _registry.at(_fallback)
  }
}

/// Returns the list of canonical BCP 47 codes defined in manifest.yaml.
/// -> array
#let i18n-supported-languages() = {
  _manifest.languages.map(e => e.code)
}
