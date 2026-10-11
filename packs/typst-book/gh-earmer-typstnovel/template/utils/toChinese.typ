#let num_to_chinese(num:0, style:"simplified")  = {
  let simplified_digits = ("零", "一", "二", "三", "四", "五", "六", "七", "八", "九")
  let traditional_digits = ("零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖")
  let units = ("", "十", "百", "千", "万", "亿", "兆", "京", "垓", "秭", "穰", "沟", "涧", "正", "载", "极")
  let traditional_units = ("", "拾", "佰", "仟", "萬", "億", "兆", "京", "垓", "秭", "穰", "溝", "澗", "正", "載", "極")

  if style == "simp" or style == "简体"  {
    style = "simplified"
  }
  else if style == "trad" or style == "繁体" {
    style = "traditional"
  } else {
    style = "simplified"
  }
  
  let digits = if style == "simplified" { simplified_digits } else { traditional_digits }

  let result = ""
  let num_str = str(num)
  // type(num_str)
  let len = num_str.len()
  let i = 0

  while i < len {
    let digit = int(num_str.at(i))
    let unit = 0
    unit = units.at(len - i - 1)
    if digit != 0 and i < len - 1 {
      result += digits.at(digit) + unit
    } else{
      if len == 1 and digit == 0 {
        result += digits.at(digit)
      }
      if digit != 0 {
        result += digits.at(digit)
      }
    }
    
    i += 1
  }

  result
}
#let date_to_chinese(date: datetime.today(), style: "simplified") = {
  let year = str(date.year())
  let month = str(date.month())
  let day = str(date.day())

  if style == "num" {
    return year + "年" + month + "月" + day + "日"
  }

  let year_chinese = ""
  for c in year {
    year_chinese += num_to_chinese(num: c, style:style)
  }
  let month_chinese = num_to_chinese(num: month, style:style)
  let day_chinese = num_to_chinese(num: day, style:style)

  year_chinese + "年" + month_chinese + "月" + day_chinese + "日"
}

