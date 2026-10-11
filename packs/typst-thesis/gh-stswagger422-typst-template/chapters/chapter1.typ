#import "_common.typ":*
#show: doc => chapter_conf(settings, doc: doc)
#let main = [
  = 标题示例

  正文内容...

  #lorem(40)

$x=1$
$ x=1 $
  == 小节标题示例


  
  
]
#main
#bibliography("../ref.bib", style: settings.参考文献格式)