// Persian Homework Typst Template - A typst template for turning assignments in Persian using typst.
// Written in 2025 by Hossein Naghdbishi <me@hossein.me>
// To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
// You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
// AI has been used to write at least some part of this file.

#let meta = (
  course: "طراحی الگوریتم",
  series: "اول",
  author: "فلانی فلانی‌نژاد",
  student-id: "۴۰۰۱۲۳۴۵۶",
  prof: "دکتر فلانی‌زاده",
  jdate: "۳ آبان ۱۴۰۴",
  type: "تمرین", // یا مثلا پروژه
  latin-font: "Fira Sans",
  fa-font: "Sahel"
)

// ===========================================
// تنظیمات کلی سند (فارسی و فونت)
// ===========================================
#set document(title: "پاسخ " + meta.type + " " + meta.series + " درس " + meta.course + " - " + meta.author,
              author: meta.author,
              description: "پاسخی برای " + meta.type + " درس " + meta.course + " " + meta.prof + " توسط " + meta.author,
              date: auto)
#set text(lang: "fa", region: "ir", font:(meta.latin-font, meta.fa-font), size: 12pt, dir: rtl)
#set par(justify: true, leading: 0.65em)
#set page(margin: (x: 1.5cm, y: 2cm))
#set figure(numbering: "۱")  // add supplement: تصویر and etc
#show link: set text(fill: rgb("#f012be"))
#show <ltrr>: set text(dir:ltr)
#show math.equation: set text(font: "Fira Math Book", style:"normal",  dir: ltr)
#show raw: set text(font: "Fira Code", style:"normal",  dir: ltr)

// #set list(marker: ([•], [‣], [⁃]))

// ===========================================
// تنظیمات رنگ و استایل قابل تغییر
// ===========================================
#let theme-color = rgb("#2c5aa0")
#let question-bg = luma(240)

// ===========================================
// تعریف صفحه جلد (Cover Page)
// ===========================================
#let assignment-cover(logo-path: "sharif-logo.png") = {
  set page(numbering: none)
  
  align(center)[
    #v(2fr)
    #if logo-path != none {
      image(logo-path, width: 60%)
    }
    #v(1fr)
    #text(18pt, weight: "bold", fill: theme-color)[دانشگاه صنعتی شریف]
    #text(16pt, fill: theme-color)[دانشکدهٔ مهندسی کامپیوتر]
    
    #v(4fr)
    
    #text(22pt, weight: "bold")[#meta.course]
    #v(1.5fr)
      #text(20pt)[#meta.type سری #meta.series]
    
    #v(6fr)
    
    #if meta.prof != none {
      text(14pt)[استاد: #meta.prof]
      v(1fr)
    }
    
    #text(14pt)[دانشجو: *#meta.author* (#meta.student-id)]
    
    #v(3fr)
    #text(14pt, fill: theme-color, style: "italic")[#meta.jdate]
  ]
  
  pagebreak()
  counter(page).update(1)
}

// ===========================================
// تنظیمات صفحات اصلی (بدون state، با meta)
// ===========================================
#let setup-main-pages() = {
  set page(
    numbering: "۱",
    header: context {
      if counter(page).get().first() > 0 [
        #set text(9pt, fill: gray)
        #grid(
          columns: (1fr, 1fr),
          align: (right, left),
          meta.course,
            [#meta.type سری #meta.series]
        )
        #line(length: 100%, stroke: 0.5pt + gray)
      ]
    },
    footer: context {
      set text(10pt)
      grid(
        columns: (1fr, auto, 1fr),
        align: (right, center, left),
        meta.author,
        [صفحه #counter(page).display("۱", lang: "fa")],
        meta.jdate
      )
    }
  )
}

// ===========================================
// فهرست مطالب (اختیاری)
// ===========================================
#let show-toc() = {
  set page(numbering: none)
  
  align(center)[
    #text(18pt, weight: "bold")[فهرست مطالب]
  ]
  
  v(2em)
  
  outline(
    title: none,
    depth: 2,
    indent: 2em
  )
  
  pagebreak()
  counter(page).update(1)
}

// ===========================================
// تعریف شمارنده و تابع سوال
// ===========================================
#let question-counter = counter("question")

#let question(title: none, body) = {
  question-counter.step()
  
  v(1.8em, weak: true)
  
  let question-title = if title != none {
    text(16pt, weight: "bold")[
      سوال #context { question-counter.display("۱") }: #title
    ]
  } else {
    text(16pt, weight: "bold")[
      سوال #context { question-counter.display("۱") }
    ]
  }
  
  block(
    fill: question-bg,
    inset: 10pt,
    radius: 5pt,
    width: 100%,
    stroke: 1pt + theme-color
  )[#question-title]
  v(1em)
  
  set par(justify: true)
  pad(left: 8pt, right: 8pt, body)
  
  pagebreak(weak: true)
}

