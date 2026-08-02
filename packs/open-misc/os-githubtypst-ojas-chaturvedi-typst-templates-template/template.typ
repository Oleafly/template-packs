#let assignment(title, author, course_id, professor_name, semester, due_time, body) = {
  set document(title: title, author: author)
  set text(12pt)
  set page(
    paper:"us-letter",
    header: locate( 
        loc => if (
            counter(page).at(loc).first()==1) { none } 
        else if (counter(page).at(loc).first()==2) { align(right, 
              [*#author* | *#course_id: #title* | *Problem 1*]
            ) }
        else { 
            align(right, 
              [*#author* | *#course_id: #title* | *Problem #problem_counter.at(loc).first()*]
            ) 
        }
    ),
    footer: locate(
      loc => if (
            counter(page).at(loc).first()==1) { none } 
      else {
        let page_number = counter(page).at(loc).first()
        let total_pages = counter(page).final(loc).last()
        align(center)[Page #page_number of #total_pages]
      }
    )
  )
  block(height:25%,fill:none)
  align(center, text(17pt)[
    *#course_id: #title*])
  align(center, text(10pt)[
    Due on #due_time])
  align(center, [_Prof. #professor_name _, #semester, #due_time])
  block(height:35%,fill:none)
  align(center)[*#author*]
  
  pagebreak(weak: false)
  body
}

#let problem_counter = counter("problem")

#let prob(question, body) = {
  [== Problem #problem_counter.step() #problem_counter.display()]
  text(12pt)[Question: #question]
  block(fill:rgb(250, 255, 250),
    width: 100%,
    inset:8pt,
    radius: 4pt,
    stroke:rgb(31, 199, 31),
    body)
  }
