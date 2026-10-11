#import "template.typ": *

#show: resumeContent.with(
  author: (
      firstname: lorem(1), 
      lastname: lorem(1),
      email: "yourEmail@xxx.xx", 
      phone: "+1 9876543210",
      github: "github.com/username",
      linkedin: "linkedin.com/in/username",
  )
)

== TECHNICAL SKILLS
- *Programming Languages*: Java, Python, C, C++, JavaScript, TypeScript
- *Tools&Platforms*: Git, Linux, Docker, Kubernetes, AWS, Azure, GCP

== Education
#experienceBlock(
  title: "M.Eng. xxxxxxxx, GPA 4.0/4.0",
  subtitle: "Xxxxxx University",
  startDate: "Sep 2077",
  endDate: "May 2028 (Expected)",
  address: "Xxxxx, Xxxxx"
)[]

#experienceBlock(
  title: "B.Eng. in Xxxxx, GPA 4.0/4.0",
  subtitle: "Xxxxxxxxx University",
  startDate: "Sep 2017",
  endDate: "Jun 2021",
  address: "Xxxxxxx, Xxxxx",
)[]

== Work Experience
#experienceBlock(
  title: lorem(2),
  titleLink: "https://www.google.com",
  subtitle: "Software Engineer Intern; Java, Spring, MySQL, Git, Linux",
  startDate: "Jan 2077",
  endDate: "Apr 2077",
  address: "Xxxxx, Xxxxx",
)[
  - #lorem(30)
  - #lorem(30)
  - #lorem(30)
]

#experienceBlock(
  title: lorem(2),
  titleLink: "",
  subtitle: "Software Engineer Intern; Java, Spring, MySQL, Git, Linux",
  startDate: "Jan 2077",
  endDate: "Apr 2077",
  address: "Xxxxx, Xxxxx",
)[
  - #lorem(30)
  - #lorem(30)
  - #lorem(30)
]

== Projects
#experienceBlock(
  title: lorem(2),
  titleLink: "",
  subtitle: "Java, Spring, MySQL, Git, Linux",
  startDate: "Jan 2077",
  endDate: "Apr 2077",
  address: "Xxxxx, Xxxxx",
)[
  - #lorem(30)
  - #lorem(30)
]
#experienceBlock(
  title: lorem(2),
  titleLink: "https://www.google.com",
  subtitle: "Java, Spring, MySQL, Git, Linux",
  startDate: "Jan 2077",
  endDate: "Apr 2077",
  address: "Xxxxx, Xxxxx",
)[
  - #lorem(30)
  - #lorem(30)
]

#experienceBlock(
  title: lorem(2),
  titleLink: "",
  subtitle: "Java, Spring, MySQL, Git, Linux",
  startDate: "Jan 2077",
  endDate: "Apr 2077",
  address: "Xxxxx, Xxxxx",
)[
  - #lorem(30)
  - #lorem(30)
]


#align(right, text(fill: gray)[Last Updated on #today()])