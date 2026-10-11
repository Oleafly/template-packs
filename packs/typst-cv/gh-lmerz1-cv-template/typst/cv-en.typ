#import "data-entries.typ": render-cv, name

#set document(
  title: "Résumé",
  author: name,
  keywords: ("CV", "Resume", "Job Application"),
  date: datetime.today(),
)

#render-cv()
