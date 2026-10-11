#let text-rootSite = "example.com/projects"
#let rootSite = "https://" + text-rootSite
#let email = "me@example.com"
#let githubHandle = "example"
#let linkedin = "linkedin.com/in/example-1234"

#let projectURL(is-text, slug) = {
  if is-text == false {
    if slug == none {
      rootSite + "/"
    } else {
      rootSite + "/" + slug + "/"
    }
  } else {
    if slug == none {
      text-rootSite
    } else {
      text-rootSite + "/" + slug
    }
  }
}

#let website = (
  title: "Portfolio",
  url: projectURL(false, none),
  text-url: projectURL(true, none),
  icon: "folder.svg",
)

#let email = (
  title: "Email",
  url: "mailto:" + email,
  text-url: email,
  icon: "envelope.svg",
)

#let github = (
  title: "GitHub",
  url: "https://github.com/" + githubHandle,
  text-url: "github.com/" + githubHandle,
  icon: "github.svg",
)

#let linkedin = (
  title: "LinkedIn",
  url: "https://www." + linkedin,
  text-url: linkedin,
  icon: "linkedin.svg",
)

#let example-project = (
  title: [Lancer Almanacs],
  url: projectURL(false, "my-project"),
  text-url: projectURL(true, "my-project"),
  date: [1668 - 1678],
  description: [
    Analyzed the Lancer farmers' almanac over ten years.
  ],
  technology: [
    in Rust
  ],
  details: (
    [
      Compared accuracy against actual weather patterns.
    ],
  ),
)

#let school = (
  title: [Master of Magic in Recent Runes],
  organization: [the Unseen University],
  location: [Ankh-Morpork],
  dates: [1657 - 1665],
  details: (
    [President of the Ancient Runes Study Society.],
  )
)

#let example-position = (
  department: [Department of Non-Evil Advisors],
  organization: [Kingdom of Genua],
  title: [Grand Vizier],
  location: [Genua],
  dates: [1666 - Present],
  show-detail: true,
  details: (
    [Facilitated a 10% increase in crop yields.],
    [Guided the organization through a period of instability, leading to a gain in productivity over two years.],
  )
)