#import "elements.typ": *

#counter(footnote).update(0)
#abstract(
  [Human Rights and Orthodox Christianity:],
  abstract-subtitle: [Learning from our Differences],
  abstract-author: [John Witte, Jr.],
  [Orthodox Christians have long been wary about the modern regime of
human rights, given its common association with liberalism, libertinism,
and individualism; its insistence on separating church and state, if not
secularizing society altogether; its disastrous effects on post-Soviet
Russia; and its growing attacks on majority and minority religions
alike. His All-Holiness Ecumenical Patriarch Bartholomew of
Constantinople, however, has recently encouraged his followers to see
that rights and liberties are God's gifts to humanity, even if they have
sometimes become prodigal and dangerous when not well rooted and routed.
Rights and liberties, the Patriarch has recently argued, ultimately
depend on Christian and other ontological beliefs and values for their
grounding and reformation. Particularly Orthodox theologies of
conversion and theosis, symphonia and society, church and state,
sacrifice and martyrdom, silence and love have much to offer to modern
human rights around the world---as illustrated in the opening story in
this article about an encounter with Moscow Patriarch Alexei II.
    ],
  abstract-keywords: [Patriarch Bartholomew; Patriarch Alexei II; Orthodox
Christianity; Russian Orthodoxy; proselytism; human rights; religious
liberty; freedom of speech; freedom of silence; church-state relations;
symphonia; liberalism; individualism]
)

// This section sets the headers for the article
#set page(
  header-ascent: 40%,
  header: context {
    set text(8pt, font: "IBM Plex Sans", stretch: 75%, weight: 400)
    let first-page = locate(<first-page-witte>).page()
    if here().page() == first-page [
      #grid(
        columns: (45%, 45%),
        gutter: 10%,
        align(left)[
          NORTHWESTERN UNIVERSITY STUDIES IN RUSSIAN\
          PHILOSOPHY, LITERATURE, AND RELIGIOUS THOUGHT
        ],
        align(right)[
          Volume 2 (2024): #first-page#sym.dash.en#locate(<end-of-witte>).page() \
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

#heading(level: 2)[Human Rights and Orthodox Christianity:]
<first-page-article>
#v(1em)
#subtitle([Learning from our Differences])

#v(1em)
#author[John Witte, Jr.]
<first-page-witte>
#heading(level: 3)[Patriarch Alexei II and the Freedom of Silence]

In 1995, I had the privilege of joining a small group of human rights
advocates who had a forty-five-minute appointment with Patriarch Alexei
II, the religious leader of the Russian Orthodox Church.#footnote[This
text is drawn in part from my chapter in Norman Doe and Aetios
Nikiforos, eds., #emph[Legal Thought and Eastern Orthodox Christianity:
The Addresses of Ecumenical Patriarch Bartholomew] (London: Routledge,
2023), 59--68 and is used herein with permission. The opening section on
the meeting with Patriarch Alexei is included in John Witte, Jr.,
#emph[Table Talk: Short Talks on Law and Religion] (Leiden: Brill, 2023;
open access), 12--14. For a bit more about Orthodox law and theology,
see Paul Valliere and Randall A. Poole, eds., #emph[Law and the
Christian Tradition in Modern Russia] (London: Routledge, 2022); John
Witte, Jr. and Frank S. Alexander, eds., #emph[Modern Orthodox Teachings
on Law, Politics, and Human Nature] (New York: Columbia University
Press, 2007); and John Witte, Jr. and Michael Bourdeaux, eds.,
#emph[Proselytism and Orthodoxy in Russia: The New War for Souls]
(Maryknoll, NY: Orbis Books, 1999).] The meeting---long and difficult in
planning---was designed to foster a frank discussion about the problem
of proselytism in post-glasnost Russia.

With Mikhail Gorbachev's liberating policies of #emph[glasnost] and
#emph[perestroika] in the late 1980s, various Western missionary groups
had poured into the long-closed Soviet Union to preach their faiths, to
offer their services, to convert new souls. Initially, the Russian
Orthodox clergy and laity had welcomed these foreigners, particularly
their foreign co-religionists, with whom they had lost contact for many
decades. But soon the Russian Orthodox came to resent these foreign
religions, particularly those from North America and Western Europe,
that assumed a democratic human rights ethic. Local religious groups
resented the participation in the marketplace of religious ideas that
democracy assumes. They resented the toxic waves of materialism and
individualism that democracy inflicts. They resented the massive
expansion of religious pluralism that democracy encourages. And they
resented the extravagant forms of religious speech that democracy
protects.

