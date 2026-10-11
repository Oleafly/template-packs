#import "@preview/in-dexter:0.7.2": *
#import "notes.typ"

#set text(
  font: "XB Niloofar",
  lang: "fa",
  size: 14pt,
)

#show figure.where(
  kind: table,
): set figure(supplement: "جدول")

#show figure.where(
  kind: image,
): set figure(supplement: "تصویر")

#show figure: set figure(numbering: "۱")

#show figure: it => block(width: 100%)[#align(center)[
  #it.body
  #text(size: .8em, [
    #strong([#it.supplement #it.counter.display(it.numbering):])
    #it.caption.body
  ])
]]

#set par(
  first-line-indent: (amount: 1.5em, all: true),
  leading: 15pt,
  justify: true,
)

#show heading: set block(above: 36pt, below: 32pt)
#show heading.where(level: 1): set text(size: 24pt)

#include "heading.typ"
#pagebreak()

#include "thanks.typ"
#pagebreak()

#include "summary.typ"
#pagebreak()

#outline(title: [فهرست مطالب])

#pagebreak()

#outline(
  title: [فهرست تصاویر],
  target: figure.where(kind: image),
)

#pagebreak()

#outline(
  title: [فهرست جداول],
  target: figure.where(kind: table),
)


#pagebreak()

#show heading.where(level: 1): it => [
  #set text()
  #linebreak() #linebreak() #linebreak() فصل #counter(heading).display(it.numbering) #linebreak() #linebreak() #it.body
]

#set heading(numbering: (..n) => numbering("۱-۱", ..n.pos().rev()))

#set page(numbering: "۱")

#counter(page).update(1)

= پیشگفتار

== مقدمه

متن بیشتر. نمونه ای از
#notes.note[پاورقی][footnote]
این جاست.

== اهمیت و ضرورت پژوهش

متن بیشتر.

#pagebreak()

= ایده

شرح این قسمت در
@some_image
آورده شده است.

#figure(
  image("./logo_abi2.png", width: 50%),
  caption: [
    نمونه‌ای از یک تصویر
  ],
) <some_image>

#pagebreak()

= فصل بیشتر

#figure(
  table(
    columns: 4,
    table.header("نام", "روش کارکرد", "خوانایی خروجی", "دقت خروجی"),
    "گیدرا", "قواعد و الگوریتم‌های دستی", "کم", "با تنظیماتی که خوانایی را کاهش دهد می‌تواند زیاد باشد",
    "کودا", "ال‌اس‌تی‌ام درختی + توجه", "زیاد در کدهای بسیار کوچک", "زیاد در کدهای بسیار کوچک",
    "آلان جافی و سایرین", "ترجمه ماشینی آماری", "بهتر از مترجم معکوس پایه", "برابر با مترجم معکوس پایه",
    "اسلید", "ترنسفرمر", "متوسط", "متوسط",
    "بانرجی و وانگ", "برت", "بهتر از مترجم معکوس پایه", "برابر با مترجم معکوس پایه",
    [ال‌ال‌ام برای ترجمه معکوس @llm4decompile], "مدل زبانی بزرگ تنظیم دقیق شده", "زیاد", "متوسط",
    [دی‌جی‌پی‌تی @DeGPT], "مدل زبانی بزرگ به صورت چند عاملی", "بهتر از مترجم معکوس پایه", "برابر با مترجم معکوس پایه",
    "سالت برای ترجمه معکوس", "مدل زبانی بزرگ با ورودی گراف جریان کنترل", "زیاد", "متوسط",
  ),
  caption: [
    مقایسه روش‌های به کار رفته برای ترجمه معکوس
  ],
)

#pagebreak()

= فصل بیشتر

#figure(
  image("./besmellah.jpg", width: 20%),
  caption: [
    نمونه‌ای از یک تصویر دیگر
  ],
)

#pagebreak()

= نتیجه‌گیری

#pagebreak()

#set heading(numbering: none)

#show heading.where(level: 1): it => [
  #set text()
  #linebreak() #linebreak() #it.body
]


= مراجع

#text(lang: "en", font: "Times New Roman", size: 9pt)[

  #bibliography("ref.bib", title: none)

]

#pagebreak()

= واژه‌نامه

// ===================================================================
//  GLOSSARY DATA
//  --- EDIT THIS LIST ---
// ===================================================================
// Add your words here. The code will handle sorting and grouping.
#context {
  let glossary-data = notes.glossary-state.get()
  // ===================================================================
  //  AUTOMATIC GROUPING & FORMATTING
  //  (No need to edit below this line)
  // ===================================================================

  // --- 1. Processing and Grouping Data ---
  // Sort data alphabetically by the Persian term
  let sorted-data = glossary-data.sorted(key: x => x.fa)

  // Group sorted data into a dictionary by the first letter
  let groups = (:)
  for item in sorted-data {
    let first-letter = item.fa.at(0)
    let existing = groups.at(first-letter, default: ())
    groups.insert(first-letter, existing + (item,))
  }

  // --- 2. Formatting Function ---
  // This function formats a single letter-group (e.g., all "الف" words)
  let format-group(letter, items) = {
    // Letter heading (e.g., "الف")
    align(center)[
      #strong[#text(size: 24pt, letter)]
    ]
    v(1em)

    // Table for the entries
    table(
      columns: (auto, 1fr, auto),
      stroke: none,
      align: (left, center, right),

      // Loop through all items for this letter
      ..for item in items {
        (
          text(dir: ltr)[#item.en], // English part (LTR)
          [......], // Dotted line
          item.fa, // Persian part (RTL)
        )
      }
    )
  }

  let all-letters = groups.keys().sorted()
  let mid-point = calc.ceil(all-letters.len() / 2)
  let col1-letters = all-letters.slice(0, mid-point)
  let col2-letters = all-letters.slice(mid-point)

  // Create the 2-column grid
  grid(
    columns: (1fr, 1fr),
    gutter: 3em,

    // RIGHT COLUMN (First half of the alphabet)
    // (This is the first grid item, so it appears right in RTL)
    [
      #for letter in col1-letters {
        format-group(letter, groups.at(letter))
        v(2em) // Space between letter sections
      }
    ],

    // LEFT COLUMN (Second half of the alphabet)
    [
      #for letter in col2-letters {
        format-group(letter, groups.at(letter))
        v(2em) // Space between letter sections
      }
    ],
  )
}

#pagebreak()

#set page(numbering: none)
#set text(lang: "en")

#include "summary_en.typ"

#pagebreak()

#include "heading_en.typ"
