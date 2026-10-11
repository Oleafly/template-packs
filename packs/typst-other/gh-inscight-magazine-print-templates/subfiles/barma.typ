#import "/template-files/inscight-template.typ": *

#let title = "In Conversation with Prof. Mustansir Barma"
#let file = "/dataFiles/interviewMB.txt"
#let group1 = ("SS:",)
#let group2 = "MB:"
#let authors = ("Swarnendu Saha",)
#let affiliations = ("IISER Kolkata",)
#let abstract = "*What sparks a lifelong passion for physics—and what does it take to lead one of India’s premier scientific institutions?* In this rich and wide-ranging conversation, Prof. Mustansir Barma opens up about his journey from a curious schoolboy writing letters to textbook authors to becoming a celebrated physicist and the founding director of TIFR Hyderabad. He reflects on the essence of randomness, the beauty of phase transitions, the art of asking questions, and the quiet power of effective leadership."
#let intervieweeInfo = "*Prof. Barma* is an Indian scientist specializing in statistical physics. He was former director of the Tata Institute of Fundamental Research[1] from 2007 to 2014 and currently Professor Emeritus at Tata Institute of Fundamental Research, Hyderabad DAE - Homi Bhabha Chair Professor. He is the recepient of several awards including the Shanti Swarup Bhatnagar Prize for the Physical Sciences awarded by the CSIR (1995) and Padma Shri Award (2013)."
#let coverImage = "/covers/MB.svg"
#let intervieweeImage = "/authFaces/MBFace.jpg"
#let received = (day: 8, month: 11, year: 2024)

#show: interview.with(
  issueDetails: yaml("/dataFiles/issueData.yml"),
  file: file,
  group1: group1,
  group2: group2,
  title: title,
  interviewees: "Mustansir Barma",
  interviewers: authors,
  interviewerAffiliations: affiliations,
  abstract: abstract,
  coverImage: coverImage,
  received: received,
  intervieweeInfo: intervieweeInfo,
  intervieweeImage: intervieweeImage,
  outlinePrefix: [*From Issue #3: *]
)

SS: Good morning sir. I am Swarnandu Saha from InScight. First things first, are you from Bombay?

MB:  Yeah, I was born in Bombay. For the last 9 years or so, I have been at TIFR Hyderabad.

SS:  You studied at St. Xavier's College, Mumbai, if I am not wrong, after which you went to the United States.

MB:  Yeah, I went to the State University of New York at Stony Brook. 

SS: I would like to know how you reached the position you are today, in the academic sphere. Were you inspired by your family, or was it more of an accident?

MB:  Yeah, so it's like this. I had an interest in physics. I want to tell you about my school days because I will tell you about an incident from my school days.

#img(path: "/images/MB1Small.png", caption: "Mustansir Barma accepting the INSA (Indian National Science Academy) medal for Young Scientists in 1980. [Source TIFR H]", position: bottom)

What happened is that we had a textbook on light and there was a statement there that if you have two parallel mirrors and a candle in between, you will get an infinite number of images. Now, I sort of found that not quite right in that light has a finite speed of propagation. So, if we put the candle there, there would be reflection from one mirror to the other and soon.

So, the number of images will keep increasing in time but in a very short time, there will be no image because the light has not gone and come back. I wrote to the author. At that time we were in the 1950s, this was an English book. So, this person was in England. I wrote to him and he wrote back a nice letter saying that he is glad that I read my books and think about what is written and he sort of agreed with me that in a finite time, you won't have an infinite number of images.

So, that incident sort of sparked my confidence and then there were many other things in school and college. So, I really wanted to take up physics. Now, when I told this to my parents, my father was actually quite supportive for various reasons. When he was young, he had done engineering but he was asked to step into the family business because his father passed away. So, he had a sympathy for people who wanted to do academics. So, that is how I have done it.

SS: Now, coming to science, you work in statistical physics. When I as a layperson hear the word random, I do have some idea of what that means. But to a practising physicist such as you, what does randomness really mean?

