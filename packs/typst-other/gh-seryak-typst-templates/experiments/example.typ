#import "functions.typ": section-title, alert

#set page(
  paper: "a4",
  margin: (top: 20mm, bottom: 20mm, left: 10mm, right: 10mm),
)

#set text( size: 11pt)




#let sidebarSection = {[
  #set par(justify: true)

  // #set text(
  //   size: eval(settings.font.size.contacts),
  //   font: settings.font.minor_highlight,
  // )
      
  Email: #link("mailto:" + "misha-seryak@ya.ru") \
  LinkedIn: #link("https://www.linkedin.com/in/seryak")[Mikhail Seriakov] \
  GitHub: #link("https://github.com/seryak")[seryak] \
  
  #line(length: 100%)

  = Summary

  // #set text(
  //     eval(settings.font.size.education_description),
  //     font: settings.font.minor_highlight,
  // )
  #{
    par(justify: true)[
      Бла бла бла бэкенд разработчик
    ]
  }
]}


#let mainSection = {[
  // #set par(justify: true)

	= Mikhail Seriakov

	#include "includes/work-experince.typ"

	#section-title("Skills")
	Тут список навыков…

	#section-title("Education")
	Тут образование…  
	#alert("Внимание")
]}


#{
  grid(
    columns: (2fr, 5fr),
    column-gutter: 3em,
    sidebarSection,
    mainSection,

  )
}


