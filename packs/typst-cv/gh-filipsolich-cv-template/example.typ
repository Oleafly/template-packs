#import "template.typ": CV, chips

#let lang = "en"

#let personalInfo = (
  name: "John Doe",
  degrees: ("Ing.",),
  photo: "photos/me.jpg",
  links: (
    (
      icon: "icons/email.svg",
      link: link("mailto:john@example.com", "john@example.com")
    ),
    (
      icon: "icons/phone.svg",
      link: link("tel:+420123456789", "+420 123 456 789")
    ),
    (
      icon: "icons/github.svg",
      link: link("https://github.com/GitHub", "John")
    ),
    (
      icon: "icons/linkedin.svg",
      link: link("https://www.linkedin.com", "in/john")
    ),
    (
      icon: "icons/location.svg",
      link: link("https://www.openstreetmap.org/relation/435514", "Prague / Czech republic")
    ),
  )
)

#let jobs = (
  title: "Experience",
  jobs: (
    (
      title: "Senior developer",
      company: "Company 3",
      description: [
        - #lorem(15)
        - #lorem(11)
        - #lorem(18)
      ],
      chips: (chips.python, chips.docker),
      dateFrom: "july 2023",
      dateTo: "december 2025",
      logo: "logos/3.png"
    ), (
      title: "Medior developer",
      company: "Company 2",
      description: [
        - #lorem(20)
        - #lorem(12)
        - #lorem(8)
      ],
      chips: (chips.python, chips.fastapi, chips.mongo, chips.grpc),
      dateFrom: "january 2023",
      dateTo: "july 2023",
      logo: "logos/2.png"
    ), (
      title: "Junior developer",
      company: "Company 1",
      description: [
        - #lorem(12)
        - #lorem(13)
      ],
      chips: (chips.cpp, chips.postgres, chips.redis),
      dateFrom: "june 2010",
      dateTo: "january 2023",
      logo: "logos/1.png"
    ),
  ),
)

#let education = (
  title: "Education",
  education: (
    (
      title: "Master degree",
      company: "University name",
      description: [#lorem(10)],
      dateFrom: "2008",
      dateTo: "2010",
      logo: "logos/2.png"
    ), (
      title: "Bachelor degree",
      company: "University name",
      description: [#lorem(12)],
      dateFrom: "2005",
      dateTo: "2008",
      logo: "logos/1.png"
    ),
  ),
)

#let projects = (
  title: "Projects",
  projects: (
    (
      title: "Proj 1",
      description: [
        #lorem(10)
        - #lorem(10)
        - #lorem(15)
        - #lorem(13)
      ],
      link: [#box(baseline: 0.15em, height: 1em, image("icons/github.svg")) #link("https://github.com")],
      chips: (chips.go, chips.rabbitmq, chips.github),
      logo: "logos/1.png"
    ),
  ),
)

#let certifications = (
  title: "Certifications",
  certs: (
    (
      title: "Cisco CCNA: Routing and switching",
      issuer: "Cisco Network Academy",
      date: "2010",
      logo: "logos/1.png"
    ),
  ),
)

#let languages = (
  title: "Languages",
  langs: (
    ("Czech", "C2"),
    ("English", "B2"),
  ),
)

#CV(lang, personalInfo, languages, jobs, education, projects, certifications)
