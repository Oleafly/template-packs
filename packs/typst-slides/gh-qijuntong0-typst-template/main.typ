#import "templates/article_en.typ": *
#set text(cjk-latin-spacing: auto)
// テンプレート関数を適用
#show: project.with(
  title: "My Research Report",
  author: "Qijun Tong",
)
#emph[This article provides a brief introduction to axiomatic quantum physics].
= Introduction
First, we recall that a physical system is described by its state—a mathematical entity—and its time evolution, which is typically governed by a differential equation. In classical physics, the state is defined by generalized coordinates $q=(q_1,...,q_f)$ and their corresponding generalized momenta $p=(p_1,...,p_f)$ . Then the time evolution is determined by *Hamilton function* and #emph[Hamilton's canonical equation]. We give the definition of the state of a quantum system as following axiom.
#axiom[The *state* of a quantum system is represented by a unit vector (referred to as the *state vector*) in a complex Hilbert space $cal(H)$ .
  For any state vector $psi in cal(H)$ and any complex number $alpha$ with absolute value 1, the vectors $psi$ and $alpha psi$ represent the same physical state. Moreover, Any observable physical quantity is represented by a self-adjoint operator on $cal(H).$ ]

#remark[Self-adjoint operators are used because their eigenvalues, which correspond to the possible measurement outcomes of a physical quantity, are always real numbers.]
An observable quantity $T$ of a state $psi in cal(H)$ in quantum physics is stochastic. Then we define a random variable $T_psi.$ Here we add an axiom for $T_psi$ on a probability space $(Omega,cal(B)(bb(R)),P).$
#axiom[Let $B in cal(B)(bb(R))$ , then $P(T_psi in B)=||E_T(B) psi||^2$ , where $E_T$ is the spectral measure of $T$ .
]

#theorem(
  title: text[From @sample],
)[The expectation value of the random variable $T_psi$ is given by $E[T_psi] = chevron.l psi, T psi chevron.r.$ ]
#proof[
  Let $P_T_psi$ the probability distribution of $T_psi.$
  $
    E[T_psi]=integral_bb(R) lambda d P_T_psi (lambda)&=integral lambda d||E_T(B) psi||^2
    =integral_bb(R)lambda d chevron.l E_T(B)psi,E_T(B)psi chevron.r \
    &=integral_bb(R)lambda d chevron.l psi,E_T(B)^2psi chevron.r because E_T(B) "is self adjoint operator"\
    &=integral_bb(R)d chevron.l psi,lambda E_T(B)psi chevron.r because E_T(B) "is projection oprerator"\
    &=chevron.l psi,T psi chevron.r because E_T(B) "is spectral measure"
  $
]

#bibliography("./bib/cite.bib")
