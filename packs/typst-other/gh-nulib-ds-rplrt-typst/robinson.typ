#import "elements.typ": *

#counter(footnote).update(0)
#abstract(
  [Freedom and Rights in the Thought of Ivan Ilyin],
  abstract-subtitle: [Secular Liberals, Soviet Christians, and Socialist Humanism in
the Brezhnev Era],
  abstract-author: [Alexander J. McConnell],
  [
    ],
  abstract-keywords: []
)

// This section sets the headers for the article
#set page(
  header-ascent: 40%,
  header: context {
    set text(8pt, font: "IBM Plex Sans", stretch: 75%, weight: 400)
    let first-page = locate(<first-page-robinson>).page()
    if here().page() == first-page [
      #grid(
        columns: (45%, 45%),
        gutter: 10%,
        align(left)[
          NORTHWESTERN UNIVERSITY STUDIES IN RUSSIAN\
          PHILOSOPHY, LITERATURE, AND RELIGIOUS THOUGHT
        ],
        align(right)[
          Volume 2 (2024): #first-page#sym.dash.en#locate(<end-of-robinson>).page() \
          10.71521/s31r-ah05
        ]
      )
    ] else if calc.even(here().page()) [
      #set align(center)
      #set text(font: "IBM Plex Sans", size: 11pt, weight: 600)
      #upper([Alexander J. McConnell])
    ] else [
      #set align(center)
      #set text(font: "IBM Plex Sans", size: 11pt, weight: 300, tracking: .1em)
  #upper([_Dissenting Views_])
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

#heading(level: 2)[Freedom and Rights in the Thought of Ivan Ilyin]
<first-page-robinson>
#v(1em)
#subtitle([])

#v(1em)
#author[Paul Robinson]

“A man who lives in freedom doesn't spend much time thinking about it,
he lives~#emph[in it], he enjoys it; he simply floats in its easy
stream. It's like air; when you breathe air, you don't think about it. …
You think about air when you don't have any. … It's the same with
freedom; a person cannot live without it, he needs it as much as he
needs air. Why?”#footnote[Ivan Il'in, “Svoboda,” in Ivan Aleksandrovich
Il'in, #emph[Novaia natsional'naia Rossiia: Publitsistika
1924]--#emph[1952 godov] (Moscow: Institut naslediia, 2019), 577
(emphasis in the original).] So asked the philosopher Ivan Ilyin
(1883--1954) in a 1939 article titled “Freedom.” He then provided an
answer. Freedom was necessary, he wrote:

#quote(block: true)[
Because one can only #emph[love] freely. Because love … arises either
freely, or not at all. Because one can only #emph[believe] and
#emph[pray] freely. For either faith penetrates to the deepest depth of
the soul where the commands and prohibitions of other people cannot
reach, where you~#emph[yourself]~contemplate and believe---or it doesn't
arise at all. … A person~#emph[thinks]~only freely, for free thought is
independent thought. … A person can only~#emph[comprehend]~freely; only
a freely-held conviction is worth anything … A person can only
be~#emph[creative]~freely---without hindrance, without order, without
prohibitions---according to his own, secret motive … Without freedom, a
person is dead and empty, broken into pieces, insincere, powerless and
helpless. … Only free labour enables life and is productive; only
uncoerced, voluntary and joyful effort has a truly beneficial influence.
Coercion cannot replace freedom in anything. Any attempts to do so are
hopeless, wherever they are undertaken and regardless of the objectives
they try to serve.#footnote[Il'in, “Svoboda,” 577--79 (emphasis in the
original).]
]

In this and other works, Ilyin made what may be some of the most
impassioned defences of freedom ever written by a Russian political
thinker. The purpose of this article, therefore, is to investigate
Ilyin's writings on the topic of freedom and the foundations on which
they rested.

To this end, the article will first place Ilyin in his historical
context and will then focus on four of his works which discuss the issue
of freedom in some detail: #emph[On the Essence of Legal Consciousness],
#emph[The Path of Spiritual Renewal], and #emph[Our Tasks], together
with a draft constitution for a future Russian state drawn up by Ilyin
towards the end of his life and published under the title,
#emph[Foundations of the State System: A Draft of Russia's Fundamental
Law]. Various newspaper articles published by Ilyin in the 1930s on the
topic of freedom will also be mentioned.

