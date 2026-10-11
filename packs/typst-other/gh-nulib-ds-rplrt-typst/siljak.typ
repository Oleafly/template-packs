#import "elements.typ": *
#counter(footnote).update(0)
#abstract(
  [The Hidden Russia in Western Philosophy
],
  abstract-subtitle: [An Outline for Future Research],
  abstract-author: [Ana Siljak],
  [],
)

// This section sets the headers for the article
#set page(
  header-ascent: 40%,
  header: context {
    set text(8pt, font: "IBM Plex Sans", stretch: 75%, weight: 400)
    let first-page = locate(<first-page-article-siljak>).page()
    if here().page() == first-page [
      #grid(
        columns: (45%, 45%),
        gutter: 10%,
        align(left)[NORTHWESTERN UNIVERSITY STUDIES IN RUSSIAN\ PHILOSOPHY, LITERATURE, AND RELIGIOUS THOUGHT
        ],
        align(right)[
          Volume 2 (2025): #first-page#sym.dash.en#locate(<end-of-article-siljak>).page() \
          10.71521/0000
        ]
      )
    ] else if calc.even(here().page()) [
      #set align(center)
      #set text(font: "IBM Plex Sans", size: 11pt, weight: 600)
      #upper([Ana Siljak])
    ] else [
      #set align(center)
      #set text(font: "IBM Plex Sans", size: 11pt, weight: 300, tracking: .1em)
  #upper([_The Hidden Russia in Western Philosophy_])
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

#heading(level: 2)[The Hidden Russia \ in Western Philosophy]
<first-page-article-siljak>
#v(1em)
#subtitle([An Outline for Future Research])

#v(1em)
#author[Ana Siljak]

In 1950, Isaiah Berlin gave one of the most concise but eloquent
descriptions of the divide that still continues to separate the fields
of analytical and continental philosophy:

#quote(block: true)[
the great chasm between, on the one hand, the clear, dry world of
Anglo-American … empiricism, … and, on the other, the darker and more
personally anguished world of French and German religious or aesthetic
or political metaphysics, was never deeper or more unbridgeable. Neither
side recognised merit in the other, and no interpreters appeared to
explain these apparently disparate activities to the other
camp.#footnote[Isaiah Berlin, #emph[Three Years: Cultural Politics in
the Mid Twentieth Century], Isaiah Berlin Online,
https:\/\/isaiah-berlin.wolf.ox.ac.uk/ (Bib. 292), 38--39. For the
purposes of this essay, I am mostly confining myself to a discussion of
English-language scholarly literature.]
]

With a simple replacement of a few terms, this could describe the gulf
that presently exists between Russianists and scholars of Western
intellectual history. Russianists, on the one hand, contend with the
“darker and more personally anguished” world of Russian ideas, often
completely foreign to those who study the much clearer and drier world
of Western thought. Russianists have little cause to consider, in depth,
the works of Thomas Aquinas, John Locke, or Alexis de Tocqueville; and
Western intellectual historians have often never even heard the names of
Vladimir Soloviev, Sergei Bulgakov, or Lev Shestov. Concepts such as
materialism, nihilism, rights, dignity, toleration, freedom, and even
liberalism and socialism have, as it were, two separate histories---one
that extends back through European history and the other that, if it has
a lineage at all, traces into the Russian past. And interpreters between
the two worlds are few and far between.#footnote[A good example of this
is the case of this is Samuel Moyn's history of human rights, #emph[The
Last Utopia: Human Rights in History], which only briefly mentions the
Russian influence on human rights, via Nikolai Berdyaev. The Russian
history of human rights, on the other hand, is detailed in Ferdinand
Feldbrugge, “Human Rights in Russian Legal History,” in #emph[Human
Rights in Russia and Eastern Europe]: #emph[Essays in Honor of Ger P.
van den Berg], ed. Ferdinand J. M. Feldbrugge and William B. Simons
(Leiden, The Netherlands: Brill, 2021), 65--90. Similarly, compendia on
concepts such as “secularism” or “toleration,” and general histories of
“liberalism,” rarely include Russian considerations of these terms.
Charles Taylor's #emph[A] #emph[Secular Age] (Cambridge, MA: Harvard
University Press, 2007) and Craig Calhoun, Mark Juergensmeyer, and
Jonathan VanAntwerpen's #emph[Rethinking Secularism] (Oxford: Oxford
University Press, 2011) contain no mention of Russia, while Catherine
Wanner's #emph[State Secularism and Lived Religion in Soviet Russia and
Ukraine] (Washington, D.C.: Woodrow Wilson Center Press, 2012) and my
#emph[Religion and Secular Modernity in Russian Christianity, Judaism,
and Atheism] (Ithaca: Cornell University Press, 2024) look at the
concept from an exclusively Russian perspective.]

The divide should not be exaggerated, of course. Following in the
tradition of the great intellectual historians such as Andrzej Walicki,
many scholars have carefully traced the undeniable and pervasive impact
of Western philosophers on Russia. Thanks to them, we understand the
influence of the Enlightenment, Romanticism, German Idealism, and French
socialism on Russian thought. In many ways, intellectual historians in
the Russian field are obliged to consider, at least in passing, Immanuel
Kant and Friedrich Nietzsche, and comprehensive histories such as Franco
Venturi's #emph[Roots of Revolution] are filled with casual references
to Jean Jacques Rousseau, Charles Fourier, and, of course, Karl Marx.
The reception of Sigmund Freud, John Stuart Mill, and Joseph de Maistre
in Russia has been at least considered, if only
briefly.#footnote[Andrzej Walicki, #emph[The Slavophile Controversy]
(Oxford: Oxford University Press, 1975); Franco Venturi, #emph[Roots of
Revolution] (London: Phoenix Press, 1972); Kant and neo-Kantianism in
Russia have been looked at in depth, see, for example, Thomas Nemeth,
#emph[Kant in Imperial Russia] (Cham: Springer, 2017) and Michael A.
Meerson, “Put' against Logos: The Critique of Kant and Neo-Kantianism by
Russian Religious Philosophers in the Beginning of the Twentieth
Century,” #emph[Studies in East European Thought] 47, no. 3/4 (1995):
225--43; Nietzsche's influence in Russia has been considered by Bernice
Glatzer Rosenthal, ed. #emph[Nietzsche in Russia] (Princeton: Princeton
University Press, 1986); and Nel Grillaert, #emph[What the God-seekers
found in Nietzsche: The Reception of Nietzsche's Übermensch by the
Philosophers of the Russian Religious Renaissance] (Leiden: Brill,
2008). For Freud, see Alexander~Etkind, #emph[Eros of the Impossible:
The History of Psychoanalysis in Russia] (New York: Routledge, 2019);
for John Stuart Mill, see Julia Berest, “J. S. Mill's~#emph[On
Liberty]~in Imperial Russia: Modernity and Democracy in
Focus,”~#emph[Slavonic and East European Review]~97, no. 2 (2019):
266--298; for de Maistre, see Vera Miltchyna, “Joseph de Maistre's Works
in Russia: A Look at Their Reception,”~in #emph[Joseph de Maistre's
Life, Thought and Influence: Selected Studies]~(Montreal: McGill-Queen's
University Press, 2001), 241--270.]

