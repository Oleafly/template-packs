// ─────────────────────────────────────────────────────────────
// 양식 초기 설정
// ─────────────────────────────────────────────────────────────

#let g-is-debug = state("g-is-debug", false)
#let g-serif-font = state("serif-font", "Noto Serif CJK KR")
#let g-san-serif-font = state("san-serif-font", "Noto Sans CJK KR")
#let g-cover-margin = state("cover-margin", (top: 30mm, bottom: 30mm, left: 30mm, right: 30mm, footer: 15mm))
#let g-margin = state("margin", (top: 30mm, bottom: 30mm, left: 30mm, right: 30mm, footer: 15mm))
#let g-compact-margin = state("compact-margin", (top: 15mm, bottom: 15mm, left: 20mm, right: 20mm, footer: 3mm))
#let g-page-numbering = state("page-numbering", (content: [-- 1 --], alignment: center))

// 제목 및 조항 넘버링 관련 카운터 및 상태
#let chapter-counter = counter("constitution-chapter")
#let section-counter = counter("constitution-section")
#let article-counter = counter("constitution-article")
#let branch-article-counter = counter("constitution-branch-article")
#let clause-counter = counter("constitution-clause")
#let numitem-counter = counter("constitution-numitem")
#let subitem-counter = counter("constitution-subitem")
#let is-addendum = state("is-addendum", false)
#let current-zone = state("current-zone", "article")
#let in-table = state("in-table", false)
#let current-article-label-part = state("current-article-label-part", "1")
#let rule-marker-registry = state("rule-marker-registry", (:))

