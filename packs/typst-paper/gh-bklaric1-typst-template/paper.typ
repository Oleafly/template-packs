#import "/layout/proposal_template.typ": *
#import "/metadata.typ": *
#import "/layout/print_page_break.typ": *

#set document(title: title, author: author)

#show: proposal.with(
  title: title,
  program: program,
  supervisor: supervisor,
  author: author,
  university: university,
  description: description,
  bib_path: bib_path,
  logo_path: logo_path,
  submissionDate: submissionDate,
)

#outline(
  indent: auto
)
#pagebreak()

#set heading(numbering: "1.1")
#include "/content/1_example.typ"

#set heading(numbering: none)
#heading("List of Figures")
#outline(
  title: none,
  target: figure.where(kind: image)
)
#pagebreak()