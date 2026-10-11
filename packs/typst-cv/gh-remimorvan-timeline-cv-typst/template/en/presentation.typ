#import "../../timeline-cv.typ": *
#let metadata = toml("../metadata.toml")
#let section_presentation = section_presentation.with(data: metadata)

#section_presentation(
  "Alan",
  "Turing",
  "Computer Scientist",
  photo: image("../alan.png", width: 75%),
  contact: (
    (type: "envelope", link: "mailto:a.turing@aol.fr", display: "a.turing@aol.fr"),
    (type: "github", link: "https://github.com/alanTutu071", display: "alanTutu071"),
    (type: "phone", display: "+34.1.23.45.67.89"),
  ),
  presentation: lorem(13),
)