// 규정 문서 양식을 사용하도록 설정합니다.
#let rule-document(
  document-title: none,
  serif: "Noto Serif CJK KR",
  san-serif: "Noto Sans CJK KR",
  default-font-type: "serif",
  margin: (top: 30mm, bottom: 30mm, left: 30mm, right: 30mm, footer: 15mm),
  compact-margin: (top: 15mm, bottom: 15mm, left: 20mm, right: 20mm, footer: 3mm),
  cover-margin: (top: 30mm, bottom: 30mm, left: 30mm, right: 30mm, footer: 15mm),
  page-numbering: (content: [-- 1 --], alignment: center),
  link-color: none,
  debug: false,
  body,
) = {
  if document-title != none { set document(title: document-title) }

  assert(type(debug) == bool, message: "debug는 true 혹은 false여야 합니다.")
  assert(margin.keys() == ("top", "bottom", "left", "right", "footer") or margin.keys() == ("top", "bottom", "left", "right"), message: "margin의 형식이 잘못되었습니다.")
  assert(compact-margin.keys() == ("top", "bottom", "left", "right", "footer") or compact-margin.keys() == ("top", "bottom", "left", "right"), message: "compact-margin의 형식이 잘못되었습니다.")
  assert(compact-margin.keys() == ("top", "bottom", "left", "right", "footer") or compact-margin.keys() == ("top", "bottom", "left", "right"), message: "compact-margin의 형식이 잘못되었습니다.")
  assert(type(page-numbering) == str or type(page-numbering) == content or type(page-numbering) == dictionary, message: "page-numbering은 큰 따옴표로 감싼 문자열이거나 대괄호로 감싼 내용이거나 딕셔너리여야 합니다.")

  margin.insert("footer", margin.at("footer", default: margin.top / 2))
  compact-margin.insert("footer", compact-margin.at("footer", default: margin.top / 2))
  
  g-is-debug.update(debug)
  g-serif-font.update(serif)
  g-san-serif-font.update(san-serif)
  g-margin.update(margin)
  g-compact-margin.update(compact-margin)

  let numbering-content = page-numbering
  let numbering-align = center
  if type(page-numbering) == dictionary {
    numbering-content = page-numbering.at("content", default: [-- 1 --])
    numbering-align = page-numbering.at("alignment", default: center)
  }
  if type(numbering-content) == str {
    final-content = [#final-content]
  }
  g-page-numbering.update((content: numbering-content, alignment: numbering-align))

  // 페이지 기본 설정

  let font = (serif, san-serif)
  if default-font-type == "san-serif" or default-font-type == "고딕" {
    font = (san-serif, serif)
  }
  set text(
    font: font,
    lang: "ko",
  )
  set par(
    justify: true,
    leading: 0.86em,
    spacing: 0.86em,
    first-line-indent: 0pt,
    linebreaks: "optimized",
  )
  show link: set text(fill: link-color) if link-color != none

  // 제목 스타일링

  set heading(numbering: (..levels) => {
    let pos = levels.pos()
    let lvl = pos.len()
    if lvl == 1 {
      none
    } else if lvl == 2 {
      str(pos.at(1)) + "."
    } else if lvl == 3 {
      numbering("가.", pos.at(2))
    } else if lvl == 4 {
      str(pos.at(3)) + ")"
    } else if lvl == 5 {
      numbering("가", pos.at(4)) + ")"
    } else if lvl == 6 {
      "(" + str(pos.at(5)) + ")"
    }
  })

  // 1단계 제목: '목차', '정관'과 같이 페이지의 큰 구성을 나눌 때 사용합니다.
  show heading.where(level: 1): it => {
    if document-title == none {
      set document(title: it.body)
    }
    block(above: 15mm, below: 8mm)[
      #align(left)[#text(size: 20pt, weight: "bold", fill: black)[#it.body]]
    ]
  }

  // 2단계 제목: 장
  show heading.where(level: 2): it => {
    if it.has("label") and it.label == <rule-chapter> {
      block(above: 5mm, below: 10mm, width: 100%)[
        #align(center)[#text(size: 16pt, weight: "bold", fill: black)[#it.body]]
      ]
    } else {
      block(above: 10mm, below: 10mm)[#it]
    }
  }

  // 3단계 제목: 절
  show heading.where(level: 3): it => {
    if it.has("label") and it.label == <rule-section> {
      block(above: 5mm, below: 8mm)[
        #align(left)[#text(size: 14pt, weight: "bold", fill: black)[#it.body]]
      ]
    } else {
      block(above: 8mm, below: 8mm)[#it]
    }
  }

  // 4단계 제목: 조
  show heading.where(level: 4): it => {
    if it.has("label") and (str(it.label).starts-with("rule-article") or str(it.label).starts-with("rule-addendum-")) {
      text(size: 12pt, weight: "bold", fill: black)[#it.body]
    } else {
      it
    }
  }

  body

  if debug == true {
    pagebreak()
    [= Rule Marker Registry]
    context [#rule-marker-registry.final()]
  }
}

// ─────────────────────────────────────────────────────────────
// 페이지 레이아웃
// ─────────────────────────────────────────────────────────────

// 표지 페이지: 표지, 목차에 사용됩니다.
#let cover-page(body) = context {
  let margin = g-margin.get()
  let _ = margin.remove("footer")
  
  set par(
    leading: 0.86em,
    spacing: 0pt,
  )
  set page(
    paper: "a4",
    margin: margin,
    numbering: none,
  )

  body
}

// 본문 페이지
#let body-page(compact-margin: false, body) = context {
  counter(page).update(here().page())
  let numbering-data = g-page-numbering.get()
  let numbering-content = numbering-data.content
  let numbering-align = numbering-data.alignment
  let margin = if compact-margin { g-compact-margin.get() } else { g-margin.get() }
  let footer-descent = margin.remove("footer")
  set par(
    leading: 0.86em,
    spacing: 0.86em,
  )
  set page(
    paper: "a4",
    margin: margin,
    numbering: "1",
    footer-descent: footer-descent,
    footer: context {
      let current-p = counter(page).get().first()
      align(numbering-align)[
        #show regex("\d+"): [#str(current-p)]
        #numbering-content
      ]
    },
  )
  set text(fill: black, size: 12pt)

  body
}

// ─────────────────────────────────────────────────────────────
// 페이지 구성
// ─────────────────────────────────────────────────────────────

// 표지: 로고와 제목, 개정일자와 간단한 장식이 포함된 표지입니다.
#let cover(title, revised, accent-color, sub-logo, main-logo) = [
  #align(left)[#sub-logo]
  #v(28mm)
  #rect(
    width: 100%,
    height: 10mm,
    fill: accent-color.transparentize(50%),
    stroke: none,
  )
  #v(12mm)
  #align(center)[#text(size: 28pt, weight: "bold", fill: black)[#title]]
  #v(12mm)
  #rect(
    width: 100%,
    height: 10mm,
    fill: accent-color.transparentize(50%),
    stroke: none,
  )
  #v(28mm)
  #align(center)[#text(size: 18pt, weight: "medium", fill: red)[#revised]]
  #v(1fr)
  #align(center)[#main-logo]
  #pagebreak()
]

// 간단한 표지: 제목 및 상단과 하단에 추가로 작성할 수 있는 텍스트들을 직사각형 박스로 둘러싼 간단한 형태의 표지입니다.
#let simple-cover(title, top-text: none, bottom-text: none) = [
  #if top-text != none {
    align(center + top)[
      #set par(spacing: 0.86em)
      #rect(stroke: 1pt + black, inset: 30pt, radius: 0pt, [
        #text(
          size: 18pt,
          fill: black,
          tracking: 3pt,
          hyphenate: true,
        )[#top-text]
      ])
    ]
  }
  #align(center + horizon)[
    #set par(spacing: 0.86em)
    #rect(stroke: 1pt + black, inset: 30pt, radius: 0pt, [
      #text(
        size: 20pt,
        weight: "bold",
        fill: black,
        tracking: 3pt,
        hyphenate: true,
      )[#title]
    ])
  ]
  #if bottom-text != none {
    align(center + bottom)[
      #set par(spacing: 0.86em)
      #rect(stroke: 1pt + black, inset: 30pt, radius: 0pt, [
        #text(
          size: 18pt,
          fill: black,
          tracking: 3pt,
          hyphenate: true,
        )[#bottom-text]
      ])
    ]
  }

  #pagebreak()
]

