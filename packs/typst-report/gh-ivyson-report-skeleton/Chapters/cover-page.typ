#set page(width: 21cm, height: 29.7cm, margin: 2.5cm)
#set text(font: "Times New Roman", size: 12pt, lang: "en")

#let cover-page(
  logo: "../Images/cput-logo.png",
  name: "MyName",
  surname: "Mysurname",
  student-number: "123456678",
  report-title: "GRADUATE ATTRIBUTE 8",
  university: "CAPE PENINSULA UNIVERSITY OF TECHNOLOGY",
  faculty: "ENGINEERING AND BUILT ENVIRONMENT",
  qualification: "BACHELOR OF ENG  TECH IN COMPUTER ENG",
  postal-address: "P.O BOX 1906, BELLVILLE, 7535",
  street-address: "SYMPHONY WAY, BELLVILLE, CAPE TOWN, 7535",
  subject-name: "ELECTRONIC COMMUNICATIONS 3",
  lecturer: "Him",
  due-date: datetime.today().display("[day] [month repr:long]  [year]")
) = {
  page(
    header: none,
    footer: none,
  )[

      #align(right+horizon)[
        #image(logo, width: 18cm, height: 5.0cm)
      ]

      #v(2cm)
      #line(length: 100%, stroke: blue)
      // #underline[#text(weight: "bold", size: 17pt)[LEARNER’S INFORMATION:]]
      #align(center)[#text(weight: "bold", )[
        #table(
        columns: (1fr, 2fr),
        rows: 1.2cm,
        //row-gutter: 0.1cm,
        //column-gutter: 0.1cm,
        inset: 10pt,
        // stroke: 0.5pt,
        align: left,
        // inset:
        
          [NAME], upper[#name],
          [SURNAME], upper[#surname],
          [STUDENT NUMBER], upper([#student-number]),
      )
    ]
    ]

      // #v(1cm)

      #text(weight: "light", size: 14pt)[REPORT: FREQUENCY MODULATION]
      #line(length: 100%, stroke: blue)
      #underline[#text(weight: "bold")[TITLE OF THE REPORT:]] #report-title

      #v(0.1cm)


      #text(weight: "bold")[SUBJECT INFORMATION:]
      #line(length: 100%, stroke: blue)
      #grid(
        columns: 2,
        column-gutter: 1cm,
        [
          #text(weight: "bold")[UNIVERSITY NAME:] #pad(left: 5cm, top: -0.8cm, right: 0cm)[#upper[#university]]
          #v(0.001cm)
          #text(weight: "bold")[FACULTY:] #pad(left: 5cm, top: -0.8cm, right: 0cm)[#upper()[#faculty]]
          #v(0.001cm)
          #text(weight: "bold")[QUALIFICATION:] #pad(left: 5cm, top: -0.8cm, right: 0cm)[#upper()[#qualification]]
          #v(0.001cm)
          #text(weight: "bold")[POSTAL ADDRESS:] #pad(left: 5cm, top: -0.8cm, right: 0cm)[#upper[#postal-address]]
          #v(0.001cm)
          #text(weight: "bold")[STREET ADDRESS:] #pad(left: 5cm, top: -0.8cm, right: 0cm)[#upper[#street-address]]
          #v(0.001cm)
          #text(weight: "bold")[SUBJECT NAME:] #pad(left: 5cm, top: -0.8cm, right: 0cm)[#upper[#subject-name]]
          #v(0.001cm)
          #text(weight: "bold")[NAME OF LECTURER:] #pad(left: 5cm, top: -0.8cm, right: 0cm)[#upper[#lecturer]]
          #v(0.001cm)
          #text(weight: "bold")[DUE DATE:] #pad(left: 5cm, top: -0.8cm, right: 0cm)[#upper[#due-date]]
          // #text(weight: "bold")[GROUP NUMBER:] #pad(left: 5cm, top: -0.8cm, right: 0cm)[#upper[4]]
        ]
      )
    ]
    }
