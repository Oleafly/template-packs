// main project
#let scut_ex_report(
  title: "",
  subtitle: none,
  author: "",
  ex_title: "",
  student_id: "",
  student_name: "",
  college: "",
  instructor: "",
  course_name: "",
  course_id: "",

  affiliation: none,
  year: none,
  class: none,
  other: none,
  date: datetime.today().display(),
  logo: none,
  main-color: "#0174B7",
  alpha: 60%,
  color-words: (),
  body,
) = {
  set document(author: author, title: title)

  // Save heading and body font families in variables.
  let body-font = "SimSun"
  let title-font = "SimSun"
  // Try the actual font family name from the TTF file
  let code-font = ("JetBrains Mono",  "Courier New", "SimSun")
  // Set colors
  let primary-color = rgb(main-color) // alpha = 100%
  // change alpha of primary color
  let secondary-color = color.mix(color.rgb(100%, 100%, 100%, alpha), primary-color, space:rgb)
  // Determine academic year range and semester based on date
  let current_year = datetime.today().year()
  let current_month = datetime.today().month()
  let current_day = datetime.today().day()
  let start_year = if current_month >= 9 { current_year } else { current_year - 1 }
  let end_year = start_year + 1
  let semester = if current_month >= 2 and current_month < 9 { "二" } else { "一" }
  // highlight important words
  show regex(if color-words.len() == 0 { "$ " } else { color-words.join("|") }): text.with(fill: primary-color)

  //customize look of figure
  set figure.caption(separator: [ --- ], position: top)

  //customize inline raw code
  // show raw.where(block: false) : it => h(0.5em) + box(fill: primary-color.lighten(90%), outset: 0.2em, it) + h(0.5em)
  show raw.where(block: false): it => (
    h(0.5em) + box(fill: primary-color.lighten(90%), outset: 0.3em, radius: 0.3em, text(font: code-font, it)) + h(0.5em)
  )
  // customize code blocks (```)
  show raw.where(block: true): it => block(
    stroke: primary-color,
    inset: 1em,
    radius: 0.3em,
    width: 100%,
    fill: primary-color.lighten(95%),
    text(font: code-font, it),
  )
  // Set body font family.
  set text(font: body-font, 12pt)
  show heading: set text(font: title-font, fill: primary-color)

  //heading numbering
set heading(numbering: (..nums) => {
  let level = nums.pos().len()
  // only level 1 and 2 are numbered
  let pattern = if level == 1 {
    "一."
  } else if level == 2 {
    "1."
  } else if level == 3 {
    "1.1."
  }
  if pattern != none {
    numbering(pattern, ..nums)
  }
})

  // add space for heading
  show heading.where(level:1): it => it + v(0.5em)
 
  // Set link style
  show link: it => underline(text(fill: primary-color, it))

  //numbered list colored
  set enum(indent: 1em, numbering: n => [#text(fill: primary-color, numbering("1.", n))])

  //unordered list colored
  set list(indent: 1em, marker: n => [#text(fill: primary-color, "•")])


  // display of outline entries
  show outline.entry: it => text(size: 12pt, weight: "regular",it)

  // Title page.
  // Logo at top right if given
  if logo != none {
    set image(width: 100%)
    place(top , logo)
  }
  // decorations at top left
  // place(top + left, dx: -35%, dy: -28%, circle(radius: 150pt, fill: primary-color))
  // place(top + left, dx: -10%, circle(radius: 75pt, fill: secondary-color))
  
  // decorations at bottom right
  // place(bottom +right, dx: 40%, dy: 30%, circle(radius: 150pt, fill: secondary-color))

  
  v(3.5fr)
  // SimSun 小一号字体约为24pt
  align(center, text(font: title-font, 24pt, weight: 700, title))
  v(24pt, weak: true)
  
  if subtitle != none {
  align(center, text(font: title-font, 24pt, weight: 700, subtitle))
  v(12pt, weak: true)
  }
  // Determine academic year range and semester based on date
  // SimSun 小二号字体约为18pt
  align(center, text(18pt,"（" + str(start_year) + "-" + str(end_year) + "学年第" + str(semester) + "学期）"))
  v(1.5fr)
  text(font: title-font, 18pt, weight: 700, "提交日期"+str(current_year)+"年"+str(current_month)+"月"+str(current_day)+"日")
  align(center,
    table(
  columns: (1fr, 2fr, 1fr, 1fr),
  inset: (x: 1em, y: 1.5em),

  [实验题目], table.cell(colspan: 3)[#ex_title],

  [学号], [#student_id], [姓名], [#student_name],
  [学院], [#college],[任课教师], [#instructor],
  [课程名称], [#course_name],[课程编号], [#course_id],
) 
  )
  v(1.5fr)
  pagebreak()


  // Table of contents.
  set page(
    numbering: "1 / 1", 
    number-align: center, 
    )


  // Main body.
  set page(
    header: [#emph()[#title #h(1fr) #author]]
  )
  set par(justify: true)

  body
  
}

//useful functions
//set block-quote
#let blockquote = rect.with(stroke: (left: 2.5pt + luma(170)), inset: (left: 1em))

// use primary-color and secondary-color in main
#let primary-color = rgb(1, 116, 183)
#let secondary-color = rgb(1, 116, 183, 60%)