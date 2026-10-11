// 設定ファイル
#import "../settings.typ": *

#heading(numbering: none)[記号表]

// 英語のアルファベット順で並べる
#table(
  columns: (1fr, 3fr),
  stroke: none,
  align: left,
  table.header(
    table.cell[#text(font: sans-font, weight: "bold")[Alphabet]],
  ),
  [$d$], [Channel width [$#dimension[L]$]],
  [$L_j$], [Computational domain size in $j$-direction [$#dimension[L]$]],
  [$N_j$], [Number of grid points in $j$-direction],
  [$Re$], [Reynolds number, $= u d slash nu$ [-]],
  [$u$], [Velocity [$#dimension[L / T]$]],
)

#v(8mm)

// ギリシャ語のアルファベット順で並べる
#table(
  columns: (1fr, 3fr),
  stroke: none,
  align: left,
  table.header(
    table.cell[#text(font: sans-font, weight: "bold")[Greek]],
  ),
  [$delta$], [Channel half width [$#dimension[L]$]],
  [$epsilon_(i j k)$], [Levi--Civita symbol],
  [$nu$], [Kinematic viscosity [$#dimension[L^2 / T]$]],
)

#v(8mm)

// 上付き添え字
#table(
  columns: (1fr, 3fr),
  stroke: none,
  align: left,
  table.header(
    table.cell[#text(font: sans-font, weight: "bold")[Superscripts]],
  ),
  [$(quad)^*$], [Normalized by outer variables, e.g., $delta$],
  [$(quad)^+$], [Normalized by inner variables, e.g., $nu slash u_tau$ (wall unit)],
  [$(quad)^prime$], [Fluctuation component],
  [$overline((quad))$], [Statistically averaged],
)

#v(8mm)

// 下付き添え字
#table(
  columns: (1fr, 3fr),
  stroke: none,
  align: left,
  table.header(
    table.cell[#text(font: sans-font, weight: "bold")[Subscripts]],
  ),
  [$(quad)_rms$], [Root mean square],
  [$(quad)_("w")$], [Wall],
  [$(quad)_tau$], [Wall unit],
)

#v(8mm)

// 略語をアルファベット順で並べる
#table(
  columns: (1fr, 3fr),
  stroke: none,
  align: left,
  table.header(
    table.cell[#text(font: sans-font, weight: "bold")[Abbreviations]],
  ),
  [CFD], [Computational fluid dynamics],
  [DNS], [Direct numerical simulation],
  [LES], [Large eddy simulation],
)

