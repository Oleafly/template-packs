#let is_even_page() = {calc.rem(here().page(), 2)==0}

#let is_chapter_page() = {
  let chapters = query(heading.where(level: 1))
  chapters.any(c => c.location().page() == here().page())
}

#let current_page_h1() = {
  let next_h1_is_not_on_this_page = {
    let after_h1_s = query(heading.where(level: 1).after(here()))
    if after_h1_s.len() == 0 {true} else {after_h1_s.first().location().page() != here().page()}
  }
  assert(next_h1_is_not_on_this_page)
  let arr_heading_prev = query(heading.where(level: 1).before(here()))
  if(arr_heading_prev == ()) {repr(heading.where(level: 1).before(here()))}
   else {arr_heading_prev.last()}
}

#let current_page_h2() = {
  let next_h2 = query(heading.where(level: 2).after(here())).first(default: none)
  if next_h2 == none {
    return none
  } else if next_h2.location().page() == here().page() {
    next_h2
  } else {
    let prev_h2 = query(heading.where(level: 2).before(here())).last(default: none)
    if prev_h2 == none {return none}
    let prev_h2_is_before_this_page = prev_h2.location().page() < here().page()
    assert(prev_h2_is_before_this_page)
    let prev_h2_is_sub_of_current_h1 = {
      let h1_count_here = counter(heading).get().first()
      let h1_count_at_prev_h2 = counter(heading).at(prev_h2.location()).first()
      h1_count_here == h1_count_at_prev_h2
    }
    if not prev_h2_is_sub_of_current_h1 {return none}
    prev_h2
  }
}

#let page_display() = counter(page).display(here().page-numbering())

#let header_line_style = black

#let heading_display(h) = {
  if h==none {return none}
  else if h.func() != heading {return h}
  let body = if h.body.func() == text {
    h.body
  } else {
    if h.body.has("child"){h.body.child}
  }
  let num = if h.numbering != none { numbering(h.numbering, ..counter(heading).at(h.location())) }
  [#num #h.body]
}


// ----- outline ----- 
// #let header_even_outline() = [#page_display() #h(1fr)]
// #let header_even_out_second() = [
//   #box([
//     #page_display()
//     #h(1fr)
//     #state("outline_type").get()
//   ])
//   #line(length: 100%, stroke: header_line_style)
// ]
// #let header_odd_outline() = [#h(1fr) #page_display()]
// #let header_odd_out_second() = [
//   #box([
//     #state("outline_type").get()
//     #h(1fr)
//     #page_display()
//     // #panic("err")
//   ])
//   #line(length: 100%, stroke: header_line_style)
// ]
// ----- outline ----- 

// ----- in main + appendix -----
#let header_even_h1() = [#page_display() #h(1fr)]
#let header_even_noh1() = [
  #box([
    #page_display()
    #h(1fr)
    #heading_display(current_page_h1())
  ])
  #line(length: 100%, stroke: header_line_style)
]
#let header_odd_h1() = [#h(1fr) #page_display()]
#let header_odd_noh1() = [
  #box([
    #heading_display(current_page_h2())
    // #if current_page_h2() == none {[草]}
    #h(1fr)
    #page_display()
  ])
  #line(length: 100%, stroke: header_line_style)
]
// ----- in outline + main + appendix -----

// ----- in acknowledgement + bib -----
#let header_even_AB() = [#page_display() #h(1fr)]
#let header_even_AB_second(title) = [
  #box([
    #page_display()
    #h(1fr)
    // #state("isAB").get()
    #title
  ])
  #line(length: 100%, stroke: header_line_style)
]
#let header_odd_AB() = [#h(1fr) #page_display()]
#let header_odd_AB_second(title) = [
  #box([
    // #state("isAB").get()
    #title
    #h(1fr)
    #page_display()
  ])
  #line(length: 100%, stroke: header_line_style)
]
// ----- in acknowledgement + bib -----