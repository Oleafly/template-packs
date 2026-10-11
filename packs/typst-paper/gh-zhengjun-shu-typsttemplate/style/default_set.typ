#import "@preview/blind-cvpr:0.7.0"

#let confName = "CVPR"
#let confYear = "2023"

// color
#let confColor = (
  phvb: rgb(128, 128, 247),
  link: rgb(73, 123, 184)
)
// font-size
#let confFontSize = (
  Huge: 25pt,
  huge: 20pt,
  LARGE: 17pt,
  Large: 14.4pt,
  large: 12pt,
  normal: 10pt,
  small: 9pt,
  footnote: 8pt,
  script: 7pt,
  tiny: 5pt,
)

// font-family
#let confFontfamily = (
  default: ("Times New Roman",),
  sans: ("Arial",),
  link: ("Courier New",),
)

// font
#let textlink(content) = {
  text(
    font: confFontfamily.link,
  )[#content]
}

#let textphvb(content) = {
  text(
    font: confFontfamily.sans,
    size: 8pt,
    weight: "bold",
    fill: confColor.phvb,
  )[#content]
}


// special symbol
#let eg = text("e.g.", style: "italic") // 例如 | exempli gratia
#let ie = text("i.e.", style: "italic") // 即、换句话说 | id est
#let etal = text("et al.", style: "italic") // 等人 | et alii
#let cf = text("cf.", style: "italic") // 参见 | confer
#let etc = text("etc.", style: "italic") // 等等 | et cetera
#let vs = text("vs.", style: "italic") // 相对于 | versus
#let wrt = text("w.r.t.", style: "italic")  // 关于 | with respect to
#let dof = text("d.o.f.", style: "italic")  // 自由度 | degrees of freedom
#let iid = text("i.i.d.", style: "italic")  // 独立同分布 | independent and identically distributed