Led by Patriarch Alexei, the Russian Orthodox Church had turned to the
state to protect them, much as a millennium of Orthodox church leaders
had done as part of the constitutional and cultural system of
#emph[symphonia]. They called for new statutes and regulations
restricting the constitutional rights of their foreign religious
rivals---through firm new antiproselytism laws, cult registration
requirements, tightened visa controls, and various other discriminatory
restrictions on non-Orthodox and non-Russian religions. The Russian
Parliament had already enacted the first of these proposed restrictions
before our meeting and had several funds bills pending.

Our little group of human rights lawyers and scholars, led by my
colleague Harold J. Berman, a fluent Russian speaker and expert on
Russian law and religion, was there to try to persuade the Patriarch and
Parliament to abandon this restrictive campaign, and to embrace free
speech and free exercise rights for all parties---Orthodox and
non-Orthodox, Russian-born and foreigners alike.

The Patriarch and his entourage came into the room where we had
gathered. We all stood and bowed in respect. “God bless you, my brothers
and sisters,” he said through an interpreter. “Let's take a moment for
prayer.” For the next forty-four minutes---I timed it---we all stood in
absolute silence. The Patriarch had his eyes tightly shut and was
swaying slightly throughout. Then the Patriarch fell to his knees, we
with him, as he prayed aloud: “Oh Lord, who taught us by word and by
deed, by silence and by suffering, teach us all how better to live out
your final commandment: ‘Go ye, therefore, and make disciples of all
nations.'” The Patriarch then stood, faced us, and said: “God bless you,
my brothers and sisters.” And he left, and his entourage with him.

There we stood. Dressed in our best suits, primed with our best
arguments for freedom of speech and religion, armed with strong letters
from political and religious leaders who opposed the Orthodox Church's
political protectionism, we were utterly defeated by the power of
silence by a religious leader. Rarely have I heard a more powerful
sermon or speech. Rarely have I seen such a moving expression of freedom
of speech. Rarely have I been more convinced by the wisdom of the
ancient prophecy: “For everything there is a season and a time . . . a
time to keep silent and a time to speak” (Ecclesiastes 3:1, 7b).

Here was a poignant glimpse into one of many distinct features of the
Orthodox Christian tradition: its celebration of spiritual silence as
its highest virtue---not just for hermits and monastics, but for every
member of the church. This was a sobering lesson for us busy Western
Christians, particularly Protestants, to hear. We are always so busy
getting on with the Lord's work---with our singing and praying, teaching
and preaching, billboards and crusades, relentlessly sharing the Gospel
in word and deed, in person and on screen. Silence and meditation, the
Patriarch taught us, are virtues and gifts to be enjoyed, forms of
worship to be exercised. There is a reason the Bible says, “Be still,
and know that I am God” (Psalm 46:10).

This was also a sobering lesson for us constitutional lawyers, brought
up to believe that an open and robust marketplace of ideas, including
religious ideas, was the best way to find truth. We were all weaned on
John Milton's famous panegyric to freedom of speech in his
#emph[Areopagitica] (1644), which argued that the best antidote to bad
speech is good speech, and the best pathway to religious freedom was
allowing an open contest between truth and falsehood, between old dogmas
and new beliefs. In forty-five short minutes, the Patriarch taught us
all a rather different way of thinking about the freedom of speech and
the freedom of silence.

#strong[Ontological Differences Between Orthodoxy and Western
Liberalism]

