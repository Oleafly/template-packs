#import "elements.typ": *

#counter(footnote).update(0)
#abstract(
  [#emph[Sobornost'] and Christian Order:],
  abstract-subtitle: [On Dignity, Rights, and Responsibility in Milbank and Frank],
  abstract-author: [Nathan Wood],
  [
    ],
  abstract-keywords: []
)

// This section sets the headers for the article
#set page(
  header-ascent: 40%,
  header: context {
    set text(8pt, font: "IBM Plex Sans", stretch: 75%, weight: 400)
    let first-page = locate(<first-page-wood>).page()
    if here().page() == first-page [
      #grid(
        columns: (45%, 45%),
        gutter: 10%,
        align(left)[
          NORTHWESTERN UNIVERSITY STUDIES IN RUSSIAN\
          PHILOSOPHY, LITERATURE, AND RELIGIOUS THOUGHT
        ],
        align(right)[
          Volume 2 (2024): #first-page#sym.dash.en#locate(<end-of-wood>).page() \
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

#heading(level: 2)[#emph[Sobornost'] and Christian Order:]
#v(1em)
#subtitle([On Dignity, Rights, and Responsibility in Milbank and Frank])

#v(1em)
#author[Nathaniel Wood]
<first-page-wood>
This paper examines how the Russian notion of #emph[sobornost'] informs
the Christian political-theological approaches to human dignity,
individual rights, and social responsibility in the work of John Milbank
and S. L. Frank. The focal question is whether a “sobornal” approach to
human dignity and rights necessitates the establishment of a Christian
political order. Milbank and Frank, who both make #emph[sobornost']
central to their treatments of dignity and rights, represent two
different answers to this question. These differences no doubt reflect
the influence of the vastly different contexts in which the two authors'
political theologies took shape. Frank, the Russian religious
philosopher writing in the first half of the 20#super[th] century who
experienced the defeat of rights-based liberalism by communism and
fascism, advocated an anti-utopian and anti-totalitarian “Christian
realism” that eschewed an externally realized Christian order. Milbank,
the English Anglo-Catholic who first developed the major themes of his
political theology in the late 1980s during the ascendancy of
neoliberalism and the aggressive dominance of the market, has become one
of the most prominent theological critics of liberalism, situating
dignity and rights within a postliberal Christian socialist order
organized under the influence of the Church.

Despite their different settings, Milbank and Frank share some
political-theological commonalities that make them worth
comparing---especially considering that Milbank has frequently drawn on
Russian religious philosophy in support of his own
positions.#footnote[Milbank has engaged primarily with Vladimir Soloviev
and especially Sergei Bulgakov. At the time this article was written, he
has never cited Frank. However, considering that Soloviev's concept of
“divine-humanity” is central for all three of these Russian thinkers and
has influenced Milbank, comparison between Frank and Milbank is fitting.
I explore Milbank's indebtedness to this stream of Russian religious
philosophy in more detail in my forthcoming #emph[Deifying Democracy:
Liberalism and the Politics of Theosis] (New York: Fordham University
Press, 2026).] Both Milbank and Frank are wary of liberal theories of
rights based in individuals' subjective self-interest, and both turn to
the #emph[sobornost'] of the Church---which rests on the
self-renunciation of private interest in favor of service to the common
good---for an alternative. In both cases, the main target is so-called
“subjective rights,” a term that is somewhat loosely and variously
defined by different scholars, but which, at the most basic level, means
that rights in some sense “belong” to the individual subject. Some
Christian thinkers have worried that subjective rights lead inexorably
to a #emph[subjectivism] that “exclude\[s\] a larger, qualifying,
objective order of moral #emph[right]” and therefore “function as
vehicles for atomistic egos to assert their selfish
desires.”#footnote[Nigel Biggar, #emph[What's Wrong with Rights?]
(Oxford: Oxford University Press, 2020), 132.] Milbank, who has long
described his project as a response to Thatcherite neoliberalism---the
inevitable end stage of liberalism, in his view---thinks that liberal
subjective rights lead to neoliberalism's “unleashing of purely selfish
individual endeavor” and the economic injustice and environmental
destruction that accompany it.#footnote[John Milbank, “Thatcher's
Perverse Victory and the Prospect of an Ethical Economy,” #emph[ABC
Religion and Ethics], April 15, 2013,
http:\/\/www.abc.net.au/religion/articles/2013/04/15/3737062.htm.]
Frank, likewise, denounces “liberal-individualist” approaches to
economic rights, which he found insufficient to resist Europe's slide
toward fascism;#footnote[I have translated from the German edition:
Simon L. Frank, “Eigentum und Sozialismus,” in #emph[Jenseits von rechts
und links: Anmerkungen zur russischen Revolution un zur moralischen
Krise in Europa], ed. Peter Schulz, Peter Ehlen, Nikolaus Lobkowicz, and
Leonid Luks (Freiburg/Munich: Verlag Karl Alber, 2012), 221--250.
Compare to Milbank's charge that “Liberalism is always incipient
fascism” (John Milbank, “Catholic Social Teaching as Political
Theology.” #emph[New Polity] 3.2 \[2022\], 40).] more generally, he
worries that liberalism can lead to an “unchaining of egoism” that opens
the door to the exploitation of the less fortunate.#footnote[S. L.
Frank, #emph[The Light Shineth in Darkness: An Essay in Christian Ethics
and Social Philosophy], trans. Boris Jakim (Athens, Ohio: Ohio
University Press, 1989), 176.] In response, both thinkers reimagine
rights primarily in terms of social #emph[service], and for both, the
responsibility of service is inseparably linked to
#emph[sobornost']---specifically, to the “sobornizing” of the social
order, which is to say, the reformation of society according to the
principles of ecclesial love and communion.

The question, then, is whether #emph[sobornost'] as a
political-theological response to egoism depends on the existence of a
Christian political order. I argue that Milbank, while offering what is
in many ways a compelling vision of social harmony shaped by
#emph[sobornost'], attempts to overcome subjectivism by rooting rights
in an objectively realized sobornal social order that in a way
ultimately binds #emph[sobornost']---and therefore human dignity and
individual rights---to such a Christian order. Frank, on the other hand,
treats #emph[sobornost'] as the objective moral goal of political
action, and even, to some extent, the basis of human subjectivity
itself, without collapsing #emph[sobornost'] into a Christian order.
Frank thus points to the possibility of a sobornal theory of subjective
rights that resists egoistic individualism and maintains the link
between rights and social responsibility but does not depend on
replacing the liberal order with a Christian one.

