/* Chalmers ISP template for typst
 * Designed to look similar to the word template
 * Vincent Molin, 2024-2025
 */

#set page(
  paper: "a4",
  header: [
    #v(10pt)

    #set align(center)
    #image("SV_Svart_Chalmers.svg", width: 38mm)
  ],
  numbering: "1 of 1",
  header-ascent: 10%,
  margin: (top: 0.6in),
)

#set table.cell(inset: 5pt)
// #set par(justify: true)
#set text(font: "DejaVu Sans", 10pt)
#set text(font: "Lato")
#set table(stroke: 0.5pt)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 3): set text(style: "italic", weight: "regular")

= Individual study plan

#let add_signature_block = true  //

#let general_basic_data = (
  ("Name", "Firstname Lastname"),
  ("Social security number", "xxxx"),
  ("Department", "Mathematical Sciences"),
  ("Division", "Applied Mathematics and Statistics"),
  ("Research school", "Mathematics"),
  ("Admission date", "zzzz-xx-yy"),
  ("Research subject specialization", " "),
  ("Director of studies", "Firstname Lastname"),
)

#let general_span_data = (
  ("Line manager", "Name"),
  ("Examiner", "Name"),
  ("Main supervisor", "Name"),
  ("Assistant supervisor", [Name 1 \ Name 2]),
  ("Other supervisors, mentors, etc", ""),
  ("Academic undergraduate degree", "Master of Science"),
  (
    "Form of employment",
    [#grid(
      columns: (1fr, 1fr),
      row-gutter: 6pt,
      [#sym.ballot.cross PhD student position], [ #sym.ballot Industrial PhD student],
      [#sym.ballot Other external employment], [ #sym.ballot Other form, specify:],
    )],
  ),
  (
    "Admitted for",
    [#grid(
      columns: (1fr, 1fr, 1fr),
      [ #sym.ballot Lic. Eng. ], [ #sym.ballot.cross PhD], [ #sym.ballot PhD later part],
    )],
  ),
)

#table(
  columns: (1.2fr, 1fr),
  table.cell(colspan: 2)[#text(12pt, [*General*])],
  ..for (a, b) in general_basic_data {
    (
      [ _#(a)_ \
        #b ],
    )
  },
  ..for (a, b) in general_span_data {
    (
      table.cell(colspan: 2)[
        _#(a)_ \
        #b
      ],
    )
  },
  [
    === Required credits for Lic. Eng. degree

    Credits for course work: 45cr

    Credits for thesis work: 75cr
  ],
  [
    === Required credits for PhD degree // (in total)

    Credits for course work: 90cr

    Credits for thesis work: 150cr
  ],
  [Intend to acquire Lic. Eng.: #h(5pt) #sym.ballot Yes #h(5pt) #sym.ballot.cross No],
  [Intend to acquire PhD: #h(5pt) #sym.ballot.cross Yes #h(5pt) #sym.ballot No],
  [Estimated date for Lic. Eng.: \
    Estimated date for midway seminar:
  ],
  [Estimated date for PhD: yyyy-mm-dd],

  table.cell(colspan: 2)[
    Activity as percentage of time

    (Previous and planned. Normal is 80% and reasons should be given for any deviations)
  ],
  table.cell(colspan: 2, inset: 0pt)[
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      [Year 1 \ 80%], [Year 2 \ 80%], [Year 3 \ 80%], [Year 4 \ 80%], [Year 5 \ 80%], [ ... ],
    )
  ],
)

#let study_follow_up_meetings = (
  (date: "yyyy-03-07", present: "AAA, BBB, CCC"),
  (date: "yyyy-03-07", present: "AAA, BBB, CCC"),
  (date: "yyyy-03-07", present: "AAA, BBB, CCC"),
)

#pagebreak()

#table(
  columns: (1.1fr, 6fr),
  table.cell(colspan: 2)[
    == Study follow-up meetings
    Regarding postgraduate education
  ],
  [=== Date],
  [=== Present at the meeting],
  ..for (date, present) in study_follow_up_meetings {
    ([#date], [#present])
  },
  table.cell(colspan: 2)[Next meeting (date): \ xxx],
)


#let appraisal_discussions = (
  (date: "yyyy-mm-dd", present: "AAA and BBB"),
  (date: "yyyy-mm-dd", present: "AAA and BBB"),
)

#table(
  columns: (1.1fr, 6fr),
  table.cell(colspan: 2)[
    == Appraisal discussions
    Regarding the postgraduate student's working conditions, etc. (held with line manager)
  ],
  [=== Date],
  [=== Present at the meeting],
  ..for (date, present) in appraisal_discussions {
    ([#date], [#present])
  },
  table.cell(colspan: 2)[Next meeting (date): \ 2025],
)


#let completed_work = (
  (work: "TA - Course", hours: 123, date: "22/23 SP1"),
  (work: "Master's thesis supervision", hours: 60, date: "Mar-Sep 24"),
  (work: "...", hours: "...", date: "..."),
)

#let planned_work = (
  (work: "TA - Course", hours: 123, date: "24/25 SP1"),
  (work: "TA - Course", hours: 123, date: "24/25 SP1"),
)

