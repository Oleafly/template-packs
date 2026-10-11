#import "tufte.typ": *


#show: template.with(
  title: "Title",
  authors: (
    (
      name: "Janik Sperling",
    ),
  ),
  onesided: true,
  numbered_sections:true,
  // points_table: 3,
  toc: true,
  header_content:false,
  text_font: "CMU Bright",
  code_font: "BerkeleyMono Nerd Font",
  math_font: "New Computer Modern Sans Math",
)

#include "content/example.typ"






