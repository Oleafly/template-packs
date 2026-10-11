#import "config.typ": *

#let nak_color = rgb(0, 32, 96)
#let font_size = 12pt

#let title_text
#let matriculation_number_text
#let topic_text
#let bachelor_centuria_text
#if {language == "en"} {
  title_text = [Transfer Paper Theory/Pratice#linebreak()Nr. #tl_number]
  matriculation_number_text = "Matriculation number:"
  topic_text = "Accepted topic:"
  bachelor_centuria_text = "Bachelor's programme, centuria:"
} else {
  title_text = [Transferleistung Theorie/Praxis#linebreak()Nr. #tl_number]
  matriculation_number_text = "Martrikelnummer:"
  topic_text = "Freigegebenes Thema:"
  bachelor_centuria_text = "Studiengang, Zenturie:"
}
