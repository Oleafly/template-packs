#let default_outline(..args) = [
    #show outline.entry.where(
      level: 1
    ): it => {
      link(it.element.location(), {
      [
        // Kind of jank hack to add spacing after the number
        #show regex("^\d+"): it => box(width: 1.75em, it)

        #v(12pt, weak: true)
        #if it.has("element") {
          strong(it.element.body)
        } else {
          strong(it.body)
        }
        #box(width: 1fr)[]
      ]

      show regex("^\d+"): it => [#it]
      if not it.has("page") {
        strong(it.page())
        linebreak()
      } else {
        strong(it.page)
      }
      })
    }

    #show outline.entry.where(
      level: 2
    ): it => {
      link(it.element.location(), {
        if it.has("element") {
          it.element.body
        } else {
          it.body
        }
        box(width: 1fr, repeat("  .  "))
        h(0.5em)
        if not it.has("page") {
          it.page()
          linebreak()
        } else {
          it.page
        }
        //panic(it)
        //it.page
      })
    }

    #set par(leading: 1em)
    #outline(..args)
]