#import "@preview/tablem:0.3.0": tablem, three-line-table
#import "@preview/dashy-todo:0.1.3": todo

#let todo-outline() = context {
  block(fill: rgb(255, 0, 0, 40%), outset: 1em)[
    = Todos
    #let todos = query(figure.where(kind: "todo"))
    #if todos.len() == 0 [No Todos] else {
      enum(..todos.map(t => block(breakable:false)[#link(t.location())[#t.caption]]))
    }
  ]
}

#let eq-align(al, body) = {
  show math.equation.where(block: true): set align(al)
  body
}
