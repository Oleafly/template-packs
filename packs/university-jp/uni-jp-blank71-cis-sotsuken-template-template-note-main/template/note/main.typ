#import "../conf/conf.typ": *
#import "../conf/user_def.typ": *

#show: conf.with(
  main: true,
  showOutline: false,
  fontSize: (
    default: 9pt,
    title: 10pt,
  ),
  title: [
    $#rmP = #rmNP$
    #emph_red[
      (題目をここに書く)
    ]
  ],
  // subtitle: "Subtitle",
  authors: (
    (
      name: "法政 太郎",
      organization: "法政大学 情報科学部",
      email: "taro.hosei@stu.hosei.ac.jp",
      supervisor: [指導教員：法政花子 教授
        #emph_red[
          （准教授の場合は准教授にする）
        ]
      ],
    ),
  ),
  abstract-title: "概要",
  abstract: [
    ここに概要を記入。
    （昔はここだけ英語指定であったが、いまは日本語で良いとのこと。）
  ],
  columns: 2,
)
= はじめに
本研究では$#rmP eq.not #rmNP$予想を否定的に解決する。すなわち、$#rmP = #rmNP$を証明する。
$#rmP eq.not #rmNP$予想は数学および計算機科学において
最も多くの研究者が関心を持つ未解決問題のひとつであり、
この命題を証明することは両分野において極めて大きな意義を持つ。
いうまでもなく、$#rmP = #rmNP$が真であることは
すべての NP 問題が多項式時間で解決可能であることを意味し
#cite(label("Cook71"))
、各種問題のNP困難性を議論することは金輪際不要となる。

$#rmP = #rmNP$を証明するにあたり、
本研究では、NP 完全問題である部分和問題を
$O(n^4649)$時間で解くアルゴリズムを与える。
部分問題の NP 困難性から、このアルゴリズムの存在は$#rmP = #rmNP$を直ちに導き、
結果として、NP に属す任意の問題が多項式時間で解けることがいえる。
一方で、冪指数（i.e., $4649$）がかなり大きい定数であるため、
このアルゴリズムの存在は、NPに属す任意の問題が現実的な時間で解けることを意味しない。
したがって、本成果の工学的意義は大きくない。
しかしながら、本結果が理論計算機科学全般に与える影響は極めて大きなものであり、
多くの研究の今後の方向性を大きく変化させるものである。

$#rmP = #rmNP$を証明するにあたり、
本研究では、NP 完全問題である部分和問題を
$O(n^4649)$時間で解くアルゴリズムを与える。
部分問題の NP 困難性から、このアルゴリズムの存在は$#rmP = #rmNP$を直ちに導き、
結果として、NP に属す任意の問題が多項式時間で解けることがいえる。
一方で、冪指数（i.e., $4649$）がかなり大きい定数であるため、
このアルゴリズムの存在は、NPに属す任意の問題が現実的な時間で解けることを意味しない。
したがって、本成果の工学的意義は大きくない。
しかしながら、本結果が理論計算機科学全般に与える影響は極めて大きなものであり、
多くの研究の今後の方向性を大きく変化させるものである。

= 準備
Pとは、ある決定性チューリングマシンが存在して〜であるような問題の集合のことである。
NPとは、ある非決定性チューリングマシンが存在して〜であるような問題の集合のことである。
ある問題がNP困難であるとは、...

= $#rmP = #rmNP$の証明
本節では以下の定理を証明する。

#theorem[$#rmP = #rmNP$である。]

#proof[
  真に驚くべき証明を発見したが、ここに記すには余白が狭すぎる。
  #h(1fr)
  $square$
]

#algorithm-figure(
  "擬似コード（特に意味はない）",
  label: <al:quick>,
  vstroke: .5pt + luma(200),
  {
    let Partition = Call.with("partition")
    let Quick = Call.with("quick")
    Function(
      "partition",
      $p, r$,
      {
        Assign($x$, $A[r]$)
        Assign($i$, $p - 1$)
        For(
          $j = p$ + [ ] + strong[to] + [ ] + $r - 1$,
          {
            If(
              $A[j] <= x$,
              {
                Assign($i$, $i + 1$)
                Line[#fbox[ア] を $A[j]$ と交換する]
              },
            )
          },
        )
        Line[$A[i + 1]$ を $A[r]$ と交換する]
        Return($i + 1$)
      },
    )
    Function(
      "quick",
      $p, r$,
      {
        IfElseChain(
          fbox[イ],
          {
            Assign($q$, Partition($p, r$))
            Line(Quick($p, q - 1$))
            Line(Quick($q + 1, r$))
          },
          [あんこ],
          {
            Line[きなこ]
          },
        )
      },
    )
    Function(
      "メイン関数",
      "",
      {
        Line(Quick($1, n$))
      },
    )
  },
)

= おわりに
本研究では$#rmP = #rmNP$であることを証明した。
チューリング賞とフィールズ賞がもらえるはずなので、
プレスリリースの準備をお願いしたい。

#load-bib("../bib/ref.bib", main: true, title: "参考文献")

// #make-index(
//   title: "索引",
//   outlined: true,
//   use-page-counter: true,
// )
