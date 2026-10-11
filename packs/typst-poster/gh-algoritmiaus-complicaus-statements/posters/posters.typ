#import "template.typ": generate-page
#set page(
  paper: "a4",
  margin: 0cm,
)

// Aquí puedes cambiar el delimitador del csv
#let data = csv(
  "../assets/equipos.csv",
  row-type: dictionary,
)

#for (index, row) in data.enumerate() {
  // Usa el nombre de estas columnas en tu csv
  let team_name = row.at("nombre_equipo").trim()
  let university = row.at("centro_estudios").trim()
  let online = row.at("online").trim()
  // Nota: Esto hace que cuando participen los de online, no se creen
  // los posters, si quieres crearlo, comenta el siguiente if
  if online == "Sí" {
    continue
  }
  generate-page(team_name, university)
  if index < data.len() - 1 {
    pagebreak()
  }
}
