#import "../bib-style.typ"
#import "../bib-setting-fucntion.typ": *

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// 引用スタイル設定 (APA)
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#let year-doubling = "%year-doubling"
#let bib-sort = true
#let bib-sort-ref = false
#let bib-full = true

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Custom Helper Functions for APA
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#let author-en-apa-internal(author_arr) = {
  let an_author = author_arr
  let author_str = ""
  let author_first = an_author.remove(0)

  if author_first.len() != 0{
    let brace_num = 0
    let num = 0
    for value in author_first{
      if value == "{"{
        brace_num += 1
      }
      else if value == "}"{
        brace_num -= 1
      }
      else{
        if value == "-"{
          num = -1
        }
        if brace_num == 0{
          if num == 0{
            author_str += upper(value)
          }
          else{
            author_str += lower(value)
          }
        }
        else{
          author_str += value
        }
      }
      num += 1
    }
    if an_author != (){
      author_str += ", "
    }
  }
  
  let total = an_author.len()
  let count = 0
  for value in an_author{
    author_str += " "
    if value.len() != 0{
      author_str += upper(value.at(0))
      author_str += "."
    }
    count += 1
  }
  return author_str
}

// Custom function for Editors: F. M. Last (with dots)
#let author-en-apa-editor-internal(author_arr) = {
  let an_author = author_arr
  let author_str = ""
  let author_str2 = ""
  let author_first = an_author.remove(0)

  if author_first.len() != 0{
    let brace_num = 0
    let num = 0
    for value in author_first{
      if value == "{"{
        brace_num += 1
      }
      else if value == "}"{
        brace_num -= 1
      }
      else{
        if value == "-"{
          num = -1
        }
        if brace_num == 0{
          if num == 0{
            author_str += upper(value)
          }
          else{
            author_str += lower(value)
          }
        }
        else{
          author_str += value
        }
      }
      num += 1
    }
  }
  
  for value in an_author{
    if value.len() != 0{
      author_str2 += upper(value.at(0)) + ". "
    }
  }

  return author_str2 + author_str
}

#let author-set-apa(biblist, name) = {
  let author_arr = ()
  let author_arr2 = author-make-arr(biblist, name)

  for author in author_arr2{
    let authorsum = author.sum()
    let check = (regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]") in authorsum)

    if check{
      author_arr.push(author-ja(author))
    }
    else{
      author_arr.push(author-en-apa-internal(author))
    }
  }

  // APA 7th: For 21+ authors, show first 19, then "...", then last author
  if biblist.lang == "ja"{
    if author_arr.len() > 20 {
      let first19 = author_arr.slice(0, 19)
      let last = author_arr.at(-1)
      return first19.join("・") + "・…・" + last
    }
    return author_arr.join("・")
  }
  else{
    if author_arr.len() > 20 {
      let first19 = author_arr.slice(0, 19)
      let last = author_arr.at(-1)
      return first19.join(", ") + ", ... " + last
    }
    return author_arr.join(", ", last: ", & ")
  }
}

#let author-set-apa-editor(biblist, name) = {
  let author_arr = ()
  let author_arr2 = author-make-arr(biblist, name)

  for author in author_arr2{
    let authorsum = author.sum()
    let check = (regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]") in authorsum)

    if check{
      author_arr.push(author-ja(author))
    }
    else{
      // Use the new custom function with dots
      author_arr.push(author-en-apa-editor-internal(author))
    }
  }

  // APA 7th: For 21+ authors, show first 19, then "...", then last author
  if biblist.lang == "ja"{
    if author_arr.len() > 20 {
      let first19 = author_arr.slice(0, 19)
      let last = author_arr.at(-1)
      return first19.join("・") + "・…・" + last
    }
    return author_arr.join("・")
  }
  else{
    if author_arr.len() > 20 {
      let first19 = author_arr.slice(0, 19)
      let last = author_arr.at(-1)
      return first19.join(", ") + ", ... " + last
    }
    return author_arr.join(", ", last: ", & ")
  }
}

#let author-set-apa-editor-with-suffix-en(biblist, name) = {
  let res = author-set-apa-editor(biblist, name)
  let author_arr2 = author-make-arr(biblist, name)
  if author_arr2.len() > 1 {
    return res + " (Eds.)"
  } else {
    return res + " (Ed.)"
  }
}

