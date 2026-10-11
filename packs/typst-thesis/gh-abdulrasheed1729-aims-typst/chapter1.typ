#let my-code = read("code/mycode.py")

= Introduction <intro>

Explain the context of your research project topic, so that the
topic itself appears motivated, natural and important.

Paragraphs are separated by blank lines in the Typst code, and the line spacing, paragraph indentation, and paragraph spacing are set in the preamble for you.

This is a textual citation #cite(<shannon44>, form: "prose"). And this is a parenthetical citation @shannon44.

== Moving On
Let's demonstrate a figure by looking at @bandwidth.

#figure(
  image("images/bandwidth-colour.png", width: 80%),
  caption: [Planning community bandwidth sharing costs. Note caption capitalization.],
) <bandwidth>

// Equivalent to \verbatimtabinput
#raw(my-code, lang: "python", block: true)
