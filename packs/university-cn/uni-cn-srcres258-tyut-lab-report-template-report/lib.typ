// 太原理工大学实验/实践报告模板 tyut-lab-report
// Author: https://github.com/MonodyTOT
// Repo: https://github.com/MonodyTOT/tyut-lab-report
// 在线模板可能不会更新得很及时，如果需要最新版本，请关注 Repo

#import "layouts/report.typ": doc, experiment, content-area, reset-page-number
#import "pages/cover.typ": cover
#import "pages/outline.typ": outline-page
#import "utils/style.typ": 字体, 字号

// 使用函数闭包特性，通过 `documentclass` 函数类进行全局信息配置，
// 然后暴露出拥有了全局配置的、具体的 `layouts` 和 `templates` 内部函数。
#let documentclass(
  is-practice: false,
  show-day: true,
  fonts: (:),
  info: (:),
  university-logo: none,
) = {
  // 合并默认参数
  fonts = 字体 + fonts

  info = (
    university: "太原理工大学",
    course-name: "待填写",
    experiment-name: "待填写",
    location: "待填写",
    class-name: "待填写",
    student-id: "待填写",
    student-name: "待填写",
    supervisor: "待填写",
    year: 2026,
    month: 1,
    day: 1,
  ) + info

  return (
    // 导出合并后的配置信息
    fonts: fonts,
    info: info,

    // 布局函数 — pre-bind fonts 和 info
    doc: doc.with(fonts: fonts, info: info),

    // 封面 — pre-bind 所有参数
    cover: cover.with(is-practice: is-practice, show-day: show-day, fonts: fonts, info: info, university-logo: university-logo),

    // 目录页 — pre-bind fonts
    outline-page: outline-page.with(fonts: fonts),

    // 实验页 — 不 pre-bind，用户显式传入 fonts:
    experiment: experiment,

    // 内容区 — pre-bind fonts
    content-area: content-area.with(fonts: fonts),

    // 页码重置 — 无需绑定
    reset-page-number: reset-page-number,
  )
}