#let author-set-apa-editor-with-suffix-ja(biblist, name) = {
  let res = author-set-apa-editor(biblist, name)
  return res + "（編）"
}

// Custom cite author function for APA (Japanese uses ・ separator)
#let author-set-cite-apa(biblist, name) = {
  let author_arr2 = ()
  if biblist.at(name, default: "") != ""{
    author_arr2 = author-make-arr(biblist, name)
  }
  else{
    author_arr2 = (("",),)
  }

  let author_arr = ()

  let disambiguate = biblist.at("disambiguate", default: none)
  let is_first = true

  for author in author_arr2{
    let authorsum = author.sum()
    let check = (regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]") in authorsum)

    if check{
      if is_first and disambiguate == "fullname" {
        author_arr.push(author-ja(author))
      } else {
        author_arr.push(author.at(0))
      }
    }
    else{
      if is_first and disambiguate == "initials" {
        author_arr.push(author-en3(author))
      } else if is_first and disambiguate == "fullname" {
        author_arr.push(author-en4(author))
      } else {
        author_arr.push(author-en2(author))
      }
    }
    is_first = false
  }

  if biblist.lang == "ja"{// 日本語の場合
    let show_count = biblist.at("show_count", default: none)
    
    if show_count != none {
       // Ambiguity resolution case
       let output_authors = author_arr.slice(0, show_count)
       if show_count < author_arr.len() {
          return output_authors.join("・") + "他"
       } else {
          return output_authors.join("・")
       }
    } else {
       // Default case
       if author_arr.len() == 1{// 著者が1人の場合
         return author_arr.sum()
       }
       else if author_arr.len() == 2{// 著者が2人の場合
         return author_arr.join("・") // Use ・ separator
       }
       else{// 著者が3人以上の場合
         let tmp = (author_arr.at(0), "他")
         return tmp.sum()
       }
    }
  }
  else{// 英語の場合
    let en_show_count = biblist.at("en_show_count", default: none)
    
    if en_show_count != none {
       // APA 8.18: List enough authors to distinguish, followed by ", et al."
       // If showing all authors is needed (only last differs), show full list
       let output_authors = author_arr.slice(0, en_show_count)
       if en_show_count >= author_arr.len() {
          // Show all authors - use & before last
          return output_authors.join(", ", last: ", & ")
       } else {
          // Show partial list + et al.
          return output_authors.join(", ") + ", et al."
       }
    } else {
       // Default case
       if author_arr.len() == 1{// 著者が1人の場合
         return author_arr.sum()
       }
       else if author_arr.len() == 2{// 著者が2人の場合
         return author_arr.join(" & ")
       }
       else{// 著者が3人以上の場合
         let tmp = (author_arr.at(0), " et al.")
         return tmp.sum()
       }
    }
  }
}

// citeのスタイル設定
#let bib-cite-author = author-set-cite-apa
#let bib-cite-year = all-return

// vancouverスタイル設定
#let bib-vancouver = "[1]"
#let vancouver-style = false
#let bib-year-doubling = "a"

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Helper Functions for Translated Books (j-prefixed fields)
// JPA Format: （翻訳者（訳）（年）．日本語タイトル　出版社）
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Format Japanese translators (jauthor field) - uses ・ separator and adds （訳）
#let jauthor-set-apa(biblist, name) = {
  let author_arr = ()
  let author_arr2 = author-make-arr(biblist, name)

  for author in author_arr2{
    author_arr.push(author-ja(author))
  }
  
  return author_arr.join("・") + "（訳）"
}

// Format Japanese title - no brackets, just the title
#let jtitle-format(biblist, name) = {
  let title = biblist.at(name).sum()
  if type(title) == content {
    title = contents-to-str(title)
  }
  return title
}

// Format Japanese year with parentheses
#let jyear-format(biblist, name) = {
  return "（" + str(biblist.at(name).sum()) + "）．"
}

// Format Japanese publisher
#let jpublisher-format(biblist, name) = {
  return biblist.at(name).sum()
}

