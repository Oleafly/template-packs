#set text(font: ("New Computer Modern", "Font Awesome 6 Free"))
#import "@preview/light-cv:0.2.1": *
#import "@preview/fontawesome:0.5.0": *
#import "settings/styles.typ": *

#show: cv.with(styles: styles)

// Trailing #h(...) keeps the Font Awesome glyphs from colliding with the text
// next to them (light-cv only inserts a single thin space).
#let icons = (
  mail: [#fa-envelope(fill: styles.colors.accent)#h(5pt)],
  phone: [#fa-phone(fill: styles.colors.accent)#h(5pt)],
  linkedin: [#fa-linkedin(fill: styles.colors.accent)#h(5pt)],
  web: [#fa-globe(fill: styles.colors.accent)#h(5pt)],
)

#header(
  styles: styles,
  full-name: [Your Name],
  job-title: [Your Title],
  socials: (
    (icon: icons.mail, text: [you\@example.com], link: "mailto:you@example.com"),
    (icon: icons.phone, text: [+000 000 0000], link: "tel:+0000000000"),
    (icon: icons.linkedin, text: [LinkedIn], link: "https://www.linkedin.com/in/your-handle"),
    (icon: icons.web, text: [your-site.com], link: "https://your-site.com"),
  ),
  // Add a photo with: profile-picture: image("media/photo.jpg")
  profile-picture: none,
)

#section(styles: styles, title: "Summary")

One or two lines framing who you are and what you do best. Lead with your niche.

#section(styles: styles, title: "Experience")

#entry(
  styles: styles,
  title: "Job Title",
  company-or-university: " Company",
  date: "2023 - present",
  location: "City, Country",
  logo: none, // or: image("media/company.png")
  description: [
    #text(weight: "bold", fill: styles.colors.accent)[Project or focus area] \
    - What you did and the impact — keep a concrete number in here.
    - Another accomplishment, framed around outcome not just tasks.
    - *Tech:* Language, Framework, Database, Tooling.
  ]
)

#section(styles: styles, title: "Education")

#entry(
  styles: styles,
  title: "Degree",
  company-or-university: " University",
  date: "2019 - 2023",
  location: "City, Country",
  logo: none,
  description: list([Thesis, relevant coursework, or an honor.])
)

#section(styles: styles, title: "Projects")

#entry(
  styles: styles,
  title: "Project name",
  company-or-university: " Personal project",
  date: "2024 - present",
  location: "",
  logo: none,
  description: list(
    [What it is and what you built / shipped.],
    [*Tech:* the stack.],
  )
)

#section(styles: styles, title: "Skills")

#skill(styles: styles, category: "Backend", skills: ("Skill", "Skill", "Skill"))
#skill(styles: styles, category: "Cloud & DevOps", skills: ("Skill", "Skill", "Skill"))
#skill(styles: styles, category: "Languages", skills: ("English", "Other"))
