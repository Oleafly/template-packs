#let min(..args) = {
  for (i,arg) in args.pos().enumerate() {
    if i == 0 [
      $m_#arg$
    ] else [
      $or m_#arg$
    ]
  }
  // [$#args.pos().map(str).map( it => "m_" + it).join(" and ")$]
}

#let max(..args) = {
  for (i,arg) in args.pos().enumerate() {
    if i == 0 [
      $M_#arg$
    ] else [
      $and M_#arg$
    ]
  }
  // [$#args.pos().map(str).map( it => "m_" + it).join(" and ")$]
}

#let tlt = it => {
  if "label" in it.fields() and it.label == <tlt> {
    return it
  }

  let cols = if type(it.columns) == int {
    it.columns
  } else {
    it.columns.len()
  }

  let rows = calc.ceil(it.children.len() / cols)

  let fields = it.fields()
  fields.remove("children")

  return [
    #table(..fields,
      ..it.children,
      table.hline(y: 0, stroke: 1.5pt),
      table.hline(y: 1),
      table.hline(y: rows, stroke: 1.5pt)
    ) <tlt>
  ]
}


#let cir(..nums) = {
  for num in nums.pos() {
    str.from-unicode(9311 + num)
  }
}

#let proof(..args) = {
  let new_children = ()
  let i = 0
  while i < args.pos().len()/2 {
    new_children += (cir(i+1), args.pos().at(2*i), args.pos().at(2*i+1),)
    i = i+1
  }

  return table(columns: (1fr, 8fr, 20fr),stroke: none,  ..new_children, )
}




// #set table(stroke: none)
// #show table: it => {
//   if table.hline() in it.children {
//     return it
//   }
//   let children = it.children
//   let new_children = ()
//   for i in children {
//     new_children += (i,)
//     if repr(i).starts-with("header") {
//       new_children += (table.hline(),)
//     }
//   }
//   let meta = it.fields()
//   meta.remove("children")
//   return table(..meta, table.hline(),..new_children,table.hline())
// }