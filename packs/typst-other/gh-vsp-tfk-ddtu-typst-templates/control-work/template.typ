#import "layout.typ": setup_layout

#let unindented(body) = {
  set par(first-line-indent: 0em)

  body
}

#let institution(internal: false) = {
  set par(leading: 0.5em, first-line-indent: 0em, justify: false)
  align(center)[
    #text(weight: "regular")[
      #if not internal [
        #block(above: 0.5em)[
          МІНІСТЕРСТВО ОСВІТИ І НАУКИ УКРАЇНИ
        ]
        #parbreak()
        #block(above: 0.5em)[
          Відокремлений структурний підрозділ
        ]
      ] else [
        #block(above: 0.5em)[
          ВІДОКРЕМЛЕНИЙ СТРУКТУРНИЙ ПІДРОЗДІЛ
        ]
      ]
      #parbreak()
      #block(above: 0.5em)[
        «ТЕХНОЛОГІЧНИЙ ФАХОВИЙ КОЛЕДЖ ДНІПРОВСЬКОГО ДЕРЖАВНОГО ТЕХНІЧНОГО УНІВЕРСИТЕТУ»
      ]
    ]
  ]
}

#let city_and_year(city: none) = {
  let today = datetime.today()
  
  align(bottom)[
    #align(center)[
      #city
      
      #today.year()
    ]
  ]
}

#let work_approval(vice_director) = {
  let year = datetime.today().year()

  grid(
    columns: (1fr, 1fr),
    [], [
      #upper[*Затверджую:*]

      *Заступник директора*
      
      *з навчально-методичної роботи*

      `_________` #vice_director

      "`__`" `_____________` #year р.
    ]
  )
}

#let work_title(subject, group, specialty) = {
  align(center)[
    *ЗАВДАННЯ*

    *для директорської контрольної роботи*
  ]

  block[
    *з дисципліни "#subject"*

    *для здобувачів освіти*
    
    *спеціальностей: #specialty*
  ]
}

#let signature(cycle_commission, cycle_commission_head) = {
  let year = datetime.today().year()
  grid(
    columns: (1fr, 1fr),
    [], [
      РОЗГЛЯНУТО І СХВАЛЕНО

      на засіданні циклової комісії

      #line(start: (0%, 1em), end: (100%, 1em), stroke: 0.2pt)

      Протокол №`____` від `________` #year р.

      `_________` #cycle_commission_head
    ]
  )
}

#let project(
  vice_director: none,
  subject: none,
  group: none,
  specialty: none,
  cycle_commission: none,
  cycle_commission_supervisor: none,
  city: "Кам’янське",
  body
) = {
  show: setup_layout

  page(numbering: none)[
    #set par(justify: false)

    #unindented[
      #institution(internal: true)

      #align(horizon)[
        #work_approval(vice_director)
      ]

      #align(horizon)[
        #block(breakable: false, height: 50%)[
            #work_title(subject, group, specialty)
            #signature(cycle_commission, cycle_commission_supervisor)
        ]
      ]

      #city_and_year(city: city)
    ]
  ]

  show table: set table(
    inset: 7pt, 
    stroke: (0.5pt + luma(200)), 
    align: center + horizon
  )

  body
}