#import "elements.typ": *

#counter(footnote).update(0)
#abstract(
  [Dissenting Views],
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
    let first-page = locate(<first-page-mcconnell>).page()
    if here().page() == first-page [
      #grid(
        columns: (45%, 45%),
        gutter: 10%,
        align(left)[
          NORTHWESTERN UNIVERSITY STUDIES IN RUSSIAN\
          PHILOSOPHY, LITERATURE, AND RELIGIOUS THOUGHT
        ],
        align(right)[
          Volume 2 (2024): #first-page#sym.dash.en#locate(<end-of-mcconnell>).page() \
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

#heading(level: 2)[Dissenting Views]
<first-page-mcconnell>
#v(1em)
#subtitle([Secular Liberals, Soviet Christians, \ and Socialist Humanism in
the Brezhnev Era])

#v(1em)
#author[Alexander J. McConnell]
#figure(image("mcconnell_fig1.png"), caption: [Figure 1. Diagram of late Soviet ideological tendencies. Source:
Andrei Amal\'rik, Prosushchestvuet li Sovetskii Soiuz do 1984 goda?
(Alexander Herzen Foundation, 1970), 37.], numbering: none)
#v(1em)

This article centers on the ideological relationship that Amal\'rik
locates at the bottom of his diagram: that between “liberal ideology”
and “Christian ideology.” Specifically, it concerns the concept that he
uses to relate these two post-Stalin dissident tendencies, namely
“humanism” (#emph[gumanizm]).#footnote[On the Stalin-era origins of this
concept in Soviet ideology and public culture, see Alexander McConnell,
“‘Tragic Presentiments': Maksim Gor\'kii and the Invention of Soviet
Humanism,” #emph[Slavic Review] 83, no. 2 (2024): 300--317.] For
Amal\'rik, this term seems to have connoted a broadly shared commitment
to human dignity and individual autonomy on the part of both Soviet
liberals and Christians, one without precedent in Russian
history.#footnote[“As a people, we have not benefited from Europe's
humanist tradition. In Russian history man has always been a means and
never in any sense an end. It is paradoxical that the term ‘period of
the cult of the personality'---by which the Stalin era is
euphemistically designated---came to mean for us a period of such
humiliation and repression of the human personality as even our people
had never previously experienced.” Andrei Amal\'rik, #emph[Will the
Soviet Union Survive Until 1984?], rev. ed. (Harper & Row, 1971), 34.]
Yet, as with the case of “official” versus “genuine” Marxism, the
“humanisms” of various figures within the dissident community were not
always compatible, let alone identical. This became increasingly evident
over the course of the 1960s as secular liberals abandoned their
Thaw-era hopes for a more humane Soviet system in favor of a legalistic,
rights-based strategy of dissent.#footnote[Benjamin Nathans, #emph[To
the Success of Our Hopeless Cause: The Many Lives of the Soviet
Dissident Movement] (Princeton University Press, 2024), esp. chapters
5--7.] In particular, the Soviet-led Warsaw Pact invasion of
Czechoslovakia in August 1968, which crushed the Prague Spring movement
and its program of “socialism with a human face,” was a watershed moment
that disillusioned many liberal reformers across the USSR and Eastern
Bloc.#footnote[Nathans, #emph[To the Success of Our Hopeless Cause],
238--267. See also Paulina Bren, #emph[The Greengrocer and His TV: The
Culture of Communism after the 1968 Prague Spring] (Cornell University
Press, 2010).]

Amal\'rik's 1969 diagram likewise overlooks the significance and
function of humanism as a concept within Soviet official ideology
itself. As a fundamental socialist value, albeit one whose scope and
meaning were always contested, humanism's ideological significance in
the USSR was well-established by the 1960s.#footnote[Aleksandr Bikbov,
#emph[Grammatika poriadka. Istoricheskaia sotsiologiia poniatii, kotorye
meniaiut nashu real\'nost\'] (Izd. dom Vysshei shkoly ekonomiki, 2014),
173--194.] Over the next decade, however, the concept's ideological
function expanded further as Party theorists deployed it to help
articulate a new discourse of socialist human rights in response to
domestic and international pressures.#footnote[Examples of this trend in
the specialist literature on human rights include V.D. Popkov,
#emph[Gumanizm sovetskogo prava] (MGU, 1972); G.V. Mal\'tsev,
“Sotsialisticheskii gumanizm i prava cheloveka,” #emph[Pravovedenie],
no. 5 (1977): 24--34; V.M. Chkhikvadze, #emph[Sotsialisticheskii
gumanizm i prava cheloveka. Leninskie idei i sovremennost\'] (Nauka,
1978). For a detailed overview of this literature, see Richard
Greenfield, “The Human Rights Literature of the Soviet Union,”
#emph[Human Rights Quarterly] 4, no. 1 (1982): 124--136.] Humanism even
played a supporting role in Leonid Brezhnev's push for Western
recognition of the USSR as a coequal partner during the so-called
Helsinki Process of the early 1970s.#footnote[On the Helsinki Process,
see Michael Cotey Morgan, #emph[The Final Act: The Helsinki Accords and
the Transformation of the Cold War] (Princeton: Princeton University
Press, 2018).] For example, a December 1973 #emph[Izvestiia] column
marking the anniversary of the UN Universal Declaration of Human Rights
included this emphatic assertion of the Soviet Union's humanizing
influence on the postwar legal order:

#quote(block: true)[
The humanism of the Great October Socialist Revolution, accomplished by
the workers of Russia for humanity, in humanity's name, and the humanism
of the Soviet social order have exercised a great influence on the
formation in contemporary international law of principles and norms
serving the interests of peace, democracy, and the broad
masses.#footnote[I. Blishchenko, “Vo imia demokratii i progressa,”
#emph[Izvestiia], no. 288, December 8, 1973, 2.]
]

Brezhnev himself underlined this connection in his keynote speech at the
Conference on Security and Cooperation in Europe, the venue for the
signing of the Helsinki Final Act, on July 31, 1975:

#quote(block: true)[
Before this exceptionally competent audience, we would like to stress
most emphatically one of the inherent features of the foreign policy of
the Soviet Union, of the Leninist policy of peace and friendship among
nations---its humanism. The decisions of the 24#super[th] Congress of
our Party are imbued with ideas of humanism as is the Peace Program, a
plank of which called for the convocation of an all-European
conference.#footnote[Leonid I. Brezhnev, #emph[Peace, Detente,
Cooperation] (Consultants Bureau, 1981), 24.]
]

Humanism was thus not only (or even primarily) an oppositional term in
the post-Stalin USSR, a fact that further complicates its use as a
neutral descriptor for overlapping dissident “ideologies.”