// Format translation note (jnote field)
#let jnote-format(biblist, name) = {
  let note = biblist.at(name).sum()
  if type(note) == content {
    note = contents-to-str(note)
  }
  return "（" + note + "）"
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// bib-vancouver = "manual"のときの設定
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#let bib-vancouver-manual = bib-vancouver-manual-default

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// 各引用の表示形式設定
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// -------------------- Custom cite functions for translated books --------------------
// cite_contents indices: 0=author, 1=year, 2=jauthor(translator), 3=jyear

// citet for translated books: Takeda（2019 田中・東山訳 2020）
#let bib-citet-translated(bib_cite_contents, label) = {
  let jauthor = bib_cite_contents.at(5, default: none)
  let jyear = bib_cite_contents.at(6, default: none)
  
  if jauthor != none and jyear != none {
    // Translated book format: Author（Year Translator Year）
    return text(fill: black)[#bib_cite_contents.at(0)] + text(fill: black)[（] + link(label, text(fill: rgb(0, 128, 0))[#bib_cite_contents.at(1)]) + text(fill: black)[ #jauthor #jyear] + [）]
  } else {
    // Regular format
    return text(fill: black)[#bib_cite_contents.at(0)] + text(fill: black)[（] + link(label, text(fill: rgb(0, 128, 0))[#bib_cite_contents.at(1)]) + [）]
  }
}

// citep for translated books:（Takeda, 2019 田中・東山訳 2020）
#let bib-citep-translated(bib_cite_contents, label) = {
  let separator = if bib_cite_contents.at(4, default: "en") == "ja" { "，" } else { ", " }
  let jauthor = bib_cite_contents.at(5, default: none)
  let jyear = bib_cite_contents.at(6, default: none)
  
  if jauthor != none and jyear != none {
    // Translated book format: Author, Year Translator Year
    return link(label, text(fill: black)[#bib_cite_contents.at(0)] + text(fill: black)[#separator] + text(fill: rgb(0, 128, 0))[#bib_cite_contents.at(1)] + text(fill: black)[ #jauthor #jyear])
  } else {
    // Regular format
    return link(label, text(fill: black)[#bib_cite_contents.at(0)] + text(fill: black)[#separator] + text(fill: rgb(0, 128, 0))[#bib_cite_contents.at(1)])
  }
}

// -------------------- cite --------------------
#let bib-cite  = ([(], bib-citep-translated, [; ], [)])

// -------------------- citet --------------------
#let bib-citet = ([], bib-citet-translated, [; ], [])

// -------------------- citep --------------------
#let bib-citep = (text(fill: black)[（], bib-citep-translated, [; ], [）])

// -------------------- citen --------------------
#let bib-citen = ([(], bib-citen-default, [, ], [)])

// -------------------- citefull --------------------
#let bib-citefull = ([], bib-citefull-default, [; ], [])

// Edition function: Adds " ed." and handles closing parenthesis if pages missing
// Helper function to convert number to ordinal (1st, 2nd, 3rd, etc.)
#let to-ordinal(n) = {
  let num = if type(n) == str { int(n) } else { n }
  let suffix = if calc.rem(calc.floor(num / 10), 10) == 1 {
    "th"  // 11th, 12th, 13th, etc.
  } else {
    let last_digit = calc.rem(num, 10)
    if last_digit == 1 { "st" }
    else if last_digit == 2 { "nd" }
    else if last_digit == 3 { "rd" }
    else { "th" }
  }
  return str(num) + suffix
}

#let edition-func-en(biblist, name) = {
  let ed = biblist.at(name).sum()
  if type(ed) == content { ed = contents-to-str(ed) }
  
  // Try to convert to ordinal if it's a number
  let ed_ordinal = ed
  let ed_clean = ed.replace(regex("[^0-9]"), "")
  if ed_clean.len() > 0 {
    ed_ordinal = to-ordinal(int(ed_clean))
  }
  
  let res = ed_ordinal + " ed."
  
  if biblist.at("pages", default: none) == none {
    res += ")"
  }
  return res
}

#let edition-func-ja(biblist, name) = {
  let ed = biblist.at(name).sum()
  if type(ed) == content { ed = contents-to-str(ed) }
  
  let res = "第" + ed + "版"
  
  if biblist.at("pages", default: none) == none {
    res += "）"
  }
  return res
}

// Pages function: Adds "pp. " and handles prefix (comma or paren)
#let pages-func-en(biblist, name) = {
  let pg = page-set(biblist, name) // Returns "pp. ..."
  let info = ()
  
  if biblist.at("edition", default: none) != none {
    let ed = biblist.at("edition").sum()
    if type(ed) == content { ed = contents-to-str(ed) }
    info.push(ed + " ed.")
  }
  
  if biblist.at("volume", default: none) != none {
    let vol = biblist.at("volume").sum()
    if type(vol) == content { vol = contents-to-str(vol) }
    info.push("Vol. " + vol)
  }
  
  info.push(pg)
  
  if info.len() > 1 {    
    if biblist.at("edition", default: none) != none {       
       let res = ""
       if biblist.at("volume", default: none) != none {
         let vol = biblist.at("volume").sum()
         if type(vol) == content { vol = contents-to-str(vol) }
         res += ", Vol. " + vol
       }
       res += ", " + pg + ")"
       return res
    } else {
       
       let res = " ("
       if biblist.at("volume", default: none) != none {
         let vol = biblist.at("volume").sum()
         if type(vol) == content { vol = contents-to-str(vol) }
         res += "Vol. " + vol + ", "
       }
       res += pg + ")"
       return res
    }
  } else {
    return " (" + pg + ")"
  }
}

