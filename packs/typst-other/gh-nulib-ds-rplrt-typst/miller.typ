#import "elements.typ": *

#counter(footnote).update(0)
#abstract(
  [Paul B. Anderson, Nikolai Berdyaev, and Russian Christian
Culture],
  abstract-subtitle: [],
  abstract-author: [Matthew Lee Miller],
  [
    ],
  abstract-keywords: []
)

// This section sets the headers for the article
#set page(
  header-ascent: 40%,
  header: context {
    set text(8pt, font: "IBM Plex Sans", stretch: 75%, weight: 400)
    let first-page = locate(<first-page-miller>).page()
    if here().page() == first-page [
      #grid(
        columns: (45%, 45%),
        gutter: 10%,
        align(left)[
          NORTHWESTERN UNIVERSITY STUDIES IN RUSSIAN\
          PHILOSOPHY, LITERATURE, AND RELIGIOUS THOUGHT
        ],
        align(right)[
          Volume 2 (2024): #first-page#sym.dash.en#locate(<end-of-miller>).page() \
          10.71521/s31r-ah05
        ]
      )
    ] else if calc.even(here().page()) [
      #set align(center)
      #set text(font: "IBM Plex Sans", size: 11pt, weight: 600)
      #upper([Matthew Lee Miller])
    ] else [
      #set align(center)
      #set text(font: "IBM Plex Sans", size: 11pt, weight: 300, tracking: .1em)
  #upper([_Paul B. Anderson, Nikolai Berdyaev, and Russian Christian
Culture_])
    ]
  },
  footer: context {
  if calc.even(here().page()) [
    #align(right)[#here().page()]
  ]
  else [
    #align(left)[#here().page()]
  ]
 
  }

)

#set align(center)
#image("articlestart.png", width: 30pt)
#set align(left)

#heading(level: 2)[Paul B. Anderson, Nikolai Berdyaev, and Russian Christian
Culture]
<first-page-miller>
#v(1em)
#subtitle([])

#v(1em)
#author[Matthew Lee Miller]


Paul B. Anderson (1894--1985) focused his career on serving young
Russians and the global Orthodox Christian community. During his years
of outreach, Anderson's understanding of Orthodox worship and thought
grew, and he emerged as one of the first Western experts on religion in
the Soviet Union. His global efforts led to four prominent
accomplishments: 1) building bridges of communication and relationship
among Eastern and Western Christians, 2) developing publishing and
educational opportunities for Orthodox believers, 3) speaking out for
the protection of religious freedom in the USSR, and 4) providing
reliable information on religion in the Soviet Union. Anderson began his
service with the Young Men's Christian Association (YMCA) in China
(1913--17) and Russia (1917--18). In 1920, he received a YMCA assignment
to serve émigrés from Russia; he conducted this work from bases in
Berlin (1920--24) and Paris (1924--41). During this period, he worked to
assist émigrés in partnership with the Russian Correspondence School,
YMCA Press, Russian Student Christian Movement, and Orthodox Theological
Institute. In 1922, Anderson and Russian philosopher Nikolai Berdyaev
began to collaborate on several significant projects, including the Free
Philosophical Academy, the YMCA Press, and the journal #emph[Put' (The
Way).] Anderson recognized the unique value of Berdyaev's thought and
experience, working to build an organizational support system which
assisted his creative vision. Anderson quietly worked alongside Berdyaev
and several other émigré leaders in a way that enabled the preservation,
enrichment, and expansion of Russian Orthodox culture.#footnote[For an
introduction to the work of the YMCA among Russians, see Matthew Lee
Miller, #emph[The American YMCA and Russian Culture: The Preservation
and Expansion of Orthodox Christianity, 1900--1940] (Lanham, Maryland:
Lexington Books, 2013).]

By 1920, Anderson understood that he would not be able to return to
Russia. However, he received a YMCA assignment to serve émigrés from
this country in Poland and Germany; this developed into his years of
ministry from bases in Berlin and Paris. This article explores the
development of his work among émigrés during this period. Anderson had
developed an interest in Orthodox Christianity during his 1917 service
with John R. Mott, and he gradually developed a deeper appreciation for
Eastern Christian doctrine and practice through his reading and
relationships. During his years in Berlin and Paris, he served as a
leader within the YMCA for shaping the Association's approach to
Orthodoxy: over the years, it had shifted from resigned toleration to
pragmatic assistance to limited support to enthusiastic
partnership.#footnote[See Paul B. Anderson, “The YMCA and the Russian
Orthodox Church,” November 27, 1926, Russian Work -- Europe, Restricted,
Correspondence and Reports, 1920--29, Annual Reports, 1920--29, Kautz
Family YMCA Archives, University of Minnesota Libraries, Minneapolis
(KFYA); #emph[Objectives, Principles, and Programme of Y.M.C.A's in
Orthodox Countries] (Geneva: World's Committee of Y.M.C.A.s, 1933), Paul
B. Anderson Papers, University of Illinois at Urbana-Champaign Archives
(PBAP); Paul B. Anderson, “A Study of Orthodoxy and the YMCA,” booklet
printed in Geneva by the World Alliance of Young Men's Christian
Associations, 1963, 15 (Pamphlets on Orthodoxy, YMCA of the USA,
Anderson, Paul B, 1, KFYA).] During this period, Anderson worked with
Berdyaev to make significant contributions to building bridges of
communication and relationship among Eastern and Western Christians and
supporting Orthodox publishing and educational opportunities. They also
spoke out for the freedom of conscience in the USSR and provided
reliable information on religion in the Soviet Union.#footnote[Three of
the most useful monographs on this topic are: Marc Raeff, #emph[Russia
Abroad: A Cultural History of the Russian Emigration, 1919--1939] (New
York: Oxford University Press, 1990); Robert C. Williams, #emph[Culture
in Exile: Russian Émigrés in Germany,] 1881--1941 (Ithaca, NY: Cornell
University Press, 1972); and Robert H. Johnston, #emph[“New Mecca, New
Babylon”: Paris and] the #emph[Russian Exiles, 1920--1945] (Kingston,
ON: McGill-Queen's University Press, 1988). See also A. V. Anashkin, K.
M. Antonov, and G. V. Bezhanidze, eds., #emph[Russkaia emigratsiia:
Tserkovnaia zhizn' i bogoslovsko-filosofskoe nasledie] (Moscow:
Izdatel'stvo Pravoslavnyi sviato-Tikhonovskii Gumanitarnyi Universitet,
2022).]

Anderson's trip to Copenhagen, Denmark, in the summer of 1920 served as
a transition that initiated his next stage of work in Berlin, Germany.
He had an opportunity to explore Sweden and Norway before he received a
telegram from John R. Mott, asking him to travel to Poland and Estonia
and visit new YMCA programs to assist refugees. Mott (1865--1955)
provided leadership for YMCA global outreach and the expansion of the
ecumenical movement. This exploratory trip led to Mott's invitation to
oversee service for Russian POWs in Germany.#footnote[Paul B. Anderson,
letter to Berta \[his sister\], August 17, 1920, Paul B. Anderson and
Family Papers, Kautz Family YMCA Archives, University of Minnesota
Libraries, Minneapolis (PBAFP KFYA). For developments in Mott's thinking
at this time, see Benjamin L. Hartley, “The 1921 Founding of the
International Missionary Council in the Life of John R. Mott,”
#emph[International Review of Mission] 111:2 (November 2022): 253--67.]
Anderson traveled to Warsaw and secured government permission to provide
Y assistance to Russian refugees who had been living in prisoner of war
camps in Poland since the war. He then received authorization to expand
service to 50,000 Soviet prisoners from the Russo-Polish War of
1919--1920, who were in transit to camps within Germany. Due to this
time, he was invited to participate in a Repatriation Committee
organized by Fridtjof Nansen, the Norwegian humanitarian leader.
Anderson represented the YMCA in the Kowno (Kaunas) Repatriation
Conference, which included Nansen and a delegation from Moscow. This
conference negotiated the exchange of prisoners between Russia, Germany,
and the former Austro-Hungarian Empire.#footnote[Paul B. Anderson,
“Introduction to the Topic,” written July 17, 1976, for the panel, “The
‘Homesick Million': Russian Emigration, 1917--1975,” American
Association for the Advancement of Slavic Studies national convention,
St. Louis, Missouri, October 8, 1976, 1--2, author's copy.] Nansen was
named High Commissioner of Refugees by the League of Nations in 1921. He
requested Association assistance for work with refugees and received
50,000 dollars; the YMCA operated twenty camps in 1920--21 with this
funding.#footnote[Donald E. Davis, “The American YMCA and the Russian
Emigration,” #emph[Sobornost] 9 (1987): 25. See also Paul B. Anderson,
“Russian Work -- Policy Study,” November 23, 1943, 3 (PBAFP KFYA).]

Anderson continued his YMCA service with civilian refugees in spring
1921; they reached several points along the Polish/Russian border for
processing and transfer to refugee camps throughout Poland. He recalled
“the great exodus of civilian refugees from Russia . . . due to the
repression, terror and famine which combined to make life in Russia
unbearable.”#footnote[Anderson, “Introduction to the Topic,” 2.] At
Narva, Estonia, he recognized familiar faces among these refugees,

#quote(block: true)[
I remember seeing refugee men, women, and children unloading from Russia
at Narva. They were dumped . . . some distance from town and walked as
best they could the two miles to the formidable looking fortress of
Ivangorod, which looked like anything but a welcome home. Their luggage,
much of it simply wrapped in a blanket and tied with a rope, was either
carried or brought in local horsedrawn wagons. All were tired, hungry,
and still anxious lest they had not yet actually left the Russia they
feared. Among these refugees from Russia there came my good friends from
Moscow, Mme. Alexandra Shidlovsky and her daughter Sophie.#footnote[Paul
B. Anderson, “No East or West: The Memoirs of Paul B. Anderson,” ed.
Donald E. Davis, unpublished manuscript, \[1982\], author's copy, 83.]
]

These two women were the wife and daughter of Sergius Shidlovsky, who
had been vice president of the Duma.#footnote[Anderson, “No East or
West,” 83--84; see Sophie Koulomzin, #emph[Many Worlds: A Russian Life]
(Crestwood, NY: St. Vladimir's Seminary Press, 1980). Her sister Mania
(Maria) worked as a secretary in the YMCA office until it closed in
1918; she was imprisoned with Anderson and other Russian secretaries for
a few days.]

#strong[Work in Berlin, 1920--1924]

