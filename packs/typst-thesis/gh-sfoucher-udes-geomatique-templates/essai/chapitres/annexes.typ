#import "../styles.typ": *

= Annexes <chap:annexes>

// Annexe 1
== Titre de l'annexe 1 <sec:annexe-A1>
Contenu de l'annexe.
#pagebreak()

// Annexe 2
== Titre de l'annexe 2 <sec:annexe-A2>
Contenu de l'annexe.
#pagebreak()

// Annexe 3 : Scripts JavaScript Google Earth Engine
== Scripts JavaScript pour Google Earth Engine <sec:annexe-GEE>
#code-source(read("../Scripts_Programmes/GEE1.js"), "js",
  [Script JavaScript GEE pour...], etiquette: <code:GEE1>)
#pagebreak()
  
// Annexe 4 : Scripts Python
== Scripts Python <sec:annexe-Python>
#code-source(read("../Scripts_Programmes/CodePython1.py"), "python",
  [Script Python pour...], etiquette: <code:scriptPy1>)
#pagebreak()

// Annexe 5 : Scripts R
== Scripts R <sec:annexe-R>
#code-source(read("../Scripts_Programmes/CodeR1.R"), "r",
  [Script R pour...], etiquette: <code:scriptR1>)
#pagebreak()

// Annexe 6 : Programmes C
== Programmes C <sec:annexe-C>
#code-source(read("../Scripts_Programmes/CodeC1.C"), "c",
  [Code C pour le calcul de la distance de Haversine], etiquette: <code:scriptC1>)
#pagebreak()

// Annexe 7 : Code MATLAB
== Programmes MATLAB <sec:annexe-MATLAB>
#code-source(read("../Scripts_Programmes/CodeMathlab1.m"), "matlab",
  [Code MATLAB pour le calcul de la distance de Haversine], etiquette: <code:scriptMatlab1>)