#let pages-func-ja(biblist, name) = {
  let pg = page-set(biblist, name)
  
  if biblist.at("edition", default: none) != none {
     let res = ""
     if biblist.at("volume", default: none) != none {
       let vol = biblist.at("volume").sum()
       if type(vol) == content { vol = contents-to-str(vol) }
       res += "，第" + vol + "巻"
     }
     res += "，" + pg + "）"
     return res
  } else {
     let res = "（"
     if biblist.at("volume", default: none) != none {
       let vol = biblist.at("volume").sum()
       if type(vol) == content { vol = contents-to-str(vol) }
       res += "第" + vol + "巻，"
     }
     res += pg + "）"
     return res
  }
}


// Custom function to add "In " to booktitle if editor is missing
#let booktitle-with-in-en(biblist, name) = {
  let res = all-emph(biblist, name)
  if biblist.at("editor", default: none) == none {
    return "In " + res
  }
  return res
}

// Japanese incollection: No "In" prefix per JPA format
#let booktitle-with-in-ja(biblist, name) = {
  return remove-str-brace(biblist, name)
}

// Custom function to remove trailing dot from publisher
#let publisher-clean(biblist, name) = {
  let val = biblist.at(name).sum()
  let s = ""
  let is_str = false
  if type(val) == str { 
    s = val 
    is_str = true
  } else if type(val) == content and val.has("text") { 
    s = val.text 
  }
  
  if s.ends-with(".") {
    if is_str { return s.slice(0, -1) }
    return s.slice(0, -1)
  }
  return val
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// 各要素の表示形式設定
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// -------------------- article (英語) --------------------
#let bibtex-article-author-en = (none,"",author-set-apa, "", "", (), ".")
#let bibtex-article-year-en = (" ("," (",all-return, "%year-doubling", "). ", ("month"), "%year-doubling).")
#let bibtex-article-title-en = (none,"",title-en, "", ". ", (), ".")
#let bibtex-article-journal-en = (none,"",all-emph, "", ", ", (), ".")
#let bibtex-article-volume-en = (none,"",all-emph, "", ", ", (), ".")
#let bibtex-article-number-en = ("","(",all-return, ")", ", ", ("volume"), ".")
#let bibtex-article-pages-en = (none,"",page-set-without-p, "", ".", (), ".")
#let bibtex-article-month-en = (none,"",all-return, "", ". ", (), ".")
#let bibtex-article-note-en = (none,"",all-return, "", ". ", (), ".")
#let bibtex-article-doi-en = (none," https://doi.org/",all-return, "", ". ", (), ".")

#let bibtex-article-en = (
  ("author", bibtex-article-author-en),
  ("year", bibtex-article-year-en),
  ("title", bibtex-article-title-en),
  ("journal", bibtex-article-journal-en),
  ("volume", bibtex-article-volume-en),
  ("number", bibtex-article-number-en),
  ("pages", bibtex-article-pages-en),
  ("doi", bibtex-article-doi-en),
  ("note", bibtex-article-note-en)
)

