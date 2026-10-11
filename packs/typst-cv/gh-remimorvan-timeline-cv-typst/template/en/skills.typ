#import "../../timeline-cv.typ": *
#let metadata = toml("../metadata.toml")
#let entry_skill = entry_skill.with(data: metadata)

#section_items(
  title: "Tech Stack",
  (
    entry_skill(
      title: [Brainfuck],
      level: 3,
    ),
    entry_skill(
      title: [Python],
      level: 2,
      details: "scikit, numpy",
    ),
    entry_skill(
      title: [Javascript],
      level: 2,
    ),
    entry_skill(
      title: [C],
      level: 1,
    ),
    entry_skill(
      title: [Django],
      level: 1,
    ),
  ),
)
