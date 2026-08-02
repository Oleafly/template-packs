#import "@preview/physica:0.9.8": *
#import "@preview/theorion:0.6.0": *

// Is this good?
#import cosmos.clouds: *

#let (example-counter, example-box, example, show-example) = make-frame(
  "example",
  theorion-i18n-map.at("example"),
  counter: theorem-counter,
  render: (prefix: none, title: "", full-title: auto, body) => {
    if full-title != "" {
      strong[#full-title.] + sym.space
    }
    body
  }
)

#let (problem-counter, problem-box, problem, show-problem) = make-frame(
  "problem",
  theorion-i18n-map.at("problem"),
  counter: theorem-counter,
  render: (prefix: none, title: "", full-title: auto, body) => {
    let result = []

    if full-title != "" {
      result += strong[#full-title.] + " " + sym.space
    }
    result += body

    block(
      width: 100%,
      radius: 3%,
      inset: 7pt, 
      fill: rgb("f7f7f7"),
      result
    )
  }
)

#let homework(doc, course, assignment_number, name, id) = {
  set text(font: "New Computer Modern", size: 12pt)
  show math.equation: set text(font: "New Computer Modern Math")

  show math.equation.where(block: true): eq => {
   block(width: 100%, inset: 0pt, align(center, eq))
  }

  set page(numbering: "1")

  show table: set block(breakable: false)

  show title: set text(weight: "medium")
  let today = datetime.today()

  place(
    top + center,
    float: true,
    block(
      {
        title(course + " - Assignment " + str(assignment_number))

        block(name + " - " + str(id))

        block(today.display("[month repr:long] [day], [year]"))
      }
    )
  )

  doc
}

#let note(doc, name) = {
  show: show-theorion

  show: show-example
  show: show-problem

  set heading(numbering: "1.1")
  set page(numbering: "1")

  show title: set text(weight: "medium")

  align(title(name), center)

  doc
}

// Shortcuts
#let x = sym.crossmark
#let v = sym.checkmark
#let parts = enum.with(numbering: "a)")
#let ip = innerproduct
#let ker(x) = $"Ker"(#x)$
#let span(x) = $"span"(#x)$
#let Id = "Id"
#let ev(x, y) = $evaluated(#x)_#y$

#let exercise_counter = state("exercise_counter", 0)
#let exercise_status = state("exercise_status", array(()))

#let exercise(..args, done: false, todo: "") = {
  //line(length: 100%, stroke: 1pt + gray)

  [= Exercise #context (exercise_counter.get() + 1)] 

  let problem = ""
  let solution = ""
  if args.pos().len() == 1 {
    solution = args.at(0)
  } else {
    problem = args.at(0)
    solution = args.at(1)
  }

  if type(problem) == array {
    problem = parts(..problem) 
  }
  if type(solution) == array {
    solution = parts(..solution) 
  }

  if problem == "" {
    solution
  } else {
    [== Problem]
    problem

    [== Solution]
    solution
  }

  exercise_counter.update(old => old + 1)

  exercise_status.update(old => {
    old.push(array((done, todo)))
    return old
  })
}

#let iff(first_direction, second_direction) = {
  [$=>)$]
  first_direction

  [
    \
  ]

  [$arrow.double.l)$]
  second_direction
}

#let todo_status(default_todo: "", display_total: true) = {
  [= Done Status]

  context {
    let i = 0
    let total_done = 0
    let exercise_count = exercise_counter.final()
    while i < exercise_count {
      let done = exercise_status.final().at(i).at(0)
      let todo = exercise_status.final().at(i).at(1)
      if done {
        total_done += 1
        [+ #v]
      } else {
        if todo.len() == 0 {
          if default_todo.len() == 0{
            [+ #x]
          } else {
            [+ #x - *#default_todo*]
          }
        } else {
          [+ #x - *#todo*]
        }
      }
      i += 1
    }

    if display_total {
      [*Total: #total_done/#exercise_count*]
    }
  }
}
