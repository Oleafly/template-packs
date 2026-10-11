#import "template.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#show: exam.with(
  name: "测试试卷",
  school: "华南理工大学",
  course: "算法设计与分析",
  semester: "2023-2024学年第二学期",
  duration: "120",
)

#question(points:3)[] 
#subquestion[$f(n) = 2^(2n), g(n) = 2^n$]
#subquestion[$f(n) = n^(log c), g(n) = c^(log n)$] 
#subquestion[$f(n) = 8log (n^n), g(n) = 100log (n!)$] 
#subquestion[$f(n) = n, g(n) = log^2 n$] 
#subquestion[$f(n) = n log n + n, g(n) = log n + n$]


#v(30em)
#question(points:10)[*求解递推关系：当$n≥2$时，$f(n)=5f(n minus 1) minus 6f(n minus 2)$；$f(0)=1$；$f(1)=0$*]

#v(30em)
#question(points:10)[*用Prim方法求下图的最小耗费生成树。*]
#diagram(
	node-stroke: .1em,
	node-fill: gradient.radial(green.lighten(60%), green, center: (30%, 20%), radius: 80%),
	spacing: 4em,
	node((0,0), `1`, radius: 1.5em),
  node((0,1), `2`, radius: 1.5em),
  node((1,0), `3`, radius: 1.5em),
  node((1,1), `4`, radius: 1.5em),
  node((2,0), `5`, radius: 1.5em),
  node((2,1), `6`, radius: 1.5em),
  edge((0,0), (0,1),`1`, "-|"),
  edge((0,0), (1,0),`6`, "-|"),
  edge((0,1), (1,1),`2`, "-|"),
  edge((1,0), (2,0),`4`, "-|"),
  edge((1,1), (2,1),`6`, "-|"),
  edge((2,0), (2,1),`3`, "-|"),
  edge((0,0), (1,1),`7`, "-|"),
  edge((1,0), (0,1),`2`, "-|"),
  edge((1,0), (1,1),`9`, "-|"),
  edge((1,0), (2,1),`7`, "-|"),
  edge((2,0), (1,1),`3`, "-|"),
)

#v(30em)
#question(points:15)[*用Dijkstra算法求解下图的单源最短路径问题，设原点为1。*]

#diagram(
	node-stroke: .1em,
	node-fill: gradient.radial(green.lighten(60%), green, center: (30%, 20%), radius: 80%),
	spacing: 2em,
  node((0,1), `1`, radius: 1.5em),
  node((2,0), `2`, radius: 1.5em),
  node((2,2), `3`, radius: 1.5em),
  node((6,0), `4`, radius: 1.5em),
  node((6,2), `5`, radius: 1.5em),
  node((8,1), `6`, radius: 1.5em),
  edge((0,1), (2,0),`9`, "-|>"),
  edge((0,1), (2,2),`4`, "-|>"),
  edge((2,2), (2,0),`4`, "-|>"),
  edge((2,0), (6,0),`12`, "-|>"),
  edge((2,2), (6,2),`13`, "-|>"),
  edge((2,0), (6,2),`5`, "-|>"),
  edge((6,2), (6,0),`3`, "-|>"),
  edge((6,2), (8,1),`15`, "-|>"),
  edge((6,0), (8,1),`2`, "-|>"),
)

#v(30em)
#question(points:15)[*用动态规划法，求解0-1背包问题，已知背包容量为22，5件物品的体积分别为3,5,7,8,9，价值分别为4,6,7,9,10。求该背包的最大价值及物品选择情况。*]

#v(30em)
#question[*求对下列5个矩阵连乘：$M 1 (4 times 5)$; $M 2 (5 times 4)$; $M 3 (4 times 6)$; $M 4 (6 times 4)$; $M 5 (4 times 5)$*]
#subquestion(points: 10)[*写出解决上述问题的动态规划实现算法(文字描述或伪代码);*] 

#subquestion(points: 10)[*写出通过此算法解决上述问题的过程及结果。*]

#v(30em)
#question(points:15)[*设A是n个数的序列，如果A中的元素x满足以下条件：小于x的数的个数$≥n/3$，且大于x的数的个数$≥ n/3$，则称x为A的近似中值。请设计算法求出A的一个近似中值，说明算法的设计思想和最坏情况下的时间复杂度。*]