#set text(lang: "zh")

#let justify-text(with-tail: false, tail: "：", body) = {
  if with-tail and tail != "" {
    stack(dir: ltr, stack(dir: ltr, spacing: 1fr, ..body.split("").filter(it => it != "")), tail)
  } else {
    stack(dir: ltr, spacing: 1fr, ..body.split("").filter(it => it != ""))
  }
}

#let heiti = "FZHei-B01S"
#let songti = "Source Han Serif SC"
#let kaiti = "FandolKai"

#let info-key-width = 72pt
#let column-gutter = -3pt
#let row-gutter = 11.5pt
#let info-inset = (x: 0pt, bottom: 2pt)
#let bold-info-keys = ("title",)

// 3.  内置辅助函数
#let info-key(body) = {
  rect(
    width: 100%,
    inset: info-inset,
    stroke: none,
    text(
      font: songti,
      size: 22pt,
			weight: "medium",
      body,
    ),
  )
}

#let info-value(body) = {
  set align(center)
  rect(
    width: 100%,
    inset: info-inset,
    stroke: (bottom: 1pt + black),
    text(
      font: songti,
      size: 22pt,
			weight: "medium",
      bottom-edge: "descender",
      body,
    ),
  )
}

#let info-long-value(body) = {
  grid.cell(
    colspan: 3,
    info-value(
      body,
    ),
  )
}

#let info-short-value(body) = {
  info-value(
    body,
  )
}


#align(center)[
  #box(
    width: 25%,
    image("assets/吉林大学校徽.svg"),
  )

  #set text(font: "FZHei-B01S")
  #set par(spacing: 1em)

  #text(size: 30pt)[
    *用原理看党的二十届三中全会*
  ]

  #set text(22pt)

  #block(
		width: 30%,
		// text(hyphenate: false, size: 26pt)[
		// 	读 书 报 告
		// ]
		justify-text(with-tail: false, "读书报告")
	)

  #text(size: 18pt)[
    （2024——2025学年第一学期）
  ]

	#v(1em)

  #block(
    width: 70%,
    grid(
      columns: (100pt, 1fr, 100pt, 1fr),
			row-gutter: 1em,
			info-key("学　　院"), info-long-value("商学与管理学院"),
			info-key("课程名称"), info-long-value("马克思主义基本原理"),
			info-key("学　　号"), info-long-value("35231321"),
			info-key("姓　　名"), info-long-value("刘兴龙"), 
			info-key("任课教师"), info-long-value("刘兴盛"), 
			info-key("撰写日期"), info-long-value("2024年10月28日"), 
    ),
  )
]

#align(center+bottom)[
	#text(size: 16pt, font: songti, weight: "medium")[马克思主义学院  编制]
]

#pagebreak()

#counter(page).update(1)

#set page(
	header: rect(stroke:(bottom: 1pt), width: 100%, height: 100%)[#text(font: kaiti)[用原理看党的二十届三中全会]],
	numbering: "1"
)

#v(14pt)

#align(center)[
	#text(size: 16pt, weight: "medium", font: heiti)[
		现代化航程：马克思主义与中国道路
	]
	
	#text(size: 15pt, weight: "medium", font: heiti)[
		——《用原理看二十届三中全会》读书报告
	]
]

#v(14pt)

// #set heading(numbering: (..nums) => {
// 	if nums.pos().len()==1 {
// 		numbering("一、", nums.pos().at(0))
// 	}
// })
// #set par(justify: true,first-line-indent: 2em)

// #show heading: it => {	
// 	let fs = if it.level == 1 { 14pt } else { 12pt }
// 	text(size: fs, weight: "semibold")[#it];text()[#v(0.2em, weak: true)];text()[#h(0em)]
// }

// #set text(font: songti, size: 12pt)

// = 前言

// 在全球化和信息化时代背景下，中国共产党第二十届中央委员会第三次全体会议的召开，标志着中国在全面深化改革和推进中国式现代化进程中迈出了坚实的步伐。本次会议由中央政治局主持，中央委员会总书记习近平作了重要讲话，并审议通过了《中共中央关于进一步全面深化改革、推进中国式现代化的决定》#cite(<cnt2>)。这份公报不仅是中国共产党在新时代背景下对马克思主义原理的创新性发展和应用的体现，也是对中国未来发展的深远影响的昭示。

// = 读书心得部分

// == （一）选题依据

