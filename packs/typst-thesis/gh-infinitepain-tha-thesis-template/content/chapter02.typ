= Noch ein paar Textbestandteile

== Mathematiknotation

Hier kommt eine abgesetzte Formel ohne Nummerierung:

$ (a+1)/(b+1) quad (a+1)/(b+1) quad (a+1)/(b+1) quad a\/b $

In einem Text ist 1/8 schöner als $1/8$.

$ a^2 + b^2 = c^2 $ <eq:pythagoras>

$ a^n + b^n = c^n $ <eq:fermat>

$ e^(i pi) + 1 = 0 "mit" i^2 = -1 $ <eq:schoen>

$ f(x) = A sin(alpha x + b) + log(x) dot sin(x/y) $

$ g(x) = (x(1-x^2))/(1/(2-x^2+3x-y^2)) $

Man nennt die Formel @eq:pythagoras den Satz des Pythagoras. Die Fermat'sche Vermutung besagt, dass Gleichung @eq:fermat keine positiven ganzzahligen Lösungen $a, b, c$ für $n >= 3$ hat und wurde 1994 von Andrew Wiles und Richard Taylor bewiesen.

Gleichung @eq:schoen wird oft als die schönste Gleichung der Mathematik bezeichnet. Um Konstanten von Variablen zu unterscheiden sollte man die Eulersche Zahl sowie die imaginäre Einheit in Formeln aufrecht setzen. Das geht mithilfe von `text(<zeichen>)`.

$ (a+b)^n = sum_(k=0)^n binom(n, k) a^k b^(n-k) $ <eq:binomial>

Der junge Carl-Friedrich Gauss fand zu Schulzeiten die Formel $sum_(j=1)^N = 1/2 N(N+1)$. Innerhalb von Text ist es auch möglich die Grenzen ober- und unterhalb zu setzen. Dafür existiert der Befehl `limits`. Das sieht dann so aus: $zeta(x) = sum_(n=1)^infinity 1/(n^x)$, und erhöht dann etwas unglücklich den Zeilenabstand. Ein paar gesetzte Formeln:

$
           sin(x)^2 + cos(x)^2 & = 1        & integral_1^infinity 1/(x^2) dif x & = 1 \
  (partial f(x,y))/(partial y) & = x^2 + 2y
$

Formeln können mit `&` ausgerichtet werden: hier hat jede Zeile ein & vor dem =. $dot$ ist der Malpunkt, $dots$ und $dots.v$ sind viele Punkte, und $dots.down$ sind diagonal. Dies ist besonders bei der Darstellung von großen Matrizen sinnvoll, zum Beispiel:

$
  A = (a_(i j))_(m,n) = mat(
    a_11, a_12, dots, a_(1n);
    a_21, a_22, dots, a_(2n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n)
  )
$

$ (1/2 + 3/5) dot 7 = 77/10 $

Für logische Zusammenhänge braucht man oft die Implikation $=>$ oder die Äquivalenz $<=>$. Die Verneinung einer Aussage kann man entweder so $not A$ oder auch $overline(A)$ darstellen. Für die logischen Vernüpfungen gibt es $and$ und $or$ (so wie jede Menge anderer Zeichen...).

Manchmal braucht man auch die Menge der natürlichen Zahlen, die man mit `bb()` (blackboard bold) setzen kann:

$ NN = {1, 2, 3, dots } $ <eq:natural>

$ ZZ = {0, plus.minus 1, plus.minus 2, plus.minus 3, dots } $ <eq:integers>

und analog natürlich auch $QQ, RR, CC$ oder beliebige andere Großbuchstaben:

$
  bb(A), bb(B), bb(D), bb(E), bb(F), bb(G), bb(H), bb(I), bb(J), bb(K), bb(L), bb(M), bb(O), bb(P), bb(S), bb(T), bb(V), bb(W), bb(X), bb(Y)
$

Wenn man Matrizen braucht, verwendet man die `mat()` Funktion mit verschiedenen Trennzeichen:

