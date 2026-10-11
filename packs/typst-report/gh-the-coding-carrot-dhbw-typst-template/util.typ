//Content functions

// Creates a red, bold text with a preceeding "TODO:"
#let todo(c) = {
  set text(red)
  [#strong[TODO: #c]]
}











// Header functions

#let active_heading = state("active_heading", "")
#let header_heading = context {

      let current-page = here().page()

      let all-headings = query(heading.where(level: 1))

      let headings-on-this-page = all-headings.filter(h => h.location().page() == current-page)

      if headings-on-this-page.len() == 0 {
        active_heading.at(here())
      } else {
        headings-on-this-page.last().body
      }
    }