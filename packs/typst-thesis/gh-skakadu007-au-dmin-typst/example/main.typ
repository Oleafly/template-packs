#import "../typ/au-dmin.typ": *

// ==============================================================================
// 🎓 ANDREWS UNIVERSITY DOCTOR OF MINISTRY PROJECT DISSERTATION
// Sample document demonstrating all formatting per the AU DMin Manual (4th ed.)
// ==============================================================================

#show: au-dmin.with(
  title: "THE USE OF SCIENCE IN THEOLOGY:\ INTRODUCTION\ AND HISTORICAL BACKGROUND",
  author: "Taras Shevchenko",
  degree: "Doctor of Ministry",
  advisor: "John A. Smith, Ph.D.",
  second-reader: "David B. Williams, D.Min.",
  third-reader: "Sarah M. Johnson, Ph.D.",
  program-director: "Stanley E. Patterson, Ph.D.",
  dean: "Jiří Moskala, Th.D., Ph.D.",
  date: "August 2026",
  lang: "en",
)

// 1. Порожня початкова сторінка (Blank Flyleaf Page)
#blank-page()

// ==============================================================================
// ABSTRACT (Unnumbered and Uncounted) — Exhibits A & B
// ==============================================================================

// Exhibit A: Abstract Title Page (Takes title, author, adviser automatically from au-dmin)
#abstract-title-page()

// Exhibit B: Abstract Body with 4 structured sections (Takes metadata automatically)
#abstract-body(
  problem: [
    Compensatory theological formulations frequently lack a coherent hermeneutical bridge when addressing contemporary scientific models in local pastoral leadership. This study investigates the extent to which pastoral integrative competency influences congregational resilience during faith-science controversies.
  ],
  method: [
    A mixed-methods empirical design was employed. Thirty-six pastoral practitioners and 124 church leaders across North America participated in semi-structured qualitative interviews and quantitative evaluative assessments over a two-year longitudinal observation period.
  ],
  results: [
    Significant variance was observed in pastoral confidence and constructive dialogue across educational backgrounds ($p < .01$). Integrative leadership training correlated positively with congregational health and retention of young adults during contentious scientific debates.
  ],
  conclusions: [
    Methodological clarity regarding the distinct domains of biblical revelation and empirical inquiry is essential for effective 21st-century ministry. An integrative pastoral curriculum equips leaders to facilitate constructive, faith-affirming dialogue.
  ],
)

// ==============================================================================
// PRELIMINARY PAGES (Numbered in Roman Numerals: i, ii, iii...)
// ==============================================================================

// Exhibit C: Title Page (Takes title, author, degree, date automatically)
#title-page()

// 2. Сторінка копірайту (Copyright Page) — без нумерації між титулкою та схваленням
#copyright-page()

// Exhibit D: Approval Page (Takes committee & dissertation metadata automatically)
#approval-page()

// ---- Switch to Roman numeral page numbering starting at iii ----
#set page(
  numbering: "i",
  footer: context {
    align(center)[
      #text(size: 12pt)[
        #counter(page).display("i")
      ]
    ]
  },
)
#counter(page).update(3)

// Optional Dedication (p. iii)
//#dedication-page[
//  To my family, whose prayerful support and patience made this research possible.
//]

// Exhibit E: Table of Contents (p. iii or iv per manual)
#dmin-toc(show-page-number: true)

// Exhibit F: List of Illustrations & List of Tables (on same page)
#list-of-illustrations()
#list-of-tables(pagebreak: false)

// Exhibit G: List of Abbreviations
#list-of-abbreviations(items: (
  ("AUSS", "Andrews University Seminary Studies"),
  ("BDAG", "Bauer, Danker, Arndt, and Gingrich, Greek-English Lexicon of the New Testament"),
  ("GC", "General Conference of Seventh-day Adventists"),
  ("JATS", "Journal of the Adventist Theological Society"),
  ("TDOT", "Theological Dictionary of the Old Testament"),
  ("WBC", "Word Biblical Commentary"),
))

// Exhibit H: Preface
#preface-page(title: auto)[
  This dissertation represents an effort to bridge the conceptual gap between theological education and empirical scientific developments. The motivation for this research stems from pastoral experiences where parishioners sought biblically faithful yet intellectually robust answers to complex contemporary questions.

  I express profound gratitude to my project advisor, Dr. John A. Smith, whose rigorous mentorship shaped this research, and to the faculty of the Seventh-day Adventist Theological Seminary at Andrews University.
]

// ==============================================================================
// MAIN BODY OF TEXT (Arabic Page Numbering: 1, 2, 3...)
// ==============================================================================

#set page(
  numbering: "1",
  footer: context {
    align(center)[
      #text(size: 12pt)[
        #counter(page).display("1")
      ]
    ]
  },
)
#counter(page).update(1)

// ==============================================================================
// CHAPTER 1 — Exhibit I: Sample page showing spacing, margins, subheadings
// ==============================================================================

#dmin-chapter(
  title: "The Use of Science in Theology:\ Introduction and Historical Background",
)

// Level 1 subhead (centered, bold, title case) — per Exhibit I: "Introduction"
#heading(level: 2)[Introduction]

// Level 2 subhead (centered, not bold, title case)
#heading(level: 3)[The Limits of Science]

