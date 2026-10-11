#let make_course_sched(classes, assignments, doc) = {
    let rows = classes.enumerate().map(pair => {
        
        let (i, info) = pair

        // find assignments due on this class's date
        let due = assignments.filter(a => a.date == info.date)

        let topic_content = eval(info.topic.replace("\n", "\\\n"), mode: "markup") + linebreak() + linebreak()

        let due_content = if due.len() > 0 {
            // due.map(a => [_#a.kind: #eval(a.id, mode: "markup")_]).join(linebreak())
            due.map(a => [#a.id]).join(linebreak())
        } else {
            " "
        }

        // let cell = if due.len() > 0 {
        //     let due_content = due.map(a => [_#a.kind: #eval(a.title, mode: "markup")_]).join(linebreak())
        //     topic_content + linebreak() + linebreak() + due_content
        // } else {
        //     topic_content
        // }

        (
            info.date.display("[weekday repr:short], [month repr:short] [day]"),
            topic_content,
            due_content
        )

    }).flatten()
    
    table(
        columns: (4fr, 16fr, 6fr),
        inset: 8pt,
        align: (left, left, left),
        stroke: 0.5pt,

        table.header(smallcaps[*Date*], smallcaps[*Topic*], smallcaps[*Due*]),

        ..rows
    )

  doc
}