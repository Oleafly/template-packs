#import "lib/style.typ": apply-style, default-uservars
#import "lib/modules.typ": build-cv, render-heading, render-sections, render-endnote

#let base = yaml("base.yml")
#let profiles = yaml("profiles.yml")

#let profile-name = sys.inputs.at("profile", default: "software-engineer")
#let work-override = sys.inputs.at("work", default: none)
#let projects-override = sys.inputs.at("projects", default: none)

#let uservars = (
  ..default-uservars,
  margin: 0.40in,
  fontsize: 10pt,
  linespacing: 6pt,
  showNumber: true,
)

#let cv = build-cv(
  base,
  profiles,
  profile-name,
  work-override: work-override,
  projects-override: projects-override,
)

#show: doc => apply-style(uservars, doc)

#render-heading(cv, uservars)
#render-sections(cv)
#render-endnote(cv)