Ilyin's passionate endorsement of freedom may come as a surprise to
those used to seeing him described as a “fascist” or at least as
belonging to “a right-wing communitarian tradition … \[that\] could be
identified as a close relative of classic fascism.”#footnote[Timothy
Snyder, “God is a Russian,” #emph[The New York Review of Books], April
5, 2018,
https:\/\/www.nybooks.com/articles/2018/04/05/god-is-a-russian/; Timothy
Snyder, #emph[The Road to Unfreedom: Russia, Europe, America] (New York:
Tim Duggan, 2018); Anton Barbashin and Hanna Thorburn, “Putin's
Philosopher,” #emph[Foreign Affairs], September 20, 2015,
https:\/\/www.foreignaffairs.com/articles/ukraine/2015--09--20/putins-philosopher;
Mikhail Suslov, #emph[Putinism---Post-Soviet Russian Regime Ideology]
(London: Routledge, 2024), 56. For a detailed discussion of whether
Ilyin deserves the fascist label, see: Hanus Nykl, “Ivan Ilyin: Fascist
or Ideologue of the White Movement Utopia?” #emph[Studies in East
European Thought] (2024):
#link("https://doi-org.proxy.bib.uottawa.ca/10.1007/s11212-024-09631-8")[https:\/\/doi-org.proxy.bib.uottawa.ca/10.1007/s11212--024--09631--8].]
Yet, Ilyin was a complex figure who defied such easy labels. Analyses of
his work often contain words such as “contradictory” and “paradoxical.”
His biographer Igor Evlampiev, for instance, comments that “Ilyin was
undoubtedly a particularly paradoxical figure … \[who\] provides an
example of radical oscillations and contradictions.”#footnote[I. I.
Evlampiev, “Ot religioznogo ekzistentsializma k filosofii pravoslaviia:
dostizheniia i neudachi Ivana Il'ina,” in #emph[I. A. Il'in: Pro et
contra]. #emph[Lichnost' i tvorchestvo Ivana Il'ina v vospominaniiakh,
dokumentakh i otsenkakh russkikh myslitelei i issledovatelei], ed. I. I.
Evlampiev (St Petersburg: Izdatel'stvo Russkogo Khristianskogo
gumanitarnogo instituta, 2004), 8.] There is undoubtedly an
authoritarian element in Ilyin's work, but there are also many other
elements, including some that might be called “liberal.” Thus, Paul
Valliere concludes that “Ilyin was a statist and a monarchist, but to
deny that liberal values occupied a central place in his political
thought is a mistake. … A rule-of-law state in Russia was always his
goal.”#footnote[Paul Valliere, “Ivan Ilyin: Philosopher of Law, Force,
and Faith,” in #emph[Law and the Christian Tradition in Modern Russia],
eds. Paul Valliere and Randall A. Poole (London: Routledge, 2021), 321,
\325.] Others agree, describing Ilyin variously as a “liberal
conservative,” “a proponent of modern conservative liberalism,” or as
“belonging to the school of classical liberalism.”#footnote[N. P.
Poltoratskii, #emph[Ivan Aleksandrovich Il'in] (Tenafly: Ermitazh,
1989), 153. Egor Kholmogorov, “Pravyi gegel'ianets v okopakh
Stalingrada,” #emph[Samopoznanie] 2 (2015): 24. Liubov' Ul'ianova,
“Skrytoe slavianofil'stvo v tvorchestve Il'ina,” #emph[Samopoznanie] 2
(2015): 38.] Evlampiev goes so far as to call Ilyin's book #emph[On the
Essence of Legal Consciousness] “the culmination of the development of
Russian liberalism in the nineteenth and early twentieth
centuries.”#footnote[I. I. Evlampiev, #emph[I. A. Il'in] (St Petersburg:
Nauka, 2016), 180.]

Evlampiev admits, however, that what he calls Ilyin's liberalism was
very different from that generally understood in the West, creating
doubts as to whether the liberal label is any more valid than the
fascist one. In this vein, Mikhail Suslov contends that “Ilyin's ideas
about freedom, lawfulness, and limited power of the state could not be
understood in the context of classical liberalism, because they have
absolutely different philosophical foundations.”#footnote[Suslov,
#emph[Putinism], 64.] Indeed, Ilyin can be seen as a distinctly Russian
writer who rejected political philosophies such as liberalism and
fascism as Western constructs that were not relevant to Russian
conditions. Iury Lisitsa, who has edited over 30 volumes of Ilyin's
work, thus rejects the “liberal conservative” label given to Ilyin by
Evlampiev and others, and instead calls him a “conservative innovator,”
that is to say somebody who regarded existing institutions and ideas as
outmoded and sought to create new ones, but who at the same time sought
to ensure that those institutions and ideas were rooted in Russia's
particular circumstances. To this end, Lisitsa quotes Ilyin as saying,
“We must reject the very method of posing political questions … We must
think not of an ‘ideal,' or a ‘dream,' or a ‘doctrine,' but of the vital
task of restoring Russia. And we must understand Russia as a living,
organically historical and unique state whose heritage is Russian, and
which has its own special faith, and its own special traditions and
needs.”#footnote[Liubov Ul'ianova, “Il'in pokazal sushchnost' svobody
kak podobiia Bozhiia v cheloveke: interv'iu s Iuriem Lisitsei,”
#emph[Samopoznanie] 2 (2015): 11.]

Another way to look at Ilyin is as heir to a strand of Russian idealist
philosophy that combined elements of Western natural law with ideas
taken from Russian Orthodoxy. This strand of philosophy is associated
with names such as Boris Chicherin, Vladimir Solovyov, Pyotr Struve, and
Pavel Novgorodtsev, the last of whom served as Ilyin's academic
supervisor while Ilyin was studying at Moscow State University. In 1903,
Novgorodtsev edited a volume titled #emph[Problems of Idealism] in which
he, Struve, and other contributors attacked the prevailing positivism of
the era and sought instead to ground liberalism in morality,
specifically a morality founded on natural law. Novgorodtsev, for
instance, wrote of a “crisis of legal consciousness” that was the
product of a legal positivism that “reduced \[law\] to positive law,
that is, order of the State authority.” Consequently, Russians had no
respect for the law, regarding it as “the product of force.” The
solution, he claimed, was a “revival of natural law.”#footnote[P. I.
Novgorodtsev, “Ethical Idealism in the Philosophy of Law (On the
Question of the Revival of Natural Law),” in #emph[Problems of Idealism:
Essays in Russian Social Philosophy], ed., trans., and intro. Randall A.
Poole (New Haven: Yale University Press, 2005), 275--76.]

