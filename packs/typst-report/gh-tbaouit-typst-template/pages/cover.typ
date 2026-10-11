#let report-cover(
	course-name: "",
	course-id: "",
	title: "",
	instructor: "",
	group-name: "Nhóm ",
	members: (), // Nhận vào một mảng chứa các mảng con: (("Tên", "MSSV"), ...)
	date: "",
	logo: "../assets/LOGO_UIT.PNG" // Đã chỉnh lại theo đường dẫn thư mục assets của bạn
) = {
	block(width: 100%, height: 100%)[
	#set table(stroke: none)

	#set text(font: "New Computer Modern")
		
	// Khung viền ngoài
	#box(
		inset: 3.5pt,
		stroke: 2.5pt + black,
		)[
		// Khung viền trong
			#box(
				width: 100%,
				height: 100%, 
				stroke: 1pt + black,
			)[
				#align(center)[
				#v(2cm)
				#set text(size:14pt)
				*TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN* 
				#v(0.25cm)
				*ĐẠI HỌC QUỐC GIA TP. HCM*
				#v(0.25cm)
				*KHOA KHOA HỌC MÁY TÍNH*
				#v(0.5cm)
				#line(length: 30%, stroke: 1.5pt)
				#v(0.25cm)
				
				#figure(
					image(logo, width: 20%), numbering: none,
				)

				#v(0.5cm)
				#set text(size:15pt)
				*BÁO CÁO ĐỒ ÁN MÔN HỌC\ #upper(course-name)*
				#line(length: 70%, stroke: 2pt)
				#v(0.5cm)
				
				#set text(size:16pt)
				*#upper(title)*
				#v(0.5cm)
				
				#set text(size:14pt)
				#line(length: 70%, stroke: 2pt)
				#v(0.25cm)
				
				*Lớp học phần*: #course-id
				#v(0.25cm)
				*GVGD:* #instructor
				#v(0.1cm)
				*#group-name:*
				#v(0.1cm)
				]

				// Bảng danh sách thành viên
				#block(inset: (left: 4cm))[
				#set table(
					columns: (0.6fr, 0.7fr),
					column-gutter: 1.5cm,
				)
				
				// Trải phẳng mảng 2 chiều thành 1 chiều để nạp vào table
				#table(
					..members.flatten()
				)
				]
				
				// Đẩy ngày tháng xuống sát đáy trang cho cân đối
				#align(center + bottom)[
					#pad(bottom: 0.75cm)[
						#date
					]
				]
			]
		]
	]
}

#let slide-cover-info = state("slide-cover-info", (
	author: "",
	course-name: "",
	term: "",
	total-page: 1,
))

#let slide-cover(
	course-id,
	course-name,
	title,
	author,
	affiliations,
	department,
	term,
	current-page,
	total-page,
	paper: "presentation-16-9",
) = {
	let dark-red = rgb("#a00000")
	let light-gray = rgb("#f1f3f5")
	let near-white = rgb("#745959")
	slide-cover-info.update((
		author: author,
		course-name: course-name,
		term: term,
		total-page: total-page,
	))

	set page(
		paper: paper,
		margin: 0pt,
		header: none,
		footer: none,
	)

	grid(
		rows: (1fr, auto),
		columns: 1fr,
		[
			#v(2.25cm)
			#align(center + horizon)[
				#block(width: 83%)[
					#rect(
						width: 100%,
						inset: (x: 18pt, y: 16pt),
						radius: 8pt,
						fill: light-gray,
						stroke: 0.6pt + rgb("#d3d7dc"),
					)[
						#text(fill: dark-red, size: 24pt, weight: "bold")[#course-id: #course-name]
						#v(0.25cm)
						#text(fill: dark-red, size: 24pt, weight: "bold")[#title]
					]
				]
				#v(0.25cm)
				#text(size: 22pt, weight: "bold")[#author]
				#v(0.25cm)

				#text(size: 15pt)[
					Nguyễn Thái Bảo#super[1],
					Bùi Huy Chương#super[2],\
					Nguyễn Hoàng Xuân Bách#super[3],
					Bùi Diên Gia Bảo#super[4],
					Lê Gia Bảo#super[5]\
					Trần Ánh Dương#super[6], Đỗ Quang Duy#super[7]
				]

				#v(0.25cm)

				#text(size: 15pt)[
				
					#text(weight: "thin")[
					{24520173, 24520230, 24520141, 24520143, 24520158, 24520362, 24520367}\@gm.uit.edu.vn
					]
  				]
				#v(0.3em)

				
				

				#align(center + bottom)[
					#pad(bottom: 0.75cm)[
						#text(size: 15pt)[
					Department of Computer Science, University of Information Technology \
					Viet Nam National University Ho Chi Minh City\ Fall 2026
  				]
					]
				]
			]
			
		],
		[
			#grid(
				columns: (1.12fr, 1fr, 1fr),
				inset: 0pt,
				align: (left, center, right),
				block(width: 100%, fill: dark-red, inset: (x: 12pt, y: 8pt))[#text(fill: white, size: 13pt)[Lecturer: Vo Nguyen Le Duy (UIT - VNUHCM)]],
				block(width: 100%, fill: light-gray, inset: (x: 12pt, y: 8pt))[#text(fill: dark-red, size: 13pt)[#course-name]],
				block(width: 100%, fill: rgb("#E1E1E1"), inset: (x: 12pt, y: 8pt))[#text(fill: dark-red, size: 13pt)[#term #h(6em) #current-page / #total-page]],
			)
		]
	)
}