Science and religion are arguably the two most powerful forces in human culture. The nature of relations between these forces has been explored and debated for millennia @calvin1960. This dissertation continues that exploration and debate. This first chapter introduces the dissertation in terms of its (1) problem and purpose, (2) problem justification, (3) methodology, and (4) delimitations @knight2001.

For Langdon Gilkey, science and theology are "mutually interdependent" with regard to relations between their types of truth:

#blockquote[
  For both science and religion . . . the question of the relation of each to reality, of the truth each holds, is crucial---for both essentially represent a relation to reality that is cognitive or believed to be so. And thus, because science and religion are mutually interdependent, the issues of the truth of science and the truth of religion and of the relations between these sorts of truth represent fundamental concerns for each. @gilkey1989[p. 11]
]

Now that Gilkey's view of science has been surveyed, the nature of his model for theology and, therefore, for the use of empirical inquiry must be carefully delineated @canale2005.

// Level 3 subhead (left margin, bold, title case) — per Exhibit I: "The Nature of Theology"
#heading(level: 4)[The Nature of Theology]

Seventh-day Adventist theology has maintained a dynamic posture toward scientific developments while upholding the authority of Scripture @andrews2024. In the historical evolution of Adventist higher education, tensions and synthesis were frequently observed @gc1995[p. 112].

// Level 4 subhead (left margin, not bold, sentence case)
#heading(level: 5)[Curricular innovations in ministerial training]

The preparation of pastoral candidates requires intentional pedagogical structures that combine biblical exegetical rigor with contemporary leadership competencies @craigie1983.

// Level 5 subhead (indented, bold, sentence case, run-in, ends with period)
#subhead5[Students feel responsible][When the students actively participate in setting curriculum benchmarks, retention and practical application improve substantially @smith2018. Faculty collaboration plays a pivotal role in designing modular course structures.]

// ==============================================================================
// TABLES AND FIGURES — Chapter 2 (p.7-8) & Chapter 3 (p.13)
// ==============================================================================

#heading(level: 2)[Quantitative Data and Research Visualizations]

The empirical phase of the research gathered data on ministerial student preferences regarding DMin coursework flexibility and mentoring support.

#dmin-table(
  number: 1,
  title: "Factors influencing students' choice of \ Andrews University DMin program (N = 24)",
  table(
    columns: (3.2in, 1.5in),
    stroke: (x, y) => if y == 0 { (bottom: 1pt + black, top: 1pt + black) } else if y == 4 {
      (bottom: 1pt + black)
    } else { none },
    align: (left, right),
    [#text(weight: "bold")[Response Criterion]], [#text(weight: "bold")[Percentage (%)]],
    [Flexible hybrid schedule], [30.2],
    [Faculty mentoring quality], [22.1],
    [Practical ministry relevance], [20.4],
    [Academic reputation], [15.7],
  ),
  note: [Note. Data gathered from DMin cohort survey, Summer 2026.],
)

As illustrated in Table 1, course scheduling flexibility remains the predominant factor determining student enrollment decisions.

#dmin-figure(
  number: 1,
  caption: "Structural components of the \ integrative ministerial formation model.",
  rect(width: 4.5in, height: 1.5in, stroke: 1pt + luma(100), radius: 4pt)[
    #align(center + horizon)[
      #text(weight: "bold")[INTEGRATIVE MINISTERIAL FORMATION MODEL]\
      #v(4pt)
      #text(size: 10pt)[Biblical Exegesis $arrow.r$ Theological Reflection $arrow.r$ Pastoral Praxis]
    ]
  ],
  source: [Source: Adapted from ministerial leadership training guidelines.],
)

// ==============================================================================
// APPENDICES — Chapter 2 (p.11)
// ==============================================================================

#appendix-section(title: "RESEARCH QUESTIONNAIRE", cover-sheet: true)[
  #heading(level: 2)[Ministerial Integration Survey Instrument]

  The following questionnaire was administered to pastoral leaders participating in the DMin research cohort. All responses were collected anonymously.

  1. How often do scientific or faith-science questions arise in your pastoral counseling and preaching?

  2. What hermeneutical models do you find most helpful when addressing cross-disciplinary topics?

]

#appendix-section(title: "LETTERS OF PERMISSION")[
  Official documentation confirming authorization from participating institutional review boards (IRB) and district ministry supervisors to conduct empirical field research.
]

// ==============================================================================
// REFERENCE LIST — Chapter 5 & Appendix A
// ==============================================================================

#dmin-bibliography("../example/references.bib", title: auto)

// ==============================================================================
// VITA — Chapter 2 (p.5/11)
// ==============================================================================

#vita-page()[
  #grid(
    columns: (1.5in, 1fr),
    row-gutter: 12pt,
    [Personal:], [Born in Kyiv, Ukraine. Married with two children.],
    [Education:],
    [
      - D.Min. in Leadership, Andrews University, Berrien Springs, MI, 2026.
      - M.Div., Andrews University Theological Seminary, 2018.
      - B.A. in Theology, Ukrainian Institute of Arts and Sciences, 2014.
    ],

    [Experience:],
    [
      - Senior Pastor, Central Church, 2018--present.
      - Youth Pastor, Dnipro District, 2014--2016.
    ],

    [Publications:],
    [
      - "Integrative Pastoral Formation," *Journal of Applied Christian Leadership* 12, no. 1 (2025): 45--58.
    ],
  )
]

// 3. Порожня кінцева сторінка (Blank Flyleaf Page)
#blank-page()