#strong[Ecclesial and Political #emph[Sobornost']]

Developed mainly by Alexei Khomiakov in the 1840s and ‘50s as an account
of the Church's “conciliarity” or “all-togetherness,” #emph[sobornost']
is first and foremost a doctrine about the Church. The doctrine quickly
established itself within Orthodox ecclesiology and, through the
influence of figures like Yves Congar, eventually found its way into the
Roman Catholicism of the Second Vatican Council.#footnote[Fr. Edward
Farrugia, “Sobornost': A Russian Orthodox Term at the Heart of Roman
Ecclesiology,” #emph[The Quarterly Journal of St. Philaret's Institute]
47 (2023): 140--180. DOI: 10.25803/26587599.] Yet, as Paul Valliere has
observed, contemporary theological receptions of #emph[sobornost'] have
shown “a tendency to value Khomiakov's ecclesiological vision while
ignoring his social and political vision.”#footnote[Paul Valliere, “The
Modernity of Khomiakov,” in #emph[A.S. Khomiakov: Poet, Philosopher,
Theologian], ed. Vladimir Tsurikov (Jordanville: Holy Trinity Seminary
Press, 2004), 140.] For Khomiakov himself, however, #emph[sobornost']
was a social as well as an ecclesiological concept, and his description
of the organic communion of ecclesial #emph[sobornost'] coincided with
the Slavophiles' romanticized portrait of the Russian peasant commune as
the ideal of social development. Slavophile polemics against the “West”
targeted a property- and contract-based order founded on what C. B.
Macpherson later called “possessive individualism,”#footnote[C. B.
Macpherson, #emph[The Political Theory of Possessive Individualism:
Hobbes to Locke] (Oxford: Clarendon Press, 1962).] a liberal conception
of individuals as independent “owners” of themselves rather than as
interdependent members of a social whole; and Khomiakov's
#emph[sobornost'] ecclesiology similarly rejects individual
self-ownership in favor of personal participation in the Church's
communal possession of God's self-revelation.

The overlap between Slavophile descriptions of Church and society is
very much in keeping with the Orthodox understanding of salvation as
“deification” or #emph[theosis], humanity's union with God, whereby the
human being is perfected #emph[as human] by attaining the “likeness” of
God through ontological participation in divine perfection.
#emph[Theosis] points to a certain ontological continuity between
created nature and divine grace, according to which creation is
naturally oriented towards fulfillment in the supernatural; the doctrine
thus resists strict divisions between the graced, “divine-human” life of
the Church and the “merely human” life of the political community. For
this reason, Orthodoxy's “theotic” ethos has tended to encourage the
idea, widespread in Orthodox political theology, that “the ecclesial and
the political communities will eventually coincide.”#footnote[Alexander
Kyrlezhev, “On the Possibility/Impossibility of an Eastern Orthodox
Political Theology,” in #emph[Political Theologies in Orthodox
Christianity: Common Challenges -- Divergent Positions], ed. Kristina
Stoeckl, Ingeborg Gabriel, and Aristotle Papanikolaou (London: T&T
Clark, 2017), 182.] The natural political community anticipates
fulfillment in the communion of the Church, and the work of Christian
politics, in some sense, is to introduce ecclesial social principles
into the broader social life.

Approached in certain ways, however, this continuity between the social
and the ecclesial poses certain dangers, especially when combined with a
Christian political theology of dignity and rights. Among these dangers
is the fusion of dignity and rights with a specific form of social order
that is thought to be most congruent with Christianity. One of Nikolai
Berdyaev's criticisms of Khomiakov is that the latter could seem at
times to “chain down” #emph[sobornost'] to the Russian
commune,#footnote[Nicholas Berdyaev, #emph[Aleksei Stepanovich
Khomyakov], trans. Fr. S. Janos (self-published, 2017), 140--141.] as if
the commune were a #emph[precondition] for ecclesial communion---a
repetition, in a way, of the old Byzantine temptation of making the
Church dependent upon the existence of the Christian imperial
order.#footnote[E.g., the claim of Patriarch Anthony IV of
Constantinople that “It is impossible for Christians to have a church
and no empire.” Quoted in Deno John Geanakoplos, #emph[Byzantium:
Church, Society, and Civilization Seen Through Contemporary Eyes]
(Chicago: University of Chicago Press, 1984), 143.] #emph[Sobornost'],
as the supernatural fulfillment of natural sociality, becomes wedded to
a specific type of social order---in Khomiakov's case, a decidedly
non-liberal one---such that the “sobornizing” of social relations
becomes closely identified with the establishment of that order.
Combined with a sobornal theology of dignity, this error in turn ends up
chaining human dignity to the maintenance of said order.

Nevertheless, Khomiakov's #emph[sobornost'] is not identical to the
empirical Christian community but is a kind of #emph[performance] of
communion.#footnote[Alexis Khomiakov, “The Church Is One,” in #emph[On
Spiritual Unity: A Slavophile Reader], trans. and ed. Boris Jakim and
Robert Bird (Hudson, NY: Lindisfarne Books, 1998), 39.] While his
ecclesiology contains no notion of individual rights, it does contain a
relational and theocentric idea of personal “dignity,” based in the
person's union with God mediated by this performance. In contrast to
possessive individualism, sobornal dignity is not privately “owned” but
communally realized. Dignity originates in the #emph[insufficiency] of
the separate individual, beginning with the insufficiency of their
knowledge of God, which is “given to the mutual love of
Christians,”#footnote[Alexis Khomiakov, “Some Remarks by an Orthodox
Christian Concerning the Western Communions, on the Occasion of a Letter
Published by the Archbishop of Paris,” in Jakim and Bird, 112.] not to
the individual rational mind. The person's knowledge of God is a
function of their participation in the Holy Spirit, who dwells within
the mutual love that circulates throughout the ecclesial community.
Within the Church, then, dignity is grounded in the performance of
mutual love and service, in a free and reciprocal exchange of the
members' unique gifts that reconciles them in a common life. On the
other hand, to withdraw from this gift-exchange through the
self-assertion of egoism---as, for instance, Khomiakov accuses the
Catholic Church of doing by its unilateral alteration of the Nicene
Creed---is to separate oneself from #emph[sobornost'] and to “wither”
like an organ that has cut itself off from the body's circulation of
blood.#footnote[Khomiakov, “The Church Is One,” 49--50.]