Both liberal and Christian dissidents, I argue, broadly rejected the
socialist humanism of Soviet official discourse, but for different
reasons and with a variety of alternatives in mind. During the Brezhnev
era, liberal dissidents tended to treat official invocations of humanism
as little more than rhetorical window dressing for state repression and
human rights violations. From the liberal perspective, Soviet ideology
had perverted humanism's historical meanings and grounding in the
European philosophical tradition to a degree that risked compromising
the concept itself.#footnote[For a recent survey of the humanist
tradition in the West, see Sarah Bakewell, #emph[Humanly Possible: Seven
Hundred Years of Humanist Freethinking, Inquiry, and Hope] (Penguin
Press, 2023).] Indeed, by 1969, many rights defenders
(#emph[pravozashchitniki]) and other prominent exponents of Amal\'rik's
“liberal ideology” had disengaged from the previous decade's debates
about humanism, opting for legalistic and personal appeals over
theoretical polemics.#footnote[For a characteristic example of these
early 1960s debates, see I.I. Anisimov, N.K. Gei, and L.N. Novichenko,
eds., #emph[Gumanizm i sovremennaia literatura] (Izd. Akademii nauk
SSSR, 1963).] Remarkably, the Soviet Union's most famous liberal
dissident during this period, the physicist Andrei Sakharov, almost
never used the term “humanism” in his own writings, despite being lauded
as a great humanist by contemporaries and retrospective observers
alike.#footnote[See, e.g., Petr Abovin-Egides, #emph[Andrei Sakharov.
Tragediia velikogo gumanista] (Poiski, 1985); Andrei Loshak, “Andreiu
Sakharovu---100 let. Kak gumanist pobedil uchenogo?” #emph[Meduza], May
21, 2021,
#link("https://meduza.io/feature/2021/05/21/andreyu-saharovu-100-let-kak-gumanist-pobedil-uchenogo").]
Instead, as I show, Sakharov consistently deployed the closely related
but distinct word “humaneness” (#emph[gumannost\']) as a strategic
appeal to the personal emotions and moral consciences of his powerful
interlocutors. While this strategy succeeded in avoiding the thorny
issue of humanism's status as a Soviet ideological concept, it
ultimately failed to prevent (and perhaps even invited) the public use
of the term as a political corrective by Sakharov's critics.

In contrast to their liberal counterparts, Christian dissidents during
the 1970s continued to engage directly with the concept of humanism and
to debate the challenge that both Soviet socialist and Western secular
humanisms posed to their own philosophical projects.#footnote[On
“secular humanism” as an organized twentieth-century social movement and
its relation to atheism, see Richard Cimino and Christopher Smith,
#emph[Atheist Awakening: Secular Activism and Community in America]
(Oxford University Press, 2014); Stephen LeDrew, #emph[The Evolution of
Atheism: The Politics of a Modern Movement] (Oxford University Press,
2015); Callum G. Brown, David Nash, and Charlie Lynch, #emph[The
Humanist Movement in Modern Britain: A History of Ethicists,
Rationalists, and Humanists] (Bloomsbury, 2022).] Far from being united
by a single “Christian ideology,” however, these thinkers expressed a
broad range of views on the compatibility of religious faith, human
freedom, and political rights. Figures as intellectually distant from
one another as the self-described Christian socialist Anatolii
Krasnov-Levitin and the Russian nationalist writer Aleksandr
Solzhenitsyn wrestled with what humanism could and should mean for a
religious opposition to Soviet authority. Such deep engagement with
twentieth-century humanism in its socialist and secular configurations,
I suggest, was unique to the Christian variant of Soviet dissidence and
distinguishes it from (rather than aligns it with) its more celebrated
secular cousin. Yet this preoccupation with humanism also led many
Christian thinkers astray in assessing Soviet human rights activists
like Sakharov, whom they either tended to dismiss as atheist wolves in
secular sheep's clothing or tried to claim as spiritual brethren who had
strayed from the flock. Whether positive or negative, these assessments
rested on a misattribution of religious meaning to nonreligious dissent
based on a contested concept---humanism---that few secular liberal
dissidents of the era actually employed.

#heading(level:3)[“On the Basis of Humaneness”: \ Sakharov's Human Rights Appeals
and Soviet Humanism]

Broadly speaking, secular liberal dissidents and human rights activists
in the Brezhnev era fell into one of two categories: those who were
dismissive of Soviet official humanism, and those who were disengaged
from this discourse entirely.#footnote[By “secular,” I have in mind
dissidents whose political activism was not primarily religious in
nature, regardless of their personal beliefs. This group includes many
secular Jews, who were overrepresented in the dissident movement
relative to the overall Soviet population. Nathans, #emph[To the Success
of Our Hopeless Cause], 517.] The former camp held that official
invocations of humanism were nothing more than a cynical ruse to justify
state repression. For instance, Mal\'va Landa, a founding member of the
Moscow Helsinki Group, wrote in 1979 that when compared to fascism,
“communist ideology and regimes, and the Soviet regime in particular,
are characterized by greater hypocrisy (more skillfully disguised as
‘humanism'), greater deceit, and a limitless capacity for
falsification.”#footnote[Houghton Library, Harvard University, Human
Rights Collection (henceforth HRC), Box 74 (Label 55), File 3, Page 10.]
Eduard Kuznetsov, a Jewish refusenik who in 1970 received a death
sentence (later commuted) for attempting to hijack an airplane to flee
the USSR, described from prison his own experience of this ideological
dissonance: “For too long, you've been stuffed full with declarations of
humanism, democracy, and justice, so you can't believe that you've
really been deemed an enemy of the state and are going to be punished by
death.”#footnote[Eduard Kuznetsov, #emph[Dnevniki] (Les Editeurs Réunis,
1973), 145. I have slightly modified the unattributed English
translation found in Eduard Kuznetsov, #emph[Prison Diaries] (Liberty
Publishing House, 2017), 68.] Other liberal figures, however, refused to
even engage with what they saw as a tired recapitulation of Thaw-era
debates. When the children's poet Kornei Chukovskii warned his daughter,
the writer Lidiia Chukovskaia, against “giving into provocation” over a
1968 speech by the Party-aligned writer Sergei Mikhalkov that used
humanism to attack cultural soft-liners, she replied curtly: “This is
all very boring since it's already been done a thousand times. The same
words, the same people, the same syntax.”#footnote[Lidiia Chukovskaia
and Kornei Chukovskii, “‘Nasha biografiia ne v nashei vlasti': Perepiska
(1912--1969),” #emph[Druzhba narodov], no. 11 (2001): 182--183.
Mikhalkov's speech, delivered at the Moscow city CPSU headquarters in
April 1968, spoke of the need to “remind these literati about what
humanism is in Maxim Gorky's understanding … a militant humanism of
implacable struggle against the hypocrisy and falsehoods of those
concerned with saving the old world.” S. Mikhalkov, “Vsem serdtsem s
partiei!” #emph[Literaturnaia Gazeta], no. 14, April 3, 1968, 2.]

