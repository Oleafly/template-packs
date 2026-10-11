#let spec(description: "", args: ("foo":"bar"), ret: none) = [
  
  #align(center + horizon)[
    #table(columns: 3, align: left,
      table.cell(colspan:3)[#description],
      table.cell(rowspan: args.len(), )[*Arguments*],
      ..for (arg, desc) in args {
        (
          [
            #set text(top-edge: 0pt)
            #h(-2pt)
            #hide(sym.zws) // Hack to prevent weirdness
            #raw(arg)
          ],
          desc
        )
      },
      table.cell(rowspan: ret.len())[*Return value*],
      ..for (r, desc) in ret {
        if desc == "" {
          (
            table.cell(colspan: 2)[
              #h(-2pt)
              #hide(sym.zws) // Hack to prevent weirdness
              #raw(r)
            ],
          )
        } else {
          (
            [
              #h(-2pt)
              #hide(sym.zws) // Hack to prevent weirdness
              #raw(r)
            ],
            desc
          )
        }
      }
    )
  ]
]
