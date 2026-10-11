#import "../lib.typ": *


= Introduction to Typst

This chapter shows the usage of Typst and some features in this template.

== Basic Syntax

=== Text Formatting

Here's how to format text in Typst:


```typst
*bold text*
_italic text_
`inline code`
*_bold and italic_*
```

This produces: *bold text*, _italic text_, `inline code`, *_bold and italic_*.

```typst
#text(font: font_serif, weight: "extralight")[明朝体]
#text(font: font_serif, weight: "light")[明朝体]
#text(font: font_serif, weight: "regular")[明朝体]
#text(font: font_serif, weight: "medium")[明朝体]
#text(font: font_serif, weight: "semibold")[明朝体]
#text(font: font_serif, weight: "bold")[明朝体]
#text(font: font_serif, weight: "extrabold")[明朝体]
#text(font: font_serif, weight: "black")[明朝体]

#text(font: font_sans, weight: "extralight")[ゴシック体]
#text(font: font_sans, weight: "light")[ゴシック体]
#text(font: font_sans, weight: "regular")[ゴシック体]
#text(font: font_sans, weight: "medium")[ゴシック体]
#text(font: font_sans, weight: "semibold")[ゴシック体]
#text(font: font_sans, weight: "bold")[ゴシック体]
#text(font: font_sans, weight: "extrabold")[ゴシック体]
#text(font: font_sans, weight: "black")[ゴシック体]

```
#text(font: font_serif, weight: "extralight")[明朝体]
#text(font: font_serif, weight: "light")[明朝体]
#text(font: font_serif, weight: "regular")[明朝体]
#text(font: font_serif, weight: "medium")[明朝体]
#text(font: font_serif, weight: "semibold")[明朝体]
#text(font: font_serif, weight: "bold")[明朝体]
#text(font: font_serif, weight: "extrabold")[明朝体]
#text(font: font_serif, weight: "black")[明朝体]

#text(font: font_sans, weight: "extralight")[ゴシック体]
#text(font: font_sans, weight: "light")[ゴシック体]
#text(font: font_sans, weight: "regular")[ゴシック体]
#text(font: font_sans, weight: "medium")[ゴシック体]
#text(font: font_sans, weight: "semibold")[ゴシック体]
#text(font: font_sans, weight: "bold")[ゴシック体]
#text(font: font_sans, weight: "extrabold")[ゴシック体]
#text(font: font_sans, weight: "black")[ゴシック体]
=== Headings

Headings use the `=` symbol:



```typst
= Level 1 Heading
== Level 2 Heading
=== Level 3 Heading
```

== Lists

=== Unordered Lists


```typst
- First item
- Second item
- Third item
```

- First item
- Second item
- Third item
=== Ordered Lists



```typst
+ First step
+ Second step
+ Third step
```

Result:
+ First step
+ Second step
+ Third step


=== Description



```typst
/ 日本: #[東工大パワー丼]
/ インド: #[ビリヤニ]
```

/ 日本: #[東工大パワー丼]
/ インド: #[ビリヤニ]


== Mathematics

Typst has excellent math support. Use `$...$` for inline math and `$ ... $` (with spaces) for display math.

=== Inline Math



```typst
The famous equation $E = m c^2$ changed physics.
```

Result: The famous equation $E = m c^2$ changed physics.

#info[
日本語の場合でも、数式の前後に半角スペースを入れる必要があります。In typst v0.14.1. See #link("https://qiita.com/zr_tex8r/items/a9d82669881d8442b574")[this] for more information.
]

```typst
パワー丼$x$杯を食べました。
パワー丼 $x$ 杯を食べました。
```

パワー丼$x$杯を食べました。

パワー丼 $x$ 杯を食べました。


=== Display Math


```typst
$ integral_0^infinity e^(-x^2) dif x = sqrt(pi)/2 $
```

Result:
$ integral_0^infinity e^(-x^2) dif x = sqrt(pi)/2 $<eq:einstein>