Both Struve and Novgorodtsev played an active role in the Union of
Liberation that sought to pressure Tsar Nicholas II into making
democratic constitutional reforms, and subsequently both joined the
leading liberal organization of the late Imperial period, the
Constitutional Democratic Party. Following the 1917 revolutions, they
swung politically to the right and became strong supporters of military
dictatorship. As Novgorodtsev said in May 1919, “If nothing is left our
democratism, then that is an excellent thing, what is needed now is
dictatorship, a force for creating authority.”#footnote[William
Rosenberg, #emph[Liberals in the Russian Revolution: The Constitutional
Democratic Party, 1917--1921] (Princeton: Princeton University Press,
1974), 416.] Ilyin's political and intellectual path, therefore, fitted
a pattern of Russian political and legal thinkers who were committed to
the concepts of freedom and law but became disenchanted with liberalism
and democracy in an era where liberal democratic states had a depressing
tendency to collapse into left or right-wing totalitarianism, and who
sought therefore to find an alternative model of social and political
development that would expand peoples' freedoms and rights while at the
same time preserving the order without which the question of freedoms
and rights becomes moot.

Comparisons have been drawn, for instance, between Ilyin and Soviet
mathematician and theologian Pavel Florensky, whose posthumously
published tract #emph[A Proposed Future State System] combined proposals
for a civil society and an authoritarian state in a manner that has been
said to be not dissimilar to Ilyin's proposals in his book #emph[Our
Tasks].#footnote[I. V. Florenskii, “Politicheskii platonizm
sviashchennika P. A. Florenskogo: ‘Predpolagaemoe gosudarstvennoe
ustroistvo v budushchem,'” #emph[Vestnik RKhGA] 24, no. 2 (2023): 146.]
That said, the concept of freedom receives little attention from
Florensky compared with Ilyin. A closer comparison might be with fellow
émigrés such as those who wrote for the religious journal #emph[Put'],
including Nikolai Berdyaev, Georgii Fedotov, and Fyodor Stepun. Despite
their many serious differences with Ilyin, they shared his concern for
freedom and his scepticism regarding liberal democracy. Fedotov, for
instance, declared that “democracy is too good for our cruel
times.”#footnote[Georgii P. Fedotov, “Nasha demokratiia,” #emph[Novyi
grad] 9 (1934): 12.] He predicted “the inevitability of dictatorship”
after the collapse of communism, commenting that “democracy is possible
now in Russia only through the methods of dictatorship,” due to the lack
of “intellectual growth of the popular consciousness.”#footnote[Georgii
P. Fedotov, “Problemy budushchei Rossii (part 2),” #emph[Sovremennye
zapiski] 45 (1931): 476--77.]

Fedotov's mention of the “popular consciousness” reflects the manner in
which he and other idealist émigré philosophers attributed the negative
consequences of the Russian revolution to the spiritual failings of the
Russian people, including their undeveloped legal consciousness, lack of
patriotism, and loss of religious faith. Ilyin shared this understanding
of events. For him, as for them, the spiritual side of human life took
priority over the material. Consequently, he saw the roots of Russia's
troubles as lying not in economic or other material factors but in the
corrupted spirituality of the country prior to the revolution. As he put
it: “The crisis that has brought Russia to enslavement, humiliation,
martyrdom, and extinction was at root not simply political and not
simply economic, but spiritual.”#footnote[I. A. Il'in, “Chto nam
delat'?” in Evlampiev, #emph[I. A. Il'in:] #emph[Pro et contra], 156.]
It followed that Russia's salvation lay in spiritual renewal, or rather
in the development of what Ilyin called an appropriate legal
consciousness (#emph[pravosoznanie]), a concept that might perhaps be
better translated as political and legal culture, as it went beyond
attitudes to law and incorporated such ideas as patriotism, honor,
loyalty, and religious faith.

Perhaps the clearest exposition of Ilyin's thinking on the matter is his
book #emph[On the Essence of Legal Consciousness]. This was originally
written in 1918, but Ilyin returned to it and amended it on various
occasions throughout his life, and it was eventually published in 1956,
two years after his death.#footnote[William Butler, “The Origins of
Il'in's Treatise on the Essence of Legal Consciousness,” in Ivan
Aleksandrovich Il'in, #emph[On the Essence of Legal Consciousness], ed.
and trans. William Butler, Philip T. Grier, and Paul Robinson, second
revised ed. (Clark, NJ: Talbot, 2023), 55--57.] The final version was
very similar to the original, suggesting that Ilyin did not
substantially change his views in the 35 years following 1918.

Ilyin's key argument was that a legal order depends not on positive law,
that is to say on the state enacting laws and forcing people to obey
them, but on the presence within the people of an appropriate legal
consciousness, of a sort that encourages them to obey the law of their
own free will because they recognize the validity and purpose of the law
and so want to obey it. This requires the state to bring positive law in
line as much as possible with natural law so that the law is seen to
respect citizens' natural freedoms and rights. At the same time, though,
it does not imply the existence of any particular form of government, be
it a republic, a monarchy, a democracy, a dictatorship, or anything
else. The legal consciousness of different peoples will differ, and
their form of government must differ too, so as to fit the national
legal consciousness.

