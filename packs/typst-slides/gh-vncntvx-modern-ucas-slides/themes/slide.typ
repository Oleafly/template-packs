#import "@preview/touying:0.8.0": *
#import "./footer.typ": render-footer
#import "./header.typ": render-header
#import "./preamble.typ": render-subslide-preamble

// 幻灯片页面函数
#let slide(
  title: auto,
  subtitle: none,
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
  self.store.subtitle = subtitle

  self = utils.merge-dicts(
    self,
    config-common(
      subslide-preamble: render-subslide-preamble,
    ),
    config-page(
      header: render-header,
      footer: render-footer,
    ),
    config,
  )

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

// 演讲者备注面板
#let notes(self: none, ..args) = touying-notes(
  self: self,
  header: self => pad(x: 1em, y: 0.8em, text(
    fill: self.colors.neutral-lightest,
    utils.display-current-heading(depth: self.slide-level),
  )),
  header-fill: self.colors.primary,
  fill: self.colors.neutral-lightest,
  ..args,
)