#let slide-outline(
	title: "Nội dung",
	sections: (),
	current-section: 1,
) = {
	let dark-red = rgb("#a00000")
	let light-gray = rgb("#f5f5f5")
	let muted-gray = luma(220)
	let near-white = rgb("#fafafa")
	let section-list = if type(sections) == str { (sections,) } else { sections }
	let footer = context {
		let cover = slide-cover-info.get()
		let current = counter(page).at(here()).first()
		grid(
			columns: (1fr, 1fr, 1fr),
			inset: 0pt,
			align: (left, center, right),
			block(width: 100%, fill: dark-red, inset: (x: 12pt, y: 8pt))[
				#text(fill: white, size: 13pt)[University of Information Technology (UIT)]
			],
			block(width: 100%, fill: light-gray, inset: (x: 12pt, y: 8pt))[
				#text(fill: dark-red, size: 13pt)[#cover.course-name]
			],

			block(width: 100%, fill: rgb("#E1E1E1"), inset: (x: 12pt, y: 8pt))[
				#text(fill: rgb("#a00000"), size: 13pt)[#cover.term #h(6em) #current / #cover.total-page]
			],
		)
	}

	set page(
		paper: "presentation-16-9",
		margin: 0pt,
		header: none,
		footer: none,
	)
	pagebreak()

	grid(
		rows: (auto, 1fr, auto),
		columns: 1fr,
		[
			#rect(
				width: 100%,
				fill: light-gray,
				inset: (x: 24pt, y: 12pt),
			)[
				#text(size: 24pt, weight: "bold", fill: dark-red)[#title]
			]
		],
		[
			#let items = section-list.enumerate().map(((i, sec)) => {
					let active = i + 1 == current-section
					let circle-fill = if active { dark-red } else { muted-gray }
					let text-fill = if active { dark-red } else { muted-gray }
					align(center + horizon)[
						#pad(left: 1.25cm)[
							#grid(
								columns: (70pt, 1fr),
								column-gutter: 14pt,
								align: (center, left),
								box(
									width: 28pt,
									height: 28pt,
									radius: 14pt,
									fill: circle-fill,
								)[
									#align(center + horizon)[
										#text(fill: if active { white } else { rgb("#666666") }, weight: "bold")[#(i + 1)]
									]
								],
								text(size: 21pt, weight: if active { "bold" } else { "regular" }, fill: text-fill)[#sec],
							)
						]	
					]
				}
				)
			#align(center + horizon)[
				#stack(dir: ttb, spacing: 1.75em, ..items)
			]
		],
		[
			#footer
		]
	)
}

/*
				#text(size: 14pt)[
					#super[1]Department of Computer Science, University of Information Technology \
					#super[2]Viet Nam National University Ho Chi Minh City\
					#text(weight: "thin")[
					{24520173, 24520230, 24520141, 24520143, 24520158, 24520362, 24520367}\@gm.uit.edu.vn
					]
  				]
*/