Andrei Sakharov, the country's most renowned and respected dissident
voice on human rights, also provides a striking example of this latter
tendency towards disengagement from the official discourse of Soviet
humanism. While Sakharov's political views evolved over time, his
letters to domestic and foreign leaders reveal a consistent preference
for appeals to “humaneness” (#emph[gumannost\']) rather than the more
ideologically charged humanism.#footnote[On Sakharov's political
evolution, see Jay Bergman, #emph[Meeting the Demands of Reason: The
Life and Thought of Andrei Sakharov] (Cornell University Press, 2009).]
Indeed, as mentioned above, Sakharov almost never used the term
“humanism” in his own writings. When he did so, it was exclusively to
honor the work of fellow dissidents, never to debate the finer points of
humanism or invoke it as a fundamental Soviet value.#footnote[For
instance, a letter that Sakharov wrote circa 1987 refers to the late
dissident Anatolii Marchenko's “enormous contribution to the cause of
democracy, humanism, and justice.” Houghton Library, Harvard University,
Andrei Sakharov Papers (henceforth MS Russ 79), Box 30, File 1887.] By
comparison, “humaneness” appears regularly in Sakharov's copious human
rights appeals of the 1970s-1980s. This was the case for letters to
Soviet officials as well as to world leaders like Pope John Paul
II.#footnote[MS Russ 79, Box 31, File 1941.] “We are convinced,”
Sakharov wrote in a draft press release in 1972, “that the cause of
defending human rights and humaneness in the USSR is not a purely
internal matter of our country.”#footnote[MS Russ 79, Box 81, File 6095,
Page 2.]

This subtle semantic difference, I argue, in fact represents a strategic
move by Sakharov to shift his struggle with the regime onto more
favorable rhetorical ground. Though the two terms are closely related,
only humanism ever attained something like official status within the
increasingly “fixed and normalized discursive system” of late Soviet
ideology.#footnote[Alexei Yurchak, #emph[Everything Was Forever, Until
It Was No More: The Last Soviet Generation] (Princeton University Press,
2005), 14.] Moreover, despite sharing a Latin root, #emph[gumanizm] and
#emph[gummanost\'] have distinct connotations in Russian due to their
endings. The suffix -#emph[izm] suggests a system or a school of thought
(e.g. #emph[kommunizm], #emph[Marksizm]), while -#emph[ost\'] more
commonly refers to personal traits or feelings (e.g. #emph[zhalost\']
\[pity\], #emph[vneshnost\'] \[appearance\]).#footnote[N.Iu. Shvedova et
al., eds., #emph[Russkaia grammatika. Tom 1] (Nauka, 1980), 170, 176.
See also R.A. Budagov, #emph[Istoriia slov v istorii obshestva]
(Prosveshchenie, 1971), 134--155.] This lexical distinction was even
observed in Brezhnev-era legal theory, which characterized humaneness as
a more psychologically specific and emotionally laden manifestation of
the social principle of humanism. As the aptly titled 1972 book
#emph[The Humanism of Soviet Law] explains:

#quote(block: true)[
In the proper (narrow) sense of the word, humanism refers to relations
between society and man, between the collective and the individual,
individuals imbued with love for humanity and respect for human dignity.
In ethical-psychological terms, one expression of humanism is
generosity, kindness, tolerance, i.e. that which is typically understood
as humaneness.#footnote[Popkov, #emph[Gumanizm sovetskogo prava], 66.]
]

For Sakharov, therefore, invoking “humaneness” was no mere stylistic
preference; it was a way of targeting the emotions and moral consciences
of individual leaders without opening up a broader theoretical dispute.

Appeals on behalf of individual political prisoners were a constant
feature of Sakharov's dissidence from the late 1960s
onwards.#footnote[Andrei Sakharov, #emph[Memoirs], trans. Richard Lourie
(Alfred A. Knopf, 1990), 267--280.] Initially, at least, he crafted
these appeals to persuade rather than antagonize, adopting a deferential
tone towards Brezhnev and other Party leaders. This strategy reflected
what Sakharov's biographer Jay Bergman dubs the dissident's “humane
elitism,” the view that it was the Soviet state's duty---­in consultation
with and guided by the educated elite---to move towards a more open,
rational, and ethical system.#footnote[Bergman, #emph[Meeting the
Demands of Reason], 147.] Nor did Sakharov yet consider it necessary to
abandon socialism, the moral values and “universal, international
approach” of which he continued to see as the basis for future
convergence with the capitalist world.#footnote[A.D. Sakharov,
“Razmyshleniia o progresse, mirnom sosushchestvovanii i intellekual\'noi
svobode,” in #emph[Trevoga i nadezhda], ed. Elena Bonner, 2#super[nd]
ed. (Inter-Verso, 1991), 42. Compare the uncredited English translation
in Andrei Sakharov, #emph[Progress, Coexistence, & Intellectual Freedom]
(W.W. Norton, 1968), 78, which misleadingly renders
#emph[obshchechelovecheskii] (“universal,” “common-to-all-humanity”) as
“humanistic.”]

This attitude can be seen across Sakharov's extensive correspondence
with Soviet state and Party officials during the Brezhnev era. In a
collective letter to the Presidium of the Supreme Soviet of the USSR in
1970, for example, Sakharov and several other human rights defenders
praised the government's decision to drop charges against Irina Kaplan
and Viacheslav Bakhmin, two students arrested for anti-Soviet agitation
and propaganda. While legal harassment for ideological reasons “remains
an important problem,” the dissidents wrote, “this humane act by the
Presidium gives us hope that we can appeal not only to the law, but also
to the humaneness of the authorities.” Many others who had been wrongly
convicted on similar charges, the letter continued, “proudly endure
suffering and are not inclined to appeal to the sympathies of the
authorities” despite hardships due to health or old age. In such cases,
“an act of humaneness would be especially appropriate.”#footnote[MS Russ
79, Box 29, File 1834.]