@eq:einstein


=== More Math Examples



```typst
$ sum_(n=1)^infinity 1/n^2 = pi^2/6 $

$ mat(1, 2; 3, 4) times vec(x, y) = vec(a, b) $
```

Results:
$ sum_(n=1)^infinity 1/n^2 = pi^2/6 $

$ mat(1, 2; 3, 4) times vec(x, y) = vec(a, b) $

#v(1em)

== Images and Figures


=== Figures with Captions



```typst
#figure(
  image("diagram.png", width: 80%),
  caption: [Architecture diagram of the system],
)
```

#figure(
  image("../gfx/example_1.jpg", width: 60%),
  caption: [Architecture diagram of the system],
)<fig:test>

=== Two Figures


```typst
#figure(
  grid(
    columns: 2,
    gutter: 1em,
    subfigure(
      image("../gfx/example_1.jpg", width: 100%),
      "(a) First"
    ),
    subfigure(
      image("../gfx/example_2.jpg", width: 100%),
      "(b) Second"
    ),
  ),
  caption: [Two figures side by side]
)
```




#figure(
  grid(
    columns: 2,
    gutter: 1em,
    subfigure(
      image("../gfx/example_1.jpg", width: 100%),
      "(a) First"
    ),
    subfigure(
      image("../gfx/example_2.jpg", width: 100%),
      "(b) Second"
    ),
  ),
  caption: [Two figures side by side]
)


=== Four Figures

```typst
#figure(
  grid(
    columns: 2,
    rows: 2,
    gutter: 1em,
    row-gutter: 1.5em,
    subfigure(image("../gfx/example_1.jpg", width: 100%), "(a) Top left"),
    subfigure(image("../gfx/example_2.jpg", width: 100%), "(b) Top right"),
    subfigure(image("../gfx/example_3.jpg", width: 100%), "(c) Bottom left"),
    subfigure(image("../gfx/example_4.jpg", width: 100%), "(d) Bottom right"),
  ),
  caption: [Four figures in 2×2 layout],
)
```

#figure(
  grid(
    columns: 2,
    rows: 2,
    gutter: 1em,
    row-gutter: 1.5em,
    subfigure(image("../gfx/example_1.jpg", width: 100%), "(a) Top left"),
    subfigure(image("../gfx/example_2.jpg", width: 100%), "(b) Top right"),
    subfigure(image("../gfx/example_3.jpg", width: 100%), "(c) Bottom left"),
    subfigure(image("../gfx/example_4.jpg", width: 100%), "(d) Bottom right"),
  ),
  caption: [Four figures in 2×2 layout],
)






== Code Blocks

=== Inline Code


```typst
Use backticks for inline code: `let x = 42`

```

Use backticks for inline code: `let x = 42`




=== Code Blocks with Syntax Highlighting



```python
def greet(name):
    return f"Hello, {name}!"
print(greet("World"))
```



== Citation


```typst
#citet(<ArticleENsamename>)
#citep(<ArticleENsamename>)
#citeauthor(<ArticleENsamename>) 
#citeyear(<ArticleENsamename>) 
//@ArticleENsamename //// bib-setting-plainとbib-setting-jsmeを使う場合、@を使って引用箇所に通し番号をつける。
```
  


#citet(<InbookEN>)

#citep(<InbookEN>)

#citeauthor(<InbookEN>) 

#citeyear(<InbookEN>) 


== Citation Style <sec:citationstyle>


The standard `enja-bib` package includes styles like IEEE and SIST 02. However, I have modified the source code in this template specifically to support the #Gls("apa")/#Gls("jpa") format. If you wish to use a different citation style (IEEE or SIST 02), please open `lib.typ`. I have included instructions in the code comments on how to switch from the custom settings to the standard package styles.

