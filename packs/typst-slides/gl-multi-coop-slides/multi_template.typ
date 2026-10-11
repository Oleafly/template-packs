#let multicolor = rgb("#4fc4af")
#let dark_multicolor = rgb("#082e3a")


#let title_page(doc_title, author: "", client_logo: "") = {
  block(height: 45%, align(bottom)[#text(40pt, weight: "bold",  multicolor, doc_title)])
  block(height: 10%, align(bottom)[#text(20pt, author)])
  
  let client = []
  if (client_logo != "") {
    client = image(client_logo, height: 50pt)
  } 

  let multi = image("assets/logo-MULTI.png", height: 50pt)

  block(height: 20%, 
    align(bottom)[#grid(
      columns: (1fr, 200pt),
      gutter: 30pt,
      align(right, client), 
      multi
    )]
  )
}


#let multi_mise_en_page(title, author: "", client_logo: "", doc)={
  set document(
    title: title,
  )

  set page(
    "presentation-16-9",
    header: {
      context {
        let num = counter(page).display().first() // thanks to @PgBiel
        if num == "1" {
          // nothing if is FirstPage
        } else {
          align(right, text(dark_multicolor, 17pt, title))
        }
      }
    },
    footer: {
      context {
        let num = counter(page).display().first() // thanks to @PgBiel
        if num == "1" {
          // nothing if is FirstPage
        } else {
          align(right, text(15pt, num))
        }
      }
    } 
  )

  set text(
    size: 18pt
  )

  set align(horizon)

  set quote(block: true)

  show heading.where(level: 1): it => {
      colbreak(weak:true)
      rect(
        stroke: (left : {6pt + multicolor}),
        inset: 15pt,
        [#text(45pt, weight: "bold", it)]
      )
  }

  show heading.where(level: 2): it => {
    colbreak(weak:true)
    [#highlight(fill: multicolor, extent: 6pt, text(white, 32pt, it)) \ ] // add newline after title
  }

  title_page(title, author: author, client_logo: client_logo)
  // contenu du document
  doc
}

#let double_column(columnA, columnB) = {
  grid(
    columns: (1fr, 1fr),
    gutter: 5pt,
    columnA,
    columnB,
  )
}