Both halves of Sakharov's “humane elitism” are on display in this
letter. Despite its legal subject, the letter's primary category is not
“truth” (#emph[pravda]) or “law” (#emph[pravo]), but
humaneness---compassion or sympathy for the well-being of others,
expressed in actions that need not be legally motivated. Both the KGB's
recommendation to drop the charges (partly, it seems, based on a lack of
evidence) and the Presidium's decision to do so are described
independently as “humane,” as if to emphasize the unusual but welcome
nature of this outcome. At the same time, Sakharov and the other
signatories cast this decision as a potential precedent for defendants
in similar circumstances. Importantly, this is not a legal standard, but
rather a model of humane action for scenarios in which such action on
the part of the authorities would be “especially appropriate.” Rather
than imploring Soviet leaders to observe their own laws, a fundamental
demand of the Soviet dissident movement, Sakharov and his allies are
content here with appealing to their personal compassion and humane
wisdom.#footnote[On this dissident demand, see Nathans, #emph[To the
Success of Our Hopeless Cause], 24--25 and #emph[passim].]

Sakharov took a similar approach in a letter he sent jointly to the
Supreme Soviet Presidium Chairman Nikolai Podgornyi and U.S. President
Richard M. Nixon three months later. Sakharov's message to Nixon
concerned the radical feminist and Communist Party member Angela Davis,
whom the President had called a “dangerous terrorist” upon her arrest in
October 1970.#footnote[Bettina Aptheker, #emph[The Morning Breaks: The
Trial of Angela Davis], 2#super[nd] ed. (Cornell University Press,
2014), 24.] Whether or not Sakharov was aware of this, he directed his
appeal to the judicial system rather than Nixon: “I hope that the
American court will consider the Davis case with total impartiality. I
also hope for humaneness from the American court.” Conversely, Sakharov
framed his message to Podgornyi, a plea for leniency in the Leningrad
hijacking case mentioned above, in terms of the Soviet leader's personal
authority: “Comrade Chairman! Do not allow \[Mark\] Dymshits and
\[Eduard\] Kuznetsov to be executed. That would be unjustifiably cruel.
Reduce their sentences in line with the other defendants.” Sakharov
closed with a direct appeal: “I hope for your personal humaneness
(#emph[lichnaia gumannost\']) and consideration of the higher interests
of humanity.”#footnote[A.D. Sakharov, “Otkrytoe obrashchenie k
Prezidentu SShA R. Niksonu i Predsedateliu Prezidiuma Verkhovnogo Soveta
SSSR N.V. Podgornomu, 28 dekabria 1970,” in #emph[Sobranie dokumentov
samizdata], vol. 7 (RFE/RL, 1972), no. AS512.]

By linking the Angela Davis and Dymshits-Kuznetsov cases, Bergman
contends, Sakharov “suggested their moral equivalence and, more subtly,
the moral equivalence of the Soviet and American legal
systems.”#footnote[Bergman, #emph[Meeting the Demands of Reason], 178.]
However, the rhetorical contrast between Sakharov's appeals to Nixon and
Podgornyi arguably suggests as much, if not more, about the differences
the dissident assumed between the two systems. The American court's
“humaneness” in the Davis trial was desirable but subordinate to the
legal standard of “total impartiality” that Sakharov hoped would be
upheld. And while Sakharov undoubtedly felt more entitled to issue
directives to Podgornyi, his countryman, than to the President of the
United States, he also understood which of the two was more likely to
make a difference through personal intervention. Sakharov acknowledged
as much in a subsequent letter to Podgornyi on behalf of the Christian
socialist Anatolii Krasnov-Levitin, arrested in 1971. “If you cannot
accept the arguments above as proof of the legality of
\[Krasnov-Levitin's\] actions,” Sakharov wrote, “I ask that you use your
constitutional power and sway to ease his plight on the basis of
humaneness.”#footnote[MS Russ 79, Box 30, File 1870.]

Sakharov's close attention to the precise wording of his appeals is
perhaps most evident in a letter to the Chilean junta led by General
Augusto Pinochet in 1973. Below is the full draft text of the letter,
with Sakharov's own original handwritten edits reproduced:

#quote(block: true)[
#strike[As an opponent of the death penalty in principle,] I write to
you with a request to spare the life of Luis Corvalán, General Secretary
of the Communist Party of Chile. #strike[This appeal is strictly
humanistic in nature.] Lacking complete and accurate information, I
refrain from political evaluations. But I am certain that tolerance and
humaneness always contribute to the prestige of #strike[any regime] any
government.
#v(1em)
#strike[With hope,]

#v(1em)
#strike[With a plea for humaneness,]

#v(1em)
With deep respect,

#v(1em)
Andrei Sakharov#footnote[MS Russ 79, Box 31, File 1978.]
]

Here, one sees Sakharov struggling with the proper language and tone to
employ in petitioning an unfamiliar foreign power. His choice to
emphasize state prestige in calling for humaneness from Chile's military
dictatorship conveys uncertainty (and likely skepticism) about the new
regime's ethics and respect for the rule of law. This stands in sharp
contrast to the deft maneuvering between Soviet paternalism and American
legalism in the letter to Nixon and Podgornyi. Sakharov's refusal to
make “political evaluations” of the Pinochet government also restricts
him to the self-interested case for mercy. His decision to close the
letter “With deep respect,” rather than the more optimistic “With hope”
or the earnest “With a plea for humaneness,” is an unusually stark
example of tactical deference to authority taking precedence over
ethical or emotional appeals in Sakharov's writings.

Sakharov did take up politics directly in the so-called “Memorandum” he
sent to Brezhnev in March 1971. The purpose of this document, in
Sakharov's own words, was to present the Soviet leadership with “a
comprehensive, internally consistent alternative to the Party
program.”#footnote[Sakharov, #emph[Memoirs], 326.] Going beyond pleas on
behalf of individual dissidents or pragmatic appeals, the Memorandum
described the defense of citizens' rights as “the state's fundamental
purpose” and the defense of human rights in general as “the loftiest of
all aims.”#footnote[MS Russ 79, Box 45, File 2783, 24. I have slightly
modified the translation in Sakharov, #emph[Memoirs], 644] Though many
of its policies, such as abolishing the death penalty, were ideas that
Sakharov had advocated elsewhere, they now appeared in a single
political manifesto that registered both his creeping pessimism about
the potential of in-system reform and stubborn commitment to pursuing it
regardless.#footnote[Bergman, #emph[Meeting the Demands of Reason],
\180.]

