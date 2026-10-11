#let Huge(body) = {
  text(size: 24.88pt, [#body])
}
#let large(body) = {
   text(size: 14.40pt, [#body])
}
#let Large(body) = {
  text(size: 17.28pt, [#body])
}
#let LARGE(body) = {
  text(size: 20.74pt, [#body])
}

#let doublepagebreak() = {
    pagebreak(to: "odd", weak: true)
}

#let noindent(body) = {
  par(first-line-indent: 0pt)[#body] 
}

#let title_page(
  type: "magisterska",
  name: "Jan Kowalski", 
  index: 123456, 
  degree: "Socjologia", 
  form: "stacjonarne", 
  level: "II", 
  supervisor: "dr inż. Karol Nowak",
  title_pl:"Tytuł pracy",
  title_en: "Tytuł po angielsku"
) = {
image("header_top.png")
align(center, block[
  #v(48pt)
  #LARGE[#upper[praca dyplomowa #type]]
  #v(32pt)
  #Large[*#title_pl*]
  #v(16pt)
  #Large[
    #text(lang: "en", [_ #title_en _])]
  #v(96pt)
    #align(right, box(
      align(left)[
        \ #large[#name] \
        Nr albumu: #index \
        Kierunek: #degree \
        Forma studiów: #type \
        Poziom studiów: #level \
        
        #v(1em)
        #noindent[
          #large[Promotor pracy:] \
          #supervisor
        ]
    ])
  )
  #v(1fr)
  #align(left, [
    #noindent[Praca przyjęta dnia:]
    #v(12pt)
    #noindent[Podpis promotora:]
  ])
  _Częstochowa #datetime.today().year()_
])
doublepagebreak()
}
#let pagesetup(body) = {
  show link: set text(fill: rgb("#000"))
  show link: underline
  // ustawienie numerowania figur (zdjęć, tabeli, listingów)
  set figure(numbering: n => {
    let h = counter(heading).get()
    if h.len() > 0 and h.at(0) > 0 {
      numbering("1.1", h.at(0), n)
    } else {
      numbering("1", n)
    }
  })
  // ustawienie numerowania działań matematycznych
  set math.equation(numbering: n => {
    let h = counter(heading).get()
    if h.len() > 0 {
      numbering("(1.1)", h.at(0), n)
    } else {
      numbering("(1)", n)
    }
  })
  // Ustawienia paragrafu
  set par(
    justify: true,
    spacing: 12pt * 1.0,
    leading: 12pt * 0.8,
    first-line-indent: (amount:2.5em, all:true)
  )
  // Ustawienia stron
  set page(
    paper: "a4",
    margin: (
      inside: 3.5cm,
      outside: 2.0cm,
      top: 2.0cm,
      bottom: 2.0cm
    )
  )
  // ustawienie listy nienumerowanej
  set list(
    body-indent: 1.5em,
    spacing: 1.5em,
  )
  show list: set block(below: 1.5em)
  
  // Ustawienie nagłówków (=)
  show heading: it => {
    
    if it.level == 1 {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: "code")).update(0)
      set block(below: 24.88pt * 1.5)
      set text(size:24.88pt)
      doublepagebreak()
      v(24.88pt * 6, weak: false)
      if it.numbering != none {
        noindent[#strong("Rozdział " + counter(heading).display())]
      }
      
      block(it.body)
    }
    if it.level == 2 {
      set block(below: 17.28pt * 1.5)
      set text(size: 17.28pt)
      
      block(it)
    }
    if it.level == 3 {
      set block(below: 14.40pt * 1.5)
      set text(size: 14.40pt)
      block(it.body)
    }
  }
  show figure: set block(below: 2em)
  // Ustawienia typu figure, proszę nie zmieniać.
  show figure.where(kind: "code"): set figure(supplement: [Kod])

  show figure.where(kind: image): set figure(supplement: [Rys.])

  show figure.where(kind: table): set figure(supplement: [Tabela])
  show figure.where(kind: table): set figure.caption(position: top)
  body
}
#let startnumbering(body) = {
  set page(
    footer: context {
      let page_num = counter(page).display()
      if calc.even(here().page()) {
        align(left, page_num)
      } else {
        align(right, page_num)
      }
    }
)
  counter(page).update(1)
  body
}
