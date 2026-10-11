#import "@preview/grayness:0.2.0": *
#import "../config/thesis-config.typ": *
#import "../config/variables.typ": *



#let logo = "../images/unipd-logo.svg"
#let logo2 = "../images/unipd-logo.png"
// Impostazioni generali della pagina e del font
#set page(
  margin: (top: 2.5cm, bottom: 2cm, left: 2.5cm, right: 2.5cm),
)

#let transparent-image(imagebytes, alpha: 50%, ..args) = {
  let ratio = bytes(str(int(float(alpha) * 255)))
  image(plg.transparency(imagebytes, ratio), ..args)
}



// --- INIZIO COPERTINA ---

// 2. Contenuto principale della copertina (tutto centrato)
#align(center)[

  #set par(spacing: 0.85em)
  // Logo dell'università in alto
  #image(logo, width: 15%)
  #text(size: 2.5em, weight: "semibold")[#smallcaps[#myUni]]
  #v(0.2cm)
  // Linea orizzontale
  #line(length: 100%, stroke: 0.5pt)
  #text(1.5em, weight: "medium")[ #smallcaps[#myDepartment]]
  #v(0.2cm)
  #text(1.5em, weight: "medium")[#smallcaps[#emph[#myDegree]]]
  
  #let data = read(logo2, encoding:none)
  #place(center)[
  #transparent-image(data,alpha:8%, width: 80%)
  ]
  
  #v(2cm)
  // Titolo in rosso e grande
  #align(center)[
  // Disabilita la giustificazione SOLO per questo blocco
    #set par(justify: false, leading: 0.85em) 
    #text(2.25em, weight: "semibold", hyphenate: false, fill: rgb("#B5001B"))[#smallcaps[#myTitle]] 

    #text(2.1em, weight: "semibold", hyphenate: false,fill: rgb("#B5001B"))[#smallcaps[#myTitle2]] 
  ]

  
    // Immagine decorativa sullo sfondo (opzionale)
 
  #v(2cm) // Spazio prima dei nomi

  // 3. Griglia per i nomi (Supervisor a sinistra, Candidato a destra)
  // Usiamo una griglia a 2 colonne per allineare i blocchi.
#grid(
    columns: (1fr, 1fr), // Due colonne di uguale larghezza
    column-gutter: 2cm,  // Spazio tra le colonne
    align(left)[
      #set par(first-line-indent: 0pt)// Colonna Sinistra
      #smallcaps[_Supervisor_] \
      #smallcaps()[#profTitle #myProf] \
      #smallcaps[University of Padova] 
      #v(0.5cm)
      #smallcaps[_Co-Supervisor_] \
      #smallcaps()[#supervisor] \
      #smallcaps[#myCompany] \

    ],
    align(right)[ // Colonna Destra
      #smallcaps[_Master Candidate_] \
      #smallcaps[#myName] \
      #v(0.9cm)
      #smallcaps[_Student ID_] \
      #myID
    ]
  )
  #v(2cm)
  // Piè di pagina
  #smallcaps[_Academic Year_] \
  #text()[#myAA]
]

// --- FINE COPERTINA ---

// Forza un salto pagina per iniziare il testo vero e proprio
#pagebreak()

// --- Inizio del documento ---