// 本表数据由同目录的 measurements.csv 维护。
#let rows = csv("measurements.csv")
#let fields = ("sample", "baseline_score", "gabor_score", "adaptive_score", "adaptive_time_ms")
#assert(rows.len() > 1 and rows.first() == fields, message: "measurements.csv 须包含规定表头与至少一条样本记录")
#let samples = rows.slice(1)
#assert(samples.all(row => row.len() == fields.len()), message: "每条样本记录须包含五列")
#assert(samples.map(row => row.first()).dedup().len() == samples.len(), message: "样本标识须唯一")
#assert(samples.all(row => range(1, 4).all(i => {
  let value = float(row.at(i))
  value >= 0 and value <= 1
})), message: "质量分数须在 0–1 之间")
#assert(samples.all(row => float(row.last()) >= 0), message: "耗时不可为负数")
#let measurements = table(
  columns: (1fr, 1fr, 1fr, 1fr, 1.4fr),
  align: center + horizon,
  table.header([样本], [原始分数], [Gabor 分数], [自适应分数], [自适应耗时（ms）]),
  ..samples.flatten(),
)
