// Imports
#import "@preview/brilliant-cv:2.0.5": cvSection, cvHonor
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)
#let cvHonor = cvHonor.with(metadata: metadata)


#cvSection("Participations")

#cvHonor(
  date: [2025],
  title: [67 ème],
  issuer: [404CTF 2025],
)

#cvHonor(
  date: [],
  title: [63 ème],
  issuer: [Coupe de France de Robotique 2025],
)

#cvHonor(
  date: [2024],
  title: [61 ème],
  issuer: [404CTF 2024],
)

#cvHonor(
  date: [],
  title: [40 ème],
  issuer: [HeroCTF v6 2024],
)
