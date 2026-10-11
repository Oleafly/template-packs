/*
 * Education component
 */

#import "../layout/generic.typ": generic-two-by-two

#let edu(
  institution: "",
  school: "",           // 院所/系名
  dates: "",
  degree: "",
  gpa: "",
  location: "",
  compact: false,       // 紧凑模式：institution 和 school 在一行（适合中文）
  consistent: false,
) = {
  let bottom-left-content = if gpa != "" {
    [#degree, GPA: #gpa]
  } else {
    degree
  }

  if school != "" {
    if compact {
      // 紧凑模式：institution + school 在一行
      // Line 1: institution (加粗)  school # location # dates
      // Line 2: degree
      [
        #strong(institution)  #school #h(1fr) #location \
        #bottom-left-content #h(1fr) #emph(dates)
      ]
    } else {
      // 默认模式：3 行布局（适合英文）
      // Line 1: institution + location
      // Line 2: school (italic) + dates
      // Line 3: degree [+ gpa]
      [
        #strong(institution) #h(1fr) #location \
        #emph(school) #h(1fr) #emph(dates) \
        #bottom-left-content
      ]
    }
  } else {
    // Without school: 2 lines (original style)
    if consistent {
      [
        #strong(institution) #h(1fr) #emph(dates) \
        #bottom-left-content #h(1fr) #location
      ]
    } else {
      [
        #strong(institution) #h(1fr) #location \
        #bottom-left-content #h(1fr) #emph(dates)
      ]
    }
  }
}
