#import "../config.typ": *

// Apply cover page specific margins (LaTeX specification)
#set page(
  margin: (
    left: cover_left_margin, 
    right: cover_right_margin, 
    top: cover_top_margin, 
    bottom: cover_bottom_margin
  ),
  header: none,
  footer: none
)

#grid(
  columns:(1fr,2.5fr,1fr),
  fill:none,
  column-gutter: 2pt,
  align(left+horizon)[#image("../images/logo_ISI.png",width: 3cm)],
  align(center)[
    #v(5pt)
    // Institution text with \footnotesize and \textbf (LaTeX specification)
    #set text(size: 9pt, weight: "bold")
    #republic\
    #v(4pt)
    #ministry\
    #v(4pt)
    #university\
    #v(4pt)
    #institute\
  ],
  align(right+horizon)[#image("../images/logo_UTM.png",width: 3cm)]
)
#v(1cm)
// Main title: \LARGE with \textbf and \textsc (LaTeX specification)
#align(center)[#text(size: 18pt, weight: "medium")[#smallcaps(report_title)]]
#v(1cm)
#align(center)[
  #box(width: 80%)[
    #text(size: 12pt, weight:"medium")[#report_subtitle]
  ]
]
#v(0.3cm)
#align(center)[#text(size: 12pt,weight:"medium")[Major: #specialty ]]
#v(0.3cm)
#align(center)[#text(size: 12pt)[ By ]]
#v(0.3cm)
#align(center)[#text(size: 12pt,weight:"medium")[#student_name ]]
#v(1cm)

#stack(
  spacing: 0.5cm,
  line(
    length:100%,
    stroke: (paint: isi_blue, thickness: 4pt, cap: "round")  // Using ISI blue
  ),
  grid(
    columns:(10pt,1fr,10pt),
    fill:none,
    [],
    [
      #align(center)[
        // Report title box: \huge with \textbf (LaTeX specification)
        #text(size: 20pt, weight: "medium")[ #project_title ]
      ]
    ],
    []
  ),
  line(
    length:100%,
    stroke: (paint: isi_blue, thickness: 4pt, cap: "round")  // Using ISI blue
  ),

)

#v(1cm)

#stack(
  spacing: 0.5cm,
  // Supervisors section: \large (LaTeX specification)
  align(center)[#text(size: 14pt)[Professional Supervisor: #professional_supervisor ]],
  align(center)[#text(size: 14pt)[Academic Supervisor: #academic_supervisor ]],
  v(1cm),
  align(center)[#text(size: 12pt)[Developed within #company ]],  // Fixed typo: "withing" -> "within"
  v(1cm),
  align(center)[#image("../images/company_logo.png", width: 4cm)],
)

// Academic year at bottom (LaTeX cover page specification)
#place(bottom + center)[
  #text(size: 10pt)[Academic Year: #report_date ]
]
