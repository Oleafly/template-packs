#let TB_template(
  content,
  config: (
    global: (
      confidential: false,
      research_report: false,
      text_lang: "fr",
    ),
    information: (
      title: "",
      subtitle: "",
      academic_years: "",
      dpt: "",
      filiere: (
        short: "",
        long: "",
      ),
      orientation: "",
      author: (
        name: "",
        feminine_form: false,
      ),
      supervisor: (
        name: "",
        feminine_form: false,
      ),
      industry_contact: (
        name: "",
        address: "",
        industry_name: "",
      ),
      resume_publiable: none,
    ),
    sections: (
      thanks: none,
      cdc: none,
      annexes: none,
    ),
    bibliography: (
      content: none,
      style: "iso-690-author-date",
    ),
    codly: (
      enabled: true
    ),
    glossary: (
      enabled: true,
      entries: none,
    )
  ),
) = {
  set text(lang: config.global.text_lang)

  /*
  Includes
  */
  import "imports.typ": *
  import "style.typ": TB_style
  show: TB_style.with(config)

  /*
  Glossarium
  */
  if config.glossary.entries != none {
    register-glossary(config.glossary.entries)
  }

  /*
  Title and   */
  import "_title.typ": *
  _title(config)
  if not config.global.research_report {
    import "_second_title.typ": *
    _second_title(config)
    include "_preambule.typ"
    import "_authentification.typ": *
    _authentification(config)

    /*
    Remerciements
    */
    if config.sections.thanks != none {
      config.sections.thanks
    }

    /*
    Cahier des charges
    */
    if config.sections.cdc != none {
      config.sections.cdc
    }
  }

  // Set numbering for content
  set heading(numbering: "1.1")

  /*
  Table of Content
  */
  outline(title: "Table des matières", depth: 3, indent: 15pt)

  /*
  Content
  */
  content

  // Remove numbering after content
  set heading(numbering: none)

  /*
  Annexes
  */
  if config.sections.annexes != none {
    config.sections.annexes
  }

  /*
  Tables
  */
  import "_bibliography.typ": *
  if config.bibliography.content != none {
    _bibliography(config)
  }
  if not config.global.research_report {
    include "_figures.typ"
    include "_tables.typ"
  }

  /*
  Glossary
  */
  import "_glossary.typ": *
  if config.glossary.enabled and config.glossary.entries != none {
    _glossary(config)
  }
}

#let TB_affiche(
  content, 
  config: (
    global: (
      type: "affiche",
      text_lang: "fr",
    ),
    information: (
      title: "",
      subtitle: "",
      academic_years: "",
      dpt: "",
      filiere: (
        short: "",
        long: "",
      ),
      orientation: "",
      author: (
        name: "",
        feminine_form: false,
      ),
      supervisor: (
        name: "",
      ),
      industry_contact: (
        name: "",
        feminine_form: false,
        industry_name: "",
      ),
    ),
  )
) = {
  // Style
  set heading(numbering: none)
  set text(font: "Arial", size: 14pt, lang: config.global.text_lang)

  show heading.where(
    level: 1
  ): it => [
    #v(0.4em)
    #it
    #v(0.4em)
  ]

  // Set global page layout
  set page(
    paper: "a3",
    numbering: none,
    margin: (
      top: 35pt,
      bottom: 25pt,
      x: 35pt
    )
  )
  set par(leading: 0.55em, spacing: 0.55em, justify: true)

  // Header
  grid(
    columns: (50%, 50%), 
    align: (left, right),
    image("images/logo_heig-vd-2020.svg", width: 30%),
    text(size: 24pt, [
      *Travail de Bachelor #datetime.today().display("[year]")* \
      *Filière #config.information.filiere.short* \
      *Orientation #config.information.orientation* \
    ])
  )
  
  v(7%)

  // Title
  align(center, par(justify: false, text(size: 54pt)[*#config.information.title*]))

  v(4%)

  set par(spacing: 2em)
  block(
    height: 55%, 
    columns(
      2, 
      content
    )
  )
  set par(spacing: 0.55em)

  // Teacher, industry and HES-SO logo
  align(bottom, grid(
    columns: (50%, 50%), 
    align: (left + top, bottom + right),
    text(size: 12pt)[
      #if config.information.author.feminine_form { "Autrice" } else { "Auteur" }: #config.information.author.name \
      #if config.information.industry_contact.feminine_form { "Répondante" } else { "Répondant" } externe: #config.information.industry_contact.name \
      Prof. responsable: #config.information.supervisor.name \
      Sujet proposé par: #config.information.industry_contact.industry_name \
    ],
    image("images/logo_hes-so.png", width: 25%)
  ))

  v(2%)

  // Footer
  align(bottom + right, text(size: 12pt)[
    *HEIG-VD #sym.copyright #datetime.today().display("[year]") filière #config.information.filiere.long*
  ])
}