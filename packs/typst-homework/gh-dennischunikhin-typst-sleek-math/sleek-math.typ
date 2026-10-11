#import "@preview/shadowed:0.2.0": shadowed
#import "@preview/i-figured:0.2.4"

// Label that will make a section unnumbered
#let NO_NUM_LABEL = label("nonum")

#let linepad = v(4pt)

#let box_counter_elements = (
    "Example": black,
    "Definition": color.hsv(-10deg, 100%, 75%),
    "Corollary": color.hsv(275deg, 100%, 75%),
    "Lemma": color.hsv(185deg, 100%, 60%),
    "Theorem": color.hsv(225deg, 95%, 75%),
    "Proposition": color.hsv(37deg, 100%, 70%)
)
#let heading_counters = box_counter_elements.keys().map(key => counter(key))
#let _ = heading_counters.map(cntr => cntr.update(1))

#let numbered_section_state = state("numbered_section_state", false)


#let title(position: top, padding-top: 0pt, author: none, date: none, spacing: 20pt, body) = align(center + position, [
    #set par(spacing: 0cm)
    #v(padding-top)
    #text(size: 22pt, weight: "bold", body)
    #v(spacing)
    #text(size: 16pt, author)
    #v(spacing)
    #text(size: 15pt, date)
])


// Counters for section elements
#let counter-heading-display(countr, loc: none) = context [#{
    //let heading_select = selector(heading.where(depth:1)).before(here())
    let location = loc
    if loc == none {
        location = here()
    }
    if numbered_section_state.at(location) {
        str(counter(heading).at(location).at(0)) + "."
        //str(counter(heading_select).get().at(0)) + "."
    } + str(countr.at(location).at(0))
}]


// Template
#let sleek-math(doc) = {
    set text(
        font: "New Computer Modern",
        size: 11pt
    )
    set page(numbering: "1")

    // Replace numbers with math numbers (TODO)
    //#show regex("(^| )[0-9]+"): set text(fill: red)


    show math.equation: it => context({
        if numbered_section_state.get() {
            i-figured.show-equation(
                it,
                numbering: (..n) => text(numbering("(1.1)", ..n))
            )
        } else {
            i-figured.show-equation(
                it,
                level: 0
            )
        }
    })

    show math.equation.where(label: NO_NUM_LABEL): it => {
        counter(math.equation).update((..n) => n.pos().at(0)-1)
        i-figured.show-equation(
            it,
            numbering: (..n) => ""
        )
    }
    
    // Unnumbered sections
    show heading.where(label: NO_NUM_LABEL): it => {
        set heading(numbering: none)
        block(
            inset: (left: 0pt),
            it.body
        )

        // Decrement heading counter at the right depth
        counter(heading).update((..n) => n.pos().enumerate().map(((i, e)) => {
            if i == it.depth - 1 {
                return e - 1
            }
            e
        }))
    }

    set heading(numbering: "1.1")
    show heading.where(depth: 1): it => {
        set text(size: 20pt)
        it
        v(6pt)
    }
    show heading.where(depth: 2): it => {
        set text(size: 16pt)
        it
        v(4pt)
    }

    show heading.where(depth: 1, label: NO_NUM_LABEL): it => {
        numbered_section_state.update(false)
        it
    }

    // Update heading-reliant element counters
    show heading.where(depth: 1): it => {
        numbered_section_state.update(true)
        for cntr in heading_counters {
            cntr.update(1)
        }
        counter(math.equation).update(0)
        it
    }


    // Tabe of contents
    show outline.entry: it => link(
        it.element.location(),
        if it.element.at("label", default: none) == NO_NUM_LABEL {
            it.indented("", it.inner())
        }
        else{
            it
        }
    )
    show outline.entry: set block(above: 0.7em)
    show outline.entry.where(level: 1): it => {
        set text(weight: "bold")
        set block(above: 1.8em)
        it
    }

    // Set align to normal for all referenceable box elements
    show selector.or(..box_counter_elements.keys().map(kind => figure.where(kind: kind))): set align(left)


    // References for proof boxes and equations
    show ref: it => {
        let el = it.element
        for (kind, clr) in box_counter_elements.pairs() {
            if el in query(figure.where(kind: kind)) {
                return {
                    set text(fill: clr)
                    link(el.location(), kind + " " + counter-heading-display(counter(kind), loc: el.location()))
                }
            }
        }
        it
    }


    numbered_section_state.update(false)
    doc
}


