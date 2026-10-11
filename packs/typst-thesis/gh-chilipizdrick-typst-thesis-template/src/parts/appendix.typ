#show heading.where(level: 2): set heading(outlined: false)
#show heading.where(level: 3): set heading(outlined: false)

= Приложение

== Приложение 1. Пример кода

#let code = read("../assets/code.py")
#raw(code, block: true, lang: "python")
