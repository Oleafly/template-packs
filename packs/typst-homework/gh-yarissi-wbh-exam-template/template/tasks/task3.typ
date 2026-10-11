#import "../../src/lib.typ": solution, subtask, task

#task(points: 35, title: "Programmierung: Rekursion")

#subtask(title: "a)", points: 10)[
  *Erläutern Sie das Prinzip der Rekursion und nennen Sie ein typisches Anwendungsbeispiel.*
]

#solution[
  Rekursion ist eine Programmiertechnik, bei der sich eine Funktion selbst aufruft. Sie besteht aus:
  1. *Basisfall (Anker):* Die Bedingung, die die Rekursion beendet.
  2. *Rekursionsschritt:* Der Selbstaufruf mit einem vereinfachten Problem.
  Ein typisches Beispiel ist die Berechnung der Fakultät oder der Fibonacci-Folge.
]

#subtask(title: "b)", points: 15)[
  *Implementieren Sie eine rekursive Funktion zur Berechnung der Fakultät $n!$ in Python.*
]

#solution[
  ```python
  def factorial(n):
      if n == 0:
          return 1
      return n * factorial(n - 1)
  ```
]



#subtask(title: "c)", points: 10)[
  *Analysieren Sie die Laufzeitkomplexität Ihrer Implementierung.*
]

#solution[
  Die Funktion ruft sich $n$-mal selbst auf, bevor der Basisfall erreicht wird. In jedem Aufruf wird eine konstante Anzahl von Operationen durchgeführt (Vergleich, Multiplikation).
  Daher beträgt die Laufzeitkomplexität $O(n)$.
]