To build this argument, Ilyin began with the claim that, “However great
the significance of the material factor in history … the human spirit is
never reduced, and never will be reduced, to a passive, non-acting
medium subordinated to material influences. … It is impossible to
organize the world of matter not having organized the world of the
soul.”#footnote[Il'in, #emph[On the Essence of Legal Consciousness],
\129.] This put Ilyin firmly in the idealist camp. He then continued by
noting that, “obedience to an external authority as a motive determining
the activity of a person is not commensurate with his spiritual dignity,
and, moreover, in #emph[all] spheres of spiritual life, in knowledge and
in morality, in art, in religion, and in law. The most fundamental and
profound essence of what humanity always fought for in the name of
#emph[freedom] consists in the possibility of #emph[autonomous and
voluntary self-determination] in spiritual life.”#footnote[Ibid., 156
(emphasis in the original).]

Ilyin based this claim on natural law, stating that humans are by nature
all isolated from one another, as nobody can know what is inside the
mind of another. Nor can anybody dictate what is in the mind of another.
Spiritually, all humans are unique and individual, and thus, Ilyin
wrote, “every person is #emph[distinctive and singular in his own
way].”#footnote[Ibid., 163 (emphasis in the original).] “Every human
being,” he continued, “has an intrinsic attraction toward a vital
#emph[self-sufficiency and self-activity], toward an autonomous
self-determination.”#footnote[Ibid., 197 (emphasis in the original).]
From this natural law, it followed that “#emph[freedom of will is
essential] … The fundamental dignity of the human consists in living a
spiritual life #emph[independently] of any heterogeneous encroachment
and pressure. … #emph[Free self-determination] in spirit is the deepest
law of this life.”#footnote[Ibid., 165 (emphasis in the original).]
Likewise, it followed that “the value lying at the foundation of natural
law is the #emph[worthy, internally self-sufficient and externally free]
life #emph[of the entire multiplicity of individual spirits] composing
humanity.” Having an “inspirated life”, Ilyin argued, is an “inalienable
right,” the loss of which “destroys the dignity of the
human.”#footnote[Ibid., 167 (emphasis in the original).]

Ilyin's focus here was on what one might call “inner freedom,” which
Ilyin referred to as “#emph[free self-determination] in spirit.” At the
same time Ilyin recognized that inner freedom is dependent on a degree
of outer, or external, freedom. People, he wrote, have “the right to
lead a spiritually dignified life.” This requires not merely the means
of life, but also “that #emph[leisure] which Aristotle required for a
person ‘free from nature,'” and “presupposes #emph[a right to
education],” and various other rights which follow
naturally.#footnote[Ibid., 167--68 (emphasis in the original).] These
other rights include a right to “legal guarantees of personhood and the
legal organization of a worthy life,” which in turn requires a “common
and just legal order.”#footnote[Ibid., 200.]

Having established this principle, Ilyin then used it to create a theory
of the state. In a true state, he wrote, “Political membership must be
#emph[consciously accepted] by each separate citizen and recognized by
him in an #emph[unfettered, free decision] … One cannot be a member of a
political union #emph[despite] one's own feelings. … A state possessing
such members … prepares its own disintegration.”#footnote[Ibid., 221--22
(emphasis in the original).] A stable state could not be founded on
coercion, he argued, because “the State … must live in the #emph[souls]
of people.”#footnote[Ibid., 223.] To this he added that the mission of
the state “consists in the #emph[protection and organization of the
spiritual life of the people belonging to a given political union]. The
protection of spirit consists in guaranteeing to #emph[the entire
population and to each individual] their natural right to a distinctive
self-determination in life, that is, the right to #emph[life] and,
moreover, to #emph[a worthy] life, outwardly free and inwardly
self-sufficient.”#footnote[Ibid., 227 (emphasis in the original).] “The
interest of the State consists in maintaining and realizing all
#emph[the natural rights] of all its citizens,” he
concluded.#footnote[Ibid., 232 (emphasis in the original).]

Ilyin did not believe, however, that these natural rights extended to
politics. Democracy did not guarantee that those elected to office would
be people inclined to protect others' natural freedoms and rights.
Indeed, if the national legal consciousness was insufficiently
developed, it was unlikely that they would be, and democracy could well
have catastrophic consequences. Ilyin wrote:

#quote(block: true)[
On the one hand, the State lives through #emph[the legal consciousness]
of the nation; whereas the essential characteristic of legal
consciousness is #emph[the capacity for self-governance]\; #emph[from
this, in theory, the State reduces to the self-governance of the
nation]. However, on the other hand, the sole and objective #emph[end]
of the State is so elevated and requires from the citizenry such a
#emph[mature legal consciousness], that historically speaking, nations
turn out to be #emph[incapable] of self-governance, of the realization
of that end. And thus is revealed the great discrepancy between the
ideal form of the State and its historical
manifestation.#footnote[Ibid., 235 (emphasis in the original).]
]

