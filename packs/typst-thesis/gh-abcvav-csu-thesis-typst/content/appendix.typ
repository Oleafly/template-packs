#import "../pages/appendix.typ": appendix-page
#show: appendix-page
#import "../utils.typ": subeqs


= 第一个附录

行间公式： $ sum_(k=1)^n k = (n(n+1)) / 2 $

行间公式： $ sum_(k=1)^n k = (n(n+1)) / 2 $

子公式：
#subeqs(
  $ f(x)=sin(x) $,
  $ g(x)=cos(x) $
)

#figure(
  table(columns: 2, align: center,
  [111],[2],
  [3],[4]),
  caption: [I'm here]
)
#figure(
  table(columns: 2, align: center,
  [111],[2],
  [3],[4]),
  caption: [I'm here1]
)

== 附录小节
== 附录小节

= 第二个附录
== 附录小节
行间公式： $ sum_(k=1)^n k = (n(n+1)) / 2 $
== 附录小节

#figure(
  table(columns: 2, align: center,
  [111],[2],
  [3],[4]),
  caption: [I'm here]
)
#figure(
  table(columns: 2, align: center,
  [111],[2],
  [3],[4]),
  caption: [I'm here]
)
#figure(
  image("assets/example.png", width: 50%), // 50% / 1cm
  caption: [列车发车时刻],
)

子公式：
#subeqs(
  $ f(x)=sin(x) $,
  $ g(x)=cos(x) $
)
