= -- Plus d'exemples<part3>



== Tableau et grilles de figures
#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 0.7pt + black)
  },
  align: (x, y) => (
    if x > 0 { center }
    else { left }
  )
)

#figure(table(align:horizon+left,columns: 6,

table.header(

[],

[A],

[B],

[C],

[D],

[E]

),

[F], [G], [H], [I], [J], [K],

[L], [M], [N], [O], [P], [Q]

),

caption:[Exemple 3])


Rien n'empêche d'utiliser des images/logo comme icones dans le corps du texte si besoin (#box(image("../images/exemple.png"),width:3%)) .



#figure(grid(gutter:1em,columns: (1fr,1fr),image("../images/exemple.png",height:5.3cm,fit:"stretch"),image("../images/exemple.png",height:5.3cm,fit:"stretch"),grid.cell(colspan:2)[#image("../images/exemple.png",height:5.3cm,)]),caption: [On peut assez facilement créer des présentations plus complexes au besoin])

== Montrer des formules mathématiques
Les formules mathématiques sont très simples à utiliser dans Typst (plus simples qu'en LaTeX en tout cas), elle doivent être encadrées de signes \$. Si il y a un espace entre les \$ et l'expression, la formule sera isolée sur sa ligne (formule importante). Sinon, elle sera intégrée au corps du texte. Exemples tirés de mon mémoire : (plus généralement, référez-vous à la #link("https://typst.app/docs/reference/math/documentation")[documentation])
$ P_"LOS" (x; beta ) = 1/(1+e^(- beta^T x)) $
où :

$x$ est le vecteur de caractéristiques d'une observation, par exemple : $vec(1,x_1,dots.v,x_n​)$

$beta$ est le vecteur des coefficients appris pendant l'entraînement, par exemple : $vec(beta_0,beta_1,
dots.v,beta_n​)$

$ J(beta)=1/M sum_(i=1)^M (P_"LOS" (x_i;beta)-y_i)^2 $<test>

et je peux faire référence à @test

$ overline("PRC") = abs((Delta rho)/(Delta t)-(-lambda f_D)) $ 



$ T'_("lock") = cases(T_("lock") "si" T_("lock")<T_(min),
                      T_(min) "sinon") $

$ "LOS"=cases("Vrai si élévation"_"point">"élévation"_"masque" ("azimut"),"Faux sinon") $



avec $w_x$ le poids associé au vecteur d'observation $x$, 

$ m = cases(1 "si" "LOS" = "True", 1 - alpha  "sinon")$ la probabilité estimée de la proportion de signaux correctement classifiés comme NLOS dans les données d'entraînement,

$alpha in [0,1]$ la pénalité sur les données hors ligne de vue (NLOS), estimation de la proportion de signaux incorrectement classifiés comme NLOS,

$beta >0$ le facteur de pénalité du trajet multiple,

#set math.mat(align: left,delim: "{")
$ "Modèles:" mat( X_("GPS,A") = [overline(C\/"N0")_"L1", overline(C\/"N0")_"L2", overline(C\/"N0")_"L5", overline("PRC")_"L1", T'"lock,L1"];

X_("GPS,B") = [overline(C\/"N0")_"L1", overline(C\/"N0")_"L2", overline("PRC")_"L1", T'_"lock,L1"];

X_("GPS,C") = [overline(C\/"N0")_"L1", overline(C\/"N0")_"L5", overline("PRC")_"L1", T'_"lock,L1"];

X_("GAL,D") = [overline(C\/"N0")_"E1", overline(C\/"N0")_"E5a", overline(C\/"N0")_"E5b", overline("PRC")_"E1", T'_"lock,E1"];

X_("GAL,E") = [overline(C\/"N0")_"E1", overline("PRC")_"E1", T'_"lockE1"]) $