MB:  Randomness means to me the same thing that it means to everybody else. Something that is not predictable because it could be this way or that way. There are options and there might be different probabilities or different options so that you cannot be sure which one will happen.


So, that is what I would say is the characteristic of randomness. You are not sure of what will happen in time.

Randomness in space, we all have an intuitive idea - things are scattered without any pattern or arrangement, you know. So, my idea of randomness is the same as anybody else's, I think.

SS:  So, if we could find out a  mechanism to determine which one is going to be picked, then do you think this concept of randomness will become redundant?

MB:  Not in such a sweeping sense but it is also true. See, there could be some things that are intrinsically random like nuclear decay which involves beta particle emission - from one emission to the next, it is truly random. There are other things which are effectively so random that you, I mean, well, which are effectively very well described as random.

For instance, when you toss a coin, you know it will end up as heads or tails and the question is why do we think of it as equally probable? Well, that is because actually as we know the laws of physics including, I mean, involving classical mechanics should determine exactly what the outcome would be - either heads or tails. But it is complicated enough that effectively indeed it is a random process.

So, what I am trying to say is that things that are complicated though intrinsically described by deterministic equations will effectively be random. People should use effective descriptions and the reason is very simple - because they are simpler. Any description that is simpler is good and useful and certainly, effective randomness is an example. 

SS: I understand. My next question relates to how we traditionally learn about phase transitions in school. We are taught that given a temperature and pressure, ice changes to water, and water changes to vapor as temperature increases. However, we often overlook the role of pressure. While temperature is the primary factor we focus on, a slight change in pressure near the triple point—even while keeping the temperature constant—can prevent a phase transition from occurring. The fundamental idea remains that once a certain boundary is crossed, a phase transition takes place.

MB: That’s an interesting point. When we talk about phase boundaries, particularly the transition between liquid and vapor, we see that this boundary terminates at a critical point. However, the solid-liquid boundary behaves differently—it does not end at a critical point but rather continues indefinitely. The reason lies in symmetry considerations.

Liquid and vapor phases share the same symmetry—both are homogeneous and isotropic. This allows for the existence of a critical point where the phase boundary terminates. However, the solid phase has a fundamentally different symmetry. In a solid, atoms are arranged in a structured manner, meaning it breaks continuous translational symmetry. This broken symmetry prevents the solid-liquid transition from terminating at a critical point because, if it did, one could theoretically move around the phase diagram and bypass the phase transition entirely, which is not physically possible.

A particularly fascinating case is water under high pressure. Unlike many other substances, water exhibits multiple solid phases, meaning that at very high pressures, the phase diagram becomes highly complex, with over 10–11 different solid phases discovered so far. Each phase is separated by its own phase boundary, creating a web of phase transitions rather than a simple linear boundary.

This concept of symmetry-driven phase behavior is fundamental in statistical physics and quantum mechanics, and it was originally formulated by Lev Landau. His argument explains why phase boundaries can terminate at a critical point only if the phases involved share the same symmetry—as seen in the liquid-vapor transition. However, for solid-liquid transitions, where symmetry fundamentally differs, such a termination is not possible.

SS: Let me try to understand this from a different angle. You mentioned earlier that in theory, for a very short time interval after I place the candle, there is no image of it  on the mirror. In the same way, if I consider the system over a very short time interval, there will be a region where the phase is morphing. Can you please explain or help me visualize what exactly is happening there?

#img(path: "/images/MB3.jpeg", caption: "The then Prime Minister of India, Dr. Manmohan Singh, unveiled the foundation stone of the new TIFR Hyderabad campus in October 2010. [Credit: Mohd. Yousuf, The Hindu]", position: bottom)

MB:  Well, the first thing is that you must understand what is meant by this temperature, pressure phase diagram and what it is referring to is phases which have reached equilibrium. So, the diagram with pressure and temperature and so on applies only to equilibrium phases of matter. Now, equilibrium is a state which is reached in principle if you wait very very long - you have to wait really long for a system to reach equilibrium and for example, if you change the temperature, it takes some time for the system to equilibrate.