“Ontological differences!” In 1997, that was the phrase His All-Holiness
Ecumenical Patriarch Bartholomew of Constantinople used to explain the
Orthodox Church's reticence about embracing the human rights reforms
that Western churches were advocating for the newly liberated Soviet
Union and Eastern Europe.#footnote[Patriarch Bartholomew, “Address of
His All Holiness Ecumenical Patriarch Bartholomew #emph[Phos Hilaron]
‘Joyful Light,'” Georgetown University, October 21, 1997,
#link("https://www.oocities.org/trvalentine/orthodox/bartholomew_phos.html").
See further John Chryssavgis, ed., #emph[Speaking the Truth in Love:
Theological and Spiritual Exhortations of Ecumenical Patriarch
Bartholomew] (New York: Fordham University Press, 2010).] “The Orthodox
Church is not a museum church,” the Patriarch explained. “It is a living
church which, although keeping the old traditions from the very
beginning, nevertheless understands very well the message of every new
era, and it knows how to adapt itself.” The “message” of the modern era
is Enlightenment liberalism, libertinism, materialism, scientism,
individualism, and human rights. While Eastern Orthodoxy has resisted
this modern message, Western Christianity has come under its “shadow.”
Hence the “ontological differences” between the churches and cultures of
the East and the West. “Since the Enlightenment, the spiritual bedrock
of Western civilization has been eroded and undermined. Intelligent,
well-intentioned people sincerely believed that the wonders of science
could replace the miracles of faith. But these great minds missed one
vital truth---that faith is not a garment to be slipped on and off; it
is a quality of the human spirit, from which it is inseparable.” “There
are a few things \[the West\] can learn from the Orthodox Church,” the
Patriarch declared---not least “that, paradoxically, faith can endure
without freedom, but freedom cannot long abide without
faith.”#footnote[Ibid.]

Twenty years later, in his 2017 Berlin Lecture on “Orthodoxy and Human
Rights,” Patriarch Bartholomew echoed and elaborated some of these same
themes.#footnote[Patriarch Bartholomew, “For Human Rights: HAH Lecture
at the Headquarters of the~Konrad Adenauer Foundation~in Berlin,” June
1, 2017,
#link("http://arhiva.spc.rs/eng/his_allholiness_patriarch_bartholomew_germany.html").
See further John Chryssavgis, ed., #emph[In the World, Yet Not of the
World: Speaking the Truth in Love: Social and Global Initiatives of
Ecumenical Patriarch Bartholomew] (New York: Fordham University Press,
2022).] He continued to argue that human rights were shaped by the
eighteenth-century Enlightenment, with its false “optimistic
anthropology,” “its forgetfulness of sins, its rationalism,
individualism and autonomism.” The Patriarch repeated common Orthodox
worries that the 1948 Universal Declaration of Human Rights was a “smug”
“humanistic manifesto” and a secular “Trojan horse” filled with
dangerous modernist ideas that threatened the heart and soul of Orthodox
faith, family, morality, and nationhood. And he repeated recent warnings
that the newly liberated Orthodox Churches of the Soviet bloc and
Eastern Europe were being forced to compete with Western missionizing
faiths in an open marketplace of religious ideas, without having the
experiences or resources needed to compete.#footnote[Ibid.]

In this same 2017 Lecture, however, the Patriarch also pushed beyond
these “ontological differences.” He now stated that human rights ideals
of liberty, equality, dignity, and fraternity had been “rooted in
Christian culture” before the Enlightenment and could still be
“nourished from that deep Christian freedom, freedom through faith,
expressed in selfless love.” He stressed that faith and freedom together
could “mobilize forces of solidarity in man and spur him on the fight
against justice and for a more humane world.” He urged all Christians to
embrace “solidarity, peace and reconciliation and … protection of
fundamental human rights.” He encouraged his fellow Orthodox Christians
not to reject modernity altogether, but to embrace its promise of
individual freedom while also demonstrating the “power of social
freedom.” He further encouraged the Orthodox faithful not to equate
modernity with secularism alone, but to appreciate the diverse
“political, social, and economic realities” of the modern world. And he
encouraged the Orthodox faithful to look beyond the separatism,
secularism, and #emph[laïcité] of some Western laws and appreciate that
some modern Western nations still established Christianity and shared
the Orthodox appreciation for “the close relationship between Church,
people, and state.” “Human rights will remain a major concern for
mankind in the future,” the Patriarch concluded, and it is an “essential
priority for our churches, together with their commitment to the
implementation of human rights, to be the place of that freedom at the
core of which is not the claiming of individual rights, but love and the
#emph[diakonia], the freedom that is not a work of man but a gift from
God.”#footnote[Ibid. See further discussion in A.G. Roeber,
#emph[Orthodox Christians and the Rights Revolution in America] (New
York: Fordham University Press, 2023).]

