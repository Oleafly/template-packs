/// 版面基本设置
#let set_style(
  title_chs,
  author_chs,
  abstract_chs,
  keyword_chs,
  title_eng,
  author_eng,
  abstract_eng,
  keyword_eng,
  doc,
  bibpath,
  enableMirrorMargins: false, // 控制是否启用镜像页边距, 也就是奇偶页页边距不同
  enableJustifyPars: true, // 控制正文是否启用两端对齐
) = {
  import "@preview/pointless-size:0.1.0": zh
  import "@preview/cuti:0.2.1": show-cn-fakebold
  import "@preview/i-figured:0.2.4"
  import "@preview/modern-nju-thesis:0.3.4": bilingual-bibliography

  show math.equation: i-figured.show-equation
  show figure: i-figured.show-figure
  show: show-cn-fakebold

  // 确定整体页面格式
  set page(
    width: 18.4cm,
    height: 26cm,
    // 页眉
    header: {
      set text(size: zh(-5), font: ("Times New Roman", "KaiTi"), lang: "zh", fill: gray)
      context {
        // 第一页无需页眉
        if counter(page).get().first() == 1 { } else {
          // 奇数页和偶数页的页眉不同
          if calc.even(counter(page).get().first()) {
            counter(page).display("1")
            h(1fr)
            text(datetime.today().display(), size: 9pt)
          } else {
            // 添加除第一页外的奇数页的 作者：标题
            author_chs.at(0).at("name")
            text(" ")
            if author_chs.len() != 1 {
              text("等")
            }
            text(":")
            text(title_chs)
            h(1fr)
            counter(page).display("1").trim()
          }
        }
        v(0.5cm)
      }
    },
    margin: (top: 2.3cm, bottom: 2.2cm, inside: 1.45cm, outside: 1.45cm),
    number-align: center,
  )
  set text(size: zh(-5), font: ("Times New Roman", "NSimsun", "Simsun"), lang: "zh")

  // 解决缩进问题，同时解决行尾间距
  set par(first-line-indent: 2em, spacing: 0.65em)
  let fake-par = {
    v(-1em)
    par("")
  }
  show math.equation.where(block: true): it => it + fake-par // 公式后缩进
  show enum.item: it => it + fake-par
  show list.item: it => it + fake-par // 列表后缩进

  // 图片的标题格式
  show figure.where(kind: image): it => {
    set text(font: ("Times New Roman", "STKaiti"), size: zh(-5))
    it
  }

  // 表格的标题格式
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    set text(font: ("Times New Roman", "SimHei"), weight: "bold")
    it
  }

  // Figure 上面空出一个空格
  show figure: it => {
    pad(top: 0.5em, bottom: 0.5em)[
      #it
    ]
    fake-par // 关键的换行
  }

  // 标题的字体格式
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): it => {
    set text(font: ("Times New Roman", "SimHei"), size: zh(5))
    pad(
      top: 0.5em,
      bottom: 0.5em,
      [
        #box(width: 0.64cm, counter(heading).display())#it.body
      ],
    )
    fake-par // 关键的换行
  }
  show heading.where(level: 2): it => {
    set text(font: ("Times New Roman", "SimHei"), size: zh(-5))
    pad([
      #box(width: 0.64cm, counter(heading).display())#it.body
    ])
    fake-par // 关键的换行
  }
  show heading.where(level: 3): it => {
    set text(font: ("Times New Roman", "SimSun"), size: zh(-5), weight: "regular")
    pad([
      #box(width: 0.64cm, counter(heading).display())#it.body
    ])
    fake-par // 关键的换行
  }

  // 表格内字体设置
  show table.cell: it => {
    set text(font: ("Times New Roman", "NSimsun", "Simsun"), size: zh(-5), weight: "regular")
    it
  }

  // 默认图像宽度
  set image(width: 60%)

  // 标题格式
  let title(title_str) = {
    linebreak()
    text(size: zh(4), font: ("Times New Roman", "SimHei"))[
      #title_str
    ]
    linebreak()
  }

  /// 作者信息，格式为一个(name,insitute)的数组
  let author(info, isEng: false) = {
    let index = 1
    set text(
      size: zh(4),
      font: ("Times New Roman", "Fangsong"),
      style: if isEng { "italic" } else { "normal" },
    )
    pad(
      top: 8pt,
      bottom: 12pt,
      for name in info {
        name.name
        super[#index]
        if name != info.last() {
          if isEng { ", " } else { "，" }
        }
        index += 1
      },
    )

    set text(size: zh(-5), font: ("Times New Roman", "STKaiti"))
    index = 1
    for value in info {
      super(str(index))
      "("
      value.insitute
      if value != info.last() {
        linebreak()
      }
      ")"
      index += 1
    }
  }

  // 摘要格式
  let abstract(leading, string) = {
    set text(size: zh(-5))
    {
      text(font: ("Times New Roman", "SimHei"))[*#leading*]
      text(font: ("Times New Roman", "STKaiti"))[#string]
      linebreak()
    }
  }


  title(title_chs)
  author(author_chs)
  pad(
    top: 1em,
    bottom: 1em,
    {
      abstract("摘要：", abstract_chs)
      abstract("关键词：", keyword_chs)
    },
  )

  title(title_eng)
  author(author_eng, isEng: true)
  pad(
    top: 1em,
    bottom: 1em,
    {
      abstract("Abstract: ", abstract_eng)
      abstract("Keywords: ", keyword_eng)
    },
  )
  linebreak()

  if enableJustifyPars {
    set par(justify: true)
  }
  text(doc)

  pad(
    top: 2.5em,
    bottom: 0.5em,
    {
      set text(font: ("Times New Roman", "SimHei"), size: zh(5))
      strong("Refrence:")
    },
  )
  fake-par

  bilingual-bibliography(bibliography: bibpath, title: none)
}
