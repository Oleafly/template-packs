#import "elements.typ": *

#counter(footnote).update(0)
#abstract(
  [Dissenting Views],
  abstract-subtitle: [Secular Liberals, Soviet Christians, and Socialist Humanism in
the Brezhnev Era],
  abstract-author: [Megan Brand],
  [
Are foreign affairs leaders bound by anything other than national
interest? Drawing on the work of Hugo Grotius, this article elucidates
the origins of rights stemming from the social nature of humans with
accountability to universal law binding on all. Are there enduring
natural rights that all leaders in international affairs are bound to
uphold? If so, from where do they arise, and how are they held
accountable? How might an idea of rights arising from the social nature
of man inform action in international affairs? For Grotius, state action
should do right, not merely align with power. For Grotius, doing right
is what separates the law of nature for man from more general laws of
nature such as those that apply to beasts, even when doing right might
materially disadvantage oneself; right action is morally best. This
direction to do right derives from mankind's unique knowledge of good
and evil and is evident through his analysis of state practice on
poison, killing, and unequal alliances.
    ],
  abstract-keywords: [Russia, Ukraine, and the Law of Nations]
)

// This section sets the headers for the article
#set page(
  header-ascent: 40%,
  header: context {
    set text(8pt, font: "IBM Plex Sans", stretch: 75%, weight: 400)
    let first-page = locate(<first-page-brand2>).page()
    if here().page() == first-page [
      #grid(
        columns: (45%, 45%),
        gutter: 10%,
        align(left)[
          NORTHWESTERN UNIVERSITY STUDIES IN RUSSIAN\
          PHILOSOPHY, LITERATURE, AND RELIGIOUS THOUGHT
        ],
        align(right)[
          Volume 2 (2024): #first-page#sym.dash.en#locate(<end-of-brand>).page() \
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

#heading(level: 2)[Whose Right?:]
#v(1em)
#subtitle([The Law of Nature and the Law of Nations in
Grotian Legal Genealogy])
<first-page-brand2>
#v(1em)
#author[Megan Brand]

Russia's military invasion of Ukraine on February 24, 2022, initiated a
land war in Europe that shocked much of the world. It was shocking not
only because it violated a treaty and an independent state's
international legal sovereignty, but also because it was an affront to
the law of nations, to what was understood as acceptable action in the
day-to-day affairs among countries, and in this case, specifically among
great powers in Europe. A land war by a great power in Europe had come
to be almost unthinkable after the fall of the Soviet Union and in the
following decades, when new territorial boundaries were agreed upon by
newly formed states as well as by Russia itself.#footnote[Treaty between
Ukraine and the Russian Federation on the Ukrainian-Russian State
Border, Concluded in Kiev, January 28, 2003, United Nations Treaty
Series Vol. 3161, Registration No. 54132; Treaty on Friendship,
Cooperation and Partnership between Ukraine and the Russian Federation,
Concluded in Kiev May 31, 1997, United Nations Treaty Series Vol. 3007,
Registration No 52240.] Russia's 2022 military aggression, bolstered by
revisionist arguments that attempted to historically legitimize the
redrawing of Russian borders,#footnote[Vladimir Putin, “On the
Historical Unity of Russians and Ukrainians,” July 12, 2021,
#link("http://en.kremlin.ru/events/president/news/66181").] challenges
the order of the international state system in fundamental
ways.#footnote[Hathaway calls Russia's aggression “the most fundamental
challenge to the modern international legal order since World War II.”
Oona Hathaway, “International Law Goes to War in Ukraine,” #emph[Emory
International Law Review] 38, no. 3 (2024): 576.] Treaty-based
agreements recognized by states and institutionalized through observance
by international organizations, civil society groups, and states
themselves have become the mode of state recognition and provide a
degree of stability to contentious issues of territorial borders. Yet
when he launched the invasion, Vladimir Putin declared, “the~old
treaties and~agreements are no longer effective.”#footnote[Vladimir
Putin, “Address by the President of the Russian Federation,” February
24, 2022, http:\/\/en.kremlin.ru/events/president/news/67843.]

Russia's aggression and the international response raise, in dramatic
form, the perennial question of might versus right in international
affairs. The law of nations, which this article explicates in terms of
Grotian legal philosophy, can be summarized simply as the way states
conduct their affairs in the international sphere. But the law of
nations is also linked to norms, which form broader ideas of
constitutionalism, of acceptable practice of what makes the rules of the
day operate and stick, beyond what is strictly and technically written
in the words of a document. Documents leave room for interpretation,
which is not limited to legal interpretation but moves beyond to
construction, how actors in a constitutional system view their
obligations, duties, and limits and how different institutions within a
constitutional system resolve conflicts over these obligations, duties,
and limits. In terms of constitutional theory, Keith Whittington argues
for the importance of norms in shaping meaning, defining constitutional
construction as “the method of elaborating constitutional meaning in
this political realm” and where constructions “make normative appeals
about what the Constitution should be.”#footnote[Keith E. Whittington,
#emph[Constitutional Construction: Divided Powers and Constitutional
Meaning] (Cambridge, MA: Harvard University Press, 1999), 1, 121.] What
becomes constitutionally acceptable is what evolves out of practice.
Extending the idea of constitutionalism to the society of states is not
seamless, but scholars have long argued that different “international
orders…can indeed exhibit constitutional characteristics.”#footnote[G.
John Ikenberry, #emph[After Victory: Institutions, Strategic Restraint,
and the Rebuilding of Order after Major Wars] (Princeton: Princeton
University Press, 2001), 6.] John Ikenberry further defines order as the
“'governing' arrangements among a group of states, including its
fundamental rules, principles, and institutions,” which are not far off
from Grotian conceptions of the law of nations.#footnote[Ikenberry,
#emph[After Victory], 23.]

Russia's war in Ukraine forces us to think anew about what is and ought
to be (im)permissible in international affairs between states. A Grotian
legal philosophy would argue that the laws of nature apply to human
action at war, and that these laws are unchanging. Because Hugo Grotius
grounds his legal philosophy in what he sees as unwavering reality and
truth, the law of nature continues to apply to contemporary
international relations, including the war in Ukraine. The law of nature
is not a social contract-based theory, requiring buy-in from parties on
all sides of the issue at hand to apply. Rather, the law of nature is
anthropological, embedded into humankind's very nature, and to which
humans are bound by the author of nature and can observe this truth
through facts of human sociability that necessitates relations with
other humans. At the same time, Grotius is no idealist when it comes to
law's application in the international sphere. For his legal theory,
obligation arises from mutual consent, and his law of nations takes into
account the actual day-to-day dealings and actions by states. He
distinguishes the law of nations from the law of nature, which blends
normative and descriptive approaches to analyzing human action. It could
be that a commander orders an attack, say on children, that is against
the law of nature. The fact that people act against the law of nature
does not negate its existence. Or it could be that the positive law
permits an action against the law of nature. Even if permitted by the
positive law, the law of nature condemns said action. Perhaps the most
relevant application of Grotius to contemporary conflict and war is his
broad understanding of the law of nations. For Grotius, the law of
nations ought to be the positive law working out of the law of nature.
However, because humans err in this application, the law of nations is
not always what it ought to be. The law of nations may turn into what
states take to be acceptable modes of interaction with each other,
which, as this article discusses later, are often at odds with the law
of nature.

