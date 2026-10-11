#import "../src/CV.typ": *

// ------------------------
// CV
// ------------------------
#cv(sidebar_width: 5cm, language: "english")[

  == Languages
  #left_right(
    [*English*],
    [Advanced],
  )
  #left_right(
    [*Spanish*],
    [Intermediate],
  )
  #left_right(
    [*French*],
    [Beginner],
  )

  == Skills

  #skill(
    3,
    [Python],
  )
  #skill(
    1,
    [JavaScript],
  )

  #pretty_list()[
    Engineering:
    - SolidWorks
    - Catia
    - Excel
    - Ansys
    - Ansys APDL
  ]

  == Strengths
  *Lorem ipsum dolor*
  - sit amet, consectetur adipiscing elit
  - Fusce id porttitor lacus

  *Praesent sollicitudin nec*
  - Praesent consequat justo ligula, non sollicitudin turpis tincidunt quis.
  - Cras sapien velit, luctus ac mollis et

  /*
  *Movilidad*
  - Coche propio
  */
][
  == About me
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce id porttitor lacus, eu ultricies arcu. Praesent sollicitudin nec augue in suscipit. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean convallis cursus lorem, feugiat faucibus lectus congue quis.

  Ut ac ipsum eget quam maximus suscipit. Praesent ut elit tortor. Ut ac ipsum eget quam maximus suscipit. Praesent ut elit tortor.


  == Work experience
  #event(
    [*TechSolutions Ltd - Junior Mechanical Design Engineer*],
    [2024 - 2025],
    [
      - I designed mechanical components (Solid Edge) for small-scale industrial automation systems.
      - I performed structural and thermal simulations (ANSYS) to validate prototypes before manufacturing.
    ],
  )
  #event(
    [*DataForge Analytics - Python Automation Intern*],
    [2023 - 2024],
    [
      - I developed Python scripts to automate data cleaning and preprocessing workflows.
      - I built internal tools to generate performance reports for engineering teams.
      - I optimized existing algorithms, reducing computation time by approximately 30%.
    ],
  )
  #event(
    [*GreenMotion Robotics - Control Systems Assistant*],
    [2020 - 2023],
    [
      - I tested and tuned controllers using MATLAB/Simulink.
      - I participated in field testing and debugging of embedded systems.
    ],
  )

  == Distinctions

  #left_right(
    [*Winner* of the *Sustainable Urban Mobility hackathon*)],
    [2025],
  )

  #left_right(
    [*Gold Medal* in the *Regional Fluid Dynamics Olympiad*],
    [2025],
  )

  #left_right(
    [Honorary Mention for *Structural Analytical Excellence in Technical Drawing*],
    [2024],
  )

  #left_right(
    [*Third Prize at the International Physics Brawl*],
    [2022],
  )


  == Education

  #event(
    [Msc in *Applied Mechanics* in *University of Oxford*],
    [2024 - 2026],
    //location: [University of Oxford, United Kingdom],
    [
      - Advanced specialization in nonlinear finite element methods, continuum mechanics, and multiphysics modelling.
      - Development of a high-performance Finite Element Method solver (C++/Python)
    ],
  )

  #event(
    [*Mechanical Engineering* in Harvard University],
    [2020 - 2024],
    //location: [Harvard University, Cambridge, MA, United States],
    [
      - Strong foundation in advanced mathematics, physics, thermofluids, control systems, and solid mechanics.
      - Selected coursework at MIT cross-registration program in advanced robotics and computational mechanics.
    ],
  )

]