// -------------------- article (日本語) --------------------
#let bibtex-article-author-ja = (none,"",author-set-apa, "", "", (), "．")
#let bibtex-article-year-ja = ("（","（",all-return, "%year-doubling", "）#h(0pt)．", ("month"), "%year-doubling）#h(0pt)．") // Full-width period after year
#let bibtex-article-title-ja = (none,"",remove-str-brace, "", "　", (), "．") // Full-width space after title (JPA format)
#let bibtex-article-journal-ja = (none,"",all-return, "", "，", (), "．")
#let bibtex-article-volume-ja = (none,"",all-emph, "", "，", (), "．") // User modified this to be emphasized
#let bibtex-article-number-ja = ("",box(h(-0.5em) + "（"),all-return, "）#h(0pt)", "，", ("volume"), "．")
#let bibtex-article-pages-ja = (none,"",page-set-without-p, "", "．", (), "．")
#let bibtex-article-note-ja = (none,"",all-return, "", "．", (), "．")
#let bibtex-article-doi-ja = (none," https://doi.org/",all-return, "", "．", (), "．")

#let bibtex-article-ja = (
  ("author", bibtex-article-author-ja),
  ("year", bibtex-article-year-ja),
  ("title", bibtex-article-title-ja),
  ("journal", bibtex-article-journal-ja),
  ("volume", bibtex-article-volume-ja),
  ("number", bibtex-article-number-ja),
  ("pages", bibtex-article-pages-ja),
  ("doi", bibtex-article-doi-ja),
  ("note", bibtex-article-note-ja)
)

// -------------------- book (英語) --------------------
#let bibtex-book-author-en = (none,"",author-set-apa, "", "", (), ".")
#let bibtex-book-year-en = (" ("," (",all-return, "%year-doubling", "). ", ("month"), "%year-doubling).")
#let bibtex-book-title-en = (none,"",all-emph, "", ". ", (), ".")

// Edition ordinal function for books (returns ordinal without pages logic)
#let edition-ordinal-en(biblist, name) = {
  let ed = biblist.at(name).sum()
  if type(ed) == content { ed = contents-to-str(ed) }
  
  // Try to convert to ordinal if it's a number
  let ed_clean = ed.replace(regex("[^0-9]"), "")
  if ed_clean.len() > 0 {
    return to-ordinal(int(ed_clean))
  }
  return ed
}

#let bibtex-book-edition-en = (none," (",edition-ordinal-en, " ed.)", ". ", (), ".")
#let bibtex-book-publisher-en = (none,"",all-return, "", ". ", (), ".")
#let bibtex-book-address-en = (none,"",all-return, "", ": ", (), ".")

// Translation fields for English books translated to Japanese
// JPA Format: （翻訳者（訳）（年）．日本語タイトル　出版社）
#let bibtex-book-jauthor-en = (none,"（",jauthor-set-apa, "", "", (), ".") // Opens with full-width paren
#let bibtex-book-jyear-en = (none,"",jyear-format, "", "", ("jauthor"), ".") // Year with parens and full-width period
#let bibtex-book-jtitle-en = (none,"",jtitle-format, "", "　", (), ".") // Full-width space after title
#let bibtex-book-jpublisher-en = (none,"",jpublisher-format, "）", "", (), "）") // Closes with full-width paren

#let bibtex-book-en = (
  ("author", bibtex-book-author-en),
  ("year", bibtex-book-year-en),
  ("title", bibtex-book-title-en),
  ("edition", bibtex-book-edition-en),
  ("publisher", bibtex-book-publisher-en),
  ("jauthor", bibtex-book-jauthor-en),
  ("jyear", bibtex-book-jyear-en),
  ("jtitle", bibtex-book-jtitle-en),
  ("jpublisher", bibtex-book-jpublisher-en),
)

