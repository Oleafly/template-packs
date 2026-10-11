#import "orly-config.typ": *

// O'Reilly 风格封面
#make-cover(
  cover-image: image("images/cover.png"),
  image-width: 50%,
  image-align: center,
  image-offset-x: 100pt,
)

// 应用文档模板
#show: orly-template

// 目录
#make-outline()

// 序言
#include "chapters/preamble.typ"

// 正文内容
#include "chapters/1_intro.typ"

// 附录
#include "chapters/appendix.typ"