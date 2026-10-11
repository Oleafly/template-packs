#import "../template.typ": *

#show: cv.with(
  name: "Solomon Grundy",
  contact: (
    email: link("mailto:solomon@grundy.xyz"),
    linkedin: link("linkedin.com/in/steigers"),
    website: link("www.bornonmonday.xyz"),
  ),
  accent: rgb("#4a7c8e"),
  icon-path: "example/icons/",
)

#section(
  "Education",
  (
    name: "PhD, Archvillain",
    institution: "Bane Academy",
    date: "2021-",
    description: "Thesis title: How to annoy Batman",
  ),
  (
    name: "MSc Villainism",
    institution: "Arkham City University",
    description: "Thesis title: Know your poems",
    date: "2019-2021",
  ),
  (
    name: "BSc Public Nuisance",
    institution: "Arkham City University",
    description: "Thesis title: Born on Monday, died on Tuesday",
    date: "2017-2019",
  ),
)

#section(
  "Research",
  (
    name: "PhD Researcher",
    institution: "Bane Academy",
    date: "2021–",
    description: "Investigating strategies to exploit deontistic vigilante superheroes.",
  ),
  (
    name: "Research Assistant",
    institution: "Arkham City University",
    date: "2019–2021",
    description: "Laboratory management and statistical analysis for a longitudinal cohort study of bats.",
  ),
)

#publications("example/bibliography.bib", style: "apa")

#section(
  "Grants",
  (
    name: "Criminal Prodigy Research Grant",
    date: "2024",
    description: "10,000€ – Awarded by Bane Academy.",
  ),
  (
    name: "Best Explosive Contraption Award",
    date: "2023",
    description: "150€ – Built an explosive batarang in under 30 minutes.",
  ),
)

#section(
  "Teaching",
  (
    name: "Antagonism I",
    institution: "Bane Academy",
    date: "2022–",
    description: "Teaching this course every year to Bachelor students.",
  ),
  (
    name: "Explosive contraptions for dummies",
    institution: "Gotham Institute",
    date: "2023",
    description: "Taught this course as a guest lecturer.",
  ),
)

#section(
  "Conferences",
  (
    name: "Neighbourhood deprivation drives villainry: new evidence from Gotham City",
    description: "International Conference of Villains, Gotham City",
    date: "2023",
  ),
  (
    name: "Tricking superheroes: what you need to know",
    description: "Congress of Deception, Arkham City",
    date: "2022",
  ),
)

#skills(
  (
    category: "Software",
    content: list([HTML], [R], [Julia]),
  ),
  (
    category: "Languages",
    content: list([German], [English], [Swedish]),
  ),
)

#pagebreak()

#section(
  "References",
  (
    name: "The Joker",
    institution: "Criminal Mastermind Inc.",
    description: "iwillfindyou@first.com",
  ),
)