Patriarch Bartholomew's growing appreciation for the mutually beneficial
interaction of Christianity and human rights offers new hope for deeper
Christian ecumenism and broader religious collaboration in support of
human rights around the world. The “ontological differences” between
Western and Eastern Christians remain real and require continued
conversation to foster better mutual understanding. The next two
sections of this chapter take up two areas of difference today but
concludes with a couple illustrations of what Western churches and human
rights advocates “can learn from the Orthodox Church,” as Patriarch
Bartholomew put it.

#strong[Baptism, Mission, and Conversion]

Let's go a little deeper into the ontological differences over “baptism,
mission, and conversion” that had led to our group's meeting with
Patriarch Alexei in 1995. Ironically, it was the liberation of
traditional Orthodox lands in the 1990s that highlighted one area of
intense “ontological difference” today---that between Eastern and
Western Christian views of baptism, mission, and conversion. Mikhail
Gorbachev's campaigns of #emph[glasnost] and #emph[perestroika] in the
late 1980s soon led to the implosion of the Soviet Union and eventual
dissolution of Soviet bloc lands from the Baltics to the Balkans. Russia
and several Eastern European countries threw off their Communist yokes
and created new Western-style constitutions and ratified many of the
most progressive international human rights instruments. The Russian
Constitution of 1993, with its sweeping embrace of rights and liberties,
was a model that a number of former Soviet nations
followed.#footnote[Michael Bourdeaux, #emph[Gorbachev, Glasnost, and
Gospel] (London: Hodder & Stoughton, 1990).]

This rapid political transformation not only liberated local Orthodox
and other churches, but also opened these societies to foreign religious
groups, who were granted rights to enter these regions for the first
time in decades. After 1990, these foreign missionaries came in
increasing numbers to preach their faiths, to offer their services, to
share their literature, to build new schools, to establish new
charities, and to convert new souls. Initially, Orthodox and other local
religious groups welcomed these foreigners, particularly their
co-religionists abroad, with whom they had lost real contact for many
decades. But local Orthodox leaders soon came to resent these foreign
missionaries, particularly those from North America, Western Europe,
South Korea, and elsewhere who entered in large numbers to preach their
gospels and compete for souls. The long-trammeled Russian churches had
none of the training, resources, experiences, or expectations needed to
participate in an open marketplace of (religious) ideas, and too little
time to prepare themselves.#footnote[John Witte, Jr., ed., “Soul Wars in
Russia: The Problem of Proselytism in Russia,” special issue,
#emph[Emory International Law Review] 12 (1998): 1--738; John Witte,
Jr., ed., “Pluralism, Proselytism and Nationalism in Eastern Europe,”
special issue, #emph[Journal of Ecumenical Studies] 36 (1999): 1--286.]

A new war for souls thus broke out in these regions---a war to reclaim
the traditional Orthodox souls of these newly opened societies and a war
to retain adherence and adherents to the Orthodox Church. In part, this
was a legal war---as local Orthodox leaders pressured their political
leaders to adopt statutes and regulations restricting the constitutional
rights of their foreign religious rivals. Beneath shiny constitutional
veneers of religious freedom for all and unqualified ratification of
international human rights instruments, several Orthodox-majority
countries in the 1990s and early 2000s passed firm new anti-proselytism
laws, cult registration requirements, tightened visa controls, and
various discriminatory restrictions on new or newly arrived religions.
Those policies have continued in some Orthodox-majority lands of Eastern
Europe today, driving beleaguered religious minorities and foreigners to
seek protection from the European Court of Human Rights.#footnote[See
cases in John Witte, Jr. and Andrea Pin, “Faith in Strasbourg and
Luxembourg: The Fresh Rise of Religious Freedom Litigation in the
Pan-European Courts,” #emph[Emory Law Journal] 70 (2021): 587--661.]

In part, this has been a theological war between fundamentally different
theologies about the nature and purpose of mission. Western Christians,
particularly Evangelicals, assume that in order to be saved every person
must make a personal, conscious commitment to Christ---to be born again,
to convert. Any person who has not been born again, or who, once reborn,
now leads a nominal or non-Christian life, is a legitimate object of
evangelism---regardless of whether and where the person has already been
baptized. The principal means of reaching that person is through
proclamation and demonstration of the Gospel. Any region that has not
been open to the Gospel is a legitimate “foreign mission
field”---regardless of whether the region might have another majority
Christian church in place. Under this definition of mission, traditional
Orthodox lands, where the Communist yoke had long suppressed the Gospel,
are prime targets for Christian witness.#footnote[Witte and Bourdeaux,
eds., #emph[Proselytism and Orthodoxy,]108--226.]

