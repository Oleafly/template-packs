// Functionalty added for cleaner / easy-to-read documents


// own figure - raw implementation for conisntent code presentation
#let code(content, lang: none, caption: none) = [
  #set raw(lang: lang)
  #figure(caption: caption, supplement: [Quellcode], kind: "code", [#content])
]


// for easier biblography creation
#let create-bibliography(title: "Literaturverzeichnis", use-pagebreak: true) = [
  #bibliography("/src/bibliography/bibliography.bib", full: true, title: title)
  #if use-pagebreak { pagebreak() }
]


// for easier image outline creation
#let create-outline-images(title: "Abbildungsverzeichnis", use-pagebreak: true) = [
  #outline(
    title: title,
    target: figure.where(kind: image),
  )
  #if use-pagebreak { pagebreak() }
]


// for easier outline creation
#let create-outline(title: "Inhaltsverzeichnis", use-pagebreak: true) = [
  #outline(
    title: title,
  )
  #if use-pagebreak { pagebreak() }
]


// for easier table outline creation
#let create-outline-table(title: "Tabellenverzeichnis", use-pagebreak: true) = [
  #outline(
    title: title,
    target: figure.where(kind: table),
  )
  #if use-pagebreak { pagebreak() }
]


// for easier code outline creation
#let create-outline-Code(title: "Quellcodeverzeichnis", use-pagebreak: true) = [
  #outline(
    title: title,
    target: figure.where(kind: "code"),
  )
  #if use-pagebreak { pagebreak() }
]

#import "@preview/glossarium:0.5.1": make-glossary, register-glossary, print-glossary, gls, glspl

#let print-glossar(entry-list: none, use-pagebreak: true) = [
  #heading("Glossar", outlined: false, numbering: none)
  #print-glossary(entry-list)
  #if use-pagebreak { pagebreak() }
]

// creates a hole author with all the additional information fields
#let create-metadata-of-person = (
  prename: "Max",
  name: "Musstermann",
  sex: "male",
  title: none,
  mnr: none,
  address: none,
  phone: none,
  e-mail: none,
  webside: none
) => {
  let dic = (
    title: title,
    prename: prename,
    name: name,
    sex: sex,
    mnr: mnr,
    address: address,
    phone: phone,
    e-mail: e-mail,
    webside: webside
  )
  dic
}


// A function that given the full offical name of a person
#let get-full-name = (person, title: false) => {
  let fullname = ""
  if(person.title != none and title) {fullname += person.title + " " }
  if(person.prename != none) {fullname += person.prename + " " }
  if(person.name != none) {fullname += person.name }
  fullname
}


// creats a dictionary for the table of the cover page
#let get-titlepage-dictionary = (
  authors: none,
  technicalSupervisors: none,
  scientificSupervisors: none,
  title: true
) => {
  let dic = (:)
  // create the Authors line
  let authors-string = ""
  for author in authors{
    authors-string += get-full-name(author, title:title) + if(author != authors.last()){",\n"}
  }
  if(authors != none){
    let author-key = ""
    if(authors.len() > 1){
      author-key = "Authoren:"
    }else if(authors.first().sex == "male") {
      author-key = "Author:"
    } else if (authors.first().sex == "female"){
      author-key = "Authorin:"
    } else {author-key = "Author*in:"}
    dic.insert(author-key, authors-string)
  }
  // create the technicalSupervisor line
  let technicalSupervisors-string = ""
  for technicalSupervisor in technicalSupervisors{
    technicalSupervisors-string += get-full-name(technicalSupervisor, title:title) + if(technicalSupervisor != technicalSupervisors.last()){",\n"}
  }
  if (technicalSupervisors != none) {
    dic.insert("Fachliche Betreunung:", technicalSupervisors-string)
  }
  // create the technicalSupervisor line
  let scientificSupervisors-string = ""
  for scientificSupervisor in scientificSupervisors{
    scientificSupervisors-string += get-full-name(scientificSupervisor, title:title) + if(scientificSupervisor != scientificSupervisors.last()){",\n"}
  }
  if (scientificSupervisors != none) {
    dic.insert("Akademische Betreuung:", scientificSupervisors-string)
  }
  dic
}