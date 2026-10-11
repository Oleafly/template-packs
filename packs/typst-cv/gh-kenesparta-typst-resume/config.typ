#let primary_color = rgb("#000090")
#let secondary_color = rgb("#0000EE")
#let accent_color = rgb("#0000CC")
#let skills_color = rgb("#1188FF")

#let at_text = text(font: ("Capriola", "Capriola"),  weight: 700, size: 0.95em)[\@]


#let format_date(date_str) = {
  if date_str == "" {
    return "Now"
  }

  let parts = date_str.split("-")
  if parts.len() != 2 {
    return date_str
  }

  let month_num = int(parts.at(0))
  let year = parts.at(1)

  let months = (
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  )

  let month_name = months.at(month_num - 1)
  return month_name + " " + year
}


#let section_title(title_name) = {
    v(0.3em)
    text(font: ("Capriola", "Capriola"), fill: secondary_color, weight: 900, size: 1.2em)[#h(-0.02em) #title_name]
    v(-0.9em)
    line(length: 100%, stroke: (paint: secondary_color.lighten(10%), dash: "dashed"))
}


#let new_contact(goto_link, show_text) = {
    text(font: ("Google Sans Code", "Google Sans Code"), weight: 600,size: .95em)[#link(goto_link)[#show_text]]
}