// 马克思主义原理是中国共产党的指导思想，其核心在于通过不断的社会实践推动社会的发展和进步。三中全会的精神正是马克思主义原理在中国现代化进程中的具体体现，特别是在经济、政治、文化、社会和生态文明建设等方面。

// == （一）确立观点

// 二十届三中全会的精神体现了马克思主义原理在中国现代化建设中的实践应用，特别是在推动经济体制改革、实现高质量发展、促进社会公平正义等方面。这些举措不仅是对马克思主义原理的继承和发展，也是对中国国情的深刻把握和科学应对。

// == （三）阐述观点

// - *经济体制改革与马克思主义原理*
  
// 	三中全会提出构建高水平社会主义市场经济体制，这与马克思主义关于商品经济和市场经济的理论相契合。公报#cite(<cnt1>)中提到，“面对严峻复杂的国际环境和艰巨繁重的国内改革发展稳定任务”，必须“进一步推动和谋划全面深化改革”。这体现了马克思主义中关于社会发展是通过不断的社会革命和改革来实现的观点。
	
// 	在马克思主义看来，市场经济是生产力发展的必然结果，而社会主义市场经济则是在公有制基础上，通过市场机制实现资源优化配置的经济形式。三中全会强调要更好发挥市场机制作用，同时保证公有制经济和非公有制经济的平等发展，这正是马克思主义关于经济基础和上层建筑关系的具体体现。
	
//   在当前全球经济格局中，中国正面临着前所未有的挑战和机遇。三中全会提出的经济体制改革，旨在通过深化供给侧结构性改革，完善推动高质量发展的激励约束机制，塑造发展新动能新优势。这些措施将有助于提升中国经济的竞争力，促进经济结构的优化升级，实现从高速增长向高质量发展的转变。

// - *高质量发展与马克思主义原理*

//   高质量发展是全面建设社会主义现代化国家的首要任务，这与马克思主义关于生产力和生产关系的理论相一致。在全球化和信息化时代背景下，中国必须通过深化改革来适应和引领时代发展。公报提出，“更加注重系统集成，更加注重突出重点，更加注重改革实效”，这体现了马克思主义关于社会是一个有机整体的观点。改革不是孤立的，而是需要在经济、政治、文化、社会等各个方面协同推进。
	
// 	马克思主义认为，生产力的发展是推动社会进步的根本动力，而生产关系必须适应生产力的发展。三中全会提出的高质量发展激励约束机制，正是为了适应新时代生产力发展的要求，通过改革促进生产关系的优化，从而推动社会生产力的发展。

// - *社会公平正义与马克思主义原理*

//   三中全会强调以促进社会公平正义、增进人民福祉为出发点和落脚点。公报中多次提到“人民”，如“坚持以人民为中心”、“增进人民福祉”，这与马克思主义关于人的自由全面发展的理念相一致。改革的最终目的是提高人民的生活水平和幸福感，实现人的全面发展。
	
// 	从马克思主义的角度来说，社会主义社会的目标是实现人的全面发展和自由，而社会公平正义是实现这一目标的基础。三中全会提出的教育、科技、人才战略，以及社会保障体系的完善，都是为了实现这一目标而采取的具体措施。

// = 结语

// 本文通过对三中全会精神的解读，了解了中国共产党如何在马克思主义原理的指导下，推动中国社会主义现代化建设。三中全会的精神不仅是对马克思主义原理的继承和发展，也是对中国国情的深刻把握和科学应对。

// 在实现中国式现代化的过程中，如何更好地将马克思主义原理与中国实际相结合，以解决发展中的不平衡、不充分问题，是值得我们进一步思考和研究的问题。特别是在经济全球化的背景下，如何保持中国经济的稳定增长，如何处理好改革、发展与稳定的关系，都是需要深入探讨的问题。

// 期待在未来的学习和实践中，能够深入理解和运用二十届三中全会精神，为推动中国社会主义现代化建设贡献自己的力量。同时，也希望能够在专业领域内，通过战略与运营管理的专业知识，为实现高质量发展提供更多的思路和方案。通过我们的努力，相信中国能够在马克思主义原理的指导下，实现更加全面、协调、可持续的发展，为世界和平与发展作出更大的贡献。


#pagebreak()

#let refs = block(width: 100%)[
	#align(center)[
		#text(size: 14pt, weight: "medium", font: songti)[
			参考文献
		]
	]
]

// #bibliography(title: refs, "refs.bib")