#import "style.typ": apply_style


#let header_and_footer_color = rgb("#afafaf")
#let header_and_footer_font_size = 8pt
#let logo_path = "heig-vd.png"


#let apply_template(
  content,
  lab_num: 1,
  course: "COURSE",
  Department: "DEPARTMENT",
  professor: "PROFESSOR",
  assistant: "ASSISTANT",
  author: "AUTHOR",
  lab_title: "TITLE",
  date: "DD.MM.YYYY",
  classroom: "CLASSROOM",
) = {
  show: apply_style
  show link: underline

  // Title page ---------------------------------------------
  place(
    top + left,
    image(
      logo_path,
      width: 30%,
      fit: "contain",
    ),
  )

  place(
    center + horizon,
    block[
      #set text(size: 24pt)

      #text[
        Laboratoire n° #lab_num \
        #lab_title \
      ]


      #set text(size: 18pt)
      #text[
        Département #Department\
        Unité d'enseignement #course
      ]
    ],
  )

  place(
    bottom,
    block[
      Auteur: *#author* \
      Professeur: *#professor* \
      Assistant: *#assistant* \
      Classe: *#classroom* \
      Date: *#date*
    ],
  )

  // End of title page -----------------------------------------------

  set page(
    numbering: "1",
    margin: (top: 3.5cm, bottom: 3.5cm, left: 4cm, right: 3cm),
    header: [
      #set text(header_and_footer_font_size, fill: header_and_footer_color)
      #grid(
        columns: (1fr, 1fr),
        image(logo_path, width: 30%, fit: "contain"), align(right, course + "\n" + date),
      )
      #line(length: 100%, stroke: 0.5pt + header_and_footer_color)
    ],

    footer: context [

      #set text(header_and_footer_font_size, fill: header_and_footer_color)
      #let footer_left_part = (
        "Auteur: " + author + "\n" + "Professeur: " + professor + "\n" + "Assistant: " + assistant + "\n"
      )
      #let footer_right_part = "Laboratoire n°" + str(lab_num) + "\n" + lab_title + "\n" + "Classe: " + classroom
      #line(length: 100%, stroke: 0.5pt + header_and_footer_color)
      #grid(
        columns: (3fr, 1fr, 3fr),
        grid.cell(
          x: 0,
          align(left + top, footer_left_part),
        ),

        grid.cell(
          x: 1,
          align(center + top, counter(page).display("1/1", both: true)),
        ),
        grid.cell(
          x: 2,
          align(right + top, footer_right_part),
        )
      )
    ],
  )
  outline(title: [Table des matières])
  pagebreak()

  content
}

#let sum_of_columns(table:table, col_index:int) = {
  let sum = 0
  let i = 0
  let nb_col = table.columns
  for row in table.children {
    if (i == col_index) {
      i = 0
      sum = sum + int(row.body.text)
    }
    i = i + 1
  }
  return sum
}

#let table_with_header(body) = {
  set table(
    stroke: (x, y) => {
      if y == 0 {
        (bottom: 1.2pt + rgb("#ffffff"), right: 0.5pt + rgb("#ffffff"))
      } else {
        (bottom: 0.5pt + rgb("#ffffff"), right: 0.5pt + rgb("#ffffff"))
      }
    },
    fill: (x, y) => {
       if y == 0 or x == 0{
        gray 
      } else {
        rgb("#e0e0e0")
      }
    },
  )
  show table.cell: it => {
    if it.x == 0 or it.y == 0 {
      set text(white)
      strong(it)
    } else {
      set text(black)
      it
    }
  }

  body
}



