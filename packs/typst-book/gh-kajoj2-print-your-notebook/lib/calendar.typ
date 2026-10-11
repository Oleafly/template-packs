// Calendar: names in the insert's language (lib/i18n.typ), ISO 8601 weeks, weeks starting
// on Monday or Sunday ([calendar] week_start).
// datetime.display() only knows English names, hence the tables in i18n.typ.

#import "config.typ": cfg
#import "i18n.typ": L

#let months = L.months
#let months-gen = L.months-gen
#let months-short = L.months-short
// from Monday, index = weekday() - 1
#let weekdays = L.weekdays
#let weekdays-short = L.weekdays-short
#let weekdays-letter = L.weekdays-letter

#assert(cfg.week-start in ("monday", "sunday"), message: "calendar.week_start: monday | sunday")
#let sunday-first = cfg.week-start == "sunday"
// days in column order (calendar headers): weekday() 1..7
#let _order = if sunday-first { (7, 1, 2, 3, 4, 5, 6) } else { range(1, 8) }
#let days-short = _order.map(i => weekdays-short.at(i - 1))
#let days-letter = _order.map(i => weekdays-letter.at(i - 1))
// column of a day in a calendar week: 0..6
#let day-column(d) = if sunday-first { calc.rem(d.weekday(), 7) } else { d.weekday() - 1 }

#let date(y, m, d) = datetime(year: y, month: m, day: d)
#let add-days(d, n) = d + duration(days: n)

#let capitalize(s) = upper(s.clusters().first()) + s.clusters().slice(1).join()

#let month-name(m) = months.at(m - 1)
#let month-gen(m) = months-gen.at(m - 1)
#let weekday-name(d) = weekdays.at(d.weekday() - 1)

// "16 września 2026" / "16 September 2026"
#let format-date(d, year: true) = {
  str(d.day()) + " " + month-gen(d.month()) + if year { " " + str(d.year()) } else { "" }
}

#let is-leap(y) = calc.rem(y, 4) == 0 and (calc.rem(y, 100) != 0 or calc.rem(y, 400) == 0)

#let days-in-month(y, m) = {
  let next = if m == 12 { date(y + 1, 1, 1) } else { date(y, m + 1, 1) }
  int((next - date(y, m, 1)).days())
}

// Monday of the week containing d.
#let week-start(d) = add-days(d, 1 - d.weekday())

// First day of the calendar week (Monday, or the Sunday before it)
// for the ISO week starting on Monday `monday`.
#let first-day(monday) = if sunday-first { add-days(monday, -1) } else { monday }

#let iso-weeks-in-year(y) = {
  let jan1 = date(y, 1, 1).weekday()
  if jan1 == 4 or (jan1 == 3 and is-leap(y)) { 53 } else { 52 }
}

// ISO week number (week 1 contains the first Thursday of the year).
#let iso-week(d) = {
  let w = calc.floor((d.ordinal() - d.weekday() + 10) / 7)
  if w < 1 { iso-weeks-in-year(d.year() - 1) } else if w > iso-weeks-in-year(d.year()) { 1 } else { w }
}

// Mondays of all ISO weeks of a year.
#let iso-week-mondays(y) = {
  let first = week-start(date(y, 1, 4))
  range(iso-weeks-in-year(y)).map(i => add-days(first, 7 * i))
}

// Weeks of a month: an array of weeks, each with 7 items (datetime or none).
#let month-weeks(y, m) = {
  let n = days-in-month(y, m)
  let lead = day-column(date(y, m, 1))
  let cells = (none,) * lead + range(1, n + 1).map(d => date(y, m, d))
  let tail = calc.rem(7 - calc.rem(cells.len(), 7), 7)
  (cells + (none,) * tail).chunks(7)
}

// ISO week number of the calendar row containing d: with Sunday-first weeks,
// a Sunday belongs to the week of the Monday that follows it.
#let week-number(d) = iso-week(if sunday-first and d.weekday() == 7 { add-days(d, 1) } else { d })