If this vision of #emph[sobornost'] were translated into a theory of
rights following the common approach of basing rights in dignity, then
this would mean that rights, like dignity, would also be oriented
towards social cohesion. Rather than protecting private interest and the
self-assertion of the individual will, which threatens to weaken social
cohesion, sobornal rights instead would incorporate responsibility for
the good of the community. Here, the potential dangers start to emerge.
A sobornal ethos in politics risks collapsing into a collectivism that
subordinates individual freedom to social conformity---a danger on
display in the revisionist anti-liberal rights agenda of Patriarch
Kirill and the Moscow Patriarchate. Arguing that Western liberal rights
encourage the individual to “base his behavior on his own interests as
having priority over those of society,”#footnote[Patriarch Kirill of
Moscow, “Liberal Ideology: A Threat to Peace and Freedom,” in
#emph[Freedom and Responsibility: A Search for Harmony---Human Rights
and Personal Dignity], trans. Basil Bush (Darton, Longman and Todd,
2011), 67.] the patriarch's alternative rights framework refigures
individual rights in a way that ends up binding them to the church's
understanding of Russia's “traditional values.” Just as individual
self-assertion within #emph[sobornost'] separates the individual from
the communal mediation of their participation in God, the political
assertion of individual freedom to engage in behavior that offends
so-called traditional values can “darken” the dignity of the divine
image in the offender.#footnote[Russian Orthodox Church, #emph[The
Russian Orthodox Church's Basic Teaching on Human Dignity, Freedom, and
Rights] (2008), section I.5.
https:\/\/old.mospat.ru/en/documents/dignity-freedom-rights/i/]
Therefore, if the fundamental purpose of human rights is to safeguard
human dignity, then rights do that here by #emph[restricting] individual
freedom to deviate from conservative social norms. In this
“secularization” of the sobornal ethos, relational dignity becomes
chained down to an anti-liberal vision for Russian society, with rights
as an instrument of its enforcement.

Patriarch Kirill is a particularly egregious example of the subjugation
of the sobornal ethos to maintenance of an anti-liberal order. Milbank
and Frank both offer far more compelling, and more theologically
sincere, proposals for a sobornal approach to dignity and rights that
links rights to moral responsibility to the community---the
responsibility especially to foster #emph[sobornost'] within
extra-ecclesial social relations. Both of their approaches share certain
commonalities regarding #emph[theosis] and the nature-grace continuity,
as well as the ontological priority of peace over violence. Both follow
Vladimir Soloviev's path of ontologizing #emph[sobornost'] by pushing it
back into the primordial heart of creation through the concept of
“All-Unity”---Frank with his “universal #emph[sobornost] of
being”#footnote[S. L. Frank, #emph[The Spiritual Foundations of Society:
An Introduction to Social Philosophy,] trans. Boris Jakim (Athens, Ohio:
Ohio University Press, 1987), 61.] and Milbank with his
“#emph[concordantia] of the whole cosmos.”#footnote[John Milbank,
#emph[Being Reconciled: Ontology and Pardon] (London: Routledge, 2003),
\129.] In both cases, the deification of the world is the restoration of
a sobornal peace that already is the reality of creation in its depths,
though currently submerged beneath the divisions drawn by competition
between egoistic individual wills (which finds political expression in
Hobbes's state of nature). For both Milbank and Frank, a Christian
theory of rights must not reinscribe egoism but must be directed towards
#emph[overcoming] it in the harmonization of differences and the
realization of the objective truth of the world as #emph[sobornost']\;
and in this sense, rights become instruments of the world's deification,
justified in relation to the sobornizing of social relations.

However, their approaches have very different consequences for the
relationship between #emph[sobornost'] and Christian order.

Milbank builds on a #emph[sobornost'] ecclesiology to advance an “order
of charity” as an #emph[alternative] to the liberal order. Rejecting the
“ontology of violence” that he sees at the basis of liberalism's
founding myths, he argues for the possibility of a politics that
surpasses the liberal management of ineliminable conflict---a politics
that is “more than an uneasy peace of contract, or agreement to
differ”#footnote[John Milbank, #emph[Theology and Social Theory,]
2#super[nd] edition (Oxford: Wiley-Blackwell, 2006), 367.]---in the
genuine peace of consensus, which he believes defines the redeemed
social life of the #emph[ecclesia]. Central to this project is Milbank's
critique of subjective rights and of a social order founded on the
celebration of subjective willing in the abstract, irrespective of the
#emph[object] of that willing. Milbank hopes to shift the focus away
from subjective rights to dignity, advancing a relational and vocational
approach that situates dignity within an objective “right order” shaped
by the educative influence of the Church and oriented towards the common
good.

Frank, on the other hand, retains an emphasis on subjective rights but
regrounds them in #emph[sobornost'] as the objective content of the
obligatory. Frank does not understand #emph[sobornost'] primarily in
terms of an external order but moves it into the divine foundation of
human consciousness, where it is encountered as both truth and
obligation in the human being's experience of ontological kinship with
God.

For both Milbank and Frank, #emph[sobornost'] detaches dignity and
rights from possessive individualism and reorients them towards social
responsibility or a kind of “right of service.” Yet, as I show below,
Milbank's service depends on the Church's coordination of specific roles
and responsibilities within a Christian order; whereas Frank, with his
anti-utopian skepticism towards such an order, points towards the
possibility of a revitalized liberalism that justifies an expansive
individual freedom in relation to the general moral responsibility to
build charitable social relations, a responsibility which grounds the
absoluteness of human dignity.

#strong[Milbank's Order of Charity]

Milbank offers what is perhaps the most extensive attempt to incorporate
aspects of #emph[sobornost'] into contemporary Western political
theology. He has described his understanding of the Church as “an event
of #emph[concordantia],” a description that he notes---citing Sergei
Bulgakov---is “almost identical to the Russian
#emph[sobornost].”#footnote[Milbank, #emph[Being Reconciled,] 128.] The
social life of the Church, which he describes as a kind of “deified
democracy,”#footnote[Ibid., 133.] is characterized above all by “social
reciprocity and gift-exchange---in a word,
#emph[charity].”#footnote[John Milbank and Adrian Pabst, #emph[The
Politics of Virtue: Post-Liberalism and the Human Future] (London and
New York: Rowman & Littlefield, 2016), 239.] Because of nature's
orientation to the supernatural, natural human society is to be
fulfilled in this deified democracy. For this reason, Milbank allows no
strict ontological boundaries between ecclesial #emph[sobornost'] and
extra-ecclesial society. Since society is already potentially the
Church, Milbank's politics seeks “to incarnate charity also in political
structures,”#footnote[John Milbank, #emph[Beyond Secular Order]:
#emph[The Representation of Being and the Representation of the People]
(Oxford: Wiley-Blackwell, 2013), 256.] which means transforming society
“in the direction of a charitable order.”#footnote[Ibid., 229.]

