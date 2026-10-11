#import "../lib.typ": *

#counter(heading).update(2)

#show: doc => template(
  doc,
  footer: "机器学习入门",
  header: "第一章 监督学习"
)

= 1 监督学习基础

== 1.1 线性回归

#box-blue([
  *线性回归* 是最基础的监督学习算法，假设目标与特征之间存在线性关系。

  目标函数：
  $ hat(y) = w^T x + b $ <eq_linear>

  损失函数（均方误差）：
  $ L = 1/n sum_(i=1)^n (y_i - hat(y)_i)^2 $ <eq_mse>
])

== 1.2 梯度下降

#box-teal([
  *梯度下降* 是优化模型参数的核心方法。

  参数更新规则：
  $ w := w - eta grad_w L(w) $

  其中 $eta$ 为学习率，$grad_w L$ 为损失函数对参数的梯度。
])

== 1.3 代码实现

#figure(
  caption: [线性回归实现对比],
  table(
    columns: (3cm, 3cm, 3cm),
    align: center,
    table.header([*特性*], [*Python*], [*Julia*]),
    [语法], [简洁], [类似 MATLAB],
    [性能], [中等], [接近 C],
    [生态], [丰富], [科学计算强],
  )
)

Python 实现：

```python
import numpy as np

def linear_regression(X, y, lr=0.01, epochs=1000):
    n_samples, n_features = X.shape
    w = np.zeros(n_features)
    b = 0

    for _ in range(epochs):
        y_pred = X @ w + b
        error = y_pred - y

        w -= lr * (X.T @ error) / n_samples
        b -= lr * np.mean(error)

    return w, b

# 使用示例
X = np.random.randn(100, 3)
y = X @ [1, 2, 3] + 0.5
w, b = linear_regression(X, y)
print(f"权重: {w}, 偏置: {b}")
```

Julia 实现：

```julia
using LinearAlgebra

function linear_regression(X, y; lr=0.01, epochs=1000)
    n_samples, n_features = size(X)
    w = zeros(n_features)
    b = 0.0

    for _ in 1:epochs
        y_pred = X * w .+ b
        error = y_pred .- y

        w .-= lr * (X' * error) ./ n_samples
        b -= lr * mean(error)
    end

    return w, b
end

# 使用示例
X = randn(100, 3)
y = X * [1.0, 2.0, 3.0] .+ 0.5
w, b = linear_regression(X, y)
println("权重: $w, 偏置: $b")
```

== 1.4 模型评估

#box-purple([
  *评估指标*用于衡量模型性能。
])

#ref-list(
  [[1]], [*均方误差*（MSE）：衡量预测值与真实值的偏差],
  [[2]], [*R² 分数*：衡量模型解释方差的比例，$R^2 = 1 - SS_"res"/SS_"tot"$],
)

通过 Python 和 Julia 的实现，读者可以快速入门监督学习。深度学习相关内容可参考#cite(<bishop2006pattern>, form: "prose")。

#bibliography("References.bib", title: "参考文献", style: "gb-7714-2015-numeric")
