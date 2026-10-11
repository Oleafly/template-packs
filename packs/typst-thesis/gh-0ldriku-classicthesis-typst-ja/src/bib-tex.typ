// This file includes code from [enja-bib] by [tkrhsmt]
// Licensed under the MIT License: https://opensource.org/licenses/MIT
// Copyright (c) 2024 tkrhsmt
#import "bib-setting-fucntion.typ": *

//---------- 文字列から，最初の{までを取り除く関数 ---------- //
#let remove-brace-l(text, remove_str: "{") = {

  // 出力文字列
  let output_str = ""
  // {で分割
  output_str = text.split(remove_str)
  // 最初の要素を削除
  output_str.remove(0)
  // 最初の{以降を返す
  return output_str.sum()
}

//---------- 文字列から，最後の}までを取り入れる関数 ---------- //
#let remove-brace-r(text, remove_str: "}") = {

  // 出力文字列
  let output_str = ""
  // {で分割
  output_str = text.split(remove_str)
  // 最初の要素のみを返す
  return output_str.at(0)
}

//---------- 文字列の一部から，ラベル名を取得する関数 ---------- //
#let text-to-label(bib_text) = {

  // 出力文字列
  let output_str = ""
  // 出力bool
  let output_bool = true

  if bib_text.contains("{") {//文字列に{が含まれる場合
    // {を削除した文字列を取得
    output_str = remove-brace-l(bib_text)
  }
  else {
    // {が含まれない場合，そのまま代入
    output_str = bib_text
  }

  if output_str.contains(",") {//出力文字列に,が含まれる場合
    // ,で分割し，最初の要素を取得
    output_str = output_str.split(",").at(0)
    // ラベル名を全て取得完了
    output_bool = false
  }

  return (output_str, output_bool)

}

//---------- 文字列の一部から，辞書型に変換する関数 ---------- //

#let text-to-dict(bib_text, contents_num, brace_num) = {

  let name_list = ()//名前のリスト
  let contents = ()//内容のリスト
  let tmp_str = ""//一時保存用
  let num = contents_num//現在の位置
  let num_list = (num,)//位置のリスト

  for value in bib_text{//一文字ずつ取得

    if num == 1{//位置が1のとき
      if value == "=" {//=のとき，名前が全て取得完了
        name_list.push(tmp_str)
        tmp_str = ""
        num = 2//位置を2に変更
        num_list.push(num)
      }
      else{//それ以外のとき，名前を追加
        tmp_str += value
      }
    }
    else if num == 2{//位置が2のとき
      if value == "{"{//{のとき，位置を3に変更
        num = 3
        num_list.push(num)
      }
    }
    else if num == 3{//位置が3のとき
      if value == "}" and brace_num == 1{//}かつ外側の括弧であるとき
        contents.push(tmp_str)
        tmp_str = ""
        num = 4//位置を4に変更
        num_list.push(num)
      }
      else{//それ以外のとき
        if value == "{"{//{のとき，これ以降は括弧の内側となる
          brace_num += 1
        }
        else if value == "}"{//}のとき，これ以降は括弧の外側となる
          brace_num -= 1
        }
        tmp_str += value//文字列の追加
      }
    }
    else if num == 4{//位置が4のとき
      if value == ","{// ,のとき，位置を1に変更
        num = 1
        num_list.push(num)
      }
    }
  }

  if tmp_str != ""{//最後の文字列を追加
    if num == 3{//位置が3のとき，contentsに追加
      contents.push(tmp_str)
    }
    else if num == 1{//位置が1のとき，name_listに追加
      name_list.push(tmp_str)
    }
  }

  return (name_list, contents, num, num_list, brace_num)
}

//---------- 文字列に日本語が含まれるかを判定する関数 ---------- //

#let check-japanese-tex-str(str) = {
  return (regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]") in str)
}

//---------- 文献リストに日本語が含まれるかを判定する関数 ---------- //

#let check-japanese-tex(bibtex) = {

  let bib_arr = bibtex.pairs()

  for value in bib_arr{
    let field_name = value.at(0)
    // Skip label and j-prefixed fields (jauthor, jtitle, jyear, jpublisher, jnote, etc.)
    // j-prefixed fields are for translation info and shouldn't affect language detection
    if field_name != "label" and not field_name.starts-with("j") {
      let tmp = value.at(1)

      if type(tmp) == array{
        tmp = tmp.sum()
      }

      if type(tmp) == content{
        tmp = contents-to-str(tmp)
      }

      if check-japanese-tex-str(tmp){
        return true
      }
    }
  }
  return false
}

