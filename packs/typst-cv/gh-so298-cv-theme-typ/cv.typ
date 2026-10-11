#set page("a4")
#import "./theme.typ": *

#show: cv

#set text(font: ja_sans, size: 10pt, lang: "ja")

#title("なまえ")
#info("Phone", "xxx-xxxx-xxxx")
#info("E-Mail", link("mailto:mail@example.com", "mail@example.com"))
#info("GitHub", link("https://github.com/your_user_name")[your_user_name])

#v(5pt)

= 経歴


== 学歴

#cventry("2020/04 - 2024/03", "すごい大学", "卒業", [
  - ここに説明を書くことができます。
])

== 職務経験

#cventry("2020/12 - 2022/03", "やばい会社", "アルバイト", [
  - 仕事内容の説明。
])

== その他

#cventry("2020/12 - 2022/03", "すごい賞", "", [
  - 内容の説明。
])

= スキルと興味

== トピック

説明文。
