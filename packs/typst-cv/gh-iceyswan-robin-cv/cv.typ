// Imports
#import "/robin-cv.typ": cv

#let metadata = toml("metadata.toml")

#show: cv.with(
  metadata,
  profile-photo: image("assets/robin.png"),
)

#include "contents/education.typ"
#include "contents/professional.typ"
#include "contents/certificates.typ"
#include "contents/skills.typ"
#include "contents/projects.typ"

//#include "contents/publications.typ"
