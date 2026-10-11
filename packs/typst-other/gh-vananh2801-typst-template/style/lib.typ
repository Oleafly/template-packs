#import "../style/ex_test.typ": *

#let current_chapter_title = state("current_chapter_title", none)
#let current_section_title = state("current_section_title", none)

#let appearance(body) = {
  // Cấu hình trang in
  set page(
    paper: "a4",
    margin: (top: 1.5cm, left: 2cm, right: 1.5cm, bottom: 1.5cm),
    numbering: "1",
    footer: context {
      let page_num = counter(page).get().first()
      let section = current_section_title.get()
      let chapter = current_chapter_title.get()
      let current = if section == none or calc.odd(page_num) { chapter } else { section }
      [
        #show linebreak: [ ]
        #line(stroke: 1pt + red.darken(30%), length: 100%)
        #v(-8pt)
        _#current #h(1fr) Trang #(page_num)_
      ]
    },
    header-ascent: 20%,
    footer-descent: 20%,
  )

  // Cấu hình font chữ
  set text(
    font: "Times New Roman",
    size: 12pt,
    lang: "vi",
    region: "vn",
  )

  // Cấu hình đoạn và căn lề
  set par(
    first-line-indent: 0cm,
    leading: 0.85em,
    spacing: 1.5em,
    justify: true,
    linebreaks: auto,
  )

  // Câu hình bảng
  set table(inset: (x: 0.6em, y: 0.7em))

  // Cấu hình danh sách
  set list(
    marker: ([--], [+]),
    indent: 1em,
  )

  set enum(
    numbering: "a.1)",
    indent: 1em,
  )

  // Cấu hình để math mode luôn hiện ở display style giốn \displaystyle trên latex
  show math.equation: it => {
    math.display(it)
  }

  show math.frac: it => {
    math.display(it)
  }

  show math.sum: it => {
    math.display(it)
  }

  // Cấu hình bộ đếm của tiêu đề
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 {
      return numbering("I", n.last()) // Chương \chapter
    } else if n.len() == 2 {
      return numbering("1.", n.last()) // Bài \section
    } else if n.len() == 3 {
      return numbering("A.", n.last()) // Mục lớn \subsection
    } else if n.len() == 4 {
      return numbering("1.", n.last()) // Tiết \subsubsection
    } else if n.len() == 5 {
      return numbering("a).", n.last()) // Mục vừa \paragraph
    }
  })

  // chapter - Chương
  show heading.where(level: 1): it => context {
    pagebreak(weak: true, to: "odd")
    set text(size: 24pt, weight: "bold")
    // Kiểm tra nếu tiêu đề KHÔNG có đánh số (ví dụ: Mục lục, Lời nói đầu)
    if it.numbering == none {
      block(width: auto, above: 1.5em, below: 2em, fill: red.lighten(80%), inset: 10pt, radius: 5pt)[
        #upper(it.body)
      ]
    } else {
      // Nếu tiêu đề CÓ đánh số (Chương 1, 2...)
      block(width: auto, above: 1.5em, below: 1em, fill: red.lighten(80%), inset: 10pt, radius: 5pt)[
        Chương #counter(heading).display()

      ]
      upper(it.body)
    }
    counter("dn_count").update(0)
    counter("dl_count").update(0)
    counter("tc_count").update(0)
    counter("vd_count").update(0)
    counter("bt_count").update(0)
    counter("btrl_count").update(0)
    counter("ex_count").update(0)
    current_chapter_title.update(it.body)
    current_section_title.update(none)
  }

  // section - Bài dạy
  show heading.where(level: 2): it => context {
    pagebreak(weak: true)
    block(above: 1.5em, below: 1em, width: 100%, radius: 8pt, inset: 12pt, stroke: 1pt + red)[
      #set text(size: 12pt, weight: "bold")
      #grid(
        columns: (auto, auto),
        gutter: 5pt,
        rect(
          fill: red.lighten(80%),
          inset: 5pt,
          radius: 5pt,
        )[ Chương #numbering("I", counter(heading).get().first()) ],
        rect(
          fill: blue.lighten(90%),
          inset: 5pt,
          radius: 5pt,
        )[ Bài #counter(heading).get().last() ],
      )
      #v(1em)
      #align(center)[
        #set text(size: 14pt, weight: "bold")
        #upper(it.body)
      ]
      #v(1em)
    ]
    counter("dn_count").update(0)
    counter("dl_count").update(0)
    counter("tc_count").update(0)
    counter("vd_count").update(0)
    counter("bt_count").update(0)
    counter("btrl_count").update(0)
    counter("ex_count").update(0)
    current_section_title.update(it.body)
  }

  // subsection - Mục đánh chữ cái in hoa
  show heading.where(level: 3): it => context {
    block(
      above: 1.5em,
      below: 1em,
    )[
      #let count = numbering("A", counter(heading).get().last())
      #let dynamic_width = calc.max(20pt, measure(count).width + 10pt)
      #set text(size: 14pt, weight: "bold")
      #set par(justify: true)
      #box(fill: green.lighten(70%), inset: 5pt, radius: 5pt, height: 20pt, width: dynamic_width)[#h(1fr)#count#h(1fr)]
      #h(0.4em)
      #it.body
    ]
  }

  // subsubsection - Mục nhỏ đánh số Ả Rập
  show heading.where(level: 4): it => context {
    block(
      above: 1.5em,
      below: 1em,
    )[
      #set text(size: 13pt, weight: "bold")
      #let count = numbering("1", counter(heading).get().last())
      #let dynamic_width = calc.max(20pt, measure(count).width + 10pt)
      #set par(justify: true)
      #box(fill: green.lighten(70%), inset: 5pt, radius: 5pt, height: 20pt, width: dynamic_width)[#h(1fr)#count#h(1fr)]
      #h(0.4em)
      #it.body
    ]
  }

  // paragraph - Mục đánh số bằng chữ cái
  show heading.where(level: 5): it => context {
    block(
      text(size: 12pt, weight: "bold", it),
      above: 1.5em,
      below: 1em,
    )
  }

  // Trả về body
  body
}

