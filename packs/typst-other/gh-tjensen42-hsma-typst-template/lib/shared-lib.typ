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
      (start.location().page() < page-num
        and page-num < end.location().page())
    })
}