Undeniably, however, it is far rarer to find scholarship that moves in
the other direction---scholarship that traces the influence of Russian
ideas on the intellectual history of the West. Michael Gillespie has
considered the impact of Turgenev's nihilists on Friedrich Nietzsche; a
few articles discuss the influence of Dmitrii Merezhkovskii on Thomas
Mann. That the phenomenologist Karl Jaspers supervised a dissertation on
Vladimir Soloviev written by Alexander Kojeve is merely a fact to be
remarked on, and scholars of Jaspers have little to say about what
Jaspers might have thought of Soloviev. In the end, this is the main
focus of this essay: Russian influence on European and American ideas
remains mostly hidden.#footnote[See Michael Gillespie, #emph[Nihilism
before Nietzsche] (Chicago, IL: University of Chicago Press, 1995); Urs
Heftrich, “Thomas Manns Weg Zur Slavischen Dämonie: Überlegungen Zur
Wirkung Dmitri Mereschkowskis,” #emph[Thomas Mann Jahrbuch] 8 (1995),
71--91. #link("http://www.jstor.org/stable/24743635"). Trevor Wilson's
recent book on Alexandre Kojeve and his much-needed contextualization of
Kojeve and his Russian philosophical roots. See Trevor Wilson,
#emph[Alexandre Kojeve and the Specters of Russian Philosophy]
(Evanston, IL: Northwestern University Press, 2025). It is worth noting
that Evert van der Zweerde voiced similar concerns in his “The Place of
Russian Philosophy in World Philosophical History---A Perspective,”
#emph[Diogenes] 56, no. 2--3 (2009): esp. 171--173.]

The blame for this state of affairs must rest partly on the shoulders of
us Russianists. For too long, students of Russian thought have suffered
from a kind of scholarly timidity, modestly accepting the sharp
disciplinary boundary between Russian and Western philosophy, simply
assuming that ideas may naturally flow from West to East but certainly
could never travel upstream. With the robust exception of studies on
Fyodor Dostoevsky and Lev Tolstoy, scholars approach the question of
Russian ideas in the West tentatively, and even apologetically.
Similarities between Martin Heidegger and Nikolai Berdyaev, the Silver
Age and European modernism, may sometimes be noted, but the question of
influence is often avoided.#footnote[Some examples of works that look at
Russian influence on Western thought include Steven G. Marks, #emph[How
Russia Shaped the Modern World: From Art to Anti-Semitism, Ballet to
Bolshevism] (Princeton: Princeton University Press, 2004); James L.
Rice, #emph[Freud's Russia: National Identity in the Evolution of
Psychoanalysis] (New York: Routledge, 1993); Adrian Wanner, “The
Underground Man as Big Brother: Dostoevsky's and Orwell's Anti-Utopia,”
#emph[Utopian Studies] 8, no. 1 (1997): 77--88; and George R. Clay,
“Tolstoy in the Twentieth Century,” in Donna Tussing Orwin, ed.,
#emph[The Cambridge Companion to Tolstoy] (Cambridge: Cambridge
University Press, 2002), 206--221.] This is in sharp contrast, for
example, to the discussions of Soviet philosophy in the West.

The conference on “Religion, Human Dignity, and Human Rights: New
Paradigms for Russia and the West,”#footnote[Hosted by the Hamilton
Center for Classical and Civic Education, University of Florida,
November 1--2, 2024.] and the current volume of #emph[Northwestern
University Studies in Russian Philosophy, Literature, and Religious
Thought], have, as their aim, the bridging of the chasm between these
two adjacent, yet often separately viewed intellectual traditions---the
Russian and the European/Western. These two traditions have considered,
very carefully and from multiple perspectives, the questions of
religion, human dignity, and human rights, but have often done so in
separate contexts. It is to be hoped that the papers presented at the
conference and published here will only be the beginning of a
conversation. The purpose of my essay is to lay out, through a few
examples, a kind of methodological blueprint for future bridge-building,
and also to issue a plea: that Russianists take seriously the
possibility of sustained Russian intellectual influence on Western
thought.

An essential caveat is in order: mine is no argument for Russian
exceptionalism. This would be very untimely, given Russia's multi-year
invasion of Ukraine and Russia's general belligerence and hostility
toward the West and all its values. The recovery of a hidden Russian
influence in the West encourages neither Russian triumphalism nor
messianism---quite the opposite. Instead, it is rather the unearthing of
what Gary Saul Morson has called the “Russian
counter-tradition.”#footnote[7 Gary Saul Morson, “Tradition and
counter-tradition: The radical intelligentsia and classical Russian
literature,” in #emph[A History of Russian Thought], ed. William
Leatherbarrow and Derek Offord (Cambridge, UK: Cambridge University
Press, 2010), 141--168.] This is a Russian intellectual tradition that
is uniquely Russian but is not anti-Western, Russian but unflinchingly
critical of Russian politics and cultural fashions. This Russian
tradition is steeped in Western ideas, but it is also unafraid to
critique Western errors and excesses. And I believe that it is this
Russian counter-tradition, or in Randall Poole's elaboration, “the
Russian counter-tradition of open humanism,” that has hidden itself
within the Western philosophical world.#footnote[Randall A. Poole, “Gary
Saul Morson and #emph[Vekhi/Landmarks]: Open Humanism in Russian
Thought,” #emph[Northwestern University Research Forum in Russian
Philosophy, Literature, and Religious Thought], January 5, 2024,
#link("https://sites.northwestern.edu/nurprt/2024/05/01/gary-saul-morson-and-vekhi-landmarks-open-humanism-in-russian-thought/").]