Anderson set up a headquarters for service to refugees in Berlin in a
large apartment at 51 Kurfurstenstrasse, where he lived with Donald
Lowrie and James Sommerville, fellow Y secretaries. They were joined by
a Mr. Hillman, who had previously served with the Y in Russia and
France. The apartment had eight rooms, plus kitchen and bath. The team
divided responsibilities according to their strengths. Lowrie focused on
developing contacts and relationships with government officials;
Anderson explained that Lowrie spoke German and Russian better than he
did himself and had an ability to connect with people in a friendly way.
Sommerville worked in the office, dealing with correspondence. Anderson
traveled extensively, visiting camps where Russian prisoners of war and
refugees had been held since 1914 in crowded and difficult
conditions.#footnote[Paul B. Anderson, letter to his mother, October 10,
1920, 1--3 (PBAFP KFYA). Two key overview documents for the study of the
YMCA Russian work are \[International Survey Committee\], “Survey of
North American YMCA Service to Russians in Europe” \[1930\], Russia,
International Survey -- 1930, Romania, Russia, South Africa, Box 12,
KFYA; and Paul B. Anderson, “YMCA Russian Work,” interview with Donald
E. Davis, September 9, 1971, Russian Work, Restricted, General, Personal
Accounts, KFYA.]

Anderson invited Mrs. Shidlovsky and Sophia to join the group for dinner
one evening, after their arrival in Berlin. They had experienced
multiple difficulties and had not had enough to eat. He had developed a
friendship with the family during his time in Moscow:

#quote(block: true)[
\[Mrs. Shidlovsky\] was a great friend of all of us Y men there, and one
of her daughters, Mary, was with me when we were locked up. They were a
very wealthy family and influential in liberal political movements. Of
course now they are quite stranded, but Mrs. Shidlovsky takes a very
practical view of her situation and is eager to set to work. The
unfortunate thing is that she both looks and is half-starved, though she
does not admit it; and Sophie, the younger daughter who came with her,
has been quite ill, partly with excitement and partly with fever and is
just now getting on her feet. Except of course for the San Galli family,
I knew them better than any others in Russia.#footnote[Paul B. Anderson,
letter to his mother, October 10, 1920, 4 (PBAFP KFYA).]
]

Sophie and her mother later participated very actively in YMCA programs
to serve refugees in Berlin and Paris. One immediate need for émigrés
was a passport, since the Soviet government deprived them of citizenship
in October 1921. After 1922, émigrés were able to apply for a “Nansen
passport,” a stateless person's passport, issued by the League of
Nations Office of High Commissioner for Refugees; this allowed them to
be authorized for employment.#footnote[Donald E. Davis, “The American
YMCA and the Russian Emigration,” #emph[Sobornost] 9 (1987): 24, 28.]

In 1920 and 1921, Anderson made multiple trips to locations assisted by
the YMCA Russian Service, primarily camps in Poland, in order to
experience the lives of men who would interact with the correspondence
school and publishing program. He also traveled to explore regions where
he hoped to provide Russian-language books; his destinations included
Sofia, Kishinev, Uzhhorod, Warsaw, Riga, and the Pochaevo Lavra near
Lvov (Lviv).#footnote[Anderson, “No East or West,” 94, 98--99.] For
example, in Volumin (Wolomin), eastern Poland, he visited a “colony”
authorized by the Polish government for ninety-eight former imperial
Russian military officers. They were organized in work groups to
manufacture shoes, dishes, buckets, decorative boxes, and other goods
for resale; the YMCA provided tools for this program.#footnote[Paul B.
Anderson letter to Berta, March 31, 1921, 1--3, PBAFP KFYA. For
reflections on the motivations and outcomes of the YMCA's work in Poland
during this period, see: Sylwia Kuźma-Markowska, “Railroad Workers,
Civilization and Communism: The Young Men's Christian Association on the
Interwar Polish Frontier,” #emph[European Journal of American Studies]
13:3 (2018), #link("http://journals.openedition.org/ejas/13718"), DOI:
10.4000/ejas.13718.]

During these years, several YMCA staff members with experience in Russia
were able to work with the American Relief Administration (ARA) famine
relief program in Soviet territory: Ethan T. Colton, Lowrie,
Sommerville, S. M. Keeny, H. Dewey Anderson, and Edgar and Stella
MacNaughten. Paul B. Anderson submitted an application and completed an
interview in London with Colonel Haskell, a representative of ARA
chairman Herbert Hoover. However, his visa application was denied,
apparently due to his 1918 arrest and interrogation in Lubianka;
Anderson believed he was the only Y secretary rejected for ARA service.
This program, funded by the US government, provided food during the
1921--22 famine and saved over one million lives.#footnote[Anderson, “No
East or West,” 101; Paul B. Anderson letter to Sergei Grigorievitch
Troubetzkoy, February 6, 1975, 1 (PBAFP KFYA). See Bertrand M.
Patenaude, #emph[The Big Show in Bololand: The American Relief
Expedition to Soviet Russia in the Famine of 1921] (Stanford, CA:
Stanford University Press, 2002). A documentary film “America\'s Gift to
Famine-Stricken Russia” was created in 1922:
#link("https://www.hoover.org/events/americas-gift-famine-stricken-russia-1922-film-screening-live-musical-accompaniment").
See also the collection of photographs in Bertrand M. Patenaude and Joan
Nabseth Stevenson, #emph[Bread and Medicine: American Famine Relief in
Soviet Russia, 1921--1923] (Stanford: Hoover Institution Press, 2023);
and Benjamin L. Hartley, “Saving Students: European Student Relief in
the Aftermath of World War I,” #emph[International Bulletin of Mission
Research] 42:4 (2018): 295--315.]

The YMCA's 1920s program for Russian-language publishing developed after
a wartime program led by Julius Hecker. He was born in St. Petersburg
and received his education in the United States before his Methodist
ordination. Hecker was hired by the YMCA for work among prisoners of
war, which included literacy courses among Russians held in
Austro-Hungarian camps and the development of educational textbooks.
Hecker also connected with émigrés in Switzerland and developed a plan
for a publishing program that could encourage adult education more
broadly. He organized the translation of books by US Protestant pastor
Harry Emerson Fosdick and planned to distribute the works of popular
science author Nikolai Aleksandrovich Rubakin.#footnote[Paul B.
Anderson#emph[, No East or West,] ed. Donald E. Davis (Paris: YMCA
Press, 1985), 27.] These books were published in Geneva with the imprint
World Alliance YMCA, and Hecker expanded his vision for Russian adult
education. Many Russians and Y leaders supported his work, but
eventually he faced strong resistance due to the theological liberalism
presented in several works and his radical political views; Hecker was
required to resign from the Association. Hecker and Anderson talked
about the program and its possibilities, and eventually, Paul was
appointed to continue the project.#footnote[Ibid.#emph[,] 28.]

The YMCA books published under Hecker's leadership were not widely
distributed, and many books were placed in a warehouse. However, several
copies of these books were received by leaders of #emph[Licht dem Osten]
(Light to the East), a German-Russian Protestant missionary
organization. These leaders were very critical of the views promoted in
the books, so they contacted Mott; Anderson's mentor told him to stop
the production and distribution of these books, and he
complied.#footnote[Anderson, “No East or West,” 104.] He discussed the
situation with his YMCA coworkers. Personally, he understood that the
content of the books might offend many Orthodox readers. However, some
of the books did include useful scientific information, so he recognized
the complexity of the situation. His colleagues agreed that he should
visit Rubakin personally to explain the decision. Anderson wrote, “He
took my explanation silently and began to shed tears. I realized that I
had been talking with a man of great integrity and a representative of
his time.”#footnote[Ibid., 105; for a detailed study of Hecker's vision
and work with the YMCA, see Natal'ia Pashkeeva, “U istokov russkogo
izdatel'stva Soiuza YMCA Severnoi Ameriki: Deiatel'nost' shveitsarskoi
izdatel'skoi gruppy ‘Zhizn' i Kniga' (1917--1921),” #emph[Issledovaniia
po istorii russkoi mysli,] vol. 10 (2010--2011), eds. M. A. Kolerova and
N. S. Plotnikova (Moscow: Modest Kolerov, 2014): 273--362,]

Beginning January 1921, the YMCA authorized Anderson to begin work as
director of a Correspondence School for Russians, while James
Niederhauser was appointed as director for publications and printing.
Niederhauser had previously served with the Y in Siberia; the two men
worked together as colleagues until 1924, after which Anderson directed
both programs. He continued working with a number of technical
specialists hired by Hecker in fields such as engineering and
agriculture. He set up the Correspondence School in Berlin due to its
center as the Russian Work Headquarters on Kochstrasse, with 100,000
refugees in the area. The International Committee authorized 250,000
dollars to fund the venture.#footnote[Anderson#emph[, No East or West,]
\29.]

By 1922, Niederhauser set up the publishing enterprise in Prague with
the name IMKA TISK (YMCA Publishers in the Czech language). The location
had been chosen for financial reasons and due to the Russian émigré
population in the city; Anderson traveled back and forth from Berlin to
Prague multiple times. However, in 1923, the Soviet Union established an
embargo on the importation of reading materials, which created a
significant obstacle for the plans. The Prague printing plant was
closed; Anderson attempted to open a small bookshop in Berlin, but low
demand led to its closure. Fortunately, the Y was able to sell the
buildings and equipment in Prague without a significant loss of
investment.#footnote[Ibid.#emph[,] 31.]

During this challenging era, Anderson and his editorial committee began
to develop plans which correlated with the educational needs and reading
interests of those they met within the Russian émigré community. Y staff
members Gustave Gerard Kullman, Amos Ebersole, and Fyodor Pianov began
to make connections within Berlin and met a network of students,
professors, and writers who had arrived in the area due to the war and
those who had been exiled from Petrograd, Moscow, and Kiev (Kyiv).
Anderson and his colleagues began to consider how to help those in
need---a common YMCA reaction. However, as Anderson wrote, “One day it
came to me that perhaps we were looking at them from the wrong
angle---how to be of help to them---whereas, we should solicit their aid
to us. I brought this up at a staff meeting, where the idea received
encouragement.”#footnote[Ibid.#emph[,] 31--32.] This began a lifelong
habit for Anderson---viewing people in need not as inferior, but as
equals with valuable experience and intelligence.

