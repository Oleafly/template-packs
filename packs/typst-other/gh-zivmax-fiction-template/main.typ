#import "template/lib.typ": book
#import "@preview/kouhu:0.1.0": kouhu

#show: book.with(
  title: [标题],
  author: "作者",
  dedication: [
    一些献词。
  ],
  publishing-info: [
    模板出版社 \
    北京市朝阳区示例路100号 \
    邮编: 100000

    #link("https://publisher.example.cn/")

    ISBN 978-7-1234-5678-9
  ],
)

= 第一章的标题
这是一个测试文档。让*我们*看看 English 如何。English 和中文的字体是分开设置的。


= 第二章的标题
#kouhu(builtin-text: "zhufu", offset: 5, length: 1000)


= 第三章的标题
#kouhu(builtin-text: "simp", offset: 5, length: 1000)