This underlying tension imbues the Memorandum with a duality absent from
Sakharov's earlier, more optimistic writings as well as later works of
cynical realism like #emph[My Country and the World].#footnote[Andrei D.
Sakharov, #emph[My Country and the World] (Alfred A. Knopf, 1975).]
Notably, for instance, Sakharov proposes eliminating the harshest Soviet
corrective labor regimens, “strict” (#emph[strogii]) and “special”
(#emph[osobyi]), for being “contrary to socialist humaneness”---one of
the rare instances in which he appended a modifier of any kind to the
term.#footnote[MS Russ 79, Box 45, File 2783, Page 27.] That Sakharov
felt it was necessary to do so here, in a document he kept private for
over a year in anticipation of a reply from Brezhnev that never came,
indicates the importance he still attached to the appearance of
deferring to the Soviet authorities. And yet, having made the strategic
choice to underscore his loyalty, Sakharov still resisted the preferred
terminology of “socialist humanism” in favor of an alternative form that
hewed closer to his own moral stance. Tellingly, the English-language
edition of Sakharov's memoirs, published in 1990, renders the sentence
quoted above as simply “Special-regimen imprisonment should be abolished
as inhumane,” suggesting the author's chagrin late in life at having
invoked socialism in this context at all.#footnote[Sakharov,
#emph[Memoirs], 647. A more accurate English translation of the original
Russian text is “Eliminate strict and special-regimen imprisonment as
contradictory to socialist humaneness” (#emph[Otmenit\' osobyi] \[sic\]
#emph[i strogii] \[sic\] #emph[rezhimy lisheniia svobody, kak
protivorechashchie sotsialisticheskoi gumannosti]).]

Sakharov's steadfast appeals to “humaneness” rather than “humanism” did
not prevent and, in fact, may have provoked the latter term's use
against him in a series of public smear campaigns, the first of which
commenced in late summer of 1973.#footnote[Bergman, #emph[Meeting the
Demands of Reason], 199--210.] On September 1, #emph[Sovetskaia Rossiia]
printed several denunciations of Sakharov, supposedly from ordinary
workers. “Learning from the papers about statements made to foreign
correspondents by the ‘humanist' Sakharov, I was simply stunned,” wrote
one I. Animov. “Only someone hostile to the Soviet Union and to the
ideals of socialism could slander the truly humanistic policies of our
government.”#footnote[MS Russ 79, Box 75, File 5664.] A letter from
members of the Soviet Pedagogical Academy, published by #emph[Izvestiia]
on September 4, charged Sakharov with “claiming to be some kind of
‘humanist' or ‘defender of civil liberties' while at the same time
opposing détente.”#footnote[MS Russ 79, Box 75, File 5667.] The next
day, #emph[Literaturnaia gazeta] printed a collective letter from a
group of Soviet writers praising the “most humane” policies of the
Communist Party but lamenting that “the true humanism and bright ideals
of our Soviet society are not to everyone's liking. … Let Sakharov
remember that he who wants to reverse the wheel of history always ends
up taking a back seat.”#footnote[MS Russ 79, Box 75, File 5668.]

The use of humanism to disparage Sakharov only intensified after the
physicist became the first Russian to win the Nobel Peace Prize in 1975.
A statement in #emph[Izvestiia], signed by members of the Soviet Academy
of Sciences, labeled the award “blasphemy against the ideas of humanism,
peace, justice, and friendship of the peoples.” While “declaring himself
a defender of humanism and human rights,” the scientists alleged,
“Sakharov has expressed his hope that the Pinochet regime will usher in
an ‘era of rebirth and consolidation' in Chile.”#footnote[MS Russ 79,
Box 75, File 5682.] These allegations were part of a KGB operation to
discredit prominent liberal dissidents by misrepresenting their
humanitarian appeals to Pinochet as support for his
rule.#footnote[Tobias Rupprecht, “Formula Pinochet: Chilean Lessons for
Russian Liberal Reformers during the Soviet

Collapse, 1970--2000,” #emph[Journal of Contemporary History] 51, no. 1
(2016): 172--173.] They also played on the image of the Chilean dictator
in the Soviet press as a kind of arch-villain whose “humanism” was
expressed through his bloody repression of left-wing politicians and
activists. (Figure 2) Like Pinochet, it was implied, Sakharov was an
American puppet who disguised his reactionary views with humanistic
language. An article in the newspaper #emph[Trud], for example, singled
out Sakharov's support for the 1974 Jackson-Vanik amendment, which
limited U.S. trade with non-market economies such as the USSR based on
the latter's restrictive emigration laws. “By classifying those in the
United States who disrupt normal trade relations between our countries
as ‘humanists,'” the article stated, “Sakharov reveals straight away
what he means by ‘humanism.'”#footnote[MS Russ 79, Box 75, File 5683.]

Of course, what Sakharov “meant by humanism” was nothing at all, in the
sense that he effectively avoided the word altogether. His disengagement
from the Soviet discourse of socialist humanism and appeals to personal
humaneness only encouraged critics who saw him as deceitful and
treacherous. A lengthy screed in #emph[Komsomol\'skaia pravda] on
February 15, 1980, for instance,

delivered this paradoxical verdict on Sakharov's worldview: “His
‘humanism' is not simply false. It is pathologically
inhuman.”#footnote[MS Russ 79, Box 75, File 5695.] By that time,
Sakharov had already been arrested and sentenced to internal exile
alongside his wife and fellow dissident, Elena Bonner. This concession,
Sakharov and other human rights defenders alleged, was meant to preserve
“the appearance of humaneness” while the couple suffered beyond the gaze
of the Moscow-based foreign press corps.#footnote[MS Russ 79, Box 59,
File 3890, Page 5; HRC, Box 13 (Label 9), File 39.] Sakharov and Bonner
would remain exiled in the closed city of Gor\'kii until their amnesty
and release by Mikhail Gorbachev in December 1986.

#figure(image("mcconnell_fig2.jpg", height: 40%), caption: [Figure 2. Anti-Pinochet Poster, 1974. The Cyrillic letter Г at
the beginning of Гуманизм (Humanism) serves as the beams of a gallows.
The text reads: “Rope, bullet, and axe---here is the ‘humanism' of the
fascist packs!” Source: “‘Gumanizm' Pinocheta,” Arthive, accessed May 3,
2025,
#link("https://plakaty.arthive.com/works/484980~Gumanizm_Pinocheta").], numbering: none)

#heading(level:3)[“Truth” or “Consequences”: Christian Dissidents on Secular
Humanism]

