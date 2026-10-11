#set page(flipped: false, margin: 2cm)
#set text(font: "DejaVu Sans", size: 12pt)
#let cell_size = 25pt
#let year = 2026
#let prazniki = (
  datetime(day: 1, month: 1, year: year),
  datetime(day: 2, month: 1, year: year),
  datetime(day: 8, month: 2, year: year),
  datetime(day: 5, month: 4, year: year), //velikonočna nedelja
  datetime(day: 6, month: 4, year: year), //velika noč
  datetime(day: 27, month: 4, year: year),
  datetime(day: 1, month: 5, year: year),
  datetime(day: 2, month: 5, year: year),
  datetime(day: 24, month: 5, year: year), //binkošti
  datetime(day: 25, month: 6, year: year),
  datetime(day: 15, month: 8, year: year),
  datetime(day: 31, month: 10, year: year),
  datetime(day: 1, month: 11, year: year),
  datetime(day: 25, month: 12, year: year),
  datetime(day: 26, month: 12, year: year),
)
#let delovna_sobota = datetime(day: 21, month: 3, year: year)

#let month-names = (
  "JANUAR",
  "FEBRUAR",
  "MAREC",
  "APRIL",
  "MAJ",
  "JUNIJ",
  "JULIJ",
  "AVGUST",
  "SEPTEMBER",
  "OKTOBER",
  "NOVEMBER",
  "DECEMBER ",
)
#let day-names = ("P", "T", "S", "Č", "P", "S", "N")

#let weekday-label(i) = [#day-names.at(i - 1)]

// Ali je leto prestopno?
#let prestopno(leto) = (calc.rem(year, 4) == 0 and calc.rem(year, 100) != 0) or calc.rem(year, 400) == 0

// Function to get the number of days in a month
#let days-in-month(year, month) = {
  if month == 2 {
    if prestopno(year) { 29 } else { 28 }
  } else if month in (4, 6, 9, 11) { 30 } else { 31 }
}

#let day-at(x, y, first_monday) = {
  let dur = duration(days: x * 7 + y - 1)
  first_monday + dur
}

#let monday-before(day) = {
  day - duration(days: day.weekday() - 1)
}

#let sunday-after(day) = {
  day + duration(days: 7 - day.weekday())
}

// Find the first day in the month that is given weekday
#let first-weekday(weekday, month, year) = {
  let first = datetime(day: 1, month: month, year: year)
  let weekday_first = first.weekday()
  if weekday_first == weekday { first } else {
    let days = if (weekday > weekday_first) { weekday - weekday_first } else { 7 + weekday - weekday_first }
    first + duration(days: days)
  }
}

#let first-monday(month, year) = first-weekday(1, month, year)

#let month-header(month) = [#month-names.at(month - 1)]

#let next-month(day) = {
  if (day.month() == 12) {
    datetime(day: day.day(), month: 1, year: day.year() + 1)
  } else {
    datetime(day: day.day(), month: day.month() + 1, year: day.year())
  }
}

#let month-headers(start, end) = {
  let first_monday = monday-before(start)
  let current_day = start
  let headers = ([],)
  while (current_day < end) {
    let next_month = next-month(current_day)
    let next_monday = first-monday(next_month.month(), next_month.year())
    let span = calc.floor((next_monday - first_monday).weeks())
    first_monday = next_monday
    headers.push(table.cell(colspan: span, month-header(current_day.month())))
    current_day = next_month
  }
  table.header(..headers)
}

#let week-index(first_monday, day) = calc.quo((day - first_monday).days(), 7)

#let xy-coords(day, first_monday) = {
  (x: week-index(first_monday, day), y: day.weekday())
}

#let month-separators(start, end) = {
  let first_monday = monday-before(start)
  let last_sunday = sunday-after(end)
  let year = start.year()
  let current = start
  let separators = array(())
  while (current < last_sunday) {
    let month = current.month()
    let year = current.year()
    let first_in_month = datetime(day: 1, month: month, year: year)
    let (x, y) = xy-coords(first_in_month, first_monday)
    separators.push(
      (table.hline(y: y, start: x + 1, end: x + 2, stroke: 1.5pt + black),)
        + range(1, 8).map(weekday => {
          let first_day = first-weekday(weekday, month, year)
          let (x, y) = xy-coords(first_day, first_monday)
          table.vline(x: x + 1, start: weekday + 0, end: weekday + 1, stroke: 1.5pt + black)
        }),
    )
    current = next-month(current)
  }
  separators.flatten()
}

#let format-day(day, start, end) = {
  if ((day > end) or (day < start)) { [] } else {
    if (prazniki.find(d => (d == day)) != none) {
      table.cell(fill: rgb("#898989"))[#day.day()]
    } else {
      if (day == delovna_sobota) {
        table.cell(fill: rgb("#fff"))[#day.day()]
      } else {
        [#day.day()]
      }
    }
  }
}
// display a table of days from start to end
#let days-table(start, end) = {
  let days = (end - start).days()
  let first_monday = monday-before(start)
  let last_sunday = sunday-after(end)
  let weeks = calc.quo(((last_sunday - first_monday).days() + 1), 7)
  let result = (
    monday: first_monday,
    sunday: last_sunday,
    weeks: weeks,
  )
  let rows = range(1, 8)
    .map(i => {
      (
        (weekday-label(i),)
          + range(0, weeks).map(x => {
            let day = day-at(x, i, first_monday)
            format-day(day, start, end)
          })
      )
    })
    .flatten()
  table(
    columns: (cell_size, ..(cell_size,) * (weeks)),
    rows: (auto, ..(cell_size,) * 7),
    align: center + horizon,
    stroke: 0.3pt + gray,
    fill: (x, y) => if y >= 6 { rgb("#d4d4d4") },
    // Shade weekends
    month-headers(start, end),
    ..month-separators(start, end),
    ..rows,
  )
}

#let year = 2026

= Koledar #year

#v(1cm)
#days-table(datetime(day: 1, month: 1, year: year), datetime(day: 30, month: 4, year: year))
#v(2em)
#days-table(datetime(day: 1, month: 5, year: year), datetime(day: 31, month: 8, year: year))
#v(2em)
#days-table(datetime(day: 1, month: 9, year: year), datetime(day: 31, month: 12, year: year))