In effect, Milbank translates ecclesial #emph[sobornost'] into a social
and political order that is meant to replace the liberal order. The
general aim of his politics is to establish a #emph[postliberal] order
of charity, and his approach to dignity and rights is a crucial part of
that project. Milbank's order of charity would be based---as the title
of one of his articles suggests---on the priority of “dignity rather
than right.”#footnote[John Milbank, “Dignity Rather than Right.”
#emph[Open Insight] 5(7): 77--124.] Within mainstream contemporary human
rights discourse, dignity and rights usually belong together, with
dignity as the foundation of rights---as we see, for example, in the
#emph[Universal Declaration of Human Rights.] Milbank challenges this
commonly assumed relationship between the two. The usual linking of
dignity and rights, he contends, is actually the fusion of two
#emph[opposing] traditions: the Catholic and the liberal-individualist.
In practice, he argues, the 20#super[th]-century union of these two
traditions stripped dignity of its substantive (Christian, personalist)
content and has effectively made the concept of dignity subservient to a
liberal-individualist right that is “derived from the exercise of
subjective freedom or from human autonomy and requires no other
foundation”#footnote[Milbank, “Dignity,” 80.]---including no foundation
in social obligation. Basically, Milbank worries that dignity---which
admittedly sometimes appears to be an empty, purely functional concept
in contemporary rights discourse---is reduced to nothing more than the
moral basis for the #emph[amoral] sovereignty of unfettered private
choice. For Milbank, however, this distorts the older Catholic sense of
dignity, which was not the property of an abstract subject but belonged
to specific groups and social roles based on their service to an
objective common good. Dignity was attached to specific positions within
an objective right order, which worked together to realize the good.

Ultimately, the common good these roles or positions realize just
#emph[is] that of charity, or #emph[sobornost']. This is why the
diversity of distinct roles is crucial for Milbank's charitable order,
because, like Khomiakov's #emph[sobornost'], this order is constituted
as a “harmonious blending of diverse gifts.”#footnote[Milbank,
#emph[Being Reconciled,] ix.] The order of charity, like the Church, is
gift-exchange. Therefore, in support of this exchange, Milbank moves
away from talk of “human dignity” in general and towards specific,
differentiated #emph[dignities] attached to the various co-essential
social roles. “To value the dignity of the person is not to value an
abstract bearer of free-will, equivalent to all other such
bearers,”#footnote[John Milbank, “Human Dignity, Not Rights: Breaking up
Modernity's Uneasy Marriage,” #emph[ABC Religion and Ethics], March 14,
2014, http:\/\/www.abc.net.au/religion/articles/2014/03/04/3956588.htm.]
but it is to value them as the occupant of specific positions that make
specific contributions to social harmony: e.g., the dignity of the
person as “miner, son, father, cricket player, or
lover.”#footnote[Milbank and Pabst, #emph[Politics of Virtue,] 210.]
Properly speaking, none of these roles possesses dignity #emph[by
itself] any more than isolated individuals do; rather they have dignity
only #emph[together with others]---only situated within the reciprocal
gift-exchange. What this means, essentially, is that Milbank
“ecclesializes” the political notion of human dignity by grounding it in
the charitable performance of #emph[sobornost']---in a sense, “doing
church”---within the people's various social roles and relations: in
labor, economic exchange, family, education, and so on.

The performative dimension of #emph[sobornost'] is particularly
important, for one, because it preserves an element of subjective
freedom in Milbank's theory of dignity, preventing it from collapsing
into pure social conformity that suppresses personality. The dignity of
social roles is a function of their contribution to building the peace
of consensus, or put differently, realizing the #emph[ecclesia] within
society. In Khomiakov's ecclesiology, the performance of ecclesial
consensus was at least as important as the propositional content of that
consensus; we see this, for instance, in his critique of the
#emph[filioque], which he deems heretical not primarily because of its
theological content but for the fact that its unilateral insertion into
the Creed broke consensus.#footnote[Khomiakov, “Archbishop of Paris,”
especially 66--68 and 132--133.] Consensus follows a similar logic in
Milbank. For Milbank, a genuinely #emph[social] unity is not the mere
coordination of wills but the unity of consensus about what is good and
true; but truth here is the ontological peace of #emph[sobornost'],
which is to say, consensus itself. This places a partial check on the
theocratic thrust of Milbank's position, because if truth is a
charitable performance and as such is irreducible to a proposition, then
consensus about the truth cannot be coercively and externally imposed;
it can only be performed as free communion, as “perfect social
harmony.”#footnote[John Milbank, #emph[The Word Made Strange: Theology,
Language, Culture] (Oxford: Wiley-Blackwell, 1997), 154.] This would
preclude the forced profession of state dogma or the exclusion of
ideological minorities. The performance of #emph[sobornost'] is
“democratic” in the sense that it must include the free participation of
all of society's members, for just as Khomiakov “dispersed” divine
revelation by locating it within mutual love, Milbank insists that “the
entire truth of Christianity exists in harmonious dispersal amongst the
body of Christ,”#footnote[John Milbank, #emph[The Future of Love: Essays
in Political Theology] (Eugene: Cascade Books, 2009), xiv.] so that this
truth is accessible only “democratically” through charitable
gift-exchange. Milbank's orientation is more ecumenical than
Khomiakov's, though. Significantly, Milbank---once again following from
the nature-grace continuity---does not restrict the democratic dispersal
of truth to the visible community of believers but extends it to all
people, who are potentially the Church.#footnote[Ibid., 245.] Therefore,
even the heterodox Christian or the non-Christian has a place within
Milbank's sobornal order. Because of this ecumenical aspect, the logic
of #emph[sobornost'] precludes the institutional Church's imposition of
Christian truth onto non-Christians, because such an imposition (à la
Khomiakov's polemical depiction of Roman Catholicism) would itself
violate the mutuality of consensus, and so would be a “heretical”
separation from the truth itself. For this reason, Aristotle
Papanikolaou's concern that Milbank's focus on consensus “looks very
much like the neo-scholastic principle that the rejection of truth
should not be allowed in a political order”#footnote[Aristotle
Papanikolaou, #emph[The Mystical as Political: Democracy and
(Non-Radical) Orthodoxy] (Notre Dame: University of Notre Dame Press,
2012), 141.] does not seem to be entirely accurate, since, in Milbank's
social #emph[sobornost'], even minority and dissident groups can be
“performing certain roles that contribute to the cohesion of the entire
polity.”#footnote[Milbank and Pabst, #emph[Politics of Virtue,] 82.]