//---------- 文献リストにlang要素を加える関数 ---------- //

#let add-dict-lang(biblist, lang) = {

  let output_list = biblist
  let check_exist_lang = biblist.at("lang", default: "")

  if check_exist_lang != ("en",) and check_exist_lang != ("ja",){

    if lang == auto or lang != "ja" or lang != "en"{
      if check-japanese-tex(biblist){
        output_list.insert("lang", "ja")
      }
      else{
        output_list.insert("lang", "en")
      }
    }
    else{
      output_list.insert("lang", lang)
    }

  }
  else{
    output_list.insert("lang", check_exist_lang.at(0))
  }

  return output_list
}

//---------- bibtexの文字列から辞書型を返す関数 ---------- //

#let bibtex-to-dict(bibtex_raw) = {

  let contents_num = 0
  let remove_bite = 0
  let target_name = ""
  let label_name = ""
  let bibtex_str = bibtex_raw

  if type(bibtex_str) != str{
    bibtex_str = bibtex_str.text
  }

  for value in bibtex_str{

    if contents_num == 0{
      if value == "@"{ contents_num = 1 }
    }
    else if contents_num == 1{
      if value == "{"{
        contents_num = 2
      }
      else{
        target_name += value
      }
    }
    else if contents_num == 2{
      if value == ","{
        remove_bite += value.len()
        break
      }
      else{
        label_name += value
      }
    }
    remove_bite += value.len()
  }

  let bibtex = bibtex_str.slice(remove_bite)

  bibtex = bibtex.replace("\\{", "#text(weight:\"regular\")[{]")
  bibtex = bibtex.replace("\\}", "#text(weight:\"regular\")[}]")

  bibtex = eval(bibtex, mode: "markup")

  // dictionaryの作成
  let biblist = (target : lower(target_name), label : label(label_name))
  let contents_num = 1 //現在の位置
                       // hoge = { hoge } ,
                       //1      2 3      4
  let label_name = "" // ラベル名
  let contents = () // 項目の一時保存
  let contents_list = () // 項目のリスト
  let contents_name = ""
  let brace_num = 1//括弧の数

  for value in bibtex.children{

    if value.has("text"){//テキストの場合

      contents = text-to-dict(value.text, contents_num, brace_num)//辞書型に変換

      for value_num in contents.at(3){//辞書へ順番に代入

        if value_num == 1 and contents.at(0) != (){//1のとき，名前を代入
          contents_name += contents.at(0).remove(0)
        }
        else if value_num == 2{//2のとき，括弧をリセットする
          brace_num = 1
        }
        else if value_num == 3 and contents.at(1) != (){//3のとき，内容を代入
          contents_list.push(contents.at(1).remove(0))
        }
        else if value_num == 4 and contents_name != "" and contents_list != (){//4のとき，項目を辞書に追加
          biblist.insert(lower(contents_name), contents_list)
          contents_name = ""
          contents_list = ()
        }
      }
      // 次の位置へ
      contents_num = contents.at(2)
      brace_num = contents.at(4)
    }
    else if value == smartquote(double: true){//ダブルクォートの場合，{や}と同様にcontents_numを変更
        if contents_num == 2{
          contents_num = 3
        }
        else if contents_num == 3{
          contents_num = 4
        }
    }
    else if contents_num == 3{//括弧の内側の場合，contents_listに追加
      if value.has("dest"){//URLなどは，その中身の文字列を取得
        contents_list.push(value.dest)
      }
      else{//それ以外の場合，そのまま追加
        contents_list.push(value)
      }
    }
  }

  return biblist
}

