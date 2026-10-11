#import "notwendig/globals.typ": *

= Methodik <sec:methodik>

== Methodisches Vorgehen <sec:vorgehen>

Hier wird das übergeordnete Vorgehen der Arbeit beschrieben und begründet, warum es zur Beantwortung der Forschungsfrage geeignet ist. Die folgende Abbildung zeigt den Ablauf im Überblick.

#include "../Abbildungen/beispiel/beispiel_blockdiagramm.typ"

Auf die einzelnen Schritte aus @fig:beispiel_blockdiagramm wird in den folgenden Abschnitten im Detail eingegangen.

== Versuchsaufbau und Datengrundlage <sec:aufbau_daten>

Hier werden der Versuchsaufbau, die verwendeten Werkzeuge oder die Datengrundlage so beschrieben, dass die Untersuchung reproduzierbar ist. Dazu gehören auch eingesetzte Mess- und Auswertungsverfahren sowie deren Genauigkeit.

== Auswertungsverfahren <sec:auswertung>

Hier wird beschrieben, wie die erhobenen Daten ausgewertet werden. Verwendete Kennzahlen werden definiert, beispielsweise der mittlere quadratische Fehler

$ "RMSE" = sqrt(1/n sum_(i=1)^n (y_i - hat(y)_i)^2) $ <eq:rmse>

mit den gemessenen Werten $y_i$ und den geschätzten Werten $hat(y)_i$. Die Kennzahl aus @eq:rmse wird in @sec:ergebnisse zur Bewertung herangezogen.

== Grenzen des Vorgehens <sec:methodik_grenzen>

Hier werden bekannte Einschränkungen des gewählten Vorgehens offengelegt, etwa vereinfachende Annahmen, begrenzte Stichprobengrößen oder nicht erfasste Einflussgrößen.
