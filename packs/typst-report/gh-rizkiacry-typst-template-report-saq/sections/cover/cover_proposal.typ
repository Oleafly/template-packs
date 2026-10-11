#import "../../config.typ": *

#page(
  numbering: none,
  header: none,
  footer: none,
)[
  #align(horizon + center)[
    #text(1.2em, weight: "bold")[#upper[
      #context {
        let current_page = counter(page).get().first()
        if current_page == 1 {
          report_type
        } else {
          report_type2
        }
      }
    ]]
    \
    #text(1.2em, weight: "bold")[#upper[#title_block]]
    #image("../../media/logo_saq.jpg", width: 3in)
    #align(left)[
      #pad(left: 4cm)[
        #grid(
          columns: (auto, auto, 1fr),
          row-gutter: 1em,
          column-gutter: 1em,
          [NAMA], [:], [#author_name],
          [NIM], [:], [#author_id],
          [KELAS], [:], [#author_class],
          [DOSEN], [:], [#advisor_name],
          [NO. PC], [:], [#author_pc],
          [ASISTEN], [:], [#reviewer_names.first()],
          ..for name in reviewer_names.slice(1) {
          ([], [:], [#name])
        }
        )
      ]
    ]
    #text(weight: "bold")[
      #upper[
        \
        \
        #faculty_of_study\
        #program_of_study\
        #campus_name \
        #year
      ]
    ]
  ]
]