The democratic dimension of Milbank's system is further reinforced by
his insistence on the “personalist” aspect of social performance. In
this way, Milbank treats dignity as the #emph[convergence] of freedom
and responsibility. Dignity is a function of the distinct social
obligations associated with a role or position, but these obligations
must be performed “freely, interpretively and
creatively.”#footnote[Ibid., 83.] This means that the human
#emph[person], the personal claimant of dignity and rights, is not the
abstract subject but a concrete performer of specific obligations. It is
the convergence of freedom and obligation that gives the person their
distinctive personal character, which

“springs up as much spontaneously from herself as from her unique and
complex relational situation.”#footnote[Ibid.] All of this is in keeping
with Milbank's larger understanding of the human person as a
“fabricating animal” whose personality derives from labor directed
towards the realization of the good.#footnote[Ibid., 384.] He goes as
far as to identify the creative performance of obligation with the
person's (always social, never individual) reflection of the #emph[imago
dei]#footnote[Ibid., 84.]#emph[---]this reflection typically being, in
Christian thought, the theological basis of human dignity. For Milbank,
the divine image in humanity is #emph[productive]\; it means “also
constantly to shape better images of deity,”#footnote[John Milbank,
“Sophiology and Theurgy: The New Theological Horizon,” in
#emph[Encounter Between Eastern Orthodoxy and Radical Orthodoxy:
Transfiguring the World Through the Word], eds. Adrian Pabst and
Christoph Schneider (Surrey: Ashgate, 2009), 66.] which we do, in part,
through the collective performance of our social obligations.

All this points to the restricted sense in which Milbank reintroduces a
kind of subjective right. To the extent that Milbank preserves
rights-language at all, rights do not inhere in the pre-social subject
but in social roles as determined by their contribution to charitable
order. The persons who perform these roles can make a subjective claim
to those rights, but the rights themselves are objectively determined by
the location of a role within the order of charity. Milbank's subjective
rights, in this way, are short of subjectivism: “It is indeed allowed
that one can have a legitimate subjective claim to an objective
#emph[ius], but not that such #emph[ius] is ever derived from
self-willing alone.”#footnote[Milbank, “Dignity Rather Than Right,” 90.]
Persons can claim by right whatever is necessary for the performance of
their roles, including the freedom to perform them creatively in ways
that perpetually generate new modes of cooperation and communion, but
legitimate rights-claims are never divorced from one's responsibilities.
In principle, this approach would allow rights to safeguard persons in
their full personal uniqueness as active social creators rather than in
their abstract (and thus interchangeable) individuality.#footnote[See,
e.g., John Milbank, “Against Human Rights: Liberty in the Western
Tradition,” #emph[Oxford Journal of Law and Religion] 1 (2012), 56.]

In sum, Milbank's rights are a kind of “right of service” inseparable
from the (always differentiated) obligation to foster mutual love within
society. Rights are, again, an instrument of the “sobornizing” of the
social order. The general project of linking rights to service is one
that Frank also affirms and, in my view, an attractive one. In Milbank's
version, this project ends up binding rights too closely to “right
order,” specifically a Christian order. Strictly speaking, Milbank does
not identify #emph[sobornost'] fully with a particular order, since
#emph[sobornost'] is the #emph[performance] of charity. Nevertheless,
the sobornal performance does appear to be too tightly bound to an
externally sobornized order, such that it is unclear the extent to which
the performance is possible within some other social and political
order---such as a liberal democratic one. In other words, the
performance appears to depend on the external organization along
ecclesial lines. It rests on a “good and just coordination of diverse
talents and needs”#footnote[Milbank and Pabst, #emph[Politics of
Virtue,] 211.] and the “distribution of specific liberties, offices and
duties to certain individuals and groups in certain circumstances
according to the discernment of what is specifically desirable and has a
tendency to cement human solidarity.#super[”]#footnote[Milbank,
#emph[Future of Love,] 246--247.] Of course, #emph[someone] must perform
this work of discernment and coordination, and Milbank is clear that it
would be carried out within the framework of a Christian
state---ideally, a constitutional monarchy---in “symphonic” cooperation
with an established Church.#footnote[Milbank and Pabst, #emph[The
Politics of Virtue], 210.] Milbank's approach appears to rest on the
legal codification of Christian charity under the Church's guidance.
Therefore, even if the #emph[ecclesia] is not identical to the
#emph[polis,] the performance of ecclesial love within the #emph[polis]
seems to be inseparably tied to the transformation of the #emph[polis]
into an #emph[ecclesia]-shaped Christian political order.

