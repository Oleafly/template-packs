// #import "template/template.typ": *
#import "template/utils/discr.typ": *
// #set enum(numbering: "(1)")
// #show: repr
// (1)
//   $
//   (p and q) or (p and not q)
//   &= (p or p) and (p or not q) and (q or p) and (q or not q) \
//   &= p and (p or not q) and (p or q ) \
//   &= p
//   $

// +

//   $
//   ((p arrow.r q) and (p arrow.r r)) &= (not p or q) and (not p or r) \
//   &= (not p and not p) or (not p and r) or (q and not p ) or (q and r) \
//   &= not p or (q and r) \
//   &= p arrow.r (q and r)
//   $

// +
fewfewfwefwefwefwefwefewf #(2*3)
fewfaw
\[
  fewfewfafeafdsfaewafds
\]

#let plain-mini(it) = if it.has("text") { it.text }
#repr(`代码片段中的 text`) \
#repr([文本中的 text])

#let x = [fewfwe, #set text(fill: blue)
fewfew]
#repr(x)

#repr([= 123])

#repr([123])

#repr({
[d]
show raw: content => {
  [c]
  set text(fill: red)
  content
}
[a]
`b`
})

#proof([1], [2], [3], [5], )

#cir(2)