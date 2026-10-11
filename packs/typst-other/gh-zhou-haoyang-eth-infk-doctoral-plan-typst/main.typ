// Minimal template for doctoral plans.
// Adapted from https://www.overleaf.com/latex/templates/doctoralplan-guideline-latex/ccqmqhfynwzh

// ---------------------------------------------------------------------------
// Preamble: page geometry, fonts, headers/footers and section formatting.
// ---------------------------------------------------------------------------

#let baselineskip = 13.6pt // \baselineskip at 11pt
// emphasize suggestions, cf. \suggestion -> {\itshape #1} (a font switch, so block
// spacing of the wrapped paragraphs is preserved).
#let suggestion(body) = { set text(style: "italic"); body }

// header: ETH logo (0.6 textwidth) on the left, address (0.3 textwidth) on the
// right. The 1/18/1/9/1 columns reproduce \hspace*{\fill} ... \hfill ...
// \hspace*{\fill} exactly (logo = 60%, address = 30%, three equal fills).
#let header = grid(
  columns: (1fr, 18fr, 1fr, 9fr, 1fr),
  align: top,
  [],
  image("logo.pdf", width: 60%), // \includegraphics[width=0.6\textwidth] inside a 0.6\textwidth minipage
  [],
  text(size: 8pt)[ // \scriptsize at 11pt
    *Department of Computer Science* \
    *Doctoral administration* \
    \
    ETH Zurich \
    CAB H 37.1 \
    Universitätstrasse 6 \
    CH-8092 Zurich \
    \
    #link("mailto:doctorate@inf.ethz.ch")[doctorate\@inf.ethz.ch] \
    #link("https://www.inf.ethz.ch")[www.inf.ethz.ch] \
  ],
  [],
)

// footer: "Doctoral Plan" left, page number centered, empty right.
#let footer = context grid(
  columns: (1fr, 1fr, 1fr),
  align: (left, center, right),
  [Doctoral Plan], counter(page).display(), [],
)

#set page(
  paper: "us-letter",
  margin: (left: 1in, right: 1in, top: 215pt, bottom: 0.9in),
  header: header,
  header-ascent: 50pt,
  footer: footer,
  footer-descent: 0.4in,
)

#set text(size: 11pt)
// parskip = \baselineskip; bumped slightly because Typst measures block spacing
// box-to-box rather than baseline-to-baseline.
#set par(justify: true, first-line-indent: 0pt, spacing: 1.75 * baselineskip)
// LaTeX list environments add topsep/itemsep; give items a line of spacing.
#set list(spacing: baselineskip)

// \thesection -> "Part N", \thesubsection -> "N."
#set heading(numbering: (..n) => {
  let p = n.pos()
  if p.len() == 1 { [Part #p.at(0)] } else { [#p.at(1).] }
})

// \section -> \Large\bfseries, \subsection -> \large\bfseries; number then \quad.
#show heading: it => block(
  above: if it.level == 1 { 2.95 * baselineskip } else { 2.55 * baselineskip },
  below: 2.15 * baselineskip,
  sticky: true, // keep the heading with the following text, cf. LaTeX \nobreak
)[
  #set text(size: if it.level == 1 { 14.4pt } else { 12pt }, weight: "bold")
  #if it.numbering != none {
    numbering(it.numbering, ..counter(heading).at(it.location()))
    h(1em)
  }
  #it.body
]

// fill-in field: label and a 12cm rule (cf. \rule{12cm}{0.15mm}), rows spaced
// by 10pt (cf. \\[10pt]).
#let fields(..rows) = block(breakable: false, grid(
  columns: (auto, auto),
  column-gutter: 12pt, // 2 * \tabcolsep
  row-gutter: 16pt, // \\[10pt] over a \baselineskip row
  inset: 0pt,
  align: (left + bottom, bottom),
  ..rows.pos().map(label => (label, line(length: 12cm, stroke: 0.15mm))).flatten(),
))

// ---------------------------------------------------------------------------
// Document
// ---------------------------------------------------------------------------

