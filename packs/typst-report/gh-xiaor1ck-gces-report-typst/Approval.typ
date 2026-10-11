
#let approval-certificate(
  title: none,
  students: (),
  supervisor: none,
  project-head: none,
  date: none
) = {
  let join-names(arr) = {
  let n = arr.len()
  if n == 0 { "" }
  else if n == 1 { strong(arr.at(0)) }
  else if n == 2 { strong(arr.at(0)) + " and " + strong(arr.at(1)) }
  else {
    let result = ""
    for i in range(0, n - 1) {
      result += strong(arr.at(i)) + ", "
    }
    result + "and " + strong(arr.at(n - 1))
  }
}
  [= APPROVAL CERTIFICATE]
  v(1em)
  align(left)[This project entitled "*#title*" prepared and submitted by #join-names(students)  under the
supervision of *#supervisor* in partial fulfillment of the requirements for the Degree of
Bachelor of Engineering in Software Engineering has been examined and is
recommended for approval and acceptance.]
v(5em)
align(left)[
  *Date Of Evaluation:* #date.display("[month repr:short] [day], [year]")
]
v(5em)
columns(2)[
  #align(left)[
        ................................. \
    *#project-head* \
    Project Head \
    *Research Management Committee*
      #colbreak()

    #if supervisor != none [
      ................................. \
    *#supervisor* \
    Project Supervisor
    ]
 
  ]
]

pagebreak()

}