//---------- 要素の関数を取得 ---------- //
#let get-element-function(
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
  biblist
) = {

  let element_function = none

  if biblist.target == "article"{//articleの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-article-en
    }
    else{//日本語の場合
      element_function = bibtex-article-ja
    }
  }
  else if biblist.target == "book"{//bookの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-book-en
    }
    else{//日本語の場合
      element_function = bibtex-book-ja
    }
  }
  else if biblist.target == "booklet"{//bookletの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-booklet-en
    }
    else{//日本語の場合
      element_function = bibtex-booklet-ja
    }
  }
  else if biblist.target == "inbook"{//inbookの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-inbook-en
    }
    else{//日本語の場合
      element_function = bibtex-inbook-ja
    }
  }
  else if biblist.target == "incollection"{//incollectionの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-incollection-en
    }
    else{//日本語の場合
      element_function = bibtex-incollection-ja
    }
  }
  else if biblist.target == "inproceedings"{//inproceedingsの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-inproceedings-en
    }
    else{//日本語の場合
      element_function = bibtex-inproceedings-ja
    }
  }
  else if biblist.target == "conference"{//inproceedingsの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-conference-en
    }
    else{//日本語の場合
      element_function = bibtex-conference-ja
    }
  }
  else if biblist.target == "manual"{//manualの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-manual-en
    }
    else{//日本語の場合
      element_function = bibtex-manual-ja
    }
  }
  else if biblist.target == "mastersthesis"{//mastersthesisの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-mastersthesis-en
    }
    else{//日本語の場合
      element_function = bibtex-mastersthesis-ja
    }
  }
  else if biblist.target == "misc"{//miscの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-misc-en
    }
    else{//日本語の場合
      element_function = bibtex-misc-ja
    }
  }
  else if biblist.target == "online"{//onlineの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-online-en
    }
    else{//日本語の場合
      element_function = bibtex-online-ja
    }
  }
  else if biblist.target == "phdthesis"{//phdthesisの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-phdthesis-en
    }
    else{//日本語の場合
      element_function = bibtex-phdthesis-ja
    }
  }
  else if biblist.target == "proceedings"{//proceedingsの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-proceedings-en
    }
    else{//日本語の場合
      element_function = bibtex-proceedings-ja
    }
  }
  else if biblist.target == "techreport"{//techreportの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-techreport-en
    }
    else{//日本語の場合
      element_function = bibtex-techreport-ja
    }
  }
  else if biblist.target == "unpublished"{//unpublishedの場合
    if biblist.lang == "en"{//英語の場合
      element_function = bibtex-unpublished-en
    }
    else{//日本語の場合
      element_function = bibtex-unpublished-ja
    }
  }

  return element_function
}

//---------- 文献リストを文献に変換 ---------- //
#let bibtex-to-bib(year-doubling, biblist, element_function) = {

  let output_list_bef = ()//出力リスト(仮)
  let interval_str = ""//要素間の文字列
  let bef_element = ""//前の要素
  let element_num = 0//要素の数
  let element_total_num = 0//全要素数

  for bibitem in element_function{
    let tmp = biblist.at(bibitem.at(0), default: "")
    if tmp != "" and tmp != ("",){//要素が存在する場合
      element_total_num += 1
    }
  }

  for bibitem in element_function{// 各要素に対して処理
    let tmp = biblist.at(bibitem.at(0), default: none)
    if tmp != none and tmp != ("",){// 要素が存在する場合
    element_num += 1

      //条件を満たすとき，前の要素間文字列を新しい文字列に置き換える
      if bibitem.at(1).at(5).contains(bef_element) and bibitem.at(1).at(0) != none{
        interval_str = bibitem.at(1).at(0)
      }
      //先頭に文字列を追加
      interval_str += bibitem.at(1).at(1)
      output_list_bef.push(interval_str)

      //要素を追加
      output_list_bef.push(bibitem.at(1).at(2)(biblist, bibitem.at(0)))

      //要素後に文字列を追加
      if element_num != element_total_num{//最後の要素でないとき
        output_list_bef.push(bibitem.at(1).at(3))
        interval_str = bibitem.at(1).at(4)
      }
      else{//最後の要素のとき
        output_list_bef.push(bibitem.at(1).at(6))
      }

      //前の要素を更新
      bef_element = bibitem.at(0)
    }
  }

  element_num = 0
  let bef_str = false//直前の要素が文字列かどうか
  let contain_str = ""
  let output_list = ()

  for value in output_list_bef{
    if value != ""{
      let outputvalue = value

      if bef_str or type(outputvalue) == str{
        if type(outputvalue) == str{
          contain_str += outputvalue
        }
        else {
          output_list.push(contain_str)
          output_list.push(outputvalue)
          contain_str = ""
        }
      }
      else{
        output_list.push(outputvalue)
      }

      if type(outputvalue) == str{
        bef_str = true
      }
      else{
        bef_str = false
      }
    }

    element_num += 1
  }

  if bef_str{
      output_list.push(contain_str)
      contain_str = ""
  }

  let outputlist = ()
  output_list_bef = ()
  for value in output_list{
    if type(value) == str{
      let tmp = value.split(year-doubling)
      if tmp.len() == 1{
        output_list_bef.push(eval(value, mode: "markup"))
      }
      else{
        output_list_bef.push(eval(tmp.at(0), mode: "markup"))
        outputlist.push(output_list_bef)
        output_list_bef = ()
        output_list_bef.push(eval(tmp.at(1), mode: "markup"))
      }
    }
    else{
      output_list_bef.push(value)
    }
  }
  outputlist.push(output_list_bef)

  return outputlist
}

