// ==============================================================================
// 🎓 Andrews University Doctor of Ministry (AU DMin) Typst Template Library
// Conforms to: Doctor of Ministry Project Writing Manual (4th Edition, Aug 2019)
// Standards: Andrews University Standards for Written Work & Turabian (8th/9th ed.)
// Supported Languages: en (English), uk (Ukrainian), ru (Russian), fr (French), es (Spanish)
// ==============================================================================

#import "state.typ": *
#import "i18n.typ": *
#import "layout.typ": *
#import "elements.typ": *
#import "preliminary.typ": *

#let au-dmin(
  title: "PROJECT DISSERTATION TITLE IN ALL CAPS",
  author: "Author Full Name",
  degree: "Doctor of Ministry",
  advisor: "Advisor Name, Ph.D.",
  second-reader: "Second Reader Name, D.Min.",
  third-reader: none,
  program-director: "Stanley E. Patterson, Ph.D.",
  dean: "Jiří Moskala, Th.D., Ph.D.",
  date: "Month Year",
  university: "Andrews University",
  school: "Seventh-day Adventist Theological Seminary",
  date-approved: "Month Day, Year",
  lang: "en",
  body,
) = {
  // Update global language & metadata states
  au-dmin-lang.update(lang)
  au-dmin-meta.update((
    title: title,
    author: author,
    degree: degree,
    advisor: advisor,
    second-reader: second-reader,
    third-reader: third-reader,
    program-director: program-director,
    dean: dean,
    date: date,
    university: university,
    school: school,
    date-approved: date-approved,
    lang: lang,
  ))

  // Apply layout, page geometry, typography, and show rules
  apply-dmin-layout(lang: lang, body)
}
