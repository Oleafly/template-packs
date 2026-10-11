//! 中文期末作业用论文 Typst 模板

// | 中文字号 | 英文字号（磅）/pt | 毫米/mm | 像素/px |
// | -------- | ----------------- | ------- | ------- |
// | 初号     | 42                | 14.82   | 56      |
// | 小初     | 36                | 12.7    | 48      |
// | 一号     | 26                | 9.17    | 34.7    |
// | 小一     | 24                | 8.47    | 32      |
// | 二号     | 22                | 7.76    | 29.3    |
// | 小二     | 18                | 6.35    | 24      |
// | 三号     | 16                | 5.64    | 21.3    |
// | 小三     | 15                | 5.29    | 20      |
// | 四号     | 14                | 4.94    | 18.7    |
// | 小四     | 12                | 4.23    | 16      |
// | 五号     | 10.5              | 3.7     | 14      |
// | 小五     | 9                 | 3.18    | 12      |
// | 六号     | 7.5               | 2.56    | 10      |
// | 小六     | 6.5               | 2.29    | 8.7     |
// | 七号     | 5.5               | 1.94    | 7.3     |
// | 八号     | 5                 | 1.76    | 6.7     |
#import "@preview/zh-kit:0.1.0": *

#let 字体 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  八号: 5pt,
)

#let MAIN_BOLDABLE_ZH_FONT = "Source Han Serif SC"

#let default-font-config = (
  size: 字体.五号, // 五号字
  bold-font: ("Times New Roman", "Source Han Serif SC"),
  cjk-serif-family: ("Times New Roman", "Source Han Serif SC"),
  latin-serif-family: ("Times New Roman", "Noto Serif"),
)

#let homework-paper(
  title: "",
  authors: (),
  keywords: none,
  font: default-font-config,
  paper: "a4",
  enable-outline: false,
) = {
  let hw-top-fields = state("hw-top-fields", ())

  let font = default-font-config + font

  let field(name, body) = {
    hw-top-fields.update(old => (..old, (name, body)))
  }

  let display(body) = {
    set page(paper: paper)

    // override setup-base-font's bold override
    show strong: x => {
      set text(font: ("Times New Roman", MAIN_BOLDABLE_ZH_FONT))
      x
    }

    show heading: x => {
      set text(font: ("Times New Roman", MAIN_BOLDABLE_ZH_FONT))
      x
    }

    show: setup-base-fonts.with(
      cjk-serif-family: font.cjk-serif-family,
      latin-serif-family: font.latin-serif-family,
    )

    set text(size: font.size)
    set par(spacing: font.size * 1.5, leading: font.size * 1.5)
    set list(spacing: 9pt)
    set enum(spacing: 9pt)

    set heading(numbering: (..nums) => {
      let depth = nums.pos().len()
      if depth == 1 {
        return numbering("一、", nums.at(0))
      } else if depth == 2 {
        return numbering("（一）、", nums.at(1))
      } else {
        let (_1, _2, ..counts) = nums.pos()
        return numbering("1.", ..counts)
      }
    })

    show heading: it => [
      #if (it.depth > 2) {
        pad(it, left: it.depth * 5pt)
      } else {
        it
      }
    ]

    show heading: it => {
      v(5pt)
      it
      v(2pt + (3 - it.level) * 1pt)
    }

    show ref: it => {
      set text(fill: color.rgb(128, 0, 0))
      it
    }

    // Helper function to display string or content
    let display-field(field) = {
      if type(field) == content { field } else if type(field) == str { text(field) } // Use 'str' for string type
      else { () } // Handle other types or empty if necessary
    }

    {
      set align(center)

      if title != () {
        v(4em)
        set text(size: 字体.三号) // 五号
        strong(display-field(title))
      }

      if authors != () {
        let author-content = ()

        for author in authors {
          author-content.push(
            [
              #set text(size: 12pt, weight: "bold")
              #display-field(author.number + "  ")
              #display-field(author.name)
              // Display email based on type (handle string as link, content directly)
              #if "email" in author {
                if type(author.email) == content {
                  author.email
                } else if type(author.email) == str {
                  // Use 'str' for string type
                  link("mailto:" + author.email)[#author.email]
                }
              }
              #if "department" in author {
                display-field("  " + author.department)
              }
            ],
          )
        }

        table(
          columns: authors.len(),
          align: center,
          stroke: 0em,
          inset: (
            x: 20pt,
          ),
          ..author-content
        )
      }
    }


    context {
      set par(first-line-indent: 0em, spacing: 1em)

      let fields = hw-top-fields.final()

      let names = fields.map(it => it.at(0))
      let max-name-len = calc.max(..names.map(it => it.clusters().len()), 0)

      for (name, body) in fields {
        let name-len = name.clusters().len()
        v(0.75em)
        set align(left)
        set par(spacing: font.size * 1.5, leading: font.size * 1.5)
        strong([#text(name, tracking: ((max-name-len - name-len) / (name-len - 1)) * 1em)：])
        // Iterate and display keywords based on type, joining with "；"
        body
      }
    }
    
    if enable-outline {
      show outline.entry: it => {
        set text(fill: color.rgb(128, 0, 0))
        it
      }

      show outline.entry.where(level: 1): it => {
        v(0.75em)
        strong(it)
      }


      set align(center)
      outline(title: [目#h(1em)录], indent: 1em)
    }

    body
  }

  return (display: display, field: field)
}