//---------- citeを作成する関数 ---------- //
#let bibtex-to-cite(
  bib-cite-author,
  bib-cite-year,
  biblist
  ) = {

  let cite_list = ()

  //citet - author
  cite_list.push(bib-cite-author(biblist, "author"))
  //citep - year
  cite_list.push(bib-cite-year(biblist, "year"))
  
  // Translation info for translated books (jauthor, jyear)
  // Format: 田中・東山訳 2020 or 田中他訳 2020 (for 3+ translators)
  if biblist.at("jauthor", default: none) != none and biblist.at("jyear", default: none) != none {
    // Get jauthor (translators)
    let jauthor = biblist.at("jauthor").sum()
    if type(jauthor) == content {
      jauthor = contents-to-str(jauthor)
    }
    // Parse jauthor names (format: 姓 名 and 姓 名)
    let translator_names = ()
    let parts = jauthor.split(regex(" and | ＆ |・"))
    for part in parts {
      let name_parts = part.trim().split(regex(",\\s*|\\s+"))
      if name_parts.len() > 0 {
        translator_names.push(name_parts.at(0)) // surname only
      }
    }
    
    // Apply Japanese abbreviation rules: 2 = join with ・, 3+ = first + 他
    let translator_str = ""
    if translator_names.len() == 1 {
      translator_str = translator_names.at(0) + "訳"
    } else if translator_names.len() == 2 {
      translator_str = translator_names.join("・") + "訳"
    } else {
      // 3 or more translators: first name + 他訳
      translator_str = translator_names.at(0) + "他訳"
    }
    
    // Get jyear
    let jyear = biblist.at("jyear").sum()
    if type(jyear) == content {
      jyear = contents-to-str(jyear)
    }
    
    cite_list.push(translator_str)
    cite_list.push(jyear)
  } else {
    cite_list.push(none)
    cite_list.push(none)
  }

  return cite_list
}

//---------- 並び替えのための読み仮名 ---------- //
#let bibtex-yomi(biblist, bib_arr) = {

  let yomi = ""
  let bib_str = contents-to-str(bib_arr.sum().sum())

  if biblist.at("yomi", default: "") != ""{
    yomi = biblist.at("yomi").sum()
  }
  else{
    yomi = bib_str
  }

  if type(yomi) == content{
    yomi = contents-to-str(yomi)
  }

  yomi = yomi.replace("{", "")
  yomi = yomi.replace("}", "")
  yomi = lower(yomi)

  return yomi
}

