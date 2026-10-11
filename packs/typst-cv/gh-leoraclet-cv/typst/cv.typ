// Imports
#import "@preview/brilliant-cv:2.0.5": cv
#let metadata = toml("./metadata.toml")
#let importModules(modules, lang: metadata.language) = {
  for module in modules {
    include {
      lang + "/" + module + ".typ"
    }
  }
}

#show: cv.with(
  metadata,
  profilePhoto: "",
)
#importModules((
  "professional",
  "education",
  "projects",
  "certificates",
  // "publications",
  "skills",
))
