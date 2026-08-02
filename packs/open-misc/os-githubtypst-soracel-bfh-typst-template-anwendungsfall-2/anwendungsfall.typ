#let anwendungsfall(
  id: none,
  name: none,
  akteur: none,
  auslöser: none,
  abhängigkeit: none,
  beschreibung: none,
  vorbedingung: none,
  standarszenario: none,
  alternativszenarien: none,
  fehlerszenarien: none,
  nachbedingung: none,
) = {
  figure(
    table(
      columns: 2,
      align: (_, y) => if y > 0 {
        left + horizon
      } else {
        center + horizon
      },
      fill: (x, y) => if y == 0 or x == 0 {
        gray.lighten(50%)
      },
      table.header(table.cell(colspan: 2)[Anwendungsfall #id]),
      [Id], id,
      [Name], name,
      [Akteur], akteur,
      [Auslöser], auslöser,
      [Abhängigkeiten], abhängigkeit,
      [Beschreibung], beschreibung,
      [Vorbedingungen], vorbedingung,
      [Standardszenario], standarszenario,
      [Alternativszenarien], alternativszenarien,
      [Fehlerszenarien], fehlerszenarien,
      [Nachbedingungen], nachbedingung,
    ),
  )
}
