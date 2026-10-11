#import "../src/lib/template.typ": (
  code, code_listing, code_ref, continued_table, fig_ref, table_ref, thesis_template, todo, un_link,
)
#import "../src/technical_task/content.typ": technical_task_content
#import "../src/report/content.typ": report_content
#import "../src/appendix/content.typ": d1_content, d2_content, d3_content, d4_content
#import "./diagrams/diagrams.typ": diagrams

#let code = todo[467100]

#let thesis = (
  topic: todo[Модуль синхронізації текстових даних у розподілених системах],
  document: (
    head_name: todo[Артем ВОЛОКИТА],
    approved_by: todo[Волокита А. М.],
    city: [Київ],
    year: todo[2026],
    codes: (
      album_description: (
        number: [ІАЛЦ.#code.001],
        short_form: [ОА],
        form: (title: [Опис альбому], note: none),
      ),
      technical_task: (
        number: [ІАЛЦ.#code.002],
        short_form: [ТЗ],
        form: (title: [Технічне завдання], note: none),
      ),
      report: (
        number: [ІАЛЦ.#code.003],
        short_form: [ПЗ],
        form: (title: [Пояснювальна записка], note: none),
      ),
      d1: (
        number: [ІАЛЦ.#code.004],
        short_form: [Д1],
        form: (title: todo[Компоненти застосунка], note: [структурна схема]),
      ),
      d2: (
        number: [ІАЛЦ.#code.005],
        short_form: [Д2],
        form: (
          title: todo[Діаграма класів],
          note: [функціональна схема],
        ),
      ),
      d3: (
        number: [ІАЛЦ.#code.006],
        short_form: [Д3],
        form: (title: todo[Алгоритм роботи застосунку], note: [принципова схема]),
      ),
      d4: (
        number: [ІАЛЦ.#code.007],
        short_form: [Д4],
        form: (title: [Текст програмного коду], note: none),
      ),
    ),
  ),
  student: (
    course: [4],
    group: todo[ІМ-21],
    full_name: todo[Сірик Максим Олександрович],
    sign_name: todo[Максим СІРИК],
    initials: todo[Сірик М. О.],
    genitive_name: todo[Сірика Максима Олександровича],
  ),
  advisor: (
    title_line: todo[
      #move(dy: 1.5pt)[
        #text(size: 12.5pt)[
          доц. кафедри ОТ ФІОТ, к.т.н., с.н.с. Долголенко О. М.
        ]
      ]
    ],
    title_line_reversed: todo[Долголенко Олександр Миколайович, к.т.н., с.н.с.],
    full_name: todo[Долголенко Олександр Миколайович],
    sign_name: todo[Олександр ДОЛГОЛЕНКО],
    initials: todo[Долголенко О. М.],
  ),
  consultant: (
    initials: todo[Коренко Д. В.],
    title_line: todo[
      #move(dy: 4.5pt)[
        #text(size: 8.9pt)[
          ас. кафедри ОТ ФІОТ, д-р. філос. Коренко Д. В.
        ]
      ]
    ],
  ),
  reviewer: (
    full_name: todo[Щербина Олександр Андрійович],
    title_line: todo[
      #move(dy: 1.8pt)[
        #text(size: 11.8pt)[
          доц. кафедри СПСКС ФПСПМ, к.т.н., доц. Щербина О. А.
        ]
      ]
    ],
  ),
  report: (
    abbreviations: (
      (
        todo[CRDT],
        todo[Conflict-free Replicated Data Type -- конфліктно-вільний реплікований
          тип даних],
      ),
      (
        todo[LEB128],
        todo[Little Endian Base 128 -- кодування цілих чисел змінної довжини],
      ),
    ),
  ),
  annotation: (
    text_ua: todo[
      У бакалаврському дипломному проєкті розроблено модуль синхронізації
      текстових даних у розподілених системах. Модуль призначений для спільного
      редагування тексту без обов'язкового центрального координатора та
      ґрунтується на підході конфліктно-вільних реплікованих типів даних (CRDT).

      У роботі реалізовано текстову CvRDT-структуру. Реалізацію виконано мовою
      Zig з можливістю компіляції у WebAssembly. Для використання у
      вебсередовищі розроблено TypeScript-обгортку та демонстраційний
      застосунок. Коректність основних властивостей перевірено модульними,
      сценарними та рандомізованими fuzz-тестами.

      *Ключові слова:* розподілені системи, синхронізація текстових даних,
      спільне редагування документів, конфліктно-вільні репліковані типи даних
      (CRDT), збіжність, автономна робота, peer-to-peer синхронізація,
      local-first застосунки, WebAssembly, Zig, TypeScript.
    ],
    text_en: todo[
      The bachelor's diploma project develops a module for synchronizing text
      data in distributed systems. The module is intended for collaborative text
      editing without requiring a central coordinator and is based on the
      Conflict-free Replicated Data Types (CRDT) approach.

      The work implements a text state-based CRDT structure. The implementation
      is written in Zig and can be compiled to WebAssembly. A TypeScript wrapper
      and a demonstration application were developed for use in a web
      environment. The correctness of the main properties was verified using
      unit tests, scenario tests, and randomized fuzz tests.

      *Keywords:* distributed systems, text data synchronization, collaborative
      document editing, conflict-free replicated data types (CRDT), convergence,
      offline operation, peer-to-peer synchronization, local-first applications,
      WebAssembly, Zig, TypeScript.
    ],
  ),
  assignment: (
    order_line: todo[
      "03" червня 2026 р. №2055-с
    ],
    due_date: todo["04" червня 2026 р.],
    input_data: todo[технічна документація, теоретичні дані],
    issue_date: todo["13" квітня 2026 р.],
    calendar: (
      ([Затвердження теми проєкту], todo[02.02.2026-19.04.2026], []),
      ([Вивчення та аналіз завдання], todo[20.04.2026-26.04.2026], []),
      (
        [Розробка архітектури та загальної структури системи],
        todo[27.04.2026-30.04.2026],
        [],
      ),
      ([Розробка структур окремих підсистем], todo[01.05.2026-03.05.2026], []),
      ([Програмна реалізація системи], todo[04.05.2026-15.05.2026], []),
      ([Оформлення пояснювальної записки], todo[16.05.2026-24.05.2026], []),
      ([Захист програмного продукту], todo[05.06.2026], []),
      ([Передзахист], todo[08.06.2026], []),
      ([Захист], todo[15.06.2026], []),
    ),
  ),
  album_description: (
    implemented_by: todo[#text(size: 5.5pt)[Сірик М. О.]],
    examined_by: todo[#text(size: 5.5pt)[Долголенко О. М.]],
  ),
)

#show: doc => thesis_template(
  thesis: thesis,
  doc,
)

#technical_task_content(
  thesis: thesis,
)[
  = Найменування та область використання

  #todo[
    Це технічне завдання поширюється на розробку модуля синхронізації текстових
    даних у розподілених системах.

    Область використання: браузерні та локальні застосунки для спільного
    редагування текстових документів, системи local-first, прототипи peer-to-peer
    редакторів.
  ]

  = Причини для розробки

  Підставою для розробки є завдання на виконання бакалаврського дипломного
  проєкту за темою "#thesis.topic" спеціальності 121 "Інженерія програмного
  забезпечення", затверджене кафедрою обчислювальної техніки Національного
  технічного університету України "Київський політехнічний інститут імені Ігоря
  Сікорського".

  = Мета та призначення розробки

  #todo[
    Метою розробки є створення модуля синхронізації текстових даних, який
    забезпечує узгодження стану між репліками в розподіленій системі та є
    придатним для використання у браузерному середовищі.
  ]

  = Джерела розробки

  #todo[
    Джерелами розробки є науково-технічна література, документація, публікації та
    статті в мережі Інтернет.
  ]

  = Технічні вимоги

  == Вимоги до продукту, що розробляється <doc:task-requirements>

  #todo[
    Реалізація модуля має бути придатною для створення систем, що відповідають
    таким вимогам:

    - *Гарантована збіжність.* Якщо всі репліки отримають однаковий набір
      оновлень, вони мають зрештою перейти в однаковий стан.
  ]

  == Вимоги до програмного забезпечення

  #todo[
    Для розробки, збирання та перевірки модуля необхідне таке програмне
  забезпечення:

    - операційна система Linux;
    - компілятор Zig версії не нижче `0.16.0`;
  ]

  == Вимоги до апаратної частини

  #todo[
    - процесор архітектури `x86_64`;
    - 16 ГБ оперативної пам'яті;
    - 20 ГБ вільного місця на диску.
  ]

  = Етапи розробки

  Розробка виконується за такими етапами:

  #table(
    columns: (9mm, 1fr, 55mm),
    inset: (x: 3pt, y: 4pt),
    align: horizon + left,
    table.header([№], [Назва етапу], [Термін виконання]),
    ..thesis
      .assignment
      .calendar
      .enumerate()
      .filter(((index, row)) => index + 1 < 7)
      .map(((index, row)) => (
        [#calc.round(index + 1)],
        row.at(0),
        row.at(1),
      ))
      .flatten(),
  )
]