Overcoming this discrepancy, according to Ilyin, required that control
of the state be in the hands of the “best” people, in other words,
people with the most advanced legal consciousness, but on condition that
they used their power to develop the legal consciousness of the masses
and gradually brought them towards self-government. The emphasis here
was on gradualness. “A political union not observing this gradualness,”
wrote Ilyin, “risks its existence; it places its fate in the hands of
political infants or political imbeciles, and its days are numbered. In
this safe gradualness there is nothing politically reprehensible; on the
contrary, there is profound sense and political wisdom in it. On the
other hand, the behavior of ruling groups and classes is ruinous and
criminal if they use the incompetence of the people in order to replace
state interest with class interest, and keep the people's legal
consciousness as a low level.”#footnote[Ibid., 242.]

There was, therefore, no single form of the state that was suitable for
all nations---the appropriate form would depend on the condition of the
national legal consciousness, with fewer or more political freedoms and
rights depending on whether the people were ready for them. In the case
of Russia, Ilyin believed that the national legal consciousness was so
corrupted that self-governance would be impossible should communism
collapse. Consequently, post-communist Russia would need dictatorship,
not democracy, albeit a dictatorship that protected people's natural
rights and gradually elevated the legal consciousness of the people
until they became capable of self-government.

Ilyin elaborated further on these themes in his book #emph[The Path of
Spiritual Renewal], first published in 1937. In #emph[On the Essence of
Legal Consciousness], Ilyin had written continuously of the “spirit.” In
#emph[The Path of Spiritual Renewal], he continued to do so, declaring
that “Freedom is something #emph[for] the spirit and #emph[thanks to]
the spirit, freedom is something that matures #emph[in the spirit] and
comes #emph[from the spirit]. Outside the spirit, and contrary to the
spirit, it loses its meaning and its sacred significance.”#footnote[Ivan
Il'in, #emph[Put' dukhovnogo obnovleniia] (Moscow: Institut russkoi
tsivilizatsii, 2011), 93 (emphasis in the original).] At the same time,
though, he allied spirit more closely to religious faith than he
previously had, describing faith as “not simply some ‘sensation' or
‘feeling',” but something that “comes from the depths of the human
essence and consequently inevitably takes over the entire
person.”#footnote[Ibid., 70.] “For faith to arise and take flame and
acquire such strength,” he stated, “the person must be #emph[free] in
his faith,” which raised the questions: “What does it mean to be free?
What sort of freedom do I have in mind? Freedom #emph[from what and for
what?]”#footnote[Ibid., 71 (emphasis in the original).] Answering these
questions, Ilyin identified three types of freedom. These can be
translated as inner freedom, outer freedom, and political freedom. Of
these, inner freedom was the most important, followed by outer freedom,
and finally by political freedom.

Regarding inner freedom, Ilyin wrote that “Internally freeing oneself …
means #emph[instilling spiritual character in oneself].”#footnote[Ibid.,
79 (emphasis in the original).] According to Ilyin, “Freedom is
#emph[accessible] to the human spirit, and #emph[befits] it. #emph[For
spirit is the strength of self-definition towards betterment]. … Spirit
is a force that allows one #emph[to strengthen oneself and overcome] in
oneself what one rejects. … Freeing oneself above all means becomes
stronger than any inclination, any whim, any desire, any temptation, any
sin. … This is the #emph[negative] stage of self-definition. The
#emph[positive] stage follows: it consists of voluntarily and lovingly
filling oneself with #emph[the best].”#footnote[Ibid., 78 (emphasis in
the original).]

Ilyin described this inner freedom as “being #emph[master of one's
passions].”#footnote[Ibid., 79 (emphasis in the original).] This was not
the same as suppressing negative passions. Rather, just as a positive
legal consciousness implied voluntary recognition and obedience of the
law, so inner freedom consisted “of the person's passions voluntarily
serving the spirit … inner freedom is the spirit's ability to
independently see the eternal law, independently recognize its
authoritative strength, and independently put it into
life.”#footnote[Ibid., 79.] Or as Ilyin also put it, “freedom consists
in … having the inner strength and capacity to independently and
responsibly stand before God and serve the cause of God on
earth.”#footnote[Ibid., 86--87.]

Ilyin defined outer freedom differently. It was, he wrote, “Not the
freedom to do anything one wants, so that other people cannot hinder one
in any way, but #emph[freedom of faith, of opinion, and conviction], in
which #emph[other people do not have the right to intrude using forcible
directives or prohibitions]\; in other words, freedom from unspiritual
and counter-spiritual #emph[pressure], from #emph[coercion and
prohibition], from #emph[brute force, threats and
persecution].”#footnote[Ibid., 71 (emphasis in the original).] As such,
outer freedom is secondary to inner freedom because it exists to serve
inner freedom, but at the same time, it is extremely important, as inner
freedom is difficult to maintain in the absence of outer freedom. As
Ilyin put it, “outer freedom is given to humans specifically for
#emph[inner self-liberation]. … Outer freedom serves inner freedom, is
necessary for it and is given for it. #emph[Outer freedom is the natural
and necessary condition for the establishment and strengthening of inner
freedom].”#footnote[Ibid., 77, 80 (emphasis in the original).]

