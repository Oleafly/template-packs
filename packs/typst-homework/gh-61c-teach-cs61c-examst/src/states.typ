
/// Set up state for the exam
#let print-answers = state("print-answers", false)
#let questions = state("questions", ())
#let question-num = counter("question-num")
#let part-num = counter("part-num")
#let sub-part-num = counter("sub-part-num")

#let show-answer-letters = state("show-answer-letters", false)
#let answer-letters = counter("answer-letters")

/// Returns the number of questions in the entire exam
#let num-questions() = questions.at(<exam-end>).len()

/// Returns the number of points in the entire exam.
#let num-points() = {
  if num-questions() == 0 {
    0
  } else {
    questions.at(<exam-end>).map(q => q.points).sum()
  }
}