// -------------------- book (日本語) --------------------
#let bibtex-book-author-ja = (none,"",author-set-apa, "", "", (), "．")
#let bibtex-book-year-ja = ("（","（",all-return, "%year-doubling", "）#h(0pt)．", ("month"), "%year-doubling）#h(0pt)．") // Full-width period after year
#let bibtex-book-title-ja = (none,"",remove-str-brace, "", "　", (), "．") // Full-width space after title (JPA format)
#let bibtex-book-edition-ja = (none," 第",all-return, "版", "　", (), "．") // Shows as "第X版" after title
#let bibtex-book-publisher-ja = (none,"",all-return, "", "．", (), "．")
#let bibtex-book-address-ja = (none,"",all-return, "", ": ", (), "．")

#let bibtex-book-ja = (
  ("author", bibtex-book-author-ja),
  ("year", bibtex-book-year-ja),
  ("title", bibtex-book-title-ja),
  ("edition", bibtex-book-edition-ja),
  ("publisher", bibtex-book-publisher-ja)
)

// -------------------- incollection (英語) --------------------
#let bibtex-incollection-author-en = (none,"",author-set-apa, "", "", (), ".")
#let bibtex-incollection-year-en = (" ("," (",all-return, "%year-doubling", "). ", ("month"), "%year-doubling).")
#let bibtex-incollection-title-en = (none,"",title-en, "", ". ", (), ".")
#let bibtex-incollection-editor-en-custom = (none,"In ",author-set-apa-editor-with-suffix-en, "", ", ", (), ".")
#let bibtex-incollection-booktitle-en-custom = (none,"",booktitle-with-in-en, "", ". ", (), ".")

// Edition: (3rd ed.
#let bibtex-incollection-edition-en = (" (","",edition-func-en, "", ". ", ("booktitle"), ".")

// Pages: (pp. 1-10) or , pp. 1-10)
#let bibtex-incollection-pages-en = ("","",pages-func-en, "", ". ", ("edition", "booktitle"), ".")

#let bibtex-incollection-publisher-en-custom = (none,"",publisher-clean, "", ".", (), ".")

#let bibtex-incollection-en = (
  ("author", bibtex-incollection-author-en),
  ("year", bibtex-incollection-year-en),
  ("title", bibtex-incollection-title-en),
  ("editor", bibtex-incollection-editor-en-custom),
  ("booktitle", bibtex-incollection-booktitle-en-custom),
  ("edition", bibtex-incollection-edition-en),
  ("pages", bibtex-incollection-pages-en),
  ("publisher", bibtex-incollection-publisher-en-custom),
  ("doi", bibtex-article-doi-en),
  ("note", bibtex-article-note-en)
)

// -------------------- incollection (日本語) --------------------
#let bibtex-incollection-author-ja = (none,"",author-set-apa, "", "", (), "．")
#let bibtex-incollection-year-ja = ("（","（",all-return, "%year-doubling", "）#h(0pt)．", ("month"), "%year-doubling）#h(0pt)．") // Full-width period after year
#let bibtex-incollection-title-ja = (none,"",remove-str-brace, "", "　", (), "．") // Full-width space after title (JPA format)
#let bibtex-incollection-editor-ja-custom = (none,"",author-set-apa-editor-with-suffix-ja, "", " ", (), "．") // No comma, space separator
#let bibtex-incollection-booktitle-ja-custom = (none,"",booktitle-with-in-ja, "", "", (), "．") // No separator after booktitle

#let bibtex-incollection-edition-ja = ("（","",edition-func-ja, "", "．", ("booktitle"), "．")
#let bibtex-incollection-pages-ja = ("","",pages-func-ja, "", "　", ("edition", "booktitle"), "．") // Space after pages

#let bibtex-incollection-publisher-ja-custom = (none,"",publisher-clean, "", "．", (), "．")

#let bibtex-incollection-ja = (
  ("author", bibtex-incollection-author-ja),
  ("year", bibtex-incollection-year-ja),
  ("title", bibtex-incollection-title-ja),
  ("editor", bibtex-incollection-editor-ja-custom),
  ("booktitle", bibtex-incollection-booktitle-ja-custom),
  ("edition", bibtex-incollection-edition-ja),
  ("pages", bibtex-incollection-pages-ja),
  ("publisher", bibtex-incollection-publisher-ja-custom),
  ("doi", bibtex-article-doi-ja),
  ("note", bibtex-article-note-ja)
)

// -------------------- Other types --------------------

