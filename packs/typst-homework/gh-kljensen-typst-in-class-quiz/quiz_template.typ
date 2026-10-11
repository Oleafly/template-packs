#let quiz(
  title: none,
  margin: 1cm,
  date: none,
  options: "ABCDE",
  text_size: 10pt,
  doc,
) = {


  // As we process questions, we will increment
  // this counter. We'll need this to assemble
  // an array of correct answers and also to print
  // an answer key with the correct number of rows.
  let question_number = counter("question_number")
  question_number.update(0)

  // This is an array of arrays. Each sub-array has
  // the correct answers for a question.
  let correct_answers = state("correct_answers", ())

  // Function for printing the answer key
  // at the end of the quiz.
  let answer_key() = {
    let data = correct_answers.get().enumerate().map(((i, answer)) => {
      let question = i + 1
      let options = answer.map(o => {
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ".at(o)
      }).join(", ")
      return ([#question], [#options])
    }).flatten()
    table(columns: 2, ..data)
  }

  let question_number = counter("question_number")
  let option_number = counter("option_number")

  show list.where(indent: 0pt): it => {
    option_number.update(0)
    question_number.step()
    let bodies = it.children.map( c => {
      c.body
    })
    enum(numbering: "A.", ..bodies)
  }

  show "[x]": it => {
    context {
      let qn = question_number.get().first()
      let on = option_number.get().first()
      option_number.step()
      correct_answers.update( ca => {
        while ca.len() <= qn - 1 {
          ca.push(())
        }
        ca.at(qn - 1).push(on)
        return ca
      })
      // [#qn #on x]
      [#sym.zws #label(str(qn) + "-" + str(on))]
    }
  }
  show "[ ]": it => {
    context {
      let qn = question_number.get().first()
      let on = option_number.get().first()
      // [#qn #on]
      [#sym.zws #label(str(qn) + "-" + str(on))]
      option_number.step()
    }
  }


  // --------------------------------------------
  // First page: instructions and answer bubbles
  // --------------------------------------------

  // Title and date
  {
    set page(
      margin: 1.5in,

    )
    set page(header: [
      #set align(right)
      #overline(offset: -1.5em)[~~ \u{2191} Your Yale netid \u{2191} ~~]
    ])
    set align(center)
    text(17pt, title)
    if date == none {
      date = datetime.today().display("[month repr:long] [day], [year]")
    }
    parbreak()
    date
    v(1cm)

    // Instructions
    [== Instructions]
    {

    rect(inset: 1em)[
      #set list(indent: 0.1pt)
      #set align(left)
      - Do not flip over this page or read the questions on the other side of this page until the start of class.
      - Your quiz will be collected after ten minutes.
      - Write your netid _clearly_ at the top right.
      - _Unless otherwise stated_, each question has one correct answer.
      - Fill in the appropriate bubble below. I will grade nothing but these bubbles. If you need to change an answer please indicate your final answer clearly.
      - If a question stinks, Kyle will fix it later. I will not answer questions during the quiz.
      - This quiz is closed book, closed device. You can only use your own meat computer.
      - When you're done, _raise your hand_ and an instructor will collect it.
    ]
    }

    // Answer bubbles
    context {
      v(1cm)
      set align(center)
      box[
        == Answers
      ]
      v(0.25cm)

      let row_of_bubbles = options.clusters().map(c => {
        [#box(circle(inset: 1pt)[
          #set align(center)
          #set text(size: 6pt)
          #c
        ])]
      }).join(" ")

      let elements = ()
      let qn = 1
      let num_questions = question_number.final().first()
      while qn < num_questions + 1 {

        // Write the question number. We
        // shift this to align with bubbles.
        let label = block[
          #set text(baseline: 0.05em)
          #qn.
        ]
        elements.push(label)
        elements.push(row_of_bubbles)
        qn += 1
      }
      grid(
        columns: 2,
        align: (right, center),
        gutter: .75em,
        ..elements
      )
    }
  }
  pagebreak()


  // --------------------------------------------
  // Second page: quiz questions
  // --------------------------------------------
  {
    set page(
      columns: 2,
      margin: margin,
    )
    set text(size: text_size)

    // This is the document body that is received
    // as the final argument to the quiz template.
    doc
    pagebreak()
  }

  // --------------------------------------------
  // Third page: answer key
  // --------------------------------------------
  {
    set align(center)
    [== Answer Key]
    context[
      #answer_key()
    ]
    // context[
    //   #correct_answers.get()
    // ]
  }

}
