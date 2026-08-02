#let note(
        title:"Note Title", 
        author: "Name", 
        mail: "None@none.none", 
        logo: none,
        preface: none, 
        boxed_heading: false, 
        body
    ) = {
    // Set the basic properties of this document
    set document(author: (author,), title: title)
    set page(
        header-ascent: 14pt,
        header: locate(
            loc => {
                let i = counter(page).at(loc).first()
                if i == 1 { return }
                set text(size: 8pt)
                if calc.odd(i) {align(end, title)} else{
                    align(start, title)
                }
            }
        ),
        paper: "a4"
    )
    set text(font: ("New Computer Modern", "Noto Sans CJK SC"), lang: "en", size: 14pt)
    show math.equation: set text(font: "New Computer Modern Math", weight: 400)
    // Set paragragh spacing.
    show par: set block(above: 1.2em, below: 1.2em)
    set par(leading: 0.75em)

    /*title page,preface and contents*/
    {
        //title page
        set page(numbering: none)
        if logo != none {
            align(center+top, image(logo, width: 40%))
        }   
        v(5pt)
        align(
            center,
            text(3em, weight: 700, title),
        )
        //Author Information
        align(right,author)
        //preface and contents
        pagebreak()
        if preface != none {
            [
                = Preface
            ]

            preface
            pagebreak()
            [
                = Contents
            ]
            outline(title: none, depth: 3, indent: true)
        } else {
            outline(depth: 3, indent: true)
        }
    }
    pagebreak()
    /*title page end*/
    /*Main body*/
    set page(numbering: "1",number-align: center)
    set par(justify: true)
    set heading(numbering: "1.1")
    /*Heading*/
    show heading.where(level: 1) : it =>{ 
        if not boxed_heading { return it }
        block(
            align(
                left,
                text(
                    font: ("New Computer Modern", "Noto Sans CJK SC"),
                    weight: 600,
                    size: 2em,
                    it + v(0.5em)
                )
            )
        )
    }
    show heading.where(level: 2) : it => {
        if not boxed_heading { return it }
        stack(
            dir: ttb,
            rect(
                width: 10em,
                height: 0.4em,
                fill: blue,
                radius: ( bottom-right: 10pt )
            ),
            rect(
                width: 100%,
                fill: luma(220),
                radius: ( top-right: 10pt ),
                stroke: (
                    left: none,
                    top: none,
                    bottom: none,
                    right: none,
                ),
                
            )[
                #align(
                    left,
                    it
                )
            ]
        )
    }

    /*Code Block with no line numbers*/
    show raw.where(block: false) : box.with(
        fill: luma(200),
        inset: (x: 3pt, y: 0pt),
        outset: (y:3pt),
        radius: 2pt
    )
    show raw.where(block: true) : it => stack(
        dir:ttb,
        rect(
            width: 100%,
            height: 1.5em,
            fill: luma(100),
            radius: (
                top-left : 5pt,
                top-right: 5pt,
            ),
            
        )[
            #stack(
                dir: ltr,
                spacing: 0.7em,
                circle(
                    radius: 0.5em,
                    fill: red
                ),
                circle(
                    radius: 0.5em,
                    fill: yellow
                ),
                circle(
                    radius: 0.5em,
                    fill: green,
                ),
            )
        ],
        rect(
            width: 100%,
            fill: luma(240),
            inset: 10pt,
        )[
            #let lines = it.text.split("\n")
            #let length = lines.len()
            #let i = 0
            #let left_str = while i < length {
                i = i + 1
                str(i) + "\n"
            }
            #grid(
                columns: (auto, 1fr),
                align(
                    right,
                    block(
                        inset: (
                            top: 1pt,
                            bottom: 1.5em,
                            left: 0pt,
                            right: 2em,
                        ),
                        left_str
                    )
                ),
                align(left, it)
            )
        ]
    )
    /*Code Block with line numbers*/

    body 
}

    /*Basic environment*/
#let base_env(type: "Theorem", name: none, numbered: true, fg: black, bg: luma(230), body) = locate(
    location => {
        let lvl = counter(heading).at(location)
        let i = counter(type).at(location).first()
        let top = if lvl.len() > 0 { lvl.first() } else { 0 }
        show: block.with(spacing: 11.5pt)
        stack(
            dir: ttb,
            rect(
                fill: fg,
                radius: (top-right: 5pt),
                stroke: fg,
            )[
                #strong(
                    text(white)[
                        #type
                        #if numbered {
                            counter(type).step()
                            [#top.#i.]
                        }
                        #if name != none [ (#name) ]
                    ]
                )
            ],
            rect(
                width: 100%,
                fill: bg,
                radius: ( right: 5pt ),
                stroke: (
                    left: fg,
                    right: bg + 0pt,
                    top: bg + 0pt,
                    bottom: bg + 0pt,
                )
            )[
                #body
            ]
        )
    }
)
/*Derived environment*/
#let theorem = base_env.with(
    type: "Theorem",
    fg: blue,
    bg: rgb("#e8e8f8"),
)

#let definition = base_env.with(
    type: "Definition",
    fg: orange,
    bg: rgb("#f8e8e8")
)

#let deduction = base_env.with(
    type: "Deduction",
    fg: purple,
    bg: rgb("#efe6ff"),
)

#let proof(body) = block(
    fill: luma(240),
    spacing: 11.5pt,
    {
        emph[Proof.]
        [ ] + body
        h(1fr)
        box(
            scale(
                160%,
                origin: bottom + right,
                sym.square.stroked,
            )
        )
    }
)