Russia's war on Ukraine has potentially altered the law of nations. As
Grotius argued, “a single people can change its determination without
consulting others; and even this happens, that in different times and
places a far different common custom, and, therefore, a different law of
nations (improperly so called), might be introduced.”#footnote[#emph[De
Jure Belli ac Pacis] (DJBP) 2.8.1.2. References to Hugo Grotius,
#emph[The Law of War and Peace], unless otherwise noted, use the Francis
W. Kelsey translation (1925), reprinted in James Brown Scott, ed.,
#emph[The Classics of International Law] (Washington, D.C.: Carnegie
Endowment for International Peace, 1984). It will be abbreviated as
DJBP.] A land war in Europe, in direct violation of treaties agreed to
by Russia, shook the foundations of a liberal order in Europe and the
West. It has called into question the extent to which these territorial
agreements apply. Each violation of previously understood limits on war
alters the law of nations for today, especially when other states take
the side of Russia. Relations between states is an iterative process,
based in part on expectations and limits about each other's behavior.
While the idea of sovereignty has limited when states will intervene in
the domestic affairs of other states, there are exceptions to
this---most notably genocide---that states worldwide have recognized.
State practice has formed an expectation in the law of nations: if you
annihilate a people group within your state, other countries might
intervene to stop it. Russia's aggression undermines the previously
understood international legal sovereignty wherein states agree to a set
of borders and to the recognition of a state as pertaining to those
borders.#footnote[Stephen Krasner defines international legal
sovereignty as, “the practices associated with mutual recognition,
usually between territorial entities, that have formal, juridical
independence.” Stephen Krasner, #emph[Sovereignty: Organized Hypocrisy]
(Princeton: Princeton University Press, 1999), 3.] Russia has violated
territorial sovereignty by its military action. Even further, it has
violated the idea of international legal sovereignty by historical
revisionism, claiming Ukraine as its own and calling its aggression a
“special military operation.”#footnote[On the term “special military
operation,” see Vladimir Putin, “Address by the President of the Russian
Federation,” February 24, 2022,
#link("http://en.kremlin.ru/events/president/news/67843"). Putin
described Ukraine's sovereignty as possible “only in partnership with
Russia.” See Vladimir Putin, “On the Historical Unity of Russians and
Ukrainians,” July 12, 2021,
#link("http://en.kremlin.ru/events/president/news/66181").]

#strong[Grotius in Russian Legal Thought]

In light of recent events, it may seem paradoxical that Grotius
exercised influence on the development of Russian legal thought, from
philosophers of natural law like Pavel Novgorodtsev to the Soviet
understanding of the law of the sea.#footnote[Randall A. Poole, “Pavel
Novgorodtsev and the Concept of Legal Consciousness in Russian
Philosophy of Law,” #emph[Istoriko-filosofskii ezhegodnik]
(#emph[History of Philosophy Yearbook]) (Institute of Philosophy,
Russian Academy of Sciences, Moscow) 37 (2022): 84--123, esp. 92; W. E.
Butler, “Grotius' Influence in Russia,” in #emph[Hugo Grotius and
International Relations], ed. Hedley Bull, Benedict Kingsbury, and Adam
Roberts (Oxford University Press, 1992), 266,
https:\/\/doi.org/10.1093/0198277717.003.0009.] At the same time,
important distinctions exist between Grotius' philosophy of
international law, which emphasizes the universal, social nature of man,
and historic Russian perspectives on international law. An enduring
debate is the universality of the law of nature applied in international
relations. Related to this question is how Eurocentric was and is the
law of nations. Building on that question is the debate about Russia's
place in the law of nations: to what extent is Russia European? If the
law of nations is seen as an exclusive marker of “civilized nations,” as
the Russian legal theorists Peter Shafirov and Friedrich Martens
maintained, rather than a universal idea applicable to all, where does
Russia fit?#footnote[Peter Shafirov wrote on just war theory in relation
to Russia's early 18#super[th] century war with Sweden: Peter Shafirov,
#emph[A discourse concerning the just causes of the war between Sweden
and Russia: 1700--1721], intro. William E. Butler (Dobbs Ferry, NY:
Oceana Publications, 1973). Friedrich Martens was a legal theorist,
professor, and diplomat to the Hague, for which the 1899 Martens Clause
is named. L. Malksoo summarizes Shafirov and Martens' views in “The
History of International Legal Theory in Russia: A Civilizational
Dialogue with Europe,” #emph[European Journal of International Law] 19,
no. 1 (February 1, 2008): 216--219, 220--222. Grotius' universal claims
about human nature also diverge from claims by theorists like Fyodor
Ivanovich Kozhevnikov (1893--1998), a Moscow State University Law Dean
and International Court of Justice judge. See L. Malksoo, “The History
of International Legal Theory in Russia,” 226-- 228.] Was the law of
nations applicable only in Europe, and if so, has Russia ever counted as
European in legal tradition? Beyond geography is the religious dimension
of different theories of the law of nations. Was the law of nations as
put forward by theorists like Grotius merely applicable to Christian
rulers, and if so, did that apply across Catholic, Protestant, and
Orthodox traditions, or was it siloed into one of them? While this
article restricts itself to the Grotian legal genealogy that explains
the emergence of the law of nations, the significance of this Grotian
approach and universality matters for the historic and continuing
debates about the place of Russia in the society of states.

Grotius' #emph[On the Law of War and Peace] did not appear in full in
Russian until 1956, which might seem to preclude centuries of influence,
but Russian intellectuals had access to his writings in Latin and
French.#footnote[Butler, “Grotius' Influence in Russia,” 258--61.] The
study of natural law had early support in the late 17#super[th] and
early 18#super[th] centuries under Peter the Great, but for political,
religious, economic, and social reasons, it did not become embedded in
practice during that period in Russia as it had in other parts of
Europe, although it took root at a theoretical level by the late
19#super[th] century.#footnote[Randall A. Poole, “Introduction: A
Russian Conception of Legal Consciousness,” in #emph[Law and the
Christian Tradition in Modern Russia], ed. Paul Valliere and Randall A.
Poole (London and New York: Routledge, 2022), 1--20. For summary of
natural law reception in Russia in the 17#super[th]-18#super[th]
centuries see Dmitry Poldnikov, “The Legacy of Classical Natural Law in
Russian Dogmatic Jurisprudence in the Late 19th Century,” #emph[Journal
on European History of Law] 4 (2013): 73.] Russian international law
held varying perspectives on the universality of natural law, a question
that played into debates about Russia's in-group or out-group belonging
to Europe. The question of the universality of natural law also had
religious variation that separated Russia from Europe. While just war
positions are not monolithic, it is fair to say that just war theories
generally argue that just war requires justice in going to war and just
actions in war. A consequence of the idea of justice within war is
limited atrocities; even when hostilities are entered into for just
causes, in theory, actions must abide by certain principles, such as
proportional responses. By contrast, Russian theorists like Mikhail
Taube, chair of international law at Imperial St. Petersburg University
before his 1917 exile, characterized Russian approaches to war as
Caesaropapist, where “all wars by Byzantium were legitimate,” with a
consequence that such wars “were among the cruelest and there were no
constraints of law with respect to the enemy.”#footnote[Malksoo, “The
History of International Legal Theory in Russia,” 214, 223.] Grotius
enters into this conversation in an interesting way; his law of nature
is normative, arguing for limits on war. However, his description of
actual practice across nations acknowledges many situations under which
cruelty and atrocities occur. Grotius' claimed objectivity of human
moral knowledge, combined with his analysis of actual state practice,
carves out its own space in theories of war. Understanding Grotian legal
genealogy is therefore productive for teasing out similarities and
differences with Russian approaches to the law of nations and for
setting the stakes for when the law of nations changes.

