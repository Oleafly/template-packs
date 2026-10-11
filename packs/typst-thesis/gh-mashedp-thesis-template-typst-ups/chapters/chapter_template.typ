#import "../minitoc.typ": *
#import "../utils.typ": *

= Deep Learning Framework <chap:functional_framework>


This chapter establishes the theoretical foundations necessary to understand deep learning estimators, which are the central objects we manipulate in this thesis. The perspective adopted here bridges the gap between classical statistical learning and the specific challenges posed by neural networks.

We begin by defining a unified functional framework that describes learning as an optimization problem in function space. This allows us to treat linear models, kernel methods, and neural networks with the same vocabulary.

We first formally define these models to establish a clear baseline. Then, in the section "Joyful Elements", we explore scenarios where this framework yields clear, elegant results—specifically in linear and kernel regression. These cases serve as a baseline, offering geometric intuition and closed-form guarantees.

In the section "Painful Elements", we confront the reality of deep learning. We discuss how non-linearity breaks the nice properties of the "joyful" cases, introducing curvature, non-convexity, and path dependence.

Finally, in Part IV of this thesis, we will return to this geometric perspective with a deep dive into spectral analysis. We will show how many complex learning tasks—such as solving PDEs or inverse problems—can be viewed as regression problems involving an operator, and how the spectral properties of this operator explain why some problems are inherently harder to learn than others (see ).

#minitoc(depth: 3)

== Blablabla

=== Oh ?

=== Mais oh !

== Blablabla 2