// 목차 페이지
#let toc-page(depth: 3) = [
  #set text(fill: black, size: 12pt)
  #text(size: 24pt, weight: "bold")[목차]
  #v(12mm)
  #[
    #set outline.entry(fill: repeat([.], gap: 0.20em))
    #show outline.entry: set block(above: 5mm)
    #show outline.entry.where(level: 1): none
    #show outline.entry.where(level: 2): set text(size: 12pt, weight: "regular")
    #show outline.entry.where(level: 3): set text(size: 12pt, weight: "regular")
    #show outline.entry.where(level: 4): set text(size: 12pt, weight: "regular")
    #outline(title: none, depth: depth, indent: 1em)
  ]
  #pagebreak()
]

// 개정 이력
#let revision-history(entries, alignment: right) = [
  #block(width: 100%, below: 10mm)[
    #align(alignment)[
      #text(size: 13pt, fill: black)[
        #grid(
          columns: (auto, auto),
          column-gutter: 18pt,
          row-gutter: 0.86em,
          align: (alignment, alignment),
          ..entries.flatten()
        )
      ]
    ]
  ]
]

// ─────────────────────────────────────────────────────────────
// 제목 및 조항 넘버링
// ─────────────────────────────────────────────────────────────

// 2단계 제목: 장
#let chapter(title) = [
  #chapter-counter.step()
  #section-counter.update(0)
  #is-addendum.update(false)
    #context {
    let n = chapter-counter.get().first()
    [#heading(level: 2, outlined: true, numbering: none)[제#(str(n))장 #title] <rule-chapter>]
  }
]

// 2단계 제목: 부칙
#let addendum(title) = [
  #article-counter.update(0)
  #is-addendum.update(true)
  #heading(level: 2, outlined: false, numbering: none)[#title] <rule-chapter>
]

// 3단계 제목: 절
#let section-title(title) = [
  #section-counter.step()
  #is-addendum.update(false)
    #context {
    let n = section-counter.get().first()
    [#heading(level: 3, outlined: true, numbering: none)[제#(str(n))절 #title] <rule-section>]
  }
]

// 4단계 제목: 조, 수동 넘버링
#let manual-article(n, title, body, m: none) = [
  #let branch-text = none
  #let art-part-val = ""
  #if type(n) == str {
    let branch-pattern = regex("^(\d+)(?:\s*)-(?:\s*)(\d+)$")
    assert(n.match(branch-pattern) != none, message: "조 번호가 문자열이려면 가지번호 표현이어야 합니다.")
    let article-num = int(n.match(branch-pattern).captures.at(0))
    let branch-num = int(n.match(branch-pattern).captures.at(1))
    branch-text = [제#(article-num)조의#(branch-num)]
    art-part-val = str(article-num) + "-" + str(branch-num)
  } else {
    art-part-val = str(n)
  }
  #current-article-label-part.update(art-part-val)

  #context {
    let addendum-mode = is-addendum.get()
    let prefix = if addendum-mode { "rule-addendum-article-" } else { "rule-article-" }
    let label-string = prefix + art-part-val

    if m != none {
      rule-marker-registry.update(dict => {
        let art-text-val = if branch-text != none {
          "제" + art-part-val.split("-").at(0) + "조의" + art-part-val.split("-").at(1)
        } else { "제" + str(n) + "조" }
        let full-art-text = if addendum-mode { "부칙 " + art-text-val } else { art-text-val }

        dict.insert(m, (
          label-str: label-string,
          art-val: art-part-val,
          cls-val: none,
          itm-val: none,
          sub-val: none,
          art-text: full-art-text,
          cls-text: none,
          itm-text: none,
          sub-text: none,
        ))
        dict
      })
    }

    if in-table.get() {
      if branch-text != none {
        [*#branch-text (#title)* #h(0.25em)#body]
      } else {
        [*제#(str(n))조 (#title)* #h(0.25em)#body]
      }
    } else {
      let self-label = label(label-string)
      current-zone.update("article")
      block(above: 1.86em, below: 1.86em, breakable: true)[
        #if branch-text != none [
          #heading(level: 4, outlined: not addendum-mode, numbering: none)[#branch-text (#title)] #self-label
        ] else [
          #heading(level: 4, outlined: not addendum-mode, numbering: none)[제#(str(n))조 (#title)] #self-label
        ]
        #h(0.5em)#body
      ]

      if g-is-debug.get() {
        text(fill: green)[#repr(self-label) ]
        text(fill: purple)[#if m == none [none] else { m }]
      }
    }
  }
]

// 4단계 제목: 조
#let article(title, body, m: none) = [
  #article-counter.step()
  #branch-article-counter.update(1)
  #clause-counter.update(0)
  #numitem-counter.update(0)
  #subitem-counter.update(0)
  #context {
    let n = article-counter.get().first()
    manual-article(n, title, body, m: m)
  }
]