It seems that the best place to begin when considering this question is
in a suburb of Paris, in Clamart, where the exiled Russian philosopher
Nikolai Berdyaev, in whose name this conference was organized, lived
until he died in 1948. Berdyaev is an ideal illustration of Russian
influence on European thought, an influence that was once universally
acknowledged. Of course, Western ideas heavily influenced Berdyaev. He
read voraciously in German and French and even some English, was
conversant in all the major German and French philosophical schools, and
followed European and American philosophical and theological debates
throughout his life. This was unsurprising for a Russian of his
generation. Far more surprising is the extent to which his ideas spread
throughout the Western world. The theologian C.S. Lewis mentioned in
passing that everyone was reading Berdyaev, Martin Heidegger inscribed a
note of gratitude in a book he gave to Berdyaev, Aldous Huxley quoted
him in his dystopian #emph[Brave New World],#footnote[Quote from
Berdyaev in #emph[Brave New World]: “We used to pay too little attention
to utopias, or even disregard them altogether, saying with regret they
were impossible of realisation. Now indeed they seem to be able to be
brought about far more easily than we supposed, and we are actually
faced by an agonising problem of quite another kind: how can we prevent
their final realisation?… Utopias are more realisable than those
\'realist politics\' that are only the carefully calculated policies of
office-holders, and towards utopias we are moving. But it is possible
that a new age is already beginning, in which cultured and intelligent
people will dream of ways to avoid ideal states and to get back to a
society that is less ‘perfect' and more free.” Aldous Huxley,
#emph[Brave New World] (London: Chatto and Windus, 1932), title page.
Translation in John Hoyles, #emph[The Literary Underground: Writers and
the Totalitarian Experience, 1900--1950] (New York: St. Martin's Press,
1991), 121.] and Martin Luther King, Jr. wrote about him in a long essay
on “Continental Theology.”#footnote[Martin Luther King, Jr.,
“Contemporary Continental Theology,” September 13, 1951--January 15,
1952, in #emph[The Papers of Martin Luther King, Jr.], Stanford Martin
Luther King, Jr. Research and Education Institute,
#link("https://kinginstitute.stanford.edu/king-papers/documents/contemporary-continental-theology").]
The breadth of his influence was confirmed by #emph[Time Magazine] in
1948, declaring him “one of the great religious philosophers of his
time,” and by his serious consideration for the Nobel
Prize.#footnote[“Religion: Berdyaev,” #emph[Time Magazine], April 5,
1948, #link("https://time.com/archive/6600681/religion-berdyaev/").] To
the extent that any Russian philosopher could be well-known in the West,
Berdyaev had reached that status.

The contrast with the present day is striking---Berdyaev and his
influence are now forgotten. Berdyaev does not even merit an entry in
the #emph[Stanford Encyclopedia of Philosophy], and the last
English-language biography of him was published in 1960.#footnote[Donald
A. Lowrie, #emph[Rebellious Prophet: A Life of Nicolai Berdyaev] (New
York: Harper and Brothers, 1960); M. M. Davy, #emph[Nicolas Berdyaev:
Man of the Eighth Day], trans. Leonora Siepman (London: Bles, 1967).] To
the extent he is mentioned today, he is often simply listed as one of
“Putin's philosophers,” since Putin off-handedly recommended Berdyaev as
light summer reading for Russian officials.#footnote[A good overview of
the controversy over Putin's philosophical reading list is found in Paul
Robinson, “The Putin Book Club,” #emph[CIPS Blog], Center for
International Policy Studies, April 3, 2014,
#link("https://www.cips-cepi.ca/2014/04/03/the-putin-book-club/").] The
question remains: why has someone once so influential now become
mischaracterized and mostly forgotten?

In the wake of the 150#super[th] anniversary of Berdyaev's birth, it is
timely to use him as the first example of Russia's influence in
European, and even global, intellectual culture. In some of the most
unexpected ways, it turns out, culture does in fact flow from Russia to
Europe and beyond. For Berdyaev and his fellow Russian exiles, this was
literally true, as they physically journeyed from Russia to Europe in
the 1920s, carrying with them an entire tradition of religious and
philosophical thought that they would proceed to share with Europeans
for decades after. Berdyaev will be the first example of a hidden
Russian counter-tradition in Western philosophy, one that reveals how
Russian thought centered the question of what it means to be human in a
modern world of secularism, scientism, rationalism, and totalitarianism.

With the recent availability of new sources, we can now definitively
trace the effect of Berdyaev's distinctly Russian personalist and
existentialist thought on Europe after 1922, especially its effect on
interwar Western personalist justifications of human dignity and human
rights. Even when they disagreed with him, French and German thinkers
acknowledged his ideas as a challenge that revealed the limits of
European rationalism and scientism, and that elevated the value of the
person in a world that was rapidly eroding human worth.

Berdyaev was born in Ukraine in 1874, and he was raised in the
iconoclastic and vibrant Ukrainian culture of the early twentieth
century. Like so many of his generation, Berdyaev joined the Kyivan
Marxist movement in the 1890s but was soon labeled a “dangerous
individualist” for pointing out Marxism's tendency toward tyranny.
Berdyaev eventually returned to the Orthodox faith of his youth, but
only after years of experimenting with Nietzschean, occult, and
sectarian movements. #footnote[Much of the information on Berdyaev here
and below is taken from my introduction, “A New Christian Humanism:
Nikolai Berdyaev and Jacques Maritain,” in Bernard Hubert, #emph[An
Exceptional Dialogue, 1925--1948: Nikolai Berdyaev and Jacques Maritain]
(Montreal: McGill-Queen's University Press, 2025), 3--36.]

Berdyaev's particular Christian philosophy, in which there is a
“religious comprehension of the Anthropos as a divine person,” was
rooted in a Russian tradition of personalism that drew upon a variety of
sources, both European and Russian: the Kabbalah, Immanuel Kant,
Vladimir Soloviev, Rudolf Steiner, Jakob Boehme, and the Eastern
patristic theologians. Central to this personalism was the conception of
the human person as the “image and likeness of God,” and thus of
incalculable value. As early as 1902, he wrote:

#quote(block: true)[
We can formulate the absolute condition of the realization of the moral
good: it is the recognition of the unconditional value and right to
self-determination of the human person … together with recognition of
the equal value of people … in the human person, we esteem the
‘universal' … a human being honors his God in another human
being.#footnote[Nicolas Berdyaev, #emph[Meaning of the Creative Act]
(San Rafael, CA: Semantron Press, 2009), 19; N.A. Berdiaev, “The Ethical
Problem in the Light of Philosophical Idealism,” in Randall A. Poole,
#emph[Problems of Idealism: Essays in Russian Social Philosophy] (New
Haven, CT: Yale University Press, 2003), 161--197, 175--177; see also
Siljak, “New,” 9--10.]
]

Berdyaev's religious personalism and his commitment to the freedom and
dignity of the person did not remain abstract. It led him to resist
authoritarianism wherever he found it. Just to take a few examples: he
was charged with blasphemy in 1913 for denouncing the Russian Orthodox
Church's persecution of dissident monks, in 1922 he was arrested and
interrogated by the Soviet head of the NKVD, Feliks Dzerzhinskii, to
whom he denounced communism, and after which he was expelled from the
Soviet Union for good. Much later, during World War II, he was
interrogated by the Gestapo for his connections to Russians in the
French resistance. He wrote articles against communism, fascism, and
antisemitism. It is no wonder that Alexander Solzhenitsyn later praised
Berdyaev as “a brilliant defender of human freedom against
ideology.”#footnote[Ol'ga Volkogonova, #emph[Berdiaev] (Moscow: Molodaia
Gvardiia, 2010), 29; \
Vitalii Shentalinskii, “Oskolki serebrianogo veka,” #emph[Novyi mir],
No. 5 (May 1998),
#link("http://www.nm1925.ru/Archive/Journal6_1998_5/Content.aspx")\;
Aleksandr Solzhenitsyn, #emph[The Gulag Archipelago: An Experiment in
Literary Investigation], vol. 1 (New York: Harper Perennial, 2007), 13,
15, 130.]

