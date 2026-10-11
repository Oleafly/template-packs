// lib/acara.typ
// Layout Bagian VIII: Susunan Acara Proposal WRI

#let render-susunan-acara(rundown) = {
  [Susunan Acara dari kegiatan ini adalah :]
  v(8pt)

  let cells = ()
  for hari in rundown {
    let count = hari.sesi.len()
    for (idx, s) in hari.sesi.enumerate() {
      if idx == 0 {
        cells.push(table.cell(rowspan: count, align: center + horizon)[#hari.hari-tanggal])
      }
      cells.push(table.cell(align: center + horizon)[#s.waktu])
      cells.push(table.cell(align: center + horizon)[#s.acara])
    }
  }

  table(
    columns: (3.74cm, 3.50cm, 7.25cm),
    rows: (36.0pt,),
    align: center + horizon,
    stroke: 0.5pt,
    inset: (x: 5pt, y: 5.5pt),
    table.header(
      align(center + horizon)[*Hari, tanggal*],
      align(center + horizon)[*Waktu*],
      align(center + horizon)[*Acara*]
    ),
    ..cells
  )
}
