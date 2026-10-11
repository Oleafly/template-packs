// ライブラリ
#import "@preview/physica:0.9.3": *
#import "@preview/gentle-clues:0.7.1": *
#import "@preview/zero:0.3.0": *
#import "@preview/unify:0.6.0": *
#import "@preview/quick-maths:0.1.0": shorthands

// 設定
#import "../contents/config.typ": *

// 種々のカスタム表示
//// 和欧混植のフォント別々指定 (本文)
#let mixed(it, rmn_font, ja_font) = {
  // 英数字のフォント指定
  set text(font: rmn_font)
  // 日本語のフォント指定
  show regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]"): set text(font: ja_font)
  it
}

//// 和欧混植のフォント別々指定 (見出し)
#let mixed_bold(it, rmn_font, ja_font) = {
  // 英数字のフォント指定
  set text(font: rmn_font)
  set text(weight: "extrabold")
  // 日本語のフォント指定
  show regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]"): set text(font: ja_font, weight: "bold")
  it
}

//// 見出しのデザイン
#let headline(it) = {
  mixed_bold(it, font_type.roman, font_type.ja_title)
  text(size: 0pt, " ")
  v(0.5em, weak: true)
}

//// 年の表示を制御する関数
#let format_year(year, convert_flag, is_academic_year) = {
  if convert_flag {
    // 変換するフラグがtrueの場合、和暦に変換
    if year >= 1989 and year <= 2019 {
      // 平成対応（1989年〜2019年）
      let jp_year = year - 1988
      if is_academic_year {
        jp_year = str(jp_year - 1)
        "平成 " + jp_year + " 年度" // 年度として表示
      } else {
        jp_year = str(jp_year)
        "平成 " + jp_year + " 年" // 年として表示
      }
    } else if year >= 2019 {
      // 令和対応（2019年以降）
      let jp_year = year - 2018
      if is_academic_year {
        jp_year = str(jp_year - 1)
        "令和 " + jp_year + " 年度" // 年度として表示
      } else {
        jp_year = str(jp_year)
        "令和 " + jp_year + " 年" // 年として表示
      }
    } else {
      "年号エラー" // それ以外の年はエラー表示
    }
  } else {
    // 変換しない場合、元の西暦年を返す
    if is_academic_year {
      str(year - 1) + " 年度"
    } else {
      str(year) + " 年"
    }
  }
}

////カラーリンク
#let blue_link(lnk, txt) = {
  link(lnk)[#text(fill: blue, txt)]
}

//// 図のパス
#let ipath(it) = {
  "../figs/" + it
}

//// インデント
#let i = h(1em)

// 数式

