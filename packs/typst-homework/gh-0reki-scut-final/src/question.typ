#import "utils/counter.typ": q-counter, sq-counter, current-type, current-points, show-points, reset-c, reset-sq
#import "type/choice.typ": render-choice, choice, reset-choice
#import "type/blank.typ": blank
#import "score.typ": score

#let get-type = type

#let render-stats() = {
  context {
    let points = current-points.get()
    let qtype = current-type.get()
    let current-pos = here().position()
    let all-questions = query(metadata).filter(q => {
      type(q.value) == dictionary and "points" in q.value
    })
    
    let next-q-pos = none
    for q in all-questions {
      let q-pos = q.location().position()
      let is-after = if q-pos.page > current-pos.page {
        true
      } else if q-pos.page < current-pos.page {
        false
      } else {
        q-pos.y > current-pos.y
      }
      
      if is-after {
        next-q-pos = q-pos
        break
      }
    }
    let all-subquestions = query(metadata).filter(sq => {
      type(sq.value) == str and sq.value == "subquestion"
    })
    
    let sq-count = 0
    for sq in all-subquestions {
      let sq-pos = sq.location().position()
      let is-after-current = if sq-pos.page > current-pos.page {
        true
      } else if sq-pos.page < current-pos.page {
        false
      } else {
        sq-pos.y > current-pos.y
      }
      
      if not is-after-current {
        continue
      }
      if next-q-pos != none {
        let is-before-next = if sq-pos.page < next-q-pos.page {
          true
        } else if sq-pos.page > next-q-pos.page {
          false
        } else {
          sq-pos.y < next-q-pos.y
        }
        
        if is-before-next {
          sq-count += 1
        }
      } else {
        sq-count += 1
      }
    }
    
    let choice-suffix = if qtype == "choice" and sq-count == 0 { "(     )" } else { "" }
    let points-suffix = if points != none and sq-count == 0 { "（" + str(points) + "分）" } else { "" }
    
    if sq-count > 0 and points != none {
      let total = points * sq-count
      text(size: 14pt)[#choice-suffix#points-suffix 共#(sq-count)题，每题#(points)分，共#(total)分.]
    } else {
      text(size: 14pt)[#choice-suffix#points-suffix]
    }
  }
}

#let question(
  type: "general",
  points: none,
  body
) = {
  context {
    let prev-type = current-type.get()
    if prev-type == "choice" {
      render-choice()
    }
  }
  
  current-type.update(type)
  current-points.update(points)
  show-points.update(points != none)

  if type == "choice" {
    reset-choice()
  }

  reset-sq()
  q-counter.step()
  
  context {
    let current-number = numbering("一、", q-counter.get().first())
    let current-pos = here().position()
    
    let choice-suffix = if type == "choice" and not has-subquestion { "(     )" } else { "" }

    block(
      width: 100%,
      [
        #place(right, dx: 3em, dy: 5em)[#score()]
        #text(size: 14pt)[*#(current-number)*#(body)#(choice-suffix)*#render-stats()*]
        #metadata((points: points)) <question-marker>
      ]
    )
  }
}

#let subquestion(
  stype: none,
  points: none,
  body
) = {
  context {
    let prev-type = current-type.get()
    let actual-type = if stype != none { stype } else { prev-type }
    
    if stype != none and stype != prev-type {
      if prev-type == "choice" {
        render-choice()
      }
      if actual-type == "choice" {
        reset-choice()
      }
    }
  }
  
  sq-counter.step()
  
  context {
    let current-number = sq-counter.get().first()
    let sub-numbering = numbering("1.", current-number)
    let question-points = current-points.get()
    let display-points = if question-points == none and points != none {
      text(size: 10.5pt)[ (本题#(points)分)]
    } else { none }
    
    let actual-type = if stype != none { stype } else { current-type.get() }
    let choice-suffix = if actual-type == "choice" { "(     )" } else { "" }
    
    v(0.5em)
    
    block(
      width: 100% - 1em,
      [
        #text[*#sub-numbering*]*#(display-points)*#body #choice-suffix
      ]
    )
    
    v(0.3em)
  }
  
  context {
    let actual-type = if stype != none { stype } else { current-type.get() }
    if actual-type == "choice" {
      render-choice()
      reset-choice()
    }
  }
  
  [#metadata("subquestion") <subquestion>]
  if points != none [#metadata((subquestion-points: points))]
}

#let finish-exam() = {
  context {
    let last-type = current-type.get()
    if last-type == "choice" {
      render-choice()
    }
  }
}