/*
|              ██         
| ████▄ ▄███▄ ▀██▀▀ ▄█▀█▄ 
| ██ ██ ██ ██  ██   ██▄█▀ 
| ██ ██ ▀███▀  ██   ▀█▄▄▄ 
| 
| Ce fichier est basé sur du code précédemment écrit par @DACC4 et @samuelroland.
| Dépot original: https://github.com/DACC4/HEIG-VD-typst-template-for-TB
| 
*/

#import "macros.typ": *
#import "config.typ": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

/*                        
                  ▄▄      
       ██         ██      
▄█▀▀▀ ▀██▀▀ ██ ██ ██ ▄█▀█▄
▀███▄  ██   ██▄██ ██ ██▄█▀
▄▄▄█▀  ██    ▀██▀ ██ ▀█▄▄▄
              ██          
            ▀▀▀           
*/

#set heading(numbering: none)

  // Format level 1 headings
#show heading.where(
  level: 1
): it => [
  #pagebreak(weak: true, to: none)
  #v(2.5em)
  #it
  \
]

#show outline.entry.where(
  level: 1
): it => {
  if it.element.func() != heading {
    // Keep default style if not a heading.
    return it
  }
  
  v(20pt, weak: true)
  strong(it)
}

#let confidential_text = [
  #if config.global.confidential{
    [Confidentiel]
  }
]

// Set global page layout
#set page(
  paper: "a4",
  numbering: "1",
  header: context{
    if (not is-first-page(page)) and (not is-title-page(page)) {
      columns(2, [
        #align(left)[#smallcaps([#currentH()])]
        #colbreak()
        #align(right)[#config.information.author.name]
      ])
      hr()
    }
  },
  footer: context{
    if not is-first-page(page){
      hr()
      columns(2, [
        #align(left)[#smallcaps(confidential_text)]
        #colbreak()
        #align(right)[#counter(page).display()]
      ])
    }
  },
  margin: (
    top: 150pt,
    bottom: 150pt,
    x: 1in
  )
)

// LaTeX look and feel :)
#set text(font: "New Computer Modern")
#show heading: set block(above: 1.4em, below: 1em)
#show heading.where(level:1): set text(size: 25pt)
#set table.cell(breakable: false)
#show figure: set block(breakable: true)
#show link: underline

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)

#set text(lang: config.global.text_lang)


/*   
                             ▄▄                                    
                             ██          ██   ▀▀  ██               
████▄  ▀▀█▄ ▄████ ▄█▀█▄   ▄████ ▄█▀█▄   ▀██▀▀ ██ ▀██▀▀ ████▄ ▄█▀█▄ 
██ ██ ▄█▀██ ██ ██ ██▄█▀   ██ ██ ██▄█▀    ██   ██  ██   ██ ▀▀ ██▄█▀ 
████▀ ▀█▄██ ▀████ ▀█▄▄▄   ▀████ ▀█▄▄▄    ██   ██▄ ██   ██    ▀█▄▄▄ 
██             ██                                                  
▀▀           ▀▀▀                                                     
*/

#set par(leading: 0.55em, spacing: 0.55em, justify: true)
#image("images/HEIG-VD_logotype-baseline_rouge-cmjn.pdf", width: 6cm)
#v(10%)
#align(center, [#text(size: 14pt, [*Travail de Bachelor*])])
#v(4%)
#align(center, [#text(size: 24pt, [*#config.information.title*])])
#v(1%)
#align(center, [#text(size: 16pt, [#config.information.subtitle])])
#v(4%)
#if config.global.confidential{
  align(center, [#text(size: 14pt, [*Confidentiel*])])
}else{
  v(14pt)
}
#v(8%)

#align(left, [
  #block(
    width: 100%, [
    #table(
      stroke: none,
      columns: (35%, 65%),
      [*#if config.information.author.feminine_form { "Étudiante" } else { "Étudiant" }*], [*#config.information.author.name*],
      [],[],
      [*#if config.information.supervisor.feminine_form { "Superviseur" } else { "Superviseure" }*], [#config.information.supervisor.name],
      [],[],
      [*Département*], [#config.information.departement.long],
      [*Filière*], [#config.information.filiere.long],
      [*Orientation*], [#config.information.orientation.long],
      [],[],
      [*Entreprise mandante*], [
        #config.information.industry_contact.name \
        #config.information.industry_contact.industry_name \
        #config.information.industry_contact.address
      ],
      [],[],
      [*Année académique*], [#config.information.academic_years]
    )
  ])
])
#align(bottom + right, [
  Yverdon-les-Bains, le #datetime.today().display("[day].[month].[year]")
])
#pagebreak(weak: true)

/*
                  ▄▄                           ▄▄                                       
             ██   ██                 ██   ▀▀  ██  ▀▀               ██   ▀▀              
 ▀▀█▄ ██ ██ ▀██▀▀ ████▄ ▄█▀█▄ ████▄ ▀██▀▀ ██ ▀██▀ ██  ▄████  ▀▀█▄ ▀██▀▀ ██  ▄███▄ ████▄ 
▄█▀██ ██ ██  ██   ██ ██ ██▄█▀ ██ ██  ██   ██  ██  ██  ██    ▄█▀██  ██   ██  ██ ██ ██ ██ 
▀█▄██ ▀██▀█  ██   ██ ██ ▀█▄▄▄ ██ ██  ██   ██▄ ██  ██▄ ▀████ ▀█▄██  ██   ██▄ ▀███▀ ██ ██ 
*/

= Authentification

Par la présente, j’atteste avoir réalisé ce travail et n’avoir utilisé aucune autre source que celles expressément mentionnées.
#v(20%)

#table(
  stroke: none,
  columns: (60%, 40%),
  [], [#config.information.author.name]
)

#align(left + bottom, [
    Yverdon-les-Bains, le #datetime.today().display("[day].[month].[year]")
  ])
