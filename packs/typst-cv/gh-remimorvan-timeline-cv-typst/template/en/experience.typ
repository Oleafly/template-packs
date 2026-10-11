#import "../../timeline-cv.typ": *
#let metadata = toml("../metadata.toml")
#let entry_main = entry_main.with(data: metadata)

#section_timeline(
  icon: "suitcase",
  title: "Professional Experience",
  content: (
    entry_main(
      when: [since Sept. 2021],
      where: [Beelzebub Inc],
      title: [Head of the Human Rights Department],
    )[#lorem(32)],
    entry_main(
      when: [Sept. 2019 – Nov. 2021],
      where: [Quetzalcoatl & co],
      details: [Hamburg, #smallcaps[de]],
      title: [Special Advisor],
    )[#lorem(14)],
    entry_main(
      when: [Feb. 2011 – Aug. 2019],
      where: [Isis #smallcaps[sarl]],
      title: [Research Engineer],
    )[#lorem(20)],
    entry_main(
      when: [Apr. 2006 – July 2006],
      where: [Jupiter Inc],
      title: [Intern in the Human Ressources Department],
    )[#lorem(21)],
  ),
)
