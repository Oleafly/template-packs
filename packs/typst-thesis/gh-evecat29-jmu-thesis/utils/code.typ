#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/pointless-size:0.1.2": zh

// 全局预设
#let code_setup(doc) = {
  show: codly-init.with()
  
  // 基础样式
  codly(
    languages: codly-languages,
    radius: 5pt,
    zebra-fill: luma(252),
    stroke: 0.5pt + luma(220), // 稍微淡一点的框线
    number-format: n => text(fill: gray, size: 1em)[#n],
    smart-indent: true,
    breakable: true,
  )
  // 开启跨页
  show figure.where(kind: raw): set block(breakable: true)
  // 隐藏原生的代码 figure 标题输出
  show figure.caption.where(kind: raw): it => none
  // 设置间距
  show figure.where(kind: raw): set block(above: 1.5em, below: 1.5em)

  // 自动编号
  show figure.where(kind: raw): set figure(
    supplement: "代码",
    numbering: n => context {
      let h1 = counter(heading).get().first()
      numbering("1-1", h1, n)
    }
  )

  // 重置计数器
  show heading.where(level: 1): it => {
    counter(figure.where(kind: raw)).update(0)
    it
  }

  doc
}


#let code_block(
  body, 
  caption: none, 
  lang: none,
) = {
  let content = if type(body) == str {
    raw(body, lang: lang)
  } else {
    if lang != none {
      show raw: set raw(lang: lang)
      body
    } else {
      body
    }
  }

  figure(
    context {
      // 获取编号
      let h1 = counter(heading).get().first()
      let n = counter(figure.where(kind: raw)).get().first()
      let fig_num = numbering("1-1", h1, n)

      // 构造标题栏
      let academic_header = if caption != none {
        stack(
          dir: ttb,
          v(0.3em),
          text(size: zh("小五"))[
            #text(weight: "bold")[代码 #fig_num] #h(0.5em) #caption
          ],
          v(0.5em),
          line(length: 100%, stroke: 0.3pt + luma(200))
        )
      } else { none }

      codly(
        header: academic_header,
        // display-name: false, // 禁用右侧语言名称显示
        // display-icon: false, // 禁用右侧图标显示
        header-repeat: true, // 跨页时是否重复 header
      )
      
      content
    },
    caption: caption,
    kind: raw,
  )
}