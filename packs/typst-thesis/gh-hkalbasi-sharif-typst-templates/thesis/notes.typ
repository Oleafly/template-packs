
#let glossary-state = state("glossary-entries", ())

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

// This is your new `note` function.
// It adds the word to the glossary state AND shows the footnote.
#let note(persian-term, english-term) = {
  // 1. Add this entry to our global state
  // We check for duplicates to avoid adding the same word multiple times
  glossary-state.update(old => {
    let is-duplicate = old.any(entry => entry.fa == to-string(persian-term))
    if not is-duplicate {
      // Add the new entry
      old + ((en: to-string(english-term), fa: to-string(persian-term)),)
    } else {
      // Return the list unchanged
      old
    }
  })

  // 2. Display the term with its footnote (the English translation)
  // We use numbering: "۱" to get Persian numerals (۱, ۲, ۳...)
  [
    #persian-term
    #footnote(numbering: "۱")[
      #text(dir: ltr, english-term)
    ]
  ]
}

// #let note(it, note) = [
//   #it #footnote(numbering: "۱")[#note]
// ]

// #let cntrs_id = "note_cntr"
// #let notes = state("dict", (:))
// #let note(it, note) = context {
// 	let pg = 0
//   let cntr = counter(cntrs_id + str(pg))
//   cntr.step()
//   notes.update(dict => {
//     let vec = ()
//     if str(pg) in dict.keys() {
//       vec = dict.at(str(pg))
//     }
//     vec.push(note)
//     dict.insert(str(pg), vec)
//     dict
//   })
//   it + super(numbering("۱", cntr.get().at(0)))
// }

// #let display(k) = context {
// 	set text(size: 8pt)
// 	let pg = 0
//   let dict = notes.final()
//   let vec = ()
//   if str(pg) in dict.keys() {
//     vec = dict.at(str(pg))
//   }

//   if vec.len() > 0 {
//       let t = calc.ceil(vec.len() / 3)
//       for i in range(k * t, calc.min((k + 1) * t, vec.len())) {
//           super[#numbering("۱", i + 1)] + h(1pt) + vec.at(i)
//           linebreak()
//       }
//   }
// }
