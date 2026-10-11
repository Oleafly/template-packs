#import "src/mod.typ": sydvd
#import sydvd:*

#show: note.with(
  title: [Machine Learning Notes],
  author: [syqwq],
)


#set enum(numbering: "(1.i)")
// #set text(size: 14pt)
#show math.epsilon: math.epsilon.alt
#outline()

#let ERM = math.text("ERM")

= A Gentle Start
#definition(title:[Generalization Loss])[
  Given a domain subset, $A subset.eq cal(X)$, the probability distribution,
  $cal(D)$ , assigns a number, $cal(D)(A)$ , which determines how likely it is to observe a point $x in A$. 

  We define the *generalization loss* of $h: cal(X) -> cal(Y)$,to be
  $
    L_((cal(D),f))(h) := PP_(x tilde.op cal(D))[h(x) != f(x)]
    :=cal(D)(Set(x, h(x)!=f(x)))
  $
  namely, the loss of $h$ with respect to the true labeling function $f$ under the distribution $cal(D)$.
]

#definition(title:[Training Error])[
  The error the classifier incurs over the training
  sample:
  $
    L_(S) (h) := frac(abs(Set(i in [m], h(x_i) != f(x_i))), m)
  $
  also called *empirical risk* or *empirical loss*.
]


Blindly minimizing the training error may lead to overfitting, one solution is to introduce a inductive bias, which can be done by restricting the hypothesis space.

#definition(title:[ERM])[
  There is a hypothesis class denoted by $cal(H)$ . Each
  $h in cal(H)$ is a function mapping from $cal(X)$ to $cal(Y)$  . For a given class $cal(H)$, and a training
  sample, $S$, the $ERM_(cal(H))$  learner uses the ERM rule to choose a predictor $h in cal(H)$,
  $
    ERM_(cal(H)) in argmin_(h in cal(H)) L_(S)(h)
  $

]

#definition(title:[The Realizability Assumption])[
  There exists a hypothesis $h^* in cal(H)$ such that $L_((cal(D),f))(h^*) = 0$.
]
This ensures for the empirical risk minimizer, $h_S$, we have $L_(S)(h_S) = 0$ for any sample, $S$.

Sometimes, we need to find where these errors come from. Since _under this assumption_, the training error is always zero, *all the error must come from the difference between the training error and the true error*, which is probably measureable.


Usually, we denote
_the probability of getting a nonrepresentative sample_ by $delta$ , and call (1−$delta$) the
*confidence* parameter of our prediction.

#theorem(title:[PAC Learnability on finite $cal(H)$ ])[
  Every finite hypothesis class $cal(H)$  is PAC learnable with the sample size 
  $
  m >= frac(1, epsilon) log frac(abs(cal(H)), delta) 
  $
  where $epsilon$ is the accuracy parameter and $delta$ is the confidence parameter. 
]<thm:pac-learnability-finite-hypothesis-class>

- $a$ 
