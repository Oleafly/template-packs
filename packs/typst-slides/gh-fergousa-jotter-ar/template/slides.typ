#import "@preview/polylux:0.4.0": *
/*#import "@preview/jotter-polylux-ar:0.1.0": (
  setup,
  title-slide,
  framed-block,
  post-it,
)*/
#import "../jotter.typ": (
  setup,
  title-slide,
  framed-block,
  post-it,
)

// الخطوط: نستخدم «El Messiri» المكتوب بخط اليد لتطابق روح القالب.
// استبدله بخط عربي مكتوب آخر إن رغبت (مثل Aref Ruqaa أو Lateef).
#set text(
  size: 25pt,
  font: "El Messiri",
  fill: blue.darken(50%),
)

// المعادلات تبقى بخط رياضي لاتيني (لا يوجد خط رياضي عربي مكتوب).
#show math.equation: set text(
  font: ("Libertinus Math", "New Computer Modern Math"),
  weight: "light",
)

// الشفرة المصدرية
#show raw: set text(font: "Fantasque Sans Mono")

#show: setup.with(
  header: [محاضرة قصيرة],
  highlight-color: red,
  binding: true,
  dots: true,
)

#title-slide[عنوان محاضرتي المثيرة][
  عنوان فرعي

  اسم المتحدث

  التاريخ، المكان

  #place(
    horizon + left,
    post-it[
      #set align(horizon + right)
      #set text(size: .6em)
      لا تفوّت هذه المحاضرة!
    ],
  )
]

#slide[
  = الطباعة

  #toolbox.side-by-side[
    نمّق محتواك بجمال!

    بعض النص *غامق*، وبعضه _مؤكَّد_.
  ][
    - نقطة نقطية
    - نقطة نقطية أخرى

    + النقطة الأولى
    + النقطة الثانية
  ]
]

#slide[
  = الرياضيات والبرمجة

  #toolbox.side-by-side[
    يقول ماكسويل:
    $
      integral.surf_(partial Omega) bold(B) dot dif bold(S) = 0
    $
  ][
    احسب الجواب:
    ```rust
    pub fn main() {
        dbg!(42);
    }
    ```
  ]
]

#slide[
  = تظليل المحتوى

  // كل من #framed-block و #post-it يقبلان وسطاء sloppiness لتحديد
  // مدى العشوائية. و #framed-block يقبل أيضاً inset و width و height
  // مثل كتلة #block العادية.

  #toolbox.side-by-side[
    #grid(
      columns: 2,
      gutter: 1em,
      framed-block[أ], framed-block[زوج],
      framed-block[من], framed-block[عشوائي],
      framed-block[مؤطّر], framed-block[صناديق],
    )
  ][
    #box(post-it(width: 6cm)[ورقة لاصقة \ السطر الثاني \ السطر الثالث])
    #box(post-it(width: 5.5cm)[ورقة أخرى \ السطر الثاني \ ثم الثالث])
  ]
]
