#import "activity-report.typ": report, activities, results
#show: body => report(
  month: "octombrie 2023",
  your_name: "Smith John",
  your_position: "CS-III",
  sign_date: "03/11/2023",
  department_head: "Emily Anderson",
  scientific_director: "Olivia Taylor",
  body,
)

#activities
- #lorem(40)
- #lorem(5) `openPMD-resampler` #lorem(10) $E = m c^2$ #lorem(20) 
- #lorem(38) 

#results
- #lorem(20) $attach(tl: 115m, bl:49, "In")$ #lorem(16)
- #lorem(33)
- #lorem(27) $	B_(6 D) = I_P /
  (epsilon_(n x) epsilon_(n y) sigma_gamma dot 0.1 %) $
 