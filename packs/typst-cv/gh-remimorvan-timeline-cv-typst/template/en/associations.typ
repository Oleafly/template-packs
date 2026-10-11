#import "../../timeline-cv.typ": *
#let metadata = toml("../metadata.toml")
#let entry_side = entry_side.with(data: metadata)

#section_items(
  title: "Associative Experience",
  (
    entry_side(
      title: [Member],
      preposition: [of the],
      where: [City Council of Vienna],
      when: [since Mar. 2025],
    )[],
    entry_side(
      title: [President],
      preposition: [of the],
      where: [XY Club],
      when: [Aug. 2016 – Sep. 2018],
    )[],
  ),
)
