#import "../sizes.typ": *
#import "../util.typ": custom_outline_size
#import "../translation.typ": get-i8n


#{
  show heading: none

  custom_outline_size.update(small_size)
  heading(get-i8n("acknowledgements"))
  custom_outline_size.update(none)
}
#heading(outlined: false, bookmarked: false)[]


#set align(right)
#set par(justify: false)
#set text(style: "italic")


Aquí puedes colocar una dedicatoria\
o unos agradecimientos\
puedes usar varias líneas o varios párrafos

Si no quieres puedes comentar el include el fichero principal.

