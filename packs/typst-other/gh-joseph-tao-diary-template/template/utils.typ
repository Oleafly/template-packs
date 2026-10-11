// yyyymmdd to datetime
#let split-date(date-str) = {
  assert(
    date-str.len() == 8,
    message: "date should have format \"yyyymmdd\""
  )
  let y = int(date-str.slice(0, 4))
  let m = int(date-str.slice(4, 6))
  let d = int(date-str.slice(6, 8))
  return datetime(year: y, month: m, day: d)
}

// datetime to formatted chinese
#let date-fmt-raw(date-packed) = {
  let num-tab = (
    "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九",
    "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九",
    "二十", "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九",
    "三十", "三十一"
  )
  let y = ""
  for i in str(date-packed.year()) {
    y += num-tab.at(int(i))
  }
  y += "年"
  let m = num-tab.at(date-packed.month()) + "月"
  let d = num-tab.at(date-packed.day()) + "日"
  return (y, m, d)
}

#let date-fmt(date-str) = {
  let date-packed = split-date(date-str)
  let date-raw = date-fmt-raw(date-packed)
  return (date-raw.at(1) + date-raw.at(2))
}

#let ref-date-fmt(date-str-dst, date-str-src) = {
  let date-dst = split-date(date-str-dst)
  let date-src = split-date(date-str-src)
  let (year-dst, year-src) = (date-dst.year(), date-src.year())
  let (y, m, d) = date-fmt-raw(date-dst)
  if (year-dst - year-src == 0) {
    y = ""
  } else if (year-dst - year-src == -1) {
    y = "去年"
  } else if (year-dst - year-src == -2) {
    y = "前年"
  }
  return y + m + d
}