#import "config.typ": *
// ------Styles------------

#import "style.typ" : init_conf
// --------End Styles----------

#show: doc => init_conf(doc)


// Title page
#include "chapters/titlepage.typ"
#pagebreak()

// Blank page
#pagebreak()

// signatures page
#include "chapters/signatures.typ"
#pagebreak()

// Acknowledgements
#include "chapters/acknowledgements.typ"
#pagebreak()

// Thanks
#include "chapters/thanks.typ"
#pagebreak()
// #show outline.entry.where(level: 1): set outline.entry(fill: none)
#context {
  show outline.entry.where(level: 1): it => {
    let strong-headings = ("General introduction","General conclusion","Bibliography")
    v(0.8em)
    link(
      it.element.location(),
      grid(
        columns: (1fr, auto),
        align: (left, right),
        gutter: 1em,
        if it.body().text in strong-headings {
          strong(it.body())
        } else {
          strong([#it.prefix() #it.body()])
        },
        strong(it.page())
      )
    )
  }

  outline(
    title: [= Contents],
    target: selector(heading).after(<ostart>)
  )
}


#pagebreak()
#outline(
  title: [= List of figures],
  target: figure.where(kind: image),
)

#pagebreak()
#outline(
  title: [= List of tables],
  target: figure.where(kind: table),
)

#metadata("outline-start") <ostart>



// #set page(numbering: "1")
#set page(
  header-ascent: header_ascent,    // Proper spacing from text
  footer-descent: footer_descent,  // Proper spacing from text
  footer: [
    #v(0.5em)  // Add space above footer
    #block(
      width: 100%,
      stroke: (top: 1pt),
      inset: (top: 0.8em, bottom: 0.3em),  // More internal padding
      context[
        #align(center)[
          #counter(page).display("1")
        ]
      ]
    )
    #v(0.2em)  // Add space below footer
  ]
)
#counter(page).update(1)


// Chapters

#include "chapters/general-introduction.typ"
#pagebreak()

#counter(heading).update(0)




#include "chapters/chapter-01.typ"
#pagebreak()


#include "chapters/chapter-02.typ"
#pagebreak()


#include "chapters/chapter-03.typ"
#pagebreak()


#include "chapters/general-conclusion.typ"
#pagebreak()


// Bibliography
= Bibliography

#show bibliography: none

#import "@preview/citegeist:0.2.0": load-bibliography

#context {
  let bibtex_string = read("references.bib")
  let bib = load-bibliography(bibtex_string)
  
  // Get all bibliography keys in sorted order
  let all_keys = bib.keys().sorted()
  
  // Render each citation
  for (index, key) in all_keys.enumerate() {
    let entry = bib.at(key)
    let fields = entry.fields
    let num = index + 1
    
    // Start with number
    text(weight: "regular", "[" + str(num) + "] ")
    
    // Format author
    let author_str = ""
    if "parsed_names" in entry and "author" in entry.parsed_names {
      let authors = entry.parsed_names.author
      author_str = authors.map(a => {
        if a.given != "" {
          a.family + ", " + a.given.split(" ").filter(n => n.len() > 0).map(n => n.at(0) + ".").join(" ")
        } else {
          a.family
        }
      }).join(" and ")
    } else if "author" in fields {
      author_str = fields.at("author", default: "")
    }
    
    if author_str != "" {
      text(author_str)
      text(". ")
    }
    
    // Year
    if "year" in fields {
      text("(" + fields.year + "). ")
    }
    
    // Title
    if "title" in fields {
      text(fields.title)
      text(". ")
    }
    
    // Journal (for articles)
    if "journal" in fields {
      text(style: "italic", fields.journal)
      if "volume" in fields {
        text(", " + fields.volume)
        if "number" in fields {
          text("(" + fields.number + ")")
        }
      }
      if "pages" in fields {
        text(", " + fields.pages)
      }
      text(". ")
    }
    
    // URL
    if "url" in fields {
      link(fields.url)
      text(" ")
    }
    
    // Note (access date)
    if "note" in fields {
      text(fields.note)
    }
    
    linebreak()
    v(0.3em)
  }
}

#bibliography("references.bib", title: none, style: "ieee")

#pagebreak()

#include "chapters/abstract.typ"