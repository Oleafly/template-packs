#let problem_counter = counter("problem")

#let template(doc) = [
  #set page(
    paper: "a4",
    margin: (
      top: 1cm, 
      left: 1cm,
      right: 1cm,
      bottom: 1cm),
  )
  #set text(
    lang: "ru",
  )
  #set par(
    justify: false,
  )
  #set math.mat(
    column-gap: .8em,
    row-gap: .8em,
  )
  #show sym.qed: sym.square
  #show sym.emptyset: sym.nothing
  #doc
]

#let footer_header(title, author, course, due_time, group, body) = {
  set page(
    footer: context{
      let current_page = counter(page).get().first()
      if current_page == 1 {
        none
      } else {
        let total_pages = counter(page).final().first()
        [Стр. #current_page из #total_pages]
        [#h(1fr)#author | #course: #title]
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
  align(center, text(16pt)[*#title*])
  align(center, text(12pt)[Дедлайн: #due_time])
  block(
    height: 30%, 
    fill: none
  )
  align(center, text(16pt)[*#author*])
  align(center, text(12pt)[#group])
  pagebreak(weak: false)
  body
}

#let problem(name: none, body) = {
  if name != none {
    name = " (" + name + ")"
  }
  problem_counter.step()
  [= Задание #context{problem_counter.display()}#name.]
  block(
    fill:rgb(240, 240, 255),
    stroke: (
      top: black,
      bottom: black,
    ),
    width: 100%,
    inset:8pt,

    body
  )
}

#let solution(no_header: false, body) = {
  if not no_header {
    [== Решение:]
  } else {
    none
  }
  block(
    fill: rgb(240, 255, 240),
    stroke: (
      top: black,
      bottom: black,
    ),
    width: 100%,
    inset: 8pt,
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
  }
  block(
    fill: rgb(240, 240, 255),
    stroke: (
      top: black,
      bottom: black,
    ),
    width: 100%,
    inset: 8pt,
    body
  )
}

#let intlim(l, r) = $cases(delim: "|", #h(0pt)^#r, #v(6pt), #h(0pt)_#l)$
#let rk = math.op("rk")
#let pr = math.op("pr")
#let ort = math.op("ort")
#let vol = math.op("vol")
#let ord = math.op("ord")
#let Spec = math.op("Spec")
#let Var = math.op("Var")
#let Cov = math.op("Cov")
#let Corr = math.op("Corr")
#let plim = math.op("plim")

#let linspan(..args) = {
  let vectors = args.pos()
  math.angle.l
  for i in range(vectors.len() - 1) {
    vectors.at(i)
    math.comma
    math.thick
  }
  vectors.at(-1)
  math.angle.r
}
