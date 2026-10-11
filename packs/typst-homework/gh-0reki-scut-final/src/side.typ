#import "@preview/cuti:0.3.0": show-cn-fakebold, regex-fakebold

#let side(name) = (doc) => {
  show: show-cn-fakebold
  show strong: it => {
    set text(weight: "bold")
    show regex("[0-9A-Za-z。]+"): content => regex-fakebold(reg-exp: "[0-9A-Za-z。]")[#content]
    it.body
  }

  let dot_size = 1.5pt
  let dot_spacing = 2pt
  let group_spacing = 3.5pt

  let dot_group = box(
    height: 3 * dot_spacing + 2 * dot_size,
    width: dot_size,
    {
      place(top + left, circle(radius: dot_size/2, fill: black))
      place(top + left, dy: dot_spacing + dot_size, circle(radius: dot_size/2, fill: black))
      place(top + left, dy: 2 * (dot_spacing + dot_size), circle(radius: dot_size/2, fill: black))
    }
  )

  let dot_pattern_with_text = {
    let elements = ()
    let total_height = 29.7cm
    let group_height = 3 * dot_spacing + 2 * dot_size + group_spacing
    let group_count = calc.floor(total_height / group_height)
    
    let text_chars = ("线", "封", "密")

    let text_positions = (
      calc.floor(group_count * 0.25),
      calc.floor(group_count * 0.5),
      calc.floor(group_count * 0.75)
    )
    
    for i in range(group_count) {
      let should_replace = false
      let char_index = 0
      
      for (j, pos) in text_positions.enumerate() {
        if i == pos {
          should_replace = true
          char_index = j
          break
        }
      }
      
      if should_replace {
        let base_y = i * group_height
        elements.push(place(
          top + left, 
          dy: base_y,
          dx: -4.5pt,
          rotate(270deg, text(text_chars.at(char_index), size: 10.5pt)),
          ))
      } else {
        elements.push(place(top + left, dy: i * group_height, dot_group))
      }
    }
    elements.join()
  }

  let input_field(width) = box(width: width, stroke: (bottom: 0.5pt), height: 1em, outset: (right: -0.5em))

  let student_grid = grid(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
    column-gutter: 0.2em,
    row-gutter: 0.5em,
    
    ..([姓名], [学号], [学院], [专业], [座位号])
      .zip((
        input_field(4cm),
        pad(right: 0.5em, grid(columns: 12, column-gutter: 0pt, ..range(12).map(_ => box(width: 0.8em, height: 1.2em, stroke: 0.5pt)))),
        input_field(5cm),
        input_field(4cm),
        input_field(2cm)
      ))
      .flatten()
  )

  set page(
    paper: "a4",
    margin: (x: 3.18cm, y: 2.54cm),
    number-align: center,
    foreground: context [
      #let page-num = counter(page).get().first()
      #if page-num == 1 [
        #place(
          horizon,
          dx: 2.5cm,
          dy: -14.7cm,
          dot_pattern_with_text,
        )

        #place(
          horizon,
          dx: -8.55cm,
          rotate(
            -90deg,
            origin: center + horizon,
            block(
              width: 29.7cm,
              stroke: (none),
              inset: 0.5em,
              align(center)[
                #text(size: 10.5pt)[( 密 封 线 内 不 答 题 )]
              ]
            )
          )
        )
        // Student information section
        #place(
          horizon,
          dx: -9.20cm,
          rotate(
            -90deg,
            origin: center + horizon,
            block(
              width: 27cm,
              inset: 0.8em,
              [
                #set text(size: 12pt)
                #student_grid
              ]
            )
          )
        )
      ]
    ],
    
    footer: context [
      #set text(size: 9pt, font: ( "SimSun"))
      #pad(
        left: 2.5cm,
        align(center)[
          #counter(page).display(
            (n, total) => [
              *《#name》试卷 第 #(n) 页 共 #(total) 页*
            ],
            both: true
          )
        ]
      )
      
    ]
  )
  
  set text(
    font: "SimSun"
  )
  
  doc
}