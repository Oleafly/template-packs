// ======================================================
// CHAPTER 1 — General Introduction (Template Demo)
// ------------------------------------------------------
// This file demonstrates a basic chapter using the
// chapter template with simple paragraph content.
// ======================================================

#import "../_templates/chapter.typ": *
#import "../constant.typ": *

#let chapter_title = [General Introduction]

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
  #fakepar
  #text()[
    This chapter provides a general introduction to the project. It presents the context,
    the problem statement, and the objectives that guided this work.

    The following sections outline the background of the project, the motivation behind it,
    and the structure of the remainder of this report.
  ]
  #lvl_2_ab
  #heading(depth: 2)[Project Context]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt
    ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
    laboris nisi ut aliquip ex ea commodo consequat.

    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
    pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt
    mollit anim id est laborum.
  ]
  #lvl_2_ab
  #heading(depth: 2)[Problem Statement]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    The main challenge addressed in this project is the need for a scalable, secure, and
    maintainable solution that meets modern requirements. This involves careful analysis of
    requirements, selection of appropriate technologies, and implementation following best
    practices.

    The project aims to deliver a production-ready system that can serve as a foundation for
    future development and extension.
  ]
  #lvl_2_ab
  #heading(depth: 2)[Report Organization]
  #lvl_4_ab_lvl_2_dwn
  #text()[
    The remainder of this report is organized as follows:
  ]
  #list(
    [*Chapter 1* introduces the project context, objectives, and methodology.],
    [*Chapter 2* presents the analysis and design of the system.],
    [*Chapter 3* covers the architecture, infrastructure, and implementation.],
    [*Chapter 4* provides a comprehensive reference of all template elements.],
  )
]

#set document(title: chapter_title)

#chapter_page("1", chapter_title)[
  #chapter_body
]
