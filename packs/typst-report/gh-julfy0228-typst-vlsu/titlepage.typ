#let titlepage(
  title: content,
  discipline: content,
  theme: content,
  students: array,
  teacher: dictionary,
  doc
) = {
  let get-gender(person) = {
    if "gender" in person and person.gender == "female" {
      "female"
    } else {
      "male"
    }
  }

  let format-students(students_data) = {
    let students = if type(students_data) == dictionary {
      (students_data,)
    } else if students_data.len() == 0 {
      ()
    } else {
      students_data
    }

    let count = students.len()
    if count == 0 { return [] }

    let header = if count == 1 {
      let gender = get-gender(students.first())
      if gender == "female" { "Выполнила:" } else { "Выполнил:" }
    } else {
      "Выполнили:"
    }
    
    let groups = (:)
    for s in students {
      let g = s.group
      let current = if g in groups { groups.at(g) } else { () }
      let new = current + (s.name,)
      groups.insert(g, new)
    }
    
    let result = [*#header* \ ]
    for (group, names) in groups {
      let line = if names.len() == 1 {
        "студент гр. " + group
      } else {
        "студенты гр. " + group
      }
      result += [#line \ ]
      for (i, name) in names.enumerate() {
        if i == names.len() - 1 {
          result += [  #name \ ]
        } else {
          result += [  #name, \ ]
        }
      }
    }
    return result
  }

  let format-teacher(teacher) = {
    let gender = get-gender(teacher)
    let header = if gender == "female" { "Приняла:" } else { "Принял:" }

    let title = if "position" in teacher and teacher.position != "" {
      teacher.position + "\n"
    } else {
      ""
    }
    return [*#header* \ #title#teacher.name]
  }

  {
    place(
      top + center,
      float: true,
      scope: "parent",
      {
        grid(
          align: (center),
          text(size: 12pt)[
            Министерство науки и высшего образования Российской Федерации\
            *Федеральное государственное бюджетное образовательное учреждение высшего образования*\
            «Владимирский государственный университет
            имени Александра Григорьевича и Николая Григорьевича Столетовых»\
            *(ВлГУ)*\
            \
            *Кафедра информационных систем и программной инженерии*
          ],
        )
        
        v(2cm)

        text(size: 16pt, upper(title), weight: "bold")
        text(size: 16pt, weight: "bold")[ \ #discipline ]

        if theme != none and theme != str and theme != "" {
          v(1cm)
          text(size: 14pt)[ #theme ]
        }
      }
    )

    place(
      right + bottom,
      dy: -4cm,
      float: true,
      scope: "parent",
      align(left)[
        #format-students(students) \ 
        #format-teacher(teacher)
      ]
    )

    pagebreak()
    doc
  }
}