When Berdyaev arrived in France in 1925, he brought his personalism with
him in the concrete form of a small collection of essays, entitled
#emph[The New Middle Ages]. First published in Russian in 1923, it was
then immediately translated into German in 1924 and became popular among
German and French intellectuals shortly thereafter. The book's critique
of Enlightenment rationalism and rampant technological mechanization,
its elucidation of Marxism and Fascism as secular religions, and its
vigorous defense of human personality against modern bourgeois
capitalism captured the French philosophical imagination. It also
introduced Berdyaev to the neo-Thomist philosopher, Jacques Maritain.

The firmest proof of the full integration of Berdyaev's philosophical
worldview into the intellectual life of Europe has been recently laid
out in multiple editions of their correspondence, by Teresa Obolevitch
and Bernard Hubert, published in French, Russian and Polish, and
English. These publications reveal that Maritain and Berdyaev were very
close friends, and they engaged in philosophical and theological
conversation with other French intellectuals, including Emmanuel
Mounier, Etienne Gilson, and Gabriel Marcel. Maritain openly praised
Russian philosophers for bringing to France a “theandric” view of human
beings, central to personalism. By the time Jacques Maritain wrote his
highly influential #emph[The] #emph[Rights of Man and Natural Law] in
1942, his view of human dignity had been formed in encounters with
Berdyaev's ideas. Personalism, it seems, was a “Russo-French”
philosophy. Again, one must reiterate that this personalism did not
remain abstract---Berdyaev and Maritain valiantly stood against
Communism, Fascism, Franco's Spain, European antisemitism, and the worst
excesses of techno-capitalism.#footnote[Teresa Obolevitch and Bernard
Marchadier, eds. #emph[Velikaia druzhba: Perepiska Zhaka i Raisy Mariten
s N. A. Berdiaevym] (Zielona Góra: Uniwersytet Zielonogórski, 2022);
Bernard Hubert, ed. #emph[Une dialogue d'exception (1925--1948): Jacques
Maritain et Nicolas Berdiaev] (Paris: YMCA-Press, 2022). See also,
Siljak, “New,” 25.]

Influence is sometimes revealed in disagreement. Maritain remained a
Thomist and insisted on the grounding of his insights on intelligible,
God-given reason. Berdyaev, on the other hand, was impatient with the
Thomistic system and insisted that the path of the individual to the
divine was often undefinable and mystical, transcending reason. Even
though Maritain explicitly criticized Berdyaev's “irrationalism” and his
“anti-intellectual existential philosophy,” he nonetheless admitted in
his journal that Berdyaev's thought served an important role: “It pushes
me to write on these topics (Personality, Evil).” By introducing the
concept of divine nothingness, by highlighting the irrational limits of
reason, by confronting, head-on, the topic of evil, Berdyaev shaped the
European philosophical conversation. In the end, Maritain openly praised
Russian philosophy for introducing, into Europe, a distinct “theandric”
view of humanity. The émigré Helene Iswolsky, who knew both
philosophers, declared that “Christian humanism” was Berdyaev's lasting
contribution to Western thought.#footnote[Siljak, “New,” 27; the
influence of Russian personalism on French thought is also discussed in
Randall A. Poole, “Integral Humanisms: Jacques Maritain, Vladimir
Soloviev, and the History of Human Rights,” #emph[Vestnik
Sankt-Peterburgskogo Universiteta, Filosofiia i Konfliktologiia], 35
(2019): 92--106.]

In sum, via Berdyaev's intellectual biography, I am illustrating my
original point: the hidden influence of Berdyaev in the West was the
influence of a philosophical Russian counter-tradition. Berdyaev
criticized Russian and Soviet despotism, as well as European rationalism
and totalitarianism, in equal measure. Berdyaev's unique attention to
the theological and existential grounding of personalism acted as a
challenge to Western thought, one that demanded a more complicated
understanding of the human person, human meaning, and human dignity.

From the 1970s on, the ideas of Berdyaev and Maritain grew increasingly
obscure, as neo-liberalism grew and the dangers of totalitarianism
faded, and as the idea of a Christian humanism seemed unnecessary. But
their collaboration had its legacy in the philosophers whose importance
is undeniable: Martin Buber, Albert Camus, Jean Paul Sartre, and the
popes John Paul II and Francis, just to name a few. Berdyaev's influence
thus illustrates my general methodological point, which can be stated
quite simply: if you look carefully, paying attention to correspondence,
footnotes, and bibliographies, you will find Russians hidden under a
number of Western philosophical rocks. Russians are often quietly
present, especially when Western thinkers grapple with what it means to
be human in the modern world, and this presence is a fruitful path for
scholars to follow as they trace the impact of Russian thought on
Western intellectual history.

But we must not think of Berdyaev as an isolated case of a Russian
émigré in Europe. I am going to be bold now and illustrate the way in
which we can find the Russian counter-tradition in some of modernity's
most unexpected places---in the thought of those whom we think rather
unlikely to embrace the existential and irrational. These are the
philosophers Max Weber and Leo Strauss.

Max Weber is today best known for his classic text, #emph[The Protestant
Ethic and the Spirit of Capitalism], in which he unearthed a hidden
Calvinist anxiety over salvation at the heart of a worldly
asceticism---an ethic of self-denial and hard work---that led to the
flourishing of capitalism. In this work, as in many of his others, Max
Weber has been accepted as he saw himself---a self-professed “scientist”
and pioneer in the field of sociology. #footnote[Space does not permit a
full discussion of the scholarship on Weber, but a discussion of Max
Weber as a founder of social science and sociology is found in Sheldon
S. Wolin, “Max Weber: Legitimation, Method, and the Politics of
Theory,”~#emph[Political Theory]~9, no. 3 (1981): 401--424; Stephen P.
Turner and Regis A. Factor, eds., #emph[Max Weber and the Dispute over
Reason and Value: A Study in Philosophy, Ethics, and Politics] (Boston:
Routledge & Kegan Paul, 1984), especially chapters 8 and 9; and in
Anthony Giddens's classic~#emph[Politics and Sociology in the Thought of
Max Weber] (London: MacMillan, 1972). A detailed discussion of Weber's
#emph[Protestant Ethic] is found in Peter Ghosh, #emph[Max Weber and the
Protestant Ethic: Twin Histories] (Oxford: Oxford University Press,
2014).]

