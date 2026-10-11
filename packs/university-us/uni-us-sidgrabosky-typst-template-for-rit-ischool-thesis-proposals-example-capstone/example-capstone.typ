#import "rit-ischool-template.typ": *

#show: rit-ischool-capstone.with(
  title: "The Title of the Project",
  // display-title: [The Title of the\n Project],  // Uncomment to provide an alternate main title version. Useful if you want to control linebreaks manually.
  author: "Student's Name",
  degree-type: "Master of Science",
  degree-symbol: "M.S.",

  committee-chair: "Dr. Felix Frankfurter",
  chair-title: "Assistant Professor",
  reader: "Dr. Learned Hand\nAssociate Professor",
  // observer: "Dr. Earl Warren\nProfessor", // Uncomment if you have an observer

  grant-month: "May",
  grant-year: "2024",
  copyright-year: 2024,

  is-project: true,     // Set to false for thesis
  is-proposal: true,    // Set to false for final report
  include-copyright: false,
  include-figures-list: true,
  include-tables-list: true,

  // previous-degrees: "B.S. Computer Science, Some University, 2022", // Optional

  // Abstract content
  abstract: [
    This should be a short description of the work and the results: about 250 words in a paragraph or two summarizing your project. Note that abstracts are meant to be read independently from the rest of the project report so you cannot cite your paper or other papers in it. It would be useful to examine other abstracts in the papers you have read to understand what an abstract really is.

    In the proposal, the abstract should just say what you will do. In the report, the abstract must say what you did briefly. This template can be used for both the proposal and the report.
  ]
)

// Optional: Dedication page
#dedication-page[
  To whomever ...
]

// Optional: Acknowledgments page
#acknowledgments-page[
  I am grateful for ...
]


// Main document content starts here

= Introduction

Briefly tell why the problem is important and the solution is beneficial. Introduce the remaining sections, giving a brief overview of each.

Citations can be added using the `@label` syntax (e.g., `@dumont2007` or `@silberschatz2005`) once you have a bibliography file setup.

And here are examples of how to include figures, such as @fig:ischoollogo, and tables in the text. Please note that the captions go below for figures and above for tables.

#figure(
  image("iSchoolLogo.png", width: 3in),
  caption: [The iSchool Logo is Above]
) <fig:ischoollogo>

Here's an example of a table:

#figure(
  table(
    columns: 3,
    [*Column 1*], [*Column 2*], [*Column 3*],
    [Row 1], [Data], [More Data],
    [Row 2], [Data], [More Data],
  ),
  caption: [This is an example table]
) <table:example>

// You can include code blocks like this:
```python
def hello_world():
    print("Hello, World!")
```

// Or inline code like this: `print("Hello")`

= Related Work

This section should describe previous work that relates to your project. Briefly explain how each piece of work relates to your project and indicate how your work differs from it.

= Methodology

This section describes how you will approach your project (for proposals) or how you approached your project (for final reports). This is where you describe the tools, techniques, algorithms, etc. that you will use or used.

// For proposals, include timeline:
= Timeline

#figure(
  table(
    columns: 2,
    align: (left, left),
    [*Task*], [*Timeline*],
    [Literature Review], [Weeks 1-3],
    [System Design], [Weeks 4-6],
    [Implementation Phase 1], [Weeks 7-10],
    [Implementation Phase 2], [Weeks 11-14],
    [Testing and Evaluation], [Weeks 15-16],
    [Final Report], [Weeks 17-18],
  ),
  caption: [Project Timeline]
) <table:timeline>

// For final reports, replace timeline with results and conclusion:
/*
= Results

This section presents the results of your project. Include figures, tables, and analysis as appropriate.

= Conclusion

This section summarizes your project, discusses what worked well, what didn't work as expected, and what future work could be done.
*/

// Bibliography
#pagebreak()
= References <references>

// Note: You'll need to create a bibliography file (references.bib or references.yml)
// For now, here's a manual bibliography as an example:

Dumont, J. (2007). Sample paper title. _Journal of Sample Research_, 15(3), 123-145.

Silberschatz, A., Galvin, P. B., & Gagne, G. (2005). _Operating System Concepts_ (7th ed.). John Wiley & Sons.

// Appendices (optional)
#pagebreak()
= Appendix A

Additional material that supports your project but is too detailed for the main body.

= Appendix B

More additional material.

= Appendix C

Even more additional material.