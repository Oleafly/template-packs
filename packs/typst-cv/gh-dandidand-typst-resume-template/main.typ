#import "config.typ": document
#import "utils.typ": title, translate
#import "content/index.typ": resumeDict, experienceDict, educationAndCertificationsDict, skillsDict

#let jobTitle = translate((
  es: [Desarrollador Frontend],
  en: [Frontend Development],
))

#show: document[
  = First Name Last Name

  * #jobTitle * \
  City, Country |
  #link("https://www.linkedin.com")[linkedin.com] |
  (+01) 999 999 999 |
  email\@test.com

  #title([#resumeDict.title])
  #resumeDict.content

  #title([#experienceDict.title])
  #for experience in experienceDict.content [
    *#experience.company* #h(1fr) *#experience.location* \
    *#experience.role* #h(1fr) #experience.period \
    #experience.description
  ]

  #title([#educationAndCertificationsDict.title])
  #for institution in educationAndCertificationsDict.content [
    *#institution.name* #h(1fr) *#institution.location* \
    #for role in institution.roles [
      #role.title #h(1fr) #role.period \
    ]

  ]
  #title([#skillsDict.title])
  #for skill in skillsDict.content [
    *#skill.title*: #skill.content \
  ]
]

