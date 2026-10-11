#import "/template/tp-functions.typ": create-metadata-of-person 

// Document Meta Data
#let document-type = "Master thesis"
#let title = "Placeholder title"

// Person Involved Meta Data
#let authors = (
  create-metadata-of-person(title: "B.Sc.", prename: "Max", name: "Musstermann", e-mail: "max.mustermann@gmail.com", mnr: 12345),
  create-metadata-of-person(title: "M.Sc.", prename: "Anna", name: "Schmidt", e-mail: "anna.schmidt@example.com", mnr: 67890),
)
#let scientificSupervisors = (
  create-metadata-of-person(title: "Prof.", prename: "Emily", name: "Rosswell"),
  create-metadata-of-person(title: "Ph.D.", prename: "Carlos", name: "Jimenez")
)
#let technicalSupervisors = (
  create-metadata-of-person(title: "M.Sc.", prename: "Samantha", name: "Whitaker"),
  create-metadata-of-person(title: "M.Eng.", prename: "Derek", name: "Langford")
)

// DateTime Meta Data
#let last-edited-date = datetime.today()
#let start-date = datetime(day: 1, month: 1, year: 2025)
#let stop-date = datetime(day: 1, month: 7, year: 2025)
