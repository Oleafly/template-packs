#import "../lib/lib.typ": gendered, signature_field, under_field, year_field
#import "../lib/page.typ": cover_page

#let is_practice = false

#let default_title_meta = (
  university_line: [НАЦІОНАЛЬНИЙ ТЕХНІЧНИЙ УНІВЕРСИТЕТ УКРАЇНИ\ “КИЇВСЬКИЙ
    ПОЛІТЕХНІЧНИЙ ІНСТИТУТ\ імені ІГОРЯ СІКОРСЬКОГО”],
  faculty: [Факультет інформатики та обчислювальної техніки\ Кафедра
    обчислювальної техніки],
  project_kind: if is_practice [Звіт з практики] else [Дипломний проєкт],
  degree_line: [на здобуття ступеня бакалавра\ за освітньо-професійною програмою
    “Інженерія програмного забезпечення\ комп'ютерних систем”\ спеціальності 121
    “Інженерія програмного забезпечення”],
)

#let title_page(
  meta: none,
  topic: none,
  student_course: none,
  student_group: none,
  student_name: none,
  advisor_name: none,
  consultant_name: none,
  reviewer_name: none,
  head_name: none,
  city: none,
  year: none,
  student_female: none,
) = {
  cover_page[
    #block(width: 170mm)[
      #align(center)[
        #text(weight: "bold")[#meta.university_line]
        #v(2mm)
        #underline(meta.faculty)
      ]

      #v(5mm)
      #align(right)[
        #block(width: 90mm)[
          #align(right)[
            #text(weight: "bold")[До захисту допущено:]\
            #text(weight: "bold")[В. о. завідувача кафедри]
          ]
          #grid(
            columns: (20mm, 60mm),
            align: horizon,
            [ #signature_field() ],
            [
              #under_field(start: 12mm)[ #head_name ]
            ],
          )
          #align(right)[
            #year_field()[#year]
          ]
        ]
      ]

      #v(8mm)

      #align(center)[
        #text(weight: "bold", size: 20pt)[#meta.project_kind]\

        #text(weight: "bold")[#meta.degree_line]
      ]

      #v(7mm)

      #let signature_gap = 3mm
      #stack(
        spacing: 14pt,
        [#text[на тему:] #under_field()[#topic]],
        [
          #gendered(
            male: [Виконав],
            female: [Виконала],
            is_female: student_female,
          ):
          #gendered(
            male: [студент],
            female: [студентка],
            is_female: student_female,
          )
          #under_field(width: 7mm)[#student_course]
          курсу, групи
          #under_field(width: 20mm, caption: [(шифр групи)])[#student_group]
        ],
        [
          #grid(
            columns: (1fr, signature_gap, auto),
            column-gutter: 2mm,
            [#under_field(
              caption: [(прізвище, ім'я, по батькові)],
              width: 100%,
            )[#student_name]],
            [],
            [#signature_field()],
          )
        ],
        [
          #grid(
            columns: (auto, 1fr, signature_gap, auto),
            column-gutter: 2mm,
            [Керівник],
            [
              #under_field(
                width: 100%,
                caption: [(посада, науковий ступінь, вчене звання, прізвище та
                  ініціали)],
              )[#advisor_name]
            ],
            [],
            [#signature_field()],
          )
        ],
        [
          #grid(
            columns: (auto, auto, 1fr, signature_gap, auto),
            column-gutter: 2mm,
            [Консультант],
            [#under_field(caption: [(назва розділу)])[(нормоконтроль)]],
            [
              #under_field(
                width: 100%,
                caption: [(посада, вчене звання, науковий ступінь, прізвище та
                  ініціали)],
                caption_width: 220pt,
                caption_dx: -15pt,
              )[#consultant_name]
            ],
            [],
            [#signature_field()],
          )
        ],
        [
          #grid(
            columns: (auto, 1fr, signature_gap, auto),
            column-gutter: 2mm,
            [Рецензент],
            [
              #under_field(
                caption: [(посада, науковий ступінь, вчене звання, прізвище та
                  ініціали)],
                width: 100%,
              )[#reviewer_name]
            ],
            [],
            [#signature_field()],
          )
        ],
      )

      #v(5mm)
      #align(right)[
        #block(width: 85mm)[
          #align(left)[
            Засвідчую, що у цьому дипломному проєкті немає запозичень з праць
            інших авторів без відповідних посилань.
            #grid(
              columns: (auto, 28mm),
              column-gutter: 7mm,
              align: horizon,
              [#gendered(
                male: [Студент],
                female: [Студентка],
                is_female: student_female,
              )],
              [#signature_field()],
            )
          ]
        ]
      ]

      #v(1fr)
      #align(center)[#city -- #year р.]
    ]
  ]
}
