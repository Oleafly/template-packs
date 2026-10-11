//Found here: https://github.com/typst/typst/issues/2196
#let to-string(content) = {
  if content.has("text") {
    content.text
  }
  else if content.has("children") {
    content.children.map(to-string).join("")
  }
  else if content.has("body") {
    to-string(content.body)
  }
  else if content == [ ] {
    " "
  }
}