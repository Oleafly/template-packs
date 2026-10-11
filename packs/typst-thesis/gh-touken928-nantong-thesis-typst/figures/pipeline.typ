// 正文中导入 pipeline，再交给 fig 统一设置图题与编号。
#let pipeline = grid(
  columns: (3.3cm, auto, 3.3cm, auto, 3.3cm),
  column-gutter: 0.4cm,
  align: center + horizon,
  box(width: 100%, stroke: 0.5pt, inset: 7pt)[原始图像],
  [→],
  box(width: 100%, stroke: 0.5pt, inset: 7pt)[方向与频率估计],
  [→],
  box(width: 100%, stroke: 0.5pt, inset: 7pt)[滤波输出],
)