// ===========================================
// توابع کمکی
// ===========================================
#let subquestion(label, body) = {
  block(inset: (right: 1em), width: 100%)[
    #text(weight: "bold", fill: theme-color)[#label)] #body
  ]
  v(0.8em)
}

#let bigO(content) = $cal(O)(#content)$
#let bigOmega(content) = $Omega(#content)$
#let bigTheta(content) = $Theta(#content)$

#let codesection(title, body) = {
  show figure: set block(breakable: true) // for large amounts of code
  figure(
    block(
      fill: luma(250),
      inset: 12pt,
      radius: 4pt,
      stroke: 1pt + theme-color
    )[
      #set align(right)
      #set text(dir: ltr, font: "Fira Code", size: 10pt)
      #body
    ],
    caption: title,
    supplement: [کد],
    kind: "code"
  )
}

// ===========================================
// محتوای سند
// ===========================================

#assignment-cover()
#setup-main-pages()
// #show-toc()

#question(title: "مرتب‌سازی سریع")[
  الگوریتم مرتب‌سازی سریع (QuickSort) یکی از کارآمدترین الگوریتم‌های مرتب‌سازی است که بر اساس روش تقسیم و حل عمل می‌کند.
  
  == تحلیل پیچیدگی
  
  پیچیدگی زمانی این الگوریتم در حالت متوسط #bigO($n log n$) و در بدترین حالت #bigO($n^2$) است.
  
  == پیاده‌سازی
  
  #codesection("الگوریتم QuickSort")[
    ```python
    def quick_sort(arr):
        if len(arr) <= 1:
            return arr
        pivot = arr[len(arr) // 2]
        left = [x for x in arr if x < pivot]
        middle = [x for x in arr if x == pivot]
        right = [x for x in arr if x > pivot]
        return quick_sort(left) + middle + quick_sort(right)
    ```
  ]
  
  == اثبات صحت
  
  برای اثبات صحت الگوریتم از استقرای ریاضی استفاده می‌کنیم:
  
  #subquestion("الف")[
    *حالت پایه:* برای آرایه‌ای با طول کمتر یا مساوی ۱، الگوریتم به درستی عمل می‌کند.
  ]
  
  #subquestion("ب")[
    *فرض استقرا:* فرض کنید الگوریتم برای آرایه‌های با طول کمتر از $n$ به درستی عمل می‌کند.
  ]
  
  #subquestion("ج")[
    *گام استقرا:* برای آرایه با طول $n$، پس از انتخاب pivot و تقسیم، زیرآرایه‌ها کوچکتر از $n$ هستند و طبق فرض استقرا مرتب می‌شوند.
  ]
]

#question(title: "برنامه‌نویسی پویا")[
  در این سوال به بررسی مسئله کوله‌پشتی (Knapsack Problem) می‌پردازیم.
  
  == تعریف مسئله
  
  داده شده:
  - مجموعه‌ای از $n$ شیء با وزن‌های $w_1, w_2, ..., w_n$
  - ارزش‌های متناظر $v_1, v_2, ..., v_n$
  - ظرفیت کوله‌پشتی $W$
  
  هدف: انتخاب زیرمجموعه‌ای از اشیاء که بیشترین ارزش را داشته و مجموع وزن‌ها از $W$ تجاوز نکند.
  
  == رابطه بازگشتی
  
  $ K(i,w) = cases(
    0 "اگر" i=0 "یا" w=0,
    K(i-1\, w) "اگر" w_i > w,
    max(K(i-1\, w)\, v_i + K(i-1\, w-w_i)) "در غیر این صورت"
  ) $
  
  == پیچیدگی
  
  - پیچیدگی زمانی: #bigTheta($n W$)
  - پیچیدگی مکانی: #bigTheta($n W$)
]

#question(title: "الگوریتم‌های گراف")[
  در این بخش الگوریتم Dijkstra را بررسی می‌کنیم.
  
  == ویژگی‌های الگوریتم
  
  - برای یافتن کوتاه‌ترین مسیر از یک راس مبدا به سایر رئوس استفاده می‌شود
  - فقط برای گراف‌های با وزن‌های غیرمنفی کار می‌کند
  - از روش حریصانه (Greedy) استفاده می‌کند
  
  == مثال عملی
  
  #figure(
    rect(
      width: 80%,  
      height: 150pt,  
      fill: white,
      stroke: 1pt + theme-color,
      inset: 10pt
    )[
      #align(center + horizon)[
        #text(fill: gray)[نمودار گراف در اینجا قرار می‌گیرد]
      ]
    ],
    caption: [گراف نمونه برای الگوریتم Dijkstra]
  )
  
  == جدول مقایسه
  
  #align(center)[
    #table(
      columns: (auto, auto, auto),
      align: center,
      table.header(
        [*الگوریتم*], [*پیچیدگی زمانی*], [*وزن منفی*]
      ),
      [Dijkstra], [#bigO($n^2$)], [خیر],
      [Bellman-Ford], [#bigO($n m$)], [بله],
      [Floyd-Warshall], [#bigO($n^3$)], [بله]
    )
  ]
]

