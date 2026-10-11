#import "makalah_utils.typ"
#let date = datetime.today().year();
#let authors = ((name: "Febri Bayu Nurcahyo", nim: 123),)
#let title = [Makalah Atom]
#let note = [Makalah ini disusun guna\
memenuhi tugas Amnesty.]

#makalah_utils.cover(title, authors, note, date)[
  // CONTENT
]
