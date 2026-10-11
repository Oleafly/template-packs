#import "tiny-olymp.typ": project, examples, problem

#show: project.with(
  title: "浙江农林大学第二十四届程序设计竞赛",
  author: "浙江农林大学 ACM 集训队",
  second-header: "China, Hangzhou, 2023.5.21",
  titlepage: true
)

// #pagebreak()

= 谢谢卡尔

#problem(`standard input`, `standard output`, "2 seconds", "256 mebibytes")

香蕉猫要考试啦，它希望小刺猬卡尔能给它带来好运。在第二天的考试中，如果香蕉猫的分数在 $60$ 分及以上，请说一句："thank you Carl"。如果分数在 $60$ 分以下（不包括 $60$ 分），说明卡尔并没有来，你需要安慰香蕉猫说一句："ur best"。

== Input

一行一个正整数 $x$ $(0 ⩽ x ⩽ 100)$，表示香蕉猫第二天的考试分数。

== Output

如果香蕉猫的分数在 $60$ 分及以上，输出 `thank you Carl`，反之输出 `ur best`。

== Example

#examples(
```
0
```,
```
thank you Carl
```,
```
100
```,
```
ur best
```
)

#pagebreak()

= 煎饼的 MEX

#problem(`standard input`, `standard output`, "1 seconds", "256 mebibytes")


定义一个数字序列的 MEX，为其中最小没有出现过的非负整数。

现在有一个长为 $n$ 的整数序列 ${a_i}$，jbgg 可以在其中自由选择三个数（三个数在序列中的下标不能相同），并获得这三个数的 MEX。jbgg 想知道他获得 MEX 的期望是多少。

答案可能很大，请对 $998244353$ 取模。

== Input

第一行有一个正整数 $n$，其中 $3 ⩽ n ⩽ 10^5$。

接下来一行有 $n$ 个整数 $a_1, dots.c, a_n$，其中 $0 ⩽ a_i ⩽ 10^5$。


== Output

一个数字，表示期望，对 $998244353$ 取模。

有理数取模：如果答案是 $P / Q$ 的形式，若存在 $R$ 满足 $Q R equiv 1 (mod 998244353)$，那么取模后的答案是 $P R mod 998244353$。

== Example

#examples(
```
4
0 1 2 3
```,
```
499122178
```,
```
5
0 0 1 2 3
```,
```
798595484
```,
```
10
0 1 2 3 4 5 6 7 8 9
```,
```
623902721
```
)

== Note

对于第一个样例：

所有可能选取的下标集合为 ${1,2,3},{1,2,4},{1,3,4},{2,3,4}$。它们对应的 MEX 值分别为：$3,2,1,0$，则期望为 $3/2$。

