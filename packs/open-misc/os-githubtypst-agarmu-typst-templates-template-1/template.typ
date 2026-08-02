
#let problem_counter = counter("problem")

#let prob(question: none, body) = {
  // let current_problem = problem_counter.step()
  problem_counter.step()
  pagebreak(weak: true)
  [= Problem  #problem_counter.display()]
 
if question != none {
    v(0.25em)
    [
    #question
    #line(length: 100%, stroke: 0.5pt)#v(0.5em)
    ] } else { v(0.75em) }

  [#body]
}

// Initiate the document title, author...
#let assignment_class(title, author, course_id, professor_name, semester, due_time, collaborators, body) = {
  set math.mat(delim: "[")
  set math.vec(delim: "[")
  set document(title: title, author: author)
  show par: set block(above: 1em, below: 1em)
  show heading: set block(above: 1.4em, below: 1em)
  set par(justify: true)
  set page(
    paper:"us-letter", 
    header: locate( 
        loc => if (
            counter(page).at(loc).first()==1) { none } 
          else { 
            let ptot = problem_counter.final(loc).last()
            align(right, 
              [*#author* | *#course_id: #title* | *Problem
              #problem_counter.display() of #ptot*]
            ) 
        }
    ), 
    footer: locate(loc => {
      let page_number = counter(page).at(loc).first()
      let total_pages = counter(page).final(loc).last()
      align(center)[Page #page_number of #total_pages]
    }))
  v(0.5fr)
  align(center, text(17pt)[
    *#course_id: #title*])
  align(center, text(10pt)[
    Due on #due_time])
  align(center, [_Prof. #professor_name _, #semester])
  v(3fr)
  align(center)[*#author*]
  v(1fr)
  body
}
