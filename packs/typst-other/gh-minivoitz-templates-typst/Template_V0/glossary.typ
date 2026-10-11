= Glossary

#import "@preview/glossarium:0.5.6": make-glossary, register-glossary, print-glossary, gls, glspl


#let entry-list = (
  // Use key as short by default
  (
    key: "kuleuven",
  ),
  // Add SHORT
  (
    key: "kuleuven",
    short: "KU Leuven"
  ),
  // Add LONG
  (
    key: "unamur",
    short: "UNamur",
    long: "Namur University",
  ),
  // Add a DESCRIPTION
  (
    key: "oidc",
    short: "OIDC",
    long: "OpenID Connect",
    description: [
      OpenID is an open standard and decentralized authentication protocol promoted by the non-profit
      #link("https://en.wikipedia.org/wiki/OpenID#OpenID_Foundation")[OpenID Foundation].
    ],
  ),
  // Add a PLURAL form
  (
    key: "potato",
    short: "potato",
    // "plural" will be used when "short" should be pluralized
    plural: "potatoes",
  ),
  // Add a LONGPLURAL form
  (
    key: "dm",
    short: "DM",
    long: "diagonal matrix",
    // "longplural" will be used when "long" should be pluralized
    longplural: "diagonal matrices",
    description: "Probably some math stuff idk",
  ),
  // Add a GROUP
  (
    key: "kuleuven",
    short: "KU Leuven",
    // The terms are displayed by groups in the glossary
    group: "Universities",
  ),
)



