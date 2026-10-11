#import "@preview/grape-suite:4.0.0": exercise
#import exercise: *

#let _type = type

// Our colors match grape-suite 4.0.0 defaults
#let grape-blue = rgb("#648fff")
#let grape-purple = rgb("#555ef0").darken(50%)
#let grape-blue-light = grape-blue.lighten(75%)

// Czech translations for grape-suite
#let czech-box-translations = (
  "task": [Úkol],
  "hint": [Nápověda],
  "solution": [Navrhované řešení],
  "definition": [Definice],
  "notice": [Upozornění!],
  "example": [Příklad],
)

// Helper function to make element with Czech points format
#let make-element(type, no, title, body) = {
  block(inset: 7pt, stroke: (bottom: (paint: grape-purple, dash: "dashed")), fill: grape-blue-light, {
    text(fill: grape-purple, strong[#type #no] + title)
  })

  block(body)
  v(0.5cm)
}

// Custom make-task function with "B." instead of "P."
#let make-task(no, title, instruction, body, extra, points, lines, extra-task-type, task-type) = {
  make-element(
    if extra { extra-task-type } else { task-type },
    no,
    if title != none [ --- #title] + h(1fr) + points,

    block(width: 100%, {
      state("grape-suite-subtask-indent").update((0,))

      if instruction != none and instruction not in ([], [ ]) {
        block(instruction)
      }

      state("grape-suite-subtask-indent").update((0,))

      if body != none and body not in ([], [ ]) { block(body) }

      context {
        if state("grape-suite-show-lines").at(here()) == false {
          return
        }

        for i in range(0, lines) {
          v(0.75cm)
          v(-1.2em)
          line(length: 100%, stroke: black.lighten(50%))
        }
      }
    }),
  )
}

// Save grape-suite's inline hint/solution before we override task
#let _gs-hint = hint
#let _gs-solution = solution

// Czech project function extending grape-suite with Czech translations and point format changes
#let project(
  no: none,
  type: [Test],
  title: none,
  suffix-title: none,
  show-outline: false,
  abstract: none,
  document-title: none,
  show-hints: false,
  show-solutions: false,
  show-namefield: true,
  namefield: [*Jméno a příjmení:*],
  show-timefield: false,
  timefield: time => [Čas: #time min.],
  max-time: 0,
  show-lines: false,
  show-titlepage: false,
  show-point-distribution: false,
  show-points-table: false,
  show-grading-rubric: false,
  show-grading-rubric-comment-field: false,
  grading-rubric-comment-field-value: [*Poznámka:* #v(0.5cm)],
  university: [DELTA - Střední škola informatiky a ekonomie, s.r.o.],
  faculty: none,
  institute: none,
  seminar: none,
  semester: none,
  instructor: none,
  author: none,
  date: datetime.today(),
  date-format: date => if type(date) == type(datetime.today()) { date.display("[day].[month].[year]") } else { date },
  header: none,
  header-gutter: 20%,
  header-right: none,
  header-middle: none,
  header-left: none,
  show-header-line: true,
  footer: none,
  footer-right: none,
  footer-middle: none,
  footer-left: none,
  show-footer-line: true,
  // Czech translations
  task-type: [Úkol],
  extra-task-type: [Bonusový úkol],
  box-task-title: czech-box-translations.at("task"),
  box-hint-title: czech-box-translations.at("hint"),
  box-solution-title: czech-box-translations.at("solution"),
  box-definition-title: czech-box-translations.at("definition"),
  box-notice-title: czech-box-translations.at("notice"),
  box-example-title: czech-box-translations.at("example"),
  sentence-supplement: "Příklad",
  hint-type: [Nápověda],
  hints-title: [Nápovědy],
  solution-type: [Navrhované řešení],
  solutions-title: [Navrhovaná řešení],
  grading-rubric-task-header: [Úkoly],
  grading-rubric-achieved-points-header: [Dosažené body],
  distribution-header-point-value: [Body],
  distribution-header-point-grade: [Známka],
  points-table-header-task: [Úkol],
  points-table-header-points: [Body],
  points-table-header-achieved: [Dosaženo],
  // Message with Czech text and "B." instead of "P."
  message: (
    points-sum,
    extrapoints-sum,
  ) => [Celkem je dosažitelných #points-sum + #extrapoints-sum B. Dosáhl/a jste #box(line(stroke: purple, length: 1cm)) z #points-sum bodů.],
  grade-scale: (
    ([výborný], 0.9),
    ([velmi dobrý], 0.8),
    ([dobrý], 0.7),
    ([dostatečný], 0.6),
    ([nedostatečný], 0.49),
  ),
  page-margins: (x: 1cm, y: 2.5cm),
  text-font: ("Atkinson Hyperlegible Next", "Atkinson Hyperlegible", "Libertinus Serif"),
  math-font: ("STIX Two Math", "New Computer Modern Math"),
  fontsize: 11pt,
  format-links: true,
  show-todolist: true,
  colors-primary: grape-purple,
  colors-accent: grape-blue,
  colors-highlight: rgb("#dc267f"),
  colors-warning: rgb("#ffb000"),
  colors-warning-dark: rgb("#fe6100").darken(50%),
  body,
) = {
  // Call the original project function with Czech translations
  exercise.project(
    no: no,
    type: type,
    title: title,
    suffix-title: suffix-title,
    show-outline: show-outline,
    abstract: abstract,
    document-title: document-title,
    show-hints: show-hints,
    show-solutions: show-solutions,
    show-namefield: show-namefield,
    namefield: namefield,
    show-timefield: show-timefield,
    timefield: timefield,
    max-time: max-time,
    show-lines: show-lines,
    show-titlepage: show-titlepage,
    show-point-distribution: show-point-distribution,
    show-points-table: show-points-table,
    show-grading-rubric: show-grading-rubric,
    show-grading-rubric-comment-field: show-grading-rubric-comment-field,
    grading-rubric-comment-field-value: grading-rubric-comment-field-value,
    university: university,
    faculty: faculty,
    institute: institute,
    seminar: seminar,
    semester: semester,
    instructor: instructor,
    author: author,
    date: date,
    date-format: date-format,
    header: header,
    header-gutter: header-gutter,
    header-right: header-right,
    header-middle: header-middle,
    header-left: header-left,
    show-header-line: show-header-line,
    footer: footer,
    footer-right: footer-right,
    footer-middle: footer-middle,
    footer-left: footer-left,
    show-footer-line: show-footer-line,
    task-type: task-type,
    extra-task-type: extra-task-type,
    box-task-title: box-task-title,
    box-hint-title: box-hint-title,
    box-solution-title: box-solution-title,
    box-definition-title: box-definition-title,
    box-notice-title: box-notice-title,
    box-example-title: box-example-title,
    sentence-supplement: sentence-supplement,
    hint-type: hint-type,
    hints-title: hints-title,
    solution-type: solution-type,
    solutions-title: solutions-title,
    grading-rubric-task-header: grading-rubric-task-header,
    grading-rubric-achieved-points-header: grading-rubric-achieved-points-header,
    distribution-header-point-value: distribution-header-point-value,
    distribution-header-point-grade: distribution-header-point-grade,
    points-table-header-task: points-table-header-task,
    points-table-header-points: points-table-header-points,
    points-table-header-achieved: points-table-header-achieved,
    message: message,
    grade-scale: grade-scale,
    page-margins: page-margins,
    text-font: text-font,
    math-font: math-font,
    fontsize: fontsize,
    format-links: format-links,
    show-todolist: show-todolist,
    colors-primary: colors-primary,
    colors-accent: colors-accent,
    colors-highlight: colors-highlight,
    colors-warning: colors-warning,
    colors-warning-dark: colors-warning-dark,
    body,
  )
}

// Custom task function that renders points as "B." instead of "P."
#let task(
  lines: 0,
  points: 0,
  extra: false,
  ignore-points: false,
  rubric: none,
  numbering-format: none,
  instruction-format: none,
  title-format: none,
  type: none,
  title,
  instruction,
  ..args,
) = (
  counter(if extra { "tasks" } else { "extra-tasks" }).step()
    + context {
      let task-translation-state = state("grape-suite-task-translations", (
        task-type: [Úkol],
        extra-task-type: [Bonusový úkol],
      ))
      let task-type = task-translation-state.final().task-type
      let extra-task-type = task-translation-state.final().extra-task-type

      let numbering-format = numbering-format
      if numbering-format == none {
        numbering-format = (..c) => numbering(if extra { "1" } else { "A" }, ..c)
      }

      let title-format = title-format
      if title-format == none {
        title-format = it => it
      }

      let instruction-format = instruction-format
      if instruction-format == none {
        instruction-format = emph
      }

      let args-pos = args.pos()
      let no = numbering-format(..counter(if extra { "tasks" } else { "extra-tasks" }).at(here()))

      let t = (
        no: no,
        title: if title != none { title-format(title) },
        instruction: if instruction != none { instruction-format(instruction) },
        body: args-pos.at(0, default: none),
        rubric: if args-pos.len() > 1 and _type(args-pos.at(1)) == array { args-pos.at(1) } else { rubric },
        points: points,
        extra: extra,
        ignore-points: ignore-points,
        extra-task-type: if type != none { type } else { extra-task-type },
        task-type: if type != none { type } else { task-type },
      )

      if t.body == [] or t.body == [ ] {
        t.body = none
      }

      state("grape-suite-tasks", ()).update(k => {
        k.push(t)
        return k
      })

      state("grape-suite-subtask-indent").update((0,))

      let t = state("grape-suite-tasks")
        .final()
        .filter(e => e.no == t.no and e.title == t.title)
        .first(default: none)

      if t != none {
        // Use custom make-task with "B." formatting
        make-task(
          no,
          t.title,
          t.instruction,
          t.body,
          t.extra,
          context {
            let points = t.points

            if points == 0 {
              let s = state("grape-suite-tasks", ())
              points = s.final().at(s.get().len() - 1).points
            }

            if points != 0 {
              [#points B.]
            }
          },
          lines,
          if type != none { type } else { extra-task-type },
          if type != none { type } else { task-type },
        )
      }
    }
    // Inline solution/hint rendering (grape-suite 4.0.0 style)
    + if args.pos().len() > 1 {
        if args.pos().len() > 2 {
          _gs-hint(args.pos().at(2))
        }

        if args.pos().at(1) != none and _type(args.pos().at(1)) != array {
          _gs-solution(args.pos().at(1))
        }
      }
    + v(0.5cm)
)

// Custom subtask function that renders points as "B." instead of "P."
#let subtask(
  points: 0,
  tight: false,
  ignore-points: false,
  markers: ("1.", "a)"),
  show-points: true,
  counter: none,
  content,
) = {
  if points != none and type(points) == int and not ignore-points {
    state("grape-suite-tasks", ()).update(k => {
      if k.len() == 0 {
        return k
      }

      let li = k.len() - 1
      let e = k.at(li)

      e.points += points

      k.at(li) = e
      return k
    })
  }

  state("grape-suite-subtask-indent", (0,)).update(k => {
    k.push(0)
    k
  })

  context {
    let indent = state("grape-suite-subtask-indent").at(here())

    let num = if counter == none {
      indent.at(indent.len() - 2) + 1
    } else {
      counter
    }

    let marker = if indent.len() - 2 >= markers.len() {
      "i."
    } else {
      markers.at(indent.len() - 2)
    }

    if not tight {
      v(0.25em)
    }

    grid(
      columns: (2em, 1fr),
      column-gutter: 0.75em,
      {
        set align(right)
        numbering(marker, num)
      },
      if points != none and points > 0 and show-points {
        metadata((type: "grape-suite-subtask-points", content: block(width: 7%, [#points B.])))
        content
      } else {
        content
      },
    )

    if not tight {
      v(0.25em)
    }
  }

  state("grape-suite-subtask-indent", (0,)).update(k => {
    k = k.slice(0, k.len() - 1)

    if k.len() > 0 {
      k.last() = k.last() + 1
    }

    k
  })
}
