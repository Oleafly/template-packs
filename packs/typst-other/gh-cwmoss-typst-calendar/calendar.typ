// create a 12 page calendar pdf for a year
// every page prints a monthly calendar with a picture and a list of events
// typst compile --font-path fonts/ calendar.typ
//
// create image index via ls:
//    ls images/ > images.txt

#set page(width: 15cm, height: 21cm, margin: 0cm)
#let year = 2026
#let image_path = "./images/"
#let events_file = "./events.txt"
#let images_file = "./images.txt"

#let days = (
  "Mo",
  "Di",
  "Mi",
  "Do",
  "Fr",
  "Sa",
  "So",
)

#let months = (
  "Januar",
  "Februar",
  "März",
  "April",
  "Mai",
  "Juni",
  "Juli",
  "August",
  "September",
  "Oktober",
  "November",
  "Dezember",
)

#let title_props = (size: 24pt, font: "Poppins", weight: "semibold", fill: fuchsia)

// calendar header days display needs
// the bold variant of the font => default-header-style()
#let calendar_props = (size: 9pt, font: "Poppins", weight: "regular", fill: black)

#let event_props = (size: 9pt, font: "Playwrite DE SAS", weight: "regular", fill: black)

// images.txt contain all the filenames of the images
#let images = csv(images_file)

// events are good for printing birthdays
#let events = {
  csv(events_file).fold(
    range(0, 13).map(month => (events: ())),
    (acc, item) => {
      let d = item.at(0)
      let e = item.at(1)
      let dm = d.split(".")


      acc
        .at(int(dm.at(1)))
        .at("events")
        .push(
          (int(dm.at(1)), datetime(year: year, month: int(dm.at(1)), day: int(dm.at(0))), e.trim()),
        )
      acc
    },
  )
}

#let default-header-style(day) = {
  show: pad.with(bottom: 6pt)
  set align(center + horizon)
  set text(weight: "bold")
  [#{ day }]
}

#let default-item-style(day) = {
  show: pad.with(y: 6pt)
  set align(center + horizon)
  [#{ day }]
}

#let highlight-item-style(day) = {
  show: pad.with(y: 6pt, x: 0pt)
  set align(center + horizon)
  [#highlight[#" " #{ day } #" "]]
}

#let get-month-last-day(month, year) = {
  if month in (1, 3, 5, 7, 8, 10, 12) {
    return 31
  } else if month in (4, 6, 9, 11) {
    return 30
  } else {
    if (calc.fract(year / 4) == 0.0) and (calc.fract(year / 400) != 0.0) {
      return 29
    } else {
      return 28
    }
  }
}

#let calendar-events(month: 1) = {
  let ev = events
    .at(month)
    .at("events")
    .sorted(
      key: item => item.at(1),
    )
  set text(..event_props)

  ev.map(e => e.at(1).display("[day].[month].") + " " + e.at(2)).join([\ ])
}

#let calendar-title-month(month: 1) = {
  let monthname = months.at(month - 1)
  set text(..title_props)

  [#h(3mm)#monthname #year]
}

#let calendar-mini-month(
  month: 1,
  year: year,
) = {
  let w = 1cm
  let last = get-month-last-day(month, year)
  let datefirst = datetime(year: year, month: month, day: 1)
  let first_day = int(
    datefirst.display(
      "[weekday repr:monday]",
    ),
  )
  set text(..calendar_props)
  let offset = range(1, first_day)

  let month_events = events.at(month).at("events")
  let evdays = month_events.map(e => int(e.at(1).display("[day]")))

  grid(
    columns: (w, w, w, w, w, w, w),
    grid.header(..days.map(d => default-header-style(d))),
    ..offset.map(d => []),
    ..range(1, last + 1).map(d => if d in evdays { highlight-item-style(d) } else { default-item-style(d) }),
  )
}

// here is where we are starting to create the contents

// create 12 times content ...
#(
  range(1, 13)
    .map(month => {
      [
        // layed out as ...

        // the image
        #image(
          image_path + images.at(month - 1).at(0),
          width: 100%,
          height: 13cm,
          // fit: "contain" // "contain" "cover" "stretch"
        )

        // 1cm vertical space
        #v(1cm)

        // the next content has a left padding of 1cm
        #pad(left: 1cm)[

          // the month's title
          #calendar-title-month(month: month)

          // the calendar and the events
          // "stacked" to 2 columns
          #stack(dir: ltr, spacing: 0.5cm)[#calendar-mini-month(month: month)][#calendar-events(month: month)]

        ]]
    })
    .join()
)
