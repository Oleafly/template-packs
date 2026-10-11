#import "vars.typ": *
#import "defenitions/customFunctions.typ": *


#import "defenitions/templateConfig.typ": template
#show: template(
  title: title,
  author: author,
  headingFont: altFont,
  textFont: textFont,
  background: background,
  textColor: textColor,
)


#import "defenitions/frontPage.typ": frontPage
#frontPage(
  title: title,
  subtitle: subtitle,
  author: author,
  authorFont: altFont,
)


= Abstract
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.asdasd


*Keywords:* Key, Words, Go, Here

#pagebreak()
#set heading(numbering: "1.")

//document content

= Title
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.




= References
#bibliography("ref.yml", title: none, full: true, style: "ieee")