The Orthodox Church, too, believes that each person must come into a
personal relationship with Christ in order to be saved. But such a
relationship comes more through birth than rebirth, and more through
regular sacramental living than a one-time conversion. A person who is
born into the Orthodox Church has by definition started
#emph[theosis]---the process of becoming “acceptable to God” and
ultimately “coming into eternal communion with Him.” Through infant
baptism, and later through the Mass, the Eucharist, the icons, and other
services of the Church, a person slowly comes into fuller realization of
this divine communion.#footnote[Ibid., 31--77.] Proclamation of the
Gospel is certainly a legitimate means of aiding the process of
#emph[theosis]---and is especially effective in reaching those not born
into the Orthodox Church. But, for the Orthodox, “mission does not aim
primarily at transmission of moral and intellectual convictions and
truths, but at the ... incorporation of persons into the communion that
exists in God and in the Church.”#footnote[Joel A. Nichols, “Mission,
Evangelism, and Proselytism in Christianity: Mainline Conceptions as
Reflected in Church Documents,” #emph[Emory International Law Review] 12
(1998): 563--650, at 624.]

This theology has led the Orthodox Church to quite a different
understanding of the proper venue and object of evangelism. Traditional
Orthodox lands are hardly an open “mission field” that other Christians
are free to harvest. To the contrary, this territory and population are
under the “spiritual protectorate” of the Orthodox Church. Any person
who has been baptized into the Orthodox Church is no longer a legitimate
object of evangelism---regardless of whether that person leads only a
nominal or non-Christian life. Only if that person actively spurns the
Orthodox Church, or if they are excommunicated, are they open to the
evangelism of others.

This is an important theological source of the Orthodox clergy's
complaints about the proselytizing activity of many Western churches in
their traditional homelands. They are not only complaining about
improper methods of evangelism---the bribery, blackmail, coercion, and
material inducements used by some groups; the garish carnivals, flashy
billboards, and expensive media blitzes used by other faiths. They are
also complaining about the improper presence of missionaries---those who
have come not to aid the Orthodox Church in its mission, but to compete
with the Orthodox Church for its own souls on its own
territory.#footnote[See Harold J. Berman, “Freedom of Religion in
Russia: An Amicus Brief for the Defendant,” in #emph[Proselytism and
Orthodoxy in Russia: The New War for Souls], ed. John Witte, Jr. and
Michael Bourdeaux (Maryknoll: Orbis Books, 1999), 261--83.]

Human rights norms alone will ultimately do little to resolve this
fundamental theological difference between Orthodox and Western
Christians. “In seeking to limit the incursion of missionary activity we
often are accused of violating the right to freedom of conscience and
the restriction of individual rights,” Russian Orthodox Patriarch Alexei
explained in 1997 during the height of the soul wars in Russia. “But
freedom does not mean general license. The truth of Christ which sets us
free (John 8:32) also places upon us a great responsibility, to respect
and preserve the freedom of others. However, the aggressive imposition
by foreign missionaries of views and principles which come from a
religious and cultural environment which is strange to us, is in fact a
violation of both \[our\] religious and civil rights.”#footnote[Quoted
in Witte and Bourdeaux, eds., #emph[Proselytism and Orthodoxy], 22--23.]
The Orthodox Church must be as free in the exercise of its theology of
baptism, mission, and conversion as Western Evangelicals wish to be.
Both groups' rights, when fully exercised, will inevitably clash.

The thirty-year war for souls in traditional Orthodox lands requires a
theological resolution as much as a human rights resolution.
Interreligious dialogue, education, and cooperation sound like tried and
tired remedies, but these are essential first steps. Self-imposed
guidelines of prudent and respectful mission work by Western Christians
are essential steps as well: know and appreciate Orthodox history,
culture, and language; avoid Westernization of the Gospel and First
Amendmentization of politics; deal honestly and respectfully with
theological and liturgical differences; respect and advocate the
religious rights of all peoples; be Good Samaritans before good
preachers; proclaim the Gospel in word and deed.#footnote[See examples
in ibid., 185--96, 323--40.] Such steps will slowly bring current
antagonists beyond competing caricatures into a greater mutual
understanding and a greater unity in diversity.

