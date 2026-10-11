
#let arrayOrNone(v) = if v == none {
  ()
 } else if type(v) == array {
  v
 } else {
  (v,)
 }

 #let valueOrDefault(v, default) = if v == none {
  default
 } else {
  v
 }

 #let  mapOrNone(v, t) = if v == none {
  none
} else {
  t(v)
}

#let filterNone(shouldSkip: true, array) = {
  if shouldSkip {
    array.filter(i => i != none)
  } else {
    array
  }
}

 #let todo(caption) = block(fill: yellow, radius: 4pt, inset: 0.5em)[
  #raw("[" + valueOrDefault(caption, "TODO") + "]")
 ]

 #let matchedSize(source, data) = {
   let n = source.len();
   if data.len() == 0 {
     (auto,) * n
   } else {
     let tail = (data.last(),) * n
     (data + tail).slice(0, n)
   }
 }

 // Resolve a character field: if the field is a function (e.g. byLevelMethod),
 // call it with the character; if auto, use `default`; if none, return none.
 #let method(o, f, default: (o) => none) = {
   if o == none {
     none
   } else {
     let result = f(o)
     if result == none {
       none
     } else if type(result) == function {
       result(o)
     } else if result == auto {
       default(o)
     } else {
       result
     }
   }
 }

 #let renderItems(items, render) = {
   for item in items {
     if type(item) == content {
       item
     } else if type(item) == dictionary {
       render(item)
     } else {
       panic("Unsupported item type: " + type(item))
     }
   }
 }

 #let switchInt(value, cases) = {
   let keys = cases.keys().map(int).filter(c => c <= value)
   if keys.len() > 0 {
     cases.at(str(keys.last()))
   }
 }

 #let roman(num) = {
     let result = ""
     let values = (1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1)
     let numerals = ("M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I")

     for (value, numeral) in values.zip(numerals) {
         while num >= value {
             result += numeral
             num -= value
         }
     }

     result
 }