// Proof boxes
#let referenceable-box(title, kind, box-func, transparency: 90%, body) = figure(
    kind: kind,
    supplement: none,
    {
        let counter = counter(kind)
        let clr = box_counter_elements.at(kind)
        box-func(
            title: kind + " " + counter-heading-display(counter) + ". " + title,
            color: clr,
            fill: clr.transparentize(transparency),
            body
        )
        counter.step()
    }
)

#let side-box(color: black, fill: none, title: none, color-title: true, body) = block(
    stroke: ("left": 2pt + color),
    width: 100%,
    fill: fill,
    pad(left: 6pt, top: 1pt, bottom: 1pt, [
        #if title != none {
            set text(fill: color) if color-title
            text(weight: "bold", title)
            linebreak()
        }
        #body
    ])
)



// Theorem boxes
#let thm-box(title: none, color: black, stroke: black+1.5pt, fill: none, title-color: white, title-width: 100%, title-radius: 0pt, title-inset: (top: 5pt, bottom: 6pt, left: 6pt, right: 7pt), radius: 0pt, inset: 6pt, body) = box(
    stroke: stroke,
    radius: radius,
    fill: white,
    grid(
        rows: (auto, auto),
        columns: (1fr),
        fill: fill,
        block(
            fill: color,
            width: title-width,
            radius: (top-left: radius, bottom-right: title-radius),
            inset: title-inset,
            text(fill: title-color, weight: "bold", title)
        ),
        block(
            width: 100%,
            inset: inset,
            body
        )
    )
)

#let slanted-thm-box(title: none, color: black, stroke: black+1.5pt, fill: none, title-color: white, title-width: 100%, slant-size: 14pt, body) = box(
    stroke: stroke,
    grid(
        rows: (auto, auto),
        columns: (1fr),
        fill: fill,
        context [
            #let title-box = box(
                inset: (top: 5pt, bottom: 6pt, left: 6pt, right: 5pt),
                text(fill: title-color, weight: "bold", title)
            )
            #let size = measure(title-box)
            #polygon(
                fill: color,
                (0pt, 0pt),
                (size.width+slant-size, 0pt),
                (size.width, size.height),
                (0pt, size.height)
            )
            #place(top+left, title-box)
        ],
        block(
            width: 100%,
            inset: 6pt,
            body
        )
    )
)

// Note: slanted-thm-box is visually the same as this with curve-size set to 0pt
#let curved-thm-box(title: none, color: black, stroke: black+1.5pt, fill: none, title-color: white, title-width: 100%, slant-size: 19pt, curve-size: 10pt, from-top:5pt, from-title: -4pt, body) = box(
    stroke: stroke,
    grid(
        rows: (auto, auto),
        columns: (1fr),
        fill: fill,
        context [
            #let title-box = box(
                inset: (top: 5pt, bottom: 6pt, left: 6pt, right: 5pt),
                text(fill: title-color, weight: "bold", title)
            )
            #let size = measure(title-box)
            #curve(
                fill: color,
                curve.line((0pt, size.height)),
                curve.line((size.width + from-title, size.height)),
                curve.cubic((size.width+curve-size+from-title, size.height), (size.width+slant-size+from-title - curve-size, from-top), (size.width+slant-size+from-title, from-top)),
                curve.line((100%, from-top)),
                curve.line((100%, 0pt)),
                curve.close()
            )
            #place(top+left, title-box)
        ]
        
        ,
        block(
            width: 100%,
            inset: 6pt,
            body
        )
    )
)

