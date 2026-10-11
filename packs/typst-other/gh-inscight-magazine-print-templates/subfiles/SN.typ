#import "/template-files/inscight-template.typ": *

#let title = "In Conversation with ISRO Scientist Shyama Narendranath"
#let file = "/dataFiles/interviewMB.txt"
#let group1 = ("SS:", "SH:")
#let group2 = "SN:"
#let authors = ("Swarnendu Saha", "Suman Halder")
#let affiliations = ("IISER Kolkata", "DPS, IISER Kolkata")
#let abstract = "\"Often, our work is viewed as something exotic, while in reality, science is fundamental to our daily lives\", *Shyama Narendranath* remarks on the perception of research in India. She is a scientist at U R Rao Satellite Centre, ISRO. She is a part of Chandrayaan-2 and other Indian planetary programs. She has been awarded the Zubin Kembhavi award by the Astronomical Society of India."
#let intervieweeInfo = "*Prof. Barma* is an Indian scientist specializing in statistical physics. He was former director of the Tata Institute of Fundamental Research[1] from 2007 to 2014 and currently Professor Emeritus at Tata Institute of Fundamental Research, Hyderabad DAE - Homi Bhabha Chair Professor. He is the recepient of several awards including the Shanti Swarup Bhatnagar Prize for the Physical Sciences awarded by the CSIR (1995) and Padma Shri Award (2013)."
#let coverImage = "/covers/SN.svg"
#let intervieweeImage = "/authFaces/SN.jpeg"
#let received = (day: 8, month: 11, year: 2024)

#show: interview.with(
  issueDetails: yaml("/dataFiles/issueData.yml"),
  file: file,
  group1: group1,
  group2: group2,
  title: title,
  interviewees: "Shyama Narendranath",
  interviewers: authors,
  interviewerAffiliations: affiliations,
  abstract: abstract,
  coverImage: coverImage,
  received: received,
  intervieweeInfo: intervieweeInfo,
  intervieweeImage: intervieweeImage,
  outlinePrefix: [*From Issue #1: *]
)

SS: Good afternoon, ma'am. So, to start off, can you tell us about your background? Starting from when you were a student, how did you eventually reach the place you're in now after all these years?

SN: I can't say that I started out thinking I wanted to be a scientist. I come from Palakkad, a small town in Kerala. Back then, things were very different. The mobile phone, for instance, came into my life during my MSc. So, your generation can't even imagine a time without the internet or such technology. Exposure to the outside world was quite low.

Academically, I was a good student, but I was really interested in dance. I trained in classical dance, and most of my school days were focused on dancing. In Kerala, school youth festivals are taken very seriously, and every school participates. So, I was always involved in that.

SS: Oh, have you been trained in Kathakali, or was it another form of classical dance?
#img(path: "/images/iisc.jpeg", position: bottom, portrait: true, caption: "SN completed her PhD from the Indian Institute of Science, Bangalore.")

#img(path: "/images/dance.jpg", position: bottom, portrait: false, caption: "SN performing the Indu Sairisiri at Udupi krishna temple in Karnataka.")

SN: Actually, I started with Bharatanatyam, and have been training in Odissi for the past 15 years. I’m still passionate about dance, and I continue to perform. So, initially, I wanted to be a dancer. I even had a short story published when I was in the 6th grade. At that time, I thought maybe I’d become a writer. But becoming a scientist was never something I considered when I was young. Probably, my interest in science began during my post-graduation. I had excellent teachers who really made the subject interesting. For young children, it’s so important to have good teachers. If you love the subject, it’s often because you had an amazing teacher.

I always had good English teachers, so I loved English, even though I was pursuing a degree in Physics. In fact, during my undergraduate years, I looked forward to my English classes more than my Physics ones. But things changed during my MSc when I had some excellent professors in Physics. They made me understand what I was doing. That’s when I had a turning point.

SH: So, did you realize that you wanted to pursue research during your MSc?

SN: Yes, it was during a small summer project that I first thought research might be an option. I had the opportunity to visit Bangalore and stay there alone for the first time. I met many PhD scholars, and that's when I realized research could be something I'd like to pursue. Before that, I never considered it seriously. 

SH: And did you think about teaching as a career?

SN: Yes, like many girls of my time, the plan was to finish MSc, do a B.Ed., and then teach. That’s the path I was following. Teaching was seen as a suitable career for women. In my MSc Physics class, there were actually more girls than boys. But when I did my short summer project, I realized there was more I could do, and I became really interested in research.

SS: But at that time, societal expectations must have been a challenge, especially for women pursuing PhDs.

SN: Absolutely. There was definitely pressure. I got married soon after my MSc and moved to Bangalore. Fortunately, I continued my studies. I taught as a guest lecturer at a college for six months, even though I didn’t have a B.Ed. at the time. Then, I joined as a Junior Research Fellow (JRF). But within a few months, I was pregnant, so I had to take a break. After my daughter was born, I resumed when she was three and half months old.

SS: Wow, that must have been quite a challenge - balancing motherhood and studies.

SN: Yes, it was. I did my coursework for the PhD while working as a JRF in the Astronomy Program at the Indian Institute of Science (IISc), and I was able to complete it with the support of my family, especially my mother. I also had an excellent PhD supervisor, which is very important for a successful PhD journey.

SH: You mentioned working with international space agencies. Can you tell us about that?