According to Ilyin, this outer freedom was necessary because, “Without
this freedom, human life has no meaning or worth, and this is the most
important thing. The meaning of life consists of loving, creating, and
praying. And without freedom, one cannot pray, or create, or love. … One
cannot pray by order or not pray due to prohibition. … One cannot love
God, motherland, and people by order, or stop loving them because of a
prohibition. … One can create only according to inspiration, from the
depths, freely. One cannot create by order, or not create due to a
prohibition.”#footnote[Ibid., 75.] He continued, “Non-recognition of
freedom \[of spiritual creation\] as the #emph[basis of life] and as
#emph[a spiritual necessity] brings humans down to the level of animals,
diminishes human dignity. It makes people #emph[lie] -- to God, to
themselves, to others. … Freedom is the air which faith and prayer
breathe.”#footnote[Ibid., 76 (emphasis in the original).]

Inner and outer freedom did not, according to Ilyin, make state power
redundant. But the purpose of the latter, he considered, was “to attend
to the inner freedom of the individual, to appeal to it, nurture it, and
strengthen it.”#footnote[Ibid., 89.] Similarly, political freedom also
existed to nurture and strengthen inner freedom, but it came with
limitations. Ilyin wrote:

#quote(block: true)[
Political freedom is something valuable and responsible, but only in so
far as spiritual, inner freedom lies behind it. … Political freedom is a
variety of outer freedom: the individual is allowed to independently
speak, write, vote, decide, and express his voice in public affairs. …
Political freedom is something bigger---in scope and
responsibility---from outer negative freedom, for the latter gives the
individual rights in his own internal affairs, rights concerning
#emph[himself] and his soul, but political freedom gives him rights over
the affairs #emph[of others], #emph[rights over others]. This means that
political freedom presupposes a greater maturity in the person to whom
it is given. … #emph[Outer freedom is given to people so that they can
internally nurture and liberate themselves. Political freedom
presupposes that people have already nurtured and liberated themselves,
and so is given to them so that they can nurture others towards
freedom].#footnote[Ibid., 90 (emphasis in the original).]
]

From this, Ilyin concluded: “It follows that here there cannot be
limitless freedom. … There is a minimum of inner freedom below which
political freedom loses its sense and becomes an entirely destructive
principle. … ‘To gift' a people political freedom sometimes means
bringing it to temptation and putting it on the path towards
death.”#footnote[Ibid., 92.]

To summarize, freedom to Ilyin was fundamentally spiritual in nature,
meaning that he considered inner freedom to be the most important of all
freedoms. In Ilyin's logic, however, inner freedom depends on some
degree of outer freedom, for which reason the latter is also required.
It may also benefit from some degree of political freedom, but this is
less important and is only relevant to the extent that it supports inner
freedom. Furthermore, because political freedom inherently involves
making decisions about other people, which may potentially restrict
their freedom, it requires a mature legal consciousness and may properly
be restricted where such legal consciousness is absent.

Ilyin put forward similar arguments in articles he wrote for popular
audiences. These included articles written in the 1930s for German and
Swiss newspapers, and articles written in the late 1940s and early 1950s
for the White Russian military veterans organization ROVS, the latter of
which were collected after his death and published as a book titled
#emph[Our Tasks]. In these articles, Ilyin demonstrated a passionate
concern for freedom. For instance, in an article entitled “The Free
Person,” Ilyin wrote that:

#quote(block: true)[
“\[C\]oerced life and coerced labour are obsolete, and cannot be brought
back. All history shows that the labor of the enslaved is economically
unproductive and inferior; that the politically repressed lack character
and lose their honor; that literature when compelled seems vulgar and
pitiful, lacking in spirit, and dead; that one cannot prohibit religious
convictions, nor can one command them. Life without creative initiative,
without independence and freedom becomes complete~#emph[slavery]~and
the~#emph[galleys]. God save us from this!”#footnote[Ivan Il'in,
“Svobodnyi chelovek,” in Il'in, #emph[Novaia natsional'naia Rossiia],
635 (emphasis in the original).]
]

He then continued: “the greatest good on earth is not at all embodied in
the state, and is not accomplished by the state. The state exists to
regulate and encourage the free creation of man, and not to take it
away. … Man is not a machine, but a living spiritual organism; and the
laws of this organism must be respected and preserved.”#footnote[Ibid.,
\635.]

Similarly, in an article titled “Freedom,” Ilyin wrote, “without freedom
life has #emph[no meaning, no dignity]. … Every legal order rests on the
recognition of the person as #emph[a subject of law], that is as a
self-directing, free center, possessing its own volition. … The law can
threaten unpleasant consequences, but that is all. #emph[In fact, an
enormous] dose of freedom, i.e. spiritual self-determination and
self-direction, lie at the foundation of any legal
order.”#footnote[Ibid., 153--54 (emphasis in the original).] And in an
article titled, “About the Eradication of Liberals,” he wrote:

#quote(block: true)[
Life … cannot grow and flourish other than #emph[from itself], according
to the secret laws of its inner expediency. … The same is true of social
life. … Politics that tries to #emph[abolish] or #emph[replace the
free], yes #emph[free growth and flourishing] of economic and spiritual
forces will be absurd, ruinous, and detestable.

Prescribe forms of art and music and only talentless slaves will come
forward to sell their hackneyed rubbish. Prescribe the method and
deductions of science, and in the emptied universities all you will have
will be dark adventurers hired as ‘red (or black) professors.' …
Understand this: life is like a garden: it grows #emph[itself]\; and
government is like a gardener: it can only and should only direct this
#emph[free process].#footnote[Ivan Il'in, “Ob iskorenenii liberalov,” in
Il'in, #emph[Novaia natsional'naia Rossiia], 197--98 (emphasis in the
original).]
]