// Mục lục
#let tableofcontens(body) = {
  show outline.entry: it => {
    show linebreak: [ ]
    // Ép chữ số (kể cả số trang trong it.inner()) dùng "tabular figures"
    // — mọi chữ số có cùng bề rộng — để việc số trang tăng từ 1 chữ số
    // lên 2 chữ số (vd 9 -> 20) không làm co giãn dòng, tránh vòng lặp
    // mục lục <-> số trang không hội tụ.
    set text(features: ("tnum",))
    if it.level == 1 {
      link(it.element.location(), [
        #if it.prefix() != none and it.prefix() != "" {
          // Trường hợp có số chương (VD: I, II, 1, 2)
          block(width: 100%, above: 1.5em, below: 1em)[
            *Chương* #strong(it.prefix())*.* #h(0.4em) #upper(strong(it.inner()))
          ]
        } else {
          // Trường hợp không có số chương (VD: LỜI CẢM ƠN)
          block(width: 100%, above: 1.5em, below: 1em)[
            #upper(strong(it.inner()))
          ]
        }
      ])
    } else if it.level == 2 {
      link(it.element.location(), [
        #block(width: 100%, above: 1.5em, below: 1em)[
          #h(1.3em) #it.prefix() #h(0.4em) #it.inner()
        ]
      ])
    } else if it.level == 3 {
      link(it.element.location(), [
        #block(width: 100%, above: 1em, below: 1em)[
          #h(2.6em) #it.prefix() #h(0.4em) #it.inner()
        ]
      ])
    } else if it.level == 4 {
      link(it.element.location(), [
        #block(width: 100%, above: 1em, below: 1em)[
          #h(3.9em) #it.prefix() #h(0.4em) #it.inner()
        ]
      ])
    }
  }

  // Trả về body
  body
}

