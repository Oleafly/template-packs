// journal.typ - Custom Typst library for journal formatting

// Define a macro for the journal title
#let journal-title(title) = {
    set text(size: 20pt)
    set align(center)
    set page-align(center)
    strong[#journal-title]
}

#let title(body) = {
  set text(font: "IBM Plex Sans",
  weight: 400,
  size: 28pt)
  set align(center)
  image("articlestart.png", width: 30pt)
  [#body]
}

#let subtitle(body) = {
  set align(center)
  set text(font: "IBM Plex Sans", size: 20pt, weight: 500)
  [#body]
}

#let author(body) = {
  set align(center)
  set text(font: "IBM Plex Sans", size: 14pt, weight: 500)
  [#body #block(below: 2em) ]
}
// Define a macro for the author name
#let author-name(name) = {
    set text(font: "IBM Plex Sans",
    size: 18pt,
    weight: 400)
    set align(center)
    [#name]
}

#let epigraph(body) = {
  set align(right)
  [#body]
}


#let abstract(abstract-title, abstract-subtitle: none, abstract-author: none, body, abstract-keywords: [nothingness, testing, kitty cats, ontology, meow]) = {
  set text(font: "Libertinus Serif", size: 12pt)
  set par(justify: true)
  
  rect(
    width: 100%,
    height: 100%,
    fill: rgb(227, 224, 224),
    inset: 5%
  )[
    #set align(center)
    #set par(first-line-indent: 0pt)
    #text(font: "IBM Plex Sans", size: 12pt, weight: 600)[#[#abstract-title]]
    #if abstract-subtitle != none [
      #v(0.5em)
      #text(font: "IBM Plex Sans", size: 12pt, weight: 600)[#[#abstract-subtitle]]
    ]
    #if abstract-author != none [
      #v(0.5em)
      #text(font: "IBM Plex Sans", size: 8pt)[#emph[by]] #text(font: "IBM Plex Sans", size: 12pt)[#[#abstract-author]]
    ]
    #set align(left)
    #v(1em)
    #[#body]
    #v(2em)
    #set align(center)
    #image("articlend.png", width: 30pt)
    #set align(left)
    #v(1fr)
    *Keywords:* #abstract-keywords
  ]
}

#let biobox(body) = {
  set align(center) 
  v(1em)
  image("articlend.png", width: 25pt)
  set align(left)
  v(1em)
  rect(width: auto,
  height: auto,
  stroke: none,
  fill: rgb(227, 224, 224),
  inset: 7.5%,
  body)
}

#let article-start-image = {
  set align(center)
  image("articlestart.png", width: 30pt)}

#set heading(numbering: "I.")

#set text(
  font: "IBM Plex Sans",
)

#let article(article-header, content) = {
  article-header
  content
}

