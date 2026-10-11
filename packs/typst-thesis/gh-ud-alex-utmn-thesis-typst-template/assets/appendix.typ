#let appendix_counter = counter("app_counter")

#let appendix(appendix_title, app_supplement: "Прил.", numbering: "default") = {
  figure(supplement: app_supplement, kind: "appendix", block(width: 100%, {

    appendix_counter.step()

    if numbering != "default"{
      appendix_counter.update(numbering)}


    align(top + right)[
      #box(height: 1cm)[ #context {
          heading(numbering: none)[
            ПРИЛОЖЕНИЕ #if numbering == "default" {appendix_counter.display()} else {numbering}
]
        }
      ]
    ]

    v(-0.75em)

    
    context heading(outlined: false, numbering: none)[
      
      #appendix_title
    ]
  }))
}
