#import "/configs.typ": font, fontsize
#import "/components.typ": paragraph, fp, anchor

#let weight-calc(bold) = if bold { "bold" } else { "regular" }

#let keyword(lang, words) = [
    #set text(font: font.sans, weight: weight-calc(lang == "en"))
    #set par(first-line-indent: 0em)
    
    #let prefix = if lang == "zh" { "关键词：" } else { "Key Words: " }
    #let suffix = words.join(if lang == "zh" { "；" } else { "; " })

    #text(size: fontsize.L4, prefix)
    #text(size: fontsize.L4s, suffix)
]

#let title(content, bold: false) = [
    #align(center, text(size: fontsize.L3, font: font.sans, weight: weight-calc(bold), content))
]

#let titlesmall(content, bold: false) = [
    #align(center, text(size: fontsize.L3s, font: font.sans, weight: weight-calc(bold), content))
]

#let abstract(content) = [
    #content
]

#let zh = abstract[
    #titlesmall[一些约束体系量子哈密顿中算符次序问题]

    #v(2em)

    #title[摘#h(2em)要]
    #anchor[摘 要]

    #v(2em)

    #paragraph[
        根据微分几何中的曲面论，用两个变量就可以完全参数化一个二维曲面。也就是，当一个粒子约束在曲面上运动时，只需要两个独立的变量就可以完全刻画粒子的运动。由于粒子的运动可以在笛卡儿坐标下分解为三个互相正交的方向，动能算符 $T$ 和三个笛卡儿动量 $P_i (i = 1,2,3)$ 的关系似乎为：

        $ T = 1/(2 mu) sum_(i = 1)^3 P_i^2 $

        其中 $P_i (i = 1,2,3)$ 为厄密算符。事实上，在量子力学中，除非粒子是在自由空间中运动或在经典极限下，此式是不正确的。在存在约束时，上式应代之以

        $ T = 1/(2 mu) sum_(i=1)^3 1/(f_i (x, y, z)) P_i f_i (x, y, z) P_i $

        其中 $f_i (i = 1,2,3)$ 是非平凡的函数。本文用圆环面，旋转抛物面，旋转单叶双曲面，磁场中的荷电平面转子，球面转子等体系中的量子运动说明函数 $f_i (i = 1,2,3)$ 是存在的。

        在不同的矢势下，荷电粒子的力学动量从而动能的表达式是不同的。本文研究了它们之间和量子规范相因子的关系，发现规范相因子会自然出现在动能算符中。
    ]

    #v(2em)

    #keyword("zh", ("量子力学", "算符次序", "厄密算符", "正则量子化", "规范变换"))
]

#let en = abstract[
    #titlesmall(bold: true)[The operator ordering problem in quantum Hamiltonian for some constraint systems]

    #v(2em)

    #title(bold: true)[Abstract]
    #anchor[Abstract]

    #v(2em)

    #paragraph[
        According to surface theory in differential geometry, the two-dimensional surface is parameterized by two variables. This is, when a particle moves on the surface, only two variables suffice to describe the motion of the particle. However, when examining the same problem in the physical point of view, the motion of the particle can also be described in the three-dimensional Cartesian coordinates. Explicitly, the relation between kinetic energy $T$ and Hermitian Cartesian momentum $P_i (i = 1,2,3)$ is speciously

        $ T = 1/(2 mu) sum_(i = 1)^3 P_i^2 $

        which holds either for the system being free of constraint or for the system in classical limit. Moreover, under constraint, above expression should be replaced by,

        $ T = 1/(2 mu) sum_(i=1)^3 1/(f_i (x, y, z)) P_i f_i (x, y, z) P_i $

        where $f_i (i = 1,2,3)$ are the non-trivial functions. This paper utilizes quantum motions on the torus surface, paraboloid of revolution, hyperboloid of revolution of one sheet, charged planar and spherical rotator etc., to demonstrate the existence of the function $f_i$.

        Since different vector potentials lead to different kinetic energies, the relationship between these kinetic energies and the gauge phase factors, are studied. Results show that the gauge phase factor can appear in the kinetic operator naturally.
    ]

    #v(1em)

    #keyword("en", ("quantum mechanics", "operator ordering", "Hermitian operator", "canonical quantization", "gauge transformation"))
]