By the early 20#super[th] century, natural law's objectivism proved a
generative response to legal positivism, leading to renewed interest by
Russian scholars like Pavel Novgorodtsev and Evgeny
Trubetskoi.#footnote[Poldnikov, “The Legacy of Classical Natural Law in
Russian Dogmatic Jurisprudence in the Late 19th Century,” 74.] Around
this time, a Russian publication summarized #emph[On the Law of War and
Peace], critiquing Grotius' theological perspective.#footnote[Butler,
“Grotius' Influence in Russia,” 260.] Grotian legal thought flows from
his human anthropology grounded in theological perspectives, which the
present article examines in the area of the meaning of the law of nature
and the law of nations. Russian critiques of Grotian theology carry over
to legal thought because theological presuppositions ground Grotius'
legal philosophy. Analysis of Grotian legal thought that neglects to
factor in Grotius' presuppositions about human nature, right reason, and
the sociability of man arising from the author of nature will fail to
accurately apply his philosophy of law. This article explains how these
distinctions across levels of law (laws of nature and positive law)
interact in Grotian legal philosophy and demonstrates how these
frameworks apply to Grotian thought on poison, killing, and unequal
alliances.

The early 20#super[th] century Russian interest in natural law dwindled
when the state persecuted intellectuals whose views diverged too far
from Marxism.#footnote[Poldnikov, “The Legacy of Classical Natural Law
in Russian Dogmatic Jurisprudence in the Late 19th Century,” 74.] Yet
decades later, the Soviet Union took up arguments on the world stage
that were reminiscent of Grotian arguments. Specifically, during
negotiations on the Law of the Sea Convention, the Soviet Union's
position on free navigation through straits rested on the idea of
“international navigation as immutable, almost natural, laws regulating
international relations and trade at sea.”#footnote[Pierre Thevenin, “A
Liberal Maritime Power as Any Other? The Soviet Union during the
Negotiations of the Law of the Sea Convention,” #emph[Ocean Development
and International Law] 52, no. 2 (2021): 215.] In some ways, the ebbs
and flows of Russian interest in natural law generally and in Grotius
specifically speak to the enduring relevance of Grotian thought in
international relations. At times of negotiation across the shared
global resources, like the sea, and in considering questions of enduring
moral import, like killing in war, Grotius' writings continue to offer
arguments that states find useful and compelling. When and why states
take up Grotian arguments may indicate a deep interest in cooperation in
a certain issue area, which is one reason why articulating the
difference between the law of nature and the law of nations in Grotian
thought is foundational to understanding the application of his many
arguments.

This article distinguishes between the law of nature and the law of
nations in Grotius' legal genealogy, which is necessary to be able to
interpret his arguments on actions in international affairs. For
Grotius, an act may be in accord with the law of nature but not the law
of nations, in accord with the law of nations but not the law of nature,
or in accord with both or neither. Grotius' discussions of war, killing
by poison, and alliances all require understanding which form of right
he is referencing. The Grotian law of nature is rooted in the social
nature of man, stemming from a divine creator. The law of nations is the
practice of states and the positive law working out of the law of nature
between states, several steps removed, and like other areas of positive
law, may or may not accord with a view of the law of nature. Grotian law
of nations should be understood as state practice, which will look
different today from his own international relations context, yet to
remain true to his legal philosophy, it should remain grounded in a law
of nature that is underlaid with principles of right, justice, and
mutual sociability. This article references the rights turn that
Grotius' legal theory facilitated, analyzes Grotius' legal genealogy in
the Prolegomena of his #emph[On the Law of War and Peace], and
demonstrates the distinction Grotius maintains between the law of nature
and law of nations by reviving Grotius' commentary on poison, killing,
and unequal alliances.

#strong[The Grotian Rights Turn in International Legal Thought]

Grotius, known as the “father of modern international law” or the
“Miracle of Holland,” was a Dutch lawyer who wrote about a hundred years
after Martin Luther's posting of the Ninety-five Theses. He wrote
extensively on laws between nations, his most well-known work being the
massive, #emph[On the Law of War and Peace].#footnote[See note 8 above.
See also Randall Lesaffer and Janne E. Nijman, eds., #emph[The Cambridge
Companion to Hugo Grotius] (Cambridge: Cambridge University Press,
2021), xix.] A learned person with gifts and interests in many areas, he
also wrote on theology and was embroiled in theological controversies
that even landed him in prison and in exile.

Grotius was born in 1583 and lived until 1645. Early in his career, he
wrote on the law of the sea and trade.#footnote[These include #emph[De
jure praedae commentarius], available today as Hugo Grotius, #emph[De
Jure Praedae Commentarius: Ex Auctoris Codice Descripsit Et Vulgavit
Hendrik Gerard Hamaker With an Unpublished Work of Hugo Grotius's]
(Lawbook Exchange Ltd, 2015), and #emph[Mare liberum] (1609), English
edition Hugo Grotius, #emph[The Free Sea], trans. Richard Hakluyt
(Indianapolis: Liberty Fund, 2004). See historical background in Edward
Gordon, “Grotius and the Freedom of the Seas in the Seventeenth
Century,” #emph[Willamette Journal of International Law and Dispute
Resolution] 16, no. 2 (2008): 252--69.] He became a public prosecutor in
1607, giving him a foray into the civil and criminal legal system in
Holland at the time. He transitioned from the judicial branch to the
executive branch in 1613 when he became a legal advisor.#footnote[Henk
Nellen, “Life and Intellectual Development: An Introductory Biographical
Sketch,” in #emph[The Cambridge Companion to Hugo Grotius], ed. Randall
Lesaffer and Janne E. Nijman (Cambridge: Cambridge University Press,
2021), 23.] He worked at conferences between the English and the Dutch
on issues related to the East Indies.#footnote[Nellen, “Life and
Intellectual Development: An Introductory Biographical Sketch,” 23. Also
see Peter Borschberg, “Grotius and the East Indies,” in #emph[The
Cambridge Companion to Hugo Grotius], ed. Randall Lesaffer and Janne E.
Nijman (Cambridge: Cambridge University Press, 2021), 65--87.] In fact,
his boss, Oldenbarnevelt, was instrumental in founding the Dutch East
India Company. Through unfortunate theological differences over
predestination related to larger church-state issues, Oldenbarnevelt and
Grotius found themselves imprisoned in The Hague. Oldenbarnevelt was
beheaded in 1619; Grotius received a sentence of “life imprisonment and
confiscation of his property.”#footnote[Nellen, “Life and Intellectual
Development: An Introductory Biographical Sketch,” 27.] He, like other
famous prisoners throughout history such as Samuel Pufendorf, Fyodor
Dostoevsky, and Aleksandr Solzhenitsyn, developed ideas while
incarcerated that would become part of later masterpieces. In prison,
Grotius drafted what may have been an early version of his #emph[On the
Law of War and Peace], as well as poetry and commentary on private
law.#footnote[Nellen, “Life and Intellectual Development: An
Introductory Biographical Sketch,” 27--28.] After several years in
prison, in 1621, he escaped in a chest meant for books. Now in exile, he
eventually made his way through parts of Europe and became Sweden's
ambassador to France, where he spent most of his life. He continually
tried to cultivate the unity of the church, an important background
concept that informs his legal scholarship.#footnote[Nellen, “Life and
Intellectual Development: An Introductory Biographical Sketch,” 20. Also
see Harm-Jan van Dam, “Church and State,” in #emph[The Cambridge
Companion to Hugo Grotius], ed. Randall Lesaffer and Janne E. Nijman
(Cambridge: Cambridge University Press, 2021), 203.]

