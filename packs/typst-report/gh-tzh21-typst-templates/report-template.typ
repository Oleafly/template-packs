#set page(
  footer: context [
    #set align(center)
    #set text(8pt)
    #counter(page).display(
      "1 / 1",
      both: true,
    )
  ]
)

#set text(lang: "zh", font: "Source Han Serif")
#set text(top-edge: 1em)
#show raw: set text(top-edge: 1em)

#let title_style(content) = {
  set align(center)
  set text(size: 18pt, weight: "bold")
  content
}

#let subtitle_style(content) = {
  set align(center)
  set text(size: 15pt)
  content
}

#set heading(numbering: "1.1.1.")
#show heading.where(level: 1): set text(size: 20pt)
#show heading.where(level: 2): set text(size: 16pt)
#show heading.where(level: 3): set text(size: 14pt)

#title_style[
RUDRA: Finding Memory Safety Bugs in Rust
at the Ecosystem Scale 阅读报告
]

#subtitle_style[
唐子涵 2021013540
]

= 选题说明

= 论文的解决方法

== Bug类型