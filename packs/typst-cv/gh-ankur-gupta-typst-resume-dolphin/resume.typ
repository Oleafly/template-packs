#import "theme/dolphin.typ": detailed_cv, google_scholar_footer, template, read_me, education, read_education, patents, articles, conferences, positions, codelink, codetxt

// `path` value remembers where it was constructed
#let me = read_me(path("./me/me.yml"))
#let links = yaml(path("./me/links.yml"))
#let educations = read_education(path("./me/education.yml"))
#let selected(tag: "resume") = {
  let p = patents(path("./me/patents.yml"), tag: tag)
    let a = articles(path("./me/articles.yml"), tag: tag)
    let c = conferences(path("./me/conferences.yml"), tag: tag)
    let ia = conferences(path("./me/invited_articles.yml"), tag: tag)
    let ip = conferences(path("./me/invited_conferences.yml"), tag: tag)
    let all = p + a + c + ia + ip
    all
}

#let summary = [
  ML Scientist with a PhD in CS. Dummy Summary.
]

#let body = [
  = Professional Experience
  #positions(list: (
    (
      title: "Senior Applied Scientist",
      company: "XYZ, Sunnyvale, CA",
      start: "May 2024",
      end: "Present",
    ),
  ))
  - Science lead for the #link(links.link_1, "C-level") strategic initiative
  - Did lots of things

  #positions(list: (
    (
      title: "Head of Artificial Intelligence",
      company: "PQR, Mountain View, CA",
      start: "May 2023",
      end: "May 2024",
    ),
  ))
  - Did lots of things
  - Filed 2 ML patents, authoring papers, and secured \$1M+ #link(links.link_1, "grant") to design plastic-degrading enzymes
  - Increased productivity (by #text(sym.approx + "50%")) and reduced compute costs (by #text(sym.approx + "20%"))

  #positions(list: (
    (
      title: "Quantitative Trader",
      company: "Alpha First, NY",
      start: "Jan 2014",
      end: "Dec 2016",
    ),
    (
      title: "(Numerical Optimization Specialist)",
    ),
  ))
  - Developed optimization algorithms
  - Won 1 patent

  // #pagebreak()

  = Education
  #education(educations.phd, university_long: true, advisor: false)
  #education(educations.dual, university_long: false, thesis: false, advisor: false)

  = Selected Accomplishments & Awards
  - Went to the moon, 2023
  - Filed patents, Alpha First, 2021
  - Engineering Award, PQR, July 2017
  - Company-wide impact awards, XYZ, _twice_, 2015 & 2016

  = Technical Skills & Open Source Projects
  - #text(weight: "semibold", "Python"), Cython, shell, SQL, #codelink(links.link_2, "scala"), HTML/CSS/React/Typescript, LaTeX, #codelink(links.link_1, "typst"), #codetxt("R")
  - PyTorch, Strands, PySpark, Docker, AWS
  - Open Source Projects: #codelink(links.link_1, "my-project"), #codelink(links.link_2, "link-2") (_total 165+ stars, 25+ forks_)

  = Selected Patents & Publications
  #enum(..selected(tag: "resume"))
]


#show: body => template(
  tight: false,
  me: me,
  summary: summary,
  body: body,
)

// #v(-2em)
#body
#google_scholar_footer(url: me.google_scholar, top_padding: 1em)
// #detailed_cv(url: links.detailed_cv, top_padding: 1em)