Grotius is a foundational theorist in the history of modern political
thought.#footnote[Space does not allow a full accounting of the
influence of Grotius on political thought, which would span several
volumes. Nevertheless, a few examples or recent scholars who have
engaged him in similar areas as this article follow: Hedley Bull, “The
Importance of Grotius in the Study of International Relations,” in
#emph[Hugo Grotius and the Study of International Relations] (New York:
Oxford University Press, 1992), 23; Charles Edwards, “The Law of Nature
in the Thought of Hugo Grotius,” #emph[The Journal of Politics] 32, no.
4 (1970): 784--807, https:\/\/doi.org/10.2307/2128383; William P.
George, “Grotius, Theology, and International Law: Overcoming Textbook
Bias,” #emph[Journal of Law and Religion] 14, no. 2 (1999): 605--31,
https:\/\/doi.org/10.2307/3556583; Janne E. Nijman, “Grotius' Imago Dei
Anthropology: Grounding Ius Naturae et Gentium,” in #emph[International
Law and Religion: Historical and Contemporary Perspectives], ed. Martti
Koskenniemi, Monica Garcia-Salmones Rovira, and Paolo Amorosa (Oxford:
Oxford University Press, 2017); Christoph A. Stumpf, #emph[The Grotian
Theology of International Law: Hugo Grotius and the Moral Foundations of
International Relations] (Berlin/Boston: Walter de Gruyter GmbH, 2006);
Oliver O'Donovan, “Theological Writings,” in #emph[The Cambridge
Companion to Hugo Grotius], ed. Randall Lesaffer and Janne E. Nijman
(Cambridge: Cambridge University Press, 2021), 339--63; Oliver O'Donovan
and Joan Lockwood O'Donovan, eds., #emph[From Irenaeus to Grotius: A
Sourcebook in Christian Political Thought 100--1625] (Grand Rapids:
Eerdmans, 1999); Richard Tuck, #emph[The Rights of War and Peace:
Political Thought and the International Order from Grotius to Kant]
(Oxford: Oxford University Press, 2001); Ursula Vollerthun and James L.
Richardson, #emph[The Idea of International Society: Erasmus, Vitoria,
Gentili and Grotius] (Cambridge: Cambridge University Press, 2017); H.
J. M. Boukema, “Grotius' Concept of Law,” #emph[ARSP: Archiv Für
Rechts-Und Sozialphilosophie / Archives for Philosophy of Law and Social
Philosophy] 69, no. 1 (1983): 68--73.] He is frequently remembered for
his assertion that natural law exists “even if we should concede that
which cannot be conceded without the utmost wickedness, that there is no
God, or that the affairs of men are of no concern to him.”#footnote[DJBP
Prolegomena, 11.] This one phrase, out of a large treatise on law and
war, has been taken to be a turning point in the history of political
thought, moving human rights and law into the area of human rather than
divine origin, although even this assertion is debated. This emphasis is
misplaced, as this article argues, given Grotius' presuppositions about
where human beings originate from and how their created beings are bound
by nature and sociability.#footnote[See, for example, John D. Haskell,
“Hugo Grotius in the Contemporary Memory of International Law:
Secularism, Liberalism, and the Politics of Restatement and Denial,”
#emph[Emory International Law Review] 25, no. 269 (2011); George,
“Grotius, Theology, and International Law”; O'Donovan and O'Donovan,
#emph[From Irenaeus to Grotius], 787--92.] Some scholars use this
passage from Grotius in the voluntarist and rationalist
debates.#footnote[Edwards, “The Law of Nature in the Thought of Hugo
Grotius,” 785--96.] Other scholarship focuses on the meaning of the law
of nations and the development of the law of nations in political and
legal thought.#footnote[A few examples include Edward Dumbauld, “John
Marshall and the Law of Nations,” #emph[University of Pennsylvania Law
Review] 104, no. 1 (1955): 38--56; Paul W. Kahn, “The Law of Nations at
the Origin of American Law,” in #emph[International Law and Religion:
Historical and Contemporary Perspectives], ed. Martti Koskenniemi,
Monica Garcia-Salmones Rovira, and Paolo Amorosa (Oxford: Oxford
University Press, 2017); Brian Richardson, “The Use of Vattel in the
American Law of Nations,” #emph[The American Journal of International
Law] 106, no. 3 (2012): 547--71.]

As this article articulates through analysis of the Prolegomena,
Grotius' legal philosophy rests on the idea of a creator and enduring
natural order, the truth of which he references over and over throughout
DJBP. Rather than being seen as a secular turn in rights, this phrase
can be understood in several ways. First, for Grotius, human existence
is bound in a moral order that is evident; the social relations that
follow from this morally ordered existence are true, full stop. While
Grotius himself believes in a creator of this order, the existence of
the order is demonstrable from human experience, without appealing to
religious texts. Secondly, Grotius is putting forward an argument for
universality that transcends the Catholic, Calvinist, and Arminian
controversies of his day. For his part, Grotius explains that he wrote
his treatise on law, war, and peace in part as a response to two
extremes: war mongering with little or no cause and, once in war, to act
without restraint toward law, whether eternal or human.#footnote[DJBP
Prolegomena, 28.] The other extreme manifests itself as the tendency, of
“above everything else…the duty of loving all men.”#footnote[DJBP
Prolegomena, 29.] Grotius suggests that a middle legal road exists such
that “men may not believe either that nothing is allowable, or that
everything is.”#footnote[DJBP Prolegomena, 29.] He is particularly
concerned that “men rush to arms for slight causes or no cause at all,
and that when arms have once been taken up there is no longer any
respect for law, divine or human.”#footnote[DJBP Prolegomena, 28.] He
hopes to articulate how war might be “carried on only within the bounds
of law and good faith.”#footnote[DJBP Prolegomena, 25.]

Hathaway and Shapiro, in their historical overview of war, right, and
legality, attribute to Grotius the principle of “Might is Right,” citing
a passage from Grotius' DJBP 3.9.4.2 on postliminy.#footnote[Oona
Hathaway and Scott Shapiro, #emph[The Internationalists: How a Radical
Plan to Outlaw War Made the World] (New York: Simon and Schuster, 2017),
41--42, citing DJBP 3.9.4.2.] However, they fail to mention that a few
pages later, Grotius comments in DJBP 3.9.10.1, “From the preceding
discussion the nature of postliminy may be understood according to the
law of nations,” meaning his discussion was not a normative claim from
the law of nature about might making right.#footnote[DJBP 3.9.10.1.] In
fact, he denies a might principle without limits when he argues, “that
nation is not foolish which does not press its own advantage to the
point of disregarding the laws common to nations,” and “so the state
which transgresses the laws of nature and of nations cuts away also the
bulwarks which safeguard its own future peace.”#footnote[DJBP 3.9.10.1;
DJBP Prolegomena 18.] These texts show, first, that the law of nations
and the law of nature are not the same. More to the point about the
“Might is Right” principle is that Grotius, here and in other passages,
maintains that because the law of nature is unchanging and universal,
its limits apply to all, even to the strong. He argues that just as a
person could violate a domestic law in a way that would benefit himself
does not mean that he should, so nations should abide by the unchanging
law of nature.#footnote[DJBP Prolegomena, 18.] Reviving Grotius'
distinction between the law of nature and the law of nations, as this
article does, corrects scholarship that uses Grotian legal philosophy as
the foundation for the position that might makes right in the
international sphere. Grotius' commentary is extensive and long; not
attending to the full meaning and implications of various passages and
to his theological presuppositions result in misinterpretation and
misapplication of his legal philosophy.#footnote[O'Donovan and O'Donovan
warn of this issue with scholarship on Grotius, noting he is “a
dangerous person to quote.” Oliver O'Donovan and Joan Lockwood
O'Donovan, eds., #emph[From Irenaeus to Grotius], 788.]