Pianov had met Boris Petrovich Vysheslavtsev, a professor of philosophy
from Moscow University who had been exiled by Lenin. Anderson met with
him and learned more about this man and his fellow intellectuals, their
personalities and aspirations. He then invited him for a second meeting
at his home, along with Nikolai Alexandrovich Berdyaev and Simeon
Ludvigovich Frank, to talk about future collaboration. Berdyaev told
Anderson about professors who had been expelled from their posts in
Moscow and had responded by organizing a Free Philosophical Academy,
which attracted many young people to public lectures. This step had led
to their exile, and believed that they could organize a similar program
in Berlin. Anderson asked Pianov to rent lecture halls during the
evening at a Berlin high school and promote events featuring Berdyaev,
Frank, and Vysheslavtsev. The opening night served as a celebration,
attended by students, professors, church leaders, and a wide variety of
Russians, as well as key figures in the emigration, such as Metropolitan
Evlogii, novelist Boris Zaitsev, and Madame Maria Germanova of the
Moscow Art Theater.#footnote[Ibid.#emph[,] 33.] Berdyaev's opening
lecture set a tone for the evening and the Academy. He spoke on “the
terrible crisis through which Russian culture was passing in the
homeland and this opportunity to keep it alive
abroad.”#footnote[Ibid.#emph[,] 34.] The Academy's lecture series
continued with many in attendance, in rented facilities, with lecturers
paid for each event. In this way, “the YMCA became recognized as a
Russian cultural organization.”#footnote[Ibid.#emph[,] 34.] This venture
led to the formation of the Y's vision for this project: “the
preservation and development of Russian Christian culture, which was
submerged by the communist ideologists in the Soviet
Union.”#footnote[Paul B. Anderson, “Distinctive Aspects of Culture in
Russia and China,” lecture presented at Wheaton College, Norton, MA, May
8, 1972, text marked April 24, 1972, 11 (PBAFP KFYA). For a survey of
the YMCA's interaction with Russian émigrés, especially in Berlin and
Paris during the interwar period, see E. G. Pashkina, “Amerikanskaia
organizatsiia ‘YMCA' i russkaia emigratsiia pervoi poslerevoliutsionnoi
volny,” #emph[Amerikanskii ezhegodnik,] ed. V. V. Sogrin (Moscow:
Izdatel'stvo ‘Ves' Mir,' 2010), 332--341.]

YMCA staff members had earlier developed a strong connection to Evlogii
within Russia during the revolutionary era. Y men such as Colton had
served members and leaders of the Orthodox church through the famine
relief outreach of the American Relief Administration (ARA) in
1919--1923. Metropolitan Evlogii (Georgievskii) (1868--1946) served as a
leader of émigré believers in Europe during the interwar period, based
in Berlin and Paris. Metropolitan Antonii (Khrapovitsky)(1863--1936) led
a synod of bishops established in Sremski Karlovci in Serbia in 1921.
The synods led by Evlogii and Antonii competed for influence among
émigré believers as they provided different visions of Orthodox
interaction with European culture and western Christian churches.
Antonii's synod sharply criticized those who wished to cooperate with
non-Orthodox believers in contexts such as the Russian Student Christian
Movement and meetings of the ecumenical
movement.#footnote[Anderson#emph[, No East or West,] 34. For discussion
of Russian church conflicts of this period, see A. A. Kostriukov,
#emph[Russkaia zarubezhnaia tserkov' v 1925--1938 gg.: Iurisdiktsionnye
konflikty i otnosheniia s moskovskoi tserkovnoi vlast'iu] (Moscow:
Izdatel'stvo Pravoslavnyi sviato-Tikhonovskii Gumanitarnyi Universitet,
2012).] Anderson explained the role played by the YMCA in church
leadership dynamics in this way:

#quote(block: true)[
On one of his visits with Patriarch Tikhon in Moscow, Ethan Colton had
been requested by him to carry to Archbishop Evlogy the message that he
was considered by the Patriarchate as being in charge of the Church in
Western Europe. When Colton reached Berlin after this interview, he
asked me, as the staff man best acquainted with the Russian language and
Church, to accompany him to deliver the message. It was subsequently
confirmed in writing, but in the meantime it gave comfort and assurance
to Archbishop Evlogy. This conversation was Archbishop Evlogy's first
contact with the YMCA, and he never forgot
it.#footnote[Anderson#emph[, No East or West,] 34--35; John R. Mott had met Tikhon earlier during the Root mission in the summer of 1917. See also Jane Swan, #emph[Chosen For His People: A Biography of Patriarch Tikhon,] preface by Scott Kenworthy (Jordanville, NY: Holy Trinity Seminary Press, 2015).
]
]

Colton and Anderson communicated Tikhon's instruction to Evlogii to lead
the Church in western Europe; they also delivered Tikhon's message that
Metropolitan Platon should lead the Church in America. As Anderson
stated,

#quote(block: true)[
Let me return again to Dr. Colton. He came out from Moscow when I was
stationed in Berlin. This was in late April or May, 1922. He brought the
verbal message (subsequently in writing) from Patriarch Tikhon to
Metropolitan Eulogius, also in Berlin, living in the residential
corridors of the Russian Church located in the premises of the old
Russian embassy on Unter den Linden. Dr. Colton asked me to go with him
and interpret in conveying his message to Metropolitan (then Archbishop)
Eulogius to the effect that Eulogius should confirm to Metropolitan
Platon the Patriarch's desire to have him rule the Orthodox Church in
America. I kept no written record of this conversation, but Dr. Colton
was asked to testify in court in New York in the controversy between the
Living Church representative and the lawyers for the Metropolia, and
this is to be found in the court record. . . .#footnote[Anderson to
Troubetzkoy, 1--2.]
]

Anderson visited the metropolitan many times in Berlin and later in
Paris (at the Alexander Nevsky Cathedral, 12 rue Daru) until his death
in 1946. Anderson summarized, “He was the chief and most loyal
ecclesiastical sponsor of our work, whether as the YMCA or as the
Russian Student Christian Movement Abroad.”#footnote[Anderson#emph[, No
East or West,] 35.] The connections of the Y to Tikhon and Evlogii led
to ongoing cooperation; for example, Mott secured funds for the
publication of an English-language Orthodox service book, and Tikhon
provided written authorization, which was printed in the
book.#footnote[Paul B. Anderson, “Russian Work -- Policy Study,”
November 23, 1943, 6 (PBAFP KFYA).] Years later, Anderson provided
clarification about his connection to Tikhon:

#quote(block: true)[
I did not personally meet Patriarch Tikhon at any time. There is some
confusion in this regard, as two of my close colleagues in Moscow in
1918 saw him several times then and again in 1922. They were Dr. E. T.
Colton and Dr. Donald A. Lowrie, and their work and mine naturally found
common expression in what has been told or written. Their visits chiefly
came when they returned to Moscow in 1922 as YMCA workers under the
umbrella of the ARA, charged with relief service to ecclesiastical and
university personalities.#footnote[Anderson to Troubetzkoy, 1.]
]

Anderson had met a number of Orthodox leaders during his time in Russia,
but his understanding of this confession and his relationships with
leaders grew during his years in Berlin. For example, in Russia, Boris
Pash and his father, Fr. Theodore Pashkovsky, became involved with YMCA
activities after returning to the country from the US just before the
1917 Revolutions. In June 1918, the father and son served with the YMCA
Volga Agricultural Exhibit steamer. They left the country by the Black
Sea route in 1919 and came to Berlin, where Boris continued Y
activities. In 1922 the Y brought him to the US and he enrolled at
Springfield College; after graduation he became a teacher in California.
His father later became Metropolitan Theophilus, head of the Russian
Orthodox Church in the USA from 1934 to 1950.#footnote[Paul B. Anderson
letter to John Randle, YMCA National Board, Archivist, September 29,
year unknown, PBAFP KFYA. Anderson was given a copy of the book
#emph[The Alsos Mission] by the author, retired Colonel Boris T. Pash.
See “His Eminence, Metropolitan Theophilus (Pashkovsky),” Orthodox
Church in America,
#link("https://www.oca.org/holy-synod/past-primates/theophilus-pashkovsky")
(accessed November 6, 2023).]

During the early 1920s, Russian students began to meet for discussion
and study at university centers across Europe. Several of these students
had participated in the pre-war Russian Student Christian movement, and
two proposed a student conference for the summer of 1922, with
sponsorship by the YMCA, the Young Women's Christian Association (YWCA),
and the World's Student Christian Federation (WSCF). This gathering was
organized for August 1922 in Prerov, Czechoslovakia. The daily
celebration of the liturgy stood out as a highlight for many
participants, and Fr. Sergei Bulgakov played a highly influential
role.#footnote[Anderson#emph[, No East or West,] 37. See Ul'iana Gutner,
#emph[Russkoe studencheskoe khristianskoe dvizhenie: Istoki,
vozniknovenie i deiatel'nost' v 1923--1939 godakh] (Moscow: Izdatel'stvo
Sviato-Filaretovskogo Instituta, 2023).]

Students gathered for a similar conference in 1923, and the movement was
formally established as the Russian Student Christian Movement Abroad
with Prof. Vasily Zenkovsky from Kiev (Kyiv) as president. Three men
were invited to serve as secretaries for the movement, with the
sponsorship of the YMCA, YWCA, and WSCF: Lev Nikolaevich Liperovsky,
Alexander Ivanovich Nikitin, and Lev Nikolaevich Zander. Anderson
participated in RSCM developments and built many close friendships with
participants.#footnote[Anderson#emph[, No East or West,] 38. See Paul B.
Anderson, “Notes on the Development of Y.M.C.A. Work for Russians
Outside Russia, 1919--1939,” unpublished paper, 1940, PBAP. The
centennial of the Russian Student Christian Movement Abroad was marked
by a number of conferences in 2023: 1) An online event “The Russian
Student Christian Movement: A Case for Conciliarity from Below” was
hosted by the University of Tartu,~School of Theology and Religious
Studies, on March 21. 2) In Moscow the St. Filaret Institute and the
Aleksandr Solzhenitsyn House of Russian Abroad co-hosted a conference on
October 4--5: “The Russian Student Christian Movement: The Experience of
the Churchification of Life.” 3) The Russian Student Christian Movement
(Action Chrétienne des Étudiants Russes-Mouvement de Jeunesse Orthodoxe)
hosted a Paris symposium on the occasion of the centenary of ACER-MJO on
October 28--29 and November 1.] They adopted this specific formal
purpose statement:

#quote(block: true)[
The Russian Student Christian Movement abroad has as its fundamental
purpose the association of believing youth for the service of the
Orthodox Church and bringing unbelievers to faith in Christ. It seeks to
aid its members to work out a Christian view of life, and sets itself
the task of preparing defenders of the Church and faith, able to conduct
struggle with contemporary atheism and materialism.#footnote[Paul B.
Anderson, “North American Y.M.C.A., Russian Service in Europe,
Administrative Report for the Year 1936,” 9. Annual Reports 1933--49.
Russian Work -- Europe, Restricted, Budgets and Appropriations,
Correspondence and Reports, 1950--, Financial Transactions. KFYA.]
]

