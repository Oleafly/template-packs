// Function to get a string, containing the course and the speciality. Used in titlepage
#let get_course_speciality(group) = {
  let specialities = (
    [Фундаментальная информатика и информационные технологии],
    [Информатика и вычислительная техника],
    [Компьютерная безопасность],
    [Математическое обеспечение и администрирование информационных систем],
    [Программная инженерия],
    [Педагогическое образование],
    [Информатика и вычислительная техника],
    [Математическое обеспечение и администрирование информационных систем],
    [Системный анализ и управление]
  )

  let result = str(group).at(0) + " курс"

  if str(group).at(1) == "7" {
    result += " (магистратура)"

    if str(group).at(2) == "1" {
      result += ", «" + specialities.at(6) + "»"
    } else if str(group).at(2) == "3" {
      result += ", «" + specialities.at(7) + "»"
    }

    return result
  }

  let id = int(str(group).at(1)) - 1;
  
  if id >= 0 and id <= 8 {
    result += ", «" + specialities.at(id) + "»"
  }

  return result
}

// Titlepage builder
#let make_titlepage(
  info: ()
) = {
  set align(center)
  
  v(2em)
  text(size: 2em,
       weight: 700,
       str(info.title))

  v(1em)
  text(size: 1em,
       str(info.author) + "\n" + get_course_speciality(int(info.group)))

  set align(center)
  text(size: 1em,
       str(info.city) + ", " + str(info.year))
}

// TOC builder
#let make_toc(
  info: ()
) = {
  outline(indent: 2%,
          title: [Содержание])
  pagebreak(weak: true)
}

// Main configuration script
#let conf(
  meta: (),
  toc: (),
  content
) = {
  show raw: set text(
    font: "JetBrains Mono",
    ligatures: false,
    features: (calt: 0)
  )

  show raw.where(block: true): code => {
    show raw.line: line => {
			context {
        let t = text(fill: gray)[#line.number]
        t
        h(1em - measure(t).width)
      }
      line.body
    }
    code
  }

  show link: set text(
    fill: gradient.linear(rgb("#6ec080"), rgb("#1b7ab4"), angle: 45deg)
  )
  
  set text(
    font: "Cambria",
    size: 14pt,
    ligatures: false,
  )

  make_titlepage(info: meta)
  make_toc(info: toc)
  
  set page(footer: context [
    #h(1fr)
    #counter(page).display(
      "1"
    )
  ])
  set page(numbering: "1")
  
  content
}
