#import "../template/template.typ": *

#let code1 = ```typ
#import "template/template.typ": template as CUMCM

#show: CUMCM.with(

  abstract: [
    摘要内容
  ],
  title: "统计建模论文Typst模板",
  keywords: ("关键词1","关键词2","关键词3"),

  abstract_en: [
    Abstract content in English
  ],
  keywords_en: ("keyword1", "keyword2", "keyword3"),
)

#include "chapter/chapter1.typ"

= 参考文献
#bibliography("refs.bib", style: "gb-7714-2005-numeric", title: none)
 
#pagebreak()
#include "chapter/appendix.typ"
```

#let codeZip=(
  "typst代码": code1,
  
)

= 附录
#for (desc,code) in codeZip{
    codeAppendix(
        code,
        caption: desc
    )
    v(2em)
}