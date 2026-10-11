#import "template.typ": signalsReport

#show: signalsReport.with(
  title: "A Test Report",
  labNum: 1,
  studentID: 1234567,
  FAN: "smit1234",
  firstName: "John",
  lastName: "Smith",
  teamMemberName: "Larry Jones",
  teamMemberFAN: "jone1234",
  workshopDemonstrator: "Dr Lee",
  dueDate: "01/01/1970",
  dateOfSubmission: "01/01/1970",
  isResubmit: false,
)

= Introduction
#lorem(100)

= Method
#lorem(300)

= Results
#lorem(200)

= Discussion
#lorem(500)

= Conclusion
#lorem(100)