Today, economic trade, specialization of labor, globalism, technology,
and inexpensive travel have all contributed to a world that in many ways
is integrated across nation states, making Grotian international legal
thought relevant now more than ever. However, to understand his
commentary on law and war, one must first understand the difference
between his law of nature and law of nations, which affects whether his
commentary in specific areas should be read as normative, descriptive,
or a combination of the two. To summarize the position of this article,
Grotius should be read normatively when discussing what is required by
the law of nature and be read more descriptively, according to his own
political and temporal context, when discussing what is permitted by the
law of nations, although even here, the positive law grounding in the
law of nature means the law of nations is never too far from normative
analysis, especially when it finds a more practice-based
norm.#footnote[For scholarship on Grotius' distinction between the law
of nature and the law of nations, see Nijman, “Grotius' Imago Dei
Anthropology: Grounding Ius Naturae et Gentium.”]

#strong[Legal Genealogy]

Grotius wrote extensively on the law and war and offers guidance for
navigating how to think about right action in international affairs. The
very first book of his major treatise offers a philosophy of law, going
extensively through the question of what is law? Grotius offers three
meanings of law: 1) rule of action toward what is just which he divides
into rectorial and equatorial law; 2) body of rights with reference to
the person, also expressed as a moral quality toward justice such as
powers, property rights, and contracts; 3) law as a rule of moral action
that implies obligation, which he further divides into natural law and
statutory law (also called established law).#footnote[DJBP 1.1.3, 1.1.4,
1.1.9.]

Legal genealogy, according to Grotius, relates human nature and law to a
family tree analogy.#footnote[DJBP Prolegomena, 16.] First, there is the
nature of man, which enters into the mutual relations of society and
which he calls the great grandmother. This nature of man is very social,
where, for Grotius, humans would choose to interact with each other even
if they did not need to. The sociability aspect underlies his philosophy
of law. After the social nature of man is the grandmother in the legal
genealogy, the law of nature, which is unique to humankind, rooted in a
true reality, and created by God, the author of nature. From the law of
nature comes an obligation that arises from mutual consent, the mother
in the genealogy. And finally, the positive law, or municipal law, the
child, results from this obligation based in consent. The figure below
visually represents these relationships.

#box(image("Brand_Figure_1.png", height: 3.65625in, width: 6.5in))

Figure 1.

Grotius takes great care to articulate the existence of the law of
nature. He begins by stating, “the law of nature is a dictate of right
reason … and … inconsequence, such an act is either forbidden or
enjoined by the author of nature, God.”#footnote[DJBP 1.1.10.1.] He goes
on to assert that the law of nature is unchangeable, even by God, making
an analogy to the truth of mathematical calculations.#footnote[DJBP
1.1.10.5.] That said, he suggests that while the law of nature is
unchangeable, circumstances may change which alter the way the law of
nature applies, similar to the difference between concept and
conceptions of rights. He offers the example of common ownership, which
could be in accordance with the law of nature, but once a law of
ownership is promulgated, one cannot claim a neighbor's
property.#footnote[DJBP 1.1.10.7.] For Grotius, what separates the law
of nature for man from more general laws of nature such as those that
apply to beasts is doing right, even when it brings harm to oneself;
this direction to do right derives from mankind's unique “knowledge of
good and evil.”#footnote[DJBP 1.1.11.1.] This assertion has striking
implications in all aspects of life. Grotius does not let people off the
hook for knowing good and evil by looking within a domestic legal
system. Humankind's knowledge of good and evil even extends to how
states, which are made up of people with reason and sociability,
interact with other states. From a Grotian perspective, international
affairs, because they fall within the social nature that God gives to
man, are also subject to right and wrong.

If one is bound by doing what is right, and one knows the difference
between good and evil, to will anything other than good is to deviate
from the law of nature and descend to the level of the beasts of the
earth. In fact, Grotius quotes Plutarch's #emph[Life of Pompey], “but
man becomes brutelike when, contrary to nature, he cultivates the habit
of doing wrong.”#footnote[DJBP 1.1.12.2.] To extend this notion of doing
right according to the law of nature, when states act against the law of
nature, they lose an aspect of their own humanity. This Grotian idea
that when a state's leaders cultivate wrong by habit, they become
brutelike, is in conflict with the might makes right idea of the Melian
dialogue.

Rewritten, Grotius' legal genealogy applies to international relations.
It starts with human nature, the great grandmother, which enters into
mutual relations of international society. The law of nature, the
grandmother, puts forward knowledge of right action. From this law of
nature arises an obligation from the mutual consent of states, what
Grotius terms the mother. And from this mutual obligation comes the law
of nations, the child.

#box(image("Brand_Figure_2.png", height: 3.65625in, width: 6.5in))

Figure 2.

For Grotius, the law of nations “is the law which has received its
obligatory force from the will of all nations, or of many nations…found
in unbroken custom and the testimony of those who are skilled in
it.”#footnote[DJBP 1.1.14.2.] Just as municipal law arises out of
obligation from consent because humans by nature need society, in the
society of states, laws arise not for the singular interest of one state
but for the benefit of the “great society of states.”#footnote[DJBP
Prolegomena, 17.] For Grotius, the law of nations is similar to the
positive law that seeks to approximate the law of nature that arises out
of mutual consent. This theoretical move opens up the possibility of
applying the analytical tools used for domestic legal systems to
interactions with other states. In other words, because the social
nature of man that precedes the law of nature is applicable, for
Grotius, to all humankind, similar legal analysis can be used for
theorizing and applying law between states (the law of nations) as can
be used to apply and theorize law within states (the positive law).
Interactions between states are not a mere power calculation because,
regardless of one's view of the existence or absence of God, the reality
of human existence necessitates mutual interactions with others that are
bounded by the law of nature and give rise to obligations. In other
words, the human nature of man has, within it, knowledge of right and
wrong, and this knowledge pervades human interactions with others, from
the local society to the area of international society where states
interact with other states. A central power is not necessary for
enforcing right, for it is within human nature to know and act on right.
Grotius critiques the assertion that man's nature is incapable of
distinguishing right from wrong, stating that humans, as distinct from
animals, exercise judgment and desire a peaceful, organized, rational
society with other humans, and part of this society is
international.#footnote[DJBP Prolegomena, 8--10.] Grotius critiques a
view of law as merely coming from fear of the unjust, in essence
containing only a punitive aspect. Grotius suggests that right and
justice produce clear consciences that point beyond the mere order of
criminal restraint to the flourishing that occurs when humans, in
relation to each other, are acting according to laws of nature. Grotius
believes justice has the protection of God.#footnote[DJBP Prolegomena,
\20.] As much as Grotius is known as the father of international law, he
holds an explicitly Christian view of law and its origins. This
religious commitment might make some commentators uncomfortable, but it
is weaved obviously throughout his writings, with citations from church
fathers and the Bible.#footnote[The text is replete with references, but
see, for example, DJBP 1.1.11.1 citing Romans and Chrysostom; also
1.1.10.5--6.] But again, even if one left God to the side for the
purposes of justice, for Grotius, the law of nature is part of the
reality of a human.

