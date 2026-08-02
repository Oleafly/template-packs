#let items = (
    [#quote[An Academic Paper: Theory and Evidence from Theory and Evidence] (with Other Author), _Journal of Academic Research_. #link("https://www.doi.org/")[DOI].],
).rev()

#enum(..items, numbering: it => numbering("1.", items.len() + 1 - it))