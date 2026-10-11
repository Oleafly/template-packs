//////////////////////////////////////////////////////////////////////////////
// EXAMPLE ARTICLE FOR INSCIGHT
// I HAVE TRIED MY BEST TO INCLUDE AS MANY EXAMPLES OF TEMPLATING AS POSSIBLE
// TO MAKE THE EXAMPLE AS COMPREHENSIVE AS I CAN.
// IF YOU FIND ANYTHING UNCLEAR OR HAVE THOUGHTS ON MAKING THIS MORE
// COMPLETE, LET ME KNOW.
//////////////////////////////////////////////////////////////////////////////

#import "/template-files/inscight-template.typ": * // this simply imports the layouts and helpers; this never changes

#let title = "Remembering Jane Goodall: In the Forest and Beyond" 
// title must be a string. Can contain formatting (bold, italic) or math (enclosed within ticks ``), 
// but we aim to keep the title as simple as possible

#let authors = "Dishari Dasgupta"
// author list is string or array of strings (in case of multiple authors).
// Can contain formatting (bold, italic) or math (enclosed within ticks ``), 
// but we aim to keep the title as simple as possible
// multi-author example: #let authors = ("Author 1", "Author 2")

#let affiliations = "Department of Biological Sciences, IISER Kolkata"
// affiliations has properties exactly same as authors
// multi-author example: #let affiliations = ("Insti 1", "Insti 2")

#let authorInfo = "*Dishari Dasgupta*, currently a PMRF scholar at the Dog Lab, works under the joint supervision of Prof. Anindita Bhadra and Dr. Manabi Paul. Her research focuses on the urban adaptation of free-ranging langurs and their interaction dynamics with free-ranging dogs and humans."
// authorInfo is meant for author bio and stuff. Has same properties as authors.
// string for single author, array of strings for multi author
// multi-author example: #let authorInfo = ("Desc 1", "Desc 2")

#let coverImage = "/covers/dishari.svg"
#let authorImage = "/authFaces/Dishari.JPG"
// cover image and author image are kept in their respective folders, which must be reflected in the paths

#let received = (month: 01, day: 27, year: 2026)
// article finalising date

#let abstract = "Dishari traces how Jane Goodall, a young woman with no formal scientific training, walked into Gombe with a notebook and binoculars and ended up overturning one of humanity’s most cherished assumptions — that tool-making, complex social life, and culture belonged to us alone."
// String. Abstract/excerpt/pitch for the article. Formatting is possible and encouraged.

#let reviewedBy= "Ishita Bardhan"
// String or array of strings. Names of the editors/reviewers for the article.
// Same properties as authors.

#let refsFile = "/dataFiles/dishari.yml"
// String. Path of data file that contains list of references for present article.

#show: article.with(
  issueDetails: yaml("/dataFiles/issueData.yml"),
  title: title, 
  authors: authors,
  authorAffiliations: affiliations,
  abstract: abstract,
  coverImage: coverImage,
  authorImage:authorImage,
  authorInfo: authorInfo,
  received: received,
  reviewedBy: reviewedBy,
  refsFile: refsFile,
  authorImageWidth: 90%,
  outlinePrefix: [*From Issue #8: *]
  // breakAfter: (-1,),
)

The iconic image of a blonde-haired lady in khaki shorts stretching out her hand towards a baby chimpanzee, and the chimpanzee too stretching out its hand towards the lady in the forest, is still fresh in my mind from when I first saw it back in college. Out of curiosity, I had tried to find out more about her and got to know her name was Jane Goodall, an iconic primatologist who changed the world’s perception about our non-human primate cousins – the chimpanzees of Gombe. That is also when I realized there is more to life science than the usual cancer-virus-DNA sequences. Cut to 2025, almost a decade after coming across this image, Jane Goodall breathed her last on 1st October at the age of 91. The internet was flooded with obituaries. After all, a legend had died.

#img(path: "/images/stretching.png", position: top, caption: "A photo of Jane Goodall and infant chimp Flint reaching out to each other, captured by her husband Hugo van Lawick in 1964. Long after that, the image continues to influence our perception of chimpanzees. \"*When I saw it, though I did not realise it would become iconic, it did make me think of Michelangelo's painting of God reaching out to Man.*\" -- Goodall", width: 66%, portrait: false)
== Early Life and Inspiration

To know who she was, it helps to begin before the forest, before the chimpanzees, when she was a little girl named Valerie Jane Morris-Goodall. She was born in London in 1934. Her first encounter with chimpanzees came in childhood through a stuffed toy named Jubilee. Her father left early, and she was raised largely by her mother in a household shaped by strong women. Although she did well in school, university was financially out of reach. In 1953, at nineteen, she enrolled at London’s Queens Secretarial College and went on to hold a series of clerical jobs. Amidst all this, she nurtured within her an ambitious dream: a dream to visit Africa. In 1955, a former school friend invited her to stay on her family’s farm in Kenya. Determined to seize the opportunity, Jane worked as a waitress to save the fare. In 1957, she finally travelled to Africa.