As Anderson observed the religious transformations within the movement,
he considered how to respond through the activities of the YMCA Russian
service publication program. He believed that books could help support
the intellectual and spiritual goals of the
movement.#footnote[Anderson#emph[, No East or West,] 38. For a
first-hand reflection of the 1923 RSCM conference in Prerov, see V.
Zen'kovskii, “Psherovskii s''ezd R. S. Kh. D. (1--7 oktiabria 1923),”
#emph[Russkaia mysl',] no. 2085, December 12, 1963, 5.] He asked
Vysheslavtsev, his closest advisor, what books might be appropriate to
present to an Orthodox young person to encourage his or her spiritual
development. He replied that saints' lives were a classic form of
edification, but they would need to be updated in style to meet the
current era. In response, they decided to invite the well-respected
novelist Boris Zaitsev to write a work of historical biography on the
life of Sergei of Radonezh, a national and spiritual hero to many. This
book was soon published, and it was well received in the community,
requiring three printings to meet demand. This book was directed at a
wide range of readers, and the second volume was directed at the
intellectual community. After a conversation, Anderson worked with
Berdyaev to publish a symposium, a collection of philosophical essays by
thinkers in his circle, #emph[Problems of the Russian Religious Mind,]
with contributions by Berdyaev, Bulgakov, Vysheslavtsev, Frank, and
Nikolai Arseniev. This was published in 1924 with the inscription “YMCA
Press,” and as Anderson explained, it

#quote(block: true)[
made an impression on the Russian reading public as showing that the
YMCA was not a Protestant proselytizing organization, but one which held
to the idea that its work must represent the indigenous thought and
aspirations of the Russian people. It set the tone for our program and
heralded the later production in Paris of practically all the great
theological and philosophical books produced by the writers at St.
Sergius Theological Institute. The YMCA had thus identified itself with
creative Orthodox doctrine. Our policy and motto became: “the
preservation and development of Russian Christian
culture.”#footnote[Anderson#emph[, No East or West,] 39--40. See E. V.
Ivanova, “Deiatel'nost' izdatel'stva ‘YMCA-Press' v Berline,”
#emph[Vestnik russkogo khristianskogo dvizheniia] 188:2 (2004):
334--63.]
]

As noted earlier, Anderson held a measure of sympathy for Julius Hecker,
but he did not express any approval of his former colleague's support of
the renovationist Living Church movement:

#quote(block: true)[
Some Western Protestant reformers, such as Julius Hecker and Methodist
Bishop Blake, declared that a new age had come to the Russian Church and
people. Thus they showed their lack of understanding of the inner
spiritual unity between the Orthodox faith and the soul of the Russian
people. After prospering outwardly for two decades, this reform movement
collapsed when anxieties and suffering brought on by the Second World
War demanded real spiritual relief and moral
support.#footnote[Anderson#emph[, No East or West,] 123. Anderson
provides his most direct critique of Hecker's published theological
views in Paul B. Anderson, “Religion and Communism,” #emph[Journal of
the Fellowship of St. Alban and St. Sergius] 1 (1934): 35--37.]
]

The Living Church was a diverse movement within the Russian Orthodox
Church from the 1920s into the 1940s. Most participants were open to
cooperating with the Soviet authorities and introducing reforms, such as
the use of the contemporary Russian language in the liturgy. Hecker
lived for several years in the USSR but came to Paris for a visit. He
contacted Anderson for a meeting and asked to meet with Berdyaev.
Anderson set up a meeting for the two men, and Hecker later reported
that they had a good conversation and “see pretty well eye to eye.”
Anderson then shared this comment with Berdyaev, who replied with a
“little twinkle,” “. . . I think there may be two points on which we
differ, one is our conception of God, and the other is our conception of
man.”#footnote[Anthony Polsky, interview with Paul B. Anderson, at his
home near Asheville, NC, March 21, 1980, 67 (PBAFP KFYA). For
information on Hecker's fate in the Soviet Union, see Alan Cullison,
“Stalin-Era Secret Police Documents Detail Arrest, Executions of
Americans,” #emph[Los Angeles Times,] November 9, 1997.
#link("https://www.latimes.com/archives/la-xpm-1997-nov-09-mn-51910-story.html")
(accessed October 4, 2023). For Berdyaev's published critique of
Hecker's views, see Nicolas Berdyaev, #emph[The Origin of Russian
Communism] (Ann Arbor: University of Michigan Press, 1960), 173--182.]

Anderson and other YMCA staff members did not regularly attend church services while in Berlin. He explained that the American congregation, which had operated in Berlin before the war, had not reopened, and the Anglican church did not have anyone in attendance when he visited. He did occasionally attend German-language services at the Evangelical (Lutheran) St.-Matthäus-Kirche near his residence on Kurfurstenstrasse.#footnote[Anderson, “No East or West,” 121.] Anderson enjoyed connecting with fellow believers in Berlin, even without the support of a congregation: “Our little YMCA group was a congenial one, and we three bachelors (the Troika) were glad to go on outings with American and Russian girls, especially Marjorie Mallory, Mary Bell, and Sophie Shidlovsky.”#footnote[Ibid.] Y staff members also received support from occasional conferences, such as a summer 1923 global gathering held in the resort town of Portschach in southern Austria. Representatives of 53 countries attended, with sessions addressing the significance, methods, and organization of Christian ministry among boys. Sherwood Eddy and Mott were plenary speakers, and Pianov spoke to the group about work among Russian boys.#footnote[“P. B. Anderson Tells of YMCA Meet,” #emph[Madrid Register-News] newspaper clipping, no author or date on clipping, \[1923\] (PBAFP KFYA). This article includes a printing of a June 24, 1923, letter from Paul B. Anderson to his parents about a recent conference.] 

In 1923, Anderson and Lowrie took a vacation trip to Jerusalem; they
visited Archibald Harte, a former supervisor of YMCA service to
prisoners of war in Petrograd, who at the time was serving as General
Secretary of the Jerusalem YMCA.#footnote[Paul B. Anderson, “A
Pilgrimage: The Pilgrimage of Donald A. Lowrie and Paul B. Anderson to
Jerusalem, 1923,” privately printed, 8. PBAFP KFYA.] On this trip they
visited key sites connected with biblical times. Anderson reflected
after viewing the location of the former temple and remembering the life
of Jesus: “How His heart throbbed with joy at the sight, and with sorrow
for the people whose hearts were hardened and would not believe that
their Messiah had come.”#footnote[Ibid., 12.] He reflected on the
presence of Judaism, Christianity, and Islam within the city, as well as
the interaction of Eastern Orthodox, Roman Catholic, and Armenian
confessions: “. . . we tried not to forget that our visit was spiritual
in purpose, and we especially prized those occasions which led us into
the religious life of the Holy City.”#footnote[Ibid., 14.] Anderson
commented on many of the different ethnic and national groups on his
visit, and he admitted that his observations were simply impressions
rather than informed perspectives. He expressed skepticism about the
recent rise in the Jewish population related to the Zionist movement and
the possibility of future economic and political success. He did not
comment on the reasons for the Zionist movement, such as widespread
European antisemitism.#footnote[Ibid., 21.]

Anderson noted at the end of his pilgrimage journal,

#quote(block: true)[
Tradition and the desire of pilgrims to see everything told of the
gospel stories have attached significance to many places which
manifestly are false. In recent years a number of competent
investigators have given serious study to this problem and by noting
their conclusions the visitor is spared many wrong impressions. We need
not believe, for instance, that our Lord walked the very streets which
he followed in Jerusalem; for excavations have showed that the streets
of that time lie often as much as twenty and thirty feet below the
present ground level of the city, which has been built upon the ruins
and debris of the many destructions which Jerusalem has suffered. On the
hills it is different, for they change less. Yet even in the city these
investigations are an aid rather than hindrance in appreciation of the
sanctity of the place.#footnote[Ibid., 44--45.]
]

Anderson referred to Lowrie and himself as “modern pilgrims,” seeking
light for their life and work.#footnote[Ibid., 46.]

#strong[Work in Paris, 1924--1940]

This section provides insights into Anderson's involvement with the YMCA
Press, Russian Student Christian Movement, and the Orthodox Theological
Institute in France; it also discusses his contributions to the careers
of prominent Christian scholars Berdyaev and Bulgakov. In the spring of
1924, the YMCA Russian Work programs moved its offices due to the
migration of many Berlin émigrés to Paris and industrial regions from
Lille to Grenoble. Anderson arrived in France on June 17, 1924, and he
estimated that 60,000 Russian refugees had settled in or near Paris. The
first office for the programs was located in St. Maur des Fosses, a
southeastern suburb of Paris.#footnote[Anderson#emph[, No East or West,]
\40. For information on the Russian émigré community, see Boris Raymond
and David R. Jones, #emph[The Russian Diaspora: 1917--1941] (Lanham, MD:
The Scarecrow Press, 2000); Iu. A. Poliakov, #emph[Istoriia rossiiskogo
zarubezh'ia: Problemy adaptatsii migrantov v xix-xx vekakh] (Moscow:
Institut Rossiiskoi Istorii, Rossiiskaia Akademiia Nauk, 1996); and W.
Chapin Huntington, #emph[The Homesick Million] (Boston: Stratford,
1933).] Vysheslavtsev supported the move of the office to France from
Germany, due to the larger number of Russian-language readers in Paris,
the greater number of potential authors, and lower printing
costs.#footnote[B. P. Vysheslavzeff letter to Paul B. Anderson, March
28, 1924, PBAFP KFYA. For discussion of the earlier development of
Russian Orthodoxy in France, see Heather L. Bailey, #emph[The Public
Image of Eastern Orthodoxy: France and Russia, 1848--1870] (Ithaca, NY:
Northern Illinois University Press, 2020).]

The year 1925 brought additional changes to Anderson's life with his
summer marriage to Margaret Holmes on July 8. Paul and Margaret served
as close and trusted partners throughout his career. For their
honeymoon, the couple traveled to Stockholm for the World Conference on
Christian Life and Work, an ecumenical conference that included
participation of many YMCA and denominational leaders. The Andersons set
up their home in Paris and hosted many guests from the Y and Russian
communities. Their children, Mary (born 1928) and Peter (born 1931), met
many from these groups during their childhood.#footnote[Paul Limbert,
“Paul B. Anderson: This is My Life,” Blue Ridge Assembly, October 4,
1983, 4 (PBAFP KFYA); Paul B. Anderson, proof entry for “Anderson, Paul
B.,” for #emph[Biographical Encyclopedia of the World], 1 (PBAFP KFYA).]
Paul and Margaret had known each other since 1919, when they met on a
family vacation at a Minnesota lake.#footnote[Limbert, “Paul B.
Anderson,” 4.] Margaret was born on January 24, 1900, to Ella Whiting
and Charles Guernsey Holmes in Whiting, Iowa, a town named for her
grandfather, Charles Edwin Whiting. She had three older brothers, Edwin,
Russell, and Whiting. Margaret graduated from Whiting High School in
1917 and attended Grinnell College for two years before transferring to
the University of Iowa in Iowa City. She graduated from the university
in 1921 with a major in music and a minor in French. She taught school
for two years in Whiting and then moved to Freeport, Illinois, where she
served as a YWCA secretary in “Girls Work.”#footnote[Mary Anderson
Glenn, “Notes on the Life of Margaret Holmes Anderson,” c. 1998;
“Anderson, Paul B. and Margaret, Biographical Data, January
1960--October 1975”; Biographical Records, Paul B. Anderson, Box 4
(KFYA).] As a child, Margaret enthusiastically participated in a
Congregational church with her family. She recalled, “On one occasion a
returned missionary from China came to speak to us. She made such a
great impression that I decided that I wanted to go to a foreign land
and be a missionary when I grew up.” After college and four years of
teaching and YWCA work, she married Paul and moved to
Paris.#footnote[Margaret H. Anderson, “Churches Around the World,”
November 1, 1977, 1. PBAFP KFYA.] In France, the Andersons moved from
St. Maur to Paris, where they rented an apartment at 5 rue Berite, about
a ten-minute walk from the future YMCA center at 10 Boulevard
Montparnasse. Their four-room apartment was on the fourth floor of a new
building, and they needed to buy furnishings for their new home, since
they had not brought many belongings from the US.#footnote[Paul B.
Anderson, “Personal Study at Oxford, English Notables” \[notes for “No
East or West”\], no date, 378 (PBAFP KFYA); Paul B. Anderson, “Russian
Work -- Policy Study,” November 23, 1943 (PBAFP KFYA).]

