// ======================================================
// CHAPTER 2 — Host Organization & Project Context
// ------------------------------------------------------
// Replace the text below with your own organization
// context and project background.
// ======================================================

#import "../_templates/chapter.typ": *
#import "../_lib/utils.typ": definition, note
#import "../constant.typ": *

#let chapter_title = [Host Organization and Project Context]

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
  #text(size: 14pt, weight: "bold")[Introduction]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    This chapter presents the institutional and project context in which this work took
    place. It introduces the host organization, the project framework, and the objectives
    that guided the development process.
  ]
  #lvl_2_ab
  #heading(depth: 2)[Host Organization]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    Your host organization is a company or institution that provided the environment and
    resources for this project. Describe its core business, history, and relevance to
    your work.

    Include details about the organization's size, market position, and the specific
    department or team you worked with during the project.
  ]
  #lvl_2_ab
  #heading(depth: 2)[Project Context and Objectives]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    Describe the broader context that motivated this project. What problem does it solve?
    Why is it important? What are the main objectives?

    The objectives of this project are:
    #list(
      spacing: 1.5em,
      [Objective 1: describe the first goal],
      [Objective 2: describe the second goal],
      [Objective 3: describe the third goal],
    )
  ]
  #lvl_2_ab
  #heading(depth: 2)[Methodology Overview]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    Briefly describe the methodology adopted for this project. This could include Agile
    practices, project management tools, collaboration workflows, and development
    processes.

    #note()[
      Refer to the Methodology chapter for a detailed comparison of different
      development methodologies and the rationale for your choice.
    ]
  ]
]

#set document(title: chapter_title)

#chapter_page("2", chapter_title)[
  #chapter_body
]
