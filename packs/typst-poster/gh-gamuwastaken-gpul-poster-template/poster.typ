
#set page(
  paper: "a4",
  flipped: true,
  fill: gradient.linear(
    rgb("#2bb2c5"), rgb("#2bc370"),
    dir: ttb
  ),
  margin: (top: 6em, x: 2em, bottom: 2em),
  header: text(fill: white, size: 3em, weight: "bold")[school.gpul.org]
)
#set align(center)
#set text(font: "FreeSans")

#show heading.where(level: 1): text.with(size: 3em)
#show heading.where(level: 2): text.with(size: 2em)
#show heading.where(level: 3): text.with(size: 1.7em)


#let data = json(bytes(sys.inputs.at("data", default: ```{
    "date" : "13/12/2023", 
    "start": "13:30",
    "end" : "14:30",
    "room" : "2.10",
    "name" : "Arquitectura ECS con Bevy como ejemplo",
    "desc" : "Una forma no oop friendly para crear aplicaciones complejas de forma clara, sencilla y extensible. Con Bevy game engine en Rust para un desarrollo anti boilerplate",
    "logo" : "logo_bevy.svg"
  }```.text
)))

#{
  // Parsing the date
  let (day, month, year) = data.date.split("/")
  data.date = datetime(
      day: int(day),
      month: int(month),
      year: int(year)
  ).display("[weekday] [day] [month repr:long]")
}

#let (date, start, end, room, name, desc, logo) = data

#block(
  fill: white,
  spacing: 1em,
  inset: 2em,
  radius: 7%,
)[
  #grid(
    // stroke: 1pt + red,
    rows: (2fr, 1fr, 2fr, 10%),
  
    // Content
    grid(columns: (15%, 1fr, 15%),
      image(logo),
      heading(level: 1)[#name],
      image("logo_gpul.svg")
    ),
    [ === #date de #start a #end \ Aula #room - Facultade de Informática ],
    [ == #desc ],
    [ === Siguenos en redes sociales: #strong("@gpul_") ]
  )
]
