#let today() = {
  let month = datetime.today().month()
  let day = datetime.today().day()
  let year = datetime.today().year()
  [#year 年 #month 月#day 日]
}

#let today_en() = {
  let month = (
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ).at(datetime.today().month() - 1)
  let day = datetime.today().day()
  let year = datetime.today().year()
  [#month #day, #year]
}
