#import "/src/lib.typ": *
#import util: cont, no-indent, cal

#show: assignment-class.with(
  title: [Report Title],
  author: "Author Name",
  course-name: "Course Name",
  mode: "report",
  lang: "en",
)

#show: util.use-three-line-table

= Introduction
This report provides an overview of the key concepts and findings related to the subject matter.

The purpose of this report is to summarize the main points and present them in a clear and concise manner.


= Methodology
The methodology section outlines the approaches and techniques used to gather and analyze data.
It includes descriptions of the tools and processes employed during the research phase.

== Data Collection
Data was collected through various means including surveys, interviews, and observation.

The data collection process was designed to ensure accuracy and reliability.

== Data Analysis
The collected data was analyzed using statistical methods and qualitative analysis techniques.

The analysis aimed to identify patterns and draw meaningful conclusions from the data.

=== Statistical Methods
Various statistical tools were employed to analyze quantitative data, including regression analysis and hypothesis testing.

=== Qualitative Analysis
Qualitative data was examined through thematic analysis and content analysis to extract significant themes and insights.

=== Collection and Analysis Methods
The following tools were utilized during the data analysis phase:
- Python with libraries such as Pandas and NumPy
- R for statistical computing
- NVivo for qualitative data analysis

The data collection process was divided into several stages to ensure systematic and organized efforts. These stages included:
+ *Planning Stage*: Defining research objectives and designing data collection methods.
+ *Implementation Stage*: Conducting the actual data collection activities.
+ *Review Stage*: Examining and validating the collected data to ensure its integrity.
#cont Each of the above stages was carefully planned to ensure the quality and relevance of the data.

The data collection process aimed to meet several objectives, including:
/ Accuracy: Ensuring that the collected data accurately reflects the subject of study.
/ Reliability: Ensuring consistency of the data through standardized data collection methods.
/ Validity: Ensuring that the data supports the verification of research hypotheses and the drawing of conclusions.
#cont This was achieved through rigorous design and execution of the data collection plan.

Various methods were employed during the data collection and analysis process, including both quantitative and qualitative techniques. Quantitative methods involved statistical analysis and mathematical modeling, while qualitative methods focused on content analysis and thematic identification. Below is a simple example of a mathematical model:
$
  Y = beta_0 + beta_1 X_1 + beta_2 X_2 + ... + beta_n X_n + epsilon, quad beta_i in RR, thick epsilon ~ N(0, sigma^2).
$
#no-indent This model is used to describe the relationship between the dependent variable $Y$ and multiple independent variables $X_i$, where $beta_i$ represents the regression coefficients and $epsilon$ denotes the error term.

== Ethical Considerations
Ethical considerations were taken into account throughout the research process to ensure the integrity and confidentiality of the data.

Participants were informed about the purpose of the study and their consent was obtained prior to data collection.

== Limitations
The study faced certain limitations, including a limited sample size and potential biases in data collection.

These limitations are acknowledged and discussed in the context of the findings.


= Results
The results section presents the findings of the research in a structured format.

It includes tables, charts, and graphs to illustrate the data collected, as shown in @fig:example-figure and @tab:example-table.

The analysis revealed several key insights that are discussed in detail below.

#figure(
  caption: [A sample figure.],
  rect(width: 240pt, height: 180pt)[
    #set align(center + horizon)
    XXX
  ],
) <fig:example-figure>

#figure(
  caption: [A sample table.],
  table(
    columns: 5,
    table.header[Task ID][Task Name][Responsible Person][Due Date][Current Progress],
    [TASK-001], [Database Schema Design], [Alice], [2023-10-15], [100%],
    [TASK-002], [Backend API Development], [Bob], [2023-10-20], [85%],
    [TASK-003], [Frontend Interface Setup], [Charlie], [2023-10-25], [45%],
    [TASK-004], [System Integration Testing], [David], [2023-11-01], [0%],
  ),
) <tab:example-table>

#pagebreak()

= Discussion

The discussion section interprets the results and explores their implications.

#lorem(200)

Mathematical script letters:
#let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
- $#math.cal(alphabet)$
- $cal(alphabet)$
- $scr(alphabet)$
