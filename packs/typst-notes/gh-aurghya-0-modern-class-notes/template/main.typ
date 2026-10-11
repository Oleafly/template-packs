#import "../lib.typ": *

#show: class-notes.with(
  title: "Algorithms & Data Structures",
  subtitle: "Official Lecture Notes & Problem Sets",
  course: "CS 301: Data Structures & Algorithms",
  course-code: "CS 301",
  semester: "Fall 2026",
  university: "Department of Computer Science, State University",
  author: "Prof. Alan Turing",
  instructor-email: "a.turing@university.edu",
  date: "October 2026",
  accent-color: rgb("#1d4ed8"), // Deep Indigo/Blue
  mode: "instructor", // Switch to "student" to hide solutions and instructor notes
  paper: "a4",
  show-outline: true,
  show-title-banner: true,
)

= Module 1: Graph Algorithms & Dynamic Programming

#lecture(
  number: 1,
  title: "Asymptotic Analysis & Recurrences",
  date: "Oct 12, 2026",
  topics: ("Big-O Notation", "Master Theorem", "Divide and Conquer")
)

#learning-objectives((
  [Understand runtime growth bounds ($O, Omega, Theta$).],
  [Apply the Master Theorem to solve divide-and-conquer recurrences.],
  [Evaluate algorithmic trade-offs between iterative and recursive solutions.]
))

== 1.1 Asymptotic Notations

When analyzing algorithm performance, we focus on the rate of growth of the execution time as the input size $n$ grows arbitrarily large.

#definition(title: "Big-O Notation")[
  Let $f(n)$ and $g(n)$ be functions from $NN$ to $RR^+$. We write $f(n) = O(g(n))$ if there exist positive constants $c > 0$ and $n_0 >= 1$ such that:
  $ f(n) <= c dot g(n) quad "for all" n >= n_0 $
]

#tip[
  Always simplify Big-O expressions by dropping low-order terms and constant coefficients. For instance, $O(3n^2 + 5n + 10) = O(n^2)$.
]

== 1.2 The Master Theorem

For divide-and-conquer recurrences of the form $T(n) = a T(n/b) + f(n)$, where $a >= 1$ and $b > 1$:

#theorem(title: "Master Theorem for Recurrences")[
  Let $T(n) = a T(n/b) + f(n)$. Define the critical exponent $c_"crit" = log_b a$.
  1. *Case 1:* If $f(n) = O(n^(c_"crit" - epsilon))$ for some $epsilon > 0$, then $T(n) = Theta(n^(log_b a))$.
  2. *Case 2:* If $f(n) = Theta(n^(c_"crit") log^k n)$ for $k >= 0$, then $T(n) = Theta(n^(log_b a) log^(k+1) n)$.
  3. *Case 3:* If $f(n) = Omega(n^(c_"crit" + epsilon))$ for $epsilon > 0$ and regularity holds, then $T(n) = Theta(f(n))$.
]

#example(title: "Merge Sort Recurrence")[
  Merge Sort splits an array into 2 halves ($a=2, b=2$) and takes $O(n)$ time to merge.
  $ T(n) = 2 T(n/2) + O(n) $
  Here $log_b a = log_2 2 = 1$. Since $f(n) = Theta(n^1)$, we trigger *Case 2* with $k=0$:
  $ T(n) = Theta(n log n) $
]

#exercise(
  title: "Solving Recurrence Relations",
  solution: [
    Applying the Master Theorem with $a=4, b=2, f(n)=n$:
    $log_b a = log_2 4 = 2$.
    Since $f(n) = n = O(n^(2 - 1))$, *Case 1* applies.
    Therefore, $T(n) = Theta(n^2)$.
  ],
  [
    Determine the tight asymptotic bound $T(n)$ for the recurrence relation:
    $ T(n) = 4 T(n/2) + n $
  ]
)

#instructor-note[
  *Pedagogical Hint for TAs:* Ensure students do not mistakenly apply Case 3 without verifying the regularity condition $a f(n/b) <= c f(n)$ for some $c < 1$.
]

#lecture(
  number: 2,
  title: "Dynamic Programming: Shortest Paths",
  date: "Oct 14, 2026",
  topics: ("Optimal Substructure", "Bellman-Ford Algorithm", "Memoization")
)

#key-terms((
  "Optimal Substructure": [A problem exhibits optimal substructure if an optimal solution contains optimal solutions to subproblems.],
  "Overlapping Subproblems": [Subproblems are recomputed multiple times in a naive recursive solution.],
  "Memoization": [Top-down optimization technique that caches subproblem answers in a lookup table.]
))

== 2.1 The Bellman-Ford Algorithm

Unlike Dijkstra's algorithm, the Bellman-Ford algorithm handles graphs with negative edge weights and detects negative weight cycles.

```python
def bellman_ford(vertices, edges, source):
    # Initialize distances
    dist = {v: float('inf') for v in vertices}
    dist[source] = 0

    # Relax edges |V| - 1 times
    for _ in range(len(vertices) - 1):
        for u, v, weight in edges:
            if dist[u] + weight < dist[v]:
                dist[v] = dist[u] + weight

    # Check for negative-weight cycles
    for u, v, weight in edges:
        if dist[u] + weight < dist[v]:
            raise ValueError("Graph contains a negative-weight cycle")

    return dist
```

#warning[
  If a graph contains a cycle whose total edge weight is negative, shortest paths are undefined because one can traverse the cycle infinitely to achieve $-infinity$ distance.
]

#important[
  Remember that the Bellman-Ford algorithm runs in $O(|V| dot |E|)$ time, which is slower than Dijkstra's $O((|V| + |E|) log |V|)$ for non-negative graphs.
]
