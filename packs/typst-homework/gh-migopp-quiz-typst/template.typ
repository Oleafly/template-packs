#import "lib/lib.typ": *

// --- config ---
#set text(font: "New Computer Modern Math")
#set page(
	margin: (x: 1.0cm, y: 1.2cm),
)
#set text(
	size: 12pt,
)
#show quote.where(block: true): q => [
	// Quote styling from:
	// https://gist.github.com/floffy-f/9c9fbcc2889116b5f2faced008611cf1
	#block(
		fill: luma(250),
		inset: (left: 3%, y: 10%),
		radius: (right: 5pt),
		stroke: (left: 2pt+luma(100)),
		q
	)
]


// --- preamble ---
//
// This is the table that provides quiz general information.
//
// The variables are somewhat self-explanatory.
#preamble(class: "CS439", quiz_no: 1, time_limit: 50)
#v(10%)
// The points distribution table
#align(center)[
	#table(
		// The number of `auto` here should be the number of
		// questions + 1
		//
		// The extra comes from the `total` column
		columns: (auto, auto, auto),
		align: horizon,
		// There should be `questions + 1` elements here
		table.header[*1*][*2*][*T*],
		// And below here, `questions + 1` copies
		[#h(7.5%) #v(4%)],
		[#h(7.5%) #v(4%)],
		[#h(7.5%) #v(4%)],
	)
]
#pagebreak()

// --- q1 ---
1. #question(points: 9)[
	Suppose that Dr. Gheith said something one time, and it was really cool. Maybe it was about a surfing penguin, or a comment about how `Java` is bad. Maybe we can have some code block with syntax highlighting with `Java`.

	```Java
	public class OSQuiz {
		public static void main(String args[]) {
			system.out.println("Welcome to CS439!");
		}
	}
	```

	1. #part(points: 1, space: 10%)[
		`Java` is a popular language. Why might it be good?
	]

	2. #part(points: 8, space: 0%)[
		Why might it be bad?
	]
]
#pagebreak()

// --- q2 ---
2. #question(points: 1)[
	What's up with ostriches?
]
