#import "globals.typ": first-heading, last-heading, algo-counter, eq-counter

#let append-state(cur-heading) = {
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  eq-counter.step()
  eq-counter.step(level: 2)

  algo-counter.update(1)

  let page-num = here().page()

  let heading-numbering = counter(heading).display()
  let final-header = if cur-heading.body != [参考文献] {
    [#heading-numbering#"  "#cur-heading.body]
  } else {
    cur-heading.body
  }

  last-heading.update(item => {
    item.insert(str(page-num), final-header)
    item
  })
  first-heading.update(item => {
    let k = str(page-num)
    if k not in item {
      item.insert(k, final-header)
    }
    item
  })
  cur-heading
}

#let find-headings(headings, page-num) = if page-num > 0 {
  headings.at(str(page-num), default: {
    let arr = headings.keys()
    if arr.len() == 0{
      return
    }
    headings.at(arr.last())
  })
}

#let display-header() = {
  let next-headings = query(selector(heading).after(here()))
  let next-heading-page = if next-headings.len() > 0 {
    next-headings.first().location().page()
  }

  let first-headings = first-heading.final()
  let page-num = here().page()

  let last-headings = last-heading.at(here())

  // 找当前页
  let cur-heading = first-headings.at(str(page-num), default: find-headings(last-headings, page-num))

  cur-heading
}
