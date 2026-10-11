#import "@preview/theorion:0.6.0": *
#import cosmos.simple: *
#show: show-theorion

= Scrittura

Di solito, i capitoli di tesi iniziamo con una breve introduzione del loro
argomento.

== Italiano

In italiano, le parole accentate hanno quasi sempre un accento grave, ad
esempio: partì, mangiò, perciò, così. L'accento acuto si utilizza sempre con i
composti di "che": perché, poiché, benché e via dicendo.

Quando si compone un elenco, lo si può fare con o senza enumerazione e la scelta
spetta allo scrittore. Sarebbe buona norma che le liste con elementi che non
superano il periodo, siano introdotte con i _due punti_. Ogni elemento di tale
lista termina con il _punto e virgola_, tranne l'ultimo che termina con un
_punto_.

#example[
  Possiamo distinguere tre grandi famiglie di algoritmi crittografici:
  + _simmetrici_, in cui la chiave usata per la cifratura è la medesima di
    quella per la decifratura;
  + _asimmetrici_, in cui le chiavi, dette pubblica e privata, sono distinte;
  + _hash_, il cui output ha lunghezza prescritta e computazionalmente difficile
    da invertire.
]

Se volessimo usare un elenco per elementi che sono identificabili con piccoli
paragrafi, si dovrebbe procedere con la punteggiatura normale.

#example[
  Quanto è bello il latino, soprattutto in questi cinque esempi.
  - #lorem(55)
  - #lorem(43)
  - #lorem(21)
  - #lorem(64)
  - #lorem(39)
]

== Matematica

Le formule, ricordano LaTeX e sono facili da scrivere!

$
  lim_(x -> x_0) f(x) = l => forall epsilon > 0,
  exists delta = delta(epsilon) : |f(x) - l| < epsilon,
  forall x: |x - delta| < 0, x != x_0
$

Inoltre, si possono usare ambienti per: definizioni, teoremi, osservazioni, ...

#definition[
  Un numero $n$ esprimibile come prodotto di due primi $p$ e $q$ è detto
  semiprimo.
]

#theorem[
  Sia $n$ semiprimo. Se è nota $phi(n)$, allora è computazionalmente trattabile
  la fattorizzazione $n$.
]

#proof[
  Se $n$ è semiprimo allora esistono $p$ e $q$ primi tali che $n = p q$. Avremo
  che
  $ phi(n) = (p - 1)(q - 1) $
  da cui
  $ phi(n) = n - p - q + 1. $
  Possiamo allora scrivere il sistema
  $
    cases(
      p + q = n - phi(n) + 1,
      p q = n,
    )
  $ <eq:sistema_phi>
  Il resto è banale e viene lasciato al lettore.
]

#remark[
  Il sistema~(@eq:sistema_phi) è simmetrico.
]

== Informatica

La scrittura del codice è nativa!

```python
import numpy as np

def incmatrix(genl1,genl2):
    m = len(genl1)
    n = len(genl2)
    M = None #to become the incidence matrix
    VT = np.zeros((n*m,1), int)  #dummy variable

    #compute the bitwise xor matrix
    M1 = bitxormatrix(genl1)
    M2 = np.triu(bitxormatrix(genl2),1)

    for i in range(m-1):
        for j in range(i+1, m):
            [r,c] = np.where(M2 == M1[i,j])
            for k in range(len(r)):
                VT[(i)*n + r[k]] = 1;
                VT[(i)*n + c[k]] = 1;
                VT[(j)*n + r[k]] = 1;
                VT[(j)*n + c[k]] = 1;

                if M is None:
                    M = np.copy(VT)
                else:
                    M = np.concatenate((M, VT), 1)

                VT = np.zeros((n*m,1), int)

    return M
```
