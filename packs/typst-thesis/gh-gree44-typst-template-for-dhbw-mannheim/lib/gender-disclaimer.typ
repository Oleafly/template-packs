#import "locale.typ": *

#let gender-disclaimer(
  gender-disclaimer-content,
  language,
) = {
  heading(
    level: 1,
    numbering: none,      // no “1” in front
    outlined: true,       // ensure it's included in the outline
  )[#GENDER_DISCLAIMER_TITLE.at(language)]
  v(1em)
  v(1em)

  if (gender-disclaimer-content != none) {
    declaration-of-authorship-content
  } else {
      par(justify: true, GENDER_DISCLAIMER.at(language))
  }
}
