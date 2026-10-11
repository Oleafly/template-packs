#let header(
  course,
  school,
  semester,
  model,
  form,
  demand,
  duration
) = [
  #text(size: 14pt)[*诚信应考，考试作弊将带来严重后果！*]
  #pad(
    left: 2.5cm,
    align(center)[
      #text(size: 22pt)[*#(school)本科生期末考试*]
      #v(-0.8em)
      #text(size: 14pt)[*《#(course)》#(model)卷*]
      #v(0em)
      #text(size: 12pt)[*#(semester)*]
    ]
  )
  #v(3em)
  
  #context {
    let all-metadata = query(metadata)
    let questions = all-metadata.filter(q => {
      type(q.value) == dictionary and "points" in q.value
    })
    let subquestions = all-metadata.filter(sq => {
      type(sq.value) == str and sq.value == "subquestion"
    })
    let subquestion-points = all-metadata.filter(sqp => {
      type(sqp.value) == dictionary and "subquestion-points" in sqp.value
    })
    
    let total = questions.len()
    let total-points = 0
    
    for (i, q) in questions.enumerate() {
      let q-pos = q.location().position()
      let q-points = q.value.points
      let next-q-pos = none
      if i + 1 < questions.len() {
        next-q-pos = questions.at(i + 1).location().position()
      }
      
      let sq-count = 0
      for sq in subquestions {
        let sq-pos = sq.location().position()
        let is-after = if sq-pos.page > q-pos.page {
          true
        } else if sq-pos.page < q-pos.page {
          false
        } else {
          sq-pos.y > q-pos.y
        }
        
        if not is-after { continue }
        if next-q-pos != none {
          let is-before = if sq-pos.page < next-q-pos.page {
            true
          } else if sq-pos.page > next-q-pos.page {
            false
          } else {
            sq-pos.y < next-q-pos.y
          }
          
          if is-before {
            sq-count += 1
          }
        } else {
          sq-count += 1
        }
      }
      
      if q-points != none {
        if sq-count > 0 {
          total-points += q-points * sq-count
        } else {
          total-points += q-points
        }
      } else {
        let sq-points-sum = 0
        for sqp in subquestion-points {
          let sqp-pos = sqp.location().position()
          let is-after = if sqp-pos.page > q-pos.page {
            true
          } else if sqp-pos.page < q-pos.page {
            false
          } else {
            sqp-pos.y > q-pos.y
          }
          
          if not is-after { continue }
          if next-q-pos != none {
            let is-before = if sqp-pos.page < next-q-pos.page {
              true
            } else if sqp-pos.page > next-q-pos.page {
              false
            } else {
              sqp-pos.y < next-q-pos.y
            }
            
            if is-before {
              sq-points-sum += sqp.value.subquestion-points
            }
          } else {
            sq-points-sum += sqp.value.subquestion-points
          }
        }
        total-points += sq-points-sum
      }
    }
    
    let notice_items = (
      "开考前请将密封线内各项信息填写清楚",
      demand,
      "考试形式：" + form,
      "本试卷共" + str(total) + "大题，满分" + str(total-points) + "分，考试时间" + str(duration) + "分钟"
    )

    align(left)[
      #set par(leading: 0.9em)
      #for (i, item) in notice_items.enumerate() [
        #if i == 0 [
          *注意事项：1. #item；*\
        ] else [
          #h(55pt) *#(i + 1). #item；* \
        ]
      ]
    ]
    v(1.5em)
    pad(
      left: 2.5cm,
      align(center)[
        #if total > 0 [
          #table(
            columns: (5em, ..range(total).map(_ => 3em), 5em),
            rows: (1.5em, 3em),
            stroke: 0.5pt,
            align: center + horizon,
            [*题 号*], 
            ..range(1, total + 1).map(i => [*#numbering("一", i)*]),
            [*总分*],
            [*得 分*], 
            ..range(total + 1).map(_ => []),
          )
        ]
      ]
    )
  }
  #v(-0.8em)
  #align(right)[评阅教师请在试卷袋上评阅栏签名]
  #v(4em)
]