#let bibtex-inproceedings-en = bibtex-incollection-en
#let bibtex-inproceedings-ja = bibtex-incollection-ja
#let bibtex-conference-en = bibtex-incollection-en
#let bibtex-conference-ja = bibtex-incollection-ja
#let bibtex-booklet-en = bibtex-book-en
#let bibtex-booklet-ja = bibtex-book-ja
#let bibtex-manual-en = bibtex-book-en
#let bibtex-manual-ja = bibtex-book-ja

#let bibtex-phdthesis-school-en = (none,"Doctoral dissertation, ",all-return, "", ".", (), ".")
#let bibtex-phdthesis-en = (
  ("author", bibtex-book-author-en),
  ("year", bibtex-book-year-en),
  ("title", bibtex-book-title-en),
  ("school", bibtex-phdthesis-school-en)
)
// Japanese thesis: School + 博士論文 (JPA format)
#let bibtex-phdthesis-school-ja = (none,"",all-return, "博士論文", "．", (), "．")
#let bibtex-phdthesis-ja = (
  ("author", bibtex-book-author-ja),
  ("year", bibtex-book-year-ja),
  ("title", bibtex-book-title-ja),
  ("school", bibtex-phdthesis-school-ja)
)

#let bibtex-mastersthesis-school-en = (none,"Master's thesis, ",all-return, "", ".", (), ".")
#let bibtex-mastersthesis-en = (
  ("author", bibtex-book-author-en),
  ("year", bibtex-book-year-en),
  ("title", bibtex-book-title-en),
  ("school", bibtex-mastersthesis-school-en)
)
// Japanese thesis: School + 修士論文 (JPA format)
#let bibtex-mastersthesis-school-ja = (none,"",all-return, "修士論文", "．", (), "．")
#let bibtex-mastersthesis-ja = (
  ("author", bibtex-book-author-ja),
  ("year", bibtex-book-year-ja),
  ("title", bibtex-book-title-ja),
  ("school", bibtex-mastersthesis-school-ja)
)

#let bibtex-techreport-en = bibtex-book-en
#let bibtex-techreport-ja = bibtex-book-ja
#let bibtex-misc-en = bibtex-article-en
#let bibtex-misc-ja = bibtex-article-ja
#let bibtex-online-en = bibtex-article-en
#let bibtex-online-ja = bibtex-article-ja
#let bibtex-unpublished-en = bibtex-article-en
#let bibtex-unpublished-ja = bibtex-article-ja
#let bibtex-proceedings-en = bibtex-book-en
#let bibtex-proceedings-ja = bibtex-book-ja
#let bibtex-inbook-en = bibtex-incollection-en
#let bibtex-inbook-ja = bibtex-incollection-ja


// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// 関数の設定
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#let bib-init = bib-style.bib-init.with(bib-cite: bib-cite)

#let bibliography-list = bib-style.bibliography-list.with(
  year-doubling: year-doubling,
  bib-sort: bib-sort,
  bib-sort-ref: bib-sort-ref,
  bib-full: bib-full,
  bib-vancouver: bib-vancouver,
  vancouver-style: vancouver-style,
  bib-year-doubling: bib-year-doubling,
  bib-vancouver-manual: bib-vancouver-manual,
  bib-cite-author: bib-cite-author,
)

