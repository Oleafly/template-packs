#import "utils.typ": fill_instance_with_default

#let EDUCATION = (
  degree: none,
  honors: none,
  field: none,
  university: (long: none, short: none),
  start: none,
  end: none,
  thesis: none,
  minor: (field: none, text: none),
  advisors: none
)

#let read_education(filename) = {
  let result = yaml(filename)
  for (key, education) in result {
    let filled_education = fill_instance_with_default(education, default: EDUCATION)
    result.insert(key, filled_education)
  }
  result
}

#let education(e, university_long: true, thesis: true, minor: true, advisor: true, honors: true) = {
  let university = if university_long {
     e.university.long
  } else {
    e.university.short
  }

  let left_txt = if (honors == true) and (e.honors == none) {
    [#text(weight:"bold", e.degree), #text(style: "italic", e.field), #university]
  } else {
    [#text(weight:"bold", e.degree) #e.honors, #text(style: "italic", e.field), #university]
  }

  let right_txt = if (e.start != none) {
    if (e.end != none) [
      #e.start #sym.dash #e.end
    ] else [
      #e.start
    ]
  } else {
    if (e.end != none) [
      #e.end
    ]
  }

  let thesis_txt = if (thesis == true) and (e.thesis != none) [
    - _Thesis_: #e.thesis
  ] else {
    none
  }

  let minor_txt = if (minor == true) and (e.minor != none) {
    if (e.minor.field != none) {
      if (e.minor.text != none) [
        - _Minor_: #text(weight: "semibold", e.minor.field) (#e.minor.text)
      ] else [
        - _Minor_: #text(weight: "semibold", e.minor.field)
      ]
    } else {
      if (e.minor.text != none) [
        - _Minor_: #e.minor.text
      ]
    }
  }

  let advisor_txt = if (advisor == true) and (e.advisors != none) {
    if (e.advisors.len()) == 1 [
      - _Advisor_: #e.advisors.join(", ")
    ] else [
      - _Advisors_: #e.advisors.join(", ")
    ]
  }

  grid(columns: (3fr, 1fr), column-gutter: 0.25fr, row-gutter: 0.5em,
       [#align(left, left_txt)], [#align(right, right_txt)])

  thesis_txt
  minor_txt
  advisor_txt
}
