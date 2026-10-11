#import "Config.typ": configure-document
#import "Config.typ": configure

#let project(
  glob-config: configure-document,
  config: configure,
  title: "",
  title-en: "",
  author: "",
  school: "",
  supervisor: "",
  field: 1,
  place: "Místo",
  year: "202X",
  ai: "",
  abstract-cs: [],
  abstract-en: [],
  keywords-cs: (),
  keywords-en: (),
  acknowledgement: [],
  body,
) = {
  let soc-fields = (
    "1. Matematika a data science",
    "2. Fyzika",
    "3. Chemie",
    "4. Biologie, geografie a geologie",
    "5. Molekulární biologie",
    "6. Zdravotnictví",
    "7. Zemědělství, potravinářství, lesní a vodní hospodářství",
    "8. Ochrana a tvorba životního prostředí",
    "9. Strojírenství, hutnictví a doprava",
    "10. Elektrotechnika, elektronika a telekomunikace",
    "11. Stavebnictví, architektura a design interiérů",
    "12. Tvorba učebních pomůcek, didaktická technologie",
    "13. Ekonomika a řízení",
    "14. Pedagogika, psychologie, sociologie a problematika volného času",
    "15. Teorie kultury, umění a umělecké tvorby",
    "16. Historie",
    "17. Filozofie, politologie a ostatní humanitní a společenskovědní obory",
    "18. Informatika",
  )

  let field-display = if type(field) == int {
    if field >= 1 and field <= 18 {
      soc-fields.at(field - 1)
    } else {
      str(field)
    }
  } else {
    field
  }

  show: glob-config

  set document(author: author, title: title)

  // --- Title Page ---
  page(numbering: none)[
    #set align(center)
    #text(size: 18pt, weight: "extrabold")[STŘEDOŠKOLSKÁ ODBORNÁ ČINNOST]

    #text(size: 14pt)[Obor: #field-display]
    #v(1fr)
    
    #text(size: 18pt, weight: "extrabold")[#title] 
    #v(0.5em)
    #text(size: 18pt, weight: "extrabold")[#title-en]

    #v(2fr)
    
    #set align(left)
    #strong("Autor:") #author \
    #strong("Škola:") #school \
    #strong("Kraj:") #place \
    #strong("Konzultant:") #supervisor \
    #strong("Rok:") #year \
  ]

  // --- Declaration ---
  page(numbering: none)[
    #v(1fr)
    #heading(level: 1, numbering: none, outlined: false)[Prohlášení]

    Prohlašuji, že jsem svou práci SOČ vypracoval/a samostatně a použil/a jsem pouze prameny 
    a literaturu uvedené v seznamu bibliografických záznamů.

    Beru na vědomí, že nejpozději odevzdáním slovesné vědecké práce do veřejné soutěže 
    Středoškolská odborná činnost, stejně jako odevzdáním jejích příloh a dalších připojených
    děl, např. audiovizuálních, fotografických, výtvarných, architektonických apod. (dále 
    jen „soutěžní dílo“), dochází ke zveřejnění díla podle § 4 odst. 1 zákona č. 121/2000 
    Sb., autorského zákona, ve znění pozdějších předpisů (dále jen „autorský zákon“). Totéž
    platí pro pozdější odevzdání doplněného, změněného, upraveného nebo opraveného díla.

    Beru na vědomí, že zveřejněním díla, jehož součástí je vynález, se tento vynález stává 
    součástí stavu techniky podle § 5 odst. 1, 2 zákona č. 527/1990 Sb., o vynálezech, 
    průmyslových vzorech a zlepšovacích návrzích, ve znění pozdějších předpisů (dále jen 
    „patentový zákon“), což zakládá překážku pro udělení patentu podle § 3 odst. 1 
    patentového zákona.

    Beru na vědomí, že vyhlašovatel soutěže je podle § 61 odst. 1 autorského zákona per 
    analogiam oprávněn užít soutěžní dílo pro účely zajištění průběhu soutěže, zejména k 
    zajištění transparentnosti soutěže a veřejnosti obhajob soutěžních prací. V odůvodněném 
    rozsahu je tedy vyhlašovatel po dobu účasti autora v soutěži oprávněn zejména:

    - zhotovovat rozmnoženiny díla, je-li to nezbytné k seznámení účastníků soutěže, porotců 
      nebo veřejnosti se soutěžní prací;
    - zapůjčit originál nebo rozmnoženinu díla účastníkům soutěže, porotcům nebo veřejnosti.
      Přitom dbá na bezpečné nakládání s dílem;
    - vystavovat originál nebo rozmnoženinu díla v průběhu soutěžních přehlídek a 
      doprovodných akcí;
    - sdělovat dílo veřejnosti v nehmotné podobě, a to především počítačovou nebo obdobnou
      sítí.

    #ai

    #v(1cm)

    #grid(
      columns: (1fr, 1fr),
      [V #place dne: #box(width: 100pt, line(length: 100%))],
      [
        #align(right, [
          #box(width: 100pt, line(length: 150%)) \
          #author
        ])
      ]      
    )
  ]

  // --- Acknowledgement ---
  if acknowledgement != [] {
    page(numbering: none)[
      #v(1fr)
      #heading(level: 1, numbering: none, outlined: false)[Poděkování]
      #acknowledgement
    ]
  }

  // --- Abstract ---
  page(numbering: none)[
    #heading(level: 1, numbering: none, outlined: false)[Abstrakt]
    #abstract-cs
    
    #heading(level: 1, numbering: none, outlined: false)[Klíčová slova]
    #keywords-cs.join("; ")
    
    #heading(level: 1, numbering: none, outlined: false)[Abstract]
    #abstract-en
    
    #heading(level: 1, numbering: none, outlined: false)[Keywords]
    #keywords-en.join("; ")
  ]
  
  show: config

  body
}

#let no-ai() = {
  text("Dále prohlašuji, že při tvorbě této práce jsem nepoužil/a nástroje AI.")
}

#let use-ai(
  model: "",
  usage: "",
) = {
  text()[Dále prohlašuji, že při tvorbě této práce jsem použil/a nástroj generativního
	modelu AI #model za účelem #usage. Po použití tohoto nástroje jsem provedl/a 
	kontrolu obsahu a přebírám za něj plnou zodpovědnost.]
}