#import "template.typ": conf, include-chapters
#import "configs/summary_vertical.typ": print-profile
//#import "configs/exam_notes_horizontal.typ": print-profile

// Optionally: individually fine-tune parameters
// #let print-profile = print-profile + (
//   body-size: 4.6pt,
//   body-leading: 2.1pt,
//   paragraph-spacing: 3.2pt,
//   show-contents: true,
//   chapters-new-page: true,
//   show-cover: true,
//   cover-title: "Document Title",
//   cover-subtitle: "Document Subtitle",
//   cover-authors: ("First Author", "Second Author"),
//   cover-date: "27 September 2026",
//   cover-organization: "Organization",
// )

#show: doc => conf(
  profile: print-profile,
  doc,
)

// Declare each chapter once. With no CLI input, all chapters are included.
#include-chapters((
  (id: "tutorial", path: "/chapters/tutorial.typ"),
))
