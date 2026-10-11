#import "../theme/global-theme.typ": outline-color, table-header-color

= CONCLUSION

This chapter reviews the outcome of the internship. It accounts for the
functionality that was delivered in @sec_completed and the unfinished tasks in
@sec_incomplete, reflects on the main technical challenges in @sec_challenges
and the professional experience gained in @sec_experience, offers a personal
perspective in @sec_perspective, and closes with the planned extensions in
@sec_future_work.

== Completed Functions <sec_completed>
...

// Space out the rotated text a bit
#show rotate: set text(tracking: 0.02em)

#figure(
  table(
    columns: (2em, 1fr, 1fr, 1fr, 4em),
    inset: 7pt,
    align: (
      center + horizon,
      left + horizon,
      left + horizon,
      left + horizon,
      center + horizon,
    ),
    table.header(
      align(center)[],
      align(center)[*Feature*],
      align(center)[*Backend*],
      align(center)[*Mobile*],
      align(center)[*Status*],
    ),

    table.cell(rowspan: 2, fill: table-header-color)[#rotate(
      -90deg,
      reflow: true,
    )[*1*]],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],

    table.hline(stroke: 1pt + outline-color),
    table.cell(rowspan: 3, fill: table-header-color)[#rotate(
      -90deg,
      reflow: true,
    )[*2*]],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],
    [...],
  ),
  caption: [Completed features and how each was delivered on the backend and
    mobile sides, grouped by domain.],
) <completed_functions_table>

== Incomplete Functions <sec_incomplete>

...

== Challenges <sec_challenges>

...

== Experience <sec_experience>

...

== Perspective <sec_perspective>

...

== Future Work <sec_future_work>
...