#let outline-box(title: none, stroke: black+1.5pt, fill: none, title-color: black, radius: 6pt, inset: (left: 7pt, right: 7pt, top: 8.5pt, bottom: 8.5pt), body) = thm-box(
    title-inset:0pt,
    radius: radius,
    inset: inset,
    stroke: stroke
)[
    #if title != none {
        text(fill: title-color, weight: "bold", title)
        linebreak()
    }
    #body
]


// Simple box drop shadow
#let box-shadow(alpha: 10%, left: -5pt, right: 5pt, top: -5pt, bottom: 5pt, radius: 0pt, body) = context [
    #let clr = color.hsv(0deg, 0%, 0%, alpha)
    #box(
        width: 100%,
        fill: clr,
        outset: (left: left, right: right, top: top, bottom: bottom),
        radius: radius,
        stroke: gray,
        //stroke: gradient.radial(clr, white)+2pt,
        box(
            fill: white,
            body
        )
    )
]

// More general shadow
#let shadow(radius: 0pt, inset: 0pt, clip: false, shadow: 4pt, dx: 0pt, dy: 0pt, color: rgb(89, 85, 101, 35%), body) = box(
    inset: (left: -shadow),
    width: 100% + shadow,
    shadowed(
        radius: radius,
        inset: inset,
        dx: dx,
        dy: dy,
        shadow: shadow,
        color: color,
        body
    )
)

#let shadow-box(radius: 4pt, inset: 12pt, clip: false, shadow: 6pt, dx: 0pt, dy: 0pt, width: 100%, position: left, body) = box(
    inset: (left: -shadow),
    width: 100% + shadow,
    align(position, shadowed(
        radius: radius,
        inset: inset,
        dx: dx,
        dy: dy,
        shadow: shadow,
        box(
            width: width,
            body
        )
    ))
)



// Defined proof boxes //

//#show figure.where(kind: "definition"): set figure(numbering: "1.1")
#let definition(title, body) = referenceable-box(
    title,
    "Definition",
    (..it) => thm-box(..it,
        stroke: 1.5pt + box_counter_elements.at("Definition")
    ),
    body
)

#let corollary(title, body) = referenceable-box(
    title,
    "Corollary",
    (..it) => slanted-thm-box(..it,
        stroke: (top: 1.5pt + box_counter_elements.at("Corollary"))
    ),
    body
)

#let lemma(title, body) = referenceable-box(
    title,
    "Lemma",
    (..it) => curved-thm-box(..it, from-top: 2pt, stroke: 0pt),
    body
)

#let theorem(title, body) = referenceable-box(
    title,
    "Theorem",
    (..it) => shadow(radius: 3pt, inset: 0pt, dx: 3pt, dy: 3pt, shadow: 3pt,
        thm-box(
            ..it,
            title-width: auto,
            title-radius: 3pt,
            radius: 3pt,
            stroke: 1.5pt + box_counter_elements.at("Theorem"),
        )
    ),
    body
)

#let proposition(title, body) = referenceable-box(
    title,
    "Proposition",
    (..it) => shadow(radius: 3pt, inset: 0pt, dx: 3pt, dy: 3pt, shadow: 3pt,
        thm-box(
            ..it,
            title-width: auto,
            title-radius: 3pt,
            radius: 3pt,
            stroke: 1.5pt + box_counter_elements.at("Proposition"),
        )
    ),
    body
)


// Defined side-boxes //
#let proof(body, qed: $square$) = side-box(color: color.hsv(210deg, 95%, 60%), title: "Proof.")[
    #context [
        #let size = measure(qed)
        #box(
            width: 100%,
            inset: (right: size.width),
            body
        )
        #place(
            bottom+right,
            clearance: 0em,
            dx: 0em,
            dy: -0.2em,
            qed
        )
    ]
]

#let remark(body, qed: $square$) = side-box(color: color.hsv(120deg, 90%, 55%), title: "Remark.", body)

#let example(body) = referenceable-box(
    none,
    "Example",
    side-box,
    transparency: 100%,
    body
)
