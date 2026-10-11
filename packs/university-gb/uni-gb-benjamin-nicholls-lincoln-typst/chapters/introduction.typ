#import "../template/cite.typ": citet, citep, citeauthor, citefull, citeyear

= Introduction


== Custom cite functions

For conveinience there are some new cite functions.
Rather than using `cite(tag, form: "prose")` for in-text citations, just use
`citet(tag)` for the same functionality.
More examples follow:

- Use `citet` for in-text citations: #citet(<stevenson2024open>) does really amazing work.
- Use `citep` for end-of-text citations: Some work in this subject area has no flaws #citep(<stevenson2024open>).
- Use `citeauthor` to cite the author: #citeauthor(<stevenson2024open>).
- Use `citeyear` for the year: #citeyear(<stevenson2024open>).
- Use `citefull` for the full citation (I doubt you will ever use this): #citefull(<stevenson2024open>).



== Equations 

Look like this:
$ a + b = gamma $ <eq:gamma>

== Figures

#figure(
  placement: none,
  circle(radius: 15pt),
  caption: [A circle representing the Sun.]
) 

== Tables
#figure(
    placement: none,
    table(
        columns: (30%, auto, auto),
        inset: 10pt,
        align: horizon,
        table.header(
            [], [*Volume*], [*Parameters*],
        ),
        image("../figures/logo.png"),
        $ pi h (D^2 - d^2) / 4 $,
        [
            $h$: height \
            $D$: outer radius \
            $d$: inner radius
        ],
        image("../figures/logo.png"),
        $ sqrt(2) / 12 a^3 $,
        [$a$: edge length],
    ),
    caption: [test]
)

== Sections 

#lorem(20)

=== Subsection
==== Subsubsection
========= They just keep going. 


#pagebreak()

Note how the chapter title displays at the bottom of this page but not the previous.



