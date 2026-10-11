#{
  import "@preview/tidy:0.2.0"
  import "../cody.typ"
  let my-module = tidy.parse-module(read("../cody.typ"), name: "cody", scope: (cody: cody))
  tidy.show-module(my-module, sort-functions: none)
}
