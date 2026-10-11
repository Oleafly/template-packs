// APA 7th Edition Student Paper Example
// Import the apa template
#import "../src/lib.typ": *

#show: apa.with(
  title: "The Effects of Social Media on Academic Performance Among College Students",
  running-head: "Social Media and Academic Performance",
  author: "Jane M. Smith",
  affiliation: "Department of Psychology, University of Example",
  course: "PSY 301: Research Methods in Psychology",
  instructor: "Dr. John A. Doe",
  due-date: "December 8, 2025",

  // Optional: Include an abstract
  abstract: [
    This paper examines the relationship between social media usage and academic performance among college students. A survey of 150 undergraduate students revealed a significant negative correlation between hours spent on social media platforms and grade point average. The findings suggest that excessive social media use may detract from study time and cognitive focus. Implications for academic interventions and digital literacy programs are discussed.
  ],

  // Optional: Include keywords
  keywords: ("social media", "academic performance", "college students", "digital distraction"),
)

// Body of the paper begins here
// Note: The title is automatically repeated at the start of the body

The proliferation of social media platforms has fundamentally transformed how college students communicate, access information, and spend their leisure time. With the average college student spending approximately three hours daily on social media #pcite("Smith & Jones", "2023"), questions have emerged regarding the impact of this digital engagement on academic outcomes. This paper explores the relationship between social media usage patterns and academic performance among undergraduate students.

#heading-1[Literature Review]

Previous research has established connections between technology use and academic achievement. #ncite("Johnson", "2022") found that students who limited their social media use during study sessions demonstrated improved retention of course material. Similarly, research by #ncite("Williams et al.", "2021") indicated that multitasking between social media and homework was associated with lower grades.

#heading-2[Theoretical Framework]

The cognitive load theory provides a useful framework for understanding why social media may interfere with academic performance. According to this theory, working memory has limited capacity, and dividing attention between multiple information sources can impede learning #pcite("Sweller", "2019").

#heading-3[Digital Distraction Hypothesis]

The digital distraction hypothesis suggests that notifications, alerts, and the anticipation of new content create a state of continuous partial attention #pcite("Roberts & Chen", "2020"). This fragmented attention pattern may be particularly detrimental during complex academic tasks that require sustained focus.

#heading-1[Method]

#heading-2[Participants]

The study included 150 undergraduate students (98 female, 52 male) recruited from introductory psychology courses at a large public university. Participants ranged in age from 18 to 24 years (M = 20.3, SD = 1.4).

#heading-2[Procedure]

Participants completed an online survey assessing their daily social media usage across platforms including Instagram, TikTok, Twitter, and Facebook. Academic performance was measured using self-reported cumulative grade point average (GPA), which was verified through university records with participant consent.

#heading-1[Results]

A Pearson correlation analysis revealed a significant negative relationship between daily social media usage and GPA, r(148) = -.34, p < .001. Students who reported more than four hours of daily social media use had significantly lower GPAs (M = 2.78, SD = 0.56) compared to those who reported less than two hours (M = 3.42, SD = 0.48).

As noted by one participant in the qualitative portion of the study:

#block-quote[
  I know I should be studying, but every time I sit down to work, I end up scrolling through Instagram for an hour without even realizing it. By the time I actually start my homework, it is already late and I am too tired to focus properly. #pcite-p("Participant 47", "2024", "interview transcript")
]

#heading-1[Discussion]

The findings of this study support the hypothesis that excessive social media use is negatively associated with academic performance among college students. These results align with previous research and suggest that interventions targeting digital habits may benefit student achievement.

#heading-2[Limitations]

Several limitations should be noted. First, the correlational design precludes causal conclusions. Second, self-reported social media usage may be subject to recall bias or social desirability effects.

#heading-2[Future Directions]

Future research should employ experimental designs to establish causality and investigate potential moderating variables such as self-regulation skills and academic motivation.

// References section
#references[
  Johnson, R. T. (2022). Digital minimalism and academic success: A longitudinal study. _Journal of Educational Psychology, 114_(3), 456-470. https://doi.org/10.1037/edu0000123

  Roberts, K. L., & Chen, M. (2020). Continuous partial attention in the digital age. _Computers in Human Behavior, 105_, Article 106215.

  Smith, A. B., & Jones, C. D. (2023). Social media usage patterns among college students. _Journal of American College Health, 71_(2), 234-241.

  Sweller, J. (2019). Cognitive load theory and educational technology. _Educational Technology Research and Development, 67_, 1-16.

  Williams, P. R., Thompson, S. K., & Garcia, L. M. (2021). Multitasking with social media: Effects on learning outcomes. _Learning and Instruction, 72_, Article 101456.
]