// 4단계 제목: 조(가지번호 사용)
#let branch-article(title, body, m: none) = [
  #branch-article-counter.step()
  #clause-counter.update(0)
  #numitem-counter.update(0)
  #subitem-counter.update(0)
  #context {
    let art-n = article-counter.get().first()
    let brn-n = branch-article-counter.get().first()
    manual-article(str(art-n) + "-" + str(brn-n), title, body, m: m)
  }
]

// 4단계 제목: 조(가지번호 사용)
#let b-article = branch-article

// 원형 숫자 변환 함수, 유니코드 자체의 한계로 인해, 최대 50까지만 변환할 수 있습니다.
#let circ(num) = {
  if num >= 1 and num <= 20 {
    str.from-unicode(0x245f + num)
  } else if num >= 21 and num <= 35 {
    str.from-unicode(0x323C + num)
  } else if num >= 36 and num <= 50 {
    str.from-unicode(0x328D + num)
  } else {
    str(num) // 50을 넘어가면 일반 숫자로 표시
  }
}

// 각 항: ①, ②, ③, ... 수동 넘버링. 유니코드 자체의 한계로 인해, 최대 50까지만 표시할 수 있습니다.
#let manual-clause(n, body, m: none) = [
  #let range-text = none
  #let range-start-val = none
  #let range-end-val = none
  #if type(n) == str {
    let range-pattern = regex("^(\d+)(?:\s*)~(?:\s*)(\d+)$")
    assert(n.match(range-pattern) != none, message: "항 번호가 문자열이려면 범위 표현이어야 합니다.")
    range-start-val = int(n.match(range-pattern).captures.at(0))
    range-end-val = int(n.match(range-pattern).captures.at(1))
    range-text = [#(circ(range-start-val) + " ~ " + circ(range-end-val))]
  }

  #context {
    let addendum-mode = is-addendum.get()
    let prefix = if addendum-mode { "rule-addendum-article-" } else { "rule-article-" }
    let art-part = current-article-label-part.get()
    let label-string = prefix + art-part + "-clause-" + str(n).replace("~", "to")

    if m != none {
      let art-text-val = if art-part.contains("-") {
        "제" + art-part.split("-").at(0) + "조의" + art-part.split("-").at(1)
      } else { "제" + art-part + "조" }
      let full-art-text = if addendum-mode { "부칙 " + art-text-val } else { art-text-val }
      let cls-text-val = if type(n) == str {
        "제" + str(range-start-val) + "항부터 제" + str(range-end-val) + "항까지"
      } else { "제" + str(n) + "항" }

      rule-marker-registry.update(dict => {
        dict.insert(m, (
          label-str: label-string,
          art-val: art-part,
          cls-val: str(n),
          itm-val: none,
          sub-val: none,
          art-text: full-art-text,
          cls-text: cls-text-val,
          itm-text: none,
          sub-text: none,
        ))
        dict
      })
    }

    block(width: 100%, above: 0.86em, below: 0pt, breakable: true)[
      #let is-table-mode = in-table.get()
      #current-zone.update("clause")
      #if is-table-mode {
        let num-label = if range-text != none { range-text } else [#(circ(n))]
        [#num-label #h(0.5em) #body]
      } else {
        let self-label = label(label-string)
        let col-width = if range-text != none { 13mm } else { 6mm }
        grid(
          columns: (col-width, 1fr),
          gutter: 5mm,
          align: (right, left),
          if range-text != none [ #range-text #self-label ] else [#(circ(n)) #self-label], [#body],
        )

        if g-is-debug.get() {
          h(col-width + 5mm)
          text(fill: green)[#repr(self-label) ]
          text(fill: purple)[#if m == none [none] else { m }]
        }
      }
      #current-zone.update("article")
    ]
  }
]

// 각 항: ①, ②, ③, ... 유니코드 자체의 한계로 인해, 최대 50까지만 표시할 수 있습니다.
#let clause(body, m: none) = [
  #clause-counter.step()
  #numitem-counter.update(0)
  #subitem-counter.update(0)
  #context {
    let n = clause-counter.get().first()
    manual-clause(n, body, m: m)
  }
]

