#import "lib.typ": *
#import "@preview/numbly:0.1.0": *

#show: ecnu-theme.with(
  config-info(
    author: [1111111],
    date: datetime.today().display(),
    institution: [ECNU Department of Data Science and Big Data Technology],
    title: [Introduction to Artificial Intelligence],
    subtitle: [Lecture 1: Search],
  ),
  config-common(
    slide-level: 2,
    // new-section-slide-fn: none,
  ),
)
#show: show-theorion
#set text(lang: "zh")
#show math.equation.where(block: false): math.display


#set heading(numbering: numbly("{1}.", default: "1.1"))
#title-slide()

#outline-slide()

#focus-slide()[
  Attention is All You Need !
]

= Introduction
== Backgrounds
- 11111111111111111 #context text.size
- 22222222222222222 
- 33333333333333333
- 44444444444444444

= Photo
== My Photo
#figure(
  image("hhhhhhhhh.jpg", width: 50%),
  caption: [hahahah......],
)

== Equation
#slide[
  #definition(title: [随机变量])[
    设 $X$ 是一个实验的样本空间 $Omega$ 上的实值函数，如果对于 $Omega$ 上的任一事件 $A$ ，都有设 $X$ 是一个实验的样本空间 $Omega$ 上的实值函数，如果对于 $Omega$ 上的任一事件 $A$ ，都有设 $X$ 是一个实验的样本空间 $Omega$ 上的实值函数，如果对于 $Omega$ 上的任一事件 $A$ ，都有设 $X$ 是一个实验的样本空间 $Omega$ 上的实值函数，如果对于 $Omega$ 上的任一事件 $A$ ，都有

    $
      P(X in A) = P({ omega in Omega | X(omega) in A })
    $<eq:0>
    则称 $X$ 为定义在 $Omega$ 上的*随机变量*。

    设 $X$ 是一个实验的样本空间 $Omega$ 上的实值函数，如果对于 $Omega$ 上的任一事件 $A$ ，都有

    $
      P(X in A) = P({ omega in Omega | X(omega) in A })
    $<eq:0>
    则称 $X$ 为定义在 $Omega$ 上的*随机变量*。

    设 $X$ 是一个实验的样本空间 $Omega$ 上的实值函数，如果对于 $Omega$ 上的任一事件 $A$ ，都有


    $
      P(X in A) = P({ omega in Omega | X(omega) in A })
    $<eq:0>
    则称 $X$ 为定义在 $Omega$ 上的*随机变量*。

    #context text.size
  ]

  #pagebreak()

  #theorem(title: [等差数列求和])[
    对于首项为 $a_1$ ，末项为 $a_n$ ，公差为 $d$ ，项数为 $n$ 的等差数列，其前 $n$ 项和 $S_n$ 为：

    $
      S_n = frac((a_1+a_n) n, 2)
    $<eq:1>
  ]
  #proof[
    #lorem(100)
  ]
]

= Conclusion
== Emmmmmmm.....
#slide[

  - *Sequence Tagging Loss *
  $
    cal(L)_(p) = - sum_(i=1)^(S) sum_(j=1)^(N) p_(i,j) log(vu(p_(i,j)))
  $

  - *Language Classifier Loss *
  $
    cal(L)_(a) = - sum_(k=1)^(K) a_(k) log(vu(a_(k)))
  $

  - *Bidirectional Language Model Loss*
  $
    cal(L)_(l) = - sum_(t=1)^(T) log(vu(w_(t) | w_(1:t-1))) - sum_(t=T)^(1) log(vu(w_(t) | w_(t+1:T)))
  $

]


= References
#bib-slide[
  #v(2em)
  #bibliography("references.yml", full: true, title: none)
]



