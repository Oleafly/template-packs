// lib/terbilang.typ
// Pure Typst Indonesian number-to-words converter for Rupiah currency

#let satuan = (
  "", "Satu", "Dua", "Tiga", "Empat", "Lima",
  "Enam", "Tujuh", "Delapan", "Sembilan", "Sepuluh", "Sebelas"
)

#let eja-angka(n) = {
  let n = int(n)
  if n < 0 {
    "Minus " + eja-angka(-n)
  } else if n < 12 {
    satuan.at(n)
  } else if n < 20 {
    eja-angka(n - 10) + " Belas"
  } else if n < 100 {
    let p = calc.floor(n / 10)
    let s = calc.rem(n, 10)
    satuan.at(p) + " Puluh" + if s > 0 { " " + eja-angka(s) } else { "" }
  } else if n < 200 {
    let s = n - 100
    "Seratus" + if s > 0 { " " + eja-angka(s) } else { "" }
  } else if n < 1000 {
    let r = calc.floor(n / 100)
    let s = calc.rem(n, 100)
    satuan.at(r) + " Ratus" + if s > 0 { " " + eja-angka(s) } else { "" }
  } else if n < 2000 {
    let s = n - 1000
    "Seribu" + if s > 0 { " " + eja-angka(s) } else { "" }
  } else if n < 1000000 {
    let rb = calc.floor(n / 1000)
    let s = calc.rem(n, 1000)
    eja-angka(rb) + " Ribu" + if s > 0 { " " + eja-angka(s) } else { "" }
  } else if n < 1000000000 {
    let jt = calc.floor(n / 1000000)
    let s = calc.rem(n, 1000000)
    eja-angka(jt) + " Juta" + if s > 0 { " " + eja-angka(s) } else { "" }
  } else if n < 1000000000000 {
    let m = calc.floor(n / 1000000000)
    let s = calc.rem(n, 1000000000)
    eja-angka(m) + " Miliar" + if s > 0 { " " + eja-angka(s) } else { "" }
  } else {
    str(n)
  }
}

#let terbilang-rupiah(n) = {
  if int(n) == 0 {
    "Nol Rupiah"
  } else {
    eja-angka(n) + " Rupiah"
  }
}

#let format-rupiah(n) = {
  let s = str(int(n))
  let len = s.len()
  let res = ""
  for i in range(len) {
    if i > 0 and calc.rem(len - i, 3) == 0 {
      res += "."
    }
    res += s.at(i)
  }
  "Rp" + res + ",00"
}
