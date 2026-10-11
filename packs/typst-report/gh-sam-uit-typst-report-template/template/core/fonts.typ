// /template/core/fonts.typ
// Font configuration — reads user overrides from /config/template.yaml.
// Author: Sam Dinh
// Version: 0.3.0
// License: MIT
//
// To change fonts without editing this file, set the keys under `fonts:`
// in <project-root>/config/template.yaml. All keys are optional; missing
// keys fall back to the defaults defined below.

// MARK: Defaults
// These are used when config/template.yaml is absent or a key is omitted.
#let _font-defaults = (
  // Alternatives: "Montserrat", "Google Sans", "Noto Sans"
  sans:  "Tex Gyre Adventor",
  // Alternatives: "Lora", "Linux Libertine", "Noto Serif"
  serif: "CMU Serif",
  // Alternatives: "Fira Code", "JetBrains Mono", "Ubuntu Mono"
  mono:  "Google Sans Code",
)

// MARK: Load user config
// Path is relative to this file: ../../config/template.yaml
// If the file is missing Typst will error — ship config/template.yaml
// with the project (it is tracked in git and safe to edit).
#let _cfg = yaml("../../config/config.yaml")
#let _user-fonts = _cfg.at("fonts", default: (:))

// MARK: Resolved fonts
#let document-fonts = (
  sans:  _user-fonts.at("sans",  default: _font-defaults.sans),
  serif: _user-fonts.at("serif", default: _font-defaults.serif),
  mono:  _user-fonts.at("mono",  default: _font-defaults.mono),
)

#let heading-font = document-fonts.sans
#let body-font    = document-fonts.serif
#let code-font    = document-fonts.mono