Is Max Weber a philosopher? In this matter, it is useful to read the
testimony of Karl Jaspers, a philosopher of the continental school, who
was categorical: “Over all these years, I never philosophized without
thinking of Max Weber.”#footnote[See John Dreimanis, ed. and trans.,
#emph[Karl Jaspers on Max Weber] (New York: Paragon House, 1989), 140]
Even more eccentric is Jaspers's more detailed claim about Weber's
philosophizing. In his “Max Weber as a Scientist,” he wrote, “Max
Weber's science is linked with the awareness of what is not
known.”#footnote[Dreimanis, #emph[Jaspers], 99.] And it is worth quoting
at length from his “Max Weber as a Philosopher”:

#quote(block: true)[
If science was once considered the way to true being, to true art, to
true nature, to true God, and to true happiness, no one believes that
any longer. Science has disenchanted everything… Therefore, as Tolstoy
concluded, science is meaningless … because it gives no answer to the
only question important for us: What should we do? How should we live?
Max Weber… declares that it is simply indisputable that science has no
answer to Tolstoyian questions of meaning, but contrary to Tolstoy, does
not deny the meaning of science.#footnote[Dreimanis, #emph[Jaspers],
105--106.]
]

For this reason, Jaspers concludes, Weber is “an existential
philosopher.”#footnote[Dreimanis, #emph[Jaspers], 9.]

The above quote not only justifies seeing Max Weber as a philosopher
(and perhaps even an existentialist!) but it also illustrates the main
theme of this essay---Jaspers justifies Weber as an existentialist
philosopher by referring to Russia (in the character of Leo Tolstoy).
Tolstoy was, of course, widely known in Europe and throughout the world,
but the larger question remains: how much did Weber know about Russia?

Scholars are not entirely ignorant of Weber's longstanding interest in
Russia. Biographers have noted that Weber read Russian literature,
including the works of Tolstoy, especially during a mental health crisis
that lasted from 1898 to 1903. Weber's essays on Russian politics and
society are well known (especially by Russianists). But most scholars of
Weber have either ignored or dismissed the very idea of Russian
influence on Weber. Weber's biographer Peter Ghosh, for example,
outright asserts that “Russia was part of the Orient,” and Weber's
thought was “relentlessly Occidental;” and Joachim Radkau declares that
Weber could not have learned much about Orthodoxy since “there were
scarcely any Russian Orthodox theologians who offered Western scholars
material for a worthwhile study.”#footnote[Fritz Ringer's #emph[Max
Weber: An Intellectual Biography] and the #emph[Oxford Handbook on Max
Weber] contain no mention of Russian thinkers. On Weber and Tolstoy, see
Guy Oakes, “The Antinomy of Values: Weber, Tolstoy and the Limits of
Scientific Rationality,”~#emph[Journal of Classical Sociology]~1, no. 2
(2001): 195--211; Ghosh, #emph[Weber], quote 292. Joachim Radkau,
#emph[Max Weber: A Biography] (Cambridge: Polity Press, 2009), 246.]

A more careful look at certain biographical details reveals that Weber
was not as “relentlessly Occidental” as Ghosh claims. For example, from
1905 on, Weber studied the Russian language every morning before he got
out of bed. In the early 1900s, he was closely involved with a group of
Russian émigré students in Heidelberg, including Fyodor Stepun and
Bogdan Kistiakovskii. Perhaps under their influence, Weber read not only
Russian novels but also works of Russian philosophy, including Vladimir
Soloviev (whose “The National Question in Russia” Weber published in
translation) and the Slavophile Alexei Khomiakov (he was familiar with
Khomiakov's defense of Orthodox conciliarity, or
#emph[sobornost']).#footnote[Two excellent articles that mention the
possibility of a Russian influence on Weber are Hubert Treiber, “Die
Geburt der Weberschen Rationalismus-These: Webers Bekanntschaften mit
der russischen Geschichtsphilosophie in Heidelberg: Überlegungen
anläßlich der Veröffentlichung des ersten Briefbandes der Max
Weber-Gesamtausgabe,”~#emph[Leviathan]~19, no. 3 (1991): 435--451 and
Andreas E. Buss, “Eastern Orthodox Christianity and the Other Spheres of
Life in Max Weber\'s Russia,” in Alan Sica, ed.,~#emph[The Routledge
International Handbook on Max Weber] (Boston: Routledge, 2022),
235--247. Treiber points out that Weber probably learned about Soloviev
through Stepun, who wrote his dissertation on him. Treiber, “Geburt,”
\442. For his acquaintance with Stepun and Kistiakovskii and the
publication of a translation of Soloviev see his letters to Paul Siebeck
in M. Rainer Lepsius and Wolgang J. Mommsen, eds., #emph[Max Weber,
Briefe 1906--1908] (Tubingen: J.C.B. Mohr, 1994), 110--111, 119, 127,
\141. The reference to Khomiakov is found in Weber's speech to the
“German Sociological Society,” discussed below.]

Most revealing of Weber's “Orientalist” tendencies, however, was Weber's
sustained interest in the philosophy of Sergei Bulgakov, especially in
Bulgakov's book, #emph[Philosophy of Economy: World as Household]. Weber
had specifically requested that Bulgakov provide him with an excerpt
from what Weber called his “great book.” He then supervised the
translation and publication of excerpts from the book in
\1913.#footnote[For Weber's interest in Bulgakov's book, see his letters
to Edgar Jaffe in M. Rainer Lepsius and Wolfgang J. Mommsen, eds.,
#emph[Max Weber, Briefe 1911--1912] (Tubingen: J.C.B. Mohr, 1996), 550,
\747. An excerpt was published as “Die naturphilosophischen Grundlagen
der Wirtschaftstheorie,” in #emph[Archiv für Sozialwissenschaft und
Sozialpolitik], 36, no. 2 (1913), 359--393.] Those who have read
Bulgakov's book should be surprised by Weber's interest, since
Bulgakov's central task in that work was the most un-Weberian
redefinition of economic terms, including, for example, the
consideration of “consumption” as “partaking of the flesh of the world”;
“production” as “the liberation of creation from the imprisonment of
thingness”; and economy as “the cosmic victory of beauty” on the pattern
of the Divine Sophia. #footnote[See Sergei Bulgakov, #emph[Philosophy of
Economy: The World as Household], ed. and trans. Catherine Evtukhov (New
Haven, CT: Yale University Press, 2000), 101--103, 122, 153.]

What did Weber learn from Bulgakov (or from Soloviev or Khomiakov, for
that matter)? A full account of this has yet to be studied. But there
are two threads of influence worth following. The first appears in
excerpts from a conversation among Weber and other sociologists
attending the first meeting of the “German Sociological Society” in
\1910. Let me quote what Weber told his colleagues:

#quote(block: true)[
While the Calvinist church is permeated by sectarianism, the Greek
church is saturated, in great measure, with a very specific classical
mysticism … brotherly love and charity, those special human
relationships which the great salvation religions have transfigured (and
which seem so pallid among us).…

