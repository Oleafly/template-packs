#import "../lib.typ": definition, axiom, theorem, proposition, lemma, corollary, example, remark, proof

= 定理と証明

== 定義と公理

#definition[
  集合 $A$ の元がすべて集合 $B$ の元であるとき、$A$ は $B$ の部分集合であるといい、
  $A subset.eq B$ と書く。
] <def-subset>

#axiom[
  任意の集合 $A$ について $A subset.eq A$ が成り立つ。
]

== 定理と証明

#theorem(name: [ピタゴラスの定理])[
  直角三角形の直角をはさむ二辺の長さを $a$, $b$、斜辺の長さを $c$ とすると、
  $ a^2 + b^2 = c^2 $
  が成り立つ。
] <thm-pythagoras>

#proof[
  一辺の長さが $a + b$ の正方形を考える。
  その内部に四つの直角三角形を並べると、残る領域は一辺 $c$ の正方形になる。
  面積を二通りに数えて $(a+b)^2 = 4 dot 1/2 a b + c^2$ を得る。
  展開して整理すれば主張を得る。
]

== 命題・補題・系

#lemma[
  $n$ が偶数ならば $n^2$ も偶数である。
] <lem-even>

#proposition[
  連続する二つの整数の積は偶数である。
]

#corollary[
  #ref(<thm-pythagoras>) より、直角二等辺三角形の斜辺は一辺の $sqrt(2)$ 倍である。
]

== 例と注意

#example[
  $A = {1, 2}$、$B = {1, 2, 3}$ のとき #ref(<def-subset>) より $A subset.eq B$ である。
]

#remark[
  #ref(<lem-even>) の逆は成り立つが、証明には別の議論が必要である。
]