Power enters into the equation of right, for without it, enforcing right
is difficult. For Grotian legal philosophy, the material capability to
enact and enforce right action normatively obligates powerful states. In
other words, states that are more materially capable of right action
ought to act according to the law of nature rather than taking advantage
of weaker states that “suffer what they must” when the “strong do what
they can.”#footnote[Thucydides, “The Melian Dialogue,” in #emph[Complete
Writings: The Peloponnesian War], trans. Richard Crawley (New York:
Modern Library, 1951), Book 5, Chapter 17.] The Grotian obligation to
act in accordance with the moral order flips the Melian dialogue on its
head. Rather than material power enabling capriciousness and tyranny, in
Grotian thought, power ought to enable right action. The much-repeated
quote from Thucydides ignores the fact that strong states #emph[can] act
rightly; they can act for mutual flourishing. Strength does not
necessitate abuse. We would not give a free moral pass to a strong kid
on the playground, bloodying his classmates, or a company that was so
rich and clever that it could keep slaves for workers without detection
by authorities. Likewise, strong states are bound by the law of nature
and have more responsibility for acting for the flourishing of human
society at the international level precisely because they are more
capable of doing so. From this Grotian perspective, might makes right
only in the sense of entailing a greater responsibility to do what is
right according to the law of nature.

Observing agreements is a principle of the law of nature, which is
necessary for a society to have order.#footnote[DJBP Prolegomena, 15.]
Grotius puts this necessity of society first in his genealogy, preceding
the law of nature. This sequencing points to the importance that Grotius
places on mutual social relations. Individual humans, as well as states,
exist in a world where interaction with others is part of reality. This
is a social view of the law, with the sociability aspect being
foundational to what becomes the positive law. The positive law, whether
domestic or international, derives its meaning from its “great
grandmother,” the social nature of humankind. To have an agreement that
is broken adds confusion and undermines trust. This emphasis on
knowability and trust arguably finds later expression in Fuller's inner
morality of law, which considers morality as coming from the consistency
and predictability that all legal systems have.#footnote[Lon Fuller,
#emph[The Morality of Law], revised ed. (New Haven: Yale University
Press, 1969).]

Grotius extends the importance of agreement beyond private contracts and
national governments to agreements between states. To violate the rights
of nations erodes future peace.#footnote[DJBP Prolegomena, 18.] But even
if this instrumental reason for not violating the rights of nations does
not exist, Grotius still cautions that wisdom would guide us to a policy
that is aligned with nature, since nature in the ideal form is ordered
toward the supreme good of God.#footnote[DJBP Prolegomena, 11--12.] He
finds divine law, which he takes to be given to humankind three times
(at creation, after the Flood, and through Christ), binding on all as
long as it is known to them.#footnote[DJBP 1.1.15.2.] This aspect of
divine law for those who know it, adds an even higher standard for
action.

This discussion of the origins of the law of nature demonstrates that
Grotius finds both useful and principled reasons for adhering to natural
rights even in international relations. At first glance, justice between
nations may not appear a priority, especially for large, prosperous
states that seem self-sufficient. According to an interest-based idea of
international relations, states will only act virtuously toward other
states when it is useful for them to do so. But Grotius reminds his
readers that no state is entirely independent, even large, strong
states. Following this observation, he argues that powerful states enter
into treaties because they will almost certainly need the help of others
at some point.#footnote[DJBP Prolegomena, 22.]

Grotius offers two proofs for the idea of the law of nature among
nations. The first is that man's rational and social nature is an
antecedent cause that demands this. Grotius' genealogy of law starts
with the nature of man, entering into mutual relations of society.
According to Grotius, humans are not solitary but are born into society.
Similarly, states interact with other states in international society.
We cannot escape the idea of borders, which necessitate interactions
with those on the other side. These interactions generate mutual
relations, which lead to a society of states. In today's world, even
more than in Grotius' world, where our economic systems are deeply
ingrained with international trade, travel across borders is relatively
cheap and easy, and we can obtain information from all over the world,
the idea of man's rational and social nature in the international realm
seems all too obvious.

The second proof of the law of nature existing within nations is that
the law of nature is accepted by most nations.#footnote[DJBP 1.1.12.]
Especially since the postwar era, when states have signed numerous
international agreements governing areas as diverse as patents to war,
the ubiquitous existence of international law is a fact, even if its
effect is not. We can gather that these agreements across states do
compose an accepted law of nations rooted in some idea of a law of
nature, of the social relations that occur between states. The table
below summarizes the legal genealogy for domestic and international law
according to Grotius' maternal legal lines.

#box(image("Brand_Figure_3.png", height: 1.51458in, width: 6.5in))

Figure 3.

#strong[Law of Nature and Law of Nations in Practice]

As argued above, in Grotian thought, the law of nature and law of
nations are not synonymous. Returning to his legal genealogy, the
obligation that arises from mutual consent is the bridge between the law
of nature and the law of nations. The law of nature puts forward
normative and obligatory bounds on human action in international
affairs, whereas the law of nations is more descriptive, grounded in
what state practice permits or forbids at particular times, which may or
may not be in accord with the law of nature. In other words, how states
act is not the same as how they ought to act. Grotius explains:

#quote(block: true)[
law of nations is not international law, strictly speaking, for it does
not affect the mutual society of nations in relation to one another; it
affects only each particular people in a state of peace. For this
reason, a single people can change its determination without consulting
others; and even this happens, that in different times and places a far
different common custom, and therefore a different law of nations
(improperly so called), might be introduced.#footnote[DJBP 2.8.1.2.]
]

Grotius' point in this passage is that custom can vary across states and
across time periods. What is interesting, however, is the use of
“improperly,” which reminds the reader of his view that the law of
nations, properly understood, should derive from the law of nature,
given by the author of nature, which means not all custom is
right.#footnote[He cites God as “the author of nature” at DJBP
1.1.10.1.] Taken to the next step, not all “law of nations” is right
law, if unmoored from an idea of human nature grounded in sociability
given by God and from the obligation that arises from mutual consent. To
explain further, this section will show how Grotius differentiates the
law of nature and the law of nations in the areas of poison, killing,
and unequal alliances.

#emph[Poison]

In Book 3, Chapter 15, Grotius gives a clear difference between the law
of nature and the law of nations by discussing the use of killing by
poison. In this case, poison is permitted by the law of nature but not
by the law of nations. He explains, “just as the law of nations…permits
many things which are forbidden by the law of nature, so it forbids
certain things which are permissible by the law of
nature.”#footnote[DJBP 3.4.15.1.] This passage claims that the law of
nature and the law of nations are not the same. Recalling Grotius' legal
genealogy, the law of nature is the grandmother of the positive law.
From the law of nature arises an obligation that becomes expressed in
the form of positive law.

