#import "lib.typ": thesis
#import "metadata.typ": *
 #import "@preview/abbr:0.2.3"

#set document(title: "", author: "")
#show: thesis.with(
    title: titleEnglish,
    titleGerman: titleGerman,
    degree: degree,
    supervisor: supervisor,
    author: author,
    faculty: faculty,
    professorship: professorship,
    professor: professor,
    submissionDate: submissionDate,
    abstract_body: include "/content/abstract.typ",
    billOfMaterials_body: include "/content/billOfMaterials.typ",
)
#let Introduction = [1 Introduction]

#set page(
  header: align(
    right + horizon,
    Introduction
  ))
#include "/content/introduction.typ"
#pagebreak(to: "odd", weak: false)
#let LiteratureReview = [2 Literature Review]

#set page(
  header: align(
    right + horizon,
    LiteratureReview
  ))
#include "/content/LiteratureReview.typ"
#pagebreak(to: "odd", weak: false)
#let Requirements = [3 Requirements]

#set page(
  header: align(
    right + horizon,
    Requirements
  ))
#include "/content/Requirements.typ"
#pagebreak(to: "odd", weak: false)
#let Architecture = [4 Architecture]

#set page(
  header: align(
    right + horizon,
    Architecture
  ))
#include "/content/Architecture.typ"
#pagebreak(to: "odd", weak: false)
#let DesignAndImplementation = [5 Design and Implementation]

#set page(
  header: align(
    right + horizon,
    DesignAndImplementation
  ))
#include "/content/DesignAndImplementation.typ"
#pagebreak(to: "odd", weak: false)
#let Evaluation = [6 Evaluation]

#set page(
  header: align(
    right + horizon,
    Evaluation
  ))
#include "/content/Evaluation.typ"
#pagebreak(to: "odd", weak: false)
#let Conclusions = [7 Conclusions]

#set page(
  header: align(
    right + horizon,
    Conclusions
  ))
#include "/content/Conclusions.typ"
#pagebreak(to: "odd", weak: false)
#let FutureWork = [8 Future Work]

#set page(
  header: align(
    right + horizon,
    FutureWork
  ))
#include "/content/FutureWork.typ"

