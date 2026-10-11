// =============================================================================
// Basic utils
// =============================================================================
// Convert content to string by recursively traversing the
// content tree and merging children
// Source: https://github.com/typst/typst/issues/2196#issuecomment-1728135476
#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}
#let lang-map() = if text.lang == "fr" {
  (
    abstract: "Résumé",
    answer: "Réponse",
    bib: "Bibliographie",
    claim: "Assertion",
    corollary: "Corollaire",
    definition: "Définition",
    example: "Exemple",
    explanation: "Explication",
    fact: "Fait",
    hint: "Indice",
    lemma: "Lemme",
    note: "Note",
    numbering: "1 sur 1",
    problem: "Problème",
    proof: "Preuve",
    proposition: "Proposition",
    question: "Question",
    remark: "Remarque",
    section: "Section",
    solution: "Solution",
    supervision: "Sous la supervision de:",
    theorem: "Théorème",
    warning: "Avertissement",
  )
} else {
  (
    abstract: "Abstract",
    answer: "Answer",
    bib: "References",
    claim: "Claim",
    corollary: "Corollary",
    definition: "Definition",
    example: "Example",
    explanation: "Explanation",
    fact: "Fact",
    hint: "Hint",
    lemma: "Lemma",
    note: "Note",
    numbering: "1 of 1",
    problem: "Problem",
    proof: "Proof",
    proposition: "Proposition",
    question: "Question",
    remark: "Remark",
    section: "Section",
    solution: "Solution",
    supervision: "Under the supervision of:",
    theorem: "Theorem",
    warning: "Warning",
  )
}

// Provides a word in the right language given a key
#let translation(key) = context lang-map().at(key)

// =============================================================================
// Custom functions
// =============================================================================

#let box-colors = (
  default: (stroke: luma(70), fill: white, title: white),
  red: (stroke: rgb("#8C441A"), fill: rgb("#f9f6f4"), title: rgb("#633012")),
  lightred: (
    stroke: rgb("#A12A12"),
    fill: rgb("#f9f6f4"),
    title: rgb("#862613"),
  ),
  green: (stroke: rgb("#458933"), fill: rgb("#f6f9f5"), title: rgb("#316124")),
  blue: (stroke: rgb("#00007B"), fill: rgb("#f2f2f8"), title: rgb("#000055")),
  lightblue: (
    stroke: rgb("#00007B"),
    fill: rgb("#fcfcfe"),
    title: rgb("#000055"),
  ),
  error: (stroke: black, fill: red, title: black),
)

#let colorbox(title: none, color: "default", width: 100%, body) = {
  let color = box-colors.at(color)

  return block(
    fill: color.fill,
    stroke: (left: 2pt + color.stroke, rest: 2pt + color.fill),
    radius: 2pt,
    width: width,
    inset: 8pt,
  )[
    #if title != none [
      #text(fill: color.title, weight: "bold")[#title.]
    ]
    #body
    #if title == translation("proof") [
      #align(right)[QED]
    ]
  ]
}

#let todo(body) = [ #colorbox(title: "TODO", color: "error", body) ]
#let definition(body) = [
  #colorbox(
    title: translation("definition"),
    color: "green",
    body,
  )
]
#let example(body) = [
  #colorbox(
    title: translation("example"),
    color: "blue",
    body,
  )
]
#let answer(body) = [
  #colorbox(
    title: translation("answer"),
    color: "green",
    body,
  )
]
#let question(body) = [
  #colorbox(
    title: translation("question"),
    color: "blue",
    body,
  )
]
#let problem(body) = [
  #colorbox(
    title: translation("problem"),
    color: "blue",
    body,
  )
]
#let proposition(body) = [
  #colorbox(
    title: translation("proposition"),
    color: "red",
    body,
  )
]
#let theorem(body) = [
  #colorbox(
    title: translation("theorem"),
    color: "red",
    body,
  )
]
#let explanation(body) = [
  #colorbox(
    title: translation("explanation"),
    color: "lightblue",
    body,
  )
]
#let lemma(body) = [
  #colorbox(
    title: translation("lemma"),
    color: "red",
    body,
  )
]
#let corollary(body) = [
  #colorbox(
    title: translation("corollary"),
    color: "red",
    body,
  )
]
#let remark(body) = [
  #colorbox(
    title: translation("remark"),
    color: "blue",
    body,
  )
]
#let claim(body) = [
  #colorbox(
    title: translation("claim"),
    color: "blue",
    body,
  )
]
#let proof(body) = [
  #colorbox(
    title: translation("proof"),
    color: "lightred",
    body,
  )
]
#let note(body) = [
  #colorbox(
    title: translation("note"),
    color: "lightblue",
    body,
  )
]
#let tldr(body) = [
  #colorbox(
    title: "TLDR",
    color: "lightblue",
    body,
  )
]
#let hint(body) = [
  #colorbox(
    title: translation("hint"),
    color: "lightblue",
    body,
  )
]
#let solution(body) = [
  #colorbox(
    title: translation("solution"),
    color: "green",
    body,
  )
]
#let fact(body) = [ #colorbox(title: translation("fact"), color: "blue", body) ]
#let warning(body) = [
  #colorbox(
    title: translation("warning"),
    color: "lightred",
    body,
  )
]