Anderson worked with two YMCA staff colleagues in Paris, Kullman and
MacNaughten. Kullman focused his work on the RSCM, which moved its
central office to Paris in 1925. By this year Paris had become the
center of Russia Abroad. Anderson focused his primary attention on
education and publishing, the Correspondence School, and the YMCA Press.
He was also responsible for administrative support of the work,
including financial and legal matters. By 1926, Anderson realized that
his administrative role demanded a central office in the city of Paris
rather than a suburb. This led to the rental of a 22-room house at 10
Boulevard Montparnasse, the building which became the hub of Y outreach
among Russians. During this year, MacNaughten was able to move to Paris
and take on new responsibilities for fundraising and programs for
boys.#footnote[Anderson#emph[, No East or West,] 41. Edgar MacNaughten
(1882--1933) served with the Y in Russia and Europe. Gustave Gerard
Kullmann (1894--1961) was the closest advisor to the Russian Student
Christian Movement in Europe.]

During the Paris years, Kullman worked with the RSCM as it developed its
intellectual and spiritual philosophy, rooted in the Russian Orthodox
heritage but emphasizing a spirit of personal freedom. Professors shared
lectures and writings with students, and Anderson worked to publish them
in order to distribute them to a wider audience. He wrote, “I was the
servant of all. The leaders and professors looked to me as a colleague
and friend.”#footnote[Anderson#emph[, No East or West,] 42--43.] The
RSCM expressed its philosophy as “the churchification of life,” the
application of Orthodox Christian teachings to every aspect of
culture.#footnote[Ibid.#emph[,] 46.]

Berdyaev also moved his Free Philosophical Academy to Paris in 1924, and
the Association welcomed it to use the building on Montparnasse.
Anderson asked Berdyaev to serve as chief editor for the YMCA Press,
Vysheslavtsev as editor, and Boris Mikhailovich Krutikov as business
manager. Anderson worked as director of the Correspondence School, and
he hired specialists to supervise instruction in a range of fields;
Alexandra Shidlovsky served as instructor for
English.#footnote[Ibid.#emph[,] 43.] The Correspondence School provided
an excellent program for those who needed vocational support, but it
could not provide the facilities required for the awarding of an
academic degree, which would be recognized by the French Ministry of
Education. A significant number of Russian professors and engineers with
prerevolutionary experience were now living in Paris and ready to
contribute to an evening technical school for young
émigrés.#footnote[Ibid.#emph[,] 45.]

The Russian Correspondence School of the North American YMCA opened in
Berlin in 1921 and transferred to Paris in 1924. The school began with
six subjects, and by 1931 the number of subjects increased to 173. The
number of students enrolled by 1931 was 1248. The total number of
participating students over ten years was 8894, who lived in sixty-one
countries. In 1931, a new program was announced: the Russian Superior
Technical Institute, a residential college-level educational program set
to operate at standards set by the French Ministry of Public Education.
At this time, the Russian Correspondence School was reorganized as the
Home Study Section of the Technical Institute. These programs were
widely recognized as a valuable contribution to the economic stability
of the emigration. The dean of the engineering faculty was Professor
Kozlovsky, who had previously served as dean of the Harbin Polytechnic
Institute. One hundred sixteen students enrolled for the first year of
the Russian Superior Technical Institute.#footnote[Paul B. Anderson,
“Ten Years of Service in Adjustment Education,” October 10, 1931, 1--2.
PBAFP KFYA.] During the interwar years, Anderson developed an
understanding of the political movements within the émigré
community---he established a wide network through his work with the
educational program. The programs were diverse and could be broadly
described as liberal, nationalist, or
monarchist.#footnote[Anderson#emph[, No East or West,] 44.]

As the activities of the Y and RSCM expanded from a base in Paris during
the 1920s, disagreements arose as to the relationship between the
partnering organizations. The International Committee of the YMCA was a
global and inter-confessional organization, while the RSCM was
intentionally Orthodox. How would they cooperate in the future? In 1927,
a meeting was held, and an “Agreement” was made that the RSCM would play
the leading role in work with Russian youth, with the exceptions of the
YMCA Press, Correspondence School, and Technical Institute, which would
continue as before. Anderson held this agreement as a guideline
throughout his career.#footnote[Ibid.#emph[,] 46.]

In the summer of 1926, Berdyaev presented a new idea as he met with
Anderson, Vysheslavtsev, and Kullman at a Paris café. He had been
energized by the philosophical, spiritual, and literary developments in
émigré Paris, which had roots in the pre-war conversations of St.
Petersburg, Moscow, and Kiev (Kyiv). He proposed the publication of a
new journal which would provide a platform for continuing discussions
about Russian cultural questions. Anderson understood that this project
would require financial investment and recalled that Mott had promised
funding for significant Russian projects. He quickly set up a meeting
between Berdyaev and Mott, who promised support for a new
interdisciplinary journal #emph[Put' (The Way),] which was published
regularly until the outbreak of World War II.#footnote[Ibid.#emph[,]
48--49.] The YMCA Press included #emph[Put'] as a key project within its
activities. Berdyaev was the only editor for the journal, but he
regularly discussed his plans with Anderson, Kullman, and Vysheslavtsev
at their weekly editorial meetings. Eventually, Lowrie replaced Kullman
on this committee.#footnote[Anderson#emph[, No East or West,] 49. For an
index to the articles in #emph[Put,'] see Boris Danilenko, #emph[Zerna
edinogo khleba: Ukazatel' statei i publikatsii zhurnala “Put'” (Parizh,
1925--1940)] (Moscow: Sinodal'naia Biblioteka Moskovskogo Patriarkhata,
Business Forms Company, 1998).] From 1925 to 1940, this journal provided
a cultural and intellectual meeting place for the thinkers of the
emigration and a connection point with Western conversation partners on
topics of theology, history, philosophy, and more. Antoine Arjakovsky's
masterful book #emph[The Way: Religious Thinkers of the Russian
Emigration in Paris and their Journal, 1925--1940] summarizes that “the
journal is one of the most brilliant in all Russian intellectual
history.”#footnote[Antoine Arjakovsky, #emph[The Way: Religious Thinkers
of the Russian Emigration in Paris and] #emph[Their Journal, 1925--1940]
(Notre Dame, IN: University of Notre Dame Press, 2013), 1.] He provides
a detailed study of the authors, audiences, themes, and debates of this
publication.

Berdyaev played a key role in the émigré community in developing
connections with French Catholics and Protestants. Berdyaev was a
dedicated Orthodox believer, but he believed that the church should not
live in isolation. He hosted regular gatherings at his home in the
suburb of Clamart, southwest of the center of Paris. The eminent French
Catholic philosopher Jacques Maritain and his wife were regular guests,
as well as the Swiss theologian Fritz Lieb. Berdyaev's wife Lydia
Yudiforovna was Catholic, and his family roots included members of the
French nobility. In addition, Berdyaev hosted secret weekly
interconfessional meetings at the YMCA Montparnasse meetings, which
included presentations and discussions by a small group of Catholic,
Orthodox, and Protestant theologians. Participants included Bulgakov and
Marc Boegner, a leading French Protestant theologian. These meetings
continued until they were forbidden by the local archdiocese, which
followed the strict guidelines of Pope Pius X.#footnote[Anderson#emph[,
No East or West,] 50.] Berdyaev was an aristocrat by birth but adopted
Marxist views as a young man before his intellectual journey in search
of freedom led him to Orthodox Christianity and a distinct career as a
philosopher. His wife Lydia was a revolutionary as a young woman and
participated in the events of 1905; later she became a devout Roman
Catholic. Lydia's mother also lived with them. Margaret Anderson and
Eugenie Rapp, Berdyaev's sister-in-law, developed a close
friendship.#footnote[Paul B. and Margaret H. Anderson, “N. A. Berdyaev
and His Household in Clamart,” no date, 1--5. PBAFP KFYA.] Berdyaev
became a well-known author in the English-speaking world after Anderson
introduced him to a representative of Sheed and Ward, the English
Catholic publishing house. This firm published his book #emph[The
Russian Revolution,] and his reputation grew.#footnote[Anderson#emph[,
No East or West,] 51.] In addition to Put', the YMCA Press published
#emph[Novyi grad (The New City)] (1934--1939) and #emph[Pravoslavnaia
mysl' (Orthodox Thought)] (1928--1954). #emph[Novyi grad], edited by G.
P. Fedotov, had more social-political content than #emph[Put'].
#emph[Pravoslavnaia mysl'] included articles written by professors at
the theological institute.#footnote[Paul B. Anderson, “A Brief History
of YMCA Press,” February 1972, 10. Corr. and Reports 1950--. Russian
Work, Restricted, Publications, YMCA Press in Paris. KFYA.]

