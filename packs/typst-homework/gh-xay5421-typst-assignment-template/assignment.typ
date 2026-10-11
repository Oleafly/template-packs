#import "@preview/showybox:2.0.3": showybox

// 颜色盘
#let prob_palette = (
  blue, orange.darken(10%), purple, olive, 
  red.darken(10%), teal, rgb("#d0335b"),
)

#let problem_counter = counter("problem")

// -----------
// Problem 函数
// -----------
#let prob(
  title: "", 
  color: auto, 
  newpage: true,
  solution: none, 
  comment: none,
  ..body
) = {
  
  problem_counter.step()
  if newpage { pagebreak(weak: true) }
  
  context {
    let current_num = problem_counter.get().first()
    
    // 颜色计算
    let box_color = if color == auto {
      prob_palette.at(calc.rem(current_num - 1, prob_palette.len()))
    } else { color }

    // 标题逻辑
    let box_title = if title != "" {
      [Problem #current_num: #title]
    } else {
      [Problem #current_num]
    }

    showybox(
      frame: (
        border-color: box_color.darken(20%),
        title-color: box_color.lighten(80%),
        body-color: box_color.lighten(96%),
        radius: 4pt,
        thickness: 1.5pt,
      ),
      title-style: (
        color: box_color.darken(30%),
        weight: "bold",
      ),
      shadow: (
        offset: 3pt,
        color: gray.lighten(50%)
      ),
      breakable: true, 
      title: box_title,
      
      [
        // ------------------------------------------------
        // 核心修复逻辑开始
        // ------------------------------------------------
        
        // 1. 安全地获取题目内容
        // 如果用户没写 body，pos() 是空数组，join() 可能会出错，所以要先判断
        #let body-parts = body.pos()
        #let body-content = if body-parts.len() > 0 { body-parts.join() } else { [] }

        // 2. 判定是否有实质性的题目内容
        // 只有当 body-content 不等于空内容 [] 时，才算有题
        #let has-body = body-content != []

        // 3. 显示题目
        #if has-body {
          body-content
        }

        // 4. 显示分割线
        // 条件：必须“有题目”且“有答案”，才画线！
        #if has-body and solution != none {
          pad(top: 0.3em, bottom: 0.3em)[
             #line(length: 100%, stroke: (paint: box_color, dash: "dashed", thickness: 0.5pt))
          ]
        }

        // 5. 显示答案
        #if solution != none {
          text(weight: "bold", fill: box_color.darken(20%))[Solution:]
          v(0.2em)
          solution
        }

        // 6. 显示评论 (Comment)
        #if comment != none {
            // 如果只有答案或者只有题目，或者都有，只要上方有东西，就画线
            if has-body or solution != none {
                pad(top: 0.3em, bottom: 0.3em)[
                     #line(length: 100%, stroke: (paint: box_color, dash: "dashed", thickness: 0.5pt))
                ]
            }
            
            // 评论样式
            text(size: 0.9em)[
                #text(weight: "bold", fill: box_color.darken(30%))[Note:] 
                #h(0.5em)
                #text(style: "italic", fill: black.lighten(40%), comment)
            ]
        }
        // ------------------------------------------------
        // 逻辑结束
        // ------------------------------------------------
      ]
    )
  }
}

// -----------
// Homework 模版主函数
// -----------
#let homework(
  author: "", student-id: "", course: "", title: "", 
  date: datetime.today().display(), 
  accent-color: rgb("#000000"), 
  paper-size: "a4", 
  body
) = {
  set document(title: title, author: author)
  set text(font: ("Linux Libertine O", "Times New Roman", "SimSun"), size: 11pt, lang: "en")
  set par(justify: true, leading: 0.8em)
  set heading(numbering: "1.1")

  // 代码块样式
  show raw.where(block: true): block.with(
    fill: luma(248), inset: 10pt, radius: 4pt, width: 100%, stroke: luma(230)
  )
  show raw.where(block: false): box.with(
    fill: luma(242), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt
  )

  set page(
    paper: paper-size,
    margin: (x: 2cm, y: 2.5cm),
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 9pt)
        let current-prob-num = problem_counter.get().first()
        grid(
          columns: (1fr, 1fr, 1fr),
          align: (left, center, right),
          [#author #student-id],
          [#course #title],
          strong[Problem #current-prob-num] 
        )
        v(-8pt)
        line(length: 100%, stroke: 0.5pt + gray)
      }
    },
    footer: context {
      set align(center)
      set text(size: 9pt, fill: gray)
      [Page #counter(page).display() of #counter(page).final().first()]
    },
  )

  align(center, {
    v(3em)
    text(2.2em, weight: "bold", fill: accent-color, title)
    v(1.2em)
    text(1.4em, weight: "bold", [Course: #course])
    v(0.8em)
    text(1.1em, [#author (#student-id)])
    v(0.5em)
    text(0.9em, style: "italic", date)
    v(2em)
    line(length: 60%, stroke: 0.5pt + gray.lighten(40%))
    v(2em)
  })

  body
}