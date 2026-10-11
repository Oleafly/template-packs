// edit these

#let name = "Bertram Gilfoyle"
#let links = (
  link("mailto:bgilfoyle@protonmail.ch"),
  link("tel:(415) 123-4567"),
  link("github.com/gilfoyle123"),
)

// page layout

#set text(font: "New Computer Modern", size: 12pt, lang: "eng")
#set page(margin: 0.5in, paper: "a4")
#set par(justify: true, leading: 0.7em)
#set line(start: (-0.125em, 0em), end: (100% + 0.125em, 0em), stroke: 0.375pt)
#show link: underline
#set table(
  stroke: 0em,
  inset: (left: 0.0em, right: 0.0em, top: 0em, bottom: 0em),
  row-gutter: 0.8em,
  column-gutter: 1.2em,
)
#show table.cell.where(x: 0): strong

// header formatting

#show heading.where(level: 1): it => [
  #set align(center)
  #set text(size: 18pt)
  #upper([#it])
]

#show heading.where(level: 2): it => [
  #set text(size: 14pt)
  #pad(upper([#it]), bottom: -10pt)
  #line()
]

#let sub_header(title: "", remark: "", dates: ()) = {
  [#strong(title), #emph(remark) #h(1fr) #emph([#dates.join(" - ")])]
}

// content

= #name

#align(center, [#links.join(" | ")])

== Experience

#sub_header(
  title: "Pied Piper, San Francisco",
  remark: "VP of Architecture & Security",
  dates: ("Jul 2014", "Aug 2018"),
)
- Implemented a revolutionary peer-to-peer decentralized internet infrastructure
- Designed security protocols for a distributed computing platform serving millions
- Developed custom network monitoring tools resulting in 99.99% uptime
- Led a team of system engineers and security specialists
- Implemented sophisticated DDoS protection systems
- Optimized server performance through custom distributed computing solutions

#sub_header(
  title: "Endframe, San Francisco",
  remark: "Senior Systems Engineer",
  dates: ("Jul 2013", "Jun 2014"),
)
- Designed and maintained distributed computing architecture
- Implemented security protocols for video compression platform
- Managed server infrastructure and optimization

#sub_header(
  title: "Various Startups, Toronto, Canada",
  remark: "Security Consultant",
  dates: ("Jul 2009", "Jun 2013"),
)
- Provided security auditing and penetration testing services
- Implemented secure network architectures
- Developed custom security solutions for diverse client needs

== Education

#sub_header(
  title: "University of Waterloo",
  remark: "B.S. Computer Science",
  dates: ("Oct 2005", "Jun 2009"),
)
- Full scholarship based on programming aptitude
- Focus on Security and Distributed Systems

== Skills

#table(
  columns: 2,
  "Languages", "C++, Python, Java, Assembly",
  "Tools", "AWS, Docker, Kubernetes",
)

== Awards

#table(
  columns: (auto, auto, 1fr),
  align: (auto, auto, right),
  "DEFCON CTF", "1st Place, Individual Category", emph("2017"),
  "University of Waterloo", "Outstanding Computer Science Graduate Award (2009)", emph("2009"),
)

== Certifications

- Certified Information Systems Security Professional (CISSP)
- Offensive Security Certified Professional (OSCP)
- AWS Certified Solutions Architect
- Certified Ethical Hacker (CEH)
