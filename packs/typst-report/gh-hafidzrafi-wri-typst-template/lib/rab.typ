// lib/rab.typ
// Engine otomatisasi kalkulasi Rencana Anggaran Biaya (RAB) Proposal WRI

#import "terbilang.typ": terbilang-rupiah, format-rupiah

#let format-angka(n) = {
  let s = str(int(n))
  let len = s.len()
  let res = ""
  for i in range(len) {
    if i > 0 and calc.rem(len - i, 3) == 0 {
      res += "."
    }
    res += s.at(i)
  }
  res + ",00"
}

#let hitung-subtotal(items) = {
  let total = 0
  for item in items {
    total += item.jumlah
  }
  total
}

#let hitung-total-pengeluaran(pengeluaran) = {
  let total = 0
  for (sie, items) in pengeluaran {
    total += hitung-subtotal(items)
  }
  total
}

#let hitung-total-sumber-dana(sumber-dana) = {
  let total = 0
  for item in sumber-dana {
    if item.at("rincian", default: none) != none {
      for r in item.rincian {
        total += r.jumlah
      }
    } else {
      total += item.jumlah
    }
  }
  total
}

#let render-sumber-dana(sumber-dana) = {
  let total = hitung-total-sumber-dana(sumber-dana)
  let rows = ()
  for (idx, item) in sumber-dana.enumerate() {
    if item.at("rincian", default: none) != none {
      rows.push(str(idx + 1) + ".")
      rows.push(item.uraian)
      rows.push("")
      for r in item.rincian {
        rows.push("")
        rows.push(pad(left: 14pt)[\- #r.uraian])
        rows.push(format-angka(r.jumlah))
      }
    } else {
      rows.push(str(idx + 1) + ".")
      rows.push(item.uraian)
      rows.push(format-angka(item.jumlah))
    }
  }

  table(
    columns: (1.20cm, 9.30cm, 4.00cm),
    align: (center + horizon, left + horizon, right + horizon),
    stroke: 0.5pt,
    inset: (x: 5pt, y:8pt),
    table.header(
      align(center + horizon)[*No.*],
      align(center + horizon)[*Uraian*],
      align(center + horizon)[*Jumlah (Rp)*]
    ),
    ..rows,
    table.cell([]),
    table.cell(align: center + horizon)[*TOTAL*],
    table.cell(align: right + horizon)[*#format-angka(total)*]
  )
}

#let render-pengeluaran-sie(pengeluaran, sie-names: none, sie-offset: 1) = {
  let sie-idx = sie-offset
  for (sie-name, items) in pengeluaran {
    if sie-names == none or sie-name in sie-names {
      let subtotal = hitung-subtotal(items)
      v(8pt)
      text(weight: "bold")[#str(sie-idx). #sie-name]
      v(4pt)
      table(
        columns: (1.20cm, 9.30cm, 4.00cm),
        align: (center + horizon, left + horizon, right + horizon),
        stroke: 0.5pt,
        inset: (x: 5pt, y:8pt),
        table.header(
          align(center + horizon)[*No.*],
          align(center + horizon)[*Uraian*],
          align(center + horizon)[*Jumlah (Rp)*]
        ),
        ..for (idx, item) in items.enumerate() {
          (
            str(idx + 1) + ".",
            item.uraian,
            format-angka(item.jumlah)
          )
        },
        table.cell([]),
        table.cell(align: center + horizon)[*TOTAL*],
        table.cell(align: right + horizon)[*#format-angka(subtotal)*]
      )
      sie-idx += 1
    }
  }
}

#let render-rekapitulasi(pengeluaran) = {
  let total = hitung-total-pengeluaran(pengeluaran)
  table(
    columns: (1.20cm, 9.30cm, 4.00cm),
    align: (center + horizon, left + horizon, right + horizon),
    stroke: 0.5pt,
    inset: (x: 5pt, y:8pt),
    table.header(
      align(center + horizon)[*No.*],
      align(center + horizon)[*Uraian*],
      align(center + horizon)[*Jumlah (Rp)*]
    ),
    ..for (idx, (sie-name, items)) in pengeluaran.pairs().enumerate() {
      let subtotal = hitung-subtotal(items)
      (
        str(idx + 1) + ".",
        sie-name,
        format-angka(subtotal)
      )
    },
    table.cell([]),
    table.cell(align: center + horizon)[*TOTAL*],
    table.cell(align: right + horizon)[*#format-angka(total)*]
  )
}