She took an office job in Nairobi, where she met Louis Leakey, a paleoanthropologist studying human evolution. Though he was an academic, he believed that formal training could sometimes limit a person's capacity for observation, binding them to pre-conceived theories. Jane’s lack of a degree, which would later become one of the strongest criticisms against her, was an advantage to him. Leakey trained her in basic research methods and entrusted her with a task to study wild chimpanzees in what would later become Gombe Stream National Park.

#img(path: "/images/dishari2.jpg", position: top, caption: "Jane Goodall with David Graybeard. In Gombe, the first chimp to lose their fear of Jane was Greybeard. This gave Jane the opportunity to study the complex world of chimpanzee life. [National Geographic / Jane Goodall Institute]", width: 90%, portrait: false)
== Work at Gombe Stream National Park

Armed with a notebook and binoculars, Jane arrived at the National Park in the 1960s in her 20s. Authorities did not permit solo women in the forest, so her mother agreed to accompany her. There were no sightings of the wild chimps for the first few months. Eventually, the chimps appeared. And once they did, everything changed.

She documented chimpanzees deliberately choosing grass stems or twigs, stripping leaves from them, and altering their length before inserting them into termite mounds. The termites clung to the probe, which the chimpanzees then withdrew and consumed. This work, published in Nature (1964), demonstrated that tool use occurred in the wild and that these tools were made for a specific purpose. This finding was revolutionary because it challenged the long-held definition of humans as "the toolmaker." By showing that chimpanzees could not only use but also modify objects for a specific task, Goodall provided the first clear evidence that the capacity for purposeful tool-making was not unique to our species, fundamentally altering the understanding of this boundary between humans and other animals. Louis Leakey responded with a line that became legendary: “Now we must redefine tool, redefine man, or accept chimpanzees as humans.” The findings reframed chimpanzees as cognitive agents capable of planning, learning, and problem-solving, laying the foundation for modern primate cognition research (Goodall, 1986; McGrew, 2010). Her subsequent research in the following decades further revealed that these free-living chimps of Gombe had social hierarchies, alliances, maternal bonds, territorial fights, male infanticide, and cannibalism. The world reacted to her findings with both appreciation and criticism. She named her chimpanzees instead of numbering them, a practice critics dismissed as anthropomorphism. Many pointed out her lack of formal scientific training and statistical rigour in the early years. Goodall responded to part of this criticism by earning a PhD from Cambridge under the mentorship of Robert Hinde, becoming one of the few people admitted to a PhD programme without an undergraduate degree.

Her visibility grew when she met her first husband, Hugo van Lawick. His photographs and films for National Geographic carried Gombe into living-room televisions across the world. One of those images, the same one that I mentioned in the beginning, came to define her in the public imagination. Leakey’s institutional backing, paired with van Lawick’s captured imagery, helped secure the grants that kept the research project running.

== Criticisms and Scientific Debate

But the spotlight created a simplified story of Jane Goodall alone in the forest, quietly erasing the native Tanzanian field assistants whose knowledge and labour sustained the research. This omission has since become a central point in broader critiques of how scientific fieldwork, particularly in colonial and post-colonial contexts, has historically overlooked the contributions of local collaborators. Their absence from authorship and intellectual credit is now recognized as part of a larger pattern of structural bias in early primatology. 

In 1975, the Gombe project was shaken when four young researchers linked to Jane Goodall were kidnapped at night by rebels associated with Laurent Kabila. In her memoirs, Goodall mentions the incident briefly, framing it as one of many dangers of working in a politically unstable region and focusing on the relief of the researchers’ eventual release. However, contemporary media accounts were far less restrained in their reporting. They detailed the beatings, the weeks of captivity, and the ransom, eventually raised by the families, while questioning why neither institutions nor senior leadership took a more visible public stand. This crisis left a haunting question for everyone, one that extends beyond Gombe: when science crosses borders and goes to the field, who is responsible for the safety of the people who make it possible?

== Conservation and Advocacy
By the 1980s and 1990s, she gradually shifted from daily field research and moved towards advocacy. She founded the Jane Goodall Institute and redirected her efforts to community-based conservation, education, and livelihoods. This transition into advocacy came to define the latter half of her life. She became a global voice on conservation ethics, fearlessly advocating for policies that protect the environment. Her commentary often extended to world leaders, whom she consistently urged to prioritize science and environmental health over short-sighted political or economic gains.

== Legacy
Jane Goodall – a celebrity scientist, a global advocate, an icon. But to understand her legacy, we must focus on her journey and not just the outcome. The journey of a woman who ventured out with a notebook and binoculars to explore the world of free-living chimpanzees. She quietly redefined what it meant to be a field-based researcher in academia. Demonstrated that the previously known boundaries differentiating between human and ape were not rigid. 

Her story also reminds us that science is a method that can be used by people, who were not formally trained in their ‘formative’ years, to go on to do great work in future, given the right mentorship, generous funding agency, great visual storytelling, and timing. 
#img(path: "/images/dishari3.jpg", position: top, caption: "The Jane Goodall Institute is a global  organization founded by Dr. Jane Goodall in 1977. It works in 6 African countries and supports the rehabilitation of chimpanzees, alongside conservation projects. [Jane Goodall Institute]", width: 90%, portrait: false)
