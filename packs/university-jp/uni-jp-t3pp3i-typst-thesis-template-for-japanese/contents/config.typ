// 紙面の基本情報
#let TITLE = "Typst Thesis Template" // タイトル
#let AUTHOR = "魚民" // 著者名
#let UNIV = "京都大学大学院" // 大学名
#let SCH = "工学研究科" // 研究科・学部名
#let DEPT = "機械理工学専攻" // 専攻・学科名
#let LAB = "サウンドアラウンド研究室" // 研究室名
#let DEGREE = "修士" // 学位
#let MENTOR = "指導教官" // 指導教員名
#let YEAR = 2025 // 提出年(西暦)
#let MONTH = 3 // 提出月
#let DAY = 15 // 提出日

// 表示するコンテンツの設定
#let COVER = true // 表紙の表示 true or false
#let ABS_JA = true // 日本語の概要 true or false
#let TOC = true // 目次の表示 true or false

// 全体の体裁設定
#let paper_size = "a4" // ページサイズ
#let line_space = 1em // 行間の大きさ
#let margin_top = 1in // 上余白
#let margin_bottom = 1in // 下余白
#let margin_left = 1in // 左余白
#let margin_right = 1in // 右余白
#let auto_pagebreak = true // 章のごとにページを自動で更新 true or false
#let convert_jp_year = true // 和暦に変換 true or false
#let academic_year = true // 年度で表示 true or false
#let font_type = (
  roman: "Times New Roman", // 英数字
  math: "New Computer Modern Math", // 数式
  ja_text: "Noto Serif JP", // 日本語:本文
  ja_title: "Noto Sans JP", // 日本語:タイトル
)// フォントの指定
#let font_size = (chapter: 18pt, section: 14pt, subsection: 12pt, text: 10.5pt)// フォントサイズの指定

// 数式、図表の体裁設定
#let chapt_eq_count = true // 数式番号の数え方 true: 章ごとにリセット,false: 通し番号
#let chapt_fig_count = true // 図表番号の数え方 true: 章ごとにリセット,false: 通し番号
#let eq_suppl = "式" // 数式のキャプションの接頭語
#let imgtbl_suppl_bold = true // 図表番号を太字にするかどうか true or false
#let image_suppl = "FIGURE" // 図のキャプションの接頭語
#let image_suppl_ref = "図" // 文中での図の参照の接頭語
#let table_suppl = "TABLE" // 表のキャプションの接頭語
#let table_suppl_ref = "表" // 文中での表の参照の接頭語

// 参考文献の設定 https://typst.app/docs/reference/model/bibliography/
#let bib_style = "american-physics-society" // 参考文献のスタイル
#let bib_file_path = "ref.bib" // 参考文献ファイルパス

