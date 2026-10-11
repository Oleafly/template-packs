#let temp(
  name: "",
  title: "",
  logo: "logo.png",
  group: "",
  year: "202x",
  lab-number: "0",
  doc
) = [
#set par(
  justify: true,
  leading: 1em,
  first-line-indent: (
    amount: 1.5cm,
    all: true,
  )
)

#set text(
  font: "Times New Roman",  
  size: 12pt,
)

#set page(
  footer: context [
    #let page-num = counter(page).get().first()
    #if page-num > 2 [
      #align(center, str(page-num))
    ]
  ],
)

#v(-.4cm)
#align(center)[
  #image(logo, width: 23%)

  #box[
    #v(2em)
    #set text(
        hyphenate: false,
    )
    #par(
      leading: 1em,
    )[
    #strong[Ministerul Educației și Cercetării Al Republicii Moldova] \
    #strong[Universitatea Tehnică a Moldovei] \
    #strong[Facultatea Calculatoare, Informatică și Microelectronică]
    ]
    #v(5em)
    #box[
        #set par(
            leading: .7em,
        )
    #text(
        19pt,
        hyphenate: false,
    )[
      Laboratory Work #lab-number:\
      #title
      ]
    ]
  ]

]
  #v(1fr)


#block[
    #set par(
        leading: .7em,
        first-line-indent: (
            amount: 0pt,
            all: false),
    )
    #set text(
        16pt,
    )
    
    Elaborated:\
    st. gr. #group #h(1fr) #name \
    \
    Verified:\
    asist. univ. #h(1fr) Fiștic Cristofor
]

#v(1fr)

#align(center+bottom)[
#text(14pt)[  
  #strong[Chișinău – #year]
]
]

#pagebreak()

//Set the level 1 to bold aka strong

#block()[

    #set par(leading: .7em)
    
    #show outline.entry.where(
    level: 1
    ): set text(weight: "bold") 
    
    #outline(title: [#h(1fr)Table of Contents#h(1fr)])

]


#pagebreak()

#show heading: it => {
    set block(below: 1em, above:1em)
    let indent-amount = (it.level - 1) * 1.5em
    pad(left: indent-amount, it)
}

#show heading.where(level: 1): it => {
    set block(below: 1.5em, above:1.5em)
    pagebreak(weak: true)
    set align(center)
    set text(
        size: 13pt,
        weight: "bold"
    )
    block[
        #if it.numbering != none [
            #counter(heading).display(it.numbering)
            #h(0.5em)
        ]
        #upper(it.body)
    ]

}
  
// #set heading(numbering: "")


#show heading.where(level: 2): set text(size: 12pt)

#set page(
margin: (top: 20mm, right: 10mm, bottom: 20mm,  left: 20mm),
)



#show raw: set text(font: "Courier New", size: 9pt)
#show raw: set par(leading: 1em)

#show raw.where(block: true): it => {
// if its a in a figure dont pad
// some code blocks dont have a field parent
if it.has("parent") and it.parent.type == "figure" {
    it
} else {
    pad(left: 4em, it)
}

}

#set list(marker: "-")

#set enum(
numbering: "1.a.",
indent: 1.5em,
)

#let end-line(line, i , max) = {
return [
  #line#if i < max - 1 [;] else [.]\
]
}

#let end-line-list(lines) = {
let new-lines = ()
for (i, line) in lines.enumerate() {
  new-lines.push(end-line(line, i, lines.len()))
}
return new-lines
}

#let slist(lines) = {
list(..end-line-list(lines))
}

#let elist(lines) = {
enum(..end-line-list(lines))
}

#show figure.caption: it => [
    #set text(
        10pt,
        weight: 100
    )
    #emph[
        #it.supplement // "Figure"
        #it.counter.display() // "1"
        #it.body // The actual caption text
    ]       
]

#doc
]