The concerns of Soviet religious dissidents overlapped with but were not
identical to those of secular figures like Sakharov in the movement for
civil and human rights.#footnote[Partly for this reason, some scholars
use “dissident” narrowly to mean only those like Sakharov who campaigned
for civil and human rights, rather than any oppositional or
non-conformist figure. See, e.g., Nathans, #emph[To the Success of Our
Hopeless Cause], 15.] Indeed, some within the Russian Orthodox
intelligentsia held human rights activism in contempt, deriding it as
“secular heroism” or worse.#footnote[Ludmilla Alexeyeva, #emph[Soviet
Dissent: Contemporary Movements for National, Religious, and Human
Rights], trans. Carol Pearce and John Glad (Wesleyan University Press,
1985), 264.] When it came to the matter of humanism, however, it was
religious dissidents such as Anatolii Krasnov-Levitin---the Orthodox
Christian socialist on whose behalf Sakharov had petitioned in
1971---who engaged more readily with the categories of Soviet official
discourse.#footnote[On Krasnov-Levitin, see Mikhail Epstein, #emph[Ideas
Against Ideocracy: Non-Marxist Thought of the] #emph[Late Soviet Period
(1953--1991)] (Bloomsbury Academic, 2022), 78--81.]

In #emph[Stromata] (1972), a collection of essays published abroad while
he was still imprisoned, Krasnov-Levitin advocates what he calls
“neo-humanism” in an attempt to unite “many religious believers, many
honest communists, many supporters of socialism and other societal
forms” under one philosophical umbrella.#footnote[A. Krasnov,
#emph[Stromaty] (Possev-Verlag, 1972), 150. The exact origins of the
term “neo-humanism” (#emph[neogumanizm]) in Krasnov-Levitin's thinking
are unclear, but it is possible he was inspired the Russian émigré
philosopher Nikolai Berdiaev, whose name appears in several of
Krasnov-Levitin's works. In his 1936 essay “Neo-Humanism, Marxism, and
Spiritual Values,” Berdiaev questions the compatibility of Christianity
and Marxism as exemplified by the “neo-humanism” that was becoming
fashionable with the Catholic Left in interwar France. Krasnov-Levitin
employs the term in a similar manner to Berdiaev but endorses (rather
than rejects) the potential unity of socialism with religion. Nikolai
Berdiaev, “Neogumanizm, marksizm i dukhovnye tsennosti,”
#emph[Sovremennye zapiski], no. 60 (1936): 319--324.] His account of how
neo-humanism diverges from traditional (“old”) humanistic ideas is quite
reminiscent of Communist Party ideological texts about the gulf between
revolutionary socialist humanism and its moribund bourgeois foil:

#quote(block: true)[
Neo-humanism, like old humanism, means humanity
\[#emph[chelovechnost\']\] and preaches love for people. However,
whereas old humanism foregrounded the concept of humankind
\[#emph[chelovechestvo]\], neo-humanism foregrounds the human
\[#emph[chelovek]\], the individual person \[#emph[chelovecheskaia
lichnost\']\]. Old humanism is thus something abstract, disconnected
from life, inert, and intellectual. Neo-humanism is concrete, active,
dynamic---it is an artistic worldview, inspirational and encouraging,
carrying a romantic impulse, and appealing to the broadest
masses.#footnote[Krasnov, #emph[Stromaty], 149.]
]

Like the Soviet variant of humanism, Krasnov-Levitin's neo-humanism is
also internationalist: he includes Martin Luther King Jr., Mahatma
Gandhi, Bertrand Russell, and Albert Einstein alongside compatriots like
Konstantin Paustovskii and Sakharov among its unspoken
practitioners.#footnote[Krasnov, #emph[Stromaty], 150.] Thus, if
Sakharov tacitly exploited the Soviet distinction between “humaneness”
and “humanism,” using the former to engage the personal sympathies of
individual leaders, Krasnov-Levitin instead sought to fashion an
alternative concept out of the official discourse of socialist humanism
itself, one that could unify the Soviet opposition and perhaps garner
mass appeal.

Religious dissidents of a Russian nationalist or Slavophile persuasion,
however, had reason to be dubious of an idea recalling the “concrete,”
“active,” and internationalist humanism of Soviet official ideology.
Even more moderate nationalists such as Vladimir Osipov, founder and
editor of the Orthodox samizdat journal #emph[Veche], expressed
reservations.#footnote[Mikhail Epstein deems Osipov the “most outspoken
proponent” of a “moderate, even liberal, nationalism.” See Epstein,
#emph[Ideas Against Ideocracy], 19.] Krasnov-Levitin, Osipov wrote in
1974, “is true to the ideals of his youth: socialism, internationalism,
Renaissance humanism. He defends these views, inculcates and cultivates
them, but his own spiritual experience kills them at the root.” By this,
Osipov appears to have had in mind a perceived contradiction between
Krasnov-Levitin's socialist politics and his Christianity: “The only
convincing pages of \[Krasnov-Levitin's\] most recent work, ‘Earth
Rampant,' were those in which spiritual insight about man in general and
Russian man in particular supersedes all pre-determined enlightenment
slogans.”#footnote[Vladimir Osipov, #emph[Tri otnosheniia k rodine]
(Possev-Verlag, 1978), 187.] For Osipov, the issue with humanism was not
simply its Marxist overtones, but also its adoption and promulgation by
foreign secular groups such as the American Humanist Association with
its #emph[Humanist Manifesto II] (1973).#footnote[Paul Kurtz and Edwin
H. Wilson, #emph[Humanist Manifesto II] (1973), American Humanist
Association,
#link("https://americanhumanist.org/what-is-humanism/manifesto2/"),
accessed May 5, 2025. Andrei Sakharov was among the original 120
signatories of the #emph[Humanist Manifesto II].] The #emph[Manifesto],
he wrote, represented “an open challenge to the Christian conscience”
and, for all its “affected humanism,” revealed its authors' “total
ignorance of the human soul.”#footnote[Osipov, #emph[Tri otnosheniia k
rodine], 185--186.] As an overarching ethos for the dissident movement,
Osipov concluded, humanism was promising in theory but untenable in
practice.

A similar concern with the fate of humanism in a secular age motivated
Evgenii Barabanov, an Orthodox theologian and art historian, to call in
1974 for “a Christian initiative to counter the godless humanism that is
destroying man and to stop \[religious\] humanism from degenerating into
a non-religious form.”#footnote[Evgenii Barabanov, “Raskol Tserkvi i
mira,” in #emph[Iz-pod glyb. Sbornik statei] (YMCA Press, 1974), 197.]
Barabanov revisited this dilemma in 1976 with “The Truth of Humanism,”
an essay that can be read as a response to Osipov's dismissal of
humanism as a unifying creed for Soviet dissidents. Why, Barabanov
wondered, do Christians so often repudiate those whose good deeds are
driven by a this-worldly love for their fellow man, dismissing such acts
of “secularized humanism” as misguided or naïve?#footnote[“In this way,
humanism, especially when combined with the epithet ‘secularized,'
becomes synonymous with a kind of unquestionable untruth, a delusion, or
in the best case, a spiritual limitation, kindly blindness, foolish
optimism.” Evgenii Barabanov, “Pravda gumanizma,” in #emph[Samosoznanie.
Sbornik statei] (Khronika, 1976), 17.] In the Soviet Union and Eastern
Europe, for the first time in history, ordinary people were asserting
their rights not in defiance of religion or absolute monarchy, but
against “an all-encompassing ideology that calls itself and demands to
be accepted as nothing less than genuine humanism.” It was thus
imperative for believers to avoid “outdated ideological standards” when
appraising secular dissidents, lest they mistake the
“religious-historical meaning of the new humanism” for “all those
godless ‘do-gooders' and ‘philanthropes' who have given their lives to
the creation of totalitarian regimes.”#footnote[Barabanov, “Pravda
gumanizma,” 18--20.]

