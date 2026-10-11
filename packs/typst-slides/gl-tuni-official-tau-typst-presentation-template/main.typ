/** presentation.typ
 *
 * The main file of this presentation. Compile it into a PDF with
 *
 *   typst compile main.typ
 *
 * in your favourite shell.
 *
***/

#import "tau-presentation.typ": tau-presentation, frame, tunipurple
#import "preamble.typ": *

#show: doc => tau-presentation(
	authors: (
		(
			name:"Santtu Söderholm",
			email: "santtu.soderholm@tuni.fi",
			organization: "Tampere University",
		),
	),
	main-title: [Presentation title],
	keywords: ("Tampere University","presentation",),
	invert-title-page-colors: false,
	show-code-line-numbers: true,
	language: "en",
	doc
)

#frame(
	alignment:left,
	[A frame with bullets],
	list(
		[This is a bullet.],
		[Here is a second item.],
		[Julia is good for scientific computing.~@bezanson2017julia],
		[ Here's an equation:
		$
			integral_a^b f(x) dif x = F(b) - F(a) ...
		$ <eq>
		],
		[ … and here's a reference to it: @eq.],
	)
)

#frame(
	[A frame with an image],
	image("images/tau-logo-fin-eng.svg",width:100%)
)

#frame(
	alignment:left,
	[A frame with a matrix–vector product],
	[
		When modelling brain activity, the forward solution of Maxwell's
		equations is usually encoded into a so-called _lead field matrix_
		#lfMat. It maps a set of synthetic dipole moments $matrix(D)$ to a set
		of measurements $matrix(M)$ as follows~@söderholm2024peeling:
		$
			lfMat matrix(D) = matrix(M) + matrix(Epsilon) thin .
		$
		Here $matrix(Epsilon)$ is an error caused by numerical simulation and
		noise. For a single dipole moment $vector(d) =
		transpose([d_x,d_y,d_z])$, the mapping is achieved via
		$
			restriction(lfMat,vector(d)) vec(d_x,d_y,d_z) = vector(m) + vector(epsilon) thin ,
		$
		where $restriction(lfMat,vector(d))$ is a restriction of $lfMat$ to
		$vector(d)$, $vector(m) in matrix(M)$ and $vector(epsilon) in
		matrix(Epsilon)$.
	]
)

#frame(
	alignment: left,
	[A frame with a _lot_ of text. Seriously, don't do anything like this.],
	lorem(200)
)

#frame(
	alignment: left,
	[A frame with code],
	[

	Here is a code block:

```julia
"""
	out = square(x::Complex)

Computes the square of an 𝑥 ∊ ℝ.

"""
function square(x::Real)
	x * x
end

"""
	out = square(x::Complex)

Computes the square of an 𝑥 ∊ ℂ.

"""
function square(x::Complex)
	conj(x) * x
end
```

Here is inline code: `code`.

	]
)

#frame(
	alignment:left,
	[References],
	{
		// Prevent page breaks within bib items.
		set grid.cell(breakable: false)
		bibliography(
			"references.bib",
			style:"elsevier-with-titles",
			title:none
		)
	}

)

#page(fill:tunipurple)[
	#set text(fill:white,size:40pt)
	#set align(center + horizon)
	Thanks!
]
