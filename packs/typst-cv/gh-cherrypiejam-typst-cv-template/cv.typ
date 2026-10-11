#import "cv-template.typ": conf

#show: conf.with(
  name: "Peter Parker",
  contact: (
    address: "20 Ingram Street, Forest Hills, Queens, New York City, 11375",
    e-mail: "peter.parker at esu dot edu",
  ),
  // research-interests: "",
  education: (
    // first
    (
      institute: "Empire State University",
      location: "New York City, NY",
      degrees: (
        (
          "B.S. in Physics",
          (
            datetime(year: 2023, month: 9, day: 1),
            datetime.today(),
          ),
          (),
        ),
      ),
    ),
    // second
    (
      institute: "Midtown Science High School",
      location: "New York City, NY",
      degrees: (
        (
          "High School Diploma",
          (
            datetime(year: 2023, month: 5, day: 1),
          ),
          (
            "GPA: 4.0/4.0",
            "Graduated with Honors",
          ),
        ),
      ),
    ),
  ),
  awards: (
    (
      "First Place in the New York City Math League (NYCML)",
      datetime(year: 2022, month: 10, day: 1),
    ),
    (
      "Norman Osborn Scholarship",
      datetime(year: 2022, month: 2, day: 1),
    ),
    (
      "Best Student Photographer Award",
      datetime(year: 2021, month: 2, day: 1),
    ),
  ),
)

=== Work Experience

*Empire State University* \
- Research Intern #box(width: 1fr, repeat[.]) Jan. 2023 - Mar. 2023
  - Worked under Dr. Curtis Connors' supervision on
    gene splicing and recombinant DNA to replicate stem cell regeneration in
    human tissue.
  - Conducted multiple successful trials on mice by fully re-growing lost limbs using
    advanced biochemical techniques such as polymerase chain reaction (PCR),
    gel electrophoresis, and CRISPR-Cas9 gene editing.
  - Collected and analyzed complex genetic data, utilizing bioinformatics
    tools to identify patterns and results. Maintained meticulous records of
    experimental procedures, results, and observations
    in lab notebooks and electronic databases for accuracy and reproducibility
    of research.
*Osborn Corporation* \
- Biochemical Research Intern #box(width: 1fr, repeat[.]) May. 2022 - Aug. 2022
  - Documented the genetic and behavioral found in the irradiated spiders.
*Joe's Pizza* \
- Pizza Delivery Service #box(width: 1fr, repeat[.]) Jan. 2021 - Sep. 2021
  - Delivered pizzas safely and courteously to customers throughout New York City,
    ensuring a high level of customer satisfaction.
  - Quickly resolved issues such as incorrect orders or late deliveries.

=== Teaching Experience

  - From Classical to Quantum Mechanics, ESU, PSY 207 #box(width: 1fr, repeat[.]) Spring'24
  - AP Chemistry, Midtown Science High School #box(width: 1fr, repeat[.]) Spring'24
  - AP Physics 1, Midtown Science High School #box(width: 1fr, repeat[.]) Fall'23

=== Publications

*Peter Parker* and Curtis Connors. A Novel Decay Rate Algorithm for Enhanced Material
Decomposition in Bio-Organic Systems. _Journal of Advanced Biochemical Engineering_,
22(4), 547-580. February 2023.

=== Skills

- Data analysis and web design (Python, R, JavaScript, HTML, Elixir)
- RNA extraction (PCR)
- Photography (Photoshop)