// ============================================
// IMPORTACIÓN DE ESTILOS Y VARIABLES
// ============================================
#import "config/styles.typ": apa_template
#import "config/variables.typ": tipo_portada
#show: doc => apa_template(doc)

// ============================================
// IMPORTACIÓN DE SECCIONES
// ============================================

// Portada
#if tipo_portada == "custom" {
  include "frontmatter/title page/custom.typ"
} else if tipo_portada == "apa_student" {
  include "frontmatter/title page/apa_student.typ"
} else if tipo_portada == "apa_professional" {
  include "frontmatter/title page/apa_professional.typ"
}

// Preliminares
#include "frontmatter/toc.typ"
#include "frontmatter/introduction.typ"

// Capítulos (cuerpo principal)
#include "chapters/chapter_1.typ"

// Cierre
#include "backmatter/conclusions.typ"
#include "backmatter/references.typ"
#include "backmatter/annexes.typ"
#include "backmatter/glossary.typ"
