#import "@preview/datify:1.0.0": *

#let timetable(
  company: [],
  employee: [],
  employee_number: [],
  month: int,
  year: int,
  dates: (),
  image: none,
  doc,
) = {
  let title = "Arbeitszeiterfassung" + employee + " " + [#month] + " " + [#year]
  set document(
    title: title,
    author: employee,
  )


  let numformat(num) = {
    if (num < 10){
      return "0" + [#num]
    }
      return [#num]
  }

  grid(
    columns: (1fr, auto),
    row-gutter: 5pt,
    [*Firma:*], [#company],
    [*Name des Mitarbeiters:*], [#employee],
    [*Personalnummer:*], [#employee_number],
    [*Monat/Jahr:*], [#month / #year],
  )
  let total_minutes = 0
  table(
    columns: (auto, auto, auto, auto, auto, auto, 1fr),
    table.header([Wochentag], [Begin], [Pause], [End], [Dauer], [\*], [Bemerkung]),
    ..for (.., day, start, end, pause, key, annotation) in dates {
      let start = datetime(
        year: year,
        month: month,
        day: day,
        minute: start.minute,
        second: 0,
        hour: start.hour,
      )
      let end = datetime(
        year: year,
        month: month,
        day: day,
        minute: end.minute,
        second: 0,
        hour: end.hour,
      )
      assert(((end - start).hours() > pause.hours()) , message: "pause is bigger than total work time ")

      let duration = end - start - pause
      let d_hours = 0
      let d_min = duration.minutes() 
      if (duration.hours() < 1) {
        d_hours = 0
      } else {
        d_hours = calc.floor(duration.hours())
        d_min = d_min - (d_hours*60)
      }
      total_minutes += d_hours * 60 + d_min
      let pause = (
        datetime(
          hour: 0,
          second: 0,
          minute: 0,
        )
          + pause
      )
      (
        custom-date-format(start, lang: "de", pattern: "EEE d"),
        start.display("[hour]:[minute]"),
        [#pause.display("[hour]:[minute]")],
        end.display("[hour]:[minute]"),
        [#numformat(d_hours):#numformat(d_min)],
        key,
        box[#annotation],
      )
    },
    [*Summe*],
    table.cell(
      colspan: 6,
      align: center,
      [*#(numformat(calc.floor(total_minutes / 60))):#(numformat(total_minutes - calc.floor((total_minutes / 60)) * 60))*],
    ),
  ) // table
   let signature = employee
   if image != none {
    signature =figure(
      image
    )
  }   

  align(bottom)[

    #grid(
      columns: (1fr, 35%, 1fr, 25%),
      row-gutter: 5pt,
      column-gutter: 5pt,
      [#datetime.today().display()], signature, [], [],
      grid.cell(colspan: 2, line(length: 100%)), grid.cell(colspan: 2, line(length: 100%)),
      [Datum], [Unterschrift Arbeitnehmer], [Datum], [Unterschrift Arbeitgeber],
    )
  ]
  doc
}