#let sfrac(numerator, denominator) = {
  math.attach("/", tl: numerator, br: denominator)
}

#let ket(x) = $lr(|#x angle.r, size: #110%)$
#let bra(x) = $lr(angle.l #x|, size: #110%)$

#let bmat(..body) = {
  math.mat(delim: "[", ..body)
}

#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)

#let bdiagbox(
  text_left,
  text_right,
  width: none,
  height: none,
  inset: 5pt,
  text_pad: none,
  box_stroke: none,
  line_stroke: 1pt,
  inner_width: none,
  left_sep: 0pt,
  right_sep: 0pt,
  left_outer_sep: 0pt,
  right_outer_sep: 0pt,
) = context {
  let left_measure = measure(text_left)
  let right_measure = measure(text_right)

  let text_pad = if text_pad == none {
    // some adjusting; sum 3pt for the base case (5pt)
    // for larger insets, it isn't very relevant
    -2 * inset / 3 + 3pt
  } else {
    text_pad
  }

  let height = if height != none {
    height
  } else {
    2 * (left_measure.height + right_measure.height)
  }

  let inner_width = if inner_width != none {
    inner_width
  } else if width != none {
    width - 2 * inset
  } else {
    2 * calc.max(left_measure.width, right_measure.width)
  }

  box(width: inner_width, height: height, stroke: box_stroke)[
    #show line: place.with(top + left)
    #place(
      top + right,
      move(dx: -right_sep - text_pad, dy: text_pad, text_right),
    )
    #line(
      start: (left_outer_sep - inset, -inset),
      end: (inner_width + inset - right_outer_sep, height + inset),
      stroke: line_stroke,
    )
    #place(
      bottom + left,
      move(dx: left_sep + text_pad, dy: -text_pad, text_left),
    )
  ]
}

#let tdiagbox(
  text_left,
  text_right,
  width: none,
  height: none,
  inset: 5pt,
  text_pad: none,
  box_stroke: none,
  line_stroke: 1pt,
  inner_width: none,
  left_sep: 0pt,
  right_sep: 0pt,
  left_outer_sep: 0pt,
  right_outer_sep: 0pt,
) = context {
  let left_measure = measure(text_left)
  let right_measure = measure(text_right)

  let text_pad = if text_pad == none {
    // some adjusting; sum 3pt for the base case (5pt)
    // for larger insets, it isn't very relevant
    -2 * inset / 3 + 3pt
  } else {
    text_pad
  }

  let height = if height != none {
    height
  } else {
    2 * (left_measure.height + right_measure.height)
  }

  let inner_width = if inner_width != none {
    inner_width
  } else if width != none {
    width - 2 * inset
  } else {
    2 * calc.max(left_measure.width, right_measure.width)
  }

  box(width: inner_width, height: height, stroke: box_stroke)[
    #show line: place.with(top + left)
    #place(top + left, move(dx: left_sep + text_pad, dy: text_pad, text_left))
    #line(
      start: (left_outer_sep - inset, height + inset),
      end: (inner_width + inset - right_outer_sep, -inset),
      stroke: line_stroke,
    )
    #place(
      bottom + right,
      move(dx: -right_sep - text_pad, dy: -text_pad, text_right),
    )
  ]
}

// Hide content and prevent disrupting placement
#let true-hide = body => hide(
  place(
    center,
    float: false,
    body,
  ),
)

// Add citation to bibliography without ref
#let nocite = (..args) => true-hide(cite(..args))

// Add citations in block to bibliography without ref
#let nocite-block(body) = {
  show cite: it => true-hide(it)
  body
}