The ultimate theological guide to resolve the deeper conflict over
mission and conversion, however, must be a more careful balancing of the
Great Commission and the Golden Rule. Jesus called his followers to
mission: “Go therefore and make disciples of all nations.…” (Matt.
28:19). But Jesus also called his followers to exercise restraint and
respect: “Do unto others, as you would have done unto you” (Matt. 7:12).
If both sides in the current war for souls would strive to hold these
principles in better balance, their dogmatism might be tempered and
their conflicts assuaged.

#strong[Church, State, and Nation]

A related ontological difference between Eastern and Western
Christianity is reflected in the Orthodox Church's attitude toward the
state. The Orthodox Church has no concept akin to the Western dualistic
constructions of two cities, two powers, two swords, two kingdoms, two
realms---let alone a “high and impregnable wall of separation between
church and state.”#footnote[See John Witte, Jr., “Facts and Fictions
About the History of Separation of Church and State,” #emph[Journal of
Church and State] 48 (2006): 15--46.] The Orthodox world, rooted in the
ancient Roman and Byzantine Empires, views church and state as an
organic community, united by blood and soil, a veritable
#emph[symphonia] of religion, politics, society, language, ethnicity,
and national culture.#footnote[See John McGuckin, #emph[The Ascent of
Christian Law: Patristic and Byzantine Formulations of a New
Civilization] (Yonkers, NY: St. Vladimir's Seminary Press, 2012).]

For many centuries, this organic unity of church, state, and nation gave
the Orthodox clergy a unique spiritual and moral voice in traditional
Orthodox societies, and unique access to the power, privilege, and
protection of the political authorities. It allowed the Orthodox clergy
to lead and comfort Orthodox lands in times of great crisis---during the
Hun, Mongol, Magyar, and Ottoman invasions, the Napoleonic Wars, the
Turkish genocide, the great World Wars, and more. It allowed the
Orthodox church to heal and teach these societies through its schools
and monasteries, its literature and preaching. It also allowed the
Orthodox clergy to nourish and inspire the people through the power and
pathos of its liturgy, icons, prayers, and music.

But this organic unity also subjected the Orthodox Churches to
substantial state control over their polities and properties, and
substantial restrictions on their religious ministry and prophecy. It
also required them to be obedient and supportive of the political
authorities. In return for their subservience, the Orthodox clergy could
turn to the state to protect them against religious outsiders and
competition. A poignant illustration of this is offered by Joachim, the
Patriarch of Moscow at the turn of the eighteenth century. In a 1690
testament, the Patriarch implored co-Tsars Ivan and Peter “never to
allow any Orthodox Christians in their realm to entertain any close
friendly relations with heretics and dissenters---with Latins,
Lutherans, Calvinists, and Tatars.” He further urged the tsars to pass a
decree “that men of foreign creeds who come here to this pious realm
shall under no circumstances preach their religion, disparage our faith
in any conversations or introduce their alien customs derived from their
heresies for the temptation of Christians.” “Such was the position of
the Muscovite Church,” leading Russian historian Firuz Kazemzadeh
concludes, “and such, in essence, it has remained” not only in Russia
but in many parts of the Orthodox world today.#footnote[Firuz
Kazemzadeh, “Reflections on Church and State in Russian History,” in
#emph[Proselytism and Orthodoxy in Russia], ed. Witte and Bourdeaux,
227--38, at 236; see further Robert P. Geraci and Michael Khodarkovsky,
eds., #emph[Of Religion and Empire: Missions, Conversion, and Tolerance
in Tsarist Russia] (Ithaca, NY: Cornell University Press, 2001).]

We can easily read the recent Orthodox church-state alliances in
fighting against foreign missionaries and faiths as yet another act in
this centuries-long drama. And, in turn, we can see the sad condonation
of the current Moscow Patriarchate in Russia's outrageous war in Ukraine
as the necessary price for the Orthodox church to pay for Putin's
ongoing protection and patronage.