// ---------- 著者の曖昧性解消のための分析関数 ---------- //
#let analyze-authors(dicts) = {
  let surname-map = (:)
  let updates = (:) // Map of "index_str" -> (key: value, ...)

  // Helper to add update
  let add-update = (updates, i, key, value) => {
      let idx = str(i)
      let current = updates.at(idx, default: (:))
      current.insert(key, value)
      updates.insert(idx, current)
      return updates
  }

  // 1. Group by first author surname
  for (i, dict) in dicts.enumerate() {
    if "author" in dict {
      let author-arr = author-make-arr(dict, "author")
      if author-arr.len() > 0 {
        let first-author = author-arr.at(0)
        let surname = first-author.at(0)
        
        // Normalize surname (remove braces, lowercase)
        let surname-key = lower(surname.replace("{", "").replace("}", "").trim())
        
        if surname-key in surname-map {
          surname-map.at(surname-key).push(i)
        } else {
          surname-map.insert(surname-key, (i,))
        }
      }
    }
  }

  // 2. Analyze same-surname disambiguation (English/General)
  // Rule: Only disambiguate when SAME surname AND SAME year
  // 「異なる著者で，同一姓，同一年の文献の引用があり，混同の恐れのある場合」
  for (key, indices) in surname-map {
    if indices.len() > 1 {
        // Group by year first
        let year-groups = (:)
        for i in indices {
           let dict = dicts.at(i)
           let year-val = dict.at("year", default: "")
           if type(year-val) == array { year-val = year-val.sum() }
           if type(year-val) == content {
             year-val = if year-val.has("text") { year-val.text } else { repr(year-val) }
           }
           let year = str(year-val)
           
           if year in year-groups {
              year-groups.at(year).push(i)
           } else {
              year-groups.insert(year, (i,))
           }
        }
        
        // Now for each year group, check if there are different authors
        for (year, y-indices) in year-groups {
           if y-indices.len() > 1 {
              // Multiple entries with same surname AND same year
              // Check if they're actually different people (different full names)
              let fullname-groups = (:)
              for i in y-indices {
                 let dict = dicts.at(i)
                 let author-arr = author-make-arr(dict, "author")
                 let first-author = author-arr.at(0)
                 let surname = first-author.at(0)
                 let firstname = if first-author.len() > 1 { first-author.at(1) } else { "" }
                 let fullname = surname + ", " + firstname
                 
                 if fullname in fullname-groups {
                    fullname-groups.at(fullname).push(i)
                 } else {
                    fullname-groups.insert(fullname, (i,))
                 }
              }
              
              if fullname-groups.len() > 1 {
                 // We have different people with same surname AND same year
                 
                 // Check initials
                 let initial-groups = (:)
                 for (fname, f-indices) in fullname-groups {
                    let parts = fname.split(", ")
                    let firstname = if parts.len() > 1 { parts.at(1) } else { "" }
                    let initial = if firstname.len() > 0 { firstname.first() } else { "" }
                    let initial-key = lower(initial)

                    if initial-key in initial-groups {
                       initial-groups.at(initial-key).push(f-indices)
                    } else {
                       initial-groups.insert(initial-key, (f-indices,))
                    }
                 }
                 
                 // Apply rules
                 for (init, groups-of-indices) in initial-groups {
                    if groups-of-indices.len() > 1 {
                       // Multiple people with same surname, same year, AND same initial
                       for group in groups-of-indices {
                          for i in group {
                             updates = add-update(updates, i, "disambiguate", "fullname")
                          }
                       }
                    } else {
                       // Different initials - use initials for English, full name for Japanese
                       for group in groups-of-indices {
                          for i in group {
                             let dict = dicts.at(i)
                             if dict.at("lang", default: "en") == "ja" {
                                 updates = add-update(updates, i, "disambiguate", "fullname")
                             } else {
                                 updates = add-update(updates, i, "disambiguate", "initials")
                             }
                          }
                       }
                    }
                 }
              }
           }
        }
     }
  }

  // 3. Analyze Japanese "et al." ambiguity
  let ja-first-author-map = (:)
  
  for (i, dict) in dicts.enumerate() {
     if dict.at("lang", default: "en") == "ja" {
        let author-arr = author-make-arr(dict, "author")
        if author-arr.len() > 2 { // Only applies to 3+ authors
           let first-author = author-arr.at(0)
           let surname = first-author.at(0)
           let key = lower(surname.replace("{", "").replace("}", "").trim())
           
           if key in ja-first-author-map {
              ja-first-author-map.at(key).push(i)
           } else {
              ja-first-author-map.insert(key, (i,))
           }
        }
     }
  }
  
  for (key, indices) in ja-first-author-map {
     if indices.len() > 1 {
        let year-groups = (:)
         for i in indices {
            let dict = dicts.at(i)
            let year-val = dict.at("year", default: "")
            // Year field may be an array like ("2020",), extract the value
            if type(year-val) == array {
              year-val = year-val.sum()
            }
            if type(year-val) == content {
              year-val = if year-val.has("text") { year-val.text } else { repr(year-val) }
            }
            let year = str(year-val)
           if year in year-groups {
              year-groups.at(year).push(i)
           } else {
              year-groups.insert(year, (i,))
           }
        }
        
        for (year, y-indices) in year-groups {
           if y-indices.len() > 1 {
              for i in y-indices {
                 let dict_i = dicts.at(i)
                 let authors_i = author-make-arr(dict_i, "author")
                 let min_show = 1
                 
                 for j in y-indices {
                    if i == j { continue }
                    let dict_j = dicts.at(j)
                    let authors_j = author-make-arr(dict_j, "author")
                    
                    let k = 0
                    let limit = calc.min(authors_i.len(), authors_j.len())
                    while k < limit {
                       let name_i = authors_i.at(k).at(0) 
                       let name_j = authors_j.at(k).at(0)
                       if name_i != name_j {
                          break
                       }
                       k += 1
                    }
                    if k < limit {
                       if k + 1 > min_show {
                          min_show = k + 1
                       }
                    }
                 }
                 
                 if min_show == authors_i.len() - 1 {
                    min_show = authors_i.len()
                 }
                 
                 updates = add-update(updates, i, "show_count", min_show)
              }
           }
        }
     }
  }

  // 4. Analyze English "et al." ambiguity (APA 8.18)
  // When two references have the same first author plus year, and 3+ authors,
  // list as many authors as needed to distinguish, followed by ", et al."
  // If only the last author differs, list all authors (since "et al." can't stand for one person)
  let en-first-author-map = (:)
  
  for (i, dict) in dicts.enumerate() {
     if dict.at("lang", default: "en") == "en" {
        let author-arr = author-make-arr(dict, "author")
        if author-arr.len() > 2 { // Only applies to 3+ authors (would normally use et al.)
           let first-author = author-arr.at(0)
           let surname = first-author.at(0)
           let key = lower(surname.replace("{", "").replace("}", "").trim())
           
           if key in en-first-author-map {
              en-first-author-map.at(key).push(i)
           } else {
              en-first-author-map.insert(key, (i,))
           }
        }
     }
  }
  
  for (key, indices) in en-first-author-map {
     if indices.len() > 1 {
        let year-groups = (:)
        for i in indices {
           let dict = dicts.at(i)
           let year-val = dict.at("year", default: "")
           if type(year-val) == array { year-val = year-val.sum() }
           if type(year-val) == content {
             year-val = if year-val.has("text") { year-val.text } else { repr(year-val) }
           }
           let year = str(year-val)
           if year in year-groups {
              year-groups.at(year).push(i)
           } else {
              year-groups.insert(year, (i,))
           }
        }
        
        for (year, y-indices) in year-groups {
           if y-indices.len() > 1 {
              // Multiple entries with same first author AND same year
              for i in y-indices {
                 let dict_i = dicts.at(i)
                 let authors_i = author-make-arr(dict_i, "author")
                 let min_show = 1
                 
                 for j in y-indices {
                    if i == j { continue }
                    let dict_j = dicts.at(j)
                    let authors_j = author-make-arr(dict_j, "author")
                    
                    // Find first differing author
                    let k = 0
                    let limit = calc.min(authors_i.len(), authors_j.len())
                    while k < limit {
                       let name_i = authors_i.at(k).at(0)
                       let name_j = authors_j.at(k).at(0)
                       if name_i != name_j {
                          break
                       }
                       k += 1
                    }
                    if k < limit {
                       if k + 1 > min_show {
                          min_show = k + 1
                       }
                    }
                 }
                 
                 // APA 8.18: "et al." is plural, can't stand for a single person
                 // If showing min_show would leave only 1 author remaining, show all
                 if min_show >= authors_i.len() - 1 {
                    min_show = authors_i.len()
                 }
                 
                 updates = add-update(updates, i, "en_show_count", min_show)
              }
           }
        }
     }
  }

  // Apply all updates
  let new-dicts = ()
  for (i, dict) in dicts.enumerate() {
      if str(i) in updates {
          let new-dict = dict
          let u = updates.at(str(i))
          for (k, v) in u {
              new-dict.insert(k, v)
          }
          new-dicts.push(new-dict)
      } else {
          new-dicts.push(dict)
      }
  }

  return new-dicts
}
