#import "@preview/numbly:0.1.0": numbly

/*定义字号*/
#let 字号=(
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
)

/*定义字体*/
#let 字体=(
  仿宋: ("Times New Roman", "FangSong"),
  宋体: ("Times New Roman", "SimSun"),
  黑体: ("Times New Roman", "SimHei"),
  楷体: ("Times New Roman", "KaiTi"),
  英文: ("Times New Roman")
)

#let template_en(abstract: [Summary content], keywords: ([key1], [key2], [key3])) = {
  //设置页面
  set page(
    paper: "a4", 
    margin: (x: 2.5cm, y: 2.5cm),
  )
   
  //设置文本样式
  set text(
    font: 字体.宋体,
    size: 字号.小四, //正文字体大小
    fill: black,
    lang: "en",
  )

  //设置段落
  set par(
    justify: true, //两端对齐
    first-line-indent: 2em, //首段缩进
    leading: 1em, //行距
  )

  [
    #set page(footer: [#none])
    #[//摘要字
      #set text(font: 字体.黑体, size: 字号.四号)
      #align(left)[*Abstract:*]
    ]
     
    #abstract
    #v(1em)
    //关键词
    #[
      #set text(font: 字体.黑体, size: 字号.小四, )
      *Keywords*:
    ]
    #for item in keywords{
      set text(font: 字体.黑体)
      item
      h(1em)
    }    
  ]

}