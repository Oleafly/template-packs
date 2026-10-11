#let problem_counter = counter("problem")

#let template(doc) = [
  #set page(
    paper: "a4",
    margin: (
      top: 1cm, 
      left: 1cm,
      right: 1cm,
      bottom: 1.75cm),
  )
  #set text(
    font: "New Computer Modern",
    lang: "ru",
  )
  #set par(
    justify: true,
  )
  #set math.mat(
    column-gap: .8em,
    row-gap: .8em,
  )
  #show sym.lt.eq: sym.lt.eq.slant
  #show sym.gt.eq: sym.gt.eq.slant
  #doc
]

// modificated by lil4rain, fixed issues with locate function [deprecated]
#let footer_header(title, author, course, due_time, group, body) = {
  set page(
    footer: context {
      let cur_page = counter(page).get().first()
      if (cur_page != 1) {
        let total_pages = context[#counter(page).final().at(0)]
        line(length: 100%)
        [Стр. #cur_page из #total_pages ]
        [#h(1fr) #author | #course: #title] 
      }
    },
  )
  body
}

#let title_page(title, author, course, due_time, group, body) = {
  block(
    height:20%,
    fill:none
  )
  align(center, text(20pt)[*#course*])
  align(center, text(17pt)[*#title*])
  align(center, [Дедлайн: #due_time])
  block(
    height: 30%, 
    fill: none
  )
  align(center, text(16pt)[*#author*])
  align(center, text(11pt)[*#group*])
  pagebreak(weak: false)
  body
}

#let problem(name: none, body) = {
  if name != none {
  }
  [= Задание #name.]
  block(
    fill:rgb(240, 240, 255),
    width: 100%,
    inset:8pt,
    radius: 4pt,
    body
  )
}

#let solution(no_header: false, body) = {
  if not no_header {
    [== Решение:]
  } else {
    none
  }
  line(length: 100%)
  block(
    fill: rgb(240, 255, 240),
    width: 100%,
    inset: 8pt,
    radius: 4pt,
    body
  )
}

#let answer(type: "answer", no_header: false, body) = {
  let title = none;
  if type == "result" {
    title = [Итого:]
  } else if type == "answer" {
    title = [Ответ:]
  }
  if not no_header {
    [== #title]
    line(length: 100%)
  }
  block(
    fill: rgb(240, 240, 255),
    width: 100%,
    inset: 8pt,
    radius: 4pt,
    [#body]
  )
}

#let intlim(l, r) = $cases(delim: "|", #h(0pt)^#r, #v(6pt), #h(0pt)_#l)$
#let pr = math.op("pr")
#let ort = math.op("ort")
#let vol = math.op("vol")
#let ord = math.op("ord")
#let Spec = math.op("Spec")
#let linspan(..args) = {
  let input = args.pos()

  math.angle.l
  for i in range(input.len() - 1) {
    input.at(i)
    math.comma
    math.thick
  }
  input.at(-1)
  math.angle.r
}


// Custom symbols and modified functions by lilrain
#let squarebox(body) = {
  align(
    center,
    [
      #rect([
        #body
      ])
    ]
  )
}

#let dels = $space dots.v space$
#let delsnot = $space  cancel(dots.v) space$
#let Enc = {
  $ serif("Enc") $
}
#let arctg(x) = {
  $ serif("arctg"(#x)) $
}
#let QR(n) = {
  $ serif("QR"(#n)) $
}
#let GDH(p, m, ma, mb) = {
  $ serif("GDH"(#p, #m, #ma, #mb)) $
}
#let DH(p, g, ga, gb) = {
  $ serif("DH"(#p, #g, #ga, #gb)) $
}
#let Pass(p, m1, m2, m3) = {
  $ serif("Pass"(#p, #m1, #m2, #m3)) $
}
