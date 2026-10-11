// UniPD Template - Versione professionale avanzata
// Creato per documenti accademici di alta qualità

#let unipd-colors = (
  primary: rgb(180, 27, 33),      // Rosso UniPD
  secondary: rgb(41, 39, 84),     // Blu scuro UniPD
  accent: rgb(248, 195, 15),      // Giallo/oro per accenti
  text: rgb(51, 51, 51),          // Testo principale
  text-light: rgb(90, 90, 90),    // Testo secondario
  light-bg: rgb(241, 241, 241),   // Sfondo chiaro per contenuti evidenziati
  link: rgb(24, 100, 171),        // Colore per i link
  light-accent: rgb(235, 235, 235), // Sfondo leggerissimo
  border: rgb(220, 220, 220)      // Colore bordi
)

// Funzione per generare numeri romani
#let to-roman(num) = {
  if num == 0 { return "0" }
  if num < 0 { return "-" + to-roman(-num) }
  
  let digits = ((1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), 
               (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), 
               (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I"))
  
  let result = ""
  for (val, sym) in digits {
    while num >= val {
      result += sym
      num -= val
    }
  }
  
  return result
}

// Funzione per creare elementi decorativi
#let decor-line(width: 100%, stroke: 1pt + unipd-colors.primary.lighten(50%)) = {
  box(width: width, {
    line(
      start: (0pt, 0pt),
      end: (width, 0pt),
      stroke: stroke
    )
  })
}

#let section-decor(content) = {
  grid(
    columns: (auto, 1fr),
    gutter: 0.5em,
    content,
    box(width: 100%, {
      place(
        bottom,
        decor-line(stroke: 1pt + unipd-colors.primary.lighten(50%))
      )
    })
  )
}

// Funzione per impostare il frontespizio
#let unipd-cover(title: none, subtitle: none, author: none, date: none, 
                logo-path: "images/unipd-logo.png", department: none, 
                supervisor: none, degree: none) = {
  
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, x: 2.5cm),
    numbering: none
  )
  
  // Commento temporaneamente lo sfondo wave per evitare errori quando l'immagine non è disponibile
  // Decommentare quando disponibile:
  // background: place(
  //   bottom + right,
  //   dx: -1cm, dy: -1cm,
  //   image("images/background_wave.svg", width: 12cm, height: 6cm)
  // )
  
  // Logo e intestazione
  align(center, {
    v(3em)
    if department != none {
      set text(size: 16pt, fill: unipd-colors.secondary, style: "italic")
      department
      v(4em)
    }
    
    box(width: 70%, {
      grid(
        columns: (1fr, auto, 1fr),
        line(length: 100%, stroke: 0.5pt + unipd-colors.primary),
        box(width: 40%, image(logo-path, width: 100%)),
        line(length: 100%, stroke: 0.5pt + unipd-colors.primary)
      )
    })
    
    v(5em)
    
    // Titolo
    box(
      width: 100%,
      inset: (y: 1em),
      {
        set text(size: 26pt, weight: "bold", fill: unipd-colors.primary)
        smallcaps(title)
      }
    )
    
    v(1em)
    
    // Sottotitolo
    if subtitle != none {
      box(
        width: 80%,
        inset: (y: 0.5em),
        {
          set text(size: 18pt, fill: unipd-colors.secondary)
          subtitle
        }
      )
    }
    
    v(6em)
    
    // Info aggiuntive
    box(width: 80%, {
      grid(
        columns: (1fr),
        rows: (auto, auto, auto, auto, auto),
        row-gutter: 1.5em,
        
        // Autore
        if author != none {
          align(center, {
            set text(size: 16pt)
            author
          })
        },
        
        // Department (if not shown at top)
        if degree != none {
          align(center, {
            set text(style: "italic", size: 14pt)
            degree
          })
        },
        
        // Supervisor
        if supervisor != none {
          align(center, {
            set text(size: 14pt)
            [Supervisor: #supervisor]
          })
        },
        
        // Date
        if date != none {
          align(center, {
            set text(size: 14pt)
            date
          })
        }
      )
    })
    
    v(1fr)
    
    // Footer decorativo
    box(width: 60%, {
      decor-line(stroke: 1pt + unipd-colors.primary.lighten(50%))
    })
  })
  
  pagebreak()
}