// 각 호: 1., 2., 3. 형식, 수동 넘버링.
#let manual-numitem(n, body, m: none) = [
  #let range-text = none
  #let range-start-val = none
  #let range-end-val = none
  #if type(n) == str {
    let range-pattern = regex("^(\d+)(?:\s*)~(?:\s*)(\d+)$")
    assert(n.match(range-pattern) != none, message: "호 번호가 문자열이려면 범위 표현이어야 합니다.")
    range-start-val = int(n.match(range-pattern).captures.at(0))
    range-end-val = int(n.match(range-pattern).captures.at(1))
    range-text = [#(str(range-start-val) + " ~ " + str(range-end-val) + ".")]
  }

  #context {
    let addendum-mode = is-addendum.get()
    let prefix = if addendum-mode { "rule-addendum-article-" } else { "rule-article-" }
    let art-part = current-article-label-part.get()
    let cls-n = clause-counter.get().first()
    let label-string = prefix + art-part + "-clause-" + str(cls-n) + "-numitem-" + str(n).replace("~", "to")

    if m != none {
      let art-text-val = if art-part.contains("-") {
        "제" + art-part.split("-").at(0) + "조의" + art-part.split("-").at(1)
      } else { "제" + art-part + "조" }
      let full-art-text = if addendum-mode { "부칙 " + art-text-val } else { art-text-val }
      let cls-text-val = if cls-n != 0 { "제" + str(cls-n) + "항" } else { none }
      let itm-text-val = if type(n) == str {
        "제" + str(range-start-val) + "호부터 제" + str(range-end-val) + "호까지"
      } else { "제" + str(n) + "호" }

      rule-marker-registry.update(dict => {
        dict.insert(m, (
          label-str: label-string,
          art-val: art-part,
          cls-val: if cls-n != 0 { str(cls-n) } else { none },
          itm-val: str(n),
          sub-val: none,
          art-text: full-art-text,
          cls-text: cls-text-val,
          itm-text: itm-text-val,
          sub-text: none,
        ))
        dict
      })
    }

    let get-col-width(text: none) = {
      if text != none {
        if text.text.clusters().len() <= 6 { 11mm } else { 11mm + ((text.text.clusters().len() - 6) * 2.5) * 1mm }
      } else {
        0mm
      }
    }

    block(width: 100%, above: 0.86em, below: 0pt, breakable: true)[
      #let is-table-mode = in-table.get()
      #let zone = current-zone.get()

      #if is-table-mode {
        let num-label = if range-text != none { range-text } else [#(str(n) + ".")]
        if zone == "clause" {
          [#h(1.5em) #num-label #h(0.5em) #body]
        } else {
          [#num-label #h(0.5em) #body]
        }
      } else {
        let self-label = label(label-string)
        let col-width = if zone == "clause" { 0mm } else { 10mm }
        col-width = col-width + get-col-width(text: range-text)
        grid(
          columns: (col-width, 1fr),
          gutter: 5mm,
          align: (right, left),
          if range-text != none [ #range-text #self-label ] else [#(str(n) + ".") #self-label], [#body],
        )

        if g-is-debug.get() {
          h(col-width + 5mm)
          text(fill: green)[#repr(self-label) ]
          text(fill: purple)[#if m == none [none] else { m }]
        }
      }
    ]
  }
]

// 각 호: 1., 2., 3. 형식
#let numitem(body, m: none) = [
  #numitem-counter.step()
  #subitem-counter.update(0)
  #context {
    let n = numitem-counter.get().first()
    manual-numitem(n, body, m: m)
  }
]

// 각 목: 가., 나., 다. 형식, 수동 넘버링.
#let manual-subitem(n, body, m: none) = [
  #let range-text = none
  #let range-start-val = none
  #let range-end-val = none
  #if type(n) == str {
    let range-pattern = regex("^(\d+)(?:\s*)~(?:\s*)(\d+)$")
    assert(n.match(range-pattern) != none, message: "목 번호가 문자열이려면 범위 표현이어야 합니다.")
    range-start-val = int(n.match(range-pattern).captures.at(0))
    range-end-val = int(n.match(range-pattern).captures.at(1))
    range-text = [#(numbering("가", range-start-val) + " ~ " + numbering("가", range-end-val) + ".")]
  }

  #context {
    let addendum-mode = is-addendum.get()
    let prefix = if addendum-mode { "rule-addendum-article-" } else { "rule-article-" }
    let art-part = current-article-label-part.get()
    let cls-n = clause-counter.get().first()
    let num-n = numitem-counter.get().first()
    let label-string = (
      prefix + art-part + "-clause-" + str(cls-n) + "-numitem-" + str(num-n) + "-subitem-" + str(n).replace("~", "to")
    )

    if m != none {
      let art-text-val = if art-part.contains("-") {
        "제" + art-part.split("-").at(0) + "조의" + art-part.split("-").at(1)
      } else { "제" + art-part + "조" }
      let full-art-text = if addendum-mode { "부칙 " + art-text-val } else { art-text-val }
      let cls-text-val = if cls-n != 0 { "제" + str(cls-n) + "항" } else { none }
      let itm-text-val = if num-n != 0 { "제" + str(num-n) + "호" } else { none }
      let sub-text-val = if type(n) == str {
        numbering("가", range-start-val) + "목부터 " + numbering("가", range-end-val) + "목까지"
      } else { numbering("가", n) + "목" }

      rule-marker-registry.update(dict => {
        dict.insert(m, (
          label-str: label-string,
          art-val: art-part,
          cls-val: if cls-n != 0 { str(cls-n) } else { none },
          itm-val: if num-n != 0 { str(num-n) } else { none },
          sub-val: str(n),
          art-text: full-art-text,
          cls-text: cls-text-val,
          itm-text: itm-text-val,
          sub-text: sub-text-val,
        ))
        dict
      })
    }

    let get-col-width(text: none) = {
      if text != none {
        if text.text.clusters().len() <= 6 { 14mm } else { 14mm + ((text.text.clusters().len() - 6) * 4.5) * 1mm }
      } else {
        0mm
      }
    }

    block(width: 100%, above: 0.86em, below: 0pt, breakable: true)[
      #let is-table-mode = in-table.get()

      #if is-table-mode {
        let num-label = if range-text != none { range-text } else [#numbering("가.", n)]
        [#h(3em) #num-label #h(0.5em) #body]
      } else {
        let self-label = label(label-string)
        let col-width = get-col-width(text: range-text)
        grid(
          columns: (col-width, 1fr),
          gutter: 5mm,
          align: (right, left),
          if range-text != none [ #range-text #self-label ] else [#numbering("가.", n) #self-label], [#body],
        )

        if g-is-debug.get() {
          h(col-width + 5mm)
          text(fill: green)[#repr(self-label) ]
          text(fill: purple)[#if m == none [none] else { m }]
        }
      }
    ]
  }
]

// 각 목: 가., 나., 다. 형식
#let subitem(body, m: none) = [
  #subitem-counter.step()
  #context {
    let n = subitem-counter.get().first()
    manual-subitem(n, body, m: m)
  }
]

// ─────────────────────────────────────────────────────────────
// 인용
// ─────────────────────────────────────────────────────────────

// 이 규정 문서의 특정 조문을 인용합니다.
#let at(body) = context {
  let text-val = if type(body) == str { body } else {
    body.fields().at("text", default: "")
  }
  if text-val == "" { return body }

  let is-citation-addendum = text-val.match(regex("부\s*칙")) != none

  let art-match = text-val.match(regex("제\s*(\d+)\s*조(?:\s*의\s*(\d+))?"))
  let cls-match = text-val.match(regex("제\s*(\d+)\s*항"))
  let itm-match = text-val.match(regex("제\s*(\d+)\s*호"))
  let sub-match = text-val.match(
    regex("제?\s*(?:\()?([가나다라마바사아자차카타파하]+)(?:\))?\s*목"),
  )

  let current-art = str(counter("constitution-article").get().first())
  let current-brn = str(counter("constitution-branch-article").get().first())
  let current-cls = str(counter("constitution-clause").get().first())
  let current-itm = str(counter("constitution-numitem").get().first())
  let current-is-addendum = is-addendum.get()

  let art-num = if art-match != none { art-match.captures.at(0) } else { none }
  let brn-num = if art-match != none { art-match.captures.at(1) } else { none }
  let cls-num = if cls-match != none { cls-match.captures.at(0) } else { none }
  let itm-num = if itm-match != none { itm-match.captures.at(0) } else { none }
  let sub-char = if sub-match != none { sub-match.captures.at(0) } else { none }

  let hangeul-to-number(char) = {
    if char == none { return none }
    let alphabet = (
      "가",
      "나",
      "다",
      "라",
      "마",
      "바",
      "사",
      "아",
      "자",
      "차",
      "카",
      "타",
      "파",
      "하",
    )
    let chars = char.clusters()
    let base = alphabet.len()
    let result = 0
    for ch in chars {
      let idx = alphabet.position(x => x == ch)
      assert(idx != none, message: "지원하지 않는 목 번호입니다: " + ch)
      result = result * base + idx + 1
    }
    str(result)
  }

  let explicit-art = art-num != none
  let explicit-cls = cls-num != none
  let explicit-itm = itm-num != none
  let explicit-sub = sub-char != none

  // 조가 생략되었으나 항/호/목 중 하나라도 입력된 경우
  if not explicit-art and (explicit-cls or explicit-itm or explicit-sub) {
    art-num = current-art
    if current-brn != "1" {
      let real-brn = int(current-brn) - 1
      if real-brn > 0 {
        brn-num = str(real-brn)
      }
    }
  }

  // 항 처리
  if cls-num == none and (itm-num != none or sub-char != none) {
    if explicit-art {
      cls-num = "0"
    } else {
      cls-num = current-cls
    }
  }

  // 호 처리
  if itm-num == none and sub-char != none {
    if explicit-art or explicit-cls {
      itm-num = "0"
    } else if current-itm != "0" {
      itm-num = current-itm
    }
  }

  let loc = here()
  if art-num != none {
    let label-art-part = if brn-num != none { art-num + "-" + brn-num } else {
      art-num
    }
    let use-addendum-prefix = is-citation-addendum or (not explicit-art and current-is-addendum)
    let prefix = if use-addendum-prefix { "rule-addendum-article-" } else { "rule-article-" }

    let target-string = prefix + label-art-part
    if cls-num != none {
      target-string += "-clause-" + cls-num
    }
    if itm-num != none {
      target-string += "-numitem-" + itm-num
    }
    if sub-char != none {
      let sub-num = hangeul-to-number(sub-char)
      target-string += "-subitem-" + sub-num
    }
    let target-label = label(target-string)
    if g-is-debug.get() != true {
      assert(
        query(target-label).len() > 0,
        message: "at() 인용 대상이 존재하지 않습니다.\n입력: \""
          + text-val
          + "\"\n"
          + repr(loc.position())
          + "\nLabel: `"
          + repr(target-label)
          + "`",
      )
    } else {
      if query(target-label).len() == 0 {
        target-label = loc
      }
    }
    link(target-label)[#text-val]
    if g-is-debug.get() == true {
      link(target-label)[#text(fill: blue)[(#repr(label(target-string)))]]
      if query(label(target-string)).len() == 0 [#text(fill: red, weight: "extrabold")[해당 위치를 찾을 수 없음.]]
    }
  } else {
    if g-is-debug.get() != true {
      assert(
        false,
        message: "조 번호를 알 수 없습니다.\n입력: \"" + text-val + "\"\n" + repr(loc.position()),
      )
    } else {
      [#text(fill: red, weight: "extrabold")[조 번호를 알 수 없음.]]
    }
  }
}

#let at-m(marker-args) = context {
  let reg = rule-marker-registry.final()

  let get-target(name) = {
    if g-is-debug.get() != true {
      assert(name in reg, message: "마커를 찾을 수 없습니다: " + name)
    }
    if not (name in reg) { return none }
    return reg.at(name)
  }

  let compute-parts(target, base-context) = {
    if target == none { return () }

    let diff-found = false
    let text-parts = ()

    let target-is-addendum = target.label-str.starts-with("rule-addendum-")
    if target-is-addendum != base-context.is-addendum { diff-found = true }

    // 조 비교
    if target.art-val != base-context.art { diff-found = true }
    if diff-found and target.art-text != none { text-parts.push(target.art-text) }

    // 항 비교
    if not diff-found and target.cls-val != base-context.cls { diff-found = true }
    if diff-found and target.cls-text != none { text-parts.push(target.cls-text) }

    // 호 비교
    if not diff-found and target.itm-val != base-context.itm { diff-found = true }
    if diff-found and target.itm-text != none { text-parts.push(target.itm-text) }

    // 목 비교
    if not diff-found and target.sub-val != base-context.sub { diff-found = true }
    if diff-found and target.sub-text != none { text-parts.push(target.sub-text) }

    // 자기 자신 인용 예외 처리
    if text-parts.len() == 0 {
      if target.sub-text != none { text-parts.push(target.sub-text) } else if target.itm-text != none {
        text-parts.push(target.itm-text)
      } else if target.cls-text != none { text-parts.push(target.cls-text) } else { text-parts.push(target.art-text) }
    }
    return text-parts
  }

  let caller-cls-num = clause-counter.get().first()
  let caller-itm-num = numitem-counter.get().first()
  let caller-sub-num = subitem-counter.get().first()
  let caller-ctx = (
    art: current-article-label-part.get(),
    cls: if caller-cls-num != 0 { str(caller-cls-num) } else { none },
    itm: if caller-itm-num != 0 { str(caller-itm-num) } else { none },
    sub: if caller-sub-num != 0 { str(caller-sub-num) } else { none },
    is-addendum: is-addendum.get(),
  )

  // 디버그 모드용 누락 마커 표기 헬퍼
  let debug-error(name) = [#text(fill: red, weight: "extrabold")["#name" 마커를 찾을 수 없음.]]

  // 단일 문자열이 들어온 경우
  if type(marker-args) == str {
    let target = get-target(marker-args)
    if target == none { return debug-error(marker-args) }

    let final-text = compute-parts(target, caller-ctx).join("")
    let target-label = label(target.label-str)

    link(target-label)[#final-text]
    if g-is-debug.get() == true {
      link(target-label)[#text(fill: blue)[(#repr(target-label))]]
    }
  } // 배열(시작점, 끝점)이 들어온 경우
  else if type(marker-args) == array {
    if marker-args.len() == 0 { return () }

    // 배열 안의 첫 원소가 다시 배열인 경우 -> 범위 인용으로 처리
    if type(marker-args.at(0)) == array {
      let range-pair = marker-args.at(0)
      assert(range-pair.len() == 2, message: "범위 인용은 정확히 2개의 마커가 필요합니다.")

      let start-target = get-target(range-pair.at(0))
      let end-target = get-target(range-pair.at(1))
      if start-target == none or end-target == none { return debug-error(range-pair.join(", ")) }

      let start-text = compute-parts(start-target, caller-ctx).join("")

      let start-as-ctx = (
        art: start-target.art-val,
        cls: start-target.cls-val,
        itm: start-target.itm-val,
        sub: start-target.sub-val,
        is-addendum: start-target.label-str.starts-with("rule-addendum-"),
      )
      let end-text = compute-parts(end-target, start-as-ctx).join("")

      [#link(label(start-target.label-str))[#start-text]부터 #link(label(end-target.label-str))[#end-text]까지]
      if g-is-debug.get() == true {
        text(fill: blue)[]
        [#link(label(start-target.label-str))[(#repr(label(start-target.label-str))] ~ #link(label(
            end-target.label-str,
          ))[(#repr(label(end-target.label-str))]]
      }
    } // 1차원 문자열 배열인 경우 -> 나열 인용으로 처리
    else {
      let targets = marker-args.map(name => (name: name, obj: get-target(name)))
      for t in targets { if t.obj == none { return debug-error(t.name) } }

      let result-content = ()
      let current-base = caller-ctx

      for (i, t) in targets.enumerate() {
        let parts = compute-parts(t.obj, current-base)
        let txt = parts.join("")

        let item-content = [
          #link(label(t.obj.label-str))[#txt]
          #if g-is-debug.get() == true [
            #text(fill: blue, size: 0.8em)[<#t.obj.label-str>]
          ]
        ]

        result-content.push(item-content)

        current-base = (
          art: t.obj.art-val,
          cls: t.obj.cls-val,
          itm: t.obj.itm-val,
          sub: t.obj.sub-val,
          is-addendum: t.obj.label-str.starts-with("rule-addendum-"),
        )
      }

      let len = result-content.len()
      if len == 1 { return result-content.at(0) } else if len == 2 {
        return [#result-content.at(0) 및 #result-content.at(1)]
      } else {
        let front = result-content.slice(0, len - 1).join(", ")
        return [#front 및 #result-content.at(len - 1)]
      }
    }
  }
}

// ─────────────────────────────────────────────────────────────
// 신·구조문대비표
// ─────────────────────────────────────────────────────────────

#let side-by-side-table(
  hide-inner-stroke: false,
  no-inset: false,
  hide-remark: false,
  rows,
) = [
  #in-table.update(true)
  #block(width: 100%, above: 1.2em, below: 1.2em, breakable: true)[
    #set text(size: 10pt)
    #set par(leading: 0.86em, first-line-indent: 0pt)

    #let table-stroke(col, row, total-rows) = {
      let base-stroke = 0.5pt + gray

      if hide-inner-stroke {
        let bottom-line = if row == 0 or row == total-rows - 1 {
          base-stroke
        } else { none }
        let top-line = if row == 0 { base-stroke } else { none }
        (
          left: base-stroke,
          right: base-stroke,
          top: top-line,
          bottom: bottom-line,
        )
      } else {
        base-stroke
      }
    }

    #let columns = (1fr, 1fr, 0.4fr)
    #let final-rows = rows
    #if hide-remark == true {
      columns = (1fr, 1fr)
      final-rows = final-rows.map(it => (it.at(0), it.at(1)))
    }

    #table(
      columns: columns,
      stroke: (col, row) => table-stroke(col, row, final-rows.len() + 1),
      fill: (col, row) => if row == 0 { rgb("#f9f9fa") } else { none },
      align: (col, row) => if row == 0 { center + horizon } else { left + top },
      ..if not no-inset { (inset: (x: 10pt, y: 12pt)) },
      table.header(
        [*현행*],
        [*개정안*],
        ..if not hide-remark { ([*비고*],) } else { () },
        repeat: false
      ),

      ..final-rows.flatten()
    )
  ]
  #in-table.update(false)
]

// 개별 행 함수
#let compare-row(old-content, new-content, remark: none) = (
  [#old-content],
  [#new-content],
  [#remark],
)

// ─────────────────────────────────────────────────────────────
// 기타 문장부호
// ─────────────────────────────────────────────────────────────

// 겹낫표(『』): 책의 제목이나 신문 이름 등을 나타낼 때 사용합니다.
#let d-bracket(body) = [『#body』]

// 겹화살괄호(《》): 책의 제목이나 신문 이름 등을 나타낼 때 사용합니다.
#let d-arrow(body) = [《#body》]

// 홑낫표(｢｣): 소제목, 그림이나 노래와 같은 예술 작품의 제목, 상호, 법률, 규정 등을 나타낼 때 사용합니다.
#let s-bracket(body) = [｢#body｣]

// 홑화살괄호(〈〉): 소제목, 그림이나 노래와 같은 예술 작품의 제목, 상호, 법률, 규정 등을 나타낼 때 사용합니다.
#let s-arrow(body) = [〈#body〉]

// 가운뎃점(·): 짝을 이루는 것을 나타낼 때 사용합니다. Typst의 sym.dot.c를 사용합니다.
#let cdot = sym.dot.c
