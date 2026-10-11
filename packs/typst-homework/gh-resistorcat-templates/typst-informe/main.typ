// ─────────────────────────────────────────────────────────────
// Plantilla para informes de tareas por Francisco Arenas
// Contacto:
//  🌐 https://ripio.dev/
//  ✉️ francis.arenasv@uc.cl
// Licencia: MIT (https://opensource.org/licenses/MIT)
// ─────────────────────────────────────────────────────────────

// Configuración del usuario
#let settings = (
    student_name: "Nombre Apellido",
    student_id: "20000000",
    institution: "Pontificia Universidad Católica de Chile",
    school: "Escuela de Ingeniería",
    department: "Departamento de Ciencias de la Computación",
    course: "IIC3675 - Aprendizaje Reforzado",
    title: "Tarea 1 - Título",
    sections: ("desarrollo",) // Mantener coma al final para evitar errores
)

// ─────────────────────────────────────────────────────────────
// Configuración del formato
// ────────────────────────────────────────────────────────────

// Función para obtener la fecha en formato (DD de mes de YYYY)
#let get_current_date() = {
    let today = datetime.today()
    let months = (
        "enero", "febrero", "marzo", "abril", "mayo", "junio",
        "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"
    )
    return str(today.day()) + " de " + months.at(today.month()-1) + " de " + str(today.year())
}

// Configuración de la página (tamaño, margenes, numeración)
#set page(
    paper: "us-letter",
    margin: (left: 1.8cm, top: 3.5cm),
    numbering: "1 / 1"
)

// Configuración de la fuente y el espaciado
#set text(font: "New Computer Modern", size: 12pt, lang: "es")
#set par(spacing: 1em)

// Configuración de encabezados
#set page(
    header: context {  
        if here().page() == 1 {
            // Encabezado de la primera página  
            [
                #grid(
                    columns: 2,
                    rows: 1,
                    gutter: 0.6cm,
                    grid.cell([
                        #image("fig/header-logo.svg", width: 4cm)
                    ],
                    inset: (y: -0.5cm)),
                    grid.cell([
                        #set text(font: "New Computer Modern", size: 11pt)
                        #text(settings.institution) \
                        #text(settings.school) \
                        #text(settings.department) \
                        #text(settings.course) \
                        ],
                        inset: (y: -0.4cm)
                    )
                )
            ]
        } else { 
            // Encabezado de las páginas siguientes 
            [
                #grid(
                    columns: (50%, 50%),
                    rows: 1,
                    //gutter: auto,
                    grid.cell([
                        #set text(font: "New Computer Modern", size: 11pt)
                        #text(settings.title)
                        ],
                        inset: (y: -1cm),
                        align: left
                    ),
                    grid.cell([
                        #set text(font: "New Computer Modern", size: 11pt)
                        #text(settings.course)
                        ],
                        inset: (y: -1cm),
                        align: right
                    )
                ) \
                #line(length: 100%, stroke: 0.6pt)
            ]
        }
    }
)

// Portada (Título, fecha y datos del autor)
#align(center, [
    #text([*#settings.title*], size: 17pt) \
    #text([#get_current_date()]) \
    #text([#settings.student_name - N° #settings.student_id]) \
    #line(length: 100%, stroke: 0.6pt)
])

// Inserción de contenidos en documento principal
#for sec in settings.sections {
    include "section/" + sec + ".typ"
}

