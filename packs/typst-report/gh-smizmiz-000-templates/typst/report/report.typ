#import "@preview/physica:0.9.5":*
#import "@preview/ez-today:1.1.0"
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#set page(numbering: "1")
#set heading(numbering: "1.1")
#show heading.where(level:1): it => {
  counter(math.equation).update(0)
  it
}
#set math.equation(numbering: n => {
  numbering("(1.1)", counter(heading).get().first(), n)
})
#align(right)[
  #ez-today.today(lang: "en", format: "Y m/d")]

#set text(
  lang:"ja",
  font:"Yu Mincho",
  size: 11pt
)

title : 

#align(right)[Name : ] //name
