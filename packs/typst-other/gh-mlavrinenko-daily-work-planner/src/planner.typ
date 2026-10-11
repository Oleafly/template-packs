// Configuration via --input parameters
// year: calendar year for day-of-year calculation (defaults to current year)
#let year = int(sys.inputs.at("year", default: str(datetime.today().year())))

// weeks: range like "1-52", "3-", "-35", "-", or "" (all default to 1-52 bounds)
#let _weeks-raw = sys.inputs.at("weeks", default: "1-52")
#let _weeks-parts = _weeks-raw.split("-")
#assert(_weeks-parts.len() == 2, message: "weeks must be in format 'START-END', got: " + _weeks-raw)
#let _weeks-start = if _weeks-parts.at(0) == "" { 1 } else { int(_weeks-parts.at(0)) }
#let _weeks-end = if _weeks-parts.at(1) == "" { 52 } else { int(_weeks-parts.at(1)) }
#assert(_weeks-start >= 1 and _weeks-start <= 52, message: "weeks start must be 1-52, got: " + str(_weeks-start))
#assert(_weeks-end >= 1 and _weeks-end <= 52, message: "weeks end must be 1-52, got: " + str(_weeks-end))
#assert(_weeks-start <= _weeks-end, message: "weeks start must be <= end, got: " + str(_weeks-start) + "-" + str(_weeks-end))
// Convert 1-based range to 0-based indices used internally
#let start-week = _weeks-start - 1
#let weeks = _weeks-end - _weeks-start + 1

#import "@preview/suiji:0.4.0": gen-rng-f, integers-f

#let base-seed = int(sys.inputs.at("seed", default: "0"))

#let adjectives = csv("res/adjectives.csv").map(row => row.at(0))
#let animals = csv("res/animals.csv").map(row => row.at(0))

#let fun-name(week, day-idx) = {
  let seed = base-seed + week * 5 + day-idx + 1
  let rng = gen-rng-f(seed)
  let (rng, adj-idx) = integers-f(rng, low: 0, high: adjectives.len() - 1)
  let (rng, ani-idx) = integers-f(rng, low: 0, high: animals.len() - 1)
  adjectives.at(adj-idx) + " " + animals.at(ani-idx)
}

#set page(
  paper: "a5",
  margin: (top: 0.7cm, bottom: 0.7cm, left: 0.7cm, right: 0.7cm),
)

#set text(font: "Liberation Sans", size: 9pt)

#let days = ("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

#let start-hour = 10
#let end-hour = 20
#let hour-count = end-hour - start-hour
#let row-count = 8

#let cb-size = 0.5cm
#let checkbox-col-width = 0.5cm
#let checkbox-gap = 0.2cm
#let header-gap = 0cm
#let timeline-height = 0.45cm
#let marking-gap = 0.09cm

#let day-gap = 0.7cm
#let days-per-page = 2

// A5 height = 210mm, minus top+bottom margins
#let page-content-height = 210mm - 0.7cm - 0.7cm
#let section-height = (page-content-height - day-gap * (days-per-page - 1)) / days-per-page

