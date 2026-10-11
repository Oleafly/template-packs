#import "lib/lib.typ": *
#title(
    title: "Solved Examples 1",
    author: "Michael Goppert (mtg2447)",
    class: "CS 331H",
    semester: "Spring 2025",
)

+ #q[
Consider a town with $n$ men and $n$ women seeking to get married to one
another. Each man has a preference list that ranks all the women, and each
woman has a preference list that ranks all the men.

The set of all $2n$ people is divided into two categories: good people and
bad people. Suppose that for some number $k$, $1 lt.eq k lt.eq n − 1$, there are $k$ good
men and $k$ good women; thus there are $n − k$ bad men and $n − k$ bad women.

Everyone would rather marry any good person than any bad person.
Formally, each preference list has the property that it ranks each good person
of the opposite gender higher than each bad person of the opposite gender: its
first $k$ entries are the good people (of the opposite gender) in some order, and
its next $n − k$ are the bad people (of the opposite gender) in some order.

Show that in every stable matching, every good man is married to a good
woman.

#proof[
    By contradiction.

    Suppose that a good man, $m_g$, ended up married to a bad woman, $w_b$, in some stable matching $S$.
    If this is the case, then there remain $k - 1$ good men and $k$ good women.
    Thus, there must exist another good woman, $w_g$, married to a bad man, $m_b$,
    for $S$ to be perfect. Since $S$ must be perfect to be stable, this must be the case.

    Then, there is an instability.
    Since $w_g$ is good, she must rank higher than $w_b$ in the preference list of $m_g$.
    By similar reasoning, $m_g$ must rank higher than $m_b$ in ther prefernece list of $w_g$.
    Thus, $m_g$ prefers $w_g$ and $w_g$ prefers $m_g$, which is an instability.

    We have shown that there cannot exist a stable matching where a good man is married to a bad woman.
    Therefore, in every stable matching, every good man is married to a good woman.
]
]

#collaborators(
    collaborators: "A, B, ...",
)
