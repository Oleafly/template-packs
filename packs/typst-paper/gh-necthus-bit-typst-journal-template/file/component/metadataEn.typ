#import "../config.typ": config,configEn
#{
  set align(center)
  set text(font: "Times New Roman", size: 12pt, weight: "black")
  [#configEn.title]
}


#{
  set align(center)
  set text(font: "Times New Roman", size: 12pt)
  [#configEn.author$#text[]^1$]
}

#{
  set align(center)
  set text(font: "Times New Roman", size: 9pt)
  [(1. #configEn.school, #configEn.university, #configEn.city #configEn.zipcode)]
  v(1em)
}

#{
  set text(font: "Times New Roman", size: 9pt)
  set par(leading: 1.5em)
  h(-2em)
  strong[Abstract：]
  include "../abstractEn.typ"
  [\ ]
  strong[Key words: ]
  [#configEn.keywords.join("; ")]
}