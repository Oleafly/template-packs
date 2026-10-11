#import "../template/i18n.typ": term

#heading(level: 1, numbering: none, outlined: true)[TABLE OF CONTENTS]
#v(1cm)

#show outline.entry.where(level: 1): it => {
  let el = it.element
  
  if el.numbering == none {
    v(12pt, weak: true)
    strong(upper(it))
  } else {
    v(12pt, weak: true)
    set text(weight: "bold")
    
    let prefix = if el.numbering == "A.1" { "APPENDIX " } else { "CHAPTER " }
    let num = numbering(el.numbering, ..counter(heading).at(el.location()))
    let page-num = counter(page).at(el.location()).first()
    
    link(el.location())[
      #upper[#prefix #num. #el.body]
      #box(width: 1fr, repeat[.])
      #page-num
    ]
  }
}

#outline(title: none, indent: auto, depth: 3)
