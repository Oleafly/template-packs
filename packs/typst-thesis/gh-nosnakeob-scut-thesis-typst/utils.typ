// 工具函数集合

// 固定长度下划线
#let fix_underline_wh = state("fix_ul", (width: auto, height: auto))

#let fix_underline(body) = context {
  rect(
    body, 
    ..fix_underline_wh.get(), 
    inset: 0.45cm, 
    stroke: (bottom: 0.5pt)
  )
}

// 两端对齐字符串（用于封面等）
#let justify_str(text) = {
  let chars = text.trim().split("").slice(1, -1)
  chars.join(h(1fr))
}

// 空行（垂直间距）
#let empty_line(cnt, size: -1em) = context {
  let s = if size == -1em { text.size } else { size }
  v(1em * cnt)
}

// 中文破折号
#let cndash = [——]

// 三线表辅助函数
#let top-line = table.hline.with(stroke: 1.5pt)    // 顶线
#let mid-line = table.hline.with(stroke: 0.75pt)   // 中线
#let bottom-line = table.hline.with(stroke: 1.5pt) // 底线