$
  mat(a_11, a_12; a_21, a_22) quad
  mat(delim: "(", a_11, a_12; a_21, a_22) quad
  mat(delim: "|", a_11, a_12; a_21, a_22) quad
  mat(delim: "[", a_11, a_12; a_21, a_22) quad
  mat(delim: "{", a_11, a_12; a_21, a_22)
$

Der `delim` Parameter steuert die Klammerart. Zur Fallunterscheidung gibt es die `cases()` Funktion:

$
  |x| = cases(
    x "falls" x > 0,
    -x "falls" x < 0
  )
$

Will man unter oder über Terme etwas schreiben, so gibt es die Befehle `underbrace` und `overbrace`:

$
  underbrace(x^3 + 7x^2 + 3x - 7 = 0, "notwendige Bedingung") quad
  overbrace(f'(x) = 0, "Nullstellen")
$ <eq:braces>

Mit `underline` und `overline` können Ausdrücke in einer Mathematikumgebung unterstrichen bzw. überstrichen werden:

$ underline(a) = arrow(a) = frak(a) "oder" overline(a + i b) = a - i b $

Oft sind in wissenschaftlich-mathematischen Texten griechische Buchstaben nötig:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 15mm,
  [
    #table(
      columns: (auto, auto, auto),
      align: (center, center, left),
      [*Klein*], [*Groß*], [*Name*],
      [$alpha$], [A], [Alpha],
      [$beta$], [B], [Beta],
      [$gamma$], [$Gamma$], [Gamma],
      [$delta$], [$Delta$], [Delta],
      [$epsilon, epsilon.alt$], [E], [Epsilon],
      [$zeta$], [Z], [Zeta],
      [$eta$], [H], [Eta],
      [$theta, theta.alt$], [$Theta$], [Theta],
      [$iota$], [I], [Iota],
      [$kappa$], [K], [Kappa],
      [$lambda$], [$Lambda$], [Lambda],
      [$mu$], [M], [My],
    )
  ],
  [
    #table(
      columns: (auto, auto, auto),
      align: (center, center, left),
      [*Klein*], [*Groß*], [*Name*],
      [$nu$], [N], [Ny],
      [$xi$], [$Xi$], [Xi],
      [o], [O], [Omikron],
      [$pi$], [$Pi$], [Pi],
      [$rho, rho.alt$], [P], [Rho],
      [$sigma$], [$Sigma$], [Sigma],
      [$tau$], [T], [Tau],
      [$upsilon$], [$Upsilon$], [Ypsilon],
      [$phi, phi.alt$], [$Phi$], [Phi],
      [$chi$], [X], [Chi],
      [$psi$], [$Psi$], [Psi],
      [$omega$], [$Omega$], [Omega],
    )
  ],
)

== Aufzählungen

Es gibt im wesentlichen drei Formen von Listen bzw. Aufzählungen

=== Nummerierte Aufzählungen

Nummerierte Listen werden mit `+` erstellt:

+ Die erste Ebene
  + zweite Ebene
  + zweiter Eintrag zweite Ebene
  + Hier nun die dritte Ebene:
    + Meistens ist es nicht nötig noch weiter zu schachteln
    + aber sollte man es doch mal brauchen, so steht auch noch
      + weitere
      + Ebenen
      + zur Verfügung.
    + Aber meist reicht diese hier!
+ Zweiter Eintrag in der ersten Ebene

=== Ohne Nummerierung

Unnummerierte Listen werden mit `-` erstellt:

- Die erste Ebene
  - zweite Ebene
  - zweiter Eintrag zweite Ebene
  - Hier nun die dritte Ebene:
    - Meistens ist es nicht nötig noch weiter zu schachteln
    - aber sollte man es doch mal brauchen, so steht auch noch
      - genau eine weitere
      - Ebene
      - zur Verfügung.
    - Aber meist reicht die dritte schon.
- Zweiter Eintrag in der ersten Ebene

=== Beschreibende Aufzählungen

Definitionslisten werden mit `/` erstellt:

/ Begriff: Diese Listenform eignet sich für Definitionen oder Beschreibungen. Der Begriff steht vor dem Doppelpunkt, die Beschreibung danach.

/ Zweiter Begriff: Alle folgenden Zeilen sind automatisch eingerückt, was den Text übersichtlich macht.
