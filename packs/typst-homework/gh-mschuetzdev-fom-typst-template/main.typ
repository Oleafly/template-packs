#let current-title = state("current-title", none)

#show heading.where(level: 1): it => {
  current-title.update(it.body)
  it
}

/* set constant page settings for document */
#set page(
  margin: (top: 4cm, bottom: 2cm, left: 4cm, right: 2cm),
  header: [
    #set text(8pt)
    #context {
      let pageTitle = query(selector(heading).before(here()))
      
      [#pageTitle]
    }
    
  ],
)

#set heading(numbering: "1.");

= Hallo Welt!

= Hallo 

= Test 