With this “ontological difference,” too, simple invocations of religious
freedom norms, American-style separatism, or French-style #emph[laïcité]
will do little to assuage these conflicts between East and West. Western
Christians must appreciate that their own long history of church-state
relations featured a variety of constitutional forms and norms, some of
them rather close to the #emph[symphonia] of Orthodox lands. They must
also remember the adage of Oliver Wendell Holmes, Jr. that “\[t\]he life
of the law is not logic but experience.”#footnote[Oliver Wendell Holmes,
Jr., #emph[The Common Law] (Boston: Little, Brown, 1881), 1.]
Constitutional laws are not commodities to be imported or exported
#emph[en masse] to other nations. These laws must grow out of the souls
and soils of the people who create and live under them, who breathe into
them their own cultures and experiences, their own #emph[Volksgeist.]
Western formulations of human rights, religious freedom, and
church-state relations cannot and should not be fully duplicated or
imitated in Orthodox lands. Indeed, the sobering lesson learned during
the heady days of #emph[glasnost] and #emph[perestroika] was that the
full-scale importation of these Western constitutional norms created a
toxic compound that these long-closed societies had little capacity to
absorb. The better course for Orthodox lands is to use Western
constitutional and human rights norms as a valuable resource and
inspiration for gradually reconstructing a better constitutional order
for the protection of individual and institutional religious freedom for
all their people.

#strong[What Western Christianity Has Contributed to Human Rights]

Orthodox Christians, in turn, must appreciate that modern norms of human
rights and religious freedom are not simple creations of the Western
Enlightenment nor a ward under the exclusive patronage of its secular
liberal values. A veritable cottage industry of recent new scholarship
has documented the long history of rights talk before the Enlightenment.
We now know a great deal more about classical Roman understandings of
rights (#emph[iura]), liberties (#emph[libertates]), capacities
(#emph[facultates)], powers (#emph[potestates]), and related concepts,
and their elaboration by medieval and early modern civilians. We can now
pore over an intricate latticework of arguments about individual and
group rights and liberties developed by medieval Catholic canonists and
moralists. We can now trace the ample expansion and reform of this
medieval handiwork by neo-scholastic writers in early modern Spain and
Portugal and by Lutheran, Anglican, and Calvinist Protestants on the
Continent and in Great Britain and their colonies. We now know a good
deal more about classical republican theories of liberty developed in
Greece and Rome, and their transformative influence on early modern
common lawyers and political revolutionaries on both sides of the
Atlantic. We now know, in brief, that the West knew ample “liberty
before liberalism”#footnote[Quentin Skinner, #emph[Liberty Before
Liberalism] (Cambridge: Cambridge University Press, 2012).] and had many
fundamental rights in place before there were modern democratic
revolutions fought in their name. It is a telling anecdote that by 1650,
almost every right listed 150 years later in the French Declaration of
the Rights of Man and Citizen (1789) and the United States Bill of
Rights (1791) had already been defined, defended, and died for by
Christians on both sides of the Atlantic.#footnote[See John Witte, Jr.,
#emph[The Blessings of Liberty: Human Rights and Religious Freedom in
the Western Legal Tradition] (Cambridge: Cambridge University Press,
2021).]

To be sure, some modern human rights advocates have deprecated and
sometimes denied these Christian roots, and many current formulations of
human rights are suffused with fundamental liberal beliefs and values,
some of which run counter to cardinal Christian beliefs. But liberalism
does not and should not have a monopoly on the nurture of human rights.
The law of human rights norms is the #emph[ius gentium] of our times,
the common law of nations, which a variety of Jewish, Greek, Roman,
Patristic, Catholic, Protestant, and Enlightenment movements have
historically nurtured in the West, and which today still needs the
constant nurture of multiple communities, in the West and beyond. For
human rights are “middle axioms” of political
discourse.#footnote[Abdullahi Ahmed An-Na\'im, “Towards an Islamic
Hermeneutics for Human Rights,” in #emph[Human Rights and Religious
Values: An Uneasy Relationship?] ed. Abdullahi Ahmed An-Na\'im et al.
(Grand Rapids, MI: Eerdmans, 1995), 229--42; Robert P. George,
“Response,” in #emph[A Preserving Grace: Protestants, Catholics, and
Natural Law], ed. Michael Cromartie (Grand Rapids, MI: Eerdmans, 1997),
157--161.] They are a means to the ends of justice and the common good,
and they depend upon the visions and values of human communities for
their content and coherence---or what the Catholic philosopher Jacques
Maritain once described as “the scale of values governing \[their\]
exercise and concrete manifestation.”#footnote[Jacques Maritain,
“Introduction,” in #emph[Human Rights: Comments and Interpretations],
ed. UNESCO (New York: Columbia University Press, 1949).]

