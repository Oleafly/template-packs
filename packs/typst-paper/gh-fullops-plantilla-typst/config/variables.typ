// ============================================
// DEFINICIÓN DE VARIABLES
// ============================================


// ============================================
// CONFIGURACIÓN GENERAL
// ============================================
#let tipografia = "Times New Roman"
#let fuente_parrafo = 12pt


// ============================================
// SELECCIÓN DE PORTADA
// ============================================

// Opciones:
// "apa_student"
// "apa_professional"
// "custom"
#let tipo_portada = "apa_student"


// ============================================
// INFORMACIÓN COMPARTIDA
// ============================================
#let titulo_linea1 = "Titulo de"
#let titulo_linea2 = "Prueba"

#let titulo = titulo_linea1 + " " + titulo_linea2

// Lista de autores
#let autores = (
  "Primer Autor",
  // "Segundo Autor",
  // "Tercer Autor",
)

#let institucion = "Nombre Institución"
#let facultad = "Facultad"
#let carrera = "Carrera"
#let ubicacion = "Ciudad, Departamento"


// ============================================
// PORTADA APA - ESTUDIANTE
// ============================================
#let nombre_curso = "Nombre del curso"
#let nombre_instructor = "Nombre profesor"
#let fecha_entrega = "Mes de Año"


// ============================================
// PORTADA APA - PROFESIONAL
// ============================================
#let nota_autor = [
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam egestas lorem eu quam pellentesque, non dignissim orci congue. Nam vitae dui ligula. Nam elementum magna maximus erat lobortis, a volutpat odio fermentum.
]


// ============================================
// PORTADA PERSONALIZADA
// ============================================
#let logo = "../../assets/logos/logo.png"
#let logo_width = 2cm

#let info = "Información relevante"
#let info2 = "Información relevante 2"

#let fecha_mes = "Mes"
#let fecha_anio = "Año"
#let version = "1.0.0"


// ============================================
// HEADER
// ============================================
#let titulo_corto = "TITULO DE PRUEBA CORTO"