```typst
// =========================================================================
// CITATION & BIBLIOGRAPHY SETTINGS
// =========================================================================

// --- Option A: Default (APA 7th + JPA 2022) ---
// This uses the customized local version located in the 'src' folder.
// If you want to use IEEE or SIST 02, COMMENT OUT the following two lines:
#import "src/biblib.typ": *
#import bib-setting-apa: *


// --- Option B: Standard Styles (IEEE or SIST 02) ---
// To use these, comment out the Option A lines above, and UNCOMMENT the 
// lines below. You must also comment out the 'src' import above.

// 1. Import the standard package
// #import "@preview/enja-bib:0.1.0": *

// 2. Choose your style (Uncomment ONE):
// #import bib-setting-plain: * // IEEE-like style
// #import bib-setting-jsme: * // SIST 02 style
// See https://github.com/tkrhsmt/enja-bib for more information.
// =========================================================================

```


== bibファイルの書き方

`bib/test_all_types.bib`か、下記のリンクを参考にしてください。

https://github.com/ShiroTakeda/jecon-bst/blob/master/jecon-example.bib


=== 英語文献

標準的な BibTeX フォーマットに従って参考文献エントリを作成してください。`lang = {en}`は入れなくても構わない。

```bib
@article{ArticleEN,
  author = {Smith, John and Doe, Jane and Brown, Robert},
  title = {A comprehensive study of wind tunnel effects near the Main Building slope},
  journal = {Journal of Titech Architecture},
  year = {2023},
  volume = {15},
  number = {3},
  pages = {123--145},
  doi = {10.1234/jai.2023.0001},
  lang = {en}
}
```


=== 日本語の文献



```bib
@article{ArticleJA,
  author = {田中, 太郎 and 鈴木, 花子 and 佐藤, 次郎},
  yomi = {Tanaka, Taro and Suzuki, Hanako and Sato, Jiro},
  title = {大岡山キャンパスにおける猫の生息分布調査},
  journal = {東工大生物学研究},
  year = {2023},
  volume = {94},
  number = {2},
  pages = {100--120},
  doi = {10.1234/ja.2024.0001},
  lang = {ja}
}
```
#memo[
`yomi`と`lang = {ja}`を入れてください。
]
== Custom Colors




```typst
#text(fill: blue)[This text is blue]
#text(fill: rgb("#ff6600"))[This is orange]
#highlight(fill: yellow)[Highlighted text]
```
  


Result:
#text(fill: blue)[This text is blue] •
#text(fill: rgb("#ff6600"))[This is orange] •
#highlight(fill: yellow)[Highlighted text]






== Links and References

=== Hyperlinks



```typst
Visit #link("https://typst.app")[Typst's website]
```

Result: Visit #link("https://www.sankei.com/article/20210915-6LED2WGCSBJEHACQU4FUCHFF5Y/")[パワー丼！]

=== Cross-References <sec:crossref>




```typst
= Introduction <ch:intro> // Do not forget to add the <ch:intro> label

As mentioned in @ch:intro, we begin here.

@sec:crossref
@fig:test
@tab:example
@tab:metrics
```
  

As mentioned in @ch:intro, we begin here.

@sec:crossref;
@fig:test;
@tab:example;
@tab:metrics

== Tables


#figure(
  table(
    columns: (auto, 1fr),
    stroke: none,
    inset: 8pt,
    align: (left, left),
    table.hline(stroke: 1pt),
    [*列 1*], [*列 2 (可変幅)*],
    table.hline(stroke: 0.5pt),
    [項目 A], [項目 A の説明。長くなる場合は次の行に折り返されます。長くなる場合は次の行に折り返されます。長くなる場合は次の行に折り返されます。],
    [項目 B], [項目 B の説明。],
    table.hline(stroke: 1pt),
  ),
  caption: [表の例],
) <tab:example>


// ============================================
// Table 2: Electronics Inventory
// ============================================


Use #link("https://typst.app/universe/package/zero")[zero] package to achieve proper number formatting.


