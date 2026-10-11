#let exam(
    exam_title: "Sample Exam",
    subtitle: none,
    nrows: 3,
    ncols: 3,
    points_per_multiple_choice: 1,
    points_per_short_response: 1,
    points_per_long_response: 5,
    multiple_choice: (),
    short_response: (),
    long_response: (),
    doc,
) = {

set page(
    paper: "us-letter",
    header: align(
        right + horizon,
        exam_title,
    ),
)

set document(title: exam_title)

title()

if { subtitle != none } { subtitle }

if sys.inputs.at("type", default: "questions") == "questions" {
    let total_nquestions        = multiple_choice.len() + short_response.len() + long_response.len()
    let multiple_choice_points  = multiple_choice.len() * points_per_multiple_choice
    let short_response_points   = short_response.len()  * points_per_short_response
    let long_response_points    = long_response.len()   * points_per_long_response
    let total_points            = multiple_choice_points + short_response_points + long_response_points

    table(
        columns: (1fr, 1fr, 1fr, 1fr),
        align: center,
        fill: (_, y) => { if calc.odd(y) { luma(200) } else { white } },
        stroke: (_, y) => {
            if y == 0 {
                (top: 2pt + black, bottom: 1pt + black)
            } else if y == 4 {
                (bottom: 2pt + black) } else { none }
        },
        table.header( [*Category*],       [*Points per question*],        [*Quantity*],                   [*Total points*]),
                      [Multiple choice],  [#points_per_multiple_choice],  [#multiple_choice.len()],       [#multiple_choice_points],
                      [Short response],   [#points_per_short_response],   [#short_response.len()],        [#short_response_points],
                      [Long response],    [#points_per_long_response],    [#long_response.len()],         [#long_response_points],
                      [*Total*],          [],                             [*#total_nquestions*],            [*#total_points*]
     )
} else if sys.inputs.at("type", default: "questions") == "answer_sheet" {
    table(
        columns: (auto, 1fr),
        align: left,
        stroke: (x, y) => { if x == 1 { (bottom: 1pt + black) } },
        inset: (left: 0pt),
        row-gutter: 10pt,
        [Name], [],
        [Date], [],
    )
}

if multiple_choice.len() > 0 [ = Multiple choice ]

if sys.inputs.at("type", default: "questions") == "questions" {
    for q in multiple_choice {
        parbreak()
        enum.item(box[
            #q.at("body")
            #set enum(numbering: "A.")
            #if q.at("a", default: none) != none [ + #q.at("a") ]
            #if q.at("b", default: none) != none [ + #q.at("b") ]
            #if q.at("c", default: none) != none [ + #q.at("c") ]
            #if q.at("d", default: none) != none [ + #q.at("d") ]
        ])
    }
} else if multiple_choice.len() > 0 and ("solutions", "answer_sheet").contains(sys.inputs.at("type", default: "questions")) {
    let extras = ()
    let matrix = ()

    assert(
        nrows * ncols >= multiple_choice.len(),
        message: "Answer matrix dimensions too small; increase nrows and ncols."
    )

    /* Number each question */
    if sys.inputs.at("type", default: "questions") == "answer_sheet" {
        multiple_choice = multiple_choice.enumerate(start: 1).map(((i, q)) => [
            #i
            #if i < 10 { h(5pt) }
            #if q.at("a", default: none) != none [ #h(5pt) A ]
            #if q.at("b", default: none) != none [ #h(5pt) B ]
            #if q.at("c", default: none) != none [ #h(5pt) C ]
            #if q.at("d", default: none) != none [ #h(5pt) D ]
        ])
    } else if sys.inputs.at("type", default: "questions") == "solutions" {
        multiple_choice = multiple_choice.enumerate(start: 1).map(((i, q)) => [
            #i #h(30pt) #strong[#q.at("solution")]
        ])
    }

    /* Initialize the answer matrix rows */
    for i in range(nrows) { matrix.push(()) }

    /* Fill the answer matrix with answers */
    let r = 0
    for q in multiple_choice {
        matrix.at(r).push(q)
        r += 1
        if r >= matrix.len() { r = 0 }
    }

    /* Pad remaining cells with empty content */
    for i in range(multiple_choice.len(), nrows * ncols) {
        matrix.at(r).push([])
        r += 1
        if r >= matrix.len() { r = 0 }
    }

    [Circle your response in the grid below.]

    /* Display answer matrix */
    table(
        columns: range(ncols).map( _ => 1fr),
        align: left,
        inset: (top: 10pt, bottom: 10pt),
        fill: (_, y) => { if calc.odd(y) { luma(200) } else { white } },
        ..(matrix.flatten()),
    )
}

if short_response.len() > 0 [ = Short response ]

set enum(start: multiple_choice.len() + 1)

if sys.inputs.at("type", default: "questions") == "questions" {
    for q in short_response {
        parbreak()
        enum.item(box(q.at("body")))
    }
} else if sys.inputs.at("type", default: "questions") == "solutions" {
    for q in short_response {
        parbreak()
        enum.item(rect(width: 100%, height: auto, q.at("solution")))
    }
} else if sys.inputs.at("type", default: "questions") == "answer_sheet" {
    for q in short_response {
        parbreak()
        enum.item(rect(width: 100%, height: 65pt)[])
    }
}

if long_response.len() > 0 [ = Long response ]

set enum(start: multiple_choice.len() + short_response.len() + 1)

if sys.inputs.at("type", default: "questions") == "questions" {
    for q in long_response {
        parbreak()
        enum.item(box(q.at("body")))
    }
} else if sys.inputs.at("type", default: "questions") == "solutions" {
    for q in long_response {
        parbreak()
        enum.item(rect(width: 100%, height: auto, q.at("solution")))
    }
} else if sys.inputs.at("type", default: "questions") == "answer_sheet" {
    for q in long_response {
        parbreak()
        enum.item(rect(width: 100%, height: 95%)[])
    }
}

doc

}
