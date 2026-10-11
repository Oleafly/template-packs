#import "template.typ": doujinshi
#import "@preview/codelst:2.0.2": sourcecode

#show: doujinshi.with(
  title: [typstで作る同人誌],
  subtitle: [簡単＆軽量なtypstで本を作ってみよう！],
  author: "Kanade",
  id: "@kanade_k_1228",
  date: datetime(year: 2024, month: 12, day: 30),
  prologue: include "prologe/prologe.typ",
  epilogue: include "epiloge/epiloge.typ",
  okuduke: [
    2024年12月20日 初版第1刷発行
    #table(
      stroke: none,
      columns: 2,
      [著者], [Kanade],
      [発行者], [Kanade],
      [連絡先], [https://twitter.com/kanade_k_1228],
    )
  ],
)

#include "chap1/chap1.typ"
#include "chap2/chap2.typ"
#include "chap3/chap3.typ"
#include "chap4/chap4.typ"
