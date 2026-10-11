#import "@preview/touying:0.8.0": *

// 底栏布局函数
#let render-footer(self) = {
  set std.align(bottom)
  set text(size: 0.55em, fill: self.colors.secondary)

  let style = self.store.at("style", default: "academic")

  let short-author = if (
    "short-author" in self.info and self.info.short-author != auto
  ) {
    self.info.short-author
  } else if "author" in self.info {
    self.info.author
  } else {
    none
  }

  let short-title = if (
    "short-title" in self.info and self.info.short-title != auto
  ) {
    self.info.short-title
  } else if "title" in self.info {
    self.info.title
  } else {
    none
  }

  let mx = self.store.at("page-margins", default: (x: 3.2em)).x

  if style == "minimal" {
    // 极简风格：仅在右侧保留页码
    pad(bottom: 10pt, x: mx, {
      grid(
        columns: (1fr, auto),
        [],
        text(fill: self.colors.secondary, weight: "medium", context {
          let cur = utils.slide-counter.display()
          let total = utils.last-slide-number
          [#cur / #total]
        }),
      )
    })
  } else if style == "bold" {
    // 科技风格：短标题与胶囊页码
    pad(bottom: 10pt, x: mx, {
      grid(
        columns: (1fr, auto),
        if short-title != none {
          text(fill: self.colors.secondary, weight: "medium", short-title)
        } else { [] },
        box(
          fill: self.colors.primary-light,
          radius: 3pt,
          inset: (x: 0.6em, y: 0.25em),
          text(fill: self.colors.primary, weight: "bold", context {
            let cur = utils.slide-counter.display()
            let total = utils.last-slide-number
            [#cur / #total]
          }),
        ),
      )
    })
  } else {
    // 典雅风格：作者、标题、日期与页码
    pad(bottom: 10pt, x: mx, {
      grid(
        columns: (1fr, auto),
        [
          #(if short-author != none [ #short-author ])
          #(
            if short-author != none
              and short-title != none [ #h(0.6em) · #h(0.6em) ]
          )
          #(if short-title != none [ #short-title ])
          #(
            if (
              short-author != none or short-title != none
            ) [ #h(0.6em) · #h(0.6em) ]
          )
          #utils.display-info-date(self)
        ],
        text(weight: "medium", context {
          let cur = utils.slide-counter.display()
          let total = utils.last-slide-number
          [#cur / #total]
        }),
      )
    })
  }
}
