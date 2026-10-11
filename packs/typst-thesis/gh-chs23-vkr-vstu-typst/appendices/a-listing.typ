// ПРИЛОЖЕНИЕ (методичка, с. 29, 33)
//
// В приложениях приводятся: тексты программ, программные документы
// (ТЗ по ГОСТ 19), объёмные результаты моделирования (таблицы, графики),
// виды экранов программы и другие документы.
// Объём приложений не учитывается при определении объёма записки.
//
// Буква приложения назначается автоматически по порядку: А, Б, В, Г, Д, Е,
// Ж, И, К, Л, М, Н, П, Р, С, Т, У, Ф, Х, Ц, Ш, Щ, Э, Ю, Я
// (Ё, З, Й, О, Ч, Ь, Ы, Ъ пропускаются по ГОСТ).
//
// Чтобы добавить ещё одно приложение, создайте такой же файл
// и допишите #include в thesis.typ — буквы сдвинутся сами.

#import "../lib/vkr.typ": appendix

#appendix[Листинг программного кода][
  Ниже приведён фрагмент реализации основного модуля.

  ```python
  from dataclasses import dataclass


  @dataclass
  class Task:
      id: int
      duration: int
      depends_on: list[int]


  def topological_sort(tasks: list[Task]) -> list[Task]:
      """Упорядочить задачи с учётом зависимостей."""
      by_id = {t.id: t for t in tasks}
      visited, order = set(), []

      def visit(task: Task) -> None:
          if task.id in visited:
              return
          visited.add(task.id)
          for dep in task.depends_on:
              visit(by_id[dep])
          order.append(task)

      for task in tasks:
          visit(task)
      return order
  ```
]
