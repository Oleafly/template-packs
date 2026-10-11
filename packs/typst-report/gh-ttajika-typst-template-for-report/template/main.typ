#import "@preview/js:0.1.3": *
//jsテンプレートの使用
//https://typst.app/universe/package/js
#import "@preview/physica:0.9.5": *
//Physicaパッケージの使用
//https://typst.app/universe/package/physica
#set math.equation(numbering: "(1)")
//数式に番号をつける

#show: js.with(
)

#maketitle(
  title: "タイトル",
  authors: "氏名",
)

#set math.mat(delim:"[") //行列のカッコを角カッコに

= はじめに

数式: 
- 微分 $dv(f,x)$
- 偏微分 $pdv(f,x,y)$
- 行列 $mat(a,b;c,d)$
- 積分 $integral_(-oo)^(2x+1) f(y) dif y$.
- 和 $sum_(i=1)^n (a_i/i)^2$
- 極限 $lim_(n->oo) a_n$

ディスプレイ数式
$
sum_(i=1)^n (alpha_n +beta_n)
$<tag>

(@tag)式を参照する．


