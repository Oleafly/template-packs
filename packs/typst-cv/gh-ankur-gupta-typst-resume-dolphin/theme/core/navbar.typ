#import "utils.typ": fill_instance_with_default
#import "me.typ": JOHNDOE, ME


#let email(content) = [
  #box(height: 1em, baseline: 22%, image("../assets/email.svg")) #link("mailto:" + content, text(font: "Cascadia Code", size: 0.8em, content))
]

#let phone(content) = [
  #box(height: 1em, baseline: 18%, image("../assets/phone.svg")) #text(font: "Cascadia Code", size: 0.8em, content)
]

#let website(content) = [
  #box(height: 1em, baseline: 27%, image("../assets/website.svg"))
  #link(content, text(font: "Cascadia Code", size: 0.8em, content.trim("https://").trim("www.")))
]

#let linkedin(content) = [
  #box(height: 1em, baseline: 20%, image("../assets/linkedin.svg"))
  #link(content, text(font: "Cascadia Code", size: 0.8em, content.trim("https://").trim("www.").trim("linkedin.com/in")))
]

#let github(content) = [
  #box(height: 1em, baseline: 25%, image("../assets/github.svg"))
  #link(content, text(font: "Cascadia Code", size: 0.8em, content.trim("https://").trim("www.").trim("github.com/")))
]

#let stackoverflow(content) = [
  #box(height: 1em, baseline: 12%, image("../assets/stackoverflow.svg"))
  #link(content, text(font: "Cascadia Code", size: 0.8em, content.trim("https://").trim("www.").trim("stackoverflow.com/users/").trim("?tab=profile")))
]

#let google_scholar(url, label) = [
  #box(height: 1em, baseline: 19%, image("../assets/google_scholar.svg"))
  #link(url, text(font: "Cascadia Code", size: 0.8em, label))
]

#let navbar(me: JOHNDOE) = {
  let filled_me = fill_instance_with_default(me, default: ME)

  if filled_me.email != none [
    #email(filled_me.email) \
  ]

  if filled_me.phone != none [
    #phone(filled_me.phone) \
  ]

  if filled_me.website != none [
    #website(filled_me.website) \
  ]

  if filled_me.linkedin != none [
    #linkedin(filled_me.linkedin) \
  ]

  if filled_me.github != none [
    #github(filled_me.github) \
  ]

  if filled_me.stackoverflow != none [
    #stackoverflow(filled_me.stackoverflow) \
  ]

  if filled_me.google_scholar != none [
    #google_scholar(filled_me.google_scholar, "Google Scholar") \
  ]
}
