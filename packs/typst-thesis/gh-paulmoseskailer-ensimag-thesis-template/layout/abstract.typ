#import "/layout/fonts.typ": *

#let abstract(body, lang: "en") = {
  let title = (en: "Abstract", fr: "Résumé")

  // --- Abstract ---
  align(center, text(font: fonts.body, 1.1em, weight: 700, title.at(lang)))
  
  body
}
