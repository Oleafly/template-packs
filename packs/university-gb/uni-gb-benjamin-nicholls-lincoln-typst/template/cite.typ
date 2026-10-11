#let citet(..citation) = {
    cite(..citation, form: "prose")
}

#let citep(..citation) = {
    cite(..citation, form: "normal")
}

#let citeauthor(..citation) = {
    cite(..citation, form: "author")
}

#let citefull(..citation) = {
    cite(..citation, form: "full")
}

#let citeyear(..citation) = {
    cite(..citation, form: "year")
}
