// This file includes code from [enja-bib] by [tkrhsmt]
// Licensed under the MIT License: https://opensource.org/licenses/MIT
// Copyright (c) 2024 tkrhsmt
#import "../config.typ": *
#import "bib-tex.typ": *


// --------------------------------------------------
//  CITE FUNCTION
// --------------------------------------------------

#let bib-cite-turn = state("bib-cite-turn", ())

#let update-bib-cite-turn(label) = bib-cite-turn.update(
  bib_info => {
    let output_arr = bib_info
    if output_arr.contains(label) == false{
      output_arr.push(label)
    }
    output_arr
  }
)

#let bib-cite-func(
    bib-cite: (),
  ..label_argument
  ) = {
    let label_arr = label_argument.pos()
    for l in label_arr {
      update-bib-cite-turn(l)
    }

    context{
    let label_arr_copy = label_arr
    if label_arr_copy.len() == 1{//ラベルが1つのとき

      let label = label_arr_copy.at(0)
      let contents = query(label)
      let cite-arr = eval(contents.at(0).supplement.text)
      // Supplement: [author, year, jauthor, jyear, lang, num]
      let jauthor = cite-arr.at(2, default: none)
      let jyear = cite-arr.at(3, default: none)
      cite-arr = (cite-arr.at(0), cite-arr.at(1), cite-arr.at(5), contents.at(0).body, cite-arr.at(4), jauthor, jyear)

      //出力
      bib-cite.at(0) + bib-cite.at(1)(cite-arr, label) + bib-cite.at(3)

    }else{//ラベルが2つ以上のとき

      let label = label_arr_copy.remove(0)
      let contents = query(label)
      let cite-arr = eval(contents.at(0).supplement.text)
      // Supplement: [author, year, jauthor, jyear, lang, num]
      let jauthor = cite-arr.at(2, default: none)
      let jyear = cite-arr.at(3, default: none)
      cite-arr = (cite-arr.at(0), cite-arr.at(1), cite-arr.at(5), contents.at(0).body, cite-arr.at(4), jauthor, jyear)
      let output1 = bib-cite.at(0) + bib-cite.at(1)(cite-arr, label) + bib-cite.at(2)

      label = label_arr_copy.remove(-1)
      contents = query(label)
      cite-arr = eval(contents.at(0).supplement.text)
      jauthor = cite-arr.at(2, default: none)
      jyear = cite-arr.at(3, default: none)
      cite-arr = (cite-arr.at(0), cite-arr.at(1), cite-arr.at(5), contents.at(0).body, cite-arr.at(4), jauthor, jyear)
      let output2 = bib-cite.at(1)(cite-arr, label) + bib-cite.at(3)

      let output = ""
      for label in label_arr_copy{
        contents = query(label)
        cite-arr = eval(contents.at(0).supplement.text)
        // Supplement: [author, year, jauthor, jyear, lang, num]
        let jauthor2 = cite-arr.at(2, default: none)
        let jyear2 = cite-arr.at(3, default: none)
        cite-arr = (cite-arr.at(0), cite-arr.at(1), cite-arr.at(5), contents.at(0).body, cite-arr.at(4), jauthor2, jyear2)
        output += bib-cite.at(1)(cite-arr, label) + bib-cite.at(2)
      }

      //出力
      output1 + output + output2
    }
}
}

// --------------------------------------------------
//  INITIALIZATION
// --------------------------------------------------

