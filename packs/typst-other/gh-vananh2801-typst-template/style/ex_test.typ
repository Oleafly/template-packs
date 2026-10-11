// MIT License
// Copyright (c) 2026 Anh

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#let ex_test_version = "1.0.0"
#let ex_test_author = "Phan Văn Anh"
#let ex_test_loicamon = "
Tôi chân thành cảm ơn thầy Trần Anh Tuấn và thầy Dương Phước Sang vì đã tạo ra gói ex_test rất tuyệt vời, giúp việc gõ LaTeX trở nên gần gủi hơn cho GV trong dạy học.
Dựa trên cơ sở ý tưởng của ex_test, tôi đã làm gói lệnh này, phục vụ cho việc gõ Typst trong dạy học.
"
#let ex_test_github = "https://github.com/vananh2801"

// state lưu lời giải đang chờ hiển thị
#let loigiai_state = state("loigiai_state", none)

// Tên đang được kích hoạt để lưu
#let current_saved_data_name = state("current_saved_data_name", "")

// Kiểm tra xem immini có ở đầu theorem không
#let immini_at_start_state = state("immini_at_start_state", false)

// Cờ kiểm tra xem có trong theorem không
#let in_theorem_state = state("in_theorem_state", false)
// Cờ kiểm tra xem có trong chc không
#let in_chc_state = state("in_chc_state", false)

// Lưu tên các thông tin theorem
#let current_theorem_name = state("current_theorem_name", none)
#let current_theorem_label = state("current_theorem_label", none)
#let current_theorem_full_label = state("current_theorem_full_label", none)
#let current_theorem_short_label = state("current_theorem_short_label", none)
#let current_theorem_title = state("current_theorem_title", none)
#let current_theorem_dapan = state("current_theorem_dapan", none)
#let current_theorem_sochc = counter("current_theorem_sochc")
#let current_theorem_boxF = state("current_theorem_boxF", (f: body => body))

#let defaultContentF(body, fulllabel: none, shortlabel: none, label: none, title: none, count: none) = [
  #strong[#fulllabel]
  #body
]
#let current_theorem_contentF = state("current_theorem_contentF", (f: defaultContentF))

#let defaultImminiF(fulllabel: none, shortlabel: none, label: none, title: none, count: none) = [
  #strong[#fulllabel]
]
#let current_theorem_imminiF = state("current_theorem_imminiF", (f: defaultImminiF))

// Câu hỏi con
#let current_chc_label = state("current_chc_label", none)
#let current_chc_full_label = state("current_chc_full_label", none)
#let current_chc_short_label = state("current_chc_short_label", none)
#let current_chc_title = state("current_chc_title", none)

// Tiêu đề lời giải
#let loigiaiEX = state("loigiaiEX", [*Lời giải.*])
// Dấu chấm cuối lựa chọn trắc nghiệm
#let dotEX = state("dotEX", [.])

// Bộ đếm dùng cho #choice tiếng Anh + underline
#let choiceUnNum = counter("choiceUnNum")

// Lệnh ẩn đáp số
#let dapso_show_state = state("dapso_show_state", false)
#let hidedapso = {
  state("dapso_show_state").update(false)
}
#let exitdapso = {
  state("dapso_show_state").update(false)
}
#let showdapso = {
  state("dapso_show_state").update(true)
}

// Lệnh để soạn chc cho đề Đánh giá năng lực
#let fromchc = state("fromchc", "Dựa vào thông tin dưới đây để trả lời các câu từ")
#let tochc = state("tochc", "đến")

// Khai báo các lệnh thay thế latex
#let chapter(title) = {
  heading(level: 1)[#title]
}
#let section(title) = {
  heading(level: 2)[#title]
}
#let subsection(title) = {
  heading(level: 3)[#title]
}
#let subsubsection(title) = {
  heading(level: 4)[#title]
}
#let paragraph(title) = {
  heading(level: 5)[#title]
}
#let subparagraph(title) = {
  heading(level: 6)[#title]
}

