#import "template.typ": *

#show: resume.with(
  author: "John Snow",
  description: [Member of the Night's Watch, Bastard of Winterfell, King in the North],
  phone: "+00 1 23 45 67 89",
  location: "Westeros",
  email: "john.snow@nwatch.com",
  github: "https://github.com/johnsnow",
  linkedin: "https://www.linkedin.com/in/johnsnow/",
  image-path: "./images/icon.jpg", // Set image-path to empty to remove the image
  accent-color: "#26428b", // Accent color is optional; remove this line to make the resume in black and white
)

/*
* Lines that start with == are formatted into section headings
* You can use the specific formatting functions if needed
* The following formatting functions are listed below
* #edu(dates: "", degree: "", gpa: "", institution: "", location: "")
* #work(company: "", dates: "", location: "", title: "")
* #project(dates: "", name: "", role: "", url: "")
* #extracurriculars(activity: "", dates: "")
* There are also the following generic functions that don't apply any formatting
* #generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "")
* #generic-one-by-two(left: "", right: "")
*/

== Experience

#work(
  title: "Leader of the human armies to defeat the White Walkers",
  location: "Westeros",
  company: "The Northern armies",
  dates: dates-helper(start-date: "~12 000 years B.C.", end-date: "~12 000 years B.C."),
)
- Wields a sword made of Valyrian steel which can kill White Walkers
- Lived and fought beyon the Wall

// You can add more work items by uncommenting & filling the following lines
// #work(
//   title: ...,
//   location: ...,
//   company: ...,
//   dates: ...,
// )
// - ...
// - ...

== Education

#edu(
  institution: "The Night's Watch",
  location: "The Wall",
  dates: dates-helper(start-date: "~12 000 years B.C.", end-date: "~12 000 years B.C."),
  degree: "Watcher on the Wall",
)
- Manage to survive the Night's Watch training (barely)
- Defended the Wall against the Wildlings and the White Walkers

// You can add more education items by uncommenting & filling the following lines
// #edu(
//   institution: ...,
//   location: ...,
//   dates: ...,
//   degree: ...,
// )
// - ...
// - ...


== Skills

- *Physical*: sword wielding
// - *Other*: ...

== Hobbies

*Sports*\
- Tried dragon riding once
// - ...

