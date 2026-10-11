// FHNW Thesis - main entrypoint
//
// For local development this imports the template from the local source tree.
// Once published to Typst Universe, swap to the package import below.

#import "../main.typ": *
// #import "@preview/fhnw-thesis:0.1.0": *

#show: thesis.with(
  draft: true,
  colored: true,

  title: "Thesis Template in Typst",
  subtitle: "A Demonstration of the FHNW Thesis Template",
  author: "Your Name",
  email: "your.email@students.fhnw.ch",
  student-id: "XX-XXX-XXX",

  supervisor: "Prof. Dr. Jane Doe",
  expert: "Prof. Dr. John Smith",

  thesis-type: "Bachelor Thesis",
  university: "University of Applied Sciences and Arts Northwestern Switzerland",
  school: "School of Computer Science",
  institute: "Institute of Mobile and Distributed Systems",
  location: "Brugg-Windisch, Switzerland",
  date: datetime.today(),
  language: "en",

  abstract: [
    This document demonstrates the FHNW thesis template for Typst. It walks
    through all available features -- title page, table of contents, chapters,
    figures, tables, mathematical formulas, citations, custom environments, and
    draft-mode TODO markers -- so you can start writing your own thesis.
  ],

  acknowledgments: [
    I would like to thank my supervisor for their guidance throughout this
    project, as well as the Institute of Mobile and Distributed Systems at FHNW
    for providing
    the resources that made this work possible.
  ],

  chapters: (
    include "content/introduction.typ",
    include "content/background.typ",
    include "content/methodology.typ",
    include "content/implementation.typ",
    include "content/evaluation.typ",
    include "content/discussion.typ",
    include "content/conclusion.typ",
    include "content/future_work.typ",
  ),

  appendices: (
    include "content/appendix.typ",
  ),

  bibliography-content: bibliography("references.bib", style: "ieee", title: none),
)
