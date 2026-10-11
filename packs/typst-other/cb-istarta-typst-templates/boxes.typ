#import "@preview/showybox:2.0.4": *

#let global_numbering_hack = state("global_numbering", true)

#let count-box(count, name, title, color, body, kind: "testkind", lable: "emptylabel") = context {
    let chapter_num = counter(heading).get().at(0)
    let count = counter(count)

    let box_num = count.get().at(0)
    count.step()
    let prenums = {
        if global_numbering_hack.get() { numbering("1", box_num) } else { numbering("1.1", chapter_num, box_num) }
    }
    let nums = prenums
    if title != none {
        nums = nums + ":"
    }
    [#figure(
            showybox(
                title-style: (
                    boxed-style: (
                        anchor: (
                            x: left,
                            y: horizon,
                        ),
                        radius: 5pt,
                    ),
                ),
                frame: (
                    title-color: color.darken(10%),
                    body-color: color.lighten(80%),
                    footer-color: color.lighten(60%),
                    border-color: color.darken(60%),
                    radius: 5pt,
                    thickness: 1.5pt,
                ),
                title: [#name #nums #title],
                body,
            ),
            kind: kind,
            supplement: [#kind #prenums],
        )#label(lable)]
}


#let def(title, body, lable: "emptylabel") = count-box(
    "def_counter",
    "Definition",
    title,
    blue,
    body,
    kind: "Definition",
    lable: lable,
)
#let nota(title, body) = count-box("def_counter", "Notation", title, blue, body)
#let exa(title, body) = count-box("def_counter", "Example", title, rgb("128434"), body)
#let rem(title, body) = count-box("def_counter", "Remark", title, rgb("8300af"), body)
#let thm(title, body, lable: "emptylabel") = count-box(
    "def_counter",
    "Theorem",
    title,
    rgb("ba0926"),
    body,
    kind: "Theorem",
    lable: lable,
)
#let lem(title, body, lable: "emptylabel") = count-box(
    "def_counter",
    "Lemma",
    title,
    rgb("a52b03"),
    body,
    kind: "Lemma",
    lable: lable,
)
#let prop(title, body, lable: "emptylabel") = count-box(
    "def_counter",
    "Proposition",
    title,
    rgb("c14d00"),
    body,
    kind: "Proposition",
    lable: lable,
)
#let cor(title, body) = count-box("def_counter", "Corollary", title, maroon, body)
#let claim(title, body) = count-box("def_counter", "Claim", title, eastern.darken(10%), body)
#let exe(title, body) = count-box("exe_counter", "Exercise", title, rgb("055b1f"), body)

#let proof(..args) = {
    if args.pos().len() == 1 {
        text("Proof: " + args.pos().at(0)) + align(right, sym.ballot)
    } else {
        text("Proof of " + args.pos().at(0) + ": " + args.pos().at(1) + align(right, sym.ballot) /*+ linebreak()*/)
    }
}

#let box-env(doc, global_numbering: true, alternating_layout: true) = [
    #global_numbering_hack.update(global_numbering)
    #set heading(numbering: "1.")

    #let def_counter = counter("def_counter")
    #def_counter.update(1)
    #show heading: head => {
        if head.level == 1 and not global_numbering {
            def_counter.update(1)
        }
        head
    }

    #let exe_counter = counter("exe_counter")
    #exe_counter.update(1)
    #show heading: head => {
        if head.level == 1 and not global_numbering {
            exe_counter.update(1)
        }
        head
    }
    #doc
]
