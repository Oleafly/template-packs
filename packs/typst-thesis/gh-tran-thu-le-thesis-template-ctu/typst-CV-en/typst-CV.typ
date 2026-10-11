// #let mystroke = gray +0.1pt
#let mystroke = none
#let mycolor = blue // blue, green, red, aqua
#set text(font: "New Computer Modern Math", size: 1.1em)
#set par(leading: 1em)
#show link: set text(fill: mycolor)
#let content(title: "Content Title", ..cont) = table(
  columns: (1fr, 4fr),
  stroke: mystroke,
  align: top,
  table.cell(align: bottom)[#line(length:100%, stroke: mycolor+0.7em) #v(0.2em)],
  [#text(fill: mycolor, size: 1.1em)[#title]],
  ..cont
) 

// -------------------------------------
// You put your Information here
// -------------------------------------
#let cell1 =[
  // #align(center)[#image("avatar.jpg", width: 50%)]
  #text(size: 2em, fill: mycolor)[*Van-A Nguyen*] \
  #text(size: 1.3em)[Mathematics Student]\
  #text(size: 1.3em)[Can Tho University, Vietnam]\
]
#let cell2 =[
  #align(center)[#image("avatar.jpg", width: 70%)]
  #text(size: 0.7em)[
    Email: nguyenvana\@gmail.com \
    Phone: 0362 xxx xxx \
    Birth: 01/01/2000 \
    Webpage: #link("https://tranthule.blogspot.com/p/about-me.html")[tranthule.blogspot.com]
  ]
]

#table(columns: (1.5fr, 1fr), 
  align: (horizon , left),
  stroke: mystroke,
  cell1, cell2,
)

#content(title: [Education],
  [2024-now], [Bachelor in Mathematics, Can Tho university, Vietnam],
  [2020-2023], [Nguyen Thi Minh Khai High school for the gifted, Soc Trang, Vietnam],
)

#content(title: [Selected Publications],
  [2025], [Chương, Lâm Hoàng, and Trịnh Hữu Nghiệm. "Moment bậc cao cho bước đi ngẫu nhiên trong không gian trạng thái rời rạc." Tạp chí Khoa học Đại học Cần Thơ 60 (2024): 58-62.],
)

#content(title: [Award and Honors],
  [2025], [Bronze Medal in *National Mathematics Olympiad*],
  [2024], [Join the *National Mathematics Olympiad* Team of Can Tho University],
  [2024], [Top-ranked student in the entrance cohort for Mathematics],
  [2023], ["Thắp sáng tài năng" Scholarship],
)

#content(title: [Experience],
  [2025], [Short-term academic exchange at Walailak University, Thailand],
  [2024], [Short-term academic exchange at Ostrava University, Czech Republic],
  [2023], [Participated in the Green Summer Volunteer Campaign in Bến Tre Province],
)

#pagebreak()
#content(title: [Computer skills],
  [Programming], [Python],
  [Markup lang.], [Latex, Typst],
)

#content(title: [Languages],
  [Vietnamese], [Native],
  [English], [Fluent, IELTS 6.5],
  [French], [Basic, B2],
)


#content(title: [Research Interest],
  [], [I am conducting research on optimal transport by designing efficient algorithms based on combinatorial optimization.
  #image("OT.png")
  
  I am also interested in optimization applications in:
  - Machine Learning and AI
  - Operations Research
  - Statistics
  - Signal & Image Processing
  ],
)



