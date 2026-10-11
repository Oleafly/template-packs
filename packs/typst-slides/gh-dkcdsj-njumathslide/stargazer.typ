// Stargazer theme.
// Authors: Coekjan, QuadnucYard, OrangeX4
// Inspired by https://github.com/Coekjan/touying-buaa and https://github.com/QuadnucYard/touying-theme-seu

//#import "../src/exports.typ": *
#import "@preview/touying:0.6.1": *

// 卡片式强调块：可在此调整顶部/底部背景色、圆角与内边距，统一用于 tblock。
#let _tblock(self: none, title: none, it) = {
  grid(
    columns: 1,
    row-gutter: 0pt,
    block(
      fill: self.colors.primary-dark,
      width: 100%,
      radius: (top: 6pt),
      inset: (top: 0.4em, bottom: 0.3em, left: 0.5em, right: 0.5em),
      text(fill: self.colors.neutral-lightest, weight: "bold", title),
    ),

    rect(
      fill: gradient.linear(
        self.colors.primary-dark,
        self.colors.primary.lighten(90%),
        angle: 90deg,
      ),
      width: 100%,
      height: 4pt,
    ),

    block(
      fill: self.colors.primary.lighten(90%),
      width: 100%,
      radius: (bottom: 6pt),
      inset: (top: 0.4em, bottom: 0.5em, left: 0.5em, right: 0.5em),
      it,
    ),
  )
}


/// Theorem block for the presentation.
///
/// - title (string): The title of the theorem. Default is `none`.
///
/// - it (content): The content of the theorem.
// 定理/提示等强调块，传入标题与内容：#tblock(title: [定理])[内容]
#let tblock(title: none, it) = touying-fn-wrapper(_tblock.with(
  title: title,
  it,
))


/// Default slide function for the presentation.
///
/// - title (string): The title of the slide. Default is `auto`.
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - repeat (auto): The number of subslides. Default is `auto`, which means touying will automatically calculate the number of subslides.
///
///   The `repeat` argument is necessary when you use `#slide(repeat: 3, self => [ .. ])` style code to create a slide. The callback-style `uncover` and `only` cannot be detected by touying automatically.
///
/// - setting (dictionary): The setting of the slide. You can use it to add some set/show rules for the slide.
///
/// - composer (function): The composer of the slide. You can use it to set the layout of the slide.
///
///   For example, `#slide(composer: (1fr, 2fr, 1fr))[A][B][C]` to split the slide into three parts. The first and the last parts will take 1/4 of the slide, and the second part will take 1/2 of the slide.
///
///   If you pass a non-function value like `(1fr, 2fr, 1fr)`, it will be assumed to be the first argument of the `components.side-by-side` function.
///
///   The `components.side-by-side` function is a simple wrapper of the `grid` function. It means you can use the `grid.cell(colspan: 2, ..)` to make the cell take 2 columns.
///
///   For example, `#slide(composer: 2)[A][B][#grid.cell(colspan: 2)[Footer]]` will make the `Footer` cell take 2 columns.
///
///   If you want to customize the composer, you can pass a function to the `composer` argument. The function should receive the contents of the slide and return the content of the slide, like `#slide(composer: grid.with(columns: 2))[A][B]`.
///
/// - bodies (content): The contents of the slide. You can call the `slide` function with syntax like `#slide[A][B][C]` to create a slide.
// 通用页：可按页覆盖标题/页眉/页脚/对齐与布局；未传入的参数沿用主题默认 store。
#let slide(
  title: auto,
  header: auto,
  footer: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  if title != auto {
    self.store.title = title
  }
  if header != auto {
    self.store.header = header
  }
  if footer != auto {
    self.store.footer = footer
  }
  // new-setting 将本页的对齐与自定义 set/show 叠加后传给 touying-slide。
  let new-setting = body => {
    show: std.align.with(self.store.align)
    show: setting
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})


