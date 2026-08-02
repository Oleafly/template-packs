#let definition-counter = counter("definition")
#let definition(content) = {
  definition-counter.step()
  block([*#context definition-counter.display("1.") Definíció.* ] + content)
}

#let theorem-counter = counter("theorem")
#let theorem(content) = {
  theorem-counter.step()
  block([*#context theorem-counter.display("1.") Tétel.* ] + emph(content))
}

#let proof(content) = block([_Bizonyítás._ ] + content)

#let remark(content) = block([_Emlékeztető._ ] + content)

#let note(content) = block([_Megjegyzés._ ] + content)

#let appendix(title) = heading(title, numbering: "A.", supplement: "függelék")
