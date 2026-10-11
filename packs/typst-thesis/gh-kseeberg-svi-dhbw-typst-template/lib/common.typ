#let check-in-dict(dict-type, state, element) = {
  context {
    let list = state.get()
    if element not in list {
      panic(element + " is not a key in the " + dict-type + " dictionary.")
    }
  }
}

#let display-link(dict-type, state, element, text) = {
  check-in-dict(dict-type, state, element)
  link(label(dict-type + "-" + element), text)
}

#let display(dict-type, state, element, text, link: true) = {
  if link {
    display-link(dict-type, state, element, text)
  } else {
    text
  }
}

// Workaround for https://github.com/typst/typst/issues/2722
#let is-page-empty() = {
  let page-num = here().page()
  query(<empty-page-start>)
    .zip(query(<empty-page-end>))
    .any(((start, end)) => {
      (start.location().page() < page-num and page-num < end.location().page())
    })
}

#let hrule = align(
  center,
  line(length: 100%),
)

#let months-de = (
  "Januar",
  "Februar",
  "März",
  "April",
  "Mai",
  "Juni",
  "Juli",
  "August",
  "September",
  "Oktober",
  "November",
  "Dezember",
)

#let format-date-de(date: datetime) = {
  (
    str(date.day()) + ". " + months-de.at(date.month() - 1) + " " + str(date.year())
  )
}

// Cite with "Vgl. "
#let flcite(
  url: str,
  date: datetime,
) = footnote[
  Vgl. #link(url), Datum: #format-date-de(date: date)
]

// Refer to a label and show the page number if the page is far away.
#let distref(lbl, max-dist: 1) = context {
  let target = locate(lbl)
  let d = calc.abs(here().page() - target.page())

  if d <= max-dist {
    ref(lbl)
  } else {
    [#ref(lbl) (#ref(lbl, form: "page"))]
  }
}