/// Title slide for the presentation. You should update the information in the `config-info` function. You can also pass the information directly to the `title-slide` function.
///
/// Example:
///
/// ```typst
/// #show: stargazer-theme.with(
///   config-info(
///     title: [Title],
///     logo: emoji.city,
///   ),
/// )
///
/// #title-slide(subtitle: [Subtitle])
/// ```
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
// 封面页：信息来自 self.info 与 args；可在 config 注入颜色或留白。
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
  )
  self.store.title = none
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  let body = {
    show: std.align.with(center + horizon)
    // 封面主块：调整 fill/inset/radius 可改封面风格。
    block(
      fill: self.colors.primary,
      inset: 1.5em,
      radius: 0.5em,
      breakable: false,
      {
        text(
          size: 1.2em,
          fill: self.colors.neutral-lightest,
          weight: "bold",
          info.title,
        )
        if info.subtitle != none {
          parbreak()
          text(
            size: 1.0em,
            fill: self.colors.neutral-lightest,
            weight: "bold",
            info.subtitle,
          )
        }
      },
    )
    // authors
    grid(
      columns: (1fr,) * calc.min(info.authors.len(), 3),
      column-gutter: 1em,
      row-gutter: 1em,
      ..info.authors.map(author => text(fill: black, author)),
    )
    v(0.5em)
    // institution
    if info.institution != none {
      parbreak()
      text(size: 0.7em, info.institution)
    }
    // date
    if info.date != none {
      parbreak()
      text(size: 1.0em, utils.display-info-date(self))
    }
  }
  touying-slide(self: self, body)
})



/// Outline slide for the presentation.
///
/// - config (dictionary): is the configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - title (string): is the title of the outline. Default is `utils.i18n-outline-title`.
///
/// - level (int, none): is the level of the outline. Default is `none`.
///
/// - numbered (boolean): is whether the outline is numbered. Default is `true`.
// 目录页：title 默认按语言自动「目录」，也可自定义文字；numbered 控制是否编号。
#let outline-slide(
  config: (:),
  title: utils.i18n-outline-title,
  numbered: true,
  level: none,
  ..args,
) = touying-slide-wrapper(self => {
  self.store.title = title
  touying-slide(
    self: self,
    config: config,
    std.align(
      self.store.align,
      components.adaptive-columns(
        text(
          fill: self.colors.primary,
          weight: "bold",
          components.custom-progressive-outline(
            level: level,
            alpha: self.store.alpha,
            indent: (0em, 1em),
            vspace: (0.4em,),
            numbered: (numbered,),
            depth: 2,
            ..args.named(),
          ),
        ),
      )
        + args.pos().sum(default: none),
    ),
  )
})

/// New section slide for the presentation. You can update it by updating the `new-section-slide-fn` argument for `config-common` function.
///
/// Example: `config-common(new-section-slide-fn: new-section-slide.with(numbered: false))`
///
/// - config (dictionary): is the configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - title (content, function): is the title of the section. The default is `utils.i18n-outline-title`.
///
/// - level (int): is the level of the heading. The default is `1`.
///
/// - numbered (boolean): is whether the heading is numbered. The default is `true`.
///
/// - body (none): is the body of the section. It will be passed by touying automatically.
// 新章节页：本质复用 outline-slide，常用于章节分隔。level 控制 heading 层级，numbered 是否编号。
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em)
    stack(
      dir: ttb,
      spacing: 1em,
      text(self.colors.neutral-darkest, utils.display-current-heading(
        level: level,
        numbered: numbered,
        style: auto,
      )),
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        components.progress-bar(
          height: 2pt,
          self.colors.primary,
          self.colors.primary-light,
        ),
      ),
    )
    text(self.colors.neutral-dark, body)
  }
  self = utils.merge-dicts(
    self,
    config-page(fill: self.colors.neutral-lightest),
  )
  touying-slide(self: self, config: config, slide-body)
})
/// 旧版
/* 
#let new-section-slide(
  config: (:),
  title: utils.i18n-outline-title,
  level: 1,
  numbered: true,
  ..args,
  body,
) = outline-slide(
  config: config,
  title: title,
  level: level,
  numbered: numbered,
  ..args,
  body,
)
*/

/// Focus on some content.
///
/// Example: `#focus-slide[Wake up!]`
///
/// - config (dictionary): is the configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - align (alignment): is the alignment of the content. The default is `horizon + center`.
// 聚焦页：全屏色块突出单条内容，默认冻结页码计数并隐藏页眉页脚。
#let focus-slide(
  config: (:),
  align: horizon + center,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: self.colors.primary,
      margin: 2em,
      header: none,
      footer: none,
    ),
  )
  // 聚焦页保留纯色底，去掉全局背景图。
  set page(background: none)
  // 修改 fill/size 可切换聚焦色与字体大小。
  set text(fill: self.colors.neutral-lightest, weight: "bold", size: 1.5em)
  touying-slide(self: self, config: config, std.align(align, body))
})