// Funzione per creare un abstract
#let unipd-abstract(content, keywords: none) = {
  set page(numbering: none)
  
  block(width: 100%, {
    grid(
      columns: (1fr),
      row-gutter: 0.5em,
      
      box({
        set align(center)
        set text(size: 16pt, weight: "bold", fill: unipd-colors.primary)
        smallcaps([Abstract])
        
        v(0.5em)
        
        decor-line(width: 40%, stroke: 1pt + unipd-colors.primary.lighten(50%))
      }),
      
      v(1em),
      
      box(
        width: 100%,
        inset: (x: 3em, y: 2em),
        fill: unipd-colors.light-bg.lighten(60%),
        radius: 4pt,
        stroke: (
          y: (paint: unipd-colors.primary.lighten(40%), dash: "dotted", thickness: 1pt),
          rest: none
        ),
        {
          set text(size: 11pt, fill: unipd-colors.text)
          set par(justify: true, leading: 0.65em)
          content
        }
      ),
      
      if keywords != none {
        v(1em)
        box(
          width: 100%,
          inset: (x: 3em, y: 0.5em),
          {
            set text(size: 10pt)
            set align(left)
            text(fill: unipd-colors.secondary, weight: "medium", [Keywords: ]) + keywords
          }
        )
      }
    )
  })
  
  pagebreak()
}

// Funzione per formattare i blocchi di codice
#let code-block(language: none, content) = {
  block(
    width: 100%,
    fill: unipd-colors.light-bg.lighten(60%),
    radius: 4pt,
    stroke: (
      top: 1.5pt + unipd-colors.primary.lighten(30%),
      rest: 0.5pt + unipd-colors.border
    ),
    inset: (x: 1em, y: 1em),
    {
      if language != none {
        block(
          width: 100% + 2em,
          fill: unipd-colors.primary.lighten(85%),
          inset: (x: 1em, y: 0.3em),
          stroke: none,
          radius: (top-left: 4pt, top-right: 4pt),
          move(
            dx: -1em,
            dy: -1em,
            {
              set text(size: 9pt, fill: unipd-colors.secondary, weight: "medium")
              language
            }
          )
        )
      }
      
      set text(font: "Fira Code", size: 9.5pt, fill: unipd-colors.text)
      content
    }
  )
}

