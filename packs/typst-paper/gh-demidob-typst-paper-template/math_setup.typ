#import "@preview/plotst:0.2.0": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/cetz:0.3.2"

#show: thmrules

#let latexHeadingNumbering(..args) = {
  let pos = args.pos()

  for (i, arg) in pos.enumerate() {
    if (i == pos.len() - 1) {
      text[#arg #h(0.2cm)]
    } else {
      text[#arg.]
    }
  }
}

#let body_font_size = 11pt

#let applyStyles(content) = [
  #set par(leading: 0.55em, first-line-indent: 1.8em, justify: true, spacing: 0.55em)
  #set text(size: body_font_size, lang: "en")
  #set text(font: "New Computer Modern")
  #set page(numbering: "1", paper: "a4")
  #show raw: set text(font: "New Computer Modern Mono")
  #show heading: set block(above: 1.4em, below: 1em)

  #set enum(numbering: "(i)", spacing: 1em)

  #set heading(numbering: latexHeadingNumbering)
  #set math.equation(numbering: "(1)")
  #show math.equation.where(block: true): set block(spacing: 1.1em)
  
  #show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      numbering(
        el.numbering,
        ..counter(eq).at(el.location())
      )
    } else {
      // Other references as usual.
      it
    }
  }

  #show: thmrules
  #show: thmrules.with(qed-symbol: $square$)

  #content
]

#let new_latex_style_thmbox(name) = thmbox(
  "theorem",
  name,
  inset: 0em,
  separator: [*.*#h(0.2em)],
  // namefmt: x => [(#emph(x))],
  // namefmt: x => [(#x)],
  bodyfmt: x => emph(x)
)

#let new_latex_style_secondary_thmbox(name) = thmbox(
  "theorem",
  name,
  inset: 0em,
  separator: [*.*#h(0.2em)],
  // namefmt: x => [(#emph(x))],
  // namefmt: x => [(#x)],
)

#let theorem = new_latex_style_thmbox("Theorem")
#let corollary = new_latex_style_thmbox("Corollary")
#let proposition = new_latex_style_thmbox("Proposition")
#let lemma = new_latex_style_thmbox("Lemma")
#let conjecture = new_latex_style_thmbox("Conjecture")
#let notation = new_latex_style_secondary_thmbox("Notation")
#let property = new_latex_style_thmbox("Property")
#let definition = new_latex_style_secondary_thmbox("Definition")
#let intuition = new_latex_style_secondary_thmbox("Intuition")
#let construction = new_latex_style_thmbox("Construction")
#let convention = new_latex_style_secondary_thmbox("Convention")
#let remark = new_latex_style_secondary_thmbox("Remark")
#let example = new_latex_style_secondary_thmbox("Example")
#let problem = new_latex_style_thmbox("Problem")
#let exercise = new_latex_style_thmbox("Exercise")

#let important_stuff(content) = {
  rect(fill: color.linear-rgb(200, 200, 200, 255))[
    #content
  ]
}

#let important_convention(content) = important_stuff[#convention[#content]]

#let proof = thmproof("proof", "Proof", inset: 0em, separator: [.#h(0.2em)])

#let today = datetime.today()

#let header_section(title, authors) = [
  #align(center, text(size: body_font_size / 11 * 19)[#title]) 
  #block(height: 0.5em)
  #align(center, text(size: body_font_size / 11 * 13)[#authors]) 
  #block(height: 0.5em)
  #align(center, text(size: body_font_size / 11 * 13)[#today.display("[day].[month].[year]")])
]

#let abstract(txt) = align(center)[
  *Abstract*

  #block(width: 90%, txt)
]

#let abstract_after_header(txt) = [
  \ \
  #abstract(txt)
]

#let tmp(content) = text(fill: red)[#content]

#let latexHeadingNumbering(..args) = {
  let pos = args.pos()

  for (i, arg) in pos.enumerate() {
    if (i == pos.len() - 1) {
      text[#arg #h(0.2cm)]
    } else {
      text[#arg.]
    }
  }
}

#let innerproduct(x, y) = $lr(angle.l #x, #y angle.r)$