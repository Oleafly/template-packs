#let c_thm = counter("theorem")
#let c_lem = counter("lemma")
#let c_cor = counter("corollary")
#let c_def = counter("definition")
#let c_list = (c_thm, c_lem, c_cor, c_def)
#let kind_list = ("theorem", "lemma", "corollary", "definition")

#let parvirtual = {
"" 
context v(-par.spacing -  measure("").height)
}

#let thmrules(doc) = {
  show heading.where(level: 1): it => {
    for c in c_list {
      c.update(0)
    }
    for k in kind_list {
      counter(figure.where(kind: k)).update(0)
    }
    it
  }
  show figure: it => {
    if it.kind in kind_list {
      v(2em, weak: true)
      set align(start)
      it
      parvirtual
      v(2em, weak: true)
    } else {
      it
    }
  }
  show ref: it => {
    if it.element == none{
      it
    } else if it.element.func() == figure and it.element.kind in kind_list{
      link(
        it.element.location()
      )[#it.element.supplement #counter(heading).at(it.element.location()).at(0).#counter(figure.where(kind: it.element.kind)).at(it.element.location()).at(0)]
    } else {
      it
    }
  }
  doc
}



#let theorem(body, name: none, kind: "theorem", type: "Theorem", count: c_thm, indent: none) = {
  let headnumber = context counter(heading).get().at(0)
  let thmnumber = context count.get().at(0)
  // return (body, headnumber, thmnumber) => {
    return (figure({
      count.step()
      block[
      #if indent != none {
      parvirtual
      }
      #if name == none {[
        *#type #headnumber.#thmnumber.*
      ]} else {[
        *#type #headnumber.#thmnumber* (#name)*.*
      ]}
      #body]
    }, kind: kind, supplement: type))
  // }
}
  
  

// #let theorem(body, name: none, type: "Theorem", count: c_thm, indent: none) = block(above: 2em, below: 2em)[
//   #count.step()
//   #if indent != none {
//   parvirtual
//   }
//   #if name == none {[
//     *#type #context counter(heading).get().at(0).#context count.display().*
//   ]} else {[
//     *#type #context counter(heading).get().at(0).#context count.display()* (#name)*.*
//   ]}
//   #body
// ]

#let lemma = theorem.with(kind: "lemma", type: "Lemma", count: c_lem)
#let corollary = theorem.with(kind: "corollary", type: "Corollary", count: c_cor)
#let definition = theorem.with(kind: "definition", type: "Definition", count: c_def)


#let proof(body, type: "Proof", count: c_thm, indent: none) = {
  v(2em, weak: true)
  block[
  #if indent != none {
  parvirtual
  }
  _#type._
  #body 
  #box(width: 2em)
  #h(1fr)
  $qed$
  ]
  parvirtual
  v(2em, weak: true)
}


#let dingli = theorem.with(type: "定理", count: c_thm, indent: true)
#let yinli = dingli.with(kind: "lemma", type: "引理", count: c_lem)
#let tuilun = dingli.with(kind: "corollary", type: "推论", count: c_cor)
#let dingyi = dingli.with(kind: "definition", type: "定义", count: c_def)


#let zhengming = proof.with(type: "证明", indent: true)

