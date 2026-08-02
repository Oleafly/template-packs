#let basic-styling(body) = {
  set page(numbering: "1", number-align: center)
  set heading(numbering: "1.1")
  set par(justify: true)
  set text(12pt, font: ("Times New Roman", "Noto Serif CJK SC"))
  set outline(indent: true)
  body
}

#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)

#let template_into=[
= Brief Introduction
This tempalate is designed to be used in daily notes for courses, meetings, lectures and etc, which now provides the following conveniences:

+ Basic Title, authors, date row
+ Definition, theorem term_box and note component for note taking
+ Fixed numbering for definition, theorem, term_box in the article and outline

= Syntax

== Definition

The definition function ```typc #def(body)``` accept 2 types of parameter:
+ A *Content* _body_
+ An *Array* _body_

For *Content*: The body must be formed like [concept:content]\
For *Array*: The body must be formed like ([concept_1:content_1], [concept_2:content_2])

== Theorem

Same as the ```typc #def()``` function, the```typc #theorem(body)``` function also accepts the same 2 types of parameter:
+ A *Content* _body_
+ An *Array* _body_

For *Content*: The body must be formed like [theorem:content]\
For *Array*: The body must be formed like ([theorem_1:content_1], [theorem_2:content_2])

== Term_box

The term_box is designed to be a complement for the definition and theorem component. The function ```typc #term_box(term, body)``` accepts 2 parameters:
+ Term: The name for the term, a string, _e.g. "Lemma"_.
+ Body: The main content of the term, which also can be in two types content and array the format is the same [term:content] or ([term_1:content_1],[term_2:content_2])

== Note

The note block is a simple but kind of fancy block in this minimalism template. The function ```typc #note(name: [], body)```, accepts 2 parameters: name and body. The name parameter in default an empety content, and the body is the content of the note, which can be whatever you want.
]



#let frontmatter(authors:  ("Authors Here As Array",),
                 title:    "Title Here As String",
                 subtitle: "Subtitle Here As String",
                 date:     "Date Here As String") = {

  //Title and date
  align(center, {
    block(text(weight: 700, 1.75em, title))
    v(1em, weak: true)
    subtitle
    linebreak()
    date}
    )


  //Authors information
  align(center, { box(width: 85%, {
    context {
    
      let max_width = 0pt

      for author in authors {
        if measure(author).width > max_width {
          max_width = measure(author).width
        }
      }

      for author in authors {
        box(width: max_width+1em, {author})
      }
    }
  })})
}

#let split_body(con)={
  if con.has("children"){
    if con.children.len()==0 { return (con,) }
    let search_colon(item)={
      if item.has("text"){
        if item.text==":" or item.text=="：" {
          return true
        }
        else{
          return false
        }}
      else{
        return false
      }
    }
    
    let pos=con.children.position(item=>search_colon(item))
    let name=[];let content=[]
    
    if pos!=none {
      name=[#con.children.slice(0,pos).join()];content=[#con.children.slice(pos+1).join()]}
  
    return (name,content)
  }
  
  else { return (con,) }
}

#let note(name: [],body) = {
  align(center)[
  #block(fill: luma(230),inset: 8pt,radius: 4pt, width: 95%)[
  #align(start)[
  *Note*: #name

  #body
  ]]]
}

#let term_box(term,
              term_counter: "",
              body) = {
  
  if body == [] {
    body = [
      #text(fill: gray, style: "italic")[Term here ...]: 
      #text(fill: gray, style: "italic")[Term content here ...]
    ]
  }

  if term_counter == "" {
    term_counter = term
  }

  if type(body) == "array" {
    
    locate( loc => {

      let levelin=counter(heading).at(loc).len()
      let num=(query(selector(label(term_counter)).before(loc),loc).len()+1)
      let i=0
      
      align(center)[ #rect(width: 95%)[ #align(start+horizon)[ #pad(top: 5pt,bottom: 5pt)[

        #for def in body {   
          [
            #heading(level: levelin+1, numbering: none)[
            #text(style: "italic")[#term] 
            #num+i: 
            #split_body(def).at(0)]
            #label(term_counter)
          ]
          split_body(def).at(1)

          i=i+1
        }
      ]]]]
    })
  }

  if type(body) == "content" {
    locate( loc => { 
      
      let levelin = counter(heading).at(loc).len()
    
      align(center)[ #rect(width: 95%)[ #align(start+horizon)[ #pad(top: 5pt,bottom: 5pt)[
      
        #heading(level: levelin+1, numbering: none)[
          #text(style: "italic")[#term] 
          #(query(selector(label(term_counter)).before(loc),loc).len()+1): 
          #split_body(body).at(0)
        ]
        #label(term_counter)

        #split_body(body).at(1)
      ]]]]
    })
  }
}

#let def(body) = {
  term_box("Definition", term_counter: "def", body)
}

#let theorem(body) = {
  term_box("Theorem", term_counter: "th", body)
}