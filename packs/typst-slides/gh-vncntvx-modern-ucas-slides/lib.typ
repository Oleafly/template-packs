// modern-ucas-slides: 基于 Typst 的中国科学院大学学术幻灯片模板
// 基于 Touying 0.8.0 构建

#import "@preview/touying:0.8.0": *

// 主题与核心逻辑
#import "themes/colors.typ": ucas-colors
#import "themes/slide.typ": notes, slide
#import "themes/ucas.typ": ucas-theme

// 卡片与区块组件
#import "components/cards.typ": (
  alertblock, exampleblock, render-card, tblock, ucas-block,
)
#import "components/theorems.typ": proof, theorem
#import "components/callout.typ": callout

// 辅助样式与脚注
#import "components/helpers.typ": alert, blfootnote, green, red, structure

// 页面组件
#import "components/slides/ending.typ": ending-slide
#import "components/slides/outline.typ": outline-slide
#import "components/slides/section.typ": new-section-slide
#import "components/slides/title.typ": title-slide
