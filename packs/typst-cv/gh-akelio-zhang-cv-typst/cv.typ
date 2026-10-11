#let render_mode = (
  la: sys.inputs.at("la", default: "zh"),
  output: sys.inputs.at("output", default: "concise")
)

#import "meta.typ": *

#set text(font: ("New Computer Modern", "Source Han Serif SC"))
#show heading: set text(font: ("Linux Biolinum", "Source Han Serif SC"))

#show link: underline


// Uncomment the following lines to adjust the size of text
// The recommend resume text size is from `10pt` to `12pt`
// #set text(
//   size: 12pt,
// )

// Custom heading color: https://typst.app/docs/reference/visualize/color/
#let head_color = black

// Feel free to change the margin below to best fit your own CV
#set page(margin: (x: 0.9cm, y: 1.3cm))

// For more customizable options, please refer to official reference: https://typst.app/docs/reference/
#set par(justify: true)
#show heading: set text(fill: head_color)

#let chiline() = {
  v(-3pt)
  line(length: 100%, stroke: head_color)
  v(-5pt)
}

// support language and output render mode switch
#let section(body, la: "zh", output: "concise") = {
  let mode = (la: la, output: output)
  if (
    mode.la == render_mode.la
      and (mode.output == "concise" or mode.output == render_mode.output)
  ) [
    #body
  ]
}

// 加载多语言数据
#let lang = render_mode.la
#let data = yaml("data-" + lang + ".yaml")

// 通用条目渲染器
#let render_entry(entry) = {
  let output_filter = "concise"
  if "output" in entry {
    output_filter = entry.output
  }
  if output_filter != "concise" and output_filter != render_mode.output {
    return
  }

  [
    #if "name" in entry [
      *#entry.name* #h(1fr)
    ]
    #if "date" in entry [
      #entry.date
    ]
    #if "desc" in entry [
      \ #entry.desc #h(1fr)
    ]
    #if "location" in entry [
      #entry.location
    ]
    #if "details" in entry {
      for detail in entry.details [
        - #detail
      ]
    }
  ]
}

// 联系方式渲染
#let render_contact() = [
  = #data.contact.name
  #data.contact.email |
  #data.contact.phone |
  #link(data.contact.github.url)[#data.contact.github.text]
]

// 模块化section渲染
#let render_section(module) = {
  if module == none { return }
  if module.at("entries", default: none) == none { return }

  [
    == #module.title
    #chiline()
    #for entry in module.entries [
      #render_entry(entry)
    ]
  ]
}

// 主文档结构
#render_contact()
#for s in data.sections [
  #if s.at("render", default: true) [
    #render_section(data.at(s.key, default: none))
  ]
]

#section[
  #align(right, text(fill: gray)[更新于 #today()])
]
#section(la: "en")[
  #align(right, text(fill: gray)[Last Updated on #today_en()])
]
