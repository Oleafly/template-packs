#import "@preview/subpar:0.2.1"
#import "styles/header-settings.typ": algo-counter
#import "styles/font-settings.typ": font, font-size
#import "styles/main-text-settings.typ": continued-header-state
#import "styles/globals.typ": eq-counter


#let myalgo(..children) = {
   align(center, grid(
    stroke: (left: none, right: none, bottom: black, top: black),
    inset: 5pt,
    [#set align(left)
    #set text(size: 11pt)
    #let algo-num = context algo-counter.display("1")
    #let chap-num = context counter(heading).get().at(0)
    *算法 #(chap-num)-#algo-num* #children.at(0)],
    [#set align(left)
    #set text(size: 9pt)
    #children.pos().slice(1).join()],
   ))
   algo-counter.step()
}


#let _subfig = subpar.grid.with(
  numbering: super => numbering("1-1", counter(heading).get().first(), super),
  numbering-sub-ref: (super, sub) => {
    numbering("1-1a", counter(heading).get().first(), super, sub)
  },
)

#let subfig(..args) = {
  set text(size: font-size.五号, font: font.Times + font.楷体)
  _subfig(..args)
}


#let continued-header(colspan: none, ..children) = {
  table.header(
    repeat: true,
    table.cell(colspan: colspan, {
      context if continued-header-state.get() {
        align(right, text(weight: "regular")[（续）])
      } else {
        v(-0.9em)
        continued-header-state.update(true)
      }
    }),
    table.hline(),
    ..children,
    table.hline(),
  )
}


#let subeqs(..args)={
  for eq in args.pos(){
    eq-counter.step(level: 3)
    eq
  }
  eq-counter.step(level: 2)
}


#let emptypar()= par()[#text(size: 0em)[#h(0.0em)]]