#pagebreak(weak: true)

/*    
               ▄                 ▄▄          ▄▄       
              ▀                  ██          ██       
████▄ ████▄ ▄█▀█▄ ███▄███▄  ▀▀█▄ ████▄ ██ ██ ██ ▄█▀█▄ 
██ ██ ██ ▀▀ ██▄█▀ ██ ██ ██ ▄█▀██ ██ ██ ██ ██ ██ ██▄█▀ 
████▀ ██    ▀█▄▄▄ ██ ██ ██ ▀█▄██ ████▀ ▀██▀█ ██ ▀█▄▄▄ 
██                                                    
▀▀                                                    
*/

= Préambule

Ce travail de Bachelor (ci-après TB) est réalisé en fin de cursus d'études, en vue de l'obtention du titre de Bachelor of Science HES-SO en Ingénierie.

#v(4%)

En tant que travail académique, son contenu, sans préjuger de sa valeur, n'engage ni la responsabilité de l'auteur, ni celles du jury du travail de Bachelor et de l'Ecole.

#v(4%)

Toute utilisation, même partielle, de ce TB doit être faite dans le respect du droit d'auteur.

#v(10%)

#table(
  stroke: none,
  columns: (60%, 40%),
  [], [HEIG-VD],
  [], [Le Chef de département #config.information.departement.court]
)

#align(bottom + left, [
  Yverdon-les-Bains, le #datetime.today().display("[day].[month].[year]")
])
#pagebreak(weak: true)

/*
         ▄                          ▄  
        ▀                          ▀   
████▄ ▄█▀█▄ ▄█▀▀▀ ██ ██ ███▄███▄ ▄█▀█▄ 
██ ▀▀ ██▄█▀ ▀███▄ ██ ██ ██ ██ ██ ██▄█▀ 
██    ▀█▄▄▄ ▄▄▄█▀ ▀██▀█ ██ ██ ██ ▀█▄▄▄                             
*/

= Resumé

#align(left)[*Travail de Bachelor #config.information.academic_years*]
#align(left)[*Titre:*  #config.information.title]
#align(left)[*Sous-titre:*  #config.information.subtitle]

#v(5%)

#config.information.resume_publiable

#v(5%)

#align(bottom + left, [
  #block(
    width: 100%, [
      #table(
        stroke: none,
        columns: (35%, 65%),
        [*#if config.information.author.feminine_form { "Étudiante" } else { "Étudiant" }*], [*#config.information.author.name*],
        [],[],
        [*#if config.information.supervisor.feminine_form { "Superviseur" } else { "Superviseure" }*], [#config.information.supervisor.name],
        [],[],
        [*Entreprise mandante*], [#config.information.industry_contact.name],
      )
    ]
  )
])
#pagebreak(weak: true)

/*                                                                                
            ▄▄                         ▄▄                     ▄▄                                  
            ██    ▀▀                   ██                     ██                                  
▄████  ▀▀█▄ ████▄ ██  ▄█▀█▄ ████▄   ▄████ ▄█▀█▄ ▄█▀▀▀   ▄████ ████▄  ▀▀█▄ ████▄ ▄████ ▄█▀█▄ ▄█▀▀▀ 
██    ▄█▀██ ██ ██ ██  ██▄█▀ ██ ▀▀   ██ ██ ██▄█▀ ▀███▄   ██    ██ ██ ▄█▀██ ██ ▀▀ ██ ██ ██▄█▀ ▀███▄ 
▀████ ▀█▄██ ██ ██ ██▄ ▀█▄▄▄ ██      ▀████ ▀█▄▄▄ ▄▄▄█▀   ▀████ ██ ██ ▀█▄██ ██    ▀████ ▀█▄▄▄ ▄▄▄█▀ 
                                                                                   ██             
                                                                                 ▀▀▀              
*/

#include "chapitres/cahier-des-charges.typ"


#outline(title: "Table des matières", depth: 2, indent: 15pt)

