#import "template.typ": *
#show: doc => conf(
  institute: [University of Mars \ Institute of Intergalactic Travel],
  name: [Flower],
  title: [Linear Maps],
  date: none,
  doc,
)
#let L(iTem) = $cal(L)(iT em)$
#let F = $bb(F)$

= The Vector Space of Linear Maps

#problem(index:"1")[
  假设 $T in cal(L)(#F^n,#F^m)$.证明存在$A_(j,k)in #F$ ，其中 $j=1,dots,m quad k=1,dots,n$， 使得
  $
    T(x_1,dots,x_n) = (A_(1,1)x_1 + dots + A_(1,n)x_n,dots, A_(m,1)x_1 + dots + A_(m,n)x_n)
  $
  对于每一个 $(x_1,dots,x_n)in #F^n$都成立.
]

#proof[
  对于任意的 $x in #F^n$，我们可以写
  $
    x = x_1 e_1 + x_2 e_2+ dots + x_n e_n,
  $
  其中 $e_1,dots,e_n$ 是 $#F^n$ 的标准基. 因为 $T$ 是线性的，我们有
  $
    T x &= T(x_1 e_1 + dots +x_n e_n) \
        &= x_1 T e_1 + dots + x_n T e_n.
  $
  现在对于 $T e_k in #F^m$, 其中 $k=1,dots, n$, 都存在
  $A_(1,k),dots, A_(m,k) in #F$ 使得
  $
    T e_k &= A_(1,k)e_1 + dots + A_(m,k)e_m\
             &= A_(1,k), dots, A_(m,k)
  $
  因此
  $
    x_k T e_k = (A_(1,k)x_k, dots, A_(m,k)x_k).
  $
  所以我们有
  $
    T x &= sum_(k = 1)^n (A_(1,k)x_k, dots, A_(m,k)x_k)\
        &= (sum_(k = 1)^n A_(1,k)x_k, dots, sum_(k = 1)^n A_(m,k)x_k),
  $
  就证得存在$A_(j,k) in #F$ ，其中 $j=1,dots,m$ 并且 $k=1,dots,n$ 使得等式成立.
]

#problem[
  假设 $T in cal(L)(#F^n,#F^m)$. 证明存在$A_(j,k)in #F$ ，其中 $j=1,dots,m quad k=1,dots,n$， 使得
]

#proof[
  对于任意的 $x in #F^n$，我们可以写
  $
    x = x_1 e_1 + dots + x_n e_n,
  $
  其中 $e_1,dots,e_n$ 是 $#F^n$ 的标准基. 因为 $T$ 是线性的，我们有
  $
    T x &= T(x_1 e_1 + dots +x_n e_n) \
        &= x_1 T e_1 + dots + x_n T e_n.
  $
  现在对于 $T e_k in #F^m$, 其中 $k=1,dots, n$, 都存在
  $A_(1,k),dots, A_(m,k) in #F$ 使得
  $
    T e_k &= A_(1,k)e_1 + dots + A_(m,k)e_m\
          &= A_(1,k), dots, A_(m,k)
  $
  因此
  $
    x_k T e_k = (A_(1,k)x_k, dots, A_(m,k)x_k).
  $
  所以我们有
  $
    T x &= sum_(k = 1)^n (A_(1,k)x_k, dots, A_(m,k)x_k)\
        &= (sum_(k = 1)^n A_(1,k)x_k, dots, sum_(k = 1)^n A_(m,k)x_k),
  $
  就证存在$A_(j,k) in #F$ ，其中 $j=1,dots,m$ 并且 $k=1,dots,n$ 使得等式成立. It is't right.
]

== The Vector Space of Linear Maps
#lorem(100) dadsf 
#problem(index: "2")[
  #lorem(100)
]

#proof[
  #lorem(100)
]

#problem(index: "2")[
Adding `rbx` to `rcx` gives
the desired result.
What is ```rust fn main()``` in Rust
would be ```c int main()``` in C.
```rust
fn main() {
    println!("Hello World!");
}
```
This has ``` `backticks` ``` in it
(but the spaces are trimmed). And
``` here``` the leading space is
also trimmed.
]

#problem(index: "999")[
  In this report, we will explore the
various factors that influence fluid
dynamics in glaciers and how they
contribute to the formation and
behaviour of these natural structures.

...

#align(center + bottom)[
  #image("pc.jpg", width: 70%)

  *Glaciers form an important
  part of the earth's climate
  system.*
]
]