Barabanov's distinction between the benevolent “new humanism” of secular
dissidents like Sakharov and the “godless humanism” of the Soviet state
reflected a desire to harness the potential overlap between “liberal”
and “Christian” ideologies that Amal\'rik identified in his 1969
diagram. By insisting on the “religious-historical meaning” of secular
dissent, Barabanov hoped to convince his fellow Christians that this
overlap was spiritual rather than superficial. What mattered most, he
argued, were humanism's origins in and basic affinity with Church
doctrine regarding humanity's divinely ordained liberty, individuality,
and creativity. Renaissance humanists such as Erasmus and Thomas More
were religious thinkers whose Christian beliefs had informed their
renewed interest in classical ideas about human nature. If this movement
had later drifted towards secularism, this was the fault of Christians
themselves, whose religious wars and resistance to change precluded a
deep engagement with humanist philosophical insights. “Christians have
been more likely to speak of humanism's lies,” Barabanov lamented, “and
have not always wanted to understand its truth.”#footnote[Barabanov,
“Pravda gumanizma,” 14--15.]

The perceived need for dialogue between secular and religious dissidents
led the editors of the Moscow-based samizdat journal #emph[Poiski] to
establish a new rubric called “Faith and Humanism” in 1979. The rubric's
introduction, most likely written by the historian Mikhail Gefter,
announced its purpose as facilitating “a dialogue between the two main
worldview systems in our country: Christianity and atheism (not state,
but personal).”#footnote[Quoted in V. Sokirko, “Prodolzhenie razgovora s
sobesednikom Kronida Liubarskogo Sergeem Alekseevichem Zheludkovym,”
website of Viktor Sokirko and Lidiia Tkachenko, accessed May 5, 2025,
#link("https://sokirko.com/victor/ideology/kronid/continue.html").] It
was this personal unbelief, rather than what Viktoria Smolkin describes
as the “alternative cosmology and way of life” of Soviet state atheism,
that liberal Christians like Barabanov had in mind when they spoke of
making common cause with the “new humanism.”#footnote[Victoria Smolkin,
#emph[A Sacred Space is Never Empty: A History of Soviet Atheism]
(Princeton University Press, 2018), 8.] The confluence of liberal (or
“open”) Christianity and secular (dissident) humanism, Mikhail Epstein
writes, made sense from a political as well as spiritual standpoint: “In
its appeal to humanistic values, open Christianity proves to be a
dissident movement vis-à-vis the Church's conservatism. By the same
token, secular humanism's belief in the freedom of conscience makes it
unacceptable to the hardline policy of official ‘class-based humanism'
maintained by the Soviet authorities.”#footnote[Epstein, #emph[Ideas
Against Ideocracy], 89.] Indeed, as we have seen, Christian dissidents
were more inclined to engage and identify positively with the notion of
humanism than the very “secular humanists” with whom they sought
dialogue.

Barabanov's open-mindedness, however, was by no means the mainstream
view among his co-religionists. In fact, the starkest Christian
expression of the anti-humanist position came from the only dissident
figure of comparable stature to Sakharov during the late Soviet period:
the writer Aleksandr Solzhenitsyn.#footnote[On Solzhenitsyn's political
and philosophical differences with Sakharov, see Bergman, #emph[Meeting
the Demands of Reason], 211--219.] In his commencement address at
Harvard University in 1978, after four years of exile from the USSR and
two years living in the United States, Solzhenitsyn delivered a scathing
indictment of Western legalism, individualism, and materialism that
stunned his audience and provoked a heated debate in the American
press.#footnote[See the responses collected in Ronald Berman, ed.,
#emph[Solzhenitsyn at Harvard: The Address, Twelve Early Responses, and
Six Later Reflections], (Ethics and Public Policy Center, 1980).] The
speech's conclusion, beginning with a section entitled “Humanism and Its
Consequences,” places the blame for the West's “decline” and “debility”
squarely on the Renaissance-era turn towards what Solzhenitsyn calls
“rationalistic humanism or humanistic autonomy.”#footnote[Aleksandr I.
Solzhenitsyn, “A World Split Apart” in #emph[Solzhenitsyn at Harvard],
\16.] If such a historical turn was inevitable after the ideological
exhaustion of medieval religious despotism, the Western embrace of
“boundless materialism” and “freedom from religion and religious
responsibility” had now resulted in a “harsh spiritual crisis and
political impasse.”#footnote[Solzhenitsyn, “A World Split Apart,”
16--17.]

For Solzhenitsyn, the central problem with humanism is that it renders
Western societies incapable of resisting socialist influence and,
ultimately, communist dictatorship. By denying the “existence of
intrinsic evil in man,” non-religious humanism tends naturally towards
the worship of humanity and its material needs. Marxism-Leninism, with
its promise to satisfy these needs and scientific-atheistic worldview,
is only the most radical iteration of this secular humanist tendency.
Thus, in Solzhenitsyn's telling, an “unexpected kinship” reveals itself
between the capitalist West and communist East; both sides of the Cold
War divide stake their political legitimacy on humanity's material
rather than spiritual well-being. Furthermore, as the more ideologically
consistent of the two materialisms, communism will eventually prove
stronger and more attractive to Western populations. “Humanism which has
lost its Christian heritage,” Solzhenitsyn cautioned his Harvard
audience, “cannot prevail in this competition.”#footnote[Solzhenitsyn,
“A World Split Apart,” 18.]