/*                                                 
                                   ▄▄                                                   
                                   ██                                              ██   
▄████ ▄███▄ ████▄ ████▄ ▄█▀▀▀   ▄████ ██ ██   ████▄  ▀▀█▄ ████▄ ████▄ ▄███▄ ████▄ ▀██▀▀ 
██    ██ ██ ██ ▀▀ ██ ██ ▀███▄   ██ ██ ██ ██   ██ ▀▀ ▄█▀██ ██ ██ ██ ██ ██ ██ ██ ▀▀  ██   
▀████ ▀███▀ ██    ████▀ ▄▄▄█▀   ▀████ ▀██▀█   ██    ▀█▄██ ████▀ ████▀ ▀███▀ ██     ██   
                  ██                                      ██    ██                      
                  ▀▀                                      ▀▀    ▀▀                      
*/


// Set numbering for content
#set heading(numbering: "1.1")

/*
| ------------------------------------
| INSEREZ VOS CHAPITRES CI-DESSOUS
| ------------------------------------
*/

#include "chapitres/introduction.typ"
#include "chapitres/planification.typ"
#include "chapitres/etat-de-lart.typ"
#include "chapitres/exemple-de-chapitre.typ"
#include "chapitres/architecture.typ"
#include "chapitres/implementation.typ"
#include "chapitres/resultats.typ"
#include "chapitres/conclusion.typ"

// ------------------------------------

// Remove numbering after content
#set heading(numbering: none)

/*   
▄▄        ▄▄    ▄▄                                   ▄▄              
██    ▀▀  ██    ██ ▀▀                                ██    ▀▀        
████▄ ██  ████▄ ██ ██  ▄███▄ ▄████ ████▄  ▀▀█▄ ████▄ ████▄ ██  ▄█▀█▄ 
██ ██ ██  ██ ██ ██ ██  ██ ██ ██ ██ ██ ▀▀ ▄█▀██ ██ ██ ██ ██ ██  ██▄█▀ 
████▀ ██▄ ████▀ ██ ██▄ ▀███▀ ▀████ ██    ▀█▄██ ████▀ ██ ██ ██▄ ▀█▄▄▄ 
                                ██             ██                    
                              ▀▀▀              ▀▀                    
*/

#if config.bibliography.content != none {
  bibliography(config.bibliography.content, style: config.bibliography.style)
}

/*           
           ▄▄    ▄▄            ▄▄                 ▄▄                                   
 ██        ██    ██            ██                ██  ▀▀                                
▀██▀▀ ▀▀█▄ ████▄ ██ ▄█▀█▄   ▄████ ▄█▀█▄ ▄█▀▀▀   ▀██▀ ██  ▄████ ██ ██ ████▄ ▄█▀█▄ ▄█▀▀▀ 
 ██  ▄█▀██ ██ ██ ██ ██▄█▀   ██ ██ ██▄█▀ ▀███▄    ██  ██  ██ ██ ██ ██ ██ ▀▀ ██▄█▀ ▀███▄ 
 ██  ▀█▄██ ████▀ ██ ▀█▄▄▄   ▀████ ▀█▄▄▄ ▄▄▄█▀    ██  ██▄ ▀████ ▀██▀█ ██    ▀█▄▄▄ ▄▄▄█▀ 
                                                            ██                         
                                                          ▀▀▀                          
*/

#context {
  let figures = query(figure.where(kind: image))
  if figures.len() != 0 {
    outline(title: "Table des figures", target: figure.where(kind: image))
  }
}

/*
▄▄                            ▄▄                          ▄▄    ▄▄                         
██ ▀▀         ██              ██                ██        ██    ██                         
██ ██  ▄█▀▀▀ ▀██▀▀ ▄█▀█▄   ▄████ ▄█▀█▄ ▄█▀▀▀   ▀██▀▀ ▀▀█▄ ████▄ ██ ▄█▀█▄  ▀▀█▄ ██ ██ ██ ██ 
██ ██  ▀███▄  ██   ██▄█▀   ██ ██ ██▄█▀ ▀███▄    ██  ▄█▀██ ██ ██ ██ ██▄█▀ ▄█▀██ ██ ██  ███  
██ ██▄ ▄▄▄█▀  ██   ▀█▄▄▄   ▀████ ▀█▄▄▄ ▄▄▄█▀    ██  ▀█▄██ ████▀ ██ ▀█▄▄▄ ▀█▄██ ▀██▀█ ██ ██ 
*/

#context {
  let tables = query(figure.where(kind: table))
  if tables.len() != 0 {
    outline(title: "Liste des tableaux", target: figure.where(kind: table))
  }
}

/*
 ▀▀█▄ ████▄ ████▄ ▄█▀█▄ ██ ██ ▄█▀█▄ ▄█▀▀▀ 
▄█▀██ ██ ██ ██ ██ ██▄█▀  ███  ██▄█▀ ▀███▄ 
▀█▄██ ██ ██ ██ ██ ▀█▄▄▄ ██ ██ ▀█▄▄▄ ▄▄▄█▀ 
*/

#fullpage([= Annexes])
#counter(heading).update(0)
#set heading(numbering: "I.i")

/*
| ------------------------------------
| INSEREZ VOS ANNEXES CI-DESSOUS
| ------------------------------------
*/

#include "chapitres/outils-utilises.typ"
#set page(flipped: true)
#include "chapitres/journal-de-travail.typ"

// ------------------------------------