#emph[Our Tasks] contains similar messages. Some passages in the book
bear a striking resemblance to parts of #emph[On the Essence of Legal
Consciousness], suggesting that he referred to the latter when writing
the articles that make up the former.#footnote[For an example see Paul
Robinson, “Introduction,” in Il'in, #emph[On the Essence of Legal
Consciousness], 6--7.] There are some differences between the two works
in that #emph[Our Tasks] is somewhat more strident in its negative views
of Western-style liberal democracy as well as in its denunciations of
Western hostility towards Russia. But in general, Ilyin's position at
the end of his life (when he wrote #emph[Our Tasks]) was not
substantially different from that at the beginning of his career (when
he wrote #emph[On the Essence of Legal Consciousness]).

In #emph[Our Tasks], Ilyin laid out an organicist rationale for the
existence of freedoms and rights. He wrote:

#quote(block: true)[
Freedom befits people for two reasons: 1) on account of the fact that
they are living organisms; 2) on account of the fact that they are
living souls. … Every living organism (from a plant to a human) is
#emph[an independent being] … The organism lives according to its own
internal laws. By studying these laws … one can to some extent direct
the organism's life, but one cannot extinguish its independence without
killing it. The natural freedom of the human being consists in this,
that he is #emph[independent] by nature, he creates his own life---in
sickness and in health, in his needs and dislikes, in filling his belly,
in love and reproduction. … This independence cannot be replaced: this
cannot be achieved by hypnosis, by diktat, or by fear. All such attempts
are doomed to fail. … The communists tried to do this … In the future
Russia … the individual creative instinctive of the person must be
recognized, encouraged, spiritually disciplined, and built on freedom …
But the human is not only a living organism: he is also a living spirit.
The spirit needs freedom of faith and love, contemplation,
conviction.#footnote[I.A. Il'in, #emph[Nashi Zadachi: stat'i 1948--1954
gg.] (Paris: Izdanie Russkogo Obshche-Voinskogo Soiuza, 1956), vol. 1:
147 (emphasis in the original).]
]

Ilyin's focus here was primarily on inner freedom.

As he put it in #emph[Our Tasks]: “The politics of the future must look
at people soberly and take them as they are. They will think of freedom
primarily as inner freedom. … People need freedom and it is sacred to
them. But this freedom is found through God, in the soul, conscience,
feelings of spiritual worth, and in the service of the people whose
blood one shares.”#footnote[Ibid., 68, 125.] When it came to outer and
especially political freedom, Ilyin retained the view that he had
expressed continually over the previous decades, namely, that “freedom
will always have its lawful limits; the measure of freedom among
different peoples will be different and will depend on the legal
consciousness implanted in the people.”#footnote[Ibid., 130.] Peoples
with mature legal consciousness would be able to enjoy considerable
political freedom, but those without it would not. He wrote: “Political
freedom by itself does not ennoble people, but only unties their hands,
frees them to be what they are, with all their inclinations, interests,
passions, and vices. … People are complicated … Freedom doesn't change
them for the better but only reveals (in the photographic sense) all
their features, inclinations, and passions.”#footnote[Ibid., 67.] In
Ilyin's eyes, the Russian people's legal consciousness was far from
being mature enough to enjoy full self-government. Giving them political
freedom would simply allow their basest passions to come to the fore.
Following the collapse of communism, he argued, Russia would face chaos.
This would be no time for elections. Rather, a strong government would
be needed. Democracy would not be possible until the moral decay of
communism had been overcome, a process that would likely take many
years.#footnote[Ibid., 20--25.] As he wrote: “After its \[communism's\]
fall, the long-standing moral debauchery will be overcome slowly. … And
until such time as the spiritual renewal is completed, we must foresee
that any attempt to introduce a democratic order will lead either to mob
rule … or to a new right-wing totalitarian tyranny. Democrats who don't
think about this and can't foresee it, don't understand the essence of
either democracy or totalitarianism.”#footnote[Ibid., 25.]

This did not mean, however, that Ilyin supported unlimited government.
On the contrary, he considered this very harmful. His envisaged
dictatorship was to be a limited one that guaranteed considerable civil
liberties to its citizens, even while not necessarily granting all of
them political ones. Thus, he wrote in #emph[Our Tasks]: “The strong
power of the future Russia must not be outside the law and above the
law, but formed according to law and serving the law … Russia needs a
power that is not arbitrary, not tyrannical, not limitless. It must have
legal limits, authority, obligations, and prohibitions.”#footnote[Ibid.,
\309.]

Ilyin said little about what this would mean in practice. One exception
was a passage in #emph[Our] Tasks which states: “The right to freedom of
belief is a sacred and inviolable right. It belongs to all Russian
citizens … All Russian citizens … are equal before the law … Nobody can
be prosecuted or punished by a court except on the basis of law … Nobody
can be arrested, taken into custody, or otherwise deprived of freedom
other than according to law … The homes of every Russian citizen are
untouchable … Property is untouchable.” Citizens, according to Ilyin,
were to have the right to form associations for the pursuit of goals not
contrary to the fundamental laws of the state, and the right to form
political parties.#footnote[Il'in, #emph[Nashi Zadachi], vol. 2.
415--16.]

