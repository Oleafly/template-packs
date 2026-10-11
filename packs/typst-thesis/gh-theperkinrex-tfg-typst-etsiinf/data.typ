
#import "@preview/datify-core:1.0.0": get-month-name

#let lang = "es"
#let estudios = "[ESTUDIOS, ej. Grado]"
#let titulo_estudios = "[TÍTULO DE LOS ESTUDIOS, ej. Ingeniería Informática]" // En inglés: Bachelor's / Master's
#let departamento = "[DEPARTAMENTO, ej. Departamento de Lenguajes y Sistemas Informáticos e Ingeniería de Software]"
#let nombre_autor = "[NOMBRE Y APELLIDOS]"
#let nombre_tutor = "[NOMBRE Y APELLIDOS]"
#let titulo_trabajo = "[Título del Trabajo, con Mayúscula en Todas las Palabras que no Sean Conectivas (Artículos, Preposiciones, Conjunciones)]"

// Escribe la fecha de lectura, en formato: mes año (ej. Enero 2021)
// El día no importa, no se mostrará
#let fecha = datetime(day: 10, month: 1, year: 2021) // TODO revisar
#let display_fecha = context { get-month-name(fecha.month(), lang: lang).replace(regex("^\w"), m=>{
	// repr(m)
	upper(m.text)
	}, count: 1) + " " + str(fecha.year())}
