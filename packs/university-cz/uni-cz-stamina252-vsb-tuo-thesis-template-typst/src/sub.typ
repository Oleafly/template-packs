#let sub_item(first: false, item_kind: none, body) = {
  if first {
    counter("nigadgsdgasgadfh").update(0)
  }
   
  set figure(numbering: it => { 
      let top_level_count = counter(figure.where(kind: item_kind)).get().first()
      let heading_count = counter(heading).get().first()
      let sub_level_count = counter("nigadgsdgasgadfh").get().first()
      numbering("1.1.(a)", heading_count, top_level_count, sub_level_count)
    }
  )

  set figure(outlined: false, supplement: " ")
  set figure.caption(separator: " ")
  
  show figure.caption: set text(9pt)
  counter("nigadgsdgasgadfh").step()
  
  
  show figure.caption: it => {
    text(
      numbering("(a)",
      counter("nigadgsdgasgadfh").get().first()) +
      it.separator +
      it.body
    )
  }
  counter(figure.where(kind: item_kind)).update(n => n - 1)
  body
}


#let sub_fig(first: false, body) = {
  sub_item(first: first, item_kind: image, body)
}

#let sub_table(first: false, body) = {
  sub_item(first: first, item_kind: table, body)
}

/*
#let sub_raw(first: false, body) = {
  sub_item(first: first, item_kind: raw, body)
}
*/