#let day-section(name, week, day-idx) = {
  let n = week + 1
  let week-label = if n < 10 { "0" } else { "" } + str(n)
  let pair = fun-name(week, day-idx)

  // Calculate actual day-of-year for the ISO week (using global year variable)
  let jan4 = datetime(year: year, month: 1, day: 4)
  let jan4_weekday = jan4.weekday() // 1=Mon..7=Sun
  let jan4_ordinal = jan4.ordinal()

  // Monday of ISO week 1 ordinal
  let week1_mon_ordinal = jan4_ordinal - (jan4_weekday - 1)

  // Day-of-year for this ISO week + weekday
  let day-of-year = week1_mon_ordinal + week * 7 + day-idx

  // Only show day-of-year if it's in the current year (1-365/366)
  let doy-label = if day-of-year >= 1 and day-of-year <= 366 {
    str(day-of-year)
  } else {
    "" // Leave blank for dates outside the target year
  }

  box(height: section-height, width: 100%, {
    let header = {
      box(
        move(
          dy: 0.8pt,
          box(
            fill: black,
            radius: 2pt,
            inset: (x: 4pt, y: 3pt),
            text(size: 10pt, weight: "bold", fill: white, week-label),
          )
        )
      )
      h(6pt)
      text(size: 16pt, weight: "bold", name)
      h(6pt)
      text(size: 9pt, fill: luma(120), "(" + pair + ")")
      h(1fr)
      text(size: 8pt, fill: luma(150), doy-label)
    }
    header

    context {
      let header-height = measure(header).height

      layout(size => {
        let avail = section-height - header-height - header-gap
        let row-h = avail / row-count

        // Pull rows up so first checkbox aligns right at the gap
        let first-row-pad = row-h - timeline-height - marking-gap - cb-size
        let rows-top = header-height + header-gap - first-row-pad

        let line-x = checkbox-col-width + checkbox-gap
        let line-w = size.width - line-x

        for i in range(row-count) {
          // Row layout (top to bottom): writing space | writing line | marking-gap | marking line | timeline ticks+labels
          let marking-y = rows-top + row-h * (i + 1) - timeline-height
          let writing-line-y = marking-y - marking-gap

          place(
            top + left,
            dy: writing-line-y - cb-size,
            dx: (checkbox-col-width - cb-size) / 2,
            rect(
              width: cb-size,
              height: cb-size,
              radius: 1pt,
              fill: white,
              stroke: 0.5pt + black,
            ),
          )

          place(
            top + left,
            dy: writing-line-y,
            dx: line-x,
            line(length: line-w, stroke: 0.5pt + black),
          )

          place(
            top + left,
            dy: marking-y,
            dx: line-x,
            line(length: line-w, stroke: 0.5pt + black),
          )

          let tick-y = marking-y + 0.5pt
          let quarter-tick = 0.08cm
          let half-tick = 0.14cm
          let full-tick = 0.07cm

          for h in range(hour-count + 1) {
            let tick-x = line-x + line-w * h / hour-count
            place(
              top + left,
              dy: tick-y,
              dx: tick-x,
              line(length: full-tick, angle: 90deg, stroke: 0.4pt + luma(60)),
            )
            place(
              top + left,
              dy: tick-y + full-tick,
              dx: tick-x,
              move(
                dy: 0.05em,
                dx: -0.3em,
                text(size: 5pt, fill: luma(100), str(start-hour + h)),
              ),
            )

            if h < hour-count {
              let half-x = line-x + line-w * (h + 0.5) / hour-count
              place(
                top + left,
                dy: tick-y,
                dx: half-x,
                line(length: half-tick, angle: 90deg, stroke: 0.3pt + luma(120)),
              )

              let q1-x = line-x + line-w * (h + 0.25) / hour-count
              place(
                top + left,
                dy: tick-y,
                dx: q1-x,
                line(length: quarter-tick, angle: 90deg, stroke: 0.25pt + luma(160)),
              )

              let q3-x = line-x + line-w * (h + 0.75) / hour-count
              place(
                top + left,
                dy: tick-y,
                dx: q3-x,
                line(length: quarter-tick, angle: 90deg, stroke: 0.25pt + luma(160)),
              )
            }
          }
        }
      })
    }
  })
}

#let all-days = range(start-week, start-week + weeks).map(week =>
  days.enumerate().map(((i, day)) => (name: day, week: week, day-idx: i))
).flatten()

#set block(spacing: 0pt)
#set par(spacing: 0pt, leading: 0pt)
#for (idx, d) in all-days.enumerate() {
  if calc.rem(idx, days-per-page) == 0 and idx > 0 { pagebreak() }
  day-section(d.name, d.week, d.day-idx)
  if calc.rem(idx, days-per-page) == 0 { v(day-gap) }
}
