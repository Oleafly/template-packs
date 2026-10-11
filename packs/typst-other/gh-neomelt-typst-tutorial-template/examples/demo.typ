#import "../tutorial.typ": *

#show: tutorial.with(
  title: "机器人学笔记",
  subtitle: "从 SO(3) 到 SE(3)",
  author: "neomelt",
  date: "2026 年 6 月",
  toc: true,
)

= 旋转矩阵

刚体运动 = 旋转 + 平移。平移好办，难点在旋转。本章建立 $"SO"(3)$ 的代数结构。

== 由基变换导出

设单位正交基 $(bold(e)_1, bold(e)_2, bold(e)_3)$ 旋转成 $(bold(e)'_1, bold(e)'_2, bold(e)'_3)$，同一向量 $bold(a)$ 坐标变换为：

$ vec(delim: "[", a_1, a_2, a_3) = underbrace(mat(delim: "[",
    bold(e)_1^top bold(e)'_1, bold(e)_1^top bold(e)'_2, bold(e)_1^top bold(e)'_3;
    bold(e)_2^top bold(e)'_1, bold(e)_2^top bold(e)'_2, bold(e)_2^top bold(e)'_3;
    bold(e)_3^top bold(e)'_1, bold(e)_3^top bold(e)'_2, bold(e)_3^top bold(e)'_3;),
  bold(R)) vec(delim: "[", a'_1, a'_2, a'_3) $

矩阵 $bold(R)$ 又称*方向余弦矩阵*（DCM）。

#definition[特殊正交群 SO(3)][
  三维旋转矩阵的集合
  $ "SO"(3) = { bold(R) in bb(R)^(3 times 3) mid(|) bold(R) bold(R)^top = bold(I), space det bold(R) = 1 }. $
  即行列式为 1 的正交矩阵，9 个元素受 6 个约束后剩 3 个自由度。
]

#proposition[旋转矩阵的逆是其转置][
  $bold(R) in "SO"(3) => bold(R)^(-1) = bold(R)^top in "SO"(3)$，几何上对应“反向旋转”。
]

#proof[
  由正交性 $bold(R) bold(R)^top = bold(I)$ 直接得 $bold(R)^(-1) = bold(R)^top$。又
  $(bold(R)^top)(bold(R)^top)^top = bold(R)^top bold(R) = bold(I)$ 且 $det bold(R)^top = 1$，故 $bold(R)^top in "SO"(3)$。
]

#note[式中 $bold(R)^top$ 既是逆又是转置，仅对正交矩阵成立。]

#pitfall[把 $bold(R)^(-1) = bold(R)^top$ 当巧合][
  这不是“凑巧好算”，而是正交性的定义后果：旋转保长度，故其逆就是“反着转”。下一节 SE(3) 的逆就不再是简单转置。
]

== 代码与提示

用 Python 验证 $bold(R) bold(R)^top = bold(I)$：

```python
import numpy as np
R = expm(skew(np.random.randn(3)))      # 随机旋转
assert np.allclose(R @ R.T, np.eye(3))  # 正交
assert np.isclose(np.linalg.det(R), 1)  # 行列式为 1
```

行内代码与按键也支持：调用 `np.linalg.det(R)`，按 #kbd("Ctrl") + #kbd("C") 退出。

#tip[`scipy.linalg.expm` 比手写罗德里格斯公式更稳，但慢；实时场景用闭式解。]

#warning[`skew(v)` 的符号约定（$bold(v)^and$）务必与右乘/左乘扰动一致，否则雅可比差一个负号。]

= 李群与李代数

#theorem[指数映射满射性][
  对任意 $bold(R) in "SO"(3)$，存在 $bold(phi) in bb(R)^3$ 使 $bold(R) = exp(bold(phi)^and)$。
]

#lemma[BCH 近似][
  当 $bold(phi)_1$ 或 $bold(phi)_2$ 为小量时，$ln(exp(bold(phi)_1^and) exp(bold(phi)_2^and))^or approx bold(J)_l^(-1) bold(phi)_1 + bold(phi)_2$。
]

#corollary[左右扰动可互换][
  左扰动与右扰动雅可比相差一个伴随矩阵 $"Ad"(bold(R))$。
]

#example[
  绕 $z$ 轴转 $90 degree$：$bold(phi) = (0, 0, pi\/2)^top$，对应 $bold(R) = mat(delim: "[", 0, -1, 0; 1, 0, 0; 0, 0, 1)$。
]

#exercise[
  + 证明 $(bold(a)^and)^top = -bold(a)^and$。
  + 用 $(dot.c)^and$ 验证 $bold(a) times (bold(b) times bold(c)) = bold(b)(bold(a)^top bold(c)) - bold(c)(bold(a)^top bold(b))$。
]