#let bib-init(
  bib-cite: (),
  body,
) = {
  //to solve the space after full width parentheses
  show regex("）([，．。、！？；：」』】）])"): it => {
    // Punctuation compression - adjust -0.5em as needed
    let chars = it.text.clusters()
    let punc = chars.at(1)
    box[）#h(-0.5em)#punc]
  }
  show ref: it =>{

      if it.has("element") and it.element != none{
        if it.element.has("kind") and it.element.kind == "bib"{

          let cite-arr = eval(it.element.supplement.text)

          update-bib-cite-turn(it.target)

          // Supplement structure: [author, year, jauthor, jyear, lang, num]
          // Reorder to: 0=author, 1=year, 2=num, 3=body, 4=lang, 5=jauthor, 6=jyear
          let jauthor = cite-arr.at(2, default: none)
          let jyear = cite-arr.at(3, default: none)
          cite-arr = (cite-arr.at(0), cite-arr.at(1), cite-arr.at(5), it.element.body, cite-arr.at(4), jauthor, jyear)

          if it.supplement == ref.supplement{//その他
            bib-cite.at(0) + bib-cite.at(1)(cite-arr, it.target) + bib-cite.at(3)
          }
          else{
            link(it.target, it.supplement)
          }

        }
        else{
          it
        }
      }
      else{
        it
      }
  }
  body
}



#let from-content-to-output(
  year-doubling,
  bib-sort,
  bib-sort-ref,
  bib-full,
  bib-vancouver,
  vancouver-style,
  bib-year-doubling,
  bib-vancouver-manual,
  hanging-indent,
  bib-cite-author,
  content_raw
) = {

  let contents = content_raw.pos()

  // ----- ソートする場合 ----- //
  if bib-sort{
    let yomi_arr = ()//yomiの配列
    let num = 0//番号
    for value in contents{//各文献ごとにyomi_arrに追加
      yomi_arr.push((value.at(2), num))
      num += 1
    }
    yomi_arr = yomi_arr.sorted()//yomi_arrをソート
    let sorted_contents = ()//ソートされた文献の配列
    for value in yomi_arr{//yomi_arrの順番にcontentsをソート
      sorted_contents.push(contents.at(value.at(1)))
    }
    contents = sorted_contents//contentsをソートされたものに変更
  }


  for value in range(contents.len()){
    contents.at(value).push(value)
  }

  // ----- 出力 ----- //

  context {
    let bib-cite-turn-labels = bib-cite-turn.final()

    // Create a mutable copy of contents for modification inside context
    let contents = contents

    let bib-cite-turn-arr = ()

    if bib-cite-turn-labels == (){//もし何も引用されてなければ，全ての文献を表示する
      bib-cite-turn-arr = range(contents.len())
    } else {
      for l in bib-cite-turn-labels {
        for (i, item) in contents.enumerate() {
          if item.at(3) == l {
            if bib-cite-turn-arr.contains(i) == false {
              bib-cite-turn-arr.push(i)
            }
            break
          }
        }
      }
    }

    // ----- Re-analyze disambiguation for CITED entries only ----- //
    // Extract raw dicts from cited entries and run analyze-authors on them only
    let cited-dicts = ()
    let cited-indices = ()
    for idx in bib-cite-turn-arr {
      let entry = contents.at(idx)
      // entry.at(5) contains the raw dict (if available)
      if entry.len() > 5 {
        cited-dicts.push(entry.at(5))
        cited-indices.push(idx)
      }
    }
    
    // Run disambiguation analysis only on cited entries
    if cited-dicts.len() > 0 and bib-cite-author != none {
      let analyzed-dicts = analyze-authors(cited-dicts)
      
      // Update cite author strings for cited entries with correct disambiguation
      for (j, idx) in cited-indices.enumerate() {
        let analyzed-dict = analyzed-dicts.at(j)
        // Recompute the cite author string with correct flags
        let new-author-str = bib-cite-author(analyzed-dict, "author")
        // Update the cite-arr in contents (cite-arr is at index 1)
        contents.at(idx).at(1).at(0) = new-author-str
      }
    }

    // ----- 文献番号をリストに変換 ----- //

    let output_contents = ()
    if bib-sort-ref{//引用された順番に文献を出力
      for value in bib-cite-turn-arr{
        output_contents.push(contents.at(value))
      }
    }
    else{
      if bib-full{
        for value in range(contents.len()){
          output_contents.push(contents.at(value))
        }
      }
      else{
        bib-cite-turn-arr = bib-cite-turn-arr.sorted()
        for value in bib-cite-turn-arr{
          output_contents.push(contents.at(value))
        }
      }
    }

    if bib-full and bib-sort-ref{//全文献を出力
      let num = 0
      for value in contents{
        if bib-cite-turn-arr.contains(num) == false{
          output_contents.push(value)
        }
        num += 1
      }
    }

    // ----- 重複文献に記号を挿入 ----- //

    if vancouver-style == false{//ハーバード方式のとき
      let cite-arr = ()
      for value in output_contents{
        cite-arr.push(value.at(1).join(", "))
      }
      let num = 0
      let remove-num = ()
      for value in cite-arr{
        let num2 = num + 1
        let double_arr = ()
        for value2 in cite-arr.slice(num2){
          if value == value2 and remove-num.contains(num2) == false{
            remove-num.push(num2)
            double_arr.push(num2)
          }
          num2 += 1
        }

        if double_arr != (){//重複があるとき

          double_arr.insert(0, num)
          let num2 = 1

          for value2 in double_arr{
            let add_character = numbering(bib-year-doubling, num2)
            output_contents.at(value2).at(0).insert(1, (add_character, ))
            output_contents.at(value2).at(1).at(1) = output_contents.at(value2).at(1).at(1) + add_character
            num2 += 1
          }
        }

        num += 1
      }
    }

    // ----- リストを出力形式に変換 ----- //

    let num = 1
    let output_bib = ()

    if vancouver-style and bib-vancouver != "manual"{
      for value in output_contents{
        let cite-arr = value.at(1)
        cite-arr.push(value.at(4))
        cite-arr.push(num)
        output_bib.push([+ #figure(text(lang: value.at(4))[#value.at(0).sum().sum()], kind: "bib", supplement: [#cite-arr])#value.at(3)])

        num += 1
      }
    }
    else{
      let bibnum = output_contents.len()
      for value in output_contents{
        let cite-arr = value.at(1)
        cite-arr.push(value.at(4))
        cite-arr.push(num)
        output_bib.push([#figure(text(lang: value.at(4))[#value.at(0).sum().sum()], kind: "bib", supplement: [#cite-arr])#value.at(3)])

        num += 1
      }
    }

    // ----- 出力 ----- //

    if vancouver-style{
      if bib-vancouver == "manual"{
        let output_bib2 = ()
        let cite-arr = ()
        for index in range(num - 1){
          cite-arr = (output_contents.at(index).at(1))
          cite-arr.push(index)
          output_bib2.push(bib-vancouver-manual(cite-arr))
          output_bib2.push(output_bib.at(index))
        }

        table(
          columns: (auto, auto),
          rows: auto,
          gutter: (),
          column-gutter: (),
          row-gutter: (),
          align: (left, left),
          stroke: none,
          fill: none,
          inset: 0% + 5pt,
          ..output_bib2
        )
      }
      else{
        set enum(numbering: bib-vancouver)
        output_bib.sum()
      }
    }
    else{
      set par(
        hanging-indent: hanging-indent,
        first-line-indent: 0em,
        justify: true,
        linebreaks: "optimized",
      )
      output_bib.sum()
    }
  }

}

// --------------------------------------------------
//  MAIN FUNCTION
// --------------------------------------------------

//メイン関数
#let bibliography-list(
  year-doubling: "",
  bib-sort: false,
  bib-sort-ref: false,
  bib-full: false,
  bib-vancouver: "(1)",
  vancouver-style: false,
  bib-year-doubling: "a",
  bib-vancouver-manual: "",
  hanging-indent: 2em,
  bib-cite-author: none,
  title: [文　　　献],
   ..body
  ) = {


  if title != none{
    heading(title, numbering: none)
  }



  // LaTeX-like bibliography styling
  set par(
    first-line-indent: 0em,
    leading: leadingvalue,           //
    spacing: spacingvalue,           // Space between entries
    justify: true,            // Full justification
    linebreaks: "optimized",  // Better line break decisions
  )
  
  // Enable hyphenation for better justification
  set text(hyphenate: true, overhang: true)
  
  // Apply English hyphenation to Latin text within bibliography
  //show regex("[A-Za-z\u0080-\u00FF\u0100-\u017F''\\-]+(\\s+[A-Za-z\u0080-\u00FF\u0100-\u017F''\\-]+)*"): set text(lang: "en", hyphenate: true)

  show figure.where(kind: "bib"): it => {
    set par(
      hanging-indent: 2em,
      first-line-indent: 0em,
      justify: true,
      linebreaks: "optimized",
    )
    set text(hyphenate: true)
    align(left, it.body)
  }

  let bib_content = body
  from-content-to-output(
    year-doubling,
    bib-sort,
    bib-sort-ref,
    bib-full,
    bib-vancouver,
    vancouver-style,
    bib-year-doubling,
    bib-vancouver-manual,
    hanging-indent,
    bib-cite-author,
    bib_content
  )
}

// ---------- 文献形式に出力する関数 ---------- //
#let bib-tex(
    year-doubling: "",
    bibtex-article-en: (),
    bibtex-article-ja: (),
    bibtex-book-en: (),
    bibtex-book-ja: (),
    bibtex-booklet-en: (),
    bibtex-booklet-ja: (),
    bibtex-inbook-en: (),
    bibtex-inbook-ja: (),
    bibtex-incollection-en: (),
    bibtex-incollection-ja: (),
    bibtex-inproceedings-en: (),
    bibtex-inproceedings-ja: (),
    bibtex-conference-en: (),
    bibtex-conference-ja: (),
    bibtex-manual-en: (),
    bibtex-manual-ja: (),
    bibtex-mastersthesis-en: (),
    bibtex-mastersthesis-ja: (),
    bibtex-misc-en: (),
    bibtex-misc-ja: (),
    bibtex-online-en: (),
    bibtex-online-ja: (),
    bibtex-phdthesis-en: (),
    bibtex-phdthesis-ja: (),
    bibtex-proceedings-en: (),
    bibtex-proceedings-ja: (),
    bibtex-techreport-en: (),
    bibtex-techreport-ja: (),
    bibtex-unpublished-en: (),
    bibtex-unpublished-ja: (),
    bib-cite-author: (),
    bib-cite-year: (),
    lang: auto,
    dict: none,
    it
  ) = {
  let dict = if dict != none { dict } else { bibtex-to-dict(it) }
  let dict = add-dict-lang(dict, lang)

  let output_arr = ()
  let bib_element_function = get-element-function(
    bibtex-article-en,
    bibtex-article-ja,
    bibtex-book-en,
    bibtex-book-ja,
    bibtex-booklet-en,
    bibtex-booklet-ja,
    bibtex-inbook-en,
    bibtex-inbook-ja,
    bibtex-incollection-en,
    bibtex-incollection-ja,
    bibtex-inproceedings-en,
    bibtex-inproceedings-ja,
    bibtex-conference-en,
    bibtex-conference-ja,
    bibtex-manual-en,
    bibtex-manual-ja,
    bibtex-mastersthesis-en,
    bibtex-mastersthesis-ja,
    bibtex-misc-en,
    bibtex-misc-ja,
    bibtex-online-en,
    bibtex-online-ja,
    bibtex-phdthesis-en,
    bibtex-phdthesis-ja,
    bibtex-proceedings-en,
    bibtex-proceedings-ja,
    bibtex-techreport-en,
    bibtex-techreport-ja,
    bibtex-unpublished-en,
    bibtex-unpublished-ja,
    dict
  )
  output_arr.push(bibtex-to-bib(year-doubling, dict, bib_element_function))

  let element_cite_list = bibtex-to-cite(
    bib-cite-author,
    bib-cite-year,
    dict
  )
  output_arr.push(element_cite_list)
  output_arr.push(bibtex-yomi(dict, output_arr.at(0)))
  output_arr.push(dict.label)
  output_arr.push(dict.lang)
  output_arr.push(dict)  // Store raw dict for later disambiguation

  return output_arr
}

#let bib-item(it, author: "", year: "", yomi: none, label: none, lang: "ja") = {

  let output_arr = ()
  let bib_str = ""
  if type(it) == content or type(it) == str{
    output_arr.push(((it, ),))
    if type(it) == content{
      bib_str = contents-to-str(it)
    }
    else{
      bib_str = it
    }
  }
  else{
    let output_bib = ()
    for v in it{
      output_bib.push((v, ))
    }
    output_arr.push(output_bib)
    bib_str = it.sum()
    if type(bib_str) == content{
      bib_str = contents-to-str(bib_str)
    }
  }

  output_arr.push((author, year))
  if yomi == none{
    output_arr.push(bib_str)
  }
  else{
    output_arr.push(yomi)
  }
  output_arr.push(label)
  output_arr.push(lang)

  return output_arr
}

#let bib-file(
  year-doubling: "",
  bibtex-article-en: (),
  bibtex-article-ja: (),
  bibtex-book-en: (),
  bibtex-book-ja: (),
  bibtex-booklet-en: (),
  bibtex-booklet-ja: (),
  bibtex-inbook-en: (),
  bibtex-inbook-ja: (),
  bibtex-incollection-en: (),
  bibtex-incollection-ja: (),
  bibtex-inproceedings-en: (),
  bibtex-inproceedings-ja: (),
  bibtex-conference-en: (),
  bibtex-conference-ja: (),
  bibtex-manual-en: (),
  bibtex-manual-ja: (),
  bibtex-mastersthesis-en: (),
  bibtex-mastersthesis-ja: (),
  bibtex-misc-en: (),
  bibtex-misc-ja: (),
  bibtex-online-en: (),
  bibtex-online-ja: (),
  bibtex-phdthesis-en: (),
  bibtex-phdthesis-ja: (),
  bibtex-proceedings-en: (),
  bibtex-proceedings-ja: (),
  bibtex-techreport-en: (),
  bibtex-techreport-ja: (),
  bibtex-unpublished-en: (),
  bibtex-unpublished-ja: (),
  bib-cite-author: (),
  bib-cite-year: (),
  lang: auto,
  file_contents
) = {

  let file_arr = file_contents.split(regex("(^|[^\\\\])@"))
  let output-arr = ()
  for value in file_arr{
    let tmp = value.starts-with("comment")
    if value.starts-with(regex("(?i)article|book|booklet|inbook|incollection|inproceedings|conference|manual|mastersthesis|misc|online|phdthesis|proceedings|techreport|unpublished")){
      output-arr.push("@" + value)
    }
  }

  // Parse all entries and normalize language
  // NOTE: We do NOT run analyze-authors here. Disambiguation is done in
  // from-content-to-output after we know which entries are actually cited.
  let dicts = ()
  for value in output-arr {
     let dict = bibtex-to-dict(value)
     dict = add-dict-lang(dict, lang)
     dicts.push(dict)
  }

  let output-bib = ()

  for (i, value) in output-arr.enumerate(){
    output-bib.push(bib-tex(
      year-doubling: year-doubling,
      bibtex-article-en: bibtex-article-en,
      bibtex-article-ja: bibtex-article-ja,
      bibtex-book-en: bibtex-book-en,
      bibtex-book-ja: bibtex-book-ja,
      bibtex-booklet-en: bibtex-booklet-en,
      bibtex-booklet-ja: bibtex-booklet-ja,
      bibtex-inbook-en: bibtex-inbook-en,
      bibtex-inbook-ja: bibtex-inbook-ja,
      bibtex-incollection-en: bibtex-incollection-en,
      bibtex-incollection-ja: bibtex-incollection-ja,
      bibtex-inproceedings-en: bibtex-inproceedings-en,
      bibtex-inproceedings-ja: bibtex-inproceedings-ja,
      bibtex-conference-en: bibtex-conference-en,
      bibtex-conference-ja: bibtex-conference-ja,
      bibtex-manual-en: bibtex-manual-en,
      bibtex-manual-ja: bibtex-manual-ja,
      bibtex-mastersthesis-en: bibtex-mastersthesis-en,
      bibtex-mastersthesis-ja: bibtex-mastersthesis-ja,
      bibtex-misc-en: bibtex-misc-en,
      bibtex-misc-ja: bibtex-misc-ja,
      bibtex-online-en: bibtex-online-en,
      bibtex-online-ja: bibtex-online-ja,
      bibtex-phdthesis-en: bibtex-phdthesis-en,
      bibtex-phdthesis-ja: bibtex-phdthesis-ja,
      bibtex-proceedings-en: bibtex-proceedings-en,
      bibtex-proceedings-ja: bibtex-proceedings-ja,
      bibtex-techreport-en: bibtex-techreport-en,
      bibtex-techreport-ja: bibtex-techreport-ja,
      bibtex-unpublished-en: bibtex-unpublished-en,
      bibtex-unpublished-ja: bibtex-unpublished-ja,
      bib-cite-author: bib-cite-author,
      bib-cite-year: bib-cite-year,
      dict: dicts.at(i),
      value)
    )
  }

  return output-bib
}