/// End slide for the presentation.
///
/// - config (dictionary): is the configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - title (string): is the title of the slide. The default is `none`.
///
/// - body (array): is the content of the slide.
// 结束页：可选 title，主体 body 自由编排；需要自定义背景可在 config 注入 config-page。
#let ending-slide(config: (:), title: none, body) = touying-slide-wrapper(
  self => {
    let content = {
      set std.align(center + horizon)
      if title != none {
        block(
          fill: self.colors.tertiary,
          inset: (top: 0.7em, bottom: 0.7em, left: 3em, right: 3em),
          radius: 0.5em,
          text(size: 1.5em, fill: self.colors.neutral-lightest, title),
        )
      }
      body
    }
    touying-slide(self: self, config: config, content)
  },
)


/// Touying stargazer theme.
///
/// Example:
///
/// ```typst
/// #show: stargazer-theme.with(aspect-ratio: "16-9", config-colors(primary: blue))`
/// ```
///
/// Consider using:
///
/// ```typst
/// #set text(font: "Fira Sans", weight: "light", size: 20pt)`
/// #show math.equation: set text(font: "Fira Math")
/// #set strong(delta: 100)
/// #set par(justify: true)
/// ```
/// The default colors:
///
///
/// ```typst
/// config-colors(
///   primary: rgb("#005bac"),
///   primary-dark: rgb("#004078"),
///   secondary: rgb("#ffffff"),
///   tertiary: rgb("#005bac"),
///   neutral-lightest: rgb("#ffffff"),
///   neutral-darkest: rgb("#000000"),
/// )
/// ```
///
/// - aspect-ratio (string): is the aspect ratio of the slides. The default is `16-9`.
///
/// - align (alignment): is the alignment of the content. The default is `horizon`.
///
/// - title (content, function): is the title in the header of the slide. The default is `self => utils.display-current-heading(depth: self.slide-level)`.
///
/// - header-right (content, function): is the right part of the header. The default is `self => self.info.logo`.
///
/// - footer (content, function): is the footer of the slide. The default is `none`.
///
/// - footer-right (content, function): is the right part of the footer. The default is `context utils.slide-counter.display() + " / " + utils.last-slide-number`.
///
/// - progress-bar (boolean): is whether to show the progress bar in the footer. The default is `true`.
///
/// - footer-columns (array): is the columns of the footer. The default is `(25%, 25%, 1fr, 5em)`.
///
/// - footer-a (content, function): is the left part of the footer. The default is `self => self.info.author`.
///
/// - footer-b (content, function): is the second left part of the footer. The default is `self => utils.display-info-date(self)`.
///
/// - footer-c (content, function): is the second right part of the footer. The default is `self => if self.info.short-title == auto { self.info.title } else { self.info.short-title }`.
///
/// - footer-d (content, function): is the right part of the footer. The default is `context utils.slide-counter.display() + " / " + utils.last-slide-number`.
// 主题入口：在文档顶端使用 `#show: stargazer-theme.with(..)` 传入参数即可全局生效。
// 常用可调项：
// - aspect-ratio: 版面比例，如 "16-9" / "4-3"。
// - align: 默认内容对齐方式（影响大多数 slide）。
// - alpha: 目录渐显透明度。
// - title/header-right/footer-* : 页眉页脚四列内容，支持传函数 self => .. 或固定文本。
// - progress-bar: 是否显示底部进度条。
// - footer-columns: 页脚四列宽度分配。
// 如需改色，推荐在文档中调用 `config-colors(...)` 覆盖默认配色。
#let stargazer-theme(
  aspect-ratio: "16-9",
  align: horizon,
  alpha: 20%,
  title: self => utils.display-current-heading(depth: self.slide-level),
  header-right: self => self.info.logo,
  progress-bar: true,
  footer-columns: (25%, 25%, 1fr, 5em),
  footer-a: self => self.info.author,
  footer-b: self => utils.display-info-date(self),
  footer-c: self => if self.info.short-title == auto {
    self.info.title
  } else {
    self.info.short-title
  },
  footer-d: context utils.slide-counter.display() + " / " + utils.last-slide-number,
  ..args,
  body,
) = {
  // 页眉：上方导航 + 自定义标题区域，可在下方 block 调整渐变、文字大小与内边距。
  let header(self) = {
    set std.align(top)
    grid(
      rows: (auto, auto),
      utils.call-or-display(self, self.store.navigation),
      utils.call-or-display(self, self.store.header),
    )
  }
  let footer(self) = {
    // 页脚：两行布局，第一行放 footer-a/b/c/d，第二行可选进度条。
    set text(size: .5em)
    set std.align(center + bottom)
    grid(
      rows: (auto, auto),
      utils.call-or-display(self, self.store.footer),
      if self.store.progress-bar {
        utils.call-or-display(
          self,
          components.progress-bar(
            height: 2pt,
            self.colors.primary, // 进度条颜色
            self.colors.neutral-lightest,
          ),
        )
      },
    )
  }

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header: header,
      footer: footer,
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 3.5em, bottom: 2.5em, x: 2.5em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        // 默认页背景：应用校背景图，可被单页覆盖。
        set page(background: self.store.background)
        // 全局字号/列表/引用样式，可在此统一替换字体或标题颜色。
        set text(size: 20pt)
        set list(marker: components.knob-marker(primary: self.colors.primary))
        show figure.caption: set text(size: 0.6em)
        show footnote.entry: set text(size: 0.6em)
        //show strong: self.methods.alert.with(self: self)
        show heading: set text(fill: self.colors.primary)
        show link: it => if type(it.dest) == str {
          set text(fill: self.colors.primary)
          it
        } else {
          it
        }
        show figure.where(kind: table): set figure.caption(position: top)

        body
      },
      alert: (self: none, it) => text(fill: self.colors.tertiary, it), // 修改全局强调颜色
      //alert: utils.alert-with-primary-color,
      tblock: _tblock,
    ),
    config-colors(
      primary: rgb("#005bac"),
      primary-dark: rgb("#004078"),
      secondary: rgb("#ffffff"),
      tertiary: rgb("#005bac"),
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    // 存储主题级参数，供各 slide 读取；如需全局调整页眉/页脚内容可修改这里或通过 with(...) 传参。
    config-store(
      align: align,
      alpha: alpha,
      title: title,
      header-right: header-right,
      progress-bar: progress-bar,
      footer-columns: footer-columns,
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
      footer-d: footer-d,
      background: /* */ image(
        "njubackground.png",
        width: 100%,
        height: 100%,
        fit: "cover",
      ),
      navigation: self => components.simple-navigation(
        self: self,
        primary: white,
        secondary: gray,
        background: self.colors.primary,
        //background: self.colors.neutral-darkest,
        logo: utils.call-or-display(self, self.store.header-right),
      ),
      // 页眉背景条：可改 gradient 颜色、文本大小、左右边距。
      header: self => if self.store.title != none {
        block(
          width: 100%,
          height: 1.8em,
          fill: gradient.linear(
            self.colors.primary,
            self.colors.neutral-darkest,
          ),
          place(
            left + horizon,
            text(
              fill: self.colors.neutral-lightest,
              weight: "bold",
              size: 1.3em,
              utils.call-or-display(self, self.store.title),
            ),
            dx: 1.5em,
          ),
        )
      },
      // 页脚四格：通过 footer-a/b/c/d 决定显示内容；如需改配色或留白，在此修改 cell fill/尺寸。
      footer: self => {
        let cell(fill: none, it) = rect(
          width: 100%,
          height: 100%,
          inset: 1mm,
          outset: 0mm,
          fill: fill,
          stroke: none,
          std.align(horizon, text(fill: self.colors.neutral-lightest, it)),
        )
        grid(
          columns: self.store.footer-columns,
          rows: (1.5em, auto),
          cell(fill: self.colors.neutral-darkest, utils.call-or-display(
            self,
            self.store.footer-a,
          )),
          cell(fill: self.colors.neutral-darkest, utils.call-or-display(
            self,
            self.store.footer-b,
          )),
          cell(fill: self.colors.primary, utils.call-or-display(
            self,
            self.store.footer-c,
          )),
          cell(fill: self.colors.primary, utils.call-or-display(
            self,
            self.store.footer-d,
          )),
        )
      },
    ),
    ..args,
  )

  body
}
