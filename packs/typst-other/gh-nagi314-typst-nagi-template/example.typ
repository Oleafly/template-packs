#import "template/template.typ": mytemplate
#show: doc => mytemplate("Naoki Otani", doc)

// ここから本文
= Chap1
== Section1
あいうえお

== 数式例
$ 1+2^(2/3) $

$ y = a x + b  + "const" $

$ sum_(k=1)^(n) k &= 1 + 2 + 3 + ... + n \
                  &= 1/2 n(n+1) $

$ product_(k=1)^(n) k = n! $

$ sqrt(3 - 2 sqrt(2)) = sqrt(2) - 1 $

$ abs(-3) = 3 \
\ norm(x/2) $

$ lim_(x->0) (sin x) / x = 1 $

$ F(omega)=integral_(-oo)^(oo) f(x) e^(i omega x) d x $

$ x in {1, 2, 3} $

$ x in.not {1, 2, 3} $

$ vec(a, b, c) dot vec(1, 2, 3) = a + 2b + 3c $

$ mat(-1, 2; 3, -4) $