International positive law approximates the practice of the law of
nations. However, just as a domestic legal system may end up with
provisions that do not exactly accord with the law of nature, so too can
international state practice result in customs that diverge from the law
of nature. It is not that the law of nations, however, cannot be
normative. In fact, Grotius argues that by the law of nature, if a
person deserves death, it makes no difference if this is by the sword or
by poison.#footnote[DJBP 3.4.15.1.] The result is the same. If you
deserve to die by the law of nature, you have no claim to choose how to
die. To reiterate, there is no law of nature against poisoning,
according to Grotius. By contrast, he argues that killing an enemy by
poison is not permissible under the law of nations.#footnote[DJBP
3.4.15.1--2.] The question then becomes, permissible by whose standard?
And for the law of nations, the standard is what is acceptable among
other nations. The standard for the law of nature, by contrast, is what
is acceptable from the social nature of man. Where the law of nations
comes out of obligation from consent to others in society, the law of
nature comes out of the social nature of man, which enters into mutual
relations of society.

The argument is not that there is nothing normative in the law of
nations, rather the normative is what is commonly accepted among
nations, a practice-based norm rather than a philosophically based norm
of what we derive from the law of nature. For the proof of poisoning
being against the law of nations, Grotius lists historical examples from
Livy to Cicero. He speculates that the agreement to avoid poison in war
arose from kings who were uniquely situated to be victims of poisoning.
He does not reveal where this comes from, but he does note that avoiding
poison is a commonly accepted practice and is part of the law of
nations. This law of nations norm may continue today. We have seen this
with international condemnation of Russia's poisoning of people abroad.
For example, in 2006, Alexander Litvinenko, a Russian defector, drank
tea in London that unbeknownst to him had been poisoned by polonium-210,
which caused his death.#footnote[Scott Neuman, “Russia Fatally Poisoned
A Prominent Defector In London, A Court Concludes,” #emph[National
Public Radio], September 22, 2021,
#link("https://www.npr.org/2021/09/21/1039224996/russia-alexander-litvinenko-european-court-human-rights-putin").]
There have been several other alleged cases of Russian poisoning in
recent years that have been condemned by the international
community.#footnote[Patrick Reevel, “Before Navalny, A Long History of
Russian Poisonings,” August 26, 2020,
#link("https://abcnews.go.com/International/navalny-long-history-russian-poisonings/story?id=72579648").]
Taboo against chemical weapons today represents a more widespread use of
harmful substances that could be seen as an extension of Grotius'
argument that poisoning goes against the law of nations. Chemical
weapons have been widely condemned when used. For example, world leaders
widely condemned the use of chemical weapons by the Assad regime in
Syria.#footnote[For Syria's chemical weapons, including a summary of
Asad's use, see Gregory D. Koblentz and Natasha Hall, “Syria Still Has
Chemical Weapons,” #emph[Foreign Affairs], December 19, 2024,
https:\/\/www.foreignaffairs.com/syria/syria-still-has-chemical-weapons;
Christophe Wasinski, “Politique Internationale de La Souffrance
in/Acceptable et Usage d'armes Chimiques En Syrie,” #emph[Cultures et
Conflits], no. 93 (2014): 151--55.] Even when state leaders have
chemical weapons in their possession, they frequently choose not to use
them, leading some scholars to call the chemical weapons taboo “a
genuine moral rejection of a means of modern warfare that arose at a
particular historical juncture.”#footnote[See especially Richard Price,
“A Genealogy of the Chemical Weapons Taboo,” #emph[International
Organization] 49, no. 1 (1995): 102. For more on the chemical weapons
taboo see Richard M. Price, #emph[The Chemical Weapons Taboo], 1st
edition (Ithaca, NY: Cornell University Press, 2007).] A generally
agreed-upon idea across states that chemical weapons should not be used
may constitute a part of today's law of nations.

#emph[Killing]

This section turns to Grotius' discussion of killing in war to elucidate
how his legal philosophy differentiates the law of nature and the law of
nations. In Book 3, Grotius discusses lawful killing. He points out that
what is permitted is not the same as what is right, meaning that someone
may do something and not get punished, which in a sense makes an action
permissible, even if not moral.#footnote[DJBP 3.4.2.3.] He is very
careful to contextualize the difficult idea of taking a human life.
Although “killing is called a right of war,” he recognizes that even in
a lawful war, knowing the “just limit of self-defence, of recovering
what is one's own, or of inflicting punishments” is
difficult.#footnote[DJBP 3.4.4.] In what we think of as “the fog of war”
he cites Tacitus, who says, “when war breaks out, innocent and guilty
fall together.”#footnote[DJBP 3.4.5.2.] Grotius then goes through the
vast “law of war” that gives a wide permission to belligerents to kill
an enemy in any territory, even veering into discussion of the slaughter
of infants and women as a commonly accepted practice among nations,
citing the Psalms, Homer, Thucydides, and others.#footnote[DJBP
3.4.5-14.]

But Grotius then distinguishes who can be killed according to moral
justice, indicating that killing must only be as “a just penalty or in
case we are able in no other way to protect our life and
property.”#footnote[DJBP 3.11.2.] Even when killing is just, he cautions
that killing may not be “in harmony with the law of love.”#footnote[DJBP
3.11.2.] Grotius goes through a list of people who ought not be killed,
even in a public war. These include children, old men and women (unless
guilty of a serious offense); priests and academics whose “literary
pursuits…are honorable and useful to the human race;”#footnote[DJBP
3.11.10.] also farmers, merchants, prisoners of war, and hostages. He
later admonishes that even those who deserve death may receive a pardon,
and that this is an act of high-mindedness “in conformity with
goodness.”#footnote[DJBP 3.11. 7.] While he recognizes killing as part
of war and that killing can be justified to protect life and property if
there is no alternative, he is reticent to call it right.

#emph[Rights in Unequal Alliances: Is Power All That Matters?]

To return to the idea of might making right, this section looks at what
Grotius says about unequal alliances. First, what does Grotius mean by
an unequal alliance? He means a treaty in which one contracting party
gains a permanent advantage over the other.#footnote[DJBP 1.3.21.1] Four
controversies arise for him from unequal alliances, for which he gives
his responses.#footnote[DJBP 1.3.21.4--7.]

First, subjects violate the treaty of alliance. For this example, think
of an individual, rogue citizen who aids the other side. What should be
done? Grotius says that the state should punish him or turn him over to
those he wronged.#footnote[DJBP 1.3.21.4--7.]

Second, states themselves are accused of violating a treaty. What should
be done? One ally has the right to compel adherence to the treaty and to
punish violators.#footnote[DJBP 1.3.21.4--7.] We do see power entering
into the equation here, but it is power to enforce right, not usurp it.
This is an important distinction about using power within the bounds of
and for the purposes of law, rather than using law as an instrument of
power.

Third, allies under the protection of one state have differences amongst
themselves. What should be done? Grotius suggests that a conference of
allies should be held, or that the disputing allies should refer the
case to arbitrators.#footnote[DJBP 1.3.21.4--7.] This approach is
consistent with Grotius' idea of mutuality, where the positive law comes
out of obligation from mutual consent. If there is a discrepancy about
what this obligation is or what it requires by whom, Grotius
unsurprisingly points to a sociable means of resolution, whether amongst
allies conferencing together or with the help of arbitration. An
alternative theory based in power determinants like economic and
military statistics might instead say that the state offering protection
to disputing allies should make the decision. However, Grotius' view of
the social nature of humans and the mutual nature of obligation points
instead to a collegial resolution rather than a unilateral
determination.#footnote[John Jay, having read Grotius' treatise on war
and peace, suggested mixed commissions to resolve lingering disputes
between the newly formed United States and Britain in 1780s. James Brown
Scott, “John Jay, First Chief Justice of the United States,”
#emph[Columbia Law Review] 6, no. 5 (1906): 289--325,
https:\/\/doi.org/10.2307/1109004; James Brown Scott, “Introduction,” in
#emph[On the Law of War and Peace], trans. Francis Kelsey (Birmingham:
The Legal Classics Library, 1984), xxxix--xl.]