The Press published a range of works during the interwar period, but the
core of its collection was books written by the faculty of the Orthodox
Theological Institute of Paris (Institut de Théologie Orthodoxe de
Paris), later known as the St. Sergius Theological Academy. On the
fifteenth anniversary of the school in 1940, Evlogii formally changed
the Russian (not the official French) title to St. Sergius Theological
Academy.#footnote[Donald A. Lowrie, #emph[Saint Sergius in Paris: The
Orthodox Theological Institute] (New York: Macmillan, 1951), 90,
19--20.] Anderson described this project as “one of our greatest
contributions to Russian religious culture.”#footnote[Anderson#emph[, No
East or West,] 51. See also Anton Arzhakovskii, “Sviato-Sergievskii
Pravoslavnyi Bogoslovskii Institut v Parizhe,” in #emph[Bogoslov,
filosof, myslitel': Iubileinye chteniia, posviashchennye 125--letiiu so
dnia rozhdeniia o. Sergiia Bulgakova (sentiabr' 1996 g., Moskva)]
(Moscow: Dom-muzei Mariny Tsvetaevoi, 1999).] These books provided a
theological foundation for a new era of Orthodox believers after the
closure of theological educational institutions in Soviet
Russia.#footnote[Anderson#emph[, No East or West,] 51.] The first
textbook published by the press was Georges Florovsky's #emph[Fathers of
the Fourth Century,] followed by his book #emph[Byzantine Fathers.]
Other members of the talented faculty continued this trend. In addition,
authors from around the Orthodox world submitted manuscripts for
consideration. Theology was a primary subject, along with philosophy,
memoirs, novels, and children's works.#footnote[Ibid.#emph[,] 52.] These
faculty members made significant contributions to the institute: Nikolay
Afanasiev, Sergei Sergeevich Bezobrazov (Bishop Kassian), Archimandrite
Cyprian (Kern), Paul Evdokimov, Anton Vladimirovich Kartashev,
Florovsky, Pyotr Kovalevsky, Mikhail Mikhailovich Ossorgine, Lev Zander,
and Vasily Zenkovsky.#footnote[Ibid.#emph[,] 58. For a brief
introduction to the history of the YMCA Press and a bibliography of its
publications, see A. L. Gurevich, #emph[Istoriia izdatel'stva
“YMCA-Press”] (Moscow: Kompaniia Sputnik+, 2004). For an index of the
books written by the faculty of the institute, along with the writings
of other émigré authors, see Nicolas Zernov, ed., #emph[Russian Émigré
Authors: A Biographical Index and Bibliography of their Works on
Theology, Religious Philosophy, Church History and Orthodox Culture,
1921--1972] (Boston: G. K. Hall, 1973). For discussion of the thought
and ecumenical involvement of Florovsky and Vladimir Lossky, see Ross
Joseph Sauve, “Georges V. Florovsky and Vladimir N. Lossky: An
Exploration, Comparison and Demonstration of their Unique Approaches to
the Neopatristic Synthesis” (Ph.D. diss., Durham University, 2010).]

Anderson expressed deep appreciation for Kartashev, who served as Assistant Procurator and then Procurator (after June 1917) of the Holy Synod during the period of the Provisional Government. Later, he served as professor of church history at the theological institute in Paris. Anderson described him as “one of the wisest and most level-headed of the Academy staff in reaching important decisions.”#footnote[Anderson, “No East or West,” 187--8.] The YMCA Press also began to publish the works of literary authors, such as Alexei Remizoff.#footnote[Anderson, proof entry, 3.] By 1939, the Press had published a total of 274 titles and gained the position as the primary publisher of philosophical and religious books in the Russian language.#footnote[“Paul B. Anderson,” #emph[The Christian Century] 102:25 (August 14--21, 1985): 730.]

Berdyaev himself stood out as a primary author for the early era of the
YMCA Press, editing sixty-one issues of #emph[Put'] before the
war.#footnote[Anderson#emph[, No East or West,] 53--54. For an
assessment of the support of the YMCA for Berdyaev and the influence of
Berdyaev on readers in the Soviet Union, including Aleksandr
Solzhenitsyn, see Donald E. Davis, “A Reassessment of N. A. Berdyaev,”
#emph[Cithara] 27 (1987): 41--56.] Lenin had exiled Berdyaev and one
hundred others in 1922.#footnote[Anderson#emph[, No East or West,] 55.
For discussion of the views and activities of these exiles and the
reasons for their expulsion, see Stuart Finkel, #emph[On the Ideological
Front: The Russian Intelligentsia and the Making of the Soviet]
#emph[Public Sphere] (New Haven, CT: Yale University Press, 2007) and
Lesley Chamberlain, #emph[The Philosophy Steamer: Lenin and the Exile of
the Intelligentsia] (London: Atlantic Books, 2006).] Berdyaev's works
presented an Orthodox worldview with an emphasis on creativity and
freedom.#footnote[Anderson#emph[, No East or West,] 55.] Here is
Anderson's explanation of Berdyaev's fundamental approach to humans:

#quote(block: true)[
All his life he had been struggling over the place of the individual in
creation, and he came to prefer speaking of the #emph[person]. By
#emph[person] he meant the individual enshrouded in all the attributes
resulting from having relationships with things and with other persons,
with happenings, with the world, and with God. Some writers have,
therefore, referred to Berdyaev's essential philosophy as “personalism.”
In all of the many contacts I had with him and his family, we always
felt we were dealing with one who was not just an individual in the
abstract but an essential part of God's
creation.#footnote[Anderson#emph[, No East or West,] 55. For two early
reviews of Berdyaev's life and work, see Donald A. Lowrie,
#emph[Rebellious Prophet: A Life of Nicolai Berdyaev] (New York: Harper,
1960) and Michel Alexander Vallon, #emph[An Apostle of Freedom: Life and
Teachings of Nicolas] #emph[Berdyaev] (New York: Philosophical Library,
1960). For a more recent reflection, see Lisa Radakovich Holsberg,
“Creative Act: Nikolai Berdyaev and the Spiritual and Intellectual World
of a Russian Philosopher in Exile, 1922--1948” (Ph.D. diss., Fordham
University, 2021).]
]

Bulgakov also stood out as a primary author for the early era of the
YMCA Press.#footnote[Anderson#emph[, No East or West,] 55.] Anderson
recognized his intellectual and political significance and the role he
played in the emigration: “The combination of his remarkable
intellectual and spiritual gifts with his completely Russian attachment
to Church and people made him a natural leader among people of the
Russian religious renaissance in Paris, and in the West, generally. He
was the Father Confessor for many.”#footnote[Anderson#emph[, No East or
West,] 56. See Catherine Evtuhov, #emph[The Cross and the Sickle: Sergei
Bulgakov and the Fate of Russian Religious Philosophy] (Ithaca, NY:
Cornell University Press, 1997); Robert Bird, “In Partibus Infidelium:
Sergius Bulgakov and the YMCA (1906--1940),” #emph[Symposion] 1 (1996):
93--121; and Robert Bird, “YMCA i sud'by russkoi religioznoi mysli
(1906--1947),” in #emph[Issledovaniia po istorii] #emph[russkoi mysli:
Ezhegodnik za 2000,] ed. M. A. Korelov (Moscow: OGI, 2000), 165--223.]
Anderson worked with Bulgakov within the context of publishing his works
with the YMCA Press and within the ecumenical movement. Bulgakov
actively participated in the Anglo-Russian student conferences and the
Anglican-Orthodox partnerships which followed. Anderson explained,

#quote(block: true)[
At first he was quite stiff in his position, adhering strictly to the
traditional Orthodox claims to uniqueness and superiority, but in these
meetings he came to realize and appreciate the authentic quality of
Anglican personal and congregational piety and to lend his voice in
favor of the movement towards sacramental unity. The same position
characterized his present participation in the meetings which formed the
ecumenical prelude to the World Council of
Churches.#footnote[Anderson#emph[, No East or West,] 57.]
]

Anderson also witnessed the sorrow Bulgakov felt when receiving sharp
criticism from more traditional Orthodox leaders for his views on
Sophia, the wisdom of God. Bulgakov expressed innovative views of Sophia
as an attempt to explain the connections of the divine and the human in
the world; he experienced “great spiritual agony.”#footnote[Ibid.]
Bulgakov made a deep impression on this American's understanding of the
tradition: “I personally gained greatly from reading his manuscripts and
from many conversations in private. My comprehension of Orthodoxy as a
Church of infinite worth grew in this way, reaching high above
controversies within its ranks on both small and great
topics.”#footnote[Ibid.#emph[,] 58.]

Years later, author Aleksandr Solzhenitsyn reflected on the contribution
of the YMCA Press:

#quote(block: true)[
The Russian YMCA-Press had had a glorious history within the Russian
diaspora. In the decades when Communism's triumph in the USSR seemed
limitless, with every glimmer of light extinguished and stamped out
forever, YMCA-Press had conserved, carried on, and even strengthened
that light, emanating from the religious renaissance at the beginning of
the century, from #emph[Vekhi,] by bringing out in small editions our
foremost thinkers who had managed to survive: a Russian distillation of
philosophical, theological, and aesthetic thought.#footnote[Aleksandr I.
Solzhenitsyn, #emph[Between Two Millstones,] Book 1: #emph[Sketches of
Exile, 1974--1978] (Notre Dame, IN: University of Notre Dame Press,
2018), 94.]
]

Scholar Kåre Johan Mjør demonstrated the contribution of the YMCA Press
to the cultural and intellectual historiography of Russia through his
analysis of four works written by members of the émigré community of
Paris and published by the Press: #emph[Saints of Ancient Russia] by
Georgy Fedotov (1931), #emph[Ways of Russian Theology] by Florovsky
(1937), #emph[The Russian Idea] by Berdyaev (1946), and #emph[The
History of Russian Philosophy] by Zenkovsky (1948--50).#footnote[Kåre
Johan Mjør, #emph[Reformulating Russia: The Cultural and Intellectual
Historiography of Russian First-Wave Émigré Writers] (Leiden: Brill,
2011).]

After his arrival in Paris, Anderson became acquainted with a number of
Russian émigré booksellers. They represented a wide range of cultural
and political backgrounds and sold books for a variety of audiences. A
lack of professional cooperation hindered the progress of all firms.
Anderson was invited to conversations that led to the formation of a
trade association, United Publishers #emph[\(Les Editeurs Reunis)],
which fostered cooperation and increased the chance of mutual benefit.
He relied on the experience of his business manager, Boris Mikhailovich
Krutikov, and was elected as president of the new
corporation.#footnote[Anderson#emph[, No East or West,] 60.]

In 1926 Anderson and the YMCA were drawn into a conflict due to the
expansion of the RSCM. The synod of Orthodox bishops based in Sremski
Karlovci in Serbia argued that students of the RSCM should submit to its
authority, rather than the authority of Evlogii, which they did not
recognize. Here is Anderson's analysis of the conflict:

#quote(block: true)[
The Russian emigre bishops in Serbia resented any initiative or activity
which seemed to diminish their episcopal standing and authority. They
felt that the RSCM was doing just that, and they blamed the YMCA for
leading earnest young Orthodox down the garden path to their personal
peril and to the destruction of the Russian Orthodox Church as it had
been in Russia.#footnote[Anderson#emph[, No East or West,] 61--62.]
]