#report_content(
  thesis: thesis, 
  // Be careful. The path is relative to the import file, 
  // which is `src/lib/theme.typ`, not the final document.
  bibliography_sources: "../../example/bib.yml",
)[
  = Вступ

  #todo[]

  = Розділ 1. Аналіз задачі та підходів до..

  == #todo[]

  === #todo[]

  == #todo[Приклад можливостей typst]

  - `=` - заголовок рівня 1  
  - `==` - заголовок рівня 2
  - `===` - заголовок рівня 3

  - $a times b$ -- математичне вираження 1
  - $ a times b $ -- математичне вираження 2

  - `@lamport-time-clocks-ordering[с. 560-562]` -- посилання 1
  - `@lamport-time-clocks-ordering` -- посилання 2

  @ot-jupiter-paper

  Порівняємо ці підходи за різними критеріями #table_ref(<tab:approaches-comparison>):

  #continued_table(
    <tab:approaches-comparison>,
    caption: [Порівняння підходів до спільного редагування],
    columns: 4,
    table.header([Характеристика], [Тристороннє злиття], [OT], [CRDT]),
    parts: (
      arguments(
        [Співпраця в реальному часі],
        [Низька],
        [Висока],
        [Висока],
      ),
      arguments(
        [Накладні витрати метаданих синхронізації],
        [Низькі],
        [Середні або високі],
        [Низькі або середні],
      ),
      arguments(
        [Накладні витрати метаданих стану документа],
        [Низькі],
        [Низькі або середні],
        [Високі],
      ),
    ),
  )

  З огляду на вимоги цієї роботи (@doc:task-requirements), найдоцільнішим
  підходом є CRDT.

  У таблиці #table_ref(<tab:approaches-comparison>, see: true, parens: true)
  використано такі позначення:

  У стандартному алгоритмі годинників Лампорта #fig_ref(
    <fig:lamport-clocks>,
    parens: true,
  ) кожна репліка збільшує локальний годинник перед створенням події.

  #figure(
    diagrams.lamport-clocks,
    caption: [Оновлення годинників Лампорта],
  ) <fig:lamport-clocks>

  #un_link("https://github.com/erotourtes/mirage/")[erotourtes/mirage]

  Мінімальний приклад синхронізації двох реплік через TypeScript-обгортку
  наведено на рисунку #code_ref(<lst:ts-sync-example>, parens: true) (це приклад
  коду з `js/packages/example`).

  #code_listing(
    target: <lst:ts-sync-example>,
    caption: [Синхронізація двох реплік через TypeScript-обгортку],
  )[
    ```ts
    import { loadMirage } from "@mirage/wasm";

    const mirage = await loadMirage();

    const a = mirage.createDocument(1);
    const b = mirage.createDocument(2);

    a.insert(0, "Hello");
    a.insert(5, " world", { key: "bold", value: "true" });

    const bState = b.encodeStateVector();
    const update = a.encodeUpdate(bState);
    b.applyUpdate(update);

    console.log(b.toString()); // "Hello world"
    console.log(b.toDelta());

    a.destroy();
    b.destroy();
    ```
  ]

  = Висновок до розділу 1

  #todo[]


  = Розділ 2. Обґрунтування вибору технологій для розробки.. <doc:section-2>

  == #todo[]

  === #todo[]

  = Висновок до розділу 2

  #todo[]


  = Розділ 3. Проєктування та реалізація..

  == #todo[]

  === #todo[]


  = Висновок до розділу 3

  #todo[]


  = Розділ 4. Тестування, аналіз та обмеження.. 

  == #todo[]

  === #todo[]

  = Висновок до розділу 4

  #todo[]


  = Висновки

  #todo[]
]

#d1_content(
  thesis: thesis,
)[
  #todo[]
]

#d2_content(
  thesis: thesis,
)[
  #todo[]
]

#d3_content(
  thesis: thesis,
)[
  #todo[]
]

#d4_content(
  thesis: thesis,
)[
  #todo[]
]
