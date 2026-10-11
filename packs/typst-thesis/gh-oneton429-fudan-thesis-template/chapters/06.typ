#import "../theorem-env.typ": *

= 定理与证明

当你需要撰写诸如“定义、定理、引理、推论、命题、注、证明”时，你需要在该章节对应的 typ 文件开头引入一行：

```typst
#import "../theorem-env.typ": *
```

下面是一些示例：


== Prime numbers

#definition[
  A natural number is called a #highlight[_prime number_] if it is greater
  than 1 and cannot be written as the product of two smaller natural numbers.
]
#example[
  The numbers $2$, $3$, and $17$ are prime.
  @cor_largest_prime shows that this list is not exhaustive!
]

#theorem("欧几里得")[
  There are infinitely many primes.
]
#proof[
  Suppose to the contrary that $p_1, p_2, dots, p_n$ is a finite enumeration
  of all primes. Set $P = p_1 p_2 dots p_n$. Since $P + 1$ is not in our list,
  it cannot be prime. Thus, some prime factor $p_j$ divides $P + 1$.  Since
  $p_j$ also divides $P$, it must divide the difference $(P + 1) - P = 1$, a
  contradiction.
]

#corollary[
  There is no largest prime number.
] <cor_largest_prime>
#proposition[
  There are infinitely many composite numbers.
]
#theorem[
  There are arbitrarily long stretches of composite numbers.
]
#proof[
  For any $n > 2$, consider
  $
    n! + 2, quad n! + 3, quad ..., quad n! + n
  $
]

#remark[
  根据 @cor_largest_prime，我们可以推出，Oneton429 牛批！
]

== 意大利面与42号混凝土的关系

#theorem("意面混凝土定理")[
  意大利面应当拌42号混凝土。
]

#proof[
  因为螺丝钉的长度会直接影响挖掘机的扭矩。

  你往里砸的时候，一瞬间，会释放大量的高能蛋白，俗称 UFO，会严重影响经济的发展。
]
