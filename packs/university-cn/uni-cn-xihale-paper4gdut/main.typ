#import "template.typ": *
#import "metadata/common.typ": metadata

// 字体配置：编辑 fonts.typ 修改字体

// ========== 选择文档类型 ==========
// 取注释需要使用的模板

// 本科毕业设计（论文）
#thesis(metadata, show_cover: true)[
  #include "chapters/1-introduction.typ"
  #include "chapters/2-related.typ"
  #include "chapters/3-method.typ"
  #include "chapters/4-experiment.typ"
  #include "chapters/5-conclusion.typ"
  #include "chapters/appendix.typ"
]

// 程序设计课程设计报告
/*
#course-report(metadata)[
  #include "chapters/1-introduction.typ"
  #include "chapters/2-related.typ"
  #include "chapters/3-method.typ"
  #include "chapters/4-experiment.typ"
  #include "chapters/5-conclusion.typ"
]
*/
