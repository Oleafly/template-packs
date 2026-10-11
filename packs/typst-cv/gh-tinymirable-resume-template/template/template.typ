#import "icons.typ": *;
#let font = (
  main: "IBM Plex Serif",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif CJK SC",
  lxgw : "LXGW WenKai TC",
  san:"Noto Sans CJK",
  fzkai-b: "FZCuKaiS-R-GB",
  tn : "Times New Roman",
  fzkai: "FZKai-Z03S"
)
#let template(doc) = {
    set page(
        margin: (x: 0.9cm, y: 1.3cm),
        paper: "a4",
    )
    set text(
        size: 11pt,
        font: (font.tn, font.fzkai),
        lang: "zh"
    )
    set enum(numbering: "1)",number-align:horizon)
    show strong: it => text(
    font: (font.tn, font.fzkai-b),
    weight: "bold",
    it  
    )
    show link: text
    show heading.where(level: 2): set text(size:14pt,fill: rgb("#292478"),font : font.fzkai-b)
//     show list: it => stack(
//     spacing: 0.4em,
//     ..it.children.map(item => {
//       grid(
//         columns: (2em, 1fr),
//         gutter: 0em,
//         box({
//           h(0.75em)
//           fa-angle-right
//         }),
//         pad(top: 0.15em, item.body),
//       )
//     }),
//   )
    set par(
        justify: true,
        leading: 0.4em
    )
    doc
}

#let init(
    name: lorem(3),
    pic_path: "",
) = {
    set document(
        title: name + "'s Resume",
        author: name,
    )
    set align(
        center,
    )
    text(
        style: "normal",
        weight: "extrabold",
        size: 20pt,
        font: font.cjk
    )[#name]
    if pic_path != "" {
        // insert picture
        place(
            top + right,
            dy: -2em,
            image(
                pic_path,
                height: 33mm,
            )
        )
    }
    v(-1em)
    set align(left)

}
#let date(body) = align(center + bottom,emph(text(font:(font.main,font.lxgw))[*#body*]))
#let info(
    color: rgb("#000000"),
    ..infos
) = {
    set text(
        fill: color,
        // size: 10pt,
    )
    set align(
        center,
    )
    infos.pos().map(dir => {
        box(
            height: 0.5em,
            {
            if "icon" in dir {
                if (type(dir.icon) == str) {
                    icon(dir.icon)
                } else {
                    dir.icon
                }
            }
            h(0.15em)
            if "link" in dir {
                link(dir.link, dir.content)
            } else {
                dir.content
            }
        })
    }).join(h(1em) + h(3em))
    // v(0em)
}

#let chiline() = {v(-3pt); line(length: 100%,stroke: 1.2pt); v(-5pt)}




#let resume_section(title) = {
    [== #title]
    chiline()
}

// #let resume_item(proj_title, proj_time, proj_postion, proj_rule) = {
//     [ *#proj_title*]
//     h(1fr)
//     if proj_time != none {
//         date([#proj_time])
//         // emph(text(font:font.main)[*#proj_time*])
//     }
//     if proj_postion != none or proj_rule != none {
//         linebreak()
//     }   
//     if proj_postion != none {
//         [#proj_postion]
//     }
//     h(1fr)
//     if(proj_rule != none) {
//         [#proj_rule]
//     }
//     linebreak()
// }
#let resume_item(proj_title, proj_time) = {
    [ *#proj_title*]
    h(1fr)
    if proj_time != none {
        date([#proj_time])
        // emph(text(font:font.main)[*#proj_time*])
    }
}

#let resume_desc(l, r) = {
    v(-0.3em)
    [- *#l*: #r]
}

#let ed-item(
  title,
  desc,
  endnote,
) = {
  v(-0.6em)
  grid(
    columns: (30%, 1fr, auto),
    gutter: 0em,
    title, desc, endnote,
  )
}


#let item(
  title,
  desc,
  endnote,
) = {
  v(-0.3em)
  grid(
    columns: (1.5fr, 1fr, auto),
    title, desc, endnote,
  )
  v(-0.5em)
}

#let tech(body) = block({
//   set text(weight: "extralight")
  body
})