Even setting aside the obvious objections of those who do not share
Milbank's own Christian convictions, the attachment of dignity and
rights to positions/roles within the Christian order calls into question
the possibility of utilizing those concepts #emph[outside] of that
order---an order that, of course, does not currently exist. Milbank
appears to have jettisoned the possibility of #emph[universal] human
rights to which justice advocates might appeal across different social
and religious contexts. This has potentially serious implications for a
Christian politics practiced within the existing liberal democratic
order. Because the objective moral foundation of human rights is not the
human subject itself but the subject's role within the Christian order,
any appeal to human rights must be, at least implicitly, an appeal to
that order. Without an overlapping concept of human rights, all that is
left for Christian politics committed to personal dignity is to
#emph[oppose] the liberal order with a Christian order of charity; it is
not clear how rights or dignity might be a resource for a Christian
politics that works #emph[within] the liberal order to sobornize it from
within, rather than to #emph[replace] it.

In the end, then, Milbank falls victim to Berdyaev's critique, and in
this case---as it has also been for Khomiakov---the “chaining” of
#emph[sobornost'] to an external order accompanies a Christian rejection
of liberalism. Frank, I suggest, offers a way past Milbank's opposition
between liberalism and the order of charity, while still maintaining an
essential link between dignity/rights and social obligation. Rights,
once again, are a function of the performance of #emph[sobornost']
within society, but in Frank's case, that performance does not rest on
the existence of an “ecclesialized” Christian order.

#strong[Frank's #emph[Sobornost'] and #emph[Obshchestvennost']]

Frank provides a more substantial notion of subjective rights than
Milbank does, but this is not to say that he endorses
#emph[subjectivism] in rights. One place Frank uses the language of
“subjective rights” is in his 1927 essay “Property and Socialism,” which
addresses the right to private property from a Christian perspective.
Here Frank defends property rights, but he distances them from what he
calls an “individualistic liberalism” that treats these rights as
absolute as “an expression of pure egoism and
self-interest.”#footnote[Frank, “Eigentum und Sozialismus,” 224.]
Because Frank thinks that no one's self-interest can place moral
obligations onto another, it cannot be the moral basis of subjective
rights-claims. Provocatively, Frank goes as far as to claim that human
beings “cannot have any innate, inalienable or sacred rights” at all, in
the subjective sense.#footnote[Ibid., 225.] This is because Frank, like
Milbank, treats all rights as a right of service: “Every subjective
right has only a functional meaning, directed towards
service.”#footnote[Ibid., 231.] Instead of the inviolability of private
choice, Frank argues that

#quote(block: true)[
Every subjective right only finds its moral basis when it is traced back
to an obligation. In the final analysis, man has only one right, which
is sacred in the true sense (of course every right is sacred, insofar as
it is a true right): the right to be given the opportunity to fulfill
his duty as well as possible, the right to demand that no one should
prevent him from doing so. All human rights, directly or indirectly,
boil down to this single right.#footnote[Ibid, 225.]
]

It is, in other words, not subjective interest but the sacredness of
moral obligation---the responsibility to realize objective
justice---that imbues rights with their sacredness.

The question is how Frank's “right of service” relates to
#emph[sobornost'], and here, he differs notably from Milbank. The “right
of service” links rights to the task of “Christianizing” society by
introducing ecclesial love into social relations and reforming laws and
institutions in a more charitable direction. However, rather than
focusing on an externally sobornized “right order” within which
differentiated rights are determined, Frank locates the link between
rights and #emph[sobornost'] in the historical struggle to
#emph[transform] society in a sobornal direction, a task that is fully
accomplished only eschatologically.

I base this reading on the key distinction between #emph[sobornost'] and
#emph[obshchestvennost'] that Frank develops in his book #emph[The
Spiritual Foundations of Society.] Building on the nature-grace
continuity, Frank sees the #emph[sobornost'] of cosmic all-unity as the
hidden foundation of social relations, even those empirically founded on
contract, because sociality as such originates in the movement (even if
unconscious) towards eschatological communion: “Not only all people but
all that exists in general is destined to participate in the
all-embracing ‘we,' and is therefore potentially a part of
‘we.'”#footnote[Frank, #emph[Spiritual Foundations], 50--51.] For Frank,
if #emph[sobornost'] is the inner foundation of creation, then this
foundation is partly obscured by the reality of empirical atomism,
division, and managed conflict. In his social theory, #emph[sobornost']
is obscured behind #emph[obshchestvennost'], the external, “mechanical”
layer of society. If #emph[sobornost'] is the ontological peace of
all-unity, then in the midst of history, it is submerged within the
#emph[obshchestvennost'], where the superficial peace of contract and
coordinated self-interest dominates. Frank's crucial move is that he
does not treat #emph[sobornost'] and #emph[obshchestvennost'] as two
distinct, rival #emph[types] of social order, like the Slavophiles'
contrast between the Russian commune and Western contract-based society.
Instead, they are two aspects that exist in every social order, as
#emph[obshchestvennost'] imperfectly mediates #emph[sobornost'] in
history: “#emph[Sobornost'] is empirically realized as
#emph[obshchestvennost'], as the interaction of separate, corporeally
isolated individuals.”#footnote[Ibid., 174.] Frank's social theory,
then, is defined by a certain tension between #emph[sobornost'] and
#emph[obshchestvennost']. #emph[Obshchestvennost'] both conceals and
reveals humanity's ontological unity. There is a sense in which
#emph[obshchestvennost'] names society's “fall” from the perfect peace
of communion, but at the same time, it is also the arena in which grace
overcomes that very fallenness. Although Frank no longer relies
explicitly on his #emph[sobornost']/#emph[obshchestvennost'] scheme in
his later, more expressly theological book on politics, #emph[The Light
Shineth] #emph[in Darkness], the Johannine metaphor that frames the
book---“The light shines in darkness, but the darkness has not overcome
it” (John 1:5)---captures the tension between the two: the divine light
of sobornal peace “shines” even in the “darkness” of externalized,
compulsory social relations between individuals, but nonetheless, it
#emph[shines].

