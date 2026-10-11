#import "@preview/pointless-size:0.1.2": zh

#let fix-path(path) = {
  if path.starts-with("../") or path.starts-with("/") {
    path
  } else {
    "../" + path
  }
}

/// 图表全局环境配置
#let image_setup(doc) = {
  // 图表上下间距
  show figure.where(kind: image): set block(above: 1.5em, below: 1.5em)

  // 图标题和图作为一个整体出现在同一页
  show figure.where(kind: image): set block(breakable: false)

  // 图标题在下方
  show figure.where(kind: image): set figure.caption(position: bottom)

  // 标题和图之间的间距
  show figure.where(kind: image): set figure(gap: 0.6em)

  // 自动编号逻辑
  show figure.where(kind: image): set figure(
    supplement: [图],
    numbering: n => context {
      let h1 = counter(heading).get().first()
      numbering("1-1", h1, n)
    }
  )

  // 章节切换时重置图计数器
  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    it
  }

  // 设置标题样式
  show figure.caption.where(kind: image): set text(size: zh("五号"))
  show figure.caption.where(kind: image): it => {
    set align(center)
    it
  }

  doc
}

#let img-single(
  path,
  caption: none,
  width: 80%,
  note: none,
) = {
  let final-path = fix-path(path)
  figure(
    image(final-path, width: width),
    caption: if note == none {
      caption
    } else {
      [#caption #v(0.2em) #set text(size: zh("小五号")); #note] // 图注通常用更小一号字体
    },
    kind: image,
  )
}


#let img-grid(
  imgs: (),
  columns: 2,
  main-caption: none,
  note: none,
) = {
  figure(
    grid(
      columns: columns,
      gutter: 1em,
      ..imgs.enumerate().map(((idx, it)) => {
        let sub-label = numbering("a", idx + 1)
        stack(
          spacing: 0.5em,
          image(fix-path(it.path), width: 100%),
          text(size: zh("五号"))[(#sub-label) #it.at("caption", default: none)]
        )
      })
    ),
    caption: if note == none {
      main-caption
    } else {
      [#main-caption #v(0.2em) #set text(size: zh("小五号")); #note]
    },
    kind: image,
  )
}