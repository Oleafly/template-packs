#let getDate(date) = {
  if date.month < 1 or date.month > 12 {
    panic("Fecha no valida")
  }
  let monthTxt = ("enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre")
  
  return str(date.day) + " de " + monthTxt.at(date.month - 1) + " de " + str(date.year)
}

#let project(subject:"", title: "", authors: (), date: (), isIndexed: bool ,body) = {
  set document(author: authors, title: title)
  set page(
    paper: "us-letter", 
    numbering: none, 
    number-align: center,
    margin: (x: 2cm, y: 2cm)
  )
  set text(font: "New Computer Modern", lang: "es")

  align(center)[
    // You can change the header of the cover page by your own image, recommended sizes
    // width: 1800px; height: 320px
    #block((image("header.jpg", width: 100%)))
    // The faculty name can be changed
    #block(text(weight: 700, 1.8em, "Facultad de ingeniería"))
    #v(15%, weak: true)
    #block(text(weight: 500, 2em, subject))
    #v(15%, weak: true)
    #block(text(weight: 300, 2em, style: "italic", title))
    #align(bottom)[
      #if authors.len() == 1{
        text(weight: 300, 1.5em, "Alumno:") 
      }else if authors.len() > 2 {
        text(weight: 300, 1.5em, "Alumnos:") 
      }
      #for author in authors [
        #block(text(weight: 300, 1.5em, author))
      ]
      #v(10%, weak: true)
      #block(text(weight: 300, 1.3em, getDate(date))) 
    ]
  ]
  set page(numbering: "1")

  if isIndexed == true {
    outline(depth: 3, indent: true)
    pagebreak()
  }
  
  body
}