// Funzione principale del template
#let unipd-doc(
  title: none, 
  subtitle: none, 
  author: none, 
  date: none, 
  degree: none,
  department: none,
  supervisor: none,
  abstract: none,
  keywords: none,
  table-of-contents: true,
  list-of-figures: true,
  list-of-tables: true,
  bibliography-file: none,
  show-cover: true,
  paper-size: "a4",
  lang: "en"
) = doc => {
  // Impostazioni globali
  set document(title: title, author: author)
  set text(font: "New Computer Modern", size: 11pt, lang: lang, fill: unipd-colors.text)
  set par(justify: true, leading: 0.65em)
  
  // Personalizzazione link
  show link: it => {
    text(fill: unipd-colors.link, weight: "medium", it)
  }
  
  // Personalizzazione codice
  show raw.where(block: true): it => {
    let language = none
    if it.lang != none {
      language = it.lang
    }
    code-block(language: language, it)
  }
  
  show raw.where(block: false): it => {
    box(
      fill: unipd-colors.light-bg.lighten(60%),
      inset: (x: 3pt, y: 0pt),
      radius: 2pt,
      text(
        font: "Fira Code", 
        size: 9.5pt,
        fill: unipd-colors.text,
        it
      )
    )
  }
  
  // Personalizzazione tabelle
  show table: it => {
    set align(center)
    
    block(
      inset: (y: 0.5em),
      width: 100%,
      {
        box(
          width: 100%,
          stroke: 0.5pt + unipd-colors.border,
          radius: 4pt,
          clip: true,
          {
            pad(
              x: 1pt,
              y: 1pt,
              it
            )
          }
        )
      }
    )
  }
  
  show table.cell.where(x: 0): it => {
    box(
      fill: unipd-colors.primary.lighten(90%),
      inset: 0.65em,
      stroke: 0.5pt + unipd-colors.border,
      text(weight: "medium", fill: unipd-colors.secondary, it.body)
    )
  }
  
  show table.cell.where(y: 0): it => {
    box(
      fill: unipd-colors.primary.lighten(90%),
      inset: 0.65em,
      stroke: 0.5pt + unipd-colors.border,
      text(weight: "medium", fill: unipd-colors.secondary, it.body)
    )
  }
  
  show table.cell.where(x: none, y: none): it => {
    box(
      inset: 0.65em,
      stroke: 0.5pt + unipd-colors.border,
      it.body
    )
  }
  
  set page(
    paper: paper-size,
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2.5cm),
    header: context {
      let current-page-number = counter(page).get().first()
      if current-page-number > 1 {
        grid(
          columns: (1fr, 1fr),
          {
            box(width: 100%, height: 100%, {
              place(bottom, {
                set text(size: 9pt, weight: "medium", fill: unipd-colors.text-light)
                smallcaps(title)
              })
            })
          },
          {
            box(width: 100%, height: 100%, {
              place(bottom + right, {
                set text(size: 9pt, fill: unipd-colors.text-light)
                counter(page).display("1", both: false)
              })
            })
          }
        )
        v(0.5em)
        box(width: 100%, height: 2pt, {
          place(
            bottom,
            line(
              stroke: (
                paint: unipd-colors.primary.lighten(60%),
                thickness: 1.5pt,
                dash: "solid",
              ),
              start: (0%, 0%),
              end: (100%, 0%)
            )
          )
        })
      }
    },
    footer: context {
      let current-page-number = counter(page).get().first()
      if current-page-number > 1 {
        grid(
          columns: (1fr),
          align(center)[
            #v(0.5em)
            #box(
              width: 30%,
              height: 0.75pt,
              fill: unipd-colors.primary.lighten(70%)
            )
            #v(0.5em)
            #text(
              font: "New Computer Modern",
              style: "italic",
              size: 9pt, 
              fill: unipd-colors.text-light,
              [Università degli Studi di Padova]
            )
          ]
        )
      }
    },
    numbering: "1",
    background: context {
      let current-page-number = counter(page).get().first()
      if current-page-number > 1 {
        place(
          top + right,
          dx: -0.5cm, dy: 0.5cm,
          rotate(
            45deg,
            box(
              width: 1.5cm,
              height: 1.5cm,
              fill: unipd-colors.primary.lighten(96%),
              stroke: 0.5pt + unipd-colors.primary.lighten(85%)
            )
          )
        )
      }
    }
  )
  
  // Impostazioni di riferimento e numerazione
  set heading(numbering: "1.1.1.")
  set figure(numbering: "1")
  
  // Stili per i titoli
  show heading.where(level: 1): it => {
    set text(fill: unipd-colors.primary, size: 18pt, weight: "bold")
    set block(spacing: 1.5em)
    
    section-decor(smallcaps(it.body))
    v(0.5em)
  }
  
  show heading.where(level: 2): it => {
    set text(fill: unipd-colors.secondary, size: 14pt, weight: "medium")
    set block(spacing: 1em)
    
    pad(left: 0.5em, {
      grid(
        columns: (auto, 1fr),
        gutter: 0.3em,
        it.body,
        box(
          width: 100%,
          place(center + horizon, {
            box(
              width: 90%,
              height: 0.75pt,
              fill: unipd-colors.secondary.lighten(70%)
            )
          })
        )
      )
    })
  }
  
  show heading.where(level: 3): it => {
    set text(size: 12pt, style: "italic", weight: "medium", fill: unipd-colors.secondary.darken(10%))
    
    pad(left: 1em, block(it.body))
  }
  
  // Personalizzazione lista
  set list(marker: ([•], [◦], [--]))
  
  // Personalizzazione figure
  show figure: it => {
    set align(center)
    pad(y: 0.5em, {
      let caption = it.caption
      
      block(
        width: 100%,
        {
          box(
            width: 100%,
            inset: (x: 0pt, y: 0.5em),
            it.body
          )
          
          if caption != none {
            v(0.3em)
            
            box(
              width: 80%,
              inset: (x: 1em, y: 0.8em),
              radius: 4pt,
              fill: unipd-colors.light-bg.lighten(60%),
              stroke: (left: 2pt + unipd-colors.primary.lighten(50%)),
              {
                set text(size: 10pt, weight: "medium")
                grid(
                  columns: (auto, 1fr),
                  gutter: 0.5em,
                  [Figura #it.counter.display():],
                  caption
                )
              }
            )
          }
        }
      )
    })
  }
  
  // Copertina
  if show-cover {
    unipd-cover(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,
      department: department,
      supervisor: supervisor,
      degree: degree,
      logo-path: "images/unipd-logo.png"
    )
  }
  
  // Abstract
  if abstract != none {
    unipd-abstract(abstract, keywords: keywords)
  }
  
  // Imposta lo stile della numerazione con numeri romani per le pagine iniziali
  if table-of-contents or list-of-figures or list-of-tables {
    set page(numbering: (..nums) => {
      to-roman(nums.first())
    })
    
    counter(page).update(1)
  }
  
  // Indice
  if table-of-contents {
    set block(spacing: 0.65em)
    
    show outline: it => {
      set text(weight: "regular")
      set par(leading: 0.45em)
      
      align(center, {
        set text(fill: unipd-colors.primary, weight: "bold", size: 18pt)
        smallcaps(if lang == "it" { "Indice" } else { "Table of Contents" })
        v(0.5em)
        decor-line(width: 40%, stroke: 0.75pt + unipd-colors.primary.lighten(50%))
      })
      
      v(1.5em)
      it
    }
    
    outline(
      title: none,
      indent: 2em,
    )
    
    pagebreak()
  }
  
  // Lista delle figure
  if list-of-figures {
    align(center, {
      heading(
        if lang == "it" { "Elenco delle figure" } else { "List of Figures" },
        numbering: none
      )
      v(0.5em)
      decor-line(width: 40%, stroke: 0.75pt + unipd-colors.primary.lighten(50%))
    })
    
    v(1.5em)
    outline(
      title: none,
      target: figure.where(kind: image),
      indent: 2em,
    )
    
    pagebreak()
  }
  
  // Lista delle tabelle
  if list-of-tables {
    align(center, {
      heading(
        if lang == "it" { "Elenco delle tabelle" } else { "List of Tables" },
        numbering: none
      )
      v(0.5em)
      decor-line(width: 40%, stroke: 0.75pt + unipd-colors.primary.lighten(50%))
    })
    
    v(1.5em)
    outline(
      title: none,
      target: figure.where(kind: table),
      indent: 2em,
    )
    
    pagebreak()
  }
  
  // Imposta la numerazione delle pagine in numeri arabi per il corpo del documento
  counter(page).update(1)
  set page(numbering: "1")
  
  // Corpo del documento
  doc
  
  // Bibliografia
  if bibliography-file != none {
    pagebreak()
    
    align(center, {
      heading(
        if lang == "it" { "Bibliografia" } else { "Bibliography" },
        numbering: none
      )
      v(0.5em)
      decor-line(width: 40%, stroke: 0.75pt + unipd-colors.primary.lighten(50%))
    })
    
    v(1.5em)
    
    show bibliography: it => {
      set text(weight: "regular", size: 10pt)
      set par(leading: 0.5em)
      it
    }
    
    bibliography(bibliography-file, title: none, style: "ieee")
  }
}