Fourth, subjects assert they have suffered wrong by their own state.
Here, Grotius says there is no right to intervention. He references
Aristotle in arguing that the purpose of an alliance is to prevent
wrongdoing between the states, not within them, which is an argument for
state sovereignty. He finally argues that “the right on the part of the
leading ally to hold command, that is hegemony, does not take away the
independence of the others.” #footnote[DJBP 1.3.8.] We see this ongoing
respect for a weaker state as its own sovereign.

Even with these controversies, Grotius notices the reality that if one
state is vastly superior in power relative to others, it will gradually
usurp their sovereignty, especially without limits to the time within
the treaty. This brings us to the question of the right exercise of
sovereignty. Grotius distinguishes between right and exercise, where a
person might have a right by virtue of a political system to use power
but be unable to actually exercise it at any given moment. An example is
a legislator traveling to a foreign country. He will not be able to
exercise his political authority there. This corresponds to a right to
sovereignty that cannot be exercised because it is thwarted by powerful
states.

Even so, using the law of nature rather than only the practice of the
law of nations makes room for an enduring justice based on human nature
and moral knowledge, an attribute that distinguishes man from beasts.
And here Grotius cautions against destroying our own enduring peace by
prioritizing an immediate gain, offering a caution especially to those
stronger states that are in a position to usurp the sovereignty of
others: “If a citizen who breaches civil Right for his own immediate
interest destroys the fabric which protects the enduring interests of
himself and his posterity, so a people that violates natural Rights and
the Rights of nations, undermines the supports of its own future
tranquility.”#footnote[From Hugo Grotius, #emph[The Right of War and
Peace,] Prolegomena, reproduced in Oliver O'Donovan and Joan Lockwood
O'Donovan, eds., #emph[From Irenaeus to Grotius: A Sourcebook in
Christian Political Thought 100--1625], 795.] Indeed, the ongoing and
future peace requires that people work in international affairs with the
long game in mind. Immediate interest ought to be subjected to a
standard of natural right, which supports long-term interest by
tranquility.

To the point about unequal alliances, the idea of the shifting of power
and changing of types of international order is relevant. Grotius
explains, “there is no state so powerful that it may not some time need
the help of others outside itself, either for purposes of trade, or even
to ward off the forces of many foreign nations united against it,” which
is why “even the most powerful peoples and sovereigns seek alliances,
which are quite devoid of significance … to … those who confine law
within the boundaries of states.”#footnote[DJBP Prolegomena 22.] This
early idea about the need for mutual cooperation is that states cannot
predetermine when they will need the assistance of friendly nations. A
state powerful now may not forever be so. At some point---and no state
knows when this will be---even the most powerful state will need the
help of others. What kind of international order it has built and upheld
through international agreements and domestic application of them, with
transparent, due process, might influence how other states respond in
its time of need.

Justice enters the analysis of state-to-state interaction in two main
ways. The first is how one state treats other states: even when in
power, a stronger state's actions will have consequences for the future
when it may no longer enjoy a superior position, or even if it does,
when it might need assistance. In this self-interested way, states ought
to consider and act on the law of nature because their actions shape the
disposition that other states will have in a future, undetermined time
of need. If a state is trustworthy and follows through on its
commitments, it will be able to count on the aid of others who share
this reciprocity. On the other hand, for states that extract every bit
of concession in overbearing ways on weaker states, we should not be
surprised to have other states relish the chance to exploit them at a
moment of weakness.

The second way to consider justice in moderating the idea of might makes
right is that might should enable right. For as much as Grotius is
hailed or derided for his brief comment that there would be “the
maintenance of social order” as the “source of law” with obligations to
each other “even if we should concede that which cannot be conceded
without the utmost wickedness, that there is no God, or that the affairs
of men are of no concern to him,”#footnote[DJBP Prolegomena, 8--11.] his
writings demonstrate that he does in fact believe God is watching and
judging human actions. Where the first sense of justice is enforced by
self-interested state concern with how other states will treat it in the
future, this second sense of justice is enforced by the idea of a divine
being to whom humans are accountable, the being who gave people reason
and sociability, leading to the law of nature, obligation, and the law
of nations. Grotius holds Christian rulers, diplomats, and statesmen to
the standard that the creation of law based on the nature of man does
not stop within the borders of a state. He argues that rulers should be
held accountable, especially for “useless shedding of
blood.”#footnote[DJBP 3.11.19.] For Grotius, the law of nature extends
to all peoples, and the fact that the law of nations has emerged from
state practice that implicitly takes account of human limits means that
it is both descriptive and prescriptive.

#strong[Theorizing A Law of Nations Rooted in the Law of Nature]

This article has argued that the distinction between the law of nature
and the law of nations in Grotian thought is necessary for understanding
his analysis of the permissibility of actions in international affairs.
His law of nature is rooted in human sociability that obligates right
action. The law of nations comes through mutual consent of states and is
similar to, although not identical to, the positive law application of
municipal law between states. Because the law of nations is, by
definition, linked to state practice, it changes over time within the
generally accepted conditions and actions put forward by states
interacting with each other.

Grotius' discussion of practical aspects of war and peace, including
poison, killing in war, and unequal alliances, must be understood in
each case as to whether he is discussing the law of nature or the law of
nations. While in an ideal world, actions according to the law of nature
and law of nations would converge, Grotius' diplomatic, real-world
experience taught him that this is not always the case. When reading
Grotius' on permissibility of actions between states, analysis must
distinguish when he is speaking of the law of nature, which is less
changeable and more normative, and the law of nations, which does change
according to the practice of the international order at any particular
time, although they should not be wholly unmoored from their foundations
in mutual consent and obligation, right, and sociability. Formulating a
theory of what constitutes the law of nations today, which will be
informed by public international law and state practice, should not
stray far from the underlying sociability principles of the law of
nature that promise trust, good faith, and reliability.

For international affairs today, our own society of states will have a
law of nations that looks different from Grotius' time, as state
practice and technology have evolved. This means that Russia's
aggression in Ukraine, if followed by other nations, may alter the
day-to-day expectations and ways of interacting across states. The more
other states buy into Russian historical revisionism and use of force,
the more the law of nations changes toward those means. On the other
hand, the more states counter Russia's actions and unite against the
illegitimate use of force (e.g., in violation of agreed upon border
treaties), the more the existing law of nations will hold. It is still
too early to tell what the lasting consequences of the Russia-Ukraine
war will be. The liberal international order may be strengthened if the
end result is Russian failure---a weaker, more isolated Russia that is
worse off for having pursued aggression. The message to other states
considering revisionism would be clear: act against the principles of
the existing law of nations, of existing treaties outlining boundaries
of state sovereignty, and you will fail. However, if Russia ultimately
gains ground, in terms of actual territory, or in terms of alliances,
partners, and world opinion, the opposite will be true, and other states
may use force to attempt to extract territorial and political gains.
Grotius' legal philosophy would recognize these facts on the ground
while reminding leaders of all nations that the universal law of nature
binds all and benefits all together, that leaders should abide by
agreements within the society of states, and that all should pursue
right action vis-à-vis other people because human sociability is
intrinsic, universal, and enduring, and because right action is
knowable.
<end-of-brand>
