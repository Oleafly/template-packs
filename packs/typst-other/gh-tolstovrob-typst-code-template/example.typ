#import "conf.typ": conf

#show: conf.with(
  meta: (
    title: "Пример использования шаблона",
    author: "Толстов Роберт Сергеевич",
    group: 251,
    city: "Саратов",
    year: 2024,
  )
)

= Типографика
Всё как в обычном Typst. Используется шрифт Cambria Math

= Работа с кодом
А вот это уже интереснее. Есть inline-код, например: #raw(lang: "python", "print(\"Hello, World\")") на языке Python.

Для блоков кода предусмотрены номера строк:
#raw(
  block: true,
  lang: "rust",
  "fn main() {
    println!(\"Hello, Rust!\");
}")

#quote(block: true,
       attribution: "Роберт",
       [Не забываем экранировать символы #raw("\"") --- а то забудете])

== Лигатуры
Да, я их выключил. Теперь будет так: #raw("=>").

= Ссылка
Да, ссылка теперь такая: #link("https://ru.w3docs.com/uchebnik-html/tablitsa-html-tegov.html")[w3docs]