This remark helps to clarify the difference between Solzhenitsyn's views
and those of more liberal Christian thinkers like Evgenii Barabanov.
While both men agreed broadly on Renaissance humanism's historical basis
in Christianity and later degeneration, they diverged over the question
of whether its “Christian heritage” was lost (Solzhenitsyn) or
recoverable (Barabanov). Moreover, Solzhenitsyn reaffirmed humanism's
fundamental affinity with Marxism---placing him in striking agreement
with the official Soviet position.#footnote[“As humanism in its
development was becoming more and more materialistic, it also
increasingly allowed its concepts to be used first by socialism and then
by communism. So that Karl Marx was able to say, in 1844, that
‘communism is naturalized humanism.' This statement has proved to be not
entirely unreasonable.” Ibid.] Barabanov, as we have seen, rejected the
Communist Party's claim to a monopoly on “genuine humanism” and
distinguished between secular dissidents, such as Andrei Sakharov, and
the atheistic Soviet state these dissidents opposed. Put another way,
what Solzhenitsyn understood as an #emph[ideology of secular repression]
in the USSR was for Barabanov a #emph[secular ideology of repression]
that could be opposed by secular as well as spiritual means. The “truth
of humanism,” to quote the title of Barabanov's 1976 essay, was that it
was flexible enough to accommodate diverse and even conflicting
political projects, from the “godless humanism” of state socialism to
the “new humanism” of liberal dissidents.

#heading(level: 3)[Conclusion]

As this article has argued, it was this very flexibility that drove
Sakharov and other liberal dissidents to dispense with humanism during
the 1970s in favor of less ideologically compromised alternatives like
“humaneness.” Such an approach recalls what Alexei Yurchak dubs “being
#emph[vnye],” the prevalent late Soviet practice of operating
simultaneously inside and outside the categories of official discourse.
Yurchak, however, limits the application of “being #emph[vnye]” to
apolitical contexts made up of people “neither simply in support \[of\]
nor simply in opposition” to the Soviet system.#footnote[Yurchak,
#emph[Everything Was Forever], 127--128, 288.] While Sakharov's
opposition was never simple, his dissidence cannot be classified as
#emph[vnye] in the sense that Yurchak uses the term.#footnote[For a
sympathetic critique that seeks to expand Yurchak's arguments in a more
political direction, see Kevin M.F. Platt and Benjamin Nathans,
“Socialist in Form, Indeterminate in Content: The Ins and Outs of Late
Soviet Culture,” #emph[Ab Imperio], no. 2 (2011): 301--324.] Rather, his
recourse to humaneness over humanism is better understood as a form of
what Sergei Oushakine calls “mimetic resistance.” Soviet dissidents,
Oushakine argues, failed to establish a “subject position outside the
existing discursive field” and hence were “able only to intensify its
reproduction.” At the same time, their ability to “reproduce the
discourse of the dominant without merging with it” proved threatening
enough that the Soviet authorities could not simply ignore the movement
altogether.#footnote[Sergei Alex. Oushakine, “The Terrifying Mimicry of
Samizdat,” #emph[Public Culture] 13, no. 2 (2001): 192, 204, 208--209,
\213.] In Sakharov's case, this manifested as a sustained campaign of
public vitriol beginning in 1973, in which the discourse of socialist
humanism was reasserted to discipline and, eventually, punish the
dissident physicist and his wife.

Within Christian dissident circles, meanwhile, the 1970s were a decade
of intense debates across the political spectrum about humanism's
unifying potential and compatibility with religion. Some liberal
Christian dissidents made explicit overtures to their secular
counterparts, advocating “neo-” or “new humanism” as a shared ideology
for the entire anti-Soviet opposition. These efforts could be taken as
confirmation of Andrei Amal\'rik's prescience in his 1969 diagram
linking “liberal ideology” and “Christian ideology” through the concept
of humanism. On the other hand, moderate to liberal Russian nationalists
joined conservative Christian thinkers in rejecting humanism as too
secular, too socialist, or both, suggesting the limits of this
ideological overlap. Nor is it clear that the “new humanism” some
liberal Christians attributed to secular dissidents actually
corresponded with the latter's political or philosophical views. Like
Soviet journalists who distorted Sakharov's human rights activism into a
“false” and “pathologically inhuman” worldview, albeit without their
malicious intent, liberal Christians also ascribed a spiritual
significance to secular dissent based on a concept (humanism) that many
dissidents had long abandoned or never consistently employed.

The liberal Christian effort to claim Sakharov as a fellow traveler
outlived these 1970s debates and, indeed, Sakharov himself. In the wake
of the dissident physicist's untimely death on December 14, 1989, the
Paris-based Russian Orthodox journal #emph[Vestnik Russkogo
khristianskogo dvizheniia] opened with an editorial by Nikita Struve
(grandson of Petr Struve) that acknowledged Sakharov's professed
agnosticism while also asserting the religious significance of his
dissidence:

#quote(block: true)[
In his ascetic ministration, remaining until the end a
humanist-agnostic, A. Sakharov revealed to all, and to Christians above
all, the truth of humanism, too often discarded or unjustly despised in
the name of falsely understood and one-sidedly perceived verities.
]

Sakharov, the editorial allowed, “had never touched on philosophical,
much less religious subjects” in his public appearances. Yet, by virtue
of his familial background (his great-grandfather was an Orthodox
priest) and early childhood in a “religious atmosphere,” he had imbibed
scriptural values that shaped the “Christian image and elemental
Russianness of this ‘Soviet' truth-loving scientist.” Though Sakharov
had ceased to consider himself a believer in adulthood, Struve
concluded, “his humanism has direct Christian roots.”#footnote[Nikita
Struve, “Pamiati A.D. Sakharova,” #emph[Vestnik Russkogo khristianskogo
dvizheniia], no. 158 (1990), 3--4.]

It is hard to imagine a more fitting coda to the Brezhnev-era heyday of
Soviet religious and secular dissent, or a better encapsulation of the
complex relationship between the two with regard to the concept of
humanism. In Struve's telling, it had taken Sakharov, a self-declared
agnostic, to reveal the “truth of humanism” to Soviet Christians---a
revelation made possible by Sakharov's own Orthodox upbringing and
allegedly religious moral outlook. Whether or not the “truth” of this
“humanism” would have been recognizable to Sakharov himself was beside
the point; it made him a potent symbol for Christians willing to look
past his personal unbelief and endorsement of the atheistic
#emph[Humanist Manifesto II].#footnote[Sakharov also received the
American Humanist Association's “Humanist of the Year” award in 1980.]
As a unifying concept for the entire Soviet dissident movement, however,
humanism never quite became the bridge across the secular-spiritual
divide that Amal\'rik had envisioned in his 1969 diagram. Ironically, it
was not until after his predicted “expiration date” for the Soviet Union
in 1984 and the coming to power of the reformist Mikhail Gorbachev that
the broad alignment of humanistic forces Amal\'rik had foreseen would
finally come to pass.

<end-of-mcconnell>
