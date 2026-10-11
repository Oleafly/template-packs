// ======================================================
// CHAPTER 3 — Design and Analysis (Template Demo)
// ------------------------------------------------------
// Replace the content below with your own system
// design, requirements analysis, and diagrams.
// ======================================================

#import "../_templates/chapter.typ": *
#import "../constant.typ": *
#import "../_lib/utils.typ": (
  definition, figureref, note, tableref, titleref,
)

#let chapter_title = [Design and Analysis]

#let fakepar = context {
  box()
  v(-measure(block() + block()).height)
}

#show heading.where(level: 2): it => {
  text(size: 14pt, weight: "bold")[#it]
  fakepar
}
#show heading.where(level: 3): it => {
  text(size: 12pt, weight: "bold", style: "italic")[#it]
  fakepar
}
#show heading.where(level: 4): it => {
  text(size: 12pt, style: "italic")[#it]
  fakepar
}

#let chapter_body = [
  #text(size: 14pt, weight: "bold")[Introduction]
  #lvl_4_ab_lvl_2_dwn
  #fakepar
  #text()[
    This chapter presents the design and analysis phase of the project. A rigorous
    requirements analysis is essential to building a well-structured system. Accordingly,
    we define the functional and non-functional requirements, model system actors, and
    outline the core use cases.
  ]

  #lvl_2_ab
  #heading(depth: 2)[Requirements Overview] <sec:requirements>
  #lvl_4_ab_lvl_2_dwn
  #text()[
    In software development, early-phase decisions impact the codebase and future features
    in the long run. Requirements analysis is a crucial step where the needs and expectations
    of users and stakeholders are identified and documented.

    #definition()[
      *Functional requirements* define the specific features and operations a system must
      perform to meet business and user needs.
    ]

    #definition()[
      *Non-functional requirements* define how a system should operate, focusing on
      performance, reliability, and user experience.
    ]
  ]

  #lvl_2_ab
  #heading(depth: 2)[System Architecture]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    Describe the overall architecture of your system. Include diagrams, component
    descriptions, and the rationale for key design decisions.

    The architecture follows a modular approach with clear separation of concerns
    between layers. This ensures maintainability, testability, and scalability.
  ]

  #lvl_2_ab
  #heading(depth: 2)[Use Cases]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    Identify the main actors and their interactions with the system. Describe the core
    use cases that drive the functionality of your application.

    #list(
      [Use case 1: description of the first primary use case],
      [Use case 2: description of the second primary use case],
      [Use case 3: description of the third primary use case],
    )
  ]

  #lvl_2_ab
  #heading(depth: 2)[Database Design]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    Present the database schema, entity relationships, and key design decisions for
    the data layer. Include an ER diagram if available.

    #note()[
      Ensure that your database design respects normalization principles and
      supports the query patterns required by your application.
    ]
  ]
]

#set document(title: chapter_title)

#chapter_page("3", chapter_title)[
  #chapter_body
]