The Orthodox Theological Institute was a fully Russian organization, but
Anderson, Mott, and the Y played key roles during its formation. Mott
first discussed the idea for a theological institution with Lev
Liperovsky, Lev Zander, and Alexander Nikitin at a 1922 meeting of the
World Student Christian Federation. In 1923 Mott met with Russian
theologians at a meeting hosted by the National Office of the
Czechoslovak YMCA, with Anderson and Lowrie in attendance. In July 1924,
Evlogii learned that Mott would be in Paris, so he invited Mott,
Kullman, and Anderson to meet and discuss the possibility of purchasing
a property. Mott pledged five thousand dollars for a down payment, and
the next day Anderson and others inspected and approved the property.
The progress led to the formation of the Institute, with a building,
faculty, and organizational committee.#footnote[Ibid.#emph[,] 63.]
Anderson served on the organizational committee, along with Rev. Canon
John Douglas, Foreign Relations Counselor of the Archbishop of
Canterbury. From the beginning, Anderson played a key financial and
administrative role: “The Metropolitan and the staff at the Institute
came to depend on my counsel.” He actively supported the fundraising for
the institute and RSCM with donors from the Church of England, the
Episcopal Church of the US, and churches in Sweden, Switzerland, and the
Netherlands.#footnote[Ibid.#emph[,] 64.]

The establishment of the Orthodox Theological Institute and RSCM led to
increased conversations among students and professors and their Anglican
counterparts. The British Student Christian Movement and a number of
leaders of the Church of England became involved.#footnote[Ibid.#emph[,]
\65.] There had been a long history of interest in Anglican-Orthodox
relations, and these conversations began a new stage of this story;
Cosmo Lang, Archbishop of Canterbury, participated. Anglo-Russian
student conferences in 1928 and 1929 led to the formation of the
Fellowship of St. Alban and St. Sergius.#footnote[Ibid.#emph[,] 67; see
Paul B. Anderson, “The Fellowship of St. Alban and St. Sergius,”
#emph[The Christian East] 13 (1932): 2--7.]

Anderson played a role in supporting Nicholas Zernov, a key participant
in Orthodox-Anglican relations. He joined with John Douglas of the
Church of England and Robert Mackie of the British Student Christian
Movement in providing sponsorship for Zernov to study at the University
of Oxford on the history and thought of the early church fathers and the
ecumenical councils. This was supported with the goal of preparing this
young émigré to provide future guidance for the Fellowship of St. Alban
and St. Sergius. He pursued his studies with enthusiasm and earned a
Ph.D. degree before his appointment as the Spalding Lecturer on Eastern
Orthodox Culture at Oxford.#footnote[Anderson#emph[, No East or West,]
67--68.] Years later Zernov described his appreciation for the work of
American YMCA leaders, specifically MacNaughten, Anderson, and Kullman:

#quote(block: true)[
Their experience and benevolence were very valuable for the Movement.
With them we immediately developed a relationship of full trust and
friendship. Although financial assistance from foreigners passed through
their hands they never behaved as a boss. On the contrary, they were
attracted to Orthodoxy and Russian culture, they spoke Russian well, and
identified themselves completely with the Movement. Each of them were
specialists in their own sphere of work.#footnote[N. M. and M. V.
Zernov, eds#emph[.], #emph[Za rubezhom: Belgrad-Parizh-Oksford (Khronika
sem'i Zernovykh)] (Paris: YMCA Press, 1973), 144.]
]

Since Anderson was focused on the YMCA Press and Correspondence School, MacNaughten took on the primary responsibility for raising funds for the theological institute, which was funded primarily from the US and England during its early years. MacNaughten and Kullman traveled to the US in 1927 to raise funds. MacNaughten approached the Episcopal Church Center for a grant from the Bishop White Memorial Fund to buy books for the institute's library. Florovsky was able to build up the library by making purchases of patristic literature from Russian émigré libraries, using resources provided by this Fund. Kullman worked with Henry Knox Sherrill, Bishop of Massachusetts, to make contacts among Episcopalians in Boston. Kullman met Ralph Adams Cram and his wife, who formed a Committee for Aid to the Paris Institute, which served as the most significant source of US revenue for many years. Cram was the chief architect for New York's Cathedral of St. John the Divine. Another committee was formed in New York with participation by William T. Manning, Bishop of New York, Frank Gavin, professor at General Theological Seminary, James DeWitt Perry, Presiding Bishop, and Reginald Belknap, treasurer of General Theological Seminary. In western New York, Lauriston L. Scaife chaired the National Episcopalian Committee for Institute support. During this period, three RSCM leaders visited the Boston and New York committees to provide personal accounts on the value of the institute: Zenkovsky, Shidlovsky, and Liperovsky.#footnote[Anderson, “No East or West,” 157--8.] 

During the 1920s and 30s, Anderson was promoting outreach among the
émigré community, but he was also researching the Soviet government's
promotion of an anti-religious campaign and promotion of atheism. The
Church of England was following these developments with alarm, and
leaders organized the RCAF (Russian Churches and Clergy Aid Fund). The
Archbishop of Canterbury and John Douglas invited Anderson to a meeting
at Lambeth Palace for RCAF and other leaders. These leaders learned of
his efforts in Paris to collect information from the USSR on the
conditions and challenges of religious organizations and believers; he
had been distributing monthly bulletins with this information. He
provided updates on Soviet conditions to this group at Lambeth Palace
and developed a range of connections within the Anglican communion with
those sharing an interest in ecumenical progress and support for
persecuted Christians. His new contacts included Sir Bernard Pares, head
of the School of Slavonic Studies at the University of London, and R. M.
French, secretary of the Anglican and Eastern Churches Association. On
the continent, Anderson's new like-minded colleagues included Adolph
Keller in Zurich, Dutch pastor F. Krop, and French Reformed theologian
Marc Boegner. This group met in Basel, Switzerland, along with Anderson
and Bulgakov.#footnote[Ibid.#emph[,] 70--71.]

Anderson provided information to many of these concerned colleagues
within a “Study on Religion in Russia” group through a series of mailed
bulletins. Tudor Pole of RCAF proposed that he lead an effort to produce
a regular series of printed pamphlets on this topic. He worked with
volunteers such as RSCM secretary Ivan Lagovsky to create these
pamphlets, which included translations of articles and documents from
the Soviet Union. Ten pamphlets were created over the years, with 500
copies printed in Paris and distributed by Pole. Anderson's effort led
to another request from Bernard Pares at the University of London to
create a quarterly “Chronicle on Soviet Russia” to be published in the
#emph[Slavonic and East European Review.] This feature appeared
regularly until the outbreak of World War II. These projects created a
demand on Anderson's time, but he saw it as an opportunity as well: “All
of this was excellent research into the nature and purpose of the
anti-religious movement as well as the vestiges of real religion somehow
portrayed in Soviet material.”#footnote[Ibid.#emph[,] 72. See Natalia
Pashkeeva, “Building an Informal Transnational Information Network on
the USSR from Paris: An Outside Perspective on Soviet Life in
1923--1939,” #emph[Laboratorium: Russian] #emph[Review of Social
Research] 16(2) (2024): 57--94. DOI:
10.25285/2078--1938--2024--16--2--57--94.]

By the 1930s the Y center at 10 Boulevard Montparnasse had become a
vibrant center for the activities of the YMCA Press, the Correspondence
School, the RSCM, and other programs. However, it gradually became a
center for activities that grew organically from within the émigré
community. As Anderson observed, it became a

#quote(block: true)[
center for all kinds of activities---intellectual, spiritual,
physical---for Russian refugees in Paris. Theologians, engineers, book
dealers, boys' clubs, student circles, volleyball games, and soon even
hungry destitute men and women filled the place from morning to night.
The combination represented an earnest attempt to discover and meet the
needs of a special constituency. Apart from the Correspondence School
and the Press, all the rest was a spontaneous response of young people
and their senior compatriots to express their sense of fellowship with
one another and with the needy outside.#footnote[Anderson#emph[, No East
or West,] 73.]
]

Anderson was pleased to observe the many forms of social outreach that
emerged in this community during the era of the economic depression of
the 1930s. Perhaps the most outstanding movement was led by Elizaveta
Yurievna Skobtsova (Mother Maria). Her early life in Russia was shaped
by revolutionary politics, but in Paris her life was deeply influenced
by the RSCM, Berdyaev, and the faculty of the theological institute. She
dedicated her life to serving those in need and became a nun under the
authority of Evlogii. Her efforts led to the formation of Orthodox
Action and programs to provide food and shelter to those in need in
Paris. Mother Maria's bold calls to action were matched by her
impressive organizational abilities. She brought in active participation
from RSCM leaders, such as Fyodor Pianov and Dmitry
Klepinin.#footnote[Ibid.#emph[,] 74--76.] During this era of expansion,
the Movement decided to establish its own center at another facility in
Paris at 91 rue Olivier de Serre. Alexander Nikitin provided leadership
for this transition, with financial support from the WSCF and ecumenical
sponsors.#footnote[Ibid.#emph[,] 77.]

It is interesting that Anderson showed openness to Metropolitan Antony
Khrapovitsky after the criticism the hierarch had expressed against the
RSCM and YMCA. In his memoir he wrote,

#quote(block: true)[
Archbishop Anthony and Sergei Bulgakov, men with contradictory
conceptions of churchmanship, and their respective followers, carried
abroad and into the non-Orthodox world the two main currents of
Orthodoxy which the atheist movement fought against: the spiritual power
in the church sacraments and the proven verity of an intellectual grasp
of the doctrines inherited from the Apostles and Fathers of the
Church.#footnote[Ibid.#emph[,] 124.]
]

He later reflected on this experience in the midst of the conflict of
the Russian Orthodox émigré world:

#quote(block: true)[
MacNaughten, Kullmann, Lowrie, and I had all come to feel ourselves
truly at worship when attending Orthodox services. We were convinced
about the preeminent role which the Orthodox Church should have in
Russia. Lowrie and I also had good relations with some of the Belgrad
bishops as well as the President of its Synod, Metropolitan Anthony
Khrapovitsky, a famous person in prerevolutionary Russia, who had come
to tea with my wife Margaret and me in our St. Maur home, and as long as
he lived I went to call on him in Belgrad or Sremsky Karlovo every time
I visited Yugoslavia. It would have been very hard not only for the
Movement but for the Theological Institute in Paris if the Synod of
Bishops had been chosen to control these institutions instead of the
benevolent and wise Metropolitan Evlogy and his successors. After all,
Evlogy was himself a famous Russian patriot having been both a ruling
bishop and a member of the Duma where he represented not only the Church
but also the mind of the faithful laity of his constituency. If the
Synod of Bishops had gained control over the Movement and the
Theological Institute in Paris, could we have worked together over the
many years?#footnote[Anderson, “No East or West,” 153. See Donald A.
Lowrie, #emph[The Light of Russia: An Introduction to the Russian
Church] (Prague: YMCA Press, 1923).]
]

Anderson later concluded, 

The so-called “Montparnasse years” was, indeed, a very rich time in every sense of the word---intellectually, culturally, socially, theologically. It marked the blossoming of a spectacular religious renaissance in the Russian immigration that the YMCA was privileged to serve. How thankful I am to have been a part of it. By the middle of the 1930s, it had reached its maturity and other problems and questions sapped its creative energies. These problems, profoundly affecting Europe itself, helped to disintegrate the interwar emigration.#footnote[Anderson, “No East or West,” 188--9.] 
 
