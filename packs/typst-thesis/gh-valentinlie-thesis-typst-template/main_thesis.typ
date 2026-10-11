// ============================================================

// Official template of
// - CHAIR OF DATA SCIENCE: MACHINE LEARNING AND DATA ENGINEERING
// - CHAIR OF DIGITAL INNOVATION AND THE PUBLIC SECTOR
// - CHAIR OF SOFTWARE ENGINEERING

// ============================================================

#import "settings/wi-thesis.typ": *

// xxxxxxxxx  FIRST ADJUST THE FOLLOWING OPTIONS xxxxxxxxx

// a) the language of your thesis to either "english" or "german",
// b) the type of the thesis to either "bachelor", "master" or "seminar",
// c) the chair:
//    "csssa" for Computational Social Science & Systems Analysis,
//    "machineLearning" for the Chair of Machine Learning and Data Engineering,
//    "datascience" if the thesis is supervised by both CSSSA & Machine Learning,
//    "dips" for the Chair of Digital Innovation and the Public Sector,
//    "bpm" for the Chair of Information Systems and Business Process Management,
//    "SE" for the Chair of Software Engineering
// d) and if the supervisor is equal to the principal supervisor
//    d1) It is possible that your thesis is supervised only by a postdoc and there
//        is no supervising professor, then use "postdoc"
//        --> e.g. Dr. Püchel, Dr. Lechtenbörger, Dr. Haskamp, ...
//    d2) else if there is a professor and a supervisor use "supervisor".
// e) Whether you want to publish your thesis under a free and open license or not
//    (https://creativecommons.org/licenses/by-sa/4.0/legalcode)
//    -> appears on the same page as the declaration of authorship
// f) If you are writing a thesis jointly with other students, set multiauthor to
//    true for (seminar) papers with multiple authors.
// g) sansserif: true to set a Sans Serif Font (Serif font is standard)
// h) sectionquestions: true to use and show the #sectionquestions[] boxes

#show: wi-thesis.with(
  language: "english", // "german" "english"
  thesis: "seminar", // "seminar" "bachelor" "master"
  chair: "machineLearning", // "csssa" "machineLearning" "datascience" "dips" "bpm" "SE"
  supervisor-mode: "supervisor", // "supervisor" "postdoc"
  license: "cc-by-sa", // "cc0" "cc-by" "cc-by-sa" [or none]
  multiauthor: false, // true false
  sansserif: false, // true false - for fonts without serifs
  sectionquestions: false, // true false - true to display the #sectionquestions[] boxes

  // ============================================================
  // Include all relevant information for the title page

  title: [Title of an Awesome Thesis Which Will Change the World and Reveal
    Incredible Insights Into Highly Relevant Topics],
  // Please be aware that if you write a seminar thesis, the title of the thesis
  // should be limited to three lines. If yours is too long, please discuss the
  // issue with your supervisor, since it will not fit on the titlepage anymore.

  // If multiple authors write a (seminar) paper, separate names with commas or
  // line breaks (\). Examples are given as comments below.
  // Address information is not used with multiple authors.
  author: "First Middle Last Name",
  // author: "Maja Mustermann, Max Musterfrau",
  // author: [First Middle Last Name \ Second Student with somewhat longer Name],

  email: "student_01@uni-muenster.de",
  // email: "{student1,student2}@uni-muenster.de",

  // Matriculation Number
  id: "123456",
  // id: "123456, 234567",

  // Field of Study
  field: "Information Systems",

  // Address, for declarations at the end of the thesis.
  city: "Münster",

  // Information about the thesis and the course

  // If you write a thesis which is supervised by both chairs of Data Science
  // (=> you selected chair: "datascience" above), then you can include the
  // second professor by adding a comma and the name of the second professor.
  professor: "Prof. Dr. Albert Einstein",

  supervisor: "Supervisor, M.Sc.",

  // You only have to include the course if you are writing a seminar thesis
  course: "Name of the Seminar",

  // Submission Date
  date: "31.01.2026",

  // Uncomment the following part if you need an abstract
  // abstract: include "content/00-abstract.typ",

  // Confidentiality Statement: Only add this if you write your thesis together
  // with a company and your thesis contains sensitive or confidential
  // information, e.g. confidential: "<your company>",
  confidential: none,

  // Add bibliography
  bibliography: bibliography("library.bib"),
)

// ============================================================

// In this template, lists of figures, tables, abbreviations etc. are not
// required. Don't add them, only if your supervisor explicitly demands them.
// In this case, include them here, e.g. via
//   #outline(title: [List of Figures], target: figure.where(kind: image))

// Add content files via #include. Put the files in the "content" folder.

#include "content/01-introduction.typ"
#include "content/02-chapter1.typ"
#include "content/03-chapter2.typ"
// .....
#include "content/10-conclusion.typ"

// Comment this part out if you do not need an appendix.
#show: appendix
#include "content/99-appendix.typ"

// The bibliography, the declaration of authorship and the consent form are
// added automatically after the last chapter.

// ============================================================
