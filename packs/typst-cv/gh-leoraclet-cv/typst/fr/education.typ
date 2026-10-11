// Imports
#import "@preview/brilliant-cv:2.0.5": cvSection, cvEntry, hBar
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)
#let cvEntry = cvEntry.with(metadata: metadata)


#cvSection("Formation")

#cvEntry(
  title: [Diplôme d'ingénieur - Electronique et télécommunications (en cours)],
  society: [Télécom Saint-Etienne],
  date: [2023 -- Présent],
  location: [Saint-Etienne, France],
  //logo: image("../src/logos/ucla.png"),
  description: list(
    [Télécommunications, antennes et fibres optiques - Modulation et codage],
    [Circuits logiques programmables - Systèmes embarqués],
  ),
)

#cvEntry(
  title: [DUT GEII et Licence L2 d'ingénieur (Prépa intégrée)],
  society: [Télécom Saint-Etienne],
  date: [2021 - 2023],
  location: [Saint-Etienne, France],
  //logo: image("../src/logos/ucla.png"),
  description: list(),
)
