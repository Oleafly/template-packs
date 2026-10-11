#import "@preview/cetz:0.3.4"

#let cite-author-genitive-s(key, supplement: none, style: auto) = {
  show regex(".+$"): it => it + "’"
  show regex("[^s]’$"): it => it + "s"
  cite(key, form: "author", supplement: supplement)
}

#let cite-prose-genitive-s(key, supplement: none, style: auto) = {
  show regex(".\s[\[\(]"): it => {
    show regex("[^\s\[\(]"): it => it + "’"
    show regex("[^s]’"): it => it + "s"
    it
  }
  cite(key, form: "prose", supplement: supplement)
}

#let doubleline(cols) = (
  table.hline(),
  table.cell(colspan: cols, inset: 0.12em, {}),
  table.hline(),
)

#let term(b: true, s: true, x) = [
  #let bd(y) = if b [*#y*] else [#y]
  #let si = if type(s) != bool [$\^(s^#s)$] else if s [$\^(s^*)$] else []
  #sym.bracket.l.stroked#bd(x)#sym.bracket.r.stroked#si
]
#let b(x) = strong[#x]
#let s(x) = strong(text(red)[#x])
#let nu = $upright(nu)$
#let g = "ɡ"
#let cor = $accent(=, \^)$

#let agree(start, end, depth, ..style) = {
  cetz.draw.set-style(mark: (end: ">", start: ">"), stroke: (paint: black, dash: "solid"))
  cetz.draw.set-style(..style)
  cetz.draw.bezier(
    start + ".south",
    end + ".south",
    (rel: (-90deg, depth * 1cm), to: (start, 0%, end)),
    (rel: (-90deg, (depth + 3) * 1cm), to: (start, 100%, end)),
  )
}

