#import "lib.typ": iitkgp-thesis

#show: iitkgp-thesis.with(
  title: "Performance improvement and Optimization of Type-4 Hydrogen Pressure Vessels using Metaheuristic Technique",
  author: "Rajeev Kumar Verma",
  rollno: "21CH30058",
  supervisor: "Swati Neogi",
  department: "Chemical Engineering",
  degree: "Dual Degree (B.Tech. + M.Tech.)",
  institution: "Indian Institute of Technology Kharagpur",
  location: "Kharagpur",
  pincode: "721302",

  certificate-text: [
    This is to certify that the thesis report entitled *Performance Improvement and Optimization of Type-4 Hydrogen Pressure Vessels Using Metaheuristic Technique*,
    submitted by *Rajeev Kumar Verma* (Roll Number: _21CH30058_),
    a postgraduate student of *Chemical Engineering*, Indian Institute of Technology Kharagpur,
    towards partial fulfilment of the requirements for the award of the Dual Degree (B.Tech. + M.Tech.),
    is a record of bona fide work carried out by him under my supervision and guidance during the Autumn Semester, 2025–26.
  ],

  declaration-text: [
    (a) The work contained in this report has been done by me under the guidance of my supervisor.

    (b) The work has not been submitted to any other Institute for any degree or diploma.

    (c) I have conformed to the norms and guidelines given in the Ethical Code of Conduct of the Institute.

    (d) Wherever I have used materials (data, theoretical analysis, figures, and text) from other sources, I have given due credit to them by citing them in the text of the thesis and giving their details in the references. Further, I have taken permission from the copyright owners of the sources, wherever necessary.
  ],


  // Front matter
  abstract: [
    This thesis presents a comprehensive computational framework for the design and optimization of Type-4 composite pressure vessels.
  ],
  acknowledgment: [
    I would like to express my sincere gratitude to my supervisor.
  ],

  // Options
  figures-outline: true,
  tables-outline: true,

  abbreviations: (
    ("AI", "Artificial Intelligence"),
    ("ML", "Machine Learning"),
    ("CLT", "Classical Lamination Theory"),
    ("GA", "Genetic Algorithm"),
    ("PSO", "Particle Swarm Optimization"),
    ("SA", "Simulated Annealing"),
    ("GWO", "Grey Wolf Optimizer"),
    ("MFO", "Moth-Flame Optimization"),
    ("ACO", "Ant Colony Optimization"),
    ("ABC", "Artificial Bee Colony"),
    ("GUI", "Graphical User Interface"),
    ("ASTM", "American Society for Testing and Materials"),
    ("NOL", "Naval Ordnance Laboratory"),
    ("FVF", "Fiber Volume Fraction"),
  ),
)

// Chapters
#include "Chapters/chapter1.typ"
#include "Chapters/chapter2.typ"
// #include "Chapters/chapter3.typ"
// #include "Chapters/chapter4.typ"
// #include "Chapters/chapter5.typ"

// Bibliography
#heading(level: 1, numbering: none)[Bibliography]
#bibliography("citations.bib", style: "ieee", title: none)