Anderson began his participation in the ecumenical movement as a representative of the YMCA, which was a Christian organization, not a church. He compared his agency to other historical missionary societies, which were ecumenical, because they included staff members from a variety of churches. As he explained, “They were fully ecumenical in the sense of inclusiveness, although we use the word in most cases as referring to bodies which have the marks of Christian churches.” He pointed out that the Student Volunteer Movement and World Student Christian Federation also served as ecumenical organizations. The Student Volunteer Movement sent out 20,500 enrolled members to work as global missionaries. Anderson observed the ecumenical approach of the YMCA in China: Association speakers gathered large crowds to present the Christian faith and recommended that those who wanted to learn more should attend the church closest to their home. This avoided “narrow denominationalism.”#footnote[Ibid., 203--4.] 

The Orthodox Theological Institute later awarded Anderson an honorary
doctoral degree. As his colleague summarized, “through the YMCA Press
and related undertakings in Paris you were able to take a leading part
in bringing new hope and intellectual vigor to thousands of Russians
displaced from their home country.”#footnote[Limbert, “Paul B.
Anderson,” 4.]

On July 15, 1928, Paul and Margaret sailed from Le Havre, France, to New
York for a scheduled furlough. They traveled to Whiting, Iowa, where
they stayed with Margaret's parents. She was expecting their first
child, and Paul traveled within Iowa for YMCA speaking assignments. They
rented a furnished apartment in Des Moines, and their daughter Mary was
born on November 20 at the Swedish Hospital in the city. During the
following months, the young family visited Paul's parents and relatives.
In March they traveled to New York for meetings with International
Committee executives related to the Russian work and with the Episcopal
Committee on Aid to the St. Sergius Academy in Paris. On March 15, they
returned to Paris. Later that spring Paul attended the Anglo-Russian
Student Conference (later renamed the Fellowship of St. Alban and St.
Sergius). There Paul became acquainted with the Principal George Francis
Graham-Brown of Wycliffe Hall, an Anglican theological college at
Oxford. Anderson shared his interest in studying Orthodoxy, and the
principal invited him to attend for the Michaelmas term
(October-December) 1929. The principal also said that he would find a
house for Paul and Margaret and help him register for non-credit
classes.#footnote[Anderson, “Personal Study at Oxford,” 379.]

In October 1929, Paul and Margaret Anderson arrived in Oxford to begin a
term of study at Wycliffe Hall. Paul was classified as a non-resident
member and his focus was early church history: “This period in Church
history has long attracted me, but closer acquaintance with it has
become essential in connection with our Russian work, for the Russian
Orthodox ideal of the Christian life is still as in the early Church,
that of the ascetic, the searcher after God.”#footnote[Paul B. Anderson
in Oxford letter to “Friends Who have been Interested in our Doings,”
December 20, 1929, 1. PBAFP KFYA.] In his letter to friends, he wrote
about his study of early Christian writers, such as Anthony and Basil,
who wrote about their physical and moral struggles for holiness. He also
explained his belief that “When Constantine made Christianity the
officially approved religion, the Christian life became too easy, and
this tradition has lasted, with notable exceptions, until this day. . .
. it is in the early Church that we find the positive, the practical
process of being Christian by trying hard to keep Christ
foremost.”#footnote[Anderson, “Friends,” 5.] Anderson's reading program
included the Apostolic Fathers, the early ascetics of the Egyptian
desert, and the Cappadocian Fathers (especially the monastic
instructions of St. Basil). He attended lectures and wrote that those by
Dr. Kenneth Kirk (later Bishop of Oxford) were especially helpful. He
met regularly with a tutor, a fellow of Merton College, who discussed
his readings. Margaret attended lectures on medieval European
history.#footnote[Anderson, “Personal Study at Oxford,” 379.] The
Andersons enjoyed conversations with students and attending Anglican
services during their time in Oxford. Before returning to Paris, they
were invited to visit the home of Bishop Walter Frere of Truro in
Cornwall, whom they had earlier met at an Anglo-Russian student
conference. The bishop was a member of the Community of the
Resurrection, an Anglican monastic order, and he invited the Andersons
to attend services for a day. Paul wrote, “It warmed our hearts and
stirred our souls.”#footnote[Ibid., 380.]

Anderson deeply valued the opportunity to study in Oxford and described
it as “one of the richest experiences of our lives.” His readings on
church history provided information that he had not received in his
previous education; his study also provided guidance for his work in
publishing books on Orthodox Christian culture. He expressed regret that
he did not have additional time to focus on studying Russian Christian
works of the 19#super[th] and early 20#super[th] centuries:

#quote(block: true)[
To this day I have found myself handicapped in student Movement circles,
in our Press editorial weekly meetings, and in the meetings and
discussions of the Ecumenical Movement, by lack of systematic
preparation in theology and philosophy as revealed in Russian writers.
To be sure, just reading the manuscripts which kept arriving at my desk
was helpful, but the fact is that this tended to open up doors calling
for more background reading which in the nature of my work I could not
undertake.#footnote[Ibid., 381.]
]

In Paris, the Andersons became very active at a church of the Anglican
Communion, the American Pro-Cathedral Church of the Holy Trinity, at 23
Avenue George V. Paul later served as a member of the vestry (parish
leadership council), and Margaret contributed to the church's Sunday
school program.#footnote[Letter from minister at the American
Pro-Cathedral Church of the Holy Trinity to Margaret Anderson, November
14, 1937. PBAFP KFYA. See American Cathedral in Paris,
#link("https://amcathparis.com") (accessed November 3, 2023).]

Anderson continued to travel to other countries in Europe to connect
with émigrés. For example, in 1930 and 1931, he traveled to Estonia and
Latvia, reported his observations on cultural and religious trends, and
described YMCA current programs. He noted that these countries had
become more integrated into central and western European economic life
and far less connected to the USSR. The Orthodox churches in Estonia and
Latvia maintained fraternal connections with the Russian church
hierarchy but did not submit to its authority: they had their own
archbishops and synods. Anderson wrote that the churches of Estonia were
approximately two-thirds Estonian by ethnicity and one-third Russian. In
Latvia, the Orthodox churches were two-thirds Russian by ethnicity and
one-third Latvian. The Russian minorities of Estonia and Latvia
maintained Russian-language schools, newspapers, and cultural
organizations. He counted fifty-seven Russian organizations in
Riga.#footnote[Paul B. Anderson, “Report on Visit to the Baltics, Dec.
17, 1933 -- Jan. 14, 1934,” 1--2. PBAFP KFYA.]

In Latvia, the partner of the RSCM was the Russian Orthodox Student
Union, which operated programs for students, boys, and girls with a
rented facility; one paid secretary served this work. Many ethnic
Russians also participated in Latvian YMCA programs. In addition, the
Russian Correspondence School supported an active student club in Riga
with twenty-five men and women participating. Anderson knew that
organizations had not been cooperating at a maximum level, so he held a
meeting on January 10, 1934, for representatives of the Russian Orthodox
Student Union, the Riga YMCA, and the Correspondence School club to
discuss cooperation and increased connection to the
churches.#footnote[Anderson, “Report on Visit,” 2--3.]

In Estonia, the RSCM, YMCA Press, and Russian Correspondence School
connected with participants in five locations: Tallinn (Reval), Narva,
Tartu (Dorpat), Petseri, and Valk. Anderson led discussions during his
trip with the goal of increasing understanding and cooperation with
churches. Plans were made for a visit by Berdyaev in March 1934. He was
encouraged to see that meetings of Orthodox students from the RSCM and
Lutheran students from the Latvian and Estonian student movements were
continuing.#footnote[Ibid., 4--9.]

Due to the Great Depression, the YMCA wrestled with economic challenges
along with many other organizations. The New York office of the
Association (Foreign Committee of the National Councils of the YMCA),
which paid Anderson's salary, was required to reduce his total salary by
ten percent for 1932. His total salary had been set at \$3750, so the
reduction was \$375 for the year.#footnote[Frank Slack letter to Paul B.
Anderson, December 7, 1931, 2--3. PBAFP KFYA.] He and his colleagues
faced difficulties with their projects as well due to funding
reductions; this led to an end of the lease on 10 Boulevard Montparnasse
on September 30, 1936.#footnote[Donald E. Davis, “The American YMCA and
the Russian Emigration,” #emph[Sobornost] 9 (1987): 35.]

Anderson was clearly motivated by a desire to serve others, rather than
by a search for advancement or wealth. He must have been encouraged by a
personal letter he received from Bulgakov on March 18, 1939:

#quote(block: true)[
To you, with whom I was given the opportunity to work in peace and
harmony for more than ten years, as a kind of guardian angel of the
Russian exile, called from a distant land and a foreign people, I would
like to say, in the name of the Russian Church and Russian culture and
Russian people, a sincere thank you.#footnote[E. V. Ivanova,
“Angel-khranitel' russkogo izgnaniia: Pol Anderson i o. Sergii Bulgakov.
K istorii vzaimootnoshenii,” in #emph[S. N. Bulgakov:
Religiozno--filosofskii put'.] Mezhdunarodnaia nauchnaia konferentsiia,
posviashchennaia 130--letiiu so dnia rozhdeniia 5--7 marta 2001 g., ed.
A. P. Kozyrev (Moscow: Russkii put', 2003), 115.]
]

A few years later, Bulgakov's gratitude was echoed by Evlogii in his
1947 memoir:

#quote(block: true)[
We \[the RSCM\] utilized the material support of this organization \[the
American YMCA\], which was wealthy and friendly to us. The YMCA, it is
true, helped us and helps us, but we remained faithful to our ideology,
which lay at the foundation of our association, and always emphasized
our inner independence, which did not prevent us from maintaining the
best relationships with our friends. At the head of the YMCA in the
first years of the emigration were E. I. MacNaughten, P. F. Anderson, G.
G. Kullman, leaders of broad views and considerate relationships to our
ideology. They supported us, never using philanthropy as a means for
propaganda of their doctrine among Russians.#footnote[Metropolit Evlogy,
#emph[Put' moei zhizni: Vospominaniia Metropolita Evlogiia,]
izlozhennyie po ego razskazam T. Manukhinoi (Paris: YMCA Press, 1947),
\535.]
]

The period of World War II led to the end of this remarkable period of
cooperation and service. Bulgakov passed away in 1944, and Berdyaev
followed in 1948. During the war, Anderson played a leading role in
coordinating aid from the United States for Russian émigrés, prisoners
of war, and other refugees in France. He continued serving in Paris
during the Nazi occupation until he was required to leave the city on
June 20, 1941.

<end-of-miller>
