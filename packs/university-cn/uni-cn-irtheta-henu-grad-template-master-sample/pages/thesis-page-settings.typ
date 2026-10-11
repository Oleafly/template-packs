// 页面样式、页眉页脚及全局段落排版配置模块
// 提供论文封面后的正文基础排版、奇偶页眉自动提取、页码样式切换

#import "../fonts/font-def.typ": *

// A4 纸张版心设置，精确还原论文模板边距
#let _set_page_size(body) = {
  set page(
    paper: "a4", 
    margin: (
      right: 2.4cm, 
      left: 2.4cm, 
      top: 3.1cm, 
      bottom: 2.8cm
    )
  )
  body
}

// 正文全局排版基础：宋体 12pt，首行缩进 2em，1.24em 行距
#let _set_page_par(body) = {
  set text(
    font: songti, 
    12pt
  )
  set par(
    justify: true, 
    first-line-indent: 2em, 
    leading: 1.24em, 
    spacing: 1.24em
  )
  body
}

// 页眉内容生成：奇数页提取当前章节名，偶数页显示论文题目
// 兼容 numbering: none 的标题（如“参考文献”），自动去除“第X章”前缀
#let _header_content(anonymous: false, title) = context {
  let headings = query(heading.where(level: 1))
  let first_chapter = headings.find(h => h.numbering != none)

  // 页眉在页面内容之前求值，正文首行的 counter(page).update(1) 此时可能尚未生效。
  // 因此以第一个带编号的一级标题为正文第 1 页，按物理页差计算正文逻辑页码。
  // 该结果不受中文摘要、英文摘要或目录占用页数变化的影响。
  let p = if first_chapter != none and here().page() >= first_chapter.location().page() {
    here().page() - first_chapter.location().page() + 1
  } else {
    counter(page).get().first()
  }
  
  if calc.odd(p) { // 逻辑奇数页 -> 显示章节名
    // 注：loc.page() 依然是物理页码，用于从近到远查找章节，逻辑不变
    let filtered = headings.filter(h => h.location().page() <= here().page())
    
    let current = if filtered.len() > 0 {
      filtered.last()
    } else if headings.len() > 0 {
      headings.first()
    } else {
      none
    }

    if current != none {
      let num = counter(heading).at(current.location()).first()
      let num-str = if current.numbering != none {
        numbering("1", num)
      } else {
        none
      }

      if num-str != none {
        [第 #num-str 章 #current.body]
      } else {
        current.body
      }
    } else {
      []
    }
  } else { // 逻辑偶数页 -> 显示论文题目
    title
  }
}

// 页眉容器模板：整体下移 5.8mm，利用 stack 精确控制文字与下划线的 3pt 物理间距
#let _set_page_header(anonymous: false, title: "", body) = {
  set page(
    header: context {
      set text(font: songti, 11.5pt, baseline: 8pt+5.8mm)
      set align(center)

      v(5.8mm)

      stack(
        dir: ttb,
        spacing: 4pt,
        _header_content(anonymous: anonymous, title),
        box(
          baseline: 5.8mm, 
          line(length: 100%, stroke: 0.7pt)
        )
      )
    }
  )
  body
}

// 页码对齐定位：偶数页居左，奇数页居右（符合中文学位论文标准）
#let _footer_location(format: "1") = context {
  let p = counter(page).get().first()
  let loc = if calc.even(p) {left} else {right}
  align(loc, counter(page).display(format))
}

// 前置部分（摘要、目录）页脚：大写罗马数字页码
#let _set_page_footer_pre(body) = {
  set page(
    footer: context {
      set text(
        font: songti, 11pt, baseline: -2.6mm
      )
      _footer_location(format: "I")
    }
  )
  body
}

// 正文部分页脚：阿拉伯数字页码
#let _set_page_footer_main(body) = {
  set page(
    footer: context {
      set text(
        font: songti, 11pt, baseline: -2.6mm
      )
      _footer_location(format: "1")
    }
  )
  body
}

// 清理页脚（用于封面、声明等不应显示页码的页面）
#let _set_page_no_footer(body) = {
  set page(
    footer: none
  )
  body
}
