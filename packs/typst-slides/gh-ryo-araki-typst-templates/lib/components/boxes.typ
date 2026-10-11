#import "../core/tokens.typ": colors

#let textbox(text, color, baseline: 0%) = box(
  fill: color.lighten(50%),
  outset: (x: 4pt, y: 10pt),
  radius: 5pt,
  baseline: baseline,
  text,
)

#let semantic-text(body, color) = text(fill: color, weight: "bold", body)
#let structure = body => semantic-text(body, colors.at("structure"))
#let alert = body => semantic-text(body, colors.at("alert"))

#let semantic-colorbox(body, color, baseline: 0%) = box(
  fill: color.lighten(70%),
  inset: (x: 0.45em, y: 0.18em),
  radius: 3pt,
  baseline: baseline,
  body,
)

#let showybox-focus = (
  border-color: white,
  body-color: colors.at("accent").lighten(70%),
  radius: 10pt,
)

#let showybox-advanced = (
  border-color: white,
  body-color: colors.at("advanced").lighten(80%),
  radius: 10pt,
)

// Backward-compatible aliases for the old slide template API.
#let showybox_focus = showybox-focus
#let showybox_advanced = showybox-advanced

#let labeled-box(
  body,
  label: none,
  color: gray,
  numbering: false,
  key: none,
  title-fill: rgb(0, 50, 100),
  inset: 15pt,
  radius: 10pt,
) = context {
  let counter-value = if numbering and key != none {
    let c = counter(key)
    let next = [#(c.get().first() + 1)]
    c.step()
    next
  } else {
    none
  }
  let header = if label == none {
    []
  } else if numbering and counter-value != none {
    [#label #counter-value]
  } else {
    [#label]
  }
  block(
    width: 100%,
    fill: color.lighten(70%),
    inset: inset,
    radius: radius,
    [
      #if label != none {
        set text(fill: title-fill, weight: "bold")
        header
        h(0.3em)
      }
      #set text(fill: black, weight: "regular")
      #body
    ],
  )
}

#let semantic-block(body, title: none, color: gray) = labeled-box(
  body,
  label: title,
  color: color,
  numbering: false,
  title-fill: color.darken(20%),
)

#let structure-block(body, title: none) = semantic-block(body, title: title, color: colors.at("structure"))
#let alert-block(body, title: none) = semantic-block(body, title: title, color: colors.at("alert"))
#let example-block(body, title: none) = semantic-block(body, title: title, color: colors.at("example"))

#let structure-colorbox = body => semantic-colorbox(body, colors.at("structure"))
#let alert-colorbox = body => semantic-colorbox(body, colors.at("alert"))
#let example-colorbox = body => semantic-colorbox(body, colors.at("example"))

// Legacy state objects kept for compatibility with older slide preambles.
#let summary-state = state("summary-state", ())
#let question-state = state("question-state", ())
#let answer-state = state("answer-state", ())

#let create-box-environment(name, title-text, color, state-obj, numbering: true) = {
  body => {
    let key = if numbering { name + "-box-legacy" } else { none }
    labeled-box(
      body,
      label: if title-text == "" { none } else { [#title-text] },
      color: color,
      numbering: numbering,
      key: key,
    )
  }
}

#let question = body => labeled-box(body, label: [Q.], color: colors.at("question"), numbering: true, key: "question-box")
#let answer = body => labeled-box(body, label: [A.], color: colors.at("answer"), numbering: true, key: "answer-box")
#let summary = body => labeled-box(body, label: [Sum.], color: colors.at("accent"), numbering: true, key: "summary-box")
#let question-no-num = body => labeled-box(body, label: [Q.], color: colors.at("question"))
#let answer-no-num = body => labeled-box(body, label: [A.], color: colors.at("answer"))
#let summary-no-num = body => labeled-box(body, color: colors.at("accent"))
