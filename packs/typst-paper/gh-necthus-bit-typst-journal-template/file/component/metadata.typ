#import "../config.typ": config,configEn
#{
  // 设置标题
  set align(center)
  set text(font: "SimHei", size: 22pt)
  [#config.title]
}


#{
  set align(center)
  set text(font: "SimSun", size: 14pt)
  [#config.author$#text[]^1$]
}

#{
  set align(center)
  set text(font: "SimSun", size: 9pt)
  [(1. #config.university #config.school, #config.city #config.zipcode)]
  v(1em)
}

#{
  set text(font: "SimSun", size: 9pt)
  set par(leading: 1.5em)
  h(-2em)
  strong[摘#h(1em)要：]
  include "../abstract.typ"
  strong[关键词：]
  [#config.keywords.join("；")]
}