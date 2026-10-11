#let section-spacing = 0.5in
#let big-entry-spacing = 0.25in
#let new-line-spacing = 0in

#let document-settings = state("document-settings", (
  language: ""
))

#let data-protection = {
  align(center)[
    Acconsento al trattamento dei dati personali presenti nel CV ai sensi dell’art. 13  del Regolamento UE 629/2016 (Regolamento Generale sulla Protezione dei Dati) e dell’art. 13 del Decreto Legislativo 196/2003 (Codice per la Protezione dei Dati Personali).
  ]
}

#let cv(
  language: "english",
  margin: 0.5in,
  name: "",
  description: "",
  location: "",
  side: [],
  body
) = {
  set page(margin: margin)
  set text(font: "Source Code Pro", size: 8pt)
  document-settings.update(x => (language: language))
  
  grid(
    rows: (auto, auto, auto, auto, 1fr),
    
    align(center)[
      #text(size: 24pt, weight: "bold")[#name]
      
      #text()[#description]
    ],
    
    v(0.25in),
    line(length: 100%, stroke: (paint: luma(200), dash: "dashed")),
    v(0.25in),
    
    grid(
      columns: (30%, auto, auto, auto),
      column-gutter: 0.25in,
      
      side,
      
      place(
        line(length: 100%, stroke: (paint: luma(200), dash: "dashed"), angle: 90deg)
      ),
      
      [
        #grid(
          rows: (1fr, auto),
          body,
          context{
            let lang = document-settings.get().language
            align(horizon)[
              #if (lang == "italian") {
                data-protection
                v(big-entry-spacing)
                text()[
                  #grid(
                    columns: (auto, auto),
                    column-gutter: 0.1in,
                    text()[
                      Luogo: #location
                      
                      Data: #datetime.today().display()
                      
                      Firma:
                    ],
                    align(bottom)[#line(length: 2in, stroke: 0.5pt + luma(200))]
                  )
                ]
              } else {
                text()[
                  #grid(
                    columns: (auto, auto),
                    column-gutter: 0.1in,
                    text()[
                      Location: #location
                      
                      Date: #datetime.today().display()
                      
                      Signature:
                    ],
                    align(bottom)[#line(length: 2in, stroke: 0.5pt + luma(200))]
                  )
                ]
              }
            ]
          }
        )
      ]
    )
  )
}

#let profile-picture(path) = {
  block(
    radius: 100%,
    clip: true,
    image(path)
  )
}

#let section(title, body) = {
  rect()[
    #text(size: 14pt, style: "italic")[#upper(title)]
  ]
  body
  v(section-spacing)
}

#let contacts-section(body) = {
  context {
    let lang = document-settings.get().language
    if (lang == "english") {
      section("contacts", body)
    } else if (lang == "italian") {
      section("contatti", body)
    }
  }
}

#let languages-section(body) = {
  context {
    let lang = document-settings.get().language
    if (lang == "english") {
      section("languages", body)
    } else if (lang == "italian") {
      section("lingue", body)
    }
  }
}

#let competencies-section(body) = {
  context {
    let lang = document-settings.get().language
    if (lang == "english") {
      section("competencies", body)
    } else if (lang == "italian") {
      section("competenze", body)
    }
  }
}

#let skills-section(body) = {
  context {
    let lang = document-settings.get().language
    if (lang == "english") {
      section("skills", body)
    } else if (lang == "italian") {
      section("skill", body)
    }
  }
}

#let hobbies-section(body) = {
  context {
    let lang = document-settings.get().language
    if (lang == "english") {
      section("hobbies", body)
    } else if (lang == "italian") {
      section("hobby", body)
    }
  }
}

#let contact-entry(platform, contact) = {
  grid(
    columns: (20%, 80%),
    column-gutter: 0.5em,
    align: horizon,
    if (platform == "email"){
      image("images/envelope.svg", width: 24pt)
    } else if (platform == "github") {
      image("images/github.svg", width: 24pt)
    }else if (platform == "linkedin") {
      image("images/linkedin.svg", width: 24pt)
    }else if (platform == "phone") {
      image("images/phone.svg")
    } else {
      platform
    },
    if (platform == "email"){
      set text(hyphenate: true)
      let breakable = contact.replace(".", ".\u{200B}")
                      .replace("@", "@\u{200B}")
                      .replace("-", "-\u{200B}")
                      .replace("_", "_\u{200B}")
      link("mailto:" + contact, breakable)
    } else if (platform == "github" or platform == "linkedin") {
      link(contact, contact)
    }else if (platform == "phone") {
      link("tel:"+contact, contact)
    } else {
      contact
    },
    
  )
  v(new-line-spacing)
}

#let language-entry(language, level) = {
  grid(
    columns: (1fr, auto),
    language,
    level
  )
  v(new-line-spacing)
}

#let work-entry(role, company, city, years) = {
  text(size: 14pt)[#role]
  grid(
    columns: (1fr, auto),
    align(top)[#text()[#company]],
    align(horizon)[
      #align(right)[#text()[#city]]
      #align(right)[#text()[#years]]
    ]
  )
  v(big-entry-spacing)
}

#let education-section(body) = {
  context {
    let lang = document-settings.get().language
    if (lang == "english") {
      section("education", body)
    } else if (lang == "italian") {
      section("educazione", body)
    }
  }
}

#let education-entry(course, title, institute, city, years) = {
  text(size: 14pt)[#course]
  v(new-line-spacing)
  text(size: 10pt)[#title]
  grid(
    columns: (1fr, auto),
    align(top)[#text()[#institute]],
    align(horizon)[
      #align(right)[#text()[#city]]
      #align(right)[#text()[#years]]
    ]
  )
  
  v(big-entry-spacing)
}
