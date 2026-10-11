#let use(name, args) = {
  let path = "../../../book/template/" + name + ".typ"
  let module = eval("import \"" + path + "\" as mod; mod", mode: "code")

  (module.template)(..args)
}
