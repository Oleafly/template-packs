#import "template.typ": *
#import "PersonalInfos.typ": *
#import "Projects.typ": *
#import "Extracurriculars.typ": *
#import "Awards.typ": *
#import "Icons.typ": *

// 主题颜色
#let themeColor = rgb(38, 38, 125)
#let NeedPhotograph = true

// 设置简历选项与头部
#show: resume.with(
  size: 10pt,
  themeColor: themeColor,
  top: 1.5cm, bottom: 2cm, left: 2cm, right: 2cm,
  photograph: Photograph, photographWidth: 9em, gutterWidth: 1em,
  need_photograph: NeedPhotograph
)[

= #Name

#info(
  color: themeColor,
  (icon: faPhone, content: PhoneNumber),
  (icon: faBuildingColumns, content: University),
  (icon: faGraduationCap, content: Major),
  (icon: faPortrait, content: PoliticalStatus),
  (icon: faEnvelope, content: MailAddress, link: "mailto:" + MailAddress),
  (icon: faGithub, content: GithubContent, link: GithubHomePage),
  (icon: faBlog, content: PersonalBlogContent, link: PersonalBlogPage),
)
#h(2em) #Intro
]

== #faGraduationCap Education Background

#sidebar(withLine: true, sideWidth: 20%)[
  #display_duration(d1: EnrollDay, d2: Today, date_format: false)
  
  #display_date(d: EnrollDay, date_format: false)
  
  #display_date(d: datetime(year: 1234, month: 9, day: 1), date_format: false)

  1234\~2345
][
  #Grade
  
  #UniversityShort · #College · *#Major*
  
  #UniversityShort · #Lab1

  #UniversityShort · #Lab2
]

== #faWrench Expertise

#sidebar(withLine: false, sideWidth: 20%)[
  *Programming*
  
  *Skills*

  *Basic*

  ~
  
  *Advanced*
][
  #ProgrammingLanguages

  #Skills
  
  #CourseCS1
  
  #CourseCS2
  
  #CourseAI
]

== #faAward Awards

#Awards

== #faCode Projects

#for project in Projects [
  #project
  #v(0.2em)
]

== #faBuildingColumns Leadership and Extracurricular Activities 

#Extracurriculars