Ilyin laid out these principles in more detail in a draft constitution
for a future Russia drawn up near the end of his life. In this, he
provided specifics of the freedoms and rights that he envisioned
Russians enjoying. In a section of the constitution on “rights and
obligations,” the first right to be mentioned was that “The right to
freedom of belief is a sacred and inviolable right.”#footnote[I. A.
Il'in, #emph[Osnovy gosudarstvennogo ustroistva: proekt osnovnogo zakona
Rossii] (Moscow: Rarog, 1996), 70.] The fact that this right came first
and was said to be “inviolable” was no accident. It reflected the
primacy that Ilyin gave to matters of the spirit.

Nevertheless, the draft constitution did list some outer and political
freedoms and rights, though in many cases they were somewhat
circumscribed in that exceptions were permitted in some circumstances.
For instance, Ilyin wrote: “All Russian citizens whose rights have not
been limited by law or the courts are equal before the law … Nobody can
be subjected to prosecution, judgment, or punishment other than on the
basis of a law published prior to the deed in question. … The home of
every Russian citizen is inviolable. Searches or seizures in their homes
are permitted only in situations defined by law.”#footnote[Ibid.,
71--72.] On the one hand, this gave citizens some clear rights, but on
the other hand, had the constitution ever been enacted, much would have
depended on the exact “situations defined by law.” The same is true of
other rights listed by Ilyin, as below:

#quote(block: true)[
Property is inviolable. Forcible alienation of movable and immovable
property is permitted only when it is necessary for some state benefit.
It must be carried out in a legal manner and with just compensation,
taking into consideration the interests of the person in question. …
Russian citizens have the right to hold meetings for goals that are not
hostile to religion, morality, the fatherland, and the laws. … Within
the boundaries laid down by the Fundamental Laws (Part 1) and by special
laws, everyone can express his opinions in words or writing, and
distribute them in written or published form. … Russian citizens have
the right to form nonpolitical organizations and unions for goals that
do not contradict the Fundamental or other laws of the
state.#footnote[Ibid., 73--74.]
]

Ilyin thus envisioned a limited, law-based state in which citizens
enjoyed clear rights and freedoms. He did not, however, imagine this to
be a Western-style liberal democratic state. Rather, he had in mind a
system in which executive power would be concentrated in the hands of a
hereditary monarch who would be supported by an elected legislature.
Citizens would have the right to form political parties, but members of
those parties would not be permitted to hold public office. Instead,
members of the legislature would be selected from those citizens whose
record of public service indicated their suitability for
politics.#footnote[Ibid., 74.] This theoretically would guarantee that
the government served the national interest as a whole, not the interest
of any individual class or party. In this way, the system Ilyin imagined
was a monarchical system with civil liberties for its citizens and some
democratic trappings, not too far removed from what had existed in
Russia between 1905 and 1917.

To conclude, Ilyin founded freedoms and rights on two claims that he
considered to be natural law. The first was that humans are not machines
subject to the whims of others but organisms that develop according to
their own inner logic, and whose inner nature must therefore be
respected if they are to survive and flourish. The second was that
humans are autonomous spirits. Consequently, respect for their spiritual
autonomy is essential for their dignity. To these, Ilyin added some
consequentialist arguments for freedoms and rights. The first was that
human creativity derives from free spirit, and that consequently
suppression of freedom would destroy that creativity. The second was
that the legal consciousness that was a necessary foundation for a
stable political and legal order was impossible if the state abused
people's natural rights and so led them to regard the state and the law
as arbitrary rather than as something to be freely obeyed. The purpose
of the state, in Ilyin's eyes, was precisely to nurture and protect
inner freedom. A state that failed to do so was doomed.

This logic led Ilyin to conclude that freedom was necessary for human
flourishing. His spiritual focus meant, however, that his focus was
primarily on inner freedom, and only secondarily on outer freedom, with
political freedom coming a distant third. This does not mean, however,
that Ilyin considered outer and political freedom unimportant. As noted,
Ilyin considered a large amount of outer freedom to be necessary for the
preservation of inner freedom. Similarly, although Ilyin believed that
political freedom could rightly be limited, this did not imply that the
state had a right to do anything it wished. Thus, he wrote: “strong
government is not at all the same as totalitarian government. … For a
strong state depends not on the bayonet, not on terror, but on the
government's authority; not on threats and punishments, but on the free
loyalty of the people.”#footnote[Il'in, #emph[Nashi Zadachi], vol. 1,
307--308.] “Totalitarianism is godless,” he remarked.#footnote[Il'in,
#emph[Osnovy gosudarstvennogo ustroistva], 143.]

Where this places Ilyin on the political spectrum is not clear. On the
one hand, his belief in individual freedom, the rule of law, and limited
government is hardly fascist and might seem more obviously liberal. On
the other hand, his sceptical view of political freedom and his call for
a dictatorship in post-communist Russia appear to place himself
somewhere else. Traditional political labels do not fit Ilyin well.
Perhaps this is because labels such as liberal, conservative, socialist,
and fascist tend to refer to a set of political, social, and economic
institutions, whereas Ilyin's primary concern was less with these than
with questions of the spirit. It is clear, though, that focusing
entirely on the authoritarian strands of Ilyin's thought, as so many
commentators do, provides a distorted picture of someone who repeatedly
stressed the vital importance of freedom for the flourishing of the
human person.<end-of-robinson>
