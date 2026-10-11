// ================================ //
//           UI LABELS              //
// Translate or adjust display text //
// without touching layout files.   //
// ================================ //

#let labels = (
  // ---- Section headings ---- //
  toc:           "Table of Contents",
  abstract:      "Abstract",
  abstract-title: "Abstract",
  abbreviations: "List of Abbreviations",
  figures:       "List of Figures",
  tables:        "List of Tables",
  listings:      "List of Listings",
  bibliography:  "References",
  appendix:      "Appendix",
  // Singular supplements for cross-references (@fig, @tab, @lst)
  supplement-figure:  "Figure",
  supplement-table:   "Table",
  supplement-listing: "Listing",

  // ---- Document type names ---- //
  doc-names: (
    project:       "Project Work",
    project-doc:   "Project Documentation",
    term-paper:    "Term Paper",
    bachelor:      "Bachelor Thesis",
    seminar:       "Seminar Paper",
  ),

  // ---- Title page – metadata labels ---- //
  meta-course:             "Course:",
  meta-mat-number:         "Student ID:",
  meta-partner:            "Dual Partner:",
  meta-company-supervisor: "Project Supervisor:",   // company-side supervisor (toggleable)
  meta-supervisor:         "Academic Supervisor:",
  meta-date:               "Submission Date:",

  // ---- Title page – institutional text ---- //
  program-prefix: "of the study programme",
  university:     "at DHBW Ravensburg",
  by:             "by",

  // ---- Confidentiality notice & declaration – shared ---- //
  place-date: "Place, Date",
  signature:  "Signature",

  // ---- Confidentiality notice ---- //
  confidentiality-title: "Confidentiality Notice",
  confidentiality-law:   [pursuant to Section 1.1.13 of Annex 1 to §§ 3, 4 and 5 of the
    Study and Examination Regulations for Bachelor's Degree Programmes of the
    Baden-Württemberg Cooperative State University dated 29 September 2017:],
  confidentiality-body:  [The contents of this thesis may not be disclosed in whole or in part to persons
    outside the examination and evaluation process without prior consent from
    the dual partner.],

  // ---- Declaration of independence ---- //
  declaration-title: "Declaration of Independent Work",
  declaration-intro: "I hereby declare that I have written the present",
  declaration-theme: "with the title",
  declaration-body:  [independently and without using any sources or aids other than those cited,
    and that this thesis has not been submitted for any other examination with
    the same or comparable content and has not been previously published.
    I further declare that the electronic version submitted
    is identical to the printed copy.],

  // ---- Appendix – AI tools table (data/ai-tools.typ) ---- //
  appendix-ai-heading: "A1: Overview of AI Tools Used",
  appendix-ai-caption: "Overview of the use of AI-based tools",
  appendix-ai-col1:    "Tool",
  appendix-ai-col2:    "Description of Use",

  // ---- AI declaration (pages/ai-declaration.typ) ---- //
  ai-declaration-title: "Declaration and Usage Documentation on the Use of AI-Based Tools in the Preparation of Academic Work as Examination Performance",
  ai-declaration-intro: [Regarding the use of AI-assisted tools, #underline[I declare with knowledge of the information sheet] "Notes on the Use of AI-Based Tools in the Preparation of Academic Work as Examination Performance in the Examination Law Context" the following:],
  ai-declaration-items: (
    [I have actively informed myself about the capabilities and limitations of the AI tools used in my work.],
    [Throughout the preparation of the work, I have worked independently and, when using AI-assisted tools, in a predominantly directing manner.],
    [In particular, I have either taken the content from scientific or other permitted sources and cited them accordingly, or developed it myself using scientific methods.],
    [I am aware that as the author of the work, I bear full responsibility for the information and statements made in it.],
    [To the extent that I have used AI-assisted tools in the preparation of the work, these are #underline[fully] disclosed in the AI index at the end of the work, including product names, formulated inputs (prompts), intended uses, and the corresponding page/section references, and are documented in the text (e.g. as a footnote).],
  ),
)
