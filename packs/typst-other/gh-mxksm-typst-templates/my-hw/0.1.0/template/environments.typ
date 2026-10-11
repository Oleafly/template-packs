#import "@preview/theoretic:0.1.1" as theoretic: theorem, proof, restate, qed

#import "macros.typ": *
#import "config.typ": *

// =======
// BASE THEOREM
// =======
 
#let lozenge = qed.with(suffix: [#h(1fr) $lozenge.filled.medium$])

#let mathlozenge() = {
  v(-1.8em)
  lozenge()
}

#let mathqed() = {
  v(-1.8em)
  qed()
}

#let base-thm = theorem.with(
  fmt-prefix: (s, n, t) => {
    v(0.5em)
    if t == none {
      if n == none {
        text(weight: "bold")[#s.]
      }
      else {
        text(weight: "bold")[#s #n.]
      }
    } else {
      if n == none {
        text(weight: "bold")[#s] 
        h(0.5em) 
        [(#t.)]
      }
      else  {
        text(weight: "bold")[#s #n] 
        h(0.5em) 
        [(#t.)]
      }
    }
  },
  fmt-body: (b, p) => {
    h(0.5em)
    b
    v(0.5em)
  },
  fmt-suffix: lozenge.with(force: false)
)

#let new-thm(environment, title: none, label: none, number: none, body) = {
  block(
    breakable: true,
    width: 100%,
  )[
    #if number == "none" {
      environment(title: title, label: label, number: none)[#body]
    } else if number == none {
      environment(title: title, label: label)[#body]
    } else {
      environment(title: title, label: label, number: number)[#body]
    }
    #v(0.75em)
  ]
}

// ===========================
// ENVIRONMENTS WITH NUMBERING
// ===========================
#let thm(body, title: none, label: none, number: none) = {
  new-thm(base-thm, title: title, label: label, number: number)[#body]
}

#let base-cor = base-thm.with(kind: "corollary", supplement: "Corollary")
#let cor(body, title: none, label: none, number: none) = {
  new-thm(base-cor, title: title, label: label, number: number)[#body]
}

#let base-defn = base-thm.with(kind: "definition", supplement: "Definition")
#let defn(body, title: none, label: none, number: none) = {
  new-thm(base-defn, title: title, label: label, number: number)[#body]
}

#let base-prop = base-thm.with(kind: "proposition", supplement: "Proposition")
#let prop(body, title: none, label: none, number: none) = {
  new-thm(base-prop, title: title, label: label, number: number)[#body]
}

#let base-fact = base-thm.with(kind: "fact", supplement: "Fact")
#let fact(body, title: none, label: none, number: none) = {
  new-thm(base-fact, title: title, label: label, number: number)[#body]
}

#let base-warn = base-thm.with(kind: "warning", supplement: "Warning")
#let warn(body, title: none, label: none, number: none) = {
  new-thm(base-warn, title: title, label: label, number: number)[#body]
}

#let base-note = base-thm.with(kind: "note", supplement: "Note")
#let note(body, title: none, label: none, number: none) = {
  new-thm(base-note, title: title, label: label, number: number)[#body]
}

#let base-lemma = base-thm.with(kind: "lemma", supplement: "Lemma")
#let lemma(body, title: none, label: none, number: none) = {
  new-thm(base-lemma, title: title, label: label, number: number)[#body]
}

#let base-remark = base-thm.with(kind: "remark", supplement: "Remark")
#let remark(body, title: none, label: none, number: none) = {
  new-thm(base-remark, title: title, label: label, number: number)[#body]
}

#let base-example = base-thm.with(kind: "example", supplement: "Example")
#let example(body, title: none, label: none, number: none) = {
  new-thm(base-example, title: title, label: label, number: number)[#body]
}

#let base-problem = base-thm.with(kind: "problem", supplement: "Problem")
#let problem(body, title: none, label: none, number: none) = {
  new-thm(base-problem, title: title, label: label, number: number)[#body]
}

#let base-notation = base-thm.with(kind: "notation", supplement: "Notation")
#let notation(body, title: none, label: none, number: none) = {
  new-thm(base-notation, title: title, label: label, number: number)[#body]
}

#let base-exercise = base-thm.with(kind: "exercise", supplement: "Exercise")
#let exercise(body, title: none, label: none, number: none) = {
  new-thm(base-exercise, title: title, label: label, number: number)[#body]
}

#let base-algorithm = base-thm.with(kind: "algorithm", supplement: "Algorithm")
#let algorithm(body, title: none, label: none, number: none) = {
  new-thm(base-algorithm, title: title, label: label, number: number)[#body]
}

#let base-construction = base-thm.with(kind: "construction", supplement: "Construction")
#let construction(body, title: none, label: none, number: none) = {
  new-thm(base-construction, title: title, label: label, number: number)[#body]
}

// ==============================
// ENVIRONMENTS WITHOUT NUMBERING
// ==============================
#let self-note = base-thm.with(
  kind: "self-note", 
  supplement: "Note to Self", 
  number: none, 
  fmt-prefix: (s, _, t) => {
    text(weight: "bold", stretch: 85%)[#text(fill: orange)[#s.]]
    if t != none {
      if t == [] {
        [ 
          #text(fill: blue)[Ask the Professor]
        ]
      }
      if t == [resolved]{
        [ 
          #text(fill: green)[Resolved]
        ]
      }
    }
    h(0.5em)
  },
  fmt-body: (b, p) => {
    text(fill: orange)[#b]
  }
)

#let todo(body) = {
  text[#text(fill: red)[[TODO: #body]]]
}


#let base-idea = base-thm.with(
  kind: "idea", 
  supplement: "Proof Idea", 
  number: none, 
  fmt-prefix: (s, _, t) => {
    text(weight: "bold", stretch: 85%)[#s.]
    if t != none [ (#t).]
    h(0.5em)
  },
)
#let idea(body, title: none, label: none) = {
  new-thm(base-idea, title: title, label: label)[#body]
}

#let base-soln = base-thm.with(
  kind: "solution", 
  supplement: "Solution", 
  number: none, 
  fmt-prefix: (s, _, t) => {
    text(weight: "bold", stretch: 85%)[#s:]
    if t != none [ (#t).]
    h(0.5em)
  },
  fmt-suffix: qed.with(force: false)
)
#let soln(body, title: none, label: none) = {
  new-thm(base-soln, title: title, label: label)[#body]
}

#let base-proof = base-thm.with(
  kind: "proof", 
  supplement: "Proof", 
  fmt-prefix: (s, n, t) => {
    // Just return text, no align or block here
    if t == none {
      emph(text[#s.])
    } else {
      emph(text[#s])
      h(0.5em) 
      [#emph("of ") #t.]
    }
  },
  number: none, 
  fmt-suffix: qed.with(force: false)
)
#let proof(body, title: none, label: none) = {
  new-thm(base-proof, title: title, label: label)[#body]
}

// ========
// EXERCISE 
// ========
#let exercise_sub = base-thm.with(
  fmt-prefix: (s, _, t) => {
    text(weight: "bold", stretch: 85%)[#s #t Solution]
    h(0.5em)
  },
  kind: "exercise",
  supplement: "Exercise",
  number: none,
)

#let exercise_statement_sub = base-thm.with(
  fmt-prefix: (s, _, t) => {
    text(weight: "bold", stretch: 85%)[#s #t.]
    h(0.5em)
  },
  kind: "exercise",
  supplement: "Exercise",
  number: none,
)

#let exercise_custom(body, title: none, label: none, solution: false) = {
  context{
    let i = q-counter.get().at(0)
    if solution == true {
      q-counter.update(n => n - 1)
      i = i - 1
      // typst has some weird behavior, so this i-- is necessary unfortunately
    }
    if i >= q.len() or q.at(i) == 1 {
      if solution == true {
        new-thm(exercise_sub, title: q-t.at(i), label: label)[#body]
      }
      else {
        new-thm(exercise_statement_sub, title: q-t.at(i), label: label)[#body]
      }
      if i >= qg.len() or qg.at(i) > 1 {
        pagebreak()
      }
    }
    q-counter.step()
  }
}

// ======
// GRADED 
// ======
#let graded_table(parts) = {
  let rows = ()
  
  for (part-index, part) in parts.enumerate() {
    // Add part header row
    if parts.len() > 1 {
      rows = rows + (
        (text(weight: "bold")[Part #(part-index + 1)], [], [])
      )
    }
    
    // Process each row in this part (3 elements per row)
    for i in range(0, part.len(), step: 3) {
      let self-pts = part.at(i)
      let max-pts = part.at(i + 1)
      let desc = part.at(i + 2)
      
      rows = rows + (
        ($#self-pts pt$, $#max-pts pt$, [#desc])
      )
    }
  }
  
  figure(
    box(width: 100%)[
      #table(
        columns: (auto, auto, auto),
        align: horizon + left,
        table.header(
          [Self-Graded Pts], [Max Rubric Pts], [Rubric Description],
          ..rows
        ),
      )
    ]
  )
}

#let graded = base-thm.with(
  fmt-prefix: (s, _, t) => {
    text(weight: "bold", stretch: 85%)[Exercise #t #s]
    h(0.5em)
  },
  kind: "graded",
  supplement: "Graded",
  number: none,
)

#let graded_custom(body, title: none, label: none) = {
  context{
    let i = q-counter.get().at(0)
    if grading == 1 and (i >= q.len() or q.at(i) == 1) {
      new-thm(graded, title: q-t.at(i), label: label)[#body]
    }
  }
}

#let code(body) = {
  text(font: code-font)[#body]
}

#let todo(body) = {
  text(fill: red)[[TODO: #body]]
}

#let inco(body) = {
  text(font: "Inconsolata")[#body]
}

#let pseudocode-comment(body) = {
  text(fill:green)[_\/$ast$ #body $ast$\/_]
}

#let my-diagram(spaced: true, ..args) = [
  #if spaced {v(1em)}
  #fletcher.diagram(
    label-size: 0.8em,
    spacing: 2cm,
    ..args
  )
  #if spaced {v(2em)}
]

#let diagram = my-diagram
