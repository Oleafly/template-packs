// ============================================================
// 复旦大学学位论文 Typst 模板 - 页眉页脚与样式
// ============================================================

#import "config.typ": *
#import "utils.typ": thesis-name

// 页眉生成函数
#let make-header(info: (:), twoside: false) = {
  return context {
    let page-num = counter(page).get().first()
    let header-text = school-name + thesis-name(info.degree)

    set text(font: font-family.宋体, size: font-size.小五)

    if twoside {
      if calc.rem(page-num, 2) == 0 {
        let elems = query(selector(heading.where(level: 1)).before(here()))
        let chapter-title = if elems.len() > 0 {
          let last = elems.last()
          if last.numbering != none {
            numbering(last.numbering, ..counter(heading).at(last.location()))
            h(0.5em)
          }
          last.body
        } else {
          header-text
        }
        align(center, chapter-title)
      } else {
        align(center, header-text)
      }
    } else {
      align(center, header-text)
    }
    v(-8pt)
    line(length: 100%, stroke: 0.5pt)
  }
}

// 正文页脚（阿拉伯数字）
#let make-footer() = {
  return context {
    let page-num = counter(page).get().first()
    align(center, text(
      font: font-family.宋体,
      size: font-size.小五,
      str(page-num),
    ))
  }
}

// 前置部分页脚（罗马数字）
#let make-front-footer() = {
  return context {
    let page-num = counter(page).get().first()
    align(center, text(
      font: font-family.宋体,
      size: font-size.小五,
      numbering("I", page-num),
    ))
  }
}

// 正文页眉：章首页空；偶数页章名左上角；奇数页节名右上角
#let make-body-header(info: (:)) = {
  context {
    let current-page = here().page()
    let all-h1 = query(heading.where(level: 1))
    let is-chapter-start = all-h1.any(h => h.location().page() == current-page)

    if not is-chapter-start {
      set text(font: font-family.宋体, size: font-size.小五)
      let page-num = counter(page).get().first()

      if calc.rem(page-num, 2) == 0 {
        let prev-h1 = query(selector(heading.where(level: 1)).before(here()))
        if prev-h1.len() > 0 {
          let h = prev-h1.last()
          let title = if h.numbering != none {
            [#numbering(h.numbering, ..counter(heading).at(h.location())) #h.body]
          } else {
            h.body
          }
          align(left, title)
        }
      } else {
        let prev-h1 = query(selector(heading.where(level: 1)).before(here()))
        let current-chapter-num = if prev-h1.len() > 0 {
          counter(heading).at(prev-h1.last().location()).at(0)
        } else { 0 }

        let prev-h2 = query(selector(heading.where(level: 2)).before(here()))
        let chapter-h2 = prev-h2.filter(h => {
          counter(heading).at(h.location()).at(0) == current-chapter-num
        })

        if chapter-h2.len() > 0 {
          let h = chapter-h2.last()
          let title = if h.numbering != none {
            [#numbering(h.numbering, ..counter(heading).at(h.location())) #h.body]
          } else {
            h.body
          }
          align(right, title)
        } else if prev-h1.len() > 0 {
          let h = prev-h1.last()
          let title = if h.numbering != none {
            [#numbering(h.numbering, ..counter(heading).at(h.location())) #h.body]
          } else {
            h.body
          }
          align(right, title)
        }
      }

      v(-8pt)
      line(length: 100%, stroke: 0.5pt)
    }
  }
}