So, the diagram, that phase diagram applies only to phases and systems which are actually in equilibrium. The moment you say that you do something and for a time, short or you know finite time, the system may or may not have reached equilibrium in that time, it probably would not, I mean it is a very short time and so this diagram on its own will not apply, but the fact is that as time goes by, you will indeed transit to the other phase. So, the question you ask is actually very interesting and a matter of current research. How do you accomplish a phase transition, how does one phase change to another in time? The answers are also very nice and finally, very simple.

So, there are regions with phase 1 and regions of phase 2 and these are small if the time is low. As time passes, these regions grow, they are still not very very large, but they are bigger than they were and you can define if you like a typical droplet size. So, as time passes, that size increases.

When that size reaches the size of a container, you actually will finally reach equilibrium. So, that is the way one can imagine it.

SS: Thank you. My next question is about administration. You have served as the Director of Tata Institute of Fundamental Research (TIFR). How do you see the difference between a non-scientist administrative role with regular responsibilities and the role of a director, in a scientific institution?

MB: These two roles are very different, yet they are interconnected. As a director, my responsibilities extended across various aspects of the institute.

First and foremost, there is a responsibility towards the faculty, as well as the entire staff—administrative personnel, technical teams, gardening staff, and so on. The director oversees the well-being of everyone in the institute. Even small but meaningful changes, such as installing an air conditioner in a driver’s cabin, can make a difference in creating a better working environment.

While these are administrative tasks, the director plays a crucial role in academics. The responsibility is not to dictate but to help define the direction the institute should take in research and education.

Personally, I found that the biggest support in this role came from two sources, i.e.,The Faculty – They are central to the institution, and their collaboration is crucial for the institute’s growth and The Council of the Institute – In the case of TIFR, the council was chaired by Ratan Tata (which, though incidental, is notable). The council played a key role in providing critical oversight and guidance. It met four times a year and functioned similarly to a Board of Governors (BOG) in other institutions.

The director also has an external-facing role—securing funding and engaging with government bodies. Since TIFR operates under the Department of Atomic Energy, I had many interactions with government officials and funding agencies.

This is very different from the role of a researcher. As a researcher, I would be happy to teach, mentor a small group of students, and work on problems at a blackboard with chalk in hand. That is where my personal comfort lies. But a director’s job is different.

One of the biggest challenges in leading an academic institution is managing highly talented, independent-minded individuals. Academics are known for their strong opinions, and everyone believes they are right—and often, they are, in different ways. The challenge for a director is to bring these different viewpoints together to shape a collective vision for the institution.

So yes, being a director is a very different experience, but fortunately, it is also a fulfilling one.

SS: How do you evaluate the present condition of academia in various countries - for science in general and research in particular? I don’t have a  more specific question regarding this, so I would just like to hear your thoughts on this.
MB: To assess the current situation, we must compare it with the past. So, I’ll share my perspective by comparing today’s scenario with the time when I returned to India from the United States.

#img(path: "/images/MB5.jpg", caption: "STATPHYS – Kolkata IX (2016): Abhishek Dhar, Sanjib Sabhapandit, Mustansir Barma, Sakuntala Chatterjee, Shamik Gupta. [Source TIFR H]", position: bottom)

I came back in 1976 and joined TIFR, first as a postdoc and later as a permanent faculty member. If I focus on physics, particularly condensed matter physics, the research environment back then was very different from what it is today. At that time, there were very few active research groups in India. It is difficult to imagine today, but back then, you could count all the major groups on your fingers—probably no more than ten. It was a challenging time, but also exciting in its own way. The DAE Solid State Physics Meeting was one of the very few academic gatherings in the country. Since there weren’t many conferences, this meeting became the central hub where almost everyone working in condensed matter physics in India would come together. Travel was very different too. There were no frequent flights, so we relied on trains for travel. I remember collaborating with a researcher in Roorkee while I was in Bombay—and every interaction required significant logistical effort.

SS: Do you mean IIT Roorkee?

MB: There was no IIT in those days—it was the University of Roorkee. But yes, the same place.

