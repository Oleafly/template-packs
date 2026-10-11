#let roman-unicode(..nums) = {
  let values = (
    (100000, "ↈ"), (50000, "ↇ"), (10000, "ↂ"), (5000, "ↁ"),
    (1000, "Ⅿ"),
    (900, "ⅭⅯ"), (500, "Ⅾ"), (400, "ⅭⅮ"),
    (100, "Ⅽ"),
    (90, "ⅩⅭ"), (50, "Ⅼ"), (40, "ⅩⅬ"),
    (10, "Ⅹ"),
    (9, "ⅠⅩ"), (5, "Ⅴ"), (4, "ⅠⅤ"),
    (1, "Ⅰ"),
  )
  let result = ""
  let rem = nums.pos().first()
  for (val, sym) in values {
    while rem >= val {
      result += sym
      rem -= val
    }
  }
  result.replace("ⅩⅠ", "Ⅺ").replace("ⅩⅡ", "Ⅻ")
}