// Các lệnh dotline
#let dotlinefull(name, socot: 1) = {
  state(name + "_show_ans_dotline").update(true)
  state(name + "_show_ans_dotline_colnum").update(socot)
}

#let dotlineEX(
  sodong,
  socot: 1,
) = [
  #grid(
    columns: (1fr,) * socot,
    column-gutter: 0pt, // Để stroke tự quản lý khoảng cách
    // Logic stroke dựa trên ý tưởng hàm modau:
    // Kẻ một đường bên trái cho tất cả các cột trừ cột đầu tiên (x > 0)
    stroke: (x, y) => if x > 0 {
      (left: 0.5pt + black)
    },
    // Inset để nội dung không dính sát vào đường kẻ dọc
    inset: (x, y) => (
      top: par.leading * 8 / 10,
      bottom: par.leading * 2 / 10, // top + bottom = 1 par.leading
      left: if x == 0 { 0pt } else { 10pt },
      right: if x == socot - 1 { 0pt } else { 10pt },
    ),
    // Nội dung các dòng kẻ chấm
    ..for _ in range(sodong * socot) {
      (box(width: 100%, repeat([. #h(5pt)])),)
    }
  )
]

// choice
#let choice(socot: none, dapan: none, khoangcach: none, ..answers) = {
  let items = answers.pos()
  let labels = ("A", "B", "C", "D")
  // Lưu đáp án
  current_theorem_dapan.update(none)
  if dapan != none {
    context {
      let active = current_saved_data_name.get()
      if active != "" {
        let lb = if in_chc_state.get() {
          current_chc_short_label.get()
        } else if in_theorem_state.get() {
          current_theorem_short_label.get()
        } else {
          none
        }
        if lb != none {
          [#metadata((name: active, label: lb, ans: dapan)) <dapan-marker>]
        }
      }
    }
  }
  // Xuất nội dung
  if items.len() == 4 {
    parbreak()
    let contents = items.enumerate().map(((i, it)) => [*#labels.at(i).* #it #h(-1mm)#context { dotEX.get() }])
    layout(size => {
      let gutter = 1em.to-absolute()
      let widths = contents.map(c => measure(c).width)
      let maxw = calc.max(..widths)
      // Độ rộng mỗi cột nếu chia 4 / 2 cột
      let col4 = (size.width - 3 * gutter) / 4
      let col2 = (size.width - gutter) / 2
      let colnum = 1 // số cột
      if socot == 1 or socot == 2 or socot == 4 {
        colnum = socot
      } else if maxw <= col4 {
        colnum = 4
      } else if maxw <= col2 {
        colnum = 2
      } else {
        colnum = 1
      }
      grid(
        columns: (1fr,) * colnum,
        column-gutter: gutter,
        row-gutter: if khoangcach != none { khoangcach } else { par.leading + 0.6em },
        ..contents
      )
    })
    parbreak()
  } else if items.len() == 1 {
    context {
      let choiceNum = choiceUnNum.get().first()
      [$underbracket(#items.at(0), display(#strong(labels.at(choiceNum))))$]
      choiceUnNum.update(choiceNum + 1)
    }
  }
}

#let choiceN(socot: none, dapan: none, khoangcach: none, ..answers) = {
  let items = answers.pos()
  let labels = ("1", "2", "3", "4")
  // Lưu đáp án
  current_theorem_dapan.update(none)
  if dapan != none {
    context {
      let active = current_saved_data_name.get()
      if active != "" {
        let lb = if in_chc_state.get() {
          current_chc_short_label.get()
        } else if in_theorem_state.get() {
          current_theorem_short_label.get()
        } else {
          none
        }
        if lb != none {
          [#metadata((name: active, label: lb, ans: dapan)) <dapan-marker>]
        }
      }
    }
  }
  // Xuất nội dung
  if items.len() == 4 {
    parbreak()
    let contents = items.enumerate().map(((i, it)) => [*#labels.at(i))* #it #h(-1mm)#context { dotEX.get() }])
    layout(size => {
      let gutter = 1em.to-absolute()
      let widths = contents.map(c => measure(c).width)
      let maxw = calc.max(..widths)
      // Độ rộng mỗi cột nếu chia 4 / 2 cột
      let col4 = (size.width - 3 * gutter) / 4
      let col2 = (size.width - gutter) / 2
      let colnum = 1 // số cột
      if socot == 1 or socot == 2 or socot == 4 {
        colnum = socot
      } else if maxw <= col4 {
        colnum = 4
      } else if maxw <= col2 {
        colnum = 2
      } else {
        colnum = 1
      }
      grid(
        columns: (1fr,) * colnum,
        column-gutter: gutter,
        row-gutter: if khoangcach != none { khoangcach } else { par.leading + 0.6em },
        ..contents
      )
    })
    parbreak()
  } else if items.len() == 1 {
    context {
      let choiceNum = choiceUnNum.get().first()
      [$underbracket(#items.at(0), display(#strong(labels.at(choiceNum))))$]
      choiceUnNum.update(choiceNum + 1)
    }
  }
}

// choiceTF
#let choiceTF(socot: none, dapan: none, kieu: none, khoangcach: none, ..answers) = {
  let items = answers.pos()
  let labels = ("a)", "b)", "c)", "d)")
  // Lưu đáp án
  current_theorem_dapan.update(dapan)
  if dapan != none {
    context {
      let active = current_saved_data_name.get()
      if active != "" {
        let lb = if in_chc_state.get() {
          current_chc_short_label.get()
        } else if in_theorem_state.get() {
          current_theorem_short_label.get()
        } else {
          none
        }
        if lb != none {
          [#metadata((name: active, label: lb, ans: dapan)) <dapan-marker>]
        }
      }
    }
  }
  // Xuất nội dung
  parbreak()
  let contents = items.enumerate().map(((i, it)) => [*#labels.at(i)* #it #h(-1mm)#context { dotEX.get() }])
  if kieu == "t" {
    table(
      columns: (1fr, auto, auto),
      stroke: 0.5pt + black,
      align: (left + horizon, center + horizon, center + horizon),
      inset: 0.8em,
      table.header([#h(1fr)*Phát biểu*#h(1fr)], [*Đ*], [*S*]),
      ..items
        .enumerate()
        .map(((i, it)) => (
          [*#labels.at(i)* #it.],
          [],
          [],
        ))
        .flatten(),
    )
  } else {
    layout(size => {
      let gutter = 1em.to-absolute()
      let widths = contents.map(c => measure(c).width)
      let maxw = calc.max(..widths)
      // Độ rộng mỗi cột nếu chia 4 / 2 cột
      let col4 = (size.width - 3 * gutter) / 4
      let col2 = (size.width - gutter) / 2
      let colnum = 1 // số cột
      if socot == 1 or socot == 2 or socot == 4 {
        colnum = socot
      } else if maxw <= col4 {
        colnum = 4
      } else if maxw <= col2 {
        colnum = 2
      } else {
        colnum = 1
      }
      grid(
        columns: (1fr,) * colnum,
        column-gutter: gutter,
        row-gutter: if khoangcach != none { khoangcach } else { par.leading + 0.6em },
        ..contents
      )
    })
  }
  parbreak()
}

// shortans
#let shortans(dapan, kieu: "...") = {
  // Lưu đáp án
  current_theorem_dapan.update(none)
  if dapan != none {
    context {
      let active = current_saved_data_name.get()
      let active = current_saved_data_name.get()
      if active != "" {
        let lb = if in_chc_state.get() {
          current_chc_short_label.get()
        } else if in_theorem_state.get() {
          current_theorem_short_label.get()
        } else {
          none
        }
        if lb != none {
          [#metadata((name: active, label: lb, ans: dapan)) <dapan-marker>]
        }
      }
    }
  }
  // Xuất nội dung
  parbreak()
  if kieu == "..." {
    [#h(1fr)_Kết quả: ..........................._]
  } else if kieu == "oly" {
    let odapan = [#box[#rect(width: 0.6cm, height: 0.6cm)]]
    [#h(1fr)_Kết quả: _] + " " + odapan * 4
  } else if kieu == "3" {
    let odapan = [#box[#rect(width: 3cm, height: 0.6cm)]]
    [#h(1fr)_Kết quả: _] + " " + odapan
  }
  parbreak()
}

// dapso để hiện đáp số vắn tắt cho bài tự luận
#let dapso(dapan, hien: none) = {
  // Xuất nội dung
  parbreak()
  context {
    let flag = dapso_show_state.get()
    if hien == true or hien == false {
      flag = hien
    }
    if flag {
      [#h(1fr) _Đáp số:_ #dapan]
    }
  }
  parbreak()
}

// Lệnh lưu đáp án
#let BatDauLuuDapAn(name) = {
  current_saved_data_name.update(name)
}
#let KetThucLuuDapAn(name) = {
  current_saved_data_name.update("")
}

// Lệnh xuất đáp án
#let XuatDapAn(name, socot: 6, duongthang: 1pt + black, botron: 0.6em, khoangcach: 0.6em, maunen: white) = context {
  let raw = query(<dapan-marker>).map(m => m.value).filter(v => v.name == name)
  if raw.len() == 0 { return }
  let parsed = raw.map(item => (cau: item.label, dapan: item.ans))
  let inset = khoangcach
  set par(spacing: inset)
  layout(size => {
    let total-cols = socot
    let avail = size.width
    let col-w = avail / total-cols
    let usable-col-w = col-w - 2 * inset - 2pt // trừ 2 bên inset + stroke
    let spans = parsed.map(p => {
      let w = measure([*#p.cau* #p.dapan]).width
      calc.clamp(calc.ceil(w.to-absolute() / usable-col-w.to-absolute()), 1, total-cols)
    })
    let rows = ()
    let current-row = ()
    let current-cols = 0
    for (i, p) in parsed.enumerate() {
      let span = spans.at(i)
      let item = (p: p, span: span)
      if current-cols + span > total-cols {
        rows.push(current-row)
        current-row = (item,)
        current-cols = span
      } else {
        current-row.push(item)
        current-cols += span
      }
    }
    if current-row.len() > 0 { rows.push(current-row) }
    for row in rows {
      let col-sizes = row.map(item => (col-w * item.span,)).fold((), (acc, x) => acc + x)
      grid(
        columns: col-sizes,
        align: left + top,
        inset: (x: 0em, y: 0em),
        ..row.map(item => [
          #box(
            width: 100% - inset,
            fill: maunen,
            inset: 0.6em,
            stroke: duongthang,
            radius: botron,
          )[*#item.p.cau* #item.p.dapan]
        ])
      )
    }
  })
}

// Môi trường itemize
#let itemize(body) = {
  parbreak()
  set list(marker: ([--], [+]), indent: 1em)
  block(above: 1em, below: 1em)[
    #body
  ]
  parbreak()
}

// Môi trường enumerate
#let enumerate(body) = {
  parbreak()
  set enum(numbering: "a1.", indent: 1em)
  block(above: 1em, below: 1em)[
    #body
  ]
  parbreak()
}

// Lệnh bổ sung cho listEX, itemchoice
// Duyệt đệ quy để lấy nội dung từng mục "+ ..." trong body
#let extract-items(body) = {
  if body.func() == enum.item {
    (body.body,)
  } else if body.has("children") {
    body.children.map(extract-items).flatten()
  } else {
    ()
  }
}

// listEX
#let listEX(socot: none, body) = {
  parbreak()
  let contents_raw = extract-items(body)
  let n = contents_raw.len()
  let contents = contents_raw
    .enumerate()
    .map(((i, it)) => {
      let label = if n <= 26 {
        numbering("a)", i + 1)
      } else {
        numbering("1)", i + 1)
      }
      [#label #it]
    })
  // Xuất nội dung
  layout(size => {
    let gutter = 1em.to-absolute()
    let widths = contents.map(c => measure(c).width)
    let maxw = calc.max(..widths)
    let safety = 1.08
    let cols = calc.min(n, 4)
    while cols > 1 {
      let colw = (size.width - (cols - 1) * gutter) / cols
      if maxw * safety <= colw {
        break
      }
      cols -= 1
    }
    if socot == 1 or socot == 2 or socot == 3 or socot == 4 {
      cols = socot
    }
    grid(
      columns: (1fr,) * cols,
      column-gutter: gutter,
      row-gutter: par.leading + 0.6em,
      ..contents
    )
  })
}

// itemchoice
#let itemchoice(socot: none, body, max-cols: 4) = context {
  let trueEX = "Đúng"
  let falseEX = "Sai"
  parbreak()
  let contents_raw = extract-items(body)
  let n = contents_raw.len()
  let contents = contents_raw
    .enumerate()
    .map(((i, it)) => {
      let label = { numbering("a) ", i + 1) }
      [#label #it]
    })
  if current_theorem_dapan.get() != none {
    let dapans = current_theorem_dapan.get().trim().split(",")
    contents = contents_raw
      .enumerate()
      .map(((i, it)) => {
        let dapan_raw = dapans.at(i, default: "")
        let dapan_text = dapan_raw.replace("S", falseEX).replace("Đ", trueEX)
        let label = numbering("a)", i + 1) + " " + dapan_text
        [*#label* #parbreak() #it]
      })
  }
  // Xuất nội dung
  layout(size => {
    let gutter = 1em.to-absolute()
    let widths = contents_raw.map(it => (
      calc.max(measure(box(it)).width, measure([*#falseEX*]).width, measure([*#trueEX*]).width) + 0.5em.to-absolute()
    ))
    let maxw = calc.max(..widths)
    let safety = 1.08
    let cols = calc.min(n, max-cols)
    while cols > 1 {
      let colw = (size.width - (cols - 1) * gutter) / cols
      if maxw * safety <= colw {
        break
      }
      cols -= 1
    }
    if socot == 1 or socot == 2 or socot == 3 or socot == 4 {
      cols = socot
    }
    grid(
      columns: (1fr,) * cols,
      column-gutter: gutter,
      row-gutter: par.leading + 0.6em,
      ..contents
    )
  })
}

// Lệnh immini
// Gắn label <immini-marker> vào grid để nhận diện sau này
#let immini(text_content, image_content) = {
  let cell1 = context {
    let titleStyle = current_theorem_imminiF.get().f
    let label = if in_chc_state.get() {
      current_chc_label.get()
    } else {
      current_theorem_label.get()
    }
    let count = if in_chc_state.get() {
      counter("chc_count").get().first()
    } else {
      counter(current_theorem_name.get() + "_count").get().first()
    }
    let title = if in_chc_state.get() {
      current_chc_title.get()
    } else {
      current_theorem_title.get()
    }
    let fulllabel = label + " " + str(count) + if title != none { " (" + title + ")" } + "."
    let shortlabel = label + " " + str(count) + "."
    let prefix = if type(titleStyle) == function {
      titleStyle(
        fulllabel: fulllabel,
        shortlabel: shortlabel,
        label: label,
        count: count,
        title: title,
      )
    }
    if not immini_at_start_state.get() or (in_theorem_state.get() and current_theorem_sochc.get().first() > 0) {
      text_content
    } else {
      prefix
      text_content
    }
  }
  [#grid(
      columns: (1fr, auto),
      column-gutter: 1em,
      align: (left, top),
      cell1, image_content,
    ) #label("immini-marker")]
}

// Lệnh immini
// Gắn label <immini-marker> vào grid để nhận diện sau này
#let imminiL(text_content, image_content) = {
  let cell2 = context {
    let titleStyle = current_theorem_imminiF.get().f
    let label = if in_chc_state.get() {
      current_chc_label.get()
    } else {
      current_theorem_label.get()
    }
    let count = if in_chc_state.get() {
      counter("chc_count").get().first()
    } else {
      counter(current_theorem_name.get() + "_count").get().first()
    }
    let title = if in_chc_state.get() {
      current_chc_title.get()
    } else {
      current_theorem_title.get()
    }
    let fulllabel = label + " " + str(count) + if title != none { " (" + title + ")" } + "."
    let shortlabel = label + " " + str(count) + "."
    let prefix = if type(titleStyle) == function {
      titleStyle(
        fulllabel: fulllabel,
        shortlabel: shortlabel,
        label: label,
        count: count,
        title: title,
      )
    }
    if not immini_at_start_state.get() or (in_theorem_state.get() and current_theorem_sochc.get().first() > 0) {
      text_content
    } else {
      prefix
      text_content
    }
  }
  [#grid(
      columns: (auto, 1fr),
      column-gutter: 1em,
      align: (left, top),
      image_content, cell2,
    ) #label("immini-marker")]
}

// Kiểm tra đệ quy: content có chứa label <immini-marker> ở đầu không
#let starts-with-immini(body) = {
  if type(body) != content {
    false
  } else if body.has("label") and body.label == <immini-marker> {
    true
  } else if body.has("children") {
    let real-children = body.children.filter(c => {
      (
        type(c) == content
          and not (
            repr(c.func()) == "space" or c.func() == parbreak or (c.func() == text and c.text.trim() == "")
          )
      )
    })
    if real-children.len() == 0 { false } else { starts-with-immini(real-children.first()) }
  } else if body.has("body") {
    starts-with-immini(body.body)
  } else if body.has("child") {
    starts-with-immini(body.child)
  } else {
    false
  }
}

// loigiai: tự quyết định hiển thị ngay hay "gửi ra ngoài"
#let loigiai(body) = context {
  parbreak()
  let name = current_theorem_name.get()
  let show_ans = state(name + "_show_ans").get()
  let show_ans_dotline = state(name + "_show_ans_dotline").get()
  let colnum = state(name + "_show_ans_dotline_colnum").get()
  if in_theorem_state.get() or in_chc_state.get() {
    if show_ans != none and show_ans {
      loigiai_state.update(body)
    }
  } else {
    align(center)[#loigiaiEX.get()]
    if show_ans_dotline != none and show_ans_dotline {
      layout(size => {
        let body_size = measure(body, width: size.width)
        let socot_final = if colnum != none { colnum } else { 1 }
        let n = calc.max(calc.ceil(body_size.height / par.leading.to-absolute() / 2), 1)
        dotlineEX(n, socot: socot_final)
      })
    } else {
      body
    }
  }
  parbreak()
}

// Câu hỏi con
#let chc = (
  body,
  tieude: none,
) => {
  // Reset counter cho #choice khi dùng cho đề tiếng Anh
  choiceUnNum.update(0)
  // Cập nhật nhãn
  current_theorem_dapan.update(none)
  // Tự xuống dòng ở đầu theorem
  parbreak()
  // Tăng bộ đếm (mặc định có counter)
  counter("chc_count").step()
  // Xoá nội dung lời giải ở lần dùng trước (nếu có)
  loigiai_state.update(none)
  // Gán cờ đang trong theorem thành true
  in_chc_state.update(true)
  // Tạo count
  let count = context {
    let result = []
    if current_theorem_sochc.get().first() != 0 {
      let theorem_cout = counter(current_theorem_name.get() + "_count").get().first()
      let chc_count = counter("chc_count").get().first()
      let sochc_count = current_theorem_sochc.get().first()
      let result_count = theorem_cout + chc_count - sochc_count
      result = [#result_count]
    } else {
      let theorem_cout = counter(current_theorem_name.get() + "_count").get().first()
      let chc_count = counter("chc_count").get().first()
      if theorem_cout != 0 {
        result = [#numbering("1.a", theorem_cout, chc_count)]
      } else {
        result = [#numbering("a", chc_count)]
      }
    }
    [#result]
    current_chc_short_label.update([#current_chc_label.get() #result.])
  }
  // tạo nguồn
  let src = if tieude != none { [ (#tieude)] }
  // Tạo label + Lưu label để có thể xử lý cho tiêu đề và ô đáp án
  let full_label = context { [#current_chc_label.get() #count#src.] }
  let short_label = context { [#current_chc_label.get() #count.] }
  current_chc_full_label.update(full_label)
  current_chc_title.update(tieude)
  // Cập nhật cờ immini
  immini_at_start_state.update(starts-with-immini(body))
  // Xuất nội dung
  context {
    let boxF = current_theorem_boxF.get().f
    let contentF = current_theorem_contentF.get().f
    if type(boxF) == function and type(contentF) != none {
      boxF()[
        #contentF(
          body,
          fulllabel: if not starts-with-immini(body) { full_label },
          shortlabel: if not starts-with-immini(body) { short_label },
          label: current_chc_label.get(),
          count: count,
          title: tieude,
        )
      ]
    }
  }
  immini_at_start_state.update(false)
  in_chc_state.update(false)
  context {
    if loigiai_state.get() != none {
      loigiai[#loigiai_state.get()]
    }
  }
  parbreak()
}

// Lệnh để tạo theorem mới có đánh số
#let createTheoremEx(
  theoremName,
  theoremLabel,
  boxF: body => body,
  contentF: defaultContentF,
  imminiF: defaultImminiF,
  numbered: true,
) = {
  // Khai báo theorem
  let theorem = (body, tieude: none, sochc: 0) => {
    // Gán số chc
    current_theorem_sochc.update(sochc)
    // Reset counter cho #choice khi dùng cho đề tiếng Anh
    choiceUnNum.update(0)
    // Tự xuống dòng ở đầu theorem
    parbreak()
    // Tăng bộ đếm
    if numbered {
      counter(theoremName + "_count").step()
    }
    // Trả bộ đếm chc về như cũ
    counter("chc_count").update(0)
    // Xoá nội dung lời giải ở lần dùng trước (nếu có)
    loigiai_state.update(none)
    // Gán cờ đang trong theorem thành true
    in_theorem_state.update(true)
    // Lưu cáu hình hiện tại để các #chc bên trong tự động kế thừa (đồng bộ font)
    current_theorem_boxF.update((f: boxF))
    current_theorem_contentF.update((f: contentF))
    current_theorem_imminiF.update((f: imminiF))
    // Tạo count
    let count = context {
      let result = [#counter(theoremName + "_count").get().first()]
      result
      current_theorem_short_label.update([#theoremLabel #if numbered { result }.])
    }
    // Tạo label + Lưu label để có thể xử lý
    let full_label = context {
      if sochc > 0 {
        parbreak()
        let start_counter = counter(theoremName + "_count").get().first()
        let end_counter = start_counter + sochc - 1
        [#fromchc.get() #str(start_counter) #tochc.get() #str(end_counter).]
        parbreak()
      } else {
        let src = if tieude != none { [ (#tieude)] }
        [#theoremLabel#if numbered { [ #count] }#src.]
      }
    }
    let short_label = context {
      if sochc > 0 {
        parbreak()
        let start_counter = counter(theoremName + "_count").get().first()
        let end_counter = start_counter + sochc - 1
        [#fromchc.get() #str(start_counter) #tochc.get() #str(end_counter).]
        parbreak()
      } else {
        [#theoremLabel #if numbered { [#count] }.]
      }
    }
    current_theorem_label.update(theoremLabel)
    current_theorem_full_label.update(full_label)
    current_theorem_title.update(tieude)
    current_chc_label.update(theoremLabel)
    current_theorem_name.update(theoremName)
    immini_at_start_state.update(starts-with-immini(body))
    // Xuất nội dung
    if type(boxF) == function and type(contentF) == function {
      boxF()[
        #contentF(
          body,
          fulllabel: if not starts-with-immini(body) { full_label },
          shortlabel: if not starts-with-immini(body) { short_label },
          label: theoremLabel,
          count: count,
          title: tieude,
        )
      ]
    }
    in_theorem_state.update(false)
    immini_at_start_state.update(false)
    context {
      if loigiai_state.get() != none {
        loigiai[#loigiai_state.get()]
      }
    }
    if sochc != 0 {
      for i in range(1, sochc) [
        #counter(theoremName + "_count").step()
      ]
    }
    parbreak()
  }
  // Trả về theorem
  theorem
}