It is here that Christianity and other religious communities have, can,
and should play a vital role---even in modern liberal societies.
Religion is a dynamic and diverse, but ultimately ineradicable,
condition and form of human community. Religions invariably provide some
of the sources and “scales of values” by which many persons and
communities govern themselves. Religions help to define the meanings and
measures of shame and regret, restraint and respect, responsibility and
restitution that a human rights regime presupposes. They help to lay out
the fundamentals of human dignity and human community, and the
essentials of human nature and human needs upon which rights are built.
Moreover, Christianity and other religions stand alongside the state and
other institutions in helping to implement and protect the rights of a
community---especially in transitional societies, or at times when a
once-stable state becomes weak, distracted, divided, or cash-strapped.
Churches and other religious communities can create the conditions
(sometimes the prototypes) for the realization of first-generation civil
and political rights of speech, press, assembly, and more. They can
provide a critical (sometimes the principal) means to meet
second-generation rights of education, health care, childcare, labor
organizations, employment, artistic opportunities, among others. And
they can offer some of the deepest insights into norms of creation,
stewardship, and servanthood that lie at the heart of third-generation
rights.

#strong[What Orthodoxy Can Teach Us About Human Rights]

Orthodox churches, too, have immense spiritual resources and “scales of
values” that hold great untapped promise for modern human rights. These
spiritual resources lie, in part, in Orthodox worship---the passion of
the liturgy, the pathos of the icons, and the power of spiritual
silence. They lie, in part, in Orthodox church life---the distinct
balancing between hierarchy and congregationalism through autocephaly;
between uniform worship and liturgical freedom through alternative
vernacular rites; between community and individuality through a
trinitarian communalism, which is centered on the parish, on the
extended family, on the wizened grandmother (the “babushka” in Russia).
These spiritual resources lie, in part, in the massive martyrdom of
millions of Orthodox faithful in the twentieth century---whether
suffered by Russian Orthodox under the Communist Party, by Greek and
Armenian Orthodox under Turkish and Iranian radicals, by Middle Eastern
Copts at the hands of religious extremists, or by North African Orthodox
under all manner of fascist autocrats and tribal
strongmen.#footnote[James H. Billington, “Orthodox Christianity and the
Russian Transformation,” in #emph[Proselytism and Orthodoxy in Russia],
ed. Witte and Bourdeaux, 51--65.]

These deep spiritual resources of the Orthodox Church have no exact
parallels in modern Catholicism and Protestantism, and most of their
implications for law, politics, and society have still to be drawn out.
It would be wise to hear what an ancient church, newly charred and
chastened by decades of oppression and martyrdom, considers essential to
the regime of religious freedom. It would be enlightening to watch how
ancient Orthodox communities, still largely centered on the parish and
the family, will reconstruct social and economic order and attendant
rights. It would be prudent to see how a culture, more prone to
beautifying than to analyzing, might transform our understanding of
culture. It would be instructive to listen to how a tradition that still
celebrates spiritual silence as its highest virtue might recast the
meaning of freedom of speech and expression. It would be illuminating to
feel how a people who have long cherished and celebrated women's
religious experience and faith---the wizened babushka of the home, the
faithful remnant in the parish pews, the living icon of the Assumption
of the Mother of God---might elaborate the place of women and the
meaning of women's rights in church, state, and society.#footnote[Ibid.;
see also Aristotle Papanikolau, #emph[The Mystical as Political:
Democracy and Non-Radical Orthodoxy] (Notre Dame, IN: University of
Notre Dame Press, 2012).]

Patriarch Bartholomew was certainly wise to remind us that “\[t\]here
are a few things” that Western churches and states “can learn from the
Orthodox Church.” We would do well to listen and learn as Orthodox
churches embrace more fully the global ecumenical project, and as
Orthodox-majority lands come into greater contact with the rest of the
world. Particularly on questions of law, religion, and human rights, the
world needs new wisemen from the East.
<end-of-witte>
