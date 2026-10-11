#let ru_alph(pattern: "а)") = {
  let alphabet = "абвгдежзиклмнопрстуфхцчшщэюя".split("")
  let f(i) = {
    let letter = alphabet.at(i)
    let str = ""
    for char in pattern {
      if char == "а" {
        str += letter
      }
      else if char == "А" {
        str += upper(letter)
      }
      else {
        str += char
      }
    }
    str
  }
  f
}

#let low_letter_list = (..args) => [
  #enum(..args, numbering: ru_alph())
]

#let small_list = (..args) => [
  #enum(..args, numbering: "1)")
]