// main.typ
#import "/globals.typ": *

// #show: university-theme.with(

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  // Customize the footer:
  footer: self => [
    #self.info.author | #self.info.institution
  ],
  config-info(
    title: [Title],
    subtitle: [Subtitle],
    author: [Authors],
    date: datetime.today(),
    institution: [Institution],
    // logo: emoji.school,
  ),
  footer-progress: true
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

= Outline <touying:hidden>

#outline(title: none, indent: 1em, depth: 2)

#include "/sections/index.typ"