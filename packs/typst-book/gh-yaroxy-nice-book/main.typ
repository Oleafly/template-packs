#import "template.typ": nice-doc, yaroxy, callout, callout-color, math-callout, math-callout-kind

#show: nice-doc.with(
  main-title: [Demostration],
  sub-title: [A Template],
  authors: (yaroxy,),
  cover-image: "image/cover.jpg",
  preface: include "chapter/preface.typ",
  reference: "chapter/ref.bib"
)

= Euler Formula

欧拉公式的一般形式为：

$
  e^(i x) = cos(x) + i sin(x) \
  e^(-i x) = cos(x) - i sin(x)
$ <EULER_FORMULA_GENERAL_FORM>

其中 $e$ 是自然对数的底，$i$ 是虚数单位。欧拉公式将复指数函数与三角函数联系起来，它使指数函数的定义域扩大到复数，建立了三角函数和复指数函数之间的关系。

欧拉公式不仅用于数学分析领域，在复变函数论里也占有非常重要的地位，被誉为"数学中的天桥”。

将 $x$ 取作 $pi$ 就得到：

$
  e^(i pi) + 1 = 0
$

它是数学里最令人着迷的一个公式，称为*欧拉恒等式*，数学家们评价它是“上帝创造的公式”。

欧拉公式的推论：
$
  cos(x) & = (e^(i x) + e^(-i x)) / 2 \
  sin(x) & = (e^(i x) - e^(-i x)) / (2i) = -i (e^(i x) - e^(-i x)) / 2
$ <EULER_FORMULA_TRIGONOMETRIC_FORM>

#callout()[
  在复平面上，@EULER_FORMULA_GENERAL_FORM 等价于一种旋转，比如 $e^(i pi)$ 表示单位向量逆时针旋转 $pi$ 弧度。
]


#figure(
  image(
    "image/cover.jpg",
    width: 80%
  ),
  caption: [Cover Image],
)



#math-callout(kind: math-callout-kind.definition, title: [可积性])[
  设 $f(x)= limits(sum)_(i=1)^(k) a_i  chi_(A_i) (x)$ 是 $E$ 上的非负简单函数，中文其中 ${A_1,A_2,dots,A_k}$ 是 $E$ 上的一个可测分割，$a_1,a_2, dots,a_k$ 是非负实数。定义 $f$ 在 $E$ 上的积分为 $ integral_(a)^b f(x)$

  $
    integral_E f dif x = sum_(i=1)^k a_i m( A_i ) pi alpha beta sigma gamma nu epsilon.alt epsilon . integral.cont_a^b limits(integral.cont)_a^b product_(i=1)^n
  $
  一般情况下 $0 lt.eq integral_E f dif x lt.eq infinity $。若 $integral_E f dif x < infinity $，则称 $f$ 在 $E$ 上可积。
]

= DDPM

DDPM的训练过程分为两步：
+ Diffusion Process / Forward Process：加噪过程
+ Denoising Process / Reverse Process：去噪过程

#figure(
  table(
    columns: 2,
    table.header(
      [符号], [含义],
    ),
    [$T$], [总时间步数],
    [$x_0$], [原始图片],
    [$x_t$], [每一步产生的图片],
    [$x_T$], [纯高斯噪声],
    [$epsilon_t in cal(N)(0,1)$], [时间步 $t$ 时增加的高斯噪声],
    [$q(x_t|x_(t-1))$], [Diffusion Process],
    [$p_theta (x_(t-1)|x_t)$], [Denoising Process],
  ),
  caption: [DDPM Notation],
)

= Code

```python
# 对于每一个batch的数据
for i in steps: 
    # 先收集经验值
    exps = generate_experience(prompts, actor, critic, reward, ref)
    # 一个batch的经验值将被用于计算ppo_epochs次loss，更新ppo_epochs次模型
    # 这也意味着，每次计算新loss时，用的是更新后的模型
    for j in ppo_epochs:
        actor_loss = cal_actor_loss(exps, actor)
        critic_loss = cal_critic_loss(exps, critic)
        
        actor.backward(actor_loss)
        actor.step()
        
        critc.backward(critic_loss)
        critic.step()
```