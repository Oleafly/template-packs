// placeholders
#let content-placeholder() = {
  context {
    let selector = selector(heading).before(here())
    let headings = query(selector)

    let last-heading
    if headings.len() > 0 {
      last-heading = headings.last()
    }
    let heading-body = last-heading.body

    let heading-level = last-heading.level
    if heading-level > 3 {
      return [
        Disini penulis dapat membahas sub bagian #heading-body lebih terperinci. Deskripsi pembahasan seharusnya singkat, padat dan jelas, sehingga membuat pembaca memahami maksud penulis yang tertuang dalam tulisan.
      ]
    } else {
      return [
        Disini penulis dapat menjelaskan lebih terperinci apa saja yang ada pada #heading-body ini. Jika bagian ini mempunyai sub bagian yang perlu diperjelas dalam pembahasan, penulis dapat menuliskannya dalam sub pembahasan pada bagian ini.
      ]
    }
  }
}
