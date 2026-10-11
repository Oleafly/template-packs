#let signalsReport(
  title: none,
  labNum: 1,
  studentID: none,
  FAN: none,
  firstName: none,
  lastName: none,
  teamMemberName: none,
  teamMemberFAN: none,
  topicCode: "ENGR2722",
  topicName: "Signals & Systems",
  workshopDemonstrator: "",
  workshopNumber: none,
  dueDate: none,
  dateOfSubmission: none,
  isResubmit: false,
  doc
) = {
  set text(size: 10pt)
  align(center)[#image("imgs/flin_logo.png", width: 40%)#text(fill: rgb(0,0,255), size: 14pt)[College of Science and Engineering]]
  linebreak()
  linebreak()
  linebreak()
  [
    == Lab Report Cover Sheet - Online Submission
    Complete this cover sheet and copy and paste the whole page at the beginning of your report.
  ]

  table(
    [Student ID],[#studentID],
    [FAN],[#FAN],
    [First Name],[#firstName],
    [Family Name],[#lastName],
    [Team member name],[#teamMemberName],
    [Team member FAN],[#teamMemberFAN],
    [Topic code],[#topicCode],
    [Topic Name],[#topicName],
    [Workshop Demonstrator],[#workshopDemonstrator],
    [Workshop number and title],[#labNum - #title],
    [Due date],[#dueDate],
    [Date of submission],[#dateOfSubmission],
    [Is this a resubmission],[#{
      if isResubmit [
        Yes #h(0.5em) #sym.ballot.cross #h(2em) No #h(0.5em) #sym.ballot
      ] else [
        Yes #h(0.5em) #sym.ballot #h(2em) No #h(0.5em) #sym.ballot.cross
      ]
    }],
    columns: (1fr, 2fr),
    stroke: 0.5pt,
  )

  pagebreak()

  image("imgs/flin_logo.png", width: 70%)
  linebreak()
  linebreak()
  linebreak()
  linebreak()
  linebreak()
  linebreak()
  linebreak()
  text(size: 14pt)[
    *Student Name: * #firstName #lastName \ \
    *Student No.:* #studentID
  ]
  linebreak()
  linebreak()
  linebreak()
  align(center)[
    #text(size: 14pt)[
      *Lab #labNum* \ \
      *#title*
    ]
  ]

  pagebreak()

  counter(page).update(1)

  set page(
    margin: (left: 1cm, right: 1cm, top: 1.5cm, bottom: 1.5cm),
    footer: context [
      #line(length:100%) 
      #topicName Logbook 
      #h(1fr) 
      #counter(page).display("1 of 1", both: true)
    ]
  )

  doc
}