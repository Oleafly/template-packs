#import "../src/lib.typ": thesis-template
#import "chap/abstract.typ": abstract-cn, keywords-cn, abstract-en, keywords-en
#import "chap/ch1.typ": ch1
#import "chap/ch2.typ": ch2
#import "chap/ch3.typ": ch3
#import "chap/ch4.typ": ch4
#import "chap/ch5.typ": ch5
#import "chap/ch6.typ": ch6
#import "chap/acknowledgements.typ": acknowledgements
#import "chap/publications.typ": publications
#import "chap/appendix.typ": appendix

#show: doc => thesis-template(
  title-cn: "Dummy 示例论文：Typst 功能演示",
  title-en: "Dummy Thesis Example: A Typst Feature Demonstration",
  running-title: "Typst Dummy 示例",
  author: "示例学生",
  advisor: "示例导师 教授",
  coadvisor: "",
  degree: "工学学士",
  major: "计算机科学与技术",
  school: "示例大学",
  submit-date: "2026年6月",
  abstract-cn: abstract-cn,
  keywords-cn: keywords-cn,
  abstract-en: abstract-en,
  keywords-en: keywords-en,
  acknowledgements: acknowledgements,
  references: bibliography("references.bib",style:"gb-7714-2015-numeric",title: none),
  appendix: appendix,
)[
  #ch1
  #ch2
  #ch3
  #ch4
  #ch5
  #ch6
]