… From this acosmic quality, characteristic of all Russian religiosity,
is derived a specific kind of natural right which is stamped upon the
Russian sects and also on Tolstoy… Soloviev\'s specific concept of the
church, in particular, rests on it. The concept rests on “community” (in
Toennies sense), not on “society.” #footnote[Ferdinand Toennies, Georg
Simmel, Ernst Troeltsch, and Max Weber, “Max Weber on church, sect, and
mysticism,”~#emph[Sociological Analysis]~34, no. 2 (1973): 140--149,
144--145. It is interesting that Weber used Tonnies's binary of
community/society \[Gemeinschaft/Gesellschaft\] long before Andrzej
Walicki did in his #emph[Slavophile Controversy], and he did so in the
presence of Tonnies himself.]
]

Could this quote reveal that, for Weber, the opposite of the Protestant
ethic and the spirit of capitalism was an Orthodox ethic and spirit of
community? The tantalizing reference to natural right here is also
interesting---did he mean he saw a Russian version of natural right
deriving from Orthodoxy? #footnote[This is explored in Buss, “Eastern,”
238--240.] We know that Weber planned, but never wrote, a book on
Orthodox Christianity. What would he have written? The answer is not at
all clear, but this trace of Russia in Weber is worth exploring.

The second thread of Russian influence may well lead directly to Weber's
conception of “the disenchantment of the world,” which appears in his
lecture “Science as a Vocation” given in 1917, and has become a
cornerstone of the philosophical and sociological debates about
modernity. Disenchantment was, for Weber, the disturbing rise of
“intellectualization and rationalization” that replaced the
understanding of the world as composed of “mysterious incalculable
forces.” In Weber's words:

#quote(block: true)[
Increasing intellectualization and rationalization … means … that there
are no mysterious incalculable forces that come into play, but rather
that one can, in principle, master all things by calculation. This means
the world is disenchanted. One need no longer have recourse to magical
means in order to master or implore the spirits, as did the savage…
Technical means and calculations perform the service…

Now this process of disenchantment … and, in general, this “progress,”
to which science belongs as a line and motive force, do they have any
meanings that go beyond the purely practical and technical? You will
find the question raised in the most principled form in the works of Leo
Tolstoi… Tolstoi has given the simplest answer, with the words: “Science
is meaningless because it gives no answer to the only question important
for us: ‘What shall we do and how shall we live…'”#footnote[H.H. Gerth
and C. Wright Mills, #emph[From Max Weber: Essays in Sociology] (Oxford:
Oxford University Press, 1958), 152--153.]
]

You will note that Russia, in the form of Tolstoy, is not even hidden
but right at the center of Weber's disenchantment thesis.#footnote[A
discussion of this is found in Oaks, “Antinomy,” 201--205.] It is worth
asking, however, whether Tolstoy, given Weber's wider reading, was but
the most prominent representative of Russian philosophical
counter-tradition that included Khomiakov, Soloviev, and Bulgakov, a
counter-tradition that forced Weber to examine the drawbacks of
excessive scientism and rationalism, and which may have even helped him
to formulate the concept of “rationalization” in the first place.

If Jaspers is correct that Weber, as a philosopher, utilized the
scientific method while also articulating its drawbacks and limits, we
can suggest that Russian thought helped him to do so. Perhaps it was the
Russians that infected Weber with the anxiety at the heart of his
“disenchantment” thesis, an anxiety that modernity was losing sight of
the human, that dignity, and even “natural right” could not be achieved
through modern science. Weber's “existentialism” may, in part, be of
Russian origin.

The thinker most openly troubled by Weber's existentialist rejection of
rationalism was the German-Jewish philosopher Leo Strauss, considered
the founder of Straussianism and American neo-conservatism. For Strauss,
Weber

#quote(block: true)[
tended to see before him the alternative of either complete spiritual
emptiness or religious revival. He despaired of the modern this-worldly
irreligious experiment, and yet he remained attached to it because he
was fated to believe in science as he understood it. The result of this
conflict, which he could not resolve, was his belief that the conflict
between values cannot be resolved by human reason.#footnote[Quoted and
discussed in Alan Mittleman, “Weber\'s Politics as a Vocation: Some
American Considerations,”~#emph[Notre Dame Journal of Law, Ethics &
Public Policy]~20, no. 1 (2014): 279--295, 281.]
]

In a way, Strauss's philosophical project endeavored to recover reason
from the clutches of Weberian doubt. According to Alan Mittleman,
Strauss's philosophy was animated by this question of reason and faith,
and the struggle to recover reason in an age of doubt, because Strauss
believed that “there is a truly just way of life capable of being known
by natural reason and lived out in political
society.”#footnote[Mittleman, “Politics,” 280.] I will now hypothesize,
however, that Leo Strauss recovered reason also by grappling with a
hidden Russia at the heart of Western thought.

Strauss's contemporary legacy is primarily located in the Anglo-American
philosophical world, but his early intellectual development took place
in continental Europe. Before he emigrated to the United States in 1938,
he met and corresponded with a kind of who's who of European
philosophers, including Martin Heidegger, Edmund Husserl, and Alexander
Kojeve. It was while in Europe that Strauss began to consider the
philosophical question of the relationship between reason and
religion.#footnote[For a discussion of the European foundations of
Strauss's thought, see Samuel Moyn, “From Experience to Law: Leo Strauss
and the Weimar Crisis of the Philosophy of Religion,”~#emph[History of
European Ideas]~33 (2) (2007): 174--94; and Daniel Tanguay, #emph[Leo
Strauss: An Intellectual Biography] (New Haven, CT: Yale University
Press, 2007).]

According to his biographer, Daniel Tanguay, however, Strauss came up
with a novel formulation of the relationship in 1946. From that time, he
referred to the conflict between reason and religion as one between
“Jerusalem and Athens.”#footnote[Tanguay, #emph[Strauss], 144.] The
binary is a reference to the well-known question of Tertullian, “What
has Athens to do with Jerusalem?” But Strauss did not formulate his
binary in reference to Tertullian. Instead, careful reading of Strauss's
various writings on the subject reveals a hidden Russian influence,
specifically that of Lev Shestov, the Russian-Jewish philosopher who
wrote his final book, #emph[Athens and Jerusalem], just before his death
in 1938.

