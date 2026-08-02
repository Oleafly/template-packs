#import "@preview/pintorita:0.1.4"


// Кольори бренду
#let brand-orange = rgb("#E85D00")
#let brand-dark   = rgb("#1a1a2e")


#let months = ("січеня", "лютого", "березня", "квітня", "травня", "червня", "липня", "серпня", "вересня", "жовтня", "листопада", "грудня")
#let translated-month(dt) = months.at(dt.month() - 1)
#let today = datetime.today()

// ============================================================
//  ТИТУЛЬНА СТОРІНКА
// ============================================================
#let title-page(
  title: "ЗВІТ ПРО ОБСТЕЖЕННЯ\nБІЗНЕС-ПРОЦЕСІВ",
  customer: "[]",
  authors: ("Someone"),
  date: today,
  agreement: "ODOO 01/13/05/2025",
  a-date: today,
) = {
  page(
    numbering: none,
    header: none,
    footer: none,
    margin: (top: 3.5cm, bottom: 1.2cm, left: 0cm, right: 0cm),
  )[
    // ── Шеврон у правому верхньому куті ──
    #place(top + right, dx: 0cm, dy: -0.5cm)[
      #image("Right-Shevron.png", width: 2.2cm)
    ]
  
    // ── Заголовок ──
    #pad(left: 1.5cm)[
      #text(
        size: 28pt, 
        weight: "bold", 
        fill: black
      )[#title]
      
      #text(
        size: 20pt, weight: "regular", 
        style: "italic", fill: black
      )[#customer]
    ]
    #v(0.6cm)
  
    // ── Фонове зображення з текстовим оверлеєм ──
    #block(width: 100%, clip: true, radius: 0pt)[
      // Контейнер з відносним позиціюванням
      #box(width: 100%, height: 14cm)[
        // Фонова картинка на всю ширину
        #place(top + left)[
          #image("Title-Backgroud.png", width: 100%)
        ]
  
        // Текстовий блок поверх картинки (права сторона)
        #place(top + right, dx: -0.7cm, dy: 2cm)[
          #block(width: 10cm)[
            #set text(fill: white, size: 9.5pt, lang: "ru")
            #set align(right)
  
            *Підстава для розробки документа:*\
            Договір № #agreement \ // ODOO 01/13/05/2025\
            від #a-date.display("[day].[month].[year]р.") //13.05.2025р.
  
            #v(3cm)
  
            *«РОЗРОБЛЕНО»*\
            *РОБОЧА ГРУПА ВИКОНАВЦЯ:*\
            #for a in authors [
              *#a*\
            ]
            *#date.display("«[day]» "+ translated-month(date)+" [year] року")*
          ]
        ]
  
        // Слоган + горизонтальні лінії (ліва нижня частина)
        #place(bottom + left, dy: -0.9cm)[
          #block(width: 10cm)[
            #pad(left: 1cm)[
              #text(
                size: 18pt,
                //style: "italic",
                tracking: 0.08em,
                fill: white,
                weight: "regular",
              )[too easy do simple]
            ]
            #v(0.1cm)
            // Декоративні горизонтальні смуги
            #stack(
              dir: ttb,
              spacing: 11pt,
              line(length: 8.5cm,  stroke: stroke(paint: white, thickness: 6pt, cap: "round")),
              line(length: 8.7cm,  stroke: stroke(paint: white, thickness: 6pt, cap: "round")),
              line(length: 8.6cm,  stroke: stroke(paint: white, thickness: 6pt, cap: "round")),
              line(length: 8.8cm,  stroke: stroke(paint: white, thickness: 6pt, cap: "round")),
              line(length: 8.4cm,  stroke: stroke(paint: white, thickness: 6pt, cap: "round")),
            )
          ]
        ]
      ]
    ]
  
    #v(1fr)
  
    // ── Логотип ToDo внизу по центру ──
    #align(center)[
      #image("ToDo-Logo.png", height: 3.5cm)
    ]
  
    #v(0.3cm)
  ]
}




// ── Header builder ──
#let doc-header(
  title: "[Title]",
  customer: "[Назва Замовника]",
  version: "0.1"
) = {
  v(1cm)
  set text(size: 8pt)
  table(
    columns: (auto, 1fr, auto),
    rows: (2.25em,2.25em),
    inset: 8pt,
    stroke: (dash: "dashed", thickness: 0.1pt),
    align: (center + horizon, left + horizon, left + horizon),
    table.cell(rowspan: 2)[
      #image("ToDo-Logo.png", height: 4em)
    ],
    text(weight: "bold")[#title],
    [Сторінка #context counter(page).display()],
    text(weight: "bold")[#customer], 
    [Версія #version],
  )
  place(top + left, dx: -2.5cm, dy: -0.2cm)[
      #image("Left-Shevron.png")
  ]
  v(4pt)
}

// ── Footer builder ──
#let doc-footer() = {
  place(bottom + left, dx: -2.5cm, dy: 0cm)[
    #block(width: 210mm, height: 2cm, fill: luma(230))[
      #set text(size: 7.5pt, fill: luma(100))
      #set align(top)
      //line(length: 100%, stroke: 1.5pt + brand-orange)
      #v(0.6cm)
      #grid(
        columns: (2.5cm,1fr, 1fr,1.5cm),
        [],
        [
          #text(weight: "bold", /*fill: brand-orange*/)[ToDo:] Too easy do simple\
          www.todo.ltd
        ],
        align(right)[
          +38 (073) 871 53 13\
          sale\@todo.ltd
        ],
        [
          // Правий шеврон
          #place(top + right, dx: 0.7cm, dy: -2.5cm)[
            #rotate(-180deg)[ #image("Left-Shevron.png") ]
          ]
        ],
      )
      
    ]
  ]
}


// ---------- Abbreviation style for tables ----------
#let abbr-table(..rows) = {
  table(
    columns: (auto, 1fr),
    inset: 6pt,
    stroke: 0.5pt,
    align: (left, left),
    table.header(
      table.cell(fill: luma(230))[*Термін*],
      table.cell(fill: luma(230))[*Визначення / розшифровка / пояснення*],
    ),
    ..rows.pos()
  )
}


#let todo-report(
  title: "",
  customer: "",
  version: "0.1",
  author: (),
  date: today,
  agreement: "ODOO 01/13/05/2025",
  a-date: today,
  body,   // обов'язковий позиційний параметр — вміст документа
) = {

  
  set document(title: title, author: author, date: date)
  set text(font: "DejaVu Sans", size: 11pt, lang: "uk")
  set par(justify: true, leading: 0.7em)
  set heading(numbering: "1.1.1.")
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2cm, left: 2.5cm, right: 1.5cm),
    numbering: "1",
    number-align: center,
    header: doc-header(title: title, customer: customer, version: version),
    header-ascent: 0.8cm,
    footer: doc-footer(),
    footer-descent: 0.5cm,
  )

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(0.5cm)
    block(text(size: 16pt, weight: "bold", it))
    v(0.3cm)
  }
  show heading.where(level: 2): it => {
    v(0.4cm)
    block(text(size: 13pt, weight: "bold", it))
    v(0.2cm)
  }
  show heading.where(level: 3): it => {
    v(0.3cm)
    block(text(size: 11.5pt, weight: "bold", it))
    v(0.15cm)
  }

  show raw.where(lang: "pintora"): it => pintorita.render(it.text)

  title-page(
    customer:customer, 
    authors: author, 
    agreement: agreement, 
    a-date: a-date, 
    date: date
  )
  counter(page).update(1)
  outline(indent: 1.5em, depth: 3)

  body  // рендерить увесь вміст документа з цими налаштуваннями
}