It is especially in #emph[The Light Shineth] that Frank lays out what he
describes as a “Christian realist” politics. While the term “Christian
realism” is most strongly associated with the politics of Reinhold
Niebuhr, scholars such as Philip Boobbyer have identified some
commonalities between Niebuhr and Frank, even if there is no evidence
that the two were aware of each other's work.#footnote[Philip Boobbyer,
“A Russian Version of Christian Realism: Spiritual Wisdom and Politics
in the Thought of S. L. Frank (1877--1950),” #emph[The International
History Review] 38.1 (2016), 45--65.] In #emph[Light Shineth], completed
in the wake of the Second World War, Frank's outlook on external social
order takes a somewhat more pessimistic tone, now framed more forcefully
as a kind of sin-burdened “darkness.” Yet Frank's message in the book is
not one-sidedly pessimistic but, like Niebuhr, attempts to balance hope
for social change with recognition of the actual limits of fallen
humanity's capacity for perfection. Frank's realism wrestles with the
tension between Christians' obligation to struggle for the good in
history and the pervasive reality of sin that corrupts every such effort
and casts judgment upon all utopian confidence that the Kingdom of God
can be realized by political means.#footnote[For a concise summary of
Frank's realism, see especially #emph[Light Shineth], 179.] The meaning
of this realism is most clearly on display in the book's final chapter
on the Christian task of perfecting, deifying, or (to use Frank's term)
“Christianizing” the world---a genuine Christian obligation, no doubt,
and one that is in a sense constitutive of the human person created in
God's image (the person's “divine-humanity”), but one that also demands
the rejection of “all political and social fanaticism” associated with
utopian politics.#footnote[Frank, #emph[Light Shineth], 225.] One on
hand, Frank considers the idea that Christianity should not influence
political and social change to be “one of the most bizarre errors of
Christian thought,”#footnote[Ibid., 145.] but on the other hand, he
cautions that “all attempts to directly conquer the world, to include
the world into the church of Christ or to transform it into the church
of Christ, into the blessed and righteous church of God…#emph[lead only
to the distortion of Christ's truth].”#footnote[Ibid., 90.] Christian
politics must not attempt “to ‘save the world'…by the establishment of
some ideal, compulsorily realized #emph[order]”#footnote[Ibid., 167.]
but instead must act only through “separate attempts to directly
influence the world, to let the world feel Christ's
truth.”#footnote[Ibid., 91.]

In other words, Frank's Christian realism refuses the ideal of
“Christian order” in favor of what he calls “the path from inside
outward,”#footnote[Ibid., 225.] which recognizes the inescapable
sinfulness of every social order as long as human personality remains
plagued by ignorance and egoism. Returning to the categories that Frank
developed in #emph[Spiritual Foundations], the realism of #emph[Light
Shineth] can be understood as the refusal of every attempt to realize
#emph[sobornost'] directly in the #emph[obshchestvennost']. In short,
the desire to establish a “Christian order” amounts to the translation
of #emph[sobornost'] into the categories of
#emph[obshchestvennost']---the translation of the free, inner union of
mutual love into external, compulsory political unity, an impossibility
that contradicts the very nature of #emph[sobornost']. Such a confusion
of #emph[sobornost'] and #emph[obshchestvennost'], I suggest, is the
basic error to which Milbank ultimately succumbs. His sobornal order of
charity risks falling into what Frank calls the “heresy of utopianism,”
which he defines as a politics that “transfer\[s\] the function of
salvation to the law, to measures of state compulsion.”#footnote[Frank,
#emph[Light Shineth], 167.] If salvation is the perfect realization of
#emph[sobornost'], wherein the sacred dignity of persons is fully
actualized in their loving reciprocity, Milbank's political theology
appears too confident about the extent to which this salvation can be
accomplished through the legal coordination of dignities within a
Christian socialist order. Frank, by contrast, in some places treats
socialism as a #emph[moral] and #emph[religious] obligation for
Christians but challenges the political translation of that imperative
directly into a socialist order that seeks the “forced realization of
social justice,” since “any attempt to force a Christian virtue,” as by
a “legal norm,” betrays the inner spiritual freedom of
love.#footnote[Simon L. Frank, “Das Problem des »christlichen
Sozializmus«,” in #emph[Jenseits von rechts und links: Anmerkungen zur
russischen Revolution un zur moralischen Krise in Europa], ed. Peter
Schulz, Peter Ehlen, Nikolaus Lobkowicz, and Leonid Luks
(Freiburg/Munich: Verlag Karl Alber, 2012), 321--335. The quoted text is
translated from the German.]

How, then, do #emph[sobornost'] and #emph[obshchestvennost'] inform
Frank's theory of dignity and rights, given the realist orientation of
his thought? He does not, and cannot, join Milbank in situating his
“right of service” within a Christianized #emph[obshchestvennost'].
Instead, Frank's right of service originates within the tension or the
“gap” between #emph[sobornost'] and #emph[obshchestvennost']. Rights
emerge from within the moral intuition that empirical society, with its
constant conflict between individualist atomization and compulsory
unification, points to something higher and deeper; that it is, in some
sense, #emph[unreal], a deviation from the reality of cosmic
#emph[sobornost'] that is creation's divine ground and goal. The right
of service is thus rooted in the perception of one's obligation to
realize, in a piecemeal and #emph[ad hoc] manner, more transparent
expressions of the reality of sobornal peace within the
#emph[obshchestvennost'], but without thereby attempting to realize
#emph[sobornost'] directly #emph[as] an external order. This right
derives, in other words, from sobornization as the ongoing work of
social reform that strives to incarnate traces of love in law and
society, but rights do not derive from one's position within an
already-realized charitable order.