Shestov was born in Kyiv in 1866 and befriended Berdyaev long before
they both emigrated to France. When Shestov came to Paris, he brought
with him an existentialism far more radical than even that of Berdyaev.
Shestov's philosophy intrigued the German interwar philosophical world,
and Shestov met and corresponded with a number of German philosophers.
He was a good friend of Edmund Husserl, who introduced him to Martin
Heidegger and suggested that Shestov read Soren Kierkegaard (according
to Samuel Moyn, Shestov reintroduced Kierkegaard into Russian thought).
He was a part of the philosophical circles in Paris that included
Jacques Maritain and Etienne Gilson. Strauss and Shestov, therefore,
shared a common philosophical community.#footnote[Biographies of Shestov
in English are few, see Michael Finkenthal,~#emph[Lev Shestov:
Existential Philosopher and Religious Thinker] (New York: Peter Lang,
2010). Brian Horowitz has written excellent articles on Shestov's ideas,
see Brian Horowitz, “The tension of Athens & Jerusalem in the philosophy
of Lev Shestov,” #emph[The Slavic and East European Journal]~43, no. 1
(1999): 156--173; and Brian Horowitz and Bernard Martin, “The demolition
of reason in Lev Shestov\'s Athens and Jerusalem,”~#emph[Poetics
Today]~(1998): 221--233.]

Strauss's connection with Russia, and with Shestov in particular, has
been mostly invisible to Strauss scholars (and to Shestov scholars, for
that matter). The possibility that Strauss read Shestov is often briefly
raised, only to be dismissed. #footnote[Jeffrey Bernstein has an astute
summary of Shestov's Athens and Jerusalem but declares “whether Strauss
was familiar with Shestov remains an open question.” Bernstein,
#emph[Strauss], 11. Remi Brague declares that Strauss could not have
read Shestov's #emph[Athens and Jerusalem] before Strauss's own
formulation of the problem because Brague misdates the first publication
to 1951 (it was published in French and German in 1938). See, Rémi
Brague, “Athens, Jerusalem, Mecca: Leo Strauss's ‘Muslim' Understanding
of Greek Philosophy,” #emph[Poetics Today] 19, no. 2 (1998): 235--59,
\236. #link("https://doi.org/10.2307/1773441"). The following works do
not consider Shestov at all: Steven B. Smith, “Leo Strauss: Between
Athens and Jerusalem,” #emph[The Review of Politics] 53, no. 1 (1991):
75--99. http:\/\/www.jstor.org/stable/1407552. David
Janssens,~#emph[Between Athens and Jerusalem: Philosophy, Prophecy, and
Politics in Leo Strauss\'s Early Thought] (State University of New York
Press, 2009); Orr, #emph[Jerusalem]. The only sustained comparison of
the thought of Shestov and Strauss on the subject of Athens and
Jerusalem is found in Tikhon G. Sheynov, “‘Athens and Jerusalem' of Leo
Strauss and Leo Shestov,” #emph[Voprosy filosofii] 4 (2024): 126--136.]
But the evidence of a Russian connection exists. Strauss participated in
a briefly mentioned “Russian course” in Berlin and a “Russian circle” in
London. And there is no doubt that Strauss read Shestov---he
specifically mentions the existence of “notes to Shestov” in his
writings on Plato's Euthyphro. In sum, Strauss spent time with Russian
thought in general and Shestov's philosophy in particular. This leads to
the specific question: Could it be that Leo Strauss wrote “Jerusalem and
Athens” partly in response to Lev Shestov's #emph[Athens and
Jerusalem]?#footnote[References to the Russian group and circle appear
in Strauss's letters to Jacob Klein in Heinrich Meier, ed., #emph[Leo
Strauss: Gesammelte Schriften, Band 3: Hobbes' politische Wissenschaft
und zugehörige Schriften. Briefe] Vol. 46. (Stuttgart: J. B. Metzler,
2017), 527, 530. Reference to Shestov appears in Hannes Kerber and
Svetozar Minkov, eds., #emph[Leo Strauss on Plato's Euthyphro: The 1948
Notebook, with Lectures and Critical Writings] (University Park, PA:
Penn State Press, 2024), 97.]

Placed side by side, the writings of Strauss and Shestov on this subject
come to diametrically different conclusions, but they share the same
premise: the question of Athens vs. Jerusalem is central to modernity.
Both philosophers suggest that modern people must make a choice between
the cities, between, as Strauss calls it, “ways of
life.”#footnote[Laurenz Denker, Hannes Kerber, and David Kretz, “Leo
Strauss's ‘Jerusalem and Athens' (1950): Three Lectures Delivered at
Hillel House, Chicago,”~#emph[Journal for the History of Modern
Theology/Zeitschrift für Neuere Theologiegeschichte]~29, no. 1 (2022):
133--173, 138.] Importantly, moreover, they both trace the origin of the
question to the same place. They both begin, not with Tertullian, but
the Biblical book of Genesis and the Tree of Knowledge in the Garden of
Eden. More concisely, for both men, the dilemma between Athens and
Jerusalem begins with the serpent in the garden.

In #emph[Athens and Jerusalem], Shestov makes the startling claim that
Western philosophy is the legacy of the serpent. It was the serpent who
told Adam and Eve to eat of the Tree of Knowledge, so that they would
ascend to a divine, impersonal, and comprehensive understanding of the
world, to become “like gods, knowing.” Modern philosophers, unlike Eve,
do not even hesitate before eating of the Tree.

#quote(block: true)[
All of us are persuaded that the serpent who enticed our primal
forefathers to taste of the fruits of the tree of the knowledge of good
and evil did not deceive them… If it is necessary to choose between God
who warns us against the fruits of the tree … and the serpent who extols
these fruits to us, the educated European cannot hesitate; he will
follow the serpent … he who seeks to discredit knowledge in our eyes
lies, while the truth speaks through the mouth of him who glorifies
knowledge.#footnote[Lev Shestov, #emph[Athens and Jerusalem] (Athens,
OH: Ohio University Press, 2016), 80]
]

For Shestov, Hegel, Spinoza, and so many other philosophers crave the
knowledge that would make the world predictable and understandable, a
world which they could “know” in all of its complexity. Starting with
Spinoza, philosophy wanted to “discover the rigorous and unchangeable
order of being,” and “the science which reveals this order to man.” In a
way, this sort of knowledge was the precursor to a kind of Stoic
acceptance of life, and knowledge that leads to patient endurance of all
that comes. This is why, for Shestov, Spinoza had a rule: not to lament,
not to curse, but to understand.”#footnote[Shestov, #emph[Athens], 83,
10]

For Shestov, the tragedy of the Tree lies in a simple fact: #emph[the
serpent lied]. Philosophers hubristically chose knowledge over God,
pursued the supposed omniscience of reason and fact, but did not become
gods. Instead, they were imprisoned by their own rationalism, bound by
the heavy chains of rational and material causality. In this manner,
they lost their freedom and their human dignity, guaranteed by the God
who created all that was reasonable and that stood above reason itself.
“Adam exchanged the freedom which determined his relationship to the
Creator who hears and listens,” wrote Shestov, and became dependent on
“the indifferent and impersonal truths which do not hear and do not
listen to anything.” Humanity disobeyed God and became enslaved by
necessity.#footnote[Shestov, #emph[Athens], 206]

