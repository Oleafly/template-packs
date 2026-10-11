#let python = `python`
#let blank_space(width: 22) = [#underline(range(width).map(_ => " ").join(""))]
#let emphasize(content) = [#underline(stroke: (dash: "dotted"), [*#content*])]

#import "@preview/cetz:0.4.2"

#let score_states = state("score_states", ())
#let display_answer = state("display_answer", false)
#let display_score = state("display_score", true)

#let show_answer = () => {
  display_answer.get()
}

#let number_of_problems = () => {
  int(counter(heading).final().at(0))
}

#let current_problem = () => {
  int(counter(heading).get().at(0))
}

#let update_current_problem_score = score => {
  score_states.final().at(current_problem() - 1).update(x => x + score)
}

#let current_problem_score = () => {
  score_states.final().at(current_problem() - 1).final()
}

#let total_problem_score = () => {
  score_states.final().map(s => s.final()).sum()
}

#let tree(data) = cetz.canvas({
  import cetz.draw: *
  cetz.tree.tree(
    data,
    direction: "down",
    draw-node: (node, ..) => {
      circle((), radius: .35, fill: white, stroke: 2pt)
      content((), text(black, [#node.content]))
    },
  )
})

#let hint(hint) = [
  *Hint: #hint*
]

#let comment(content) = [
  #set text(red, weight: "bold")
  注：#content
]

#let pts(score) = if display_score.get() {
  [ (#score pts) ]
} else {
  []
}

#let pts_code(score) = if display_score.get() {
  " # (" + str(score) + "pts)"
} else {
  ""
}

#let answer(
  content,
  score,
  draw_underline: false,
) = context {
  let content = text(red)[
    *#content*
  ]
  [
    #if show_answer() {
      content
    } else if draw_underline {
      underline(hide(content))
    } else {
      hide(content)
    } #h(1fr) #pts(score)
  ]
  update_current_problem_score(score)
}

// Workaround for code blocks with line numbering
#let code_block(
  content,
  compact: false,
) = context {
  let r = regex("#\{\{(.+?)\}\}")
  let text = ""

  for line in content.text.split("\n") {
    let matches = line.matches(r)
    let new_line = line
    for occurrence in matches {
      let (hidden_answer, score) = occurrence.captures.at(0).split("@")
      let score = int(score)
      new_line = new_line.replace(
        occurrence.text,
        if show_answer() {
          hidden_answer
        } else {
          "_" * calc.max(occurrence.text.len(), 10)
        },
      )
      new_line += pts_code(score)
      update_current_problem_score(score)
    }
    text += new_line + "\n"
  }

  table(
    columns: (auto, if compact { auto } else { 1fr }),
    align: (right, left),
    raw(
      lang: content.lang,
      block: true,
      range(1, content.text.split("\n").len() + 1).map(str).join("\n"),
    ),
    table.cell(
      breakable: false,
      raw(
        lang: content.lang,
        block: true,
        text,
      ),
    ),
  )
}
