#import "template.typ": *
#import "@preview/algo:0.3.4": algo, i, d, comment, code
#import "symbols.typ": *


#import "@preview/ctheorems:1.1.3": *
#import "theorems.typ": *

#let title = "Homework 1"
#let author = "Mukul Agarwal"
#let course_id = "CS 355"
#let semester = "Spring 2025"
#let collaborators = ()
#set enum(numbering: "1.")

#show: assignment_class.with(
  title,
  author,
  course_id,
  semester,
  collaborators,
)

#problem[Basic Probabilities][
#part(2)[
  Consider 7 balls: 3 yellow, 2 red, and 2 green. 
  I pick one ball uniformly at random. 
  What is the probability that I pick a red ball?
][
]

#part(2)[
  Consider 7 balls: 3 yellow, 2 red, and 2 green. 
  I pick one of them uniformly at random. 
  What is the probability that it is NOT a red ball?
][
  
]
#brk()
#part(4)[
    Consider 8 balls: 4 white and 4 black. 
    I pick two balls uniformly at random without replacement.
    What is the probability that both balls are black?
][

]

]

#problem[Conditional Probabilities and Bayes' Rule][
  #part(2)[ #h(1fr)
    $
      prob[X = x] = 0.5 \
      prob[Y = y] = 0.3 \
      prob[X = x, Y = y] = 0.15
    $
    What is $prob[X = x given Y = y]$?
  ][]

  #part(2)[
    Write $prob[X = x given Y = y]$ in terms of $prob[Y = y given X = x]$. That is,
    $prob[X = x given Y = y] = lambda dot prob[Y = y given X = x]$ where $lambda$ is
    some expression.
  ][]
]


#problem[Pólya's Urn][

  #part(4)[
    Suppose there are $R>1$ red balls and $G>1$ green balls in a
    box. We pick a ball from the box uniformly at random.  If it is red,
    we put it back in the box; otherwise, we throw it away. After that,
    we pick another ball from the box uniformly at random. 
    What is the probability that the first ball we picked is green,
    conditioned on the fact that the second ball we picked is red? 
  ][

  ]
  #brk()
  #part(5)[
    Suppose there are $R>1$ red and $B>1$ blue balls in an urn. 
    We sample a ball uniformly at random.
    We replace the ball in the urn and add one additional ball
    of the SAME color. After that, we sample a ball and report
    its color.

    What is the distribution of the second ball's color?
  ][

  ]
]

#problem[Understanding Joint Distribution][
Twelve balls will be tossed into six bins numbered ${1, 2, 3, 4, 5,6}$. 
Each ball is thrown into a bin uniformly and independently into the bins. 
For $i in {1,2,3,4,5,6}$, let $X_i$ represent the _number_ of balls
that fall into bin $i$. 

  #part(3)[
    Find $prob[X_1 = 12]$.
  ][

  ]
  #part(5)[
    Find the (marginal) distribution of $X_5$.
  ][]
  #brk()
  #part(7)[
    Find $prob[X_2 = 2 given X_1 + X_3 + X_5 = 5]$.
  ][]
]

#problem[Sending One Bit][
  
  Alice intends to send a bit $b in zo$ to Bob.
  When Alice sends the bit, it goes through a series of
  $n$ relays before reaching Bob. Each relay flips the
  received bit independently with probability $p$ before
  forwarding that bit to the next relay.

  #part(5)[
    Show that Bob will receive the correct bit with probability
    $
      sum_(k = 0)^floor(n \/ 2) binom(n, 2k) dot p^(2k) dot (1 - p)^(n - 2k) .
    $
    Hint: You solution should work irrespective of whether Alice sends
    $0$ or $1$.
  ][

  ]
  #brk()
  #part(5)[
    Let us consider an alternative way to calculate this probability.
    We say that the relay has _bias_ $q$ if the probability it
    flips the bit is $(1-q)\/2$. The bias $q$ is a real number between
    $-1$ and $+1$. Show that sending a bit through two relays with bias
    $q_1$ and $q_2$ is equivalent to sending a bit through a single relay
    with bias $q_1 dot q_2$.
  ][

  ]

  #part(5)[

    Prove that the probability you receive the correct bit
    when it passes through $n$ relays is $ (1+(1-2p)^n)/2. $
  ][

  ]
]


#problem(
  points: 5,
  [Mixing Two Boxes],
  question: [
  Experiment 1: 
  I have two boxes, each with a mix of some red and blue balls. 
  I will select one of the boxes uniformly at random
  (with a probability of $0.5$), then select one of the balls from that box
  uniformly at random and report its color.

  Experiment 2: 
  I pour all the balls from both boxes into one large box.
  After that, I select one of the balls from this large box uniformly
  at random and report its color.

  Are the two color distributions identical, irrespective of how many
  red/blue balls were in the two boxes? Please Justify your answer.
  ]
)[]

#problem(coalesce: true)[][
 Recall that $x mod p$ means the remainder of $x$ when divided by $p$.
  For example, "$13$ divided by $3$" is $4$ with remainder $1$ because
  $13=4 dot 3 + 1$. We write this as: $13 mod 3 = 1$.

  #part(10)[
    Recall the definition of binomial coefficient
    $binom(p, k) := (p!)/(k! (p - k)!)$.
    For a prime $p$, prove that $p$ divides $binom(p, k)$,
    if $k in {1, 2, ..., p - 1}$.
  ][]
  #brk()
  #part(10)[
    Recall that $(1 + x)^p = sum_(k = 0)^p binom(p, k) x^k$. Prove by
    induction on $x$ that, for any $x in {1, 2, ..., p - 1}$, we have
    $ overbrace(x times x times x dots.c times x, p-"times") quad mod p = x. $
  ][]
]
