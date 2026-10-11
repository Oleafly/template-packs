#import "/components/Skills.typ": Skills
#let Skills = Skills.with(aligned: left)

= Skills
Here are some skills rendered using the `Skills` component.
#let generic-skills = (
  [Communication],
  [Finance],
  [Gardening],
)

#let tech-skills = (
  [Bash],
  [Google docs],
  [Typst],
)

#Skills(
  header: [Technical],
  ..tech-skills,
)

#Skills(
  header: [Generic],
  ..generic-skills,
)
