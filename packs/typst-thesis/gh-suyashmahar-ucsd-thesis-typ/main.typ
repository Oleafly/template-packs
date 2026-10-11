#import "ucsd_thesis.typ": ucsd_thesis

#show: ucsd_thesis.with(
  subject: "Computer Science",
  author: "Potato Salad",
  title: "My Little Thesis",
  degree: "Doctor of Philosophy",
  committee: (
    (title: "Professor", name: "Alan Turing", chair: true),
    (title: "Professor", name: "Ada Lovelace", chair: false),
    (title: "Professor", name: "John von Neumann", chair: false),
    (title: "Professor", name: "Charles Babbage", chair: false),
  ),
  
  abstract: lorem(250),
  acknowledgement: "Add any acknowledgements here.",
  
  enable_list_of_figures: false,
  enable_list_of_tables: false,

  introduction: "This is the introduction.",
)

= My Chapter
#lorem(250)

= Conclusion
Conslusion goes here.