For Shestov, controversially, freedom and dignity paradoxically require
the absurd: “the relationship of man to God is freedom.” This was
Tertullian's statement of faith, which Shestov, though Jewish, quoted
approvingly: “the son of God died: it is absolutely credible because it
is absurd; and having been buried, he rose from the dead; it is certain
because it is impossible.”#footnote[Shestov, #emph[Athens], 165] Only an
absurd God, wholly free from the tyranny of causality, creates a space
for vertiginous human freedom, a space into which faith can leap. This
Jewish existentialist faith became the cornerstone of Shestov's
philosophical contribution to Western thought.#footnote[According to
Sidney Monas, there was a strain of Hasidism in Shestov's thought. See
Sidney Monas, “New Introduction,” in Leon Shestov, #emph[Chekhov and
Other Essays] (Ann Arbor: University of Michigan Press, 1966), v--xxiv,
vii--ix.]

In his talk entitled “Jerusalem and Athens,” given in 1950, I think
Strauss implicitly attacked Shestov: “What is to be done with those who
assert and reassert their belief in revelation while claiming to see
farther and higher than does the positive mind?” What is to be done,
indeed! Only one thing: to rescue philosophy from the clutches of
Shestov's absurdism.

To do so, Strauss himself turns to the serpent in the garden. Strauss
defends the serpent: “The serpent spoke the truth.” His evidence?
“Everything happens exactly as the serpent had predicted. Adam and Eve
do not die, their eyes are opened, they become similar to God by
acquiring knowledge.” Yes, Adam and Eve are punished, but there is only
one lesson in this, according to Strauss: God is capricious and fickle,
God, it seems, wants “simplicity of his obedience to God and trust in
his maker” even in the face of His arbitrary whims. For Strauss,
unthinking obedience was the Biblical road to
Jerusalem.#footnote[Denker, et al., eds. “Jerusalem,” 157--158.]

So how did Strauss rescue reason and philosophy from revelation? First
of all, he resolutely declared his agreement with Shestov: “Philosophy
is not #emph[necessarily] the right way of life. Philosophy is not
#emph[evidently] the right way of life. The #emph[choice] of philosophy
by an individual is then based on #emph[blind choice], on blind
faith.”#footnote[Denker, et al., eds. “Jerusalem,” 173.] Like Shestov,
Strauss believes that people must choose between faith and reason, and
that the choice of reason is, in fact, a blind leap. But in another
place, he adds that there are a few who do make that choice. For this
reason, inspired by Shestov, Strauss reread Genesis, but did so in his
own peculiar manner: “esoterically.”#footnote[Discussions of Strauss's
esoteric method, primarily extolled in #emph[Persecution and the Art of
Writing] (Chicago: University of Chicago Press, 2013) can be found in
Robert Howse, “Reading between the Lines: Exotericism, Esotericism, and
the Philosophical Rhetoric of Leo Strauss,” #emph[Philosophy & Rhetoric]
32, no. 1 (1999): 60--77; and Shadia B. Drury “The Esoteric Philosophy
of Leo Strauss,”~#emph[Political Theory]~13, no. 3 (1985): 315--337.]
Only a careful reading of the implications inserted by what Strauss
calls the “Biblical authors,” could a reader the meaning hidden for
those capable and intelligent enough to see it. In one reading, God
extols revelation and obedience, and for the unthinking many, this is
enough. But for the few, chosen and unafraid, the serpent points the way
to reason, to philosophy, to Athens. These, Strauss wrote, can become
“kings,” the very few, since “knowledge of the most important things
will remain, as it always was, the preserve of the philosophers, i.e.,
of a very small part of the population.”#footnote[Leo Strauss,
“Jerusalem and Athens: Some Introductory Reflections,” #emph[Commentary
Magazine], June 1967,
#link("https://www.commentary.org/articles/leo-strauss/jerusalem-and-athens-some-introductory-reflections/").]
Only a few, it seems, can be brave enough to follow the serpent.

Strauss thus inverted Shestov, but it seems that, as Berdyaev did for
Maritain, and as Soloviev, Khomiakov, and Bulgakov did for Weber, so
Shestov challenged Strauss to grapple with existential and theological
questions at the heart of modernity, and to contend with what it means
to be human in a world of science and progress. In other words, Strauss
grappled with the Russian counter-tradition, and thus, this
counter-tradition reveals new perspectives on his philosophical project.

In the hidden Russia in Western philosophy, we see a repeated,
subterranean challenge to European and Western philosophizing. If we
return to the Isaiah Berlin quote with which this article begins, we can
propose the following: if continental philosophy is “impenetrably dark,”
“romantic,” and “struggling” with “cosmic issues” upon which “salvation”
depends, it is so partly because of the hidden Russian undercurrent
within it. As Dostoevsky noted in #emph[Brothers Karamazov], nothing was
more intellectually Russian than “the eternal questions, of the
existence of God, and immortality…” The continental builders of
systems---Husserl, Heidegger, Jaspers, Maritain, and Strauss encountered
in Russian philosophy an exploration of boundaries, an understanding of
limits, a pointing toward the transcendent and the salvific---all of
which could be countered, but none of which could be ignored. It is in
this hidden Russian anti-rationalism and anti-scientism that, I think,
the best of the Russian counter-tradition resides, a counter-tradition
whose as yet undiscovered streams we should not be afraid to explore.

It is fitting to close with parting thoughts from Gary Saul Morson and
Caryl Emerson on Mikhail Bakhtin, whose influence on the West has not
yet been forgotten. According to them, Bakhtin's literary criticism
attacked “theoretism,” which was a modern “way of thinking that
abstracts from concrete human actions all that is generalizable,” and
“takes that abstraction as a whole.” Bakhtin saw that theoretism “blinds
us to the particular person and situation, which is where morality
resides.” In this, Morson and Emerson argue, he was a part of the
Russian counter-tradition, and it is as good a summary of the
counter-tradition as any philosophical definition.#footnote[Gary Saul
Morson and Caryl Emerson, eds., #emph[Rethinking Bakhtin: Extensions and
Challenges] (Evanston, IL: Northwestern University Press, 1989), 7, 9.]

The Russian counter-tradition may not have provided clear answers to how
one must live, but sought instead for a philosophy of the particular,
the existential, the transcendent, and the human. It insisted on freedom
and dignity. It called for “a surplus of humanness” to undermine the
parsimony of ideology. Born in the contest against the prevailing
worldview of the twentieth century, concerned to defend the human
personality against the totalizing ideologies of communism and fascism
that threatened it, this counter-tradition retains its relevance in our
present era. Our much-discussed present crises---of liberalism, of the
humanities, of artificial intelligence---could benefit from a
revitalization of the concept of personality that takes into account the
whole human being: physical and spiritual, in its immanence and
transcendence. It may be hidden and a counter-tradition, but in a time
where the human person is devalued, human dignity is in question, and
human rights are violated in the West and in Russia, this
counter-tradition deserves to be resurrected to challenge us anew.

<end-of-article-siljak>
