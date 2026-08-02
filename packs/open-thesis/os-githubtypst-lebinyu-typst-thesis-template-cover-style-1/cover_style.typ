#let cover(
    title:"", 
    supervisor: (), 
    group_name: "", 
    institute: "", 
    author: "", 
    ID: "", 
    address: (), 
    email: "", 
    closing_date: ""
) = {
    set document(title: title, author: author)
    set page(
        margin: (x: 3cm),
        numbering: none,
        number-align: center,
    )
  
  // --- Cover ---
    linebreak() * 4
    align(center)[
        #image(width: 9cm ,"figure/uzh_logo.png")
    ]
    linebreak() * 3
  
    align(center)[
        #block(text(weight: 100, 1.75em, "Master Thesis"))
    ] 
    align(center)[
        #block(text(weight: 900, 1.75em, title))
    ]  
    linebreak() * 3

    align(center)[
        #block(text(weight: 100, 1.3em, "Supervisors:"))
    ]

    align(center)[
        #supervisor.join(", ", last: " and ")
    ]
    linebreak() * 3

    align(center)[
        #block(text(weight: 400, 1.75em, group_name))
    ]  
    linebreak() * 3

    align(center)[
        #block(text(weight: 400, 1.75em, institute))
    ] 
    linebreak() * 3

    grid(
        columns: (1fr, 1fr),
        gutter: 5pt,
        row-gutter: 0.65em,//0.65em is default spacing betwen line
    
        align(right)[Author:],
        align(left)[#author],
    
        align(right)[Student ID:],
        align(left)[#ID],
    
        align(right)[Address],
        align(left)[
            #for adressline in address [
                #adressline \
            ]    
        ],
    
    align(right)[E-mail:],
    align(left)[#email],

    align(right)[Closing date:],
    align(left)[#closing_date],
    )
  
    pagebreak(weak:false)
    pagebreak(weak:false)
}