Taking this approach moves dignity back into the willing subject, but
not the empty self-asserting subject. #emph[Sobornost'] is still, for
Frank, the #emph[objective] end of subjective freedom. This is
facilitated by Frank's spin on Soloviev's notion of divine-humanity or
Godmanhood (#emph[bogochelovechestvo]) as humanity's uncreated divine
ground, which for Frank situates the morally obligatory force of
#emph[sobornost'] within the constitution of subjective consciousness
itself. God is the transcendent principle who is immanent within human
personality.#footnote[Frank develops this aspect of divine-humanity in
several places. See, for example, S. L. Frank, #emph[The Unknowable: An
Ontological Introduction to the Philosophy of Religion], trans. Boris
Jakim (Athens, Ohio: Ohio University Press, 1983), Chapter IX “God and
I,” 224--260; and S. L. Frank, #emph[Reality and Man: An Essay in the
Metaphysics of Human Nature], trans. Natalie Duddington (London: Faber
and Faber, 1965), Chapter IV “Man and God,” 110--161.] The human subject
encounters God as a transcendent “Thou” dwelling within the self, an
“Other” who is the innermost ground of the self. Thus, the nature of the
human subject is not that of egoistic self-assertion but divine-human
communion: I am #emph[myself] only in relation to #emph[God-in-me.] At
the same time, my discovery of ontological kinship with God is also the
discovery of kinship with all things in God---Frank's cosmic
#emph[sobornost']. Moreover, the experience of God is also an intuitive
grasping of the #emph[obligatory]. “God-in-me” is none other than God
the Creator, and humanity's kinship with God is necessarily that of
co#emph[\-]creativity. God “#emph[creates creators],”#footnote[Frank,
#emph[Reality and Man,] 157.] insists Frank, and God creates through
human creativity, which is to be “participation in God's activity,” in
service to the realization of God's will.#footnote[S. L. Frank,
#emph[God with Us: Three Meditations], trans. Natalie Duddington
(London: Jonathan Cape, 1946), 159.] For Frank, the obligatory is
experienced as a “free wanting without the element of self-willfulness,
the merging of ‘I should' and ‘I want'”#footnote[S. L. Frank,
#emph[Man's Soul: An Introductory Essay in Philosophical Psychology],
trans. Boris Jakim (Athens, Ohio: Ohio University Press, 1993),
\167.]---or, in other words, not as external #emph[law] but as a
#emph[vocation] originating from within one's own depths, a drive to
take up the realization of the truth freely as #emph[my own] work. Here,
as in Milbank, we find a fusion of freedom and obligation, which is the
image and likeness of God and the basis of human dignity.

#emph[Sobornost'], therefore, exists within Frank's thought not only as
the ontological basis of society but also as a creative task that human
beings carry out as God's co-creators, joining God in the still-ongoing
completion---or deification---of creation by realizing sobornal truth
within it.#footnote[For Frank, creation and deification are “two aspects
of one general creative act” (#emph[Reality and Man], 221). Therefore,
the human being as co-creator also participates in the deification of
creation, or a victory over sin that is already won “in the metaphysical
depths of being” (#emph[Reality and Man,] 223)] As a task,
#emph[sobornost'] grounds subjective rights that remain linked to
service, to the responsibility of building a more just and peaceful
community. These subjective rights are not based on the egoistic
divisions of private interest but on the interior call to
#emph[overcome] those divisions through a divine-human co-laboring. Yet
it is precisely this moral grounding of subjective rights in obligation
that requires the #emph[obshchestvennost'] to be founded on individual
freedom, not as the protection of egoism, but as the human being's
“primordial #emph[obligation],” since freedom is “the general and
highest condition for the fulfillment of all his other
obligations.”#footnote[Frank, #emph[Spiritual Foundations], 136.] Thus,
returning to the topic of property rights Frank addresses in “Property
and Socialism,” he offers a Christian justification for private property
on the basis of freedom as an “indispensable prerequisite” for “the
realization of morality”#footnote[Frank, “Eigentum und Sozialismus,”
\231.] and for “productive service” that fosters social
solidarity.#footnote[Ibid., 248.] This is an adoption and subversion of
possessive individualism: a society founded on property rights, but
those with rights themselves based not in atomism but in the recognition
of human unity.

Individual freedom, as the precondition of service, is therefore also
the precondition for the realization of #emph[sobornost']. Thus, we
arrive back at Frank's “realist” duality of #emph[sobornost'] and
#emph[obshchestvennost']: while #emph[sobornost'] enacts a peace and a
communion beyond the liberal rights-based order, the conditions of its
realization demand the recognition of individual rights that are, by
themselves, something less than #emph[sobornost'] and cannot ever
guarantee its realization. For although Frank allows that subjective
rights such as the right to property are non-absolute and can be
“chastened” by the responsibilities of charity, the nature of
#emph[sobornost'] as a #emph[free] communion of mutual love precludes
its exact convertibility into a fully realized Christian alternative.
Politics is the “one domain of human creativeness which stands by its
very nature in dangerous proximity to demonism,” including the sin of
“unrestrainedly ordering people's destinies (even if it does so with the
good intention of improving them).”#footnote[Frank, #emph[Reality and
Man,] 188.] Christian politics, therefore, must inhabit the tension
between #emph[sobornost'] as the ideal norm of social action and the
impossibility of its accomplishment as a Christian social order; and
yet, it is precisely this persistent gap between #emph[sobornost'] and
#emph[obshchestvennost'] that preserves the space for the free, creative
work of charitable social engagement through which #emph[sobornost'] is
performed and human dignity is expressed.

#strong[Conclusion]

Both Milbank and Frank draw on #emph[sobornost'] to challenge the
separation of rights from social responsibility, yet the differences
between their approaches have important implications for subjective
rights and their relationship to “Christian order,” and so also for the
relationship between Christian politics and liberal democracy. As I have
argued, Milbank errs by tying #emph[sobornost']---and thus dignity and
rights---too closely to a postliberal Christian order of charity, while
Frank offers a corrective to Milbank's error with his distinction (but
not separation) between #emph[sobornost'] and #emph[obshchestvennost'].
The upshot of Milbank's treatment is that a Christian conception of
human dignity (as well as what he retains of subjective rights) is
ultimately incompatible with liberalism. Frank, on the other hand, is
critical of liberal individualism, which is at odds with
#emph[sobornost']\; but his detachment of subjective rights from an
externally realized sobornal order provides greater opportunity for
(critical) Christian support of liberalism. Frank shows that one of the
foundational concepts of liberalism, subjective individual rights, can
be established on sobornal terms, shorn of possessive individualist
justifications. In that case, a political #emph[sobornost'] can offer an
opportunity for fruitful Christian engagement with the liberal
tradition---a chance to imagine better, more charitable
liberalisms---and not simply to oppose it with a Christian alternative.

<end-of-wood>
