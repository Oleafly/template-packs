#import "lib.typ": plantilla

#show: plantilla.with(
  universidad:  "UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO",
  facultad:     "Facultad de Estudios Superiores Acatlán",
  licenciatura: "Matemáticas Aplicadas y Computación",

  // Solo se pasa uno → el separador no aparece
  escudo-universidad: image("escudos/escudo-unam.svg", height: 2cm),
  escudo-facultad:    image("escudos/escudo-fesa-negro.jpg", height: 2cm),

  etiqueta:     "Etiqueta",
  titulo:       "Título impresionante",
  asignatura:   "Asignatura",
  alumno:       "sav1209",
  num-cuenta:   "XXXXXXXXX",
  profesor:     "Juan Peréz",
  grupo:        "XXXX",
  semestre:     "XXXX-X",
)

= #lorem(5)
#lorem(100)

- #lorem(20)
- #lorem(20)
- #lorem(20)

== #lorem(3)

Enlace: https://www.acatlan.unam.mx/

+ #lorem(20)
+ #lorem(20)
+ #lorem(20)