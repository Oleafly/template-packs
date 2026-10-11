#import "template.typ": LDZK
#show: doc => LDZK(
  title: [
    兰州大学学报(自然科学版)模板使用说明
  ],
  author: [
    nftuoa
  ],
  address: [兰州大学 信息科学与工程学院 兰州 730000],
  abstract: [在这里输入你的摘要],
  doc,
  category: [114514],
  keywords: ("中文的","关键词","在这"),
  title_eng: [Tutor on how to use this template],
  address_eng: [School of Information Science & Engineering, Lanzhou University, Lanzhou 730000, China],
  abstract_eng: [Your English abstract here],
  author_eng: [nftuoa],
  keywords_eng: ("english","keyword"),
  intro:[这里是正文前的一小段话],
  acknowledge: [如果你真的用我的模板写到这了,可以谢谢一下我吗]
)

= 基础文字
直接写在这里就好

== 分段
大标题用一个=,小标题用两个=

== 代码块
```c
#include <stdio.h>

int main(void){
  return 114514
}
```
请参考此处的代码样式
== 致谢
加入到上面的acknowledge中
= 外部引用
== 参考文献
首先将参考文献生成BibTeX,复制到references.bib中，再在文中使用@ 符号即可
如@Nobody06

== 插入图片
在项目文件夹里拷入图像，再使用figure函数即可；需使用caption参数添加附注并且需要是双语的。
#figure(image("fig1.png"),caption: [这是一张照片 \ Fig.1 This is an image])
