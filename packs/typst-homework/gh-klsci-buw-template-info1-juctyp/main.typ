
#set page(
  paper: "a4",
  margin: (x: 1.8cm, y: 2.5cm),
  header: align(right)[ 
    Aufgaben Info 1 
  ], 
  numbering: "1",
)

#set text(
  font: "Roboto Mono",
  size: 10pt,
)

#set heading(
  numbering: "// 1."
)

#let nicegrid(body, rows, columns) = {
  let lines = body.split("\n")
  let cells = lines.map(line => line.split("\\"))
  
  let col-widths = range(columns).map(i => {
    calc.max(..cells.map(row => {
      // Handle rows that might not have enough columns
      if i < row.len() {
        row.at(i).trim().len()
      } else {
        0
      }
    }))
  })
  
  let hline = "/" + col-widths.map(w => "*" * (w+2)).join("*") + "/"
 
  let table-rows = cells.map(row => 
    "/* " + range(columns).map(i => {
      let content = if i < row.len() { row.at(i).trim()} else { "" }
      content + " " * (col-widths.at(i) - content.len())
    }).join("  ") + " */"
  )
  
  hline + "\n" + table-rows.join("\n") + "\n" + hline
}

*
#nicegrid(
"Uebungsblatt: xx, Aufgabe: xx 

Bearbeitet durch: \ Klaas Jacob Hettema
Gruppe: \ Do10
Leiter: \ Musterleiter 
Thema: \ Musterthema
Version: \ 1.0
Datum: \ tt.mm.jjjj
Status: \ lauffaehig",
1,
3
)
*

= Hello World






