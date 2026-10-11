#import "../utils/style.typ": 字号, 字体

// 太原理工大学实验/实践报告 — 封面页
#let cover(
  is-practice: false,
  show-day: true,
  fonts: (:),
  info: (:),
  university-logo: none,
) = {
  // ============================================================
  // 1. 默认参数
  // ============================================================
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

  // ============================================================
  // 2. 参数处理
  // ============================================================
  // (本封面页参数无需额外处理)

  // ============================================================
  // 3. 内置辅助函数
  // ============================================================
  let info-label(body) = {
    text(font: fonts.黑体, size: 字号.三号, body)
  }

  let info-value(body) = {
    text(font: fonts.宋体, size: 字号.三号, body)
  }

  // 下划线字段行：左列标签(右对齐) + 右列下划线框(内容居中)
  // 用法: field-row([课程名称：], [#info.course-name])
  let field-row(label, value) = {
    (
      align(right + horizon, info-label(label)),
      box(
        width: 100%,
        stroke: (bottom: 0.5pt),
        outset: (y: 0.15em),
        align(center + horizon, info-value(value)),
      ),
    )
  }

  // 复选框原生绘制（避免 Unicode ☑/□ 被渲染为 Emoji）
  // 使用 Typst 原生 box(stroke:) 绘框，框内渲染非 emoji 的 ✓ (U+2713) 打勾
  let cb-size = 1em
  let cb-unchecked = box(
    stroke: 0.6pt,
    width: cb-size,
    height: cb-size,
    inset: 0pt,
  )
  let cb-checked = box(
    stroke: 0.6pt,
    width: cb-size,
    height: cb-size,
    inset: 0pt,
    align(center + horizon, text(size: 0.65em)[✓]),
  )

  // ============================================================
  // 4. 正式渲染
  // ============================================================

  pagebreak(weak: true)
  set page(numbering: none)
  set align(center)

  // 用 block(height: 100%) + v(1fr) 推满整页：
  //   - 学校名/logo 占 ~1/5 高度
  //   - checkbox 字号略大于字段
  //   - 字段区域自然流排
  //   - v(1fr) 将日期推至页面底部
  //   - 日期右对齐，恰好落在右下角
  block(height: 100%, width: 100%, {
    // ── 学校名 / Logo（约占 1/5 页面高度）──
    if university-logo != none {
      align(center + horizon, image(university-logo, height: 45mm))
    } else {
      text(font: fonts.黑体, size: 字号.小初, weight: "bold")[太原理工大学]
    }

    v(1.5em)

    // ── Checkbox 行 — 字号.二号（略大于字段行）──
    text(font: fonts.黑体, size: 字号.二号, {
      if is-practice {
        cb-unchecked + [实验报告] + h(1em) + cb-checked + [实践报告]
      } else {
        cb-checked + [实验报告] + h(1em) + cb-unchecked + [实践报告]
      }
    })

    v(2em)

    // ── 字段区域：两列表格 ──
    // 左列 6em（右对齐标签），右列 1fr（下划线 + 居中值）
    grid(
      columns: (6em, 1fr),
      column-gutter: 0pt,
      row-gutter: 0.5em,
      ..field-row([课程名称：], [#info.course-name]),
      ..field-row([实验名称：], [#info.experiment-name]),
      ..field-row([地点：], [#info.location]),
      ..field-row([专业班级：], [#info.class-name]),
      ..field-row([学号：], [#info.student-id]),
      ..field-row([学生姓名：], [#info.student-name]),
      ..field-row([指导老师：], [#info.supervisor]),
    )

    // ── 弹性空白：将日期推至底部 ──
    v(1fr)

    // ── 日期行 — 右下角，字号与字段行相同（三号）──
    align(right, {
      let date-content = if show-day {
        [#(info.year)年#(info.month)月#(info.day)日]
      } else {
        [#(info.year)年#(info.month)月]
      }
      info-value(date-content)
    })
  })
}
