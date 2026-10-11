#import "/common.typ":*
#set align(center)
#set par(spacing: 1.5em)
// Ensures sections and images from the titlepage does not end up in the table of contents
#show heading: set heading(outlined: false) 
#show figure: set figure(outlined: false)

#figure(
  image(titlepage_img_path,width: 10cm)
)

#v(84pt)
#title(report_title)
#v(24pt)

// Group
== #report_group
#v(6pt)

===== #titlepage_consisting_of
#v(12pt)

// Authors of the report
= #report_authors
#v(24pt)

==== #titlepage_in 
#v(24pt)


==== #report_course_code
==== #report_course_name
#v(72pt)

// The department/institution
== #report_department
#v(12pt)
== #report_faculty
#v(12pt)
== #report_datetime

#pagebreak()
