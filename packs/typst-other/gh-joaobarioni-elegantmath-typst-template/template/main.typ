#import "../src/lib.typ": *

#show: elegantmath.with(
	title: "Modelagem Matemática",
	subtitle: "Cálculo Integral e Diferencial",
	subsubtitle: "Lista de Exercícios - Módulo 3",
	number: "2024.1",
	author: "Prof. João Silva",
	email: "joao.silva@universidade.edu.br",
	font: "New Computer Modern",
	theme: "night" // ou "light"
)

= Introdução ao Cálculo Integral

#elegantmath-info(
	type: "info",
	title: "Objetivo da Lista"
)[
	Esta lista de exercícios aborda conceitos fundamentais de integração, incluindo:
	- Técnicas básicas de integração
	- Integração por partes
	- Substituição trigonométrica
	- Aplicações de integrais
]

== Definições Importantes

#elegantmath-definition(
	term: "Integral Indefinida"
)[
	A integral indefinida de uma função $f(x)$ é o conjunto de todas as suas primitivas, denotada por:
	
	$ integral f(x) dif x = F(x) + C $
	
	onde $F'(x) = f(x)$ e $C$ é uma constante arbitrária.
]

#elegantmath-theorem(
	name: "Teorema Fundamental do Cálculo",
	number: "1.1"
)[
	Se $f$ é contínua em $[a,b]$ e $F$ é uma primitiva de $f$ em $[a,b]$, então:
	
	$ integral_a^b f(x) dif x = F(b) - F(a) $
]

= Exercícios Resolvidos

== Técnicas Básicas de Integração

#elegantmath-problem(
	title: "Integral do Logaritmo Natural",
	difficulty: "medium",
	points: 8
)[
	Calcule a integral indefinida:
	$ integral ln x dif x $
][
	Utilizaremos a técnica de integração por partes.
	
	#elegantmath-steps((
		[Escolhemos $u = ln x$ e $dif v = dif x$],
		[Calculamos $dif u = 1/x dif x$ e $v = x$],
		[Aplicamos a fórmula: $integral u dif v = u v - integral v dif u$],
		[Substituímos os valores encontrados],
		[Resolvemos a integral restante]
	))
	
	Desenvolvimento:
	$ integral ln x dif x &= x ln x - integral x dot 1/x dif x \
	                      &= x ln x - integral dif x \
	                      &= x ln x - x + C $
	
	#elegantmath-final[
		$ integral ln x dif x = x ln x - x + C $
	]
]

#elegantmath-problem(
	title: "Integral Trigonométrica",
	difficulty: "easy",
	points: 5
)[
	Calcule:
	$ integral sin(3x) cos(3x) dif x $
][
	Podemos usar a identidade trigonométrica $sin(2θ) = 2sin(θ)cos(θ)$.
	
	Note que $sin(3x)cos(3x) = 1/2 sin(6x)$
	
	Portanto:
	$ integral sin(3x) cos(3x) dif x &= integral 1/2 sin(6x) dif x \
	                                  &= 1/2 integral sin(6x) dif x \
	                                  &= 1/2 dot (-1/6 cos(6x)) + C \
	                                  &= -1/12 cos(6x) + C $
	
	#elegantmath-final[
		$ integral sin(3x) cos(3x) dif x = -1/12 cos(6x) + C $
	]
]

== Aplicações Práticas

#elegantmath-problem(
	title: "Área sob uma Curva",
	difficulty: "hard",
	points: 12
)[
	Encontre a área da região limitada pelas curvas $y = x^2$ e $y = 2x + 3$.
][
	#elegantmath-info(type: "warning")[
		Para encontrar a área entre curvas, primeiro precisamos determinar os pontos de interseção.
	]
	
	*Passo 1:* Encontrar pontos de interseção
	
	Igualando as funções: $x^2 = 2x + 3$
	
	$x^2 - 2x - 3 = 0$
	
	$(x - 3)(x + 1) = 0$
	
	Logo, $x = -1$ ou $x = 3$
	
	*Passo 2:* Determinar qual função está acima
	
	Para $x = 0$: $y_1 = 0^2 = 0$ e $y_2 = 2(0) + 3 = 3$
	
	Portanto, $2x + 3 > x^2$ no intervalo $[-1, 3]$.
	
	*Passo 3:* Calcular a área
	
	$ "Área" = integral_{-1}^{3} (2x + 3 - x^2) dif x $
	
	$ = integral_{-1}^{3} (-x^2 + 2x + 3) dif x $
	
	$ = [-x^3/3 + x^2 + 3x]_{-1}^{3} $
	
	$ = (-27/3 + 9 + 9) - (1/3 + 1 - 3) $
	
	$ = (-9 + 18) - (1/3 - 2) $
	
	$ = 9 - (-5/3) = 9 + 5/3 = 32/3 $
	
	#elegantmath-final[
		A área da região é $32/3$ unidades quadradas.
	]
]

= Exercícios Propostos

#elegantmath-info(type: "success")[
	Resolva os exercícios a seguir aplicando as técnicas estudadas.
]

1. Calcule $integral x^3 e^(x^4) dif x$

2. Encontre $integral (x^2 + 1)/(x^3 + 3x + 2) dif x$

3. Determine a área entre $y = sin x$ e $y = cos x$ no intervalo $[0, π/2]$

#elegantmath-code(
	caption: "Verificação com Software",
	language: "python"
)[
```python
import numpy as np
from scipy import integrate

# Verificar a integral do logaritmo
def integrand(x):
    return np.log(x)

result, error = integrate.quad(integrand, 1, 2)
print(f"Resultado numérico: {result:.6f}")

# Verificar usando a fórmula analítica
x = 2
analytical = x * np.log(x) - x - (1 * np.log(1) - 1)
print(f"Resultado analítico: {analytical:.6f}")
```
]

#pagebreak()

= Gabarito e Dicas

#elegantmath-info(type: "info", title: "Dicas Importantes")[
	- Sempre verifique sua resposta derivando o resultado
	- Para integrais definidas, use o Teorema Fundamental do Cálculo
	- Lembre-se das constantes de integração em integrais indefinidas
	- Pratique o reconhecimento de padrões para escolher a técnica adequada
]

#align(center)[
	#text(size: 14pt, weight: "bold")[
		Boa sorte nos estudos!
	]
]