SN: Yes, I was fortunate to be part of India’s first lunar mission, Chandrayaan-1. I worked on an instrument that was developed in collaboration with the European Space Agency. It was built at the Rutherford Appleton Laboratory in the UK, so I got the opportunity to go and work. It was a difficult period because I had to leave my daughter behind, but with the support of my family, I managed. It was a new experience, and it gave me significant exposure. Working on Chandrayaan-1 was a turning point in my career. That project really helped shape my future work in space missions. 

#img(path: "/images/SN3.jpg", position: top, portrait: true, caption: "PSLV C11 carrying Chandrayaan-1. SN was involved in developing the Chandrayaan-1 X-ray spectrometer, in collaboration with the Rutherford Appleton Laboratory in the UK.")
SH: You’ve spent a lot of time as a student and as a scientist at major space agencies like NASA, the European Space Agency, and JAXA. How do their approaches compare to ours? Especially with the perception that ISRO achieves a lot with significantly less funding. 

SN: There’s no debate—NASA is far ahead in terms of technology. They landed the first humans on the moon in 1969, and we haven’t sent humans to space yet. Their technological advancement is evident. However, in India, we are conditioned to work with limited resources. It’s not just in space research—across sectors, there’s always a resource crunch. Our approach is more about optimizing what we have. In many cases, we spend more time on things and make up for the lack of resources with extra effort. In NASA, industries take on parts of the technology development. Here, we still rely heavily on academic institutions and agencies like ISRO to develop technology in-house. But India is in a phase of transition. Over the next 10-20 years, I believe we’ll see more involvement of private industries in space missions.

SS: There’s a lot of pride in India about the Mars mission, Mangalyaan. It was achieved on a limited budget, but how does it compare to missions from NASA?

#img(path: "/images/SN4.jpg", position: bottom, portrait: true, caption: "Aerial view of Rutherford Appleton Laboratory, where SN worked towards Chandrayaan-1.")
SN: Yes, Mangalyaan was a great achievement in terms of engineering. However, from a scientific perspective, it’s not on the same scale as NASA’s Maven mission to Mars. The amount of science that came out of Maven is much greater. The Indian mission was more about demonstrating that we could navigate a spacecraft to Mars and make it work within our constraints.

SH: Could you talk a bit about Chandrayaan-3 and how that mission was planned?

SN: I think Chandrayaan-3 was very critical for ISRO and India’s planetary program. After Chandrayaan-2’s near-success, we needed Chandrayaan-3 to work to ensure the continuation of our planetary missions. The success of Chandrayaan-3 proved that we could achieve a soft landing on the moon, and now we are well-positioned to plan future lunar missions.

SH: When it comes to research funding in India, especially in space research, how do you feel about the current budget allocations?

SN: Without adequate funding, research progress is slow. In order to innovate, we need new funding. There is a push from the government to involve academic institutions more, which is a positive development. We need to focus on core research, while industries can undertake more of the technology development. This transition will take time, but it’s necessary for the future.

SS: What about the Chandrayaan-3 mission’s scientific studies? What have we learned from it?

SN: The mission included several instruments, bothon the lander and the rover. The rover  analyzed the composition of the surface, and it seemed to be a fairly  homogeneous area.  The lander carried a Langmuir probe  to measure the electron density in the moon’s exosphere, and a seismometer to measure moonquakes, though the data we collected over 10.5 days did not record any significant seismic activity. The mission was a great success overall, contributing valuable data for future lunar exploration.

SS: And the Aditya L1 mission? How is that going?

SN: Aditya L1 launched in September, and it's doing well so far. The spacecraft is in a halo orbit around the Lagrange point L1. The payloads are still being calibrated, but the mission is on track, and we expect some significant scientific findings from it soon.

SS: When you look back at your journey, from a student to a scientist, and the progress of ISRO, how do you feel about the way society views scientists in India?

SN: I think there is still a gap, but missions like the Chandrayaan and Mangalyaan are making people more aware of ISRO and the work we do. That being said, I believe there’s still a need for better science communication. People should know the time and effort it takes to make scientific progress. Often, our work is viewed as something exotic, while in reality, science—especially physics—is fundamental to our daily lives.

SH: Do you think the current system supports students interested in pursuing research careers?

SN: There are challenges. Many bright students are discouraged from pursuing research because of financial insecurity. The stipends are often not enough, and delays in funding can make life difficult for students. I’ve seen students struggle just to pay rent while pursuing their passion for research. This situation can dissuade many from continuing in science, and it’s something that needs attention.

SH: Do you think the research ecosystem in India needs improvement, especially in terms of job opportunities?

SN: Yes, definitely. Many of our postdocs don’t return to India because there aren’t enough job opportunities here. We need to create more positions and ensure that talented researchers have a place to contribute. Other countries, like China, have programs where they send postdocs abroad with the requirement that they return and work for their space agencies. We could benefit from similarinitiatives in India.

#img(path: "/images/SARA.jpg", position: top, portrait: false, caption: "European Lunar X-Ray Camera, employed on Chandrayaan 1. SN was the Instrument Operations Scientist at ISRO at that time.")
#colbreak()
SS: As we conclude, do you have any final thoughts or advice for the next generation of scientists?

SN: I would encourage students to be patient and persistent. Success in science doesn’t come quickly. It requires time, effort, and the willingness to face failures   along the way. But the satisfaction of contributing to knowledge and discovery is worth it. Focus on the long-term impact of your work, not just the number of papers you publish. At the end of the day, it’s about making a meaningful contribution to the field.
