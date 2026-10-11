// ======================================================
// CONCLUSION (Template Demo)
// ------------------------------------------------------
// Replace the content below with your own conclusion,
// summary of contributions, and future perspectives.
// ======================================================

#import "../_templates/chapter.typ": *
#import "../constant.typ": *

#let chapter_title = [Conclusion and Perspectives]

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

#let chapter_body = [
  #text()[
    #fakepar
    This work represents the culmination of a project aimed at designing, developing, and
    deploying a modern digital solution. Throughout the previous chapters, we described
    the project context, system design, methodology, architecture, and implementation.

    This project does not mark an endpoint but rather the foundation for a robust platform
    capable of handling complex workflows and real-world requirements.
  ]

  #heading(depth: 2)[Summary of Contributions]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    The main contributions of this work are:
    #list(
      [Design and implementation of a modular, scalable architecture],
      [Development of core features and API endpoints],
      [Integration with external services and third-party tools],
      [Automated testing and CI/CD pipeline setup],
      [Deployment on cloud infrastructure],
    )
  ]

  #heading(depth: 2)[Limitations]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    Despite the achievements, some limitations remain:
    #list(
      [Limitation 1: describe a current limitation],
      [Limitation 2: describe another limitation],
      [Limitation 3: describe a third limitation],
    )
  ]

  #heading(depth: 2)[Future Perspectives]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    Several improvements and extensions are envisioned:
    #list(
      [Enhancement 1: describe a planned improvement],
      [Enhancement 2: describe another improvement],
      [Enhancement 3: describe a third improvement],
      [Enhancement 4: describe a fourth improvement],
    )
  ]

  #heading(depth: 2)[Final Remarks]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    This project demonstrates the effective application of modern development practices
    to build a production-ready system. The knowledge gained and the foundation laid
    during this work will serve as a springboard for future innovation and development.
  ]
]

#set document(title: chapter_title)

#chapter_page("5", chapter_title)[
  #chapter_body
]
