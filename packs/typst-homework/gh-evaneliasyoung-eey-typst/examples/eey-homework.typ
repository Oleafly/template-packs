#import "../eey-homework/lib.typ": eey-homework
#import "../eey-homework/lib.typ": eey-response
#import "../eey-homework/lib.typ": long-us-date
#import "../eey-homework/lib.typ": us-date

#show: doc => eey-homework(
  doc,
  university: "Missouri University of Science and Technology",
  subject: "Comp Sci",
  course: 1500,
  section: 101,
  assignment: "Homework #1",
  semester: "FS2019",
  pubdate: datetime(
    year: 2019,
    month: 9,
    day: 18,
  ),
  authors: (
    (name: "Evan Elias Young", email: "eeymrr@mst.edu"),
    (name: "Evan Elias Young", email: "eeymrr@mst.edu"),
    (name: "Evan Elias Young", email: "eeymrr@mst.edu"),
  ),
  section_index_base: 1,
)
#let duedate = datetime(
  year: 2019,
  month: 10,
  day: 26,
  hour: 21,
  minute: 5,
  second: 0,
)

= Template Methods

- `eey-homework` renders the base document.
- `eey-response(content)` renders a highlighted box for certain courses which require specific response "zones".
- `long-us-date(dt)` renders a date and time, with the day of the week, spelled out month, and in common US format.
- `us-date(dt)` renders a date, with a spelled out month, and in common US format.

== `eey-homework`

I encourage you to take a look at the provided typst code for this document, as it can better list out the variables used to render the heading, title, authors, and date.

- `university: content = "Missouri University of Science and Technology"`
- `subject: content = "Comp Sci"`
- `course: content = 1500`
- `section: content = 101`
- `assignment: content = "Homework #1"`
- `semester: content = "FS2019"`
- `pubddate: datetime = datetime(year: 2019, month: 9, day: 18,)`
- `authors: array = ((name: "Evan Elias Young", email: "eeymrr@mst.edu"),)`
- `section_index_base: int = 0`

== `eey-response()[...]`

#eey-response[
  There are no parameters to this function, instead only `#eey-response[]` should be used.
]

== `long-us-date(dt)`

#long-us-date(duedate)

== `us-date(dt)`

#us-date(duedate)
