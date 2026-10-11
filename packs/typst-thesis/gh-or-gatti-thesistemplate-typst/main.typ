
#set heading(numbering: "1.")
#set par(justify: true)
#set page(
  numbering: "1",
)

#show heading: it => [
  
  #set text(9pt,font: "MS Gothic")
  #counter(heading).display() 
  #emph(it.body)
  \ \
]

\ \ 
#align(center, text(14pt)[
  #set text(font:"MS Gothic")
  *タイトルをここに入力*
  \ \
])
#set text(font:"MS Mincho",size:9pt)
#align(center, text(12pt)[
  〇〇〇〇〇〇〇〇工学科 #h(1.26cm) 高専太郎
  \ \
])
#show: rest => columns(2, rest)
//本文はここから
= まえがき
  #lorem(30)
= 見出し
 #lorem(50)
= 見出し
 #lorem(30)
== 小見出し
#lorem(30)
== 小見出し
#lorem(100)
== 小見出し
#lorem(50)
= 見出し
#lorem(50)
= 見出し
 #lorem(100)



