// const color for let the resume look better
#let color_darknight = rgb("#131A28")

// const font
#let the_name_font = "Source Sans Pro"
#let the_font = "Source Serif Pro"
#let header_font = "Times New Roman"


#let SeparationLine() = {
  v(-10pt);
  line(length: 100%, stroke: 0.5pt + black);
  v(-1pt)
}

#let experienceBlock(
  title: "",
  titleLink: "",
  subtitle: "",
  startDate: "",
  endDate: "",
  address: "",
  content
) = {
  block(
    inset: (left: 0pt),
    if titleLink == "" {
      text(strong(title), style: "normal", font: "Times New Roman") 
    } else {
      text(strong(box[#link(titleLink)[#title]]), style: "normal", font: header_font) 
    }
    + h(1fr) 
    + text(startDate, style: "normal", font: header_font)
    + [ -- ]
    + text(endDate, style: "normal", font: header_font)
    + if subtitle != "" { 
      linebreak() + text(subtitle, style: "italic", font: header_font) + h(1fr) + text(address, style: "italic", font: header_font)
    } 
    + if content != "" { linebreak() + content }
  )
}

#let resumeContent(author: (), date: "", body) = {
  set document(
    author: author.firstname + " " + author.lastname, 
    title: "resume",
  )
  
  set text(
    font: the_font,
    lang: "en",
    size: 11pt,
    fill: color_darknight,
    fallback: false,

  )

  set page(
    paper: "a4",
    margin: (left: 8mm, right: 8mm, top: 8mm, bottom: 8mm)
  )

  // set paragraph spacing
  let linespacing = 0.72em
  set par(justify: true, leading: linespacing)
  
  // set link style
  show link: it => underline(offset: 2pt, it)
  
  // set list heading spacing
  set list(indent: 0pt)

  // set header style
  set heading(
    numbering: none,
    outlined: true,
  )

  show heading.where(
    level: 2
  ): it => text(
    size: 12pt,
    weight: "bold",
    block(
      text(upper(it), font: header_font) + SeparationLine(),
    )
  )


  // set your name style
  let name = {
    align(center)[
      #pad(bottom: 0pt)[
        #block[
          #set text(font:the_name_font,size: 24pt, style: "normal")
          #text(weight: "regular")[#author.firstname]
          #text(weight: "regular")[#author.lastname]
        ]
      ]
    ]
  }
  
  
  // set your contacts style
  let contacts = {
    set box(height: 11pt)
    
    let linkedin_icon = box(image("/icons/linkedin.svg"))
    let github_icon = box(image("/icons/square-github.svg"))
    let email_icon = box(image("/icons/square-envelope-solid.svg"))
    let phone_icon = box(image("/icons/square-phone-solid.svg"))
    let separator = box(width: 3pt)[|]
    
    align(center)[
      #block[
        #align(horizon)[
          #phone_icon
          #box[#link("tel:" + author.phone)[#author.phone]]
          #separator
          #email_icon
          #box[#link("mailto:" + author.email)[#author.email]]
          #separator
          #github_icon
          #box[#link("https://" + author.github)[#author.github]]
          #separator
          #linkedin_icon
          #box[
            #link("https://www." + author.linkedin)[#author.linkedin]
          ]
        ]
      ]
    ] 
  }
  
  name
  contacts
  body
}

#let today() = {
  let month = (
    "January", "February", "March", "April", "May", "June", "July",
    "August", "September", "October", "November", "December",
  ).at(datetime.today().month() - 1);
  let day = datetime.today().day();
  let year = datetime.today().year();
  [#month #day, #year]
}