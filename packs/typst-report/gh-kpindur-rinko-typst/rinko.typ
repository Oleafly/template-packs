#let maketitle(
  title: [Default Title],
  title_fontsize: 17pt,
  corners: ()
) = {
  let top-left = corners.at(0)
  let top-right = corners.at(1)
  let bot-left = corners.at(2)
  let bot-right = corners.at(3)
  
  rect()[
    #align( left + horizon, [ #top-left #h(1fr) #top-right] )

    #set align(center)
    #text(title_fontsize, title)

    #align( left + horizon, [ #bot-left #h(1fr) #bot-right ] )
  ]

}

#set heading(numbering: "1.1.1)")

#let abstract(
  abstract: [],
  keywords: ()
) = {
  par(justify: false)[
    *Abstract* \
    #abstract
  ]
}

#let conf(
  body
) = {
  maketitle(title: [Rinko paper], title_fontsize: 17pt, corners: ("test1", "test2", "test3", "test4"))

  columns(2, [#body])
}

