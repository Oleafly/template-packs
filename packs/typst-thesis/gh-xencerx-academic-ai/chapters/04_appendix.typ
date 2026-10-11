#import "../settings/gost_appendix.typ": gost-appendix-list, gost-appendix
#import "../settings/gost_tables.typ": gost-table
#import "../settings/gost_listings.typ": gost-listing

// Вывод перечня приложений (на отдельном листе)
#gost-appendix-list(
  ("А", "Техническое задание"),
  ("Б", "Листинги кода")
)

// Приложение А
#gost-appendix("А", "Техническое задание")[
  Текст технического задания и пример таблицы.

  #gost-table(
    columns: (1fr, 1fr),
    caption: [Требования],
    header: ([Параметр], [Значение]),
    [Шрифт], [Times New Roman],
    [Размер], [14pt]
  ) <tab-app>

  Как видно из #ref(<tab-app>, supplement: "Таблицы"), требования строгие.
]

// Приложение Б (Альбомная ориентация)
#set page(flipped: true)
#gost-appendix("Б", "Листинги кода")[
  Код программы представлен в #ref(<list-app-b>, supplement: "Листинге").

  #gost-listing(
    code: "print('Hello, Appendix B!')",
    caption: [Скрипт приветствия],
    lang: "python",
    numbers: true
  ) <list-app-b>
]
#set page(flipped: false)