#heading(level: 1, numbering: none)[Guidelines for Doctoral Plan]

This document aims to help you write your doctoral plan, which you have to submit in advance of the aptitude colloquium.
An electronic copy must be submitted within eleven months after provisional admission to the #link("mailto:bernadette.gianesi@inf.ethz.ch?subject=Research%20Plan")[D-INFK doctoral coordination].

The integrated research proposal will be the basis of your aptitude colloquium, which you need to pass in order to advance to definitive admission as a doctoral student.

Please note that the doctoral plan has not the character of a legally binding agreement but is instead a declaration of intent between you and your supervisor and should be conceived as a living instrument.
Changes are possible, and in many cases, certainly necessary.
Major changes should be documented in the annual status conversations.

#heading(level: 2, numbering: none)[Basic Information]

// replace rules with actual content
#fields(
  [Name Doctoral Student],
  [Student Number],
  [Name Supervisor],
  [Name Second Advisor],
  [Start of Doctorate],
)

Title Research Proposal

#rect(width: 100%, height: 6 * baselineskip, stroke: 0.4pt)

// uncomment to add blank page
// #pagebreak()

= Research Proposal

#suggestion[(please add extra pages here; use the following structure to describe your research work)]

== Abstract
#suggestion[
Present the background of your research project, list its main goals, describe the methods to be used and the expected results, as well as their impact on the field and beyond.
]

== Introduction and Current State of Research in the Field
#suggestion[
Describe your project in the context of the current state of knowledge in your field.
Refer to the most important publications.
Describe briefly:

- Which previous insights provided the starting point and basis for your project

- In which areas research is needed, and why
]

== Goals of the Thesis
#suggestion[
Describe the research questions you address in your research project and the concrete objectives that you aim to achieve in the period of your doctorate.

Illustrate the expected impacts of your project: how will your proposed research add to existing knowledge in the field?
How and where might your results be used?
How do you intend to disseminate your research?
]

== Progress to Date
#suggestion[
Present the research work you have already undertaken in the relevant field, describe the results obtained so far (including publications), as well as the relevance of these preliminary undertakings for your project.
Also, describe your "negative results": what could you learn from this if something went wrong?
]

== Detailed Work Plan
#suggestion[
Describe the studies or experiments envisaged to reach the set goals.
Present your work plan in the form of work packages (WP), each defining the task and describing the methods used and the expected outcome.
In general, a work package should describe 3 - 12 months of work.
Assess the risks involved for each work package: if the work package does not work, do you have various options, which other parts of your plan are affected, what is the backup?

WP 1: …

WP 2: …
]

== Publication Plan
#suggestion[
For each work package, list the tentative publication in a specific conference or journal.
]

== Time Schedule (potentially as a visualization)
#suggestion[
Indicate the tentative timeframe for each work package.
Your time schedule should be based on the average time of 4 years of doctorate.
]

== References
#suggestion[
List the sources of all work referred to in the research proposal.
Give the full reference, especially the title, source, and full author list (use a style commonly adopted in your research field).
]

= Teaching Responsibilities
#suggestion[
Describe which teaching tasks you are assigned to and indicate (roughly) how many hours you devote to such activities each week.

Teaching tasks are, e.g., assisting in lectures, practical classes, exercise classes, correcting students' reports, supervising undergraduates in semester projects, summers schools, marking/overseeing exams.
]

= Other Duties
#suggestion[
If relevant, describe which additional tasks you are assigned to (e.g., operation or maintenance of equipment).
Indicate (roughly) how many hours you devote to such activities each week.
]

= Study Plan
#suggestion[
Please add your individual study plan here, including a tentative schedule (e.g., using the learning agreement in mystudies).
*NOTE*: a course in ethics and good scientific practice is a *mandatory* requirement.]

#heading(level: 1, numbering: none)[Signatures]

// replace rules with actual content
#fields(
  [Supervisor],
  [Second Advisor],
  [Doctoral Student],
  [Date],
)
