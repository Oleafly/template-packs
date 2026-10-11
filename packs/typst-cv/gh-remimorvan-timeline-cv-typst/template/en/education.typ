#import "../../timeline-cv.typ": *
#let metadata = toml("../metadata.toml")
#let entry_main = entry_main.with(data: metadata)

#section_timeline(
  icon: "user-graduate",
  title: "Education",
  content: (
    entry_main(
      when: [Sept. 2006 – Aug. 2010],
      where: [National University of Illiberal Arts],
      details: [Berne, #smallcaps[ch]],
      title: [Ph.D. in Robotics],
    )[#lorem(31)],
    entry_main(
      when: [Sept. 2004 – Aug. 2006],
      where: [École Normale Supérieure de Tourcoing],
      title: [Masters of Mathematics and Biology],
    )[#lorem(15)],
    entry_main(
      when: [Sept. 2001 – Aug. 2004],
      where: [Waterside University],
      title: [Bachelor of Mathematics],
    )[],
  ),
)
