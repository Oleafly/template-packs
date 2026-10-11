// Imports
#import "@preview/brilliant-cv:2.0.5": cvSection, cvEntry
#let metadata = toml("../metadata.toml")
#let cvSection = cvSection.with(metadata: metadata)
#let cvEntry = cvEntry.with(metadata: metadata)


#cvSection("Projets Personnels & Scolaires")

#cvEntry(
  title: [Github],
  society: [Génerateur de fractales],
  date: [2023],
  location: "",
  description: list(
    [Un programme écrit en C / C++ permettant de générer et d'explorer des fractales stylisées],
    [Utilisation de SFML et de OpenGL pour permettre le zoom en temps réel],
  ),
  tags: ("C / C++", "SFML", "OpenGL", "Fractales", "Git")
)