#let bib-tex  = bib-style.bib-tex.with(
  year-doubling:  year-doubling,
  bibtex-article-en:  bibtex-article-en,
  bibtex-article-ja:  bibtex-article-ja,
  bibtex-book-en:  bibtex-book-en,
  bibtex-book-ja:  bibtex-book-ja,
  bibtex-booklet-en:  bibtex-booklet-en,
  bibtex-booklet-ja:  bibtex-booklet-ja,
  bibtex-inbook-en:  bibtex-inbook-en,
  bibtex-inbook-ja:  bibtex-inbook-ja,
  bibtex-incollection-en:  bibtex-incollection-en,
  bibtex-incollection-ja:  bibtex-incollection-ja,
  bibtex-inproceedings-en:  bibtex-inproceedings-en,
  bibtex-inproceedings-ja:  bibtex-inproceedings-ja,
  bibtex-conference-en:  bibtex-conference-en,
  bibtex-conference-ja:  bibtex-conference-ja,
  bibtex-manual-en:  bibtex-manual-en,
  bibtex-manual-ja:  bibtex-manual-ja,
  bibtex-mastersthesis-en:  bibtex-mastersthesis-en,
  bibtex-mastersthesis-ja:  bibtex-mastersthesis-ja,
  bibtex-misc-en:  bibtex-misc-en,
  bibtex-misc-ja:  bibtex-misc-ja,
  bibtex-online-en:  bibtex-online-en,
  bibtex-online-ja:  bibtex-online-ja,
  bibtex-phdthesis-en:  bibtex-phdthesis-en,
  bibtex-phdthesis-ja:  bibtex-phdthesis-ja,
  bibtex-proceedings-en:  bibtex-proceedings-en,
  bibtex-proceedings-ja:  bibtex-proceedings-ja,
  bibtex-techreport-en:  bibtex-techreport-en,
  bibtex-techreport-ja:  bibtex-techreport-ja,
  bibtex-unpublished-en:  bibtex-unpublished-en,
  bibtex-unpublished-ja:  bibtex-unpublished-ja,
  bib-cite-author:  bib-cite-author,
  bib-cite-year:  bib-cite-year,
)

#let bib-file = bib-style.bib-file.with(
  year-doubling:   year-doubling,
  bibtex-article-en:   bibtex-article-en,
  bibtex-article-ja:   bibtex-article-ja,
  bibtex-book-en:   bibtex-book-en,
  bibtex-book-ja:   bibtex-book-ja,
  bibtex-booklet-en:   bibtex-booklet-en,
  bibtex-booklet-ja:   bibtex-booklet-ja,
  bibtex-inbook-en:   bibtex-inbook-en,
  bibtex-inbook-ja:   bibtex-inbook-ja,
  bibtex-incollection-en:   bibtex-incollection-en,
  bibtex-incollection-ja:   bibtex-incollection-ja,
  bibtex-inproceedings-en:   bibtex-inproceedings-en,
  bibtex-inproceedings-ja:   bibtex-inproceedings-ja,
  bibtex-conference-en:   bibtex-conference-en,
  bibtex-conference-ja:   bibtex-conference-ja,
  bibtex-manual-en:   bibtex-manual-en,
  bibtex-manual-ja:   bibtex-manual-ja,
  bibtex-mastersthesis-en:   bibtex-mastersthesis-en,
  bibtex-mastersthesis-ja:   bibtex-mastersthesis-ja,
  bibtex-misc-en:   bibtex-misc-en,
  bibtex-misc-ja:   bibtex-misc-ja,
  bibtex-online-en:   bibtex-online-en,
  bibtex-online-ja:   bibtex-online-ja,
  bibtex-phdthesis-en:   bibtex-phdthesis-en,
  bibtex-phdthesis-ja:   bibtex-phdthesis-ja,
  bibtex-proceedings-en:   bibtex-proceedings-en,
  bibtex-proceedings-ja:   bibtex-proceedings-ja,
  bibtex-techreport-en:   bibtex-techreport-en,
  bibtex-techreport-ja:   bibtex-techreport-ja,
  bibtex-unpublished-en:   bibtex-unpublished-en,
  bibtex-unpublished-ja:   bibtex-unpublished-ja,
  bib-cite-author:   bib-cite-author,
  bib-cite-year:   bib-cite-year,
)

#let bib-item = bib-style.bib-item

#let citet = bib-style.bib-cite-func.with(bib-cite: bib-citet)
#let citep = bib-style.bib-cite-func.with(bib-cite: bib-citep)
#let citen = bib-style.bib-cite-func.with(bib-cite: bib-citen)
#let citefull = bib-style.bib-cite-func.with(bib-cite: bib-citefull)

// -------------------- citeauthor --------------------
// Usage: #citeauthor(<key>) -> Author (or Author et al.)
#let bib-citeauthor = ([], bib-cite-authoronly, [; ], [])
#let citeauthor = bib-style.bib-cite-func.with(bib-cite: bib-citeauthor)

// -------------------- citeyear --------------------
// Usage: #citeyear(<key>) -> 2023 (raw year, no parentheses, no suffix)
#let bib-citeyear = ([], bib-cite-yearonly-raw, [; ], [])
#let citeyear = bib-style.bib-cite-func.with(bib-cite: bib-citeyear)
