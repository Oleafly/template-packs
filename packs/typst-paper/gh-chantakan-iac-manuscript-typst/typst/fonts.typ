// Shared font policy for manuscript, editor preview, and font specimen.
#let font-mode = sys.inputs.at("font-mode", default: "auto")
#assert(("auto", "bundled").contains(font-mode), message: "font-mode must be auto or bundled")
#let detected-font = sys.inputs.at("detected-body-font", default: "")
#assert(("", "Times New Roman", "TeX Gyre Termes").contains(detected-font))
#let body-fonts = if font-mode == "bundled" {
  ("TeX Gyre Termes",)
} else if detected-font == "TeX Gyre Termes" {
  ("TeX Gyre Termes",)
} else {
  ("Times New Roman", "TeX Gyre Termes")
}
#let apply-fonts(body) = {
  set text(font: body-fonts, size: 10pt, lang: "en")
  show math.equation: set text(font: "TeX Gyre Termes Math")
  body
}
