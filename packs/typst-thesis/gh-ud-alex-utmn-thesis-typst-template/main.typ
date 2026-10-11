
#import "/assets/template.typ": project
#show: project.with(yaml("/project_data.yml"))


#include "chapters/title_page.typ"

#outline(title: "Содержание", indent: 1.5em)


#include "chapters/intro.typ"

#include "chapters/first_chapter.typ"

#include "chapters/second_chapter.typ"

#include "chapters/conclusion.typ"

#include "chapters/bibliography.typ"

#include "chapters/appendices.typ"

// Файл, включенный ниже, нужен только для визуальной проверки
// «плотности текста» — того, сколько строк помещаются на одну страницу
// Нужен только для демонстрационных целей, перед финально компиляцией —
// — обязательно удалить или закомментировать

// #include "chapters/number_of_lines_test.typ"