#figure(
  {
    show: format-table(auto, auto, auto, auto)  // (製品, カテゴリ, 在庫, 価格)
    table(
      columns: (auto, auto, auto, auto),
      stroke: none,
      inset: 6pt,
      table.hline(stroke: 1pt),
      [*製品*], [*カテゴリ*], [*在庫*], [*価格 (\$)*],
      table.hline(stroke: 0.5pt),
      [MacBook Pro 16"], [Laptop], [45], [2499],
      [Dell XPS 15], [Laptop], [32], [1799],
      [ThinkPad X1 Carbon], [Laptop], [28], [1899],
      table.hline(stroke: 0.5pt),
      [Magic Mouse 2], [Accessory], [156], [79],
      [Logitech MX Master 3], [Accessory], [203], [99],
      [Razer DeathAdder V2], [Accessory], [87], [69],
      table.hline(stroke: 0.5pt),
      [Mechanical Keyboard], [Peripheral], [64], [129],
      [Wireless Keyboard], [Peripheral], [91], [59],
      [Gaming Keyboard RGB], [Peripheral], [43], [159],
      table.hline(stroke: 0.5pt),
      [27" 4K Monitor], [Display], [38], [549],
      [34" Ultrawide Monitor], [Display], [22], [899],
      [32" Gaming Monitor], [Display], [29], [699],
      table.hline(stroke: 0.5pt),
      [USB-C Hub], [Adapter], [245], [49],
      [Thunderbolt Dock], [Adapter], [67], [279],
      [HDMI Cable 10ft], [Cable], [412], [15],
      table.hline(stroke: 1pt),
    )
  },
  caption: [電子機器在庫表],
) <tab:inventory>

// ============================================
// Table 3
// ============================================

#figure(
  // We open a code block to group the table AND the note together
  {
    ztable(
      columns: (1fr, auto, auto, auto, auto, auto, auto),
      align: (left, center, center, center, center, center, center),
      inset: 8pt,
      stroke: none,
      format: (none, (digits: 2), (digits: 2), (digits: 2), none, (digits: 2), (digits: 2)),
      
      // --- Header ---
      table.header(
        table.hline(stroke: 1pt),
        table.cell(rowspan: 2, align: left + horizon)[*Predictor*], 
        table.cell(rowspan: 2, align: center + horizon)[$B$], 
        table.cell(rowspan: 2, align: center + horizon)[$"SE"$],  
        table.cell(rowspan: 2, align: center + horizon)[$beta$], 
        table.cell(rowspan: 2, align: center + horizon)[$p$], 
        table.cell(colspan: 2)[$95% "CI"$],
        [$"LL"$], [$"UL"$],
        table.hline(stroke: 0.5pt),
      ),

      // --- Model 1 ---
      table.cell(colspan: 7, fill: luma(245), align: left)[*Model 1*],
      [Constant],       [5.12], [0.41], [-0.22],   [#hide($<$)#no-lead(0.002)], [4.31], [5.92],
      [Age],            [-0.04],[0.01], [-0.11],[#hide($<$)#no-lead(0.124)], [-0.06], [0.02],
      
      // --- Model 2 ---
      table.cell(colspan: 7, fill: luma(245), align: left)[*Model 2*],
      [Education],      [2.15], [0.52], [0.31], [$<$#no-lead(0.001)], [1.13], [3.17],
      [Work Stress],    [-0.85],[0.15], [-0.42],[$<$#no-lead(0.001)], [-1.14], [-0.56],

      table.hline(stroke: 1pt),
    )

    // --- The Note (Outside the table, inside the figure) ---
    v(6pt) // A little breathing room
    set align(left)
    set par(first-line-indent: 0pt)
    text(size: 9pt)[
      _Note._ $N$ = 450. 
      $"CI"$ = confidence interval; 
      $"LL"$ = lower limit; 
      $"UL"$ = upper limit; 
      $"SE"$ = standard error; 
      $beta$ = standardized regression coefficient.
    ]
  },
  caption: [Hierarchical Multiple Regression Analysis Predicting Job Satisfaction.],
) <tab:metrics>



== Margin Note


```typst
#note[This appears in the outer margin!]
#note(counter: none)[No number on this note]
#note(side: "inner")[This goes on the inside margin]
#wideblock[This goes outside the text area.]
```
  


#wideblock[This goes outside #box(line(length: 12cm)) the text area.]

This is main text#note[This appears in the outer margin!]#note(side: "inner")[This goes on the inside margin].

I don't know much about the usage of margin note#note(counter: none)[No number on this note]. Please read the #link("https://typst.app/universe/package/marginalia")[manual].





== Draft mode

When draft mode is enabled, the To-Do and Version History pages will be displayed at the very beginning of the document. 

ドラフトモードが有効な場合、To-Doリストとバージョン履歴ページが冒頭に表示されます。



In `config.typ`, 

```typ
// Draft Mode Toggle
#let draft = true // Draft mode on
//#let draft = false // Draft mode off
```


Add the changelog in `changelog_data.typ`
== ToDo Note



```typ
#noteil[Note 1]
#todoil[In line todo 1]
#todo[Margin Todo 1]
#noteil(done:true)[Note 2]
#todoil(done:true)[In line todo 2]
#todo(done:true)[Margin todo 2]
```

#noteil[Note 1]
#todoil[In line todo 1]
#todo[Margin Todo 1]
#noteil(done:true)[Note 2]
#todoil(done:true)[In line todo 2]
#todo(done:true)[Margin todo 2]


If the setting of note/ToDo function is set to `done:true`, the item will be hidden from the main text of the PDF, but it will still appear in the To-Do List with a strikethrough line. This feature works for `#noteil`, `#todoil`, `#todo`, and `#feedback`.

== Footnote


```typst
吾輩は🐈#footnote[毎日パワー丼を食べる。]である。
```
  

吾輩は🐈#footnote[毎日パワー丼を食べる。]である。

== Other Languages

You can use most language in Typst. If the language is supported by the Google Noto font family, it will work#note[多分？].

#v(1em)
// Simplified Chinese (SC)
*Simplified Chinese*

#set text(font: "Noto Serif CJK SC")
人人生而自由，在尊严和权利上一律平等。他们赋有理性和良心，并应以兄弟关系的精神相对待。

#v(1em)

// Traditional Chinese (TC)
*Traditional Chinese*

#set text(font: "Noto Serif CJK TC")
人人生而自由，在尊嚴和權利上一律平等。他們賦有理性和良心，並應以兄弟關係的精神相對待。

#v(1em)

// Japanese (JP)
*Japanese*

#set text(font: "Noto Serif CJK JP")
すべての人間は、生れながらにして自由であり、かつ、尊厳と権利とについて平等である。人間は、理性と良心とを授けられており、互いに同胞の精神をもって行動しなければならない。


#v(1em)

// Korean (KR)
*Korean*

#set text(font: "Noto Serif CJK KR")
모든 인간은 태어날 때부터 자유로우며 그 존엄과 권리에 있어 동등하다. 인간은 천부적으로 이성과 양심을 부여받았으며 서로 형제애의 정신으로 행동하여야 한다.
#v(1em)

//*Russian (Cyrillic)*
//#set text(font: "Noto Serif", lang: "ru")
//Все люди рождаются свободными и равными в своем достоинстве и правах. Они наделены разумом и совестью и должны поступать в отношении друг друга в духе братства.

//#v(1em)

//*Greek (Greek)*
//#set text(font: "Noto Serif", lang: "el")
//Όλοι οι άνθρωποι γεννιούνται ελεύθεροι και ίσοι στην αξιοπρέπεια και τα δικαιώματα. Είναι προικισμένοι με λογική και συνείδηση, και οφείλουν να συμπεριφέρονται μεταξύ τους με πνεύμα αδελφοσύνης.

//#v(1em)

//*Vietnamese (Latin Extended)*
//#set text(font: "Noto Serif", lang: "vi")
//Tất cả mọi người sinh ra đều được tự do và bình đẳng về nhân phẩm và quyền. Mọi người đều được tạo hóa ban cho lý trí và lương tâm và cần phải đối xử với nhau trong tình bằng hữu.

//#v(1em)

== Abbreviations

1. Define abbreviations in `frontmatter/abbreviations.typ`:



```typst
 #let abbreviation-list = (
   (key: "api", short: "API", long: "Application Programming Interface"),
   (key: "html", short: "HTML", long: "HyperText Markup Language"),
// )

```
  



2. Use in your text:



```typst
// Basic reference (first use shows full form, subsequent shows short)
The #Gls("api") enables communication between systems.

// Plural form
Multiple #glspl("api") can be integrated.

// Capitalized (for start of sentence)
#Gls("html") is used for web pages.

// Capitalized plural
#Glspl("html") documents are common.

// Alternative: use label syntax
The @tpd is widely adopted.  // same as #gls("tpd")
The @css are evolving.   // same as #glspl("css")
```
  

#v(1em)
// Basic reference (first use shows full form, subsequent shows short)
The #Gls("api") enables communication between systems.

// Plural form
Multiple #glspl("api") can be integrated.

// Capitalized (for start of sentence)
#Gls("html") is used for web pages.

// Capitalized plural
#Glspl("html") documents are common.

// Alternative: use label syntax
The @tpd is widely adopted.  // same as #gls("tpd")
The @css are evolving.   // same as #glspl("css")


#v(1em)
#table(
  columns: (auto, 1fr),
  inset: 12pt,
  align: horizon,
  stroke: none, // Removes the grid lines for a cleaner look
  fill: (col, row) => if row == 0 {
    rgb("#263238") // Dark Blue-Grey Header
  } else if calc.even(row) {
    rgb("#f5f5f5") // Light Grey Stripe
  } else {
    white
  },
  
  // Header
  table.header(
    text(fill: white, weight: "bold")[Function],
    text(fill: white, weight: "bold")[Description],
  ),

  // Content
  raw("#gls(\"key\")", lang: "typ"),   [Normal reference],
  raw("#glspl(\"key\")", lang: "typ"),  [Plural reference],
  raw("#Gls(\"key\")", lang: "typ"),   [Capitalized reference],
  raw("#Glspl(\"key\")", lang: "typ"),  [Capitalized plural reference],
  raw("@key", lang: "typ"),           [Label syntax (= gls)],
  raw("@key:pl", lang: "typ"),        [Label syntax plural (= glspl)],
)



== Feedback


```typst
#feedback(done:true)[   //pdfでは表示されません。
  パワー丼を食べてください。// add feedback here
][
  食べました。// add response here
]

#feedback[
  パワー丼をもう一杯食べてください。// add feedback here
][
  食べます。// add response here
]
```

#feedback(done:true)[   //pdfでは表示されません。
  パワー丼を食べてください。
][
  食べました。
]


#feedback[
  パワー丼をもう一杯食べてください。 
][
  食べます。
]



== Japanese Ruby (Furigana) support
This template does not include built-in support for Ruby text. If you need to add Furigana to your Japanese text, I recommend importing one of the following packages:

- #link("https://typst.app/universe/package/rubby")[*rubby*]: Provides standard, manual control for adding ruby.
- #link("https://typst.app/universe/package/auto-jrubby")[*auto-jrubby*]: Provides automatic ruby generation.

== Troubleshooting: "Layout Did Not Converge"
Because this template uses an asymmetric "book" layout (where inner and outer margins differ), text width changes depending on whether it is on an odd or even page.

Occasionally, a paragraph or block may land exactly on a page boundary, causing Typst to enter an infinite loop of resizing and moving the text back and forth. This results in the error: `layout did not converge within 5 attempts`.

*The Solution:*
If you encounter this error, simply force a fresh page start by adding a `#pagebreak()` command immediately before the text or section causing the crash.