#table(
  columns: (3.1fr, 1.1fr, 1fr),
  table.cell(colspan: 3)[
    == Department work
    Activity as percentage of time. Maximum is 20% and reasons should be given for any deviations)
  ],
  table.cell(colspan: 3, inset: 0pt)[
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      [Year 1 \ 20%], [Year 2 \ ], [Year 3 \ ], [Year 4 \ ], [Year 5 \ ], [ ... ],
    )
  ],
  [=== Department work accomplished],
  [=== Number of hours],
  [=== Date],
  ..for (work, hours, date) in completed_work {
    ([#work], [#hours], [#date])
  },
  [=== Planned department work],
  [=== Number of hours],
  [=== Date],
  ..for (work, hours, date) in planned_work {
    ([#work], [#hours], [#date])
  },
)

#let completed_courses = (
  (
    course: "Title",
    examiner: "Examiner",
    credits: 7.5,
    date: "YY-MM-DD",
  ),
  (
    course: "Title",
    examiner: "Examiner",
    credits: 7.5,
    date: "YY-MM-DD",
  ),
  (
    course: "Title",
    examiner: "Examiner",
    credits: 7.5,
    date: "YY-MM-DD",
  ),
  (
    course: "Title",
    examiner: "Examiner",
    credits: 7.5,
    date: "YY-MM-DD",
  ),
)

#let planned_courses = (
  (course: "Tricky advanced course #1", examiner: "", credits: 6, date: "25/26"),
  (course: "Seminar Course", examiner: "", credits: 7.5, date: "Future"),
)

#pagebreak()

// Course table
#table(
  columns: (3.1fr, 1.5fr, 1.1fr, 1fr),
  table.cell(colspan: 4)[#text(12pt, [*Courses*])
  ],
  [=== Completed courses],
  [=== Course examiner],
  [=== Credits],
  [=== Date],
  ..for (course, examiner, credits, date) in completed_courses {
    ([#course], [#examiner], [#credits cr], [#date])
  },

  table.cell(colspan: 4, stroke: none)[],
  // [...], [...], [...], [...],
  table.vline(),
  [=== Planned courses],
  [=== Course examiner],
  [=== Credits],
  [=== Date],
  ..for (course, examiner, credits, date) in planned_courses {
    ([#course], [#examiner], [#credits cr], [#date])
  },
)

#let total = completed_courses.map(c => c.credits).sum()
#let planned_total = planned_courses.map(c => c.credits).sum()

Finished credits: #total/90 (#calc.round(total / 0.90, digits: 0)%).
Finished and planned credits: #(total + planned_total)/90 (#calc.round((total + planned_total) / 0.9, digits: 0)%).


#table(
  columns: 1fr,
  [== Supervisor plan for upcoming year],
  [
    === Availability of supervisor (e.g. days / month)

    #lorem(10)
  ],
  [
    === Scope of supervision (e.g. hours / week)


    #lorem(10)
  ],
  [
    === Content of supervision


    #lorem(10)
  ]
)


#table(
  columns: 1fr,
  [== Research project for the upcoming year],
  [
    === Description of objective

    #lorem(10)
  ],
  [
    === Research projects

    #lorem(10)
  ],
  [
    === Available resources for the above

    #lorem(10)
  ],
  [
    === Publications, etc.

    #lorem(10)
  ],
  [
    === Other (conference participation, seminars, contacts, research exchange, etc.)

  ]
)


#table(
  columns: 1fr,
  [
    == Percentage of postgraduate education accomplished

    Normal is 20% per year and reasons should be given for any deviations
  ],
  table.cell(colspan: 1, inset: 0pt)[
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      [Year 1 \ 20%], [Year 2 \ ], [Year 3 \ ], [Year 4 \ ], [Year 5 \ ], [ ... ],
    )
  ],
  [
    Reasons for deviation

  ],
  [
    == Other

    (Information that is not within the scope of the study plan, e.g. union work, commitments, etc.)
  ],
  [

  ],
  [
    #text(12pt, [*Reasons for deviations*])

    Regarding activity (normal is 80%) and department work (maximum 20%). \
    Regarding completed postgraduate education (normal is 20%).
  ],
  [

  ],
)

#pagebreak()

#if add_signature_block {
  table(
    columns: 1fr,
    [
      #text(12pt, [*Signatures*])
    ],
    [
      Date:
      #grid(
        columns: (1fr, 1fr), row-gutter: 10pt, inset: 30pt,
        ..(
          (
            "Doctoral student",
            "Examiner",
            "Main supervisor",
            "Director of studies",
            "Assistant supervisor",
            "Assistant supervisor",
          ).map(n => {
            [
              #line(stroke: (dash: "dashed"), length: 100%)
              #n
            ]
          })
        )
      )
    ]
  )
}

#pagebreak()

= Publications, etc.

#let pubs = (
  (
    title: [Theory of stuff],
    date: "22-24 August 2099",
  ),
  (title: "A publication", date: "11-13 January 33"),
  (
    title: [
      A conference \
      Poster: _A title_
    ],
    date: "June 1234",
  ),
)

#{
  [ #set par(justify: false)
    #table(
      columns: (4fr, 1fr),
      [
        === Articles, conferences, patents, awards, etc.
      ],
      [=== Date],
      ..for (title, date) in pubs {
        ([#title], [#date])
      },
    )
  ]
}

= Research education history

#table(columns: 1fr)[
  === Year 1

][
  === Year 2

][
  === Year 3

][
  === Year 4

][
  === Year 5

]


