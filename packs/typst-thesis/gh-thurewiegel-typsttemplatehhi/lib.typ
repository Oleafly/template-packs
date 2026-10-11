#let declaration-of-independent-processing = {
  include "pages/declaration_of_independent_processing.typ"
}

#let report(
  thesis: "Report",
  cover-logo-left: "../assets/logos/UPlogo.png",
  cover-logo-left-width: 90pt,
  cover-logo-right: "../assets/logos/HHIlogo.png",
  cover-logo-right-width: 170pt,
  cover-page-margin: (left: 22mm, right: 22mm, top: 18mm, bottom: 20mm),
  cover-main-text-size: 23pt,
  university-name: "University of Potsdam",
  cover-institute-line: "Thesis conducted at the Fraunhofer Heinrich Hertz Institute (Fraunhofer HHI), Berlin",
  title: "",
  author: "",
  faculty: "",
  supervisors: (),
  submission-date: none,
  before-content: none,
  after-content: none,
  body,
) = {
  import "template.typ": template
  template(
    is-thesis: false,
    thesis: thesis,
    cover-logo-left: cover-logo-left,
    cover-logo-left-width: cover-logo-left-width,
    cover-logo-right: cover-logo-right,
    cover-logo-right-width: cover-logo-right-width,
    cover-page-margin: cover-page-margin,
    cover-main-text-size: cover-main-text-size,
    university-name: university-name,
    cover-institute-line: cover-institute-line,

    title: title,
    keywords: none,
    abstract: none,

    author: author,
    faculty: faculty,
    study-course: none,
    supervisors: supervisors,
    submission-date: submission-date,
    before-content: before-content,
    after-content: after-content,
    body,
  )
}

#let bachelor-thesis(
  thesis: "Bachelor Thesis",
  cover-logo-left: "../assets/logos/UPlogo.png",
  cover-logo-left-width: 90pt,
  cover-logo-right: "../assets/logos/HHIlogo.png",
  cover-logo-right-width: 170pt,
  cover-page-margin: (left: 22mm, right: 22mm, top: 18mm, bottom: 20mm),
  cover-main-text-size: 23pt,
  university-name: "University of Potsdam",
  cover-institute-line: "Thesis conducted at the Fraunhofer Heinrich Hertz Institute (Fraunhofer HHI), Berlin",
  title: "",
  keywords: none,
  abstract: none,
  author: "",
  faculty: "",
  study-course: "",
  supervisors: (),
  submission-date: none,
  before-content: none,
  after-content: none,
  body,
) = {
  import "template.typ": template
  template(
    is-thesis: true,
    thesis: thesis,
    cover-logo-left: cover-logo-left,
    cover-logo-left-width: cover-logo-left-width,
    cover-logo-right: cover-logo-right,
    cover-logo-right-width: cover-logo-right-width,
    cover-page-margin: cover-page-margin,
    cover-main-text-size: cover-main-text-size,
    university-name: university-name,
    cover-institute-line: cover-institute-line,

    title: title,
    keywords: keywords,
    abstract: abstract,

    author: author,
    faculty: faculty,
    study-course: study-course,
    supervisors: supervisors,
    submission-date: submission-date,
    before-content: before-content,
    after-content: after-content,
    body,
  )
}

#let master-thesis(
  thesis: "Master Thesis",
  cover-logo-left: "../assets/logos/UPlogo.png",
  cover-logo-left-width: 90pt,
  cover-logo-right: "../assets/logos/HHIlogo.png",
  cover-logo-right-width: 170pt,
  cover-page-margin: (left: 22mm, right: 22mm, top: 18mm, bottom: 20mm),
  cover-main-text-size: 23pt,
  university-name: "University of Potsdam",
  cover-institute-line: "Thesis conducted at the Fraunhofer Heinrich Hertz Institute (Fraunhofer HHI), Berlin",
  title: "",
  keywords: none,
  abstract: none,
  author: "",
  faculty: "",
  study-course: "",
  supervisors: (),
  submission-date: none,
  before-content: none,
  after-content: none,
  body,
) = {
  import "template.typ": template
  template(
    is-thesis: true,
    thesis: thesis,
    cover-logo-left: cover-logo-left,
    cover-logo-left-width: cover-logo-left-width,
    cover-logo-right: cover-logo-right,
    cover-logo-right-width: cover-logo-right-width,
    cover-page-margin: cover-page-margin,
    cover-main-text-size: cover-main-text-size,
    university-name: university-name,
    cover-institute-line: cover-institute-line,

    title: title,
    keywords: keywords,
    abstract: abstract,

    author: author,
    faculty: faculty,
    study-course: study-course,
    supervisors: supervisors,
    submission-date: submission-date,
    before-content: before-content,
    after-content: after-content,
    body,
  )
}