// Môi trường các bước
#let cacbuoc(content) = {
  parbreak()
  set enum(
    numbering: (..n) => {
      [#emph[Bước] #numbering("1.", n.pos().at(0))]
    },
    indent: 1em,
  )
  block(above: 1em, below: 1em)[
    #content
  ]
  parbreak()
}

// Khai báo hàm tạo hệ phương trình / tuyển phương trình
// Dấu , và ; phải đặt trong ""
#let heva(..parts) = {
  math.cases(..parts.pos(), delim: "{")
}
#let hoac(..parts) = {
  math.cases(..parts.pos(), delim: "[")
}

#let dnBox(body) = {
  block(
    stroke: (left: 3pt + red.darken(30%)),
    width: 100%,
    radius: 0pt,
    inset: (left: 1em, right: 1em, top: 0.5em, bottom: 0.5em),
    outset: (left: -3pt),
    breakable: true,
  )[#body]
}

#let dlBox(body) = {
  block(
    width: 100%,
    radius: 6pt,
    inset: 1em,
    stroke: 1pt + red.darken(30%),
    breakable: true,
  )[#body]
}

#let tcBox(body) = {
  block(
    width: 100%,
    radius: 6pt,
    inset: 1em,
    stroke: 1pt + red.darken(30%),
    breakable: true,
  )[#body]
}

#let vdBox(body) = {
  block(
    width: 100%,
    radius: 6pt,
    inset: 1em,
    fill: blue.lighten(90%),
    stroke: 0pt + black,
    breakable: true,
  )[#body]
}

#let btBox(body) = {
  block(
    width: 100%,
    radius: 6pt,
    inset: 1em,
    fill: blue.lighten(90%),
    stroke: 0pt + black,
    breakable: true,
  )[#body]
}

#let exBox(body) = {
  block(
    width: 100%,
    radius: 6pt,
    inset: 1em,
    fill: blue.lighten(90%),
    stroke: 0pt + black,
    breakable: true,
  )[#body]
}

#let btrlBox(body) = {
  block(
    width: 100%,
    radius: 6pt,
    inset: 1em,
    fill: blue.lighten(90%),
    stroke: 0pt + black,
    breakable: true,
  )[#body]
}

#let questionImminiF(fulllabel: none, shortlabel: none, label: none, title: none, count: none) = [
  #strong[#shortlabel]
]

#let questionContentF(body, fulllabel: none, shortlabel: none, label: none, title: none, count: none) = [
  // In đậm Tiêu đề
  #strong[#shortlabel]
  // Xuất nội dung
  #body
  // Xuất nguồn đề bài in nghiêng
  #if title != none {
    [#parbreak()#h(1fr)#emph[Nguồn: #title]]
  }
]

#let dlcontentF(body, fulllabel: none, shortlabel: none, label: none, title: none, count: none) = [
  // In đậm Tiêu đề
  #strong[#fulllabel]
  // In nghiêng nội dung
  #set text(style: "italic")
  #show emph: it => it.body
  #body
]

#let dn = createTheoremEx(
  "dn",
  "Định nghĩa",
  boxF: dnBox,
)
#let dl = createTheoremEx(
  "dl",
  "Định lý",
  boxF: dlBox,
  contentF: dlcontentF,
)
#let tc = createTheoremEx(
  "tc",
  "Tính chất",
  boxF: tcBox,
)
#let luuy = createTheoremEx(
  "luuy",
  "Lưu ý",
  numbered: false,
)
#let nhanxet = createTheoremEx(
  "nhanxet",
  "Nhận xét",
  numbered: false,
)
#let vd = createTheoremEx(
  "vd",
  "Ví dụ",
  boxF: vdBox,
  contentF: questionContentF,
  imminiF: questionImminiF,
)
#let btrl = createTheoremEx(
  "btrl",
  "Bài",
  contentF: questionContentF,
  imminiF: questionImminiF,
)
#let ex = createTheoremEx(
  "ex",
  "Câu",
  contentF: questionContentF,
  imminiF: questionImminiF,
)
#let bt = createTheoremEx(
  "bt",
  "Bài",
  boxF: btBox,
  contentF: questionContentF,
  imminiF: questionImminiF,
)