Back then, travel was very different. To visit Roorkee, I would take the Dehradun Express, which slowly made its way through Delhi and reached Roorkee in about 36 hours. Today, that seems unimaginable—there were no direct flights, no quick alternatives, but we managed. We took trains all over the country, and that was just how things were.

Of course, that’s not the main point. The real point is how different the academic landscape was. There were very few researchers, but it was still very enjoyable. We communicated by letters—no email, no instant messaging. And in some ways, that was actually a good thing. When you wrote a letter, you had time to think before responding. Today, emails create an expectation of immediate replies—within a couple of hours at most. But back then, you could take a week to reply, reflect on ideas, and engage more deeply. Compared to those days, things today are much faster and more interconnected. Collaborations are no longer limited by geography—they happen online, across institutions, and even across continents.

If I focus on my field, statistical physics, the transformation has been incredible. Today, India has one of the largest statistical physics communities in the world. That didn’t happen overnight—it took years of meetings, training, holding schools, and community-building efforts. One of the best examples of this is the Annual Community Meeting, organized by the International Centre for Theoretical Sciences (ICTS) in Bangalore. It is a completely open forum, where everyone—no matter how senior or junior—gets just 10 minutes to speak. The idea is to foster inclusivity and ensure that everyone contributes.

#img(path: "/images/MB4.jpg", caption: "Mustansir Barma delivering an invited talk at the International Institute of Physics, Brazil, on \"Entropy, Order and Fluctuations\", in January of 2020. [Source IIP]", position: bottom)
Another major initiative by ICTS is the Annual Summer School, where they bring in top international speakers. Around 80–90 students participate each year, getting exposure to some of the best minds in the field. It’s not just about learning from experts—it’s also about impressing them with the quality of Indian research. There’s no doubt that the research scenario in India has evolved dramatically. Opportunities have multiplied, and the landscape is far richer than before.

I once wrote about this in an article titled “An Evolving Landscape” for the Indian Association of Physics Teachers magazine. But that’s beside the point—I’m happy to share these thoughts again because the transformation of science in India is something worth celebrating.

SS: What do you make of the present scenario regarding research funds in India?

MB: Research funding has its challenges. Due to the budget cycle, sometimes funds are not released exactly on time, but such delays have not been severe enough to disrupt the entire system. It is not as though salaries are suddenly cut in half or research is completely halted.

The government has been generally supportive of science—sometimes more, sometimes less. All institutions have aspirations: they want to grow, expand into new areas, and accommodate more students. However, it is not always possible for the government to support everything at the desired scale.

That said, if I compare today with the 1970s, the situation has greatly improved. Back then, traveling abroad to attend conferences was not possible frequently—perhaps once in a few years, not every year as it is for many researchers today.

Research funding today is better than in the past, but a judicious allocation of resources across institutions and researchers would have a huge impact. In the grand scheme, the amount allocated to fundamental science is still minuscule, but it does not mean that simply increasing the budget is the solution.

If we can ensure that financial support is given in an effective and strategic manner, India can progress by leaps and bounds.

SS: Should we question everything, or should we only ask the right questions?

MB: Question everything. There is no such thing as questioning rightly or wrongly. How do you even know if a question is right or wrong until you define it and explore the answer?

In science, answers are not the main thing. The question is paramount. The true essence of science lies in asking the right questions, pushing boundaries, and challenging assumptions.


#colbreak()

SS: Having completed a major portion of your academic life and having become an Emeritus Professor, what do you consider to be your biggest contribution to science, TIFR, and the students?

MB: One of my most significant contributions as a Director of TIFR was initiating and playing a key role in the formulation and partial execution of the new TIFR campus in Hyderabad. It is a very large campus, seven times the area of the TIFR campus in Mumbai. It holds enormous potential, and if it reaches its full realization, it will be a game changer—not just for TIFR, but for the entire country.

Progress is happening, though not at the speed we initially envisioned. Time has inflated, as is often the case with large-scale projects. But in the long run, this does not matter, because we hope that this institution will last for hundreds of years.
Seeing the plans I helped initiate now being executed is a source of immense satisfaction and pride for me.

SS: Thank you, sir. It was a pleasure speaking with you.

MB: Thank you very much.
