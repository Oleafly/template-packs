#import "/layouts/frontpage.typ": front-page
#import "/layouts/coverpage.typ": cover-page
#import "Approval.typ": approval-certificate
#import "/layouts/style.typ": style


#let set-style(doc) = {
 return (
  style(doc)
)
}


#show: doc => style(doc)


#let generate-report(
  info: (:),
  body,
) = {
  info = (
    document-type: "Report",
    project-type: "Major",
    title: "BitMaatDaan",
    students : ("Student 1", "Student 2", "Student 3"),
    logo: image("/assets/gces-logo.png", width: 30%),
    date: datetime.today(),
    project-head: "Project Head name",
    supervisor: none,
    front-matter: (:),
    back-matter: (:),
  ) + info

  set page(numbering: none)
  cover-page(
    document-type: info.document-type,
    project-type: info.project-type,
    title: info.title,
    students: info.students,
    logo: info.logo,
    date: info.date
  )
  if info.supervisor != none {
  front-page(
    document-type: info.document-type,
    project-type: info.project-type,
    title: info.title,
    students: info.students,
    logo: info.logo,
    date: info.date,
    supervisor: info.supervisor
  )
}

  // Start Page numbering From Start
  counter(page).update(1)
  //Set page numbering style to i,ii...
  set page(numbering: "i") 
  approval-certificate(
  title: info.title,
  students: info.students,
  supervisor: info.supervisor,
  project-head: info.project-head,
  date: info.date
  )
  
  // Iterate over front matters like Acknowledgement, Abstract. etc
  for items in info.front-matter{
    include items
    pagebreak()
}

  //No Page Numbers For Table of contents, list of figures and tables
  set page(numbering: none)


  outline(title: "Table Of Contents")
  pagebreak()
  outline(title: "List Of tables", target: figure.where(kind: table))
  pagebreak()
  outline(title: "List Of Figures", target: figure.where(kind: image))
  pagebreak()

  //Heading Counter resets for the rest of the documents
  counter(heading).update(0)
  // Page Counter resets to 1 for rest of the document
  counter(page).update(1)
  body

  if info.bib != () {
      pagebreak()
      info.bib
    }
  pagebreak()
  // Iterate over back mater like wireframes, Appendices, etc..
  for items in info.back-matter {
    include items
    pagebreak()
}
  }


