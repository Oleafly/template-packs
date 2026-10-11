// The TeX-family logos, set by hand: mitex's \LaTeX renders as plain "LATEX"
// here, so the raised A and dropped E are positioned manually. Kept beside
// misc/typst.typ, which does the same for the typst logo.

#let tex = box[T#h(-0.14em)#box(move(dy: 0.22em)[E])#h(-0.11em)X]

#let latex = box[L#h(-0.29em)#box(text(size: 0.72em, baseline: -0.32em)[A])#h(-0.13em)#tex]

#let bibtex = box[B#box(text(size: 0.8em)[IB])#h(0.02em)#tex]
