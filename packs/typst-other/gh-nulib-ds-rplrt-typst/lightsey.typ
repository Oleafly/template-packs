#import "elements.typ": *

#counter(footnote).update(0)
#abstract(
  [Ecologies of Care],
  abstract-subtitle: [Gregory of Nyssa & Sergii Bulgakov on Human Dignity and Responsibility],
  abstract-author: [Daniel Adam Lightsey],
  [
    ],
  abstract-keywords: []
)

// This section sets the headers for the article
#set page(
  header-ascent: 40%,
  header: context {
    set text(8pt, font: "IBM Plex Sans", stretch: 75%, weight: 400)
    let first-page = locate(<first-page-lightsey>).page()
    if here().page() == first-page [
      #grid(
        columns: (45%, 45%),
        gutter: 10%,
        align(left)[
          NORTHWESTERN UNIVERSITY STUDIES IN RUSSIAN\
          PHILOSOPHY, LITERATURE, AND RELIGIOUS THOUGHT
        ],
        align(right)[
          Volume 2 (2024): #first-page#sym.dash.en#locate(<end-of-lightsey>).page() \
          10.71521/s31r-ah05
        ]
      )
    ] else if calc.even(here().page()) [
      #set align(center)
      #set text(font: "IBM Plex Sans", size: 11pt, weight: 600)
      #upper([Daniel Adam Lightsey])
    ] else [
      #set align(center)
      #set text(font: "IBM Plex Sans", size: 11pt, weight: 300, tracking: .1em)
  #upper([_Ecologies of Care_])
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

#heading(level: 2)[Ecologies of Care]
<first-page-lightsey>
#v(1em)
#subtitle([Gregory of Nyssa & Sergii Bulgakov on Human Dignity and Responsibility])

#v(1em)
#author[Daniel Adam Lightsey]






The hardest thing of all to see is what is really there.#footnote[J. A.
Baker, #emph[The Peregrine] (New York: NYRB, 2005), 19.]

#emph[La splendeur qui ne veut rien appelle pourtant notre
chant].#footnote[Jean-Louis Chrétien, #emph[L'effroi du beau] (Paris:
CERF, 2011), 73.]

Halfway, or thereabouts, into Henri Bosco's absorbing novel
#emph[Malicroix] (1948)#emph[,] the reader encounters a pivotal scene.
Until this point, the tale has mostly marked the journey of a young man,
a Monsieur Martial, to an estate on a remote island in the Camargue
region with rarely another soul present save a taciturn shepherd,
Balandran, and his dog, Brequillet. Committed to a rather opaque though
perilous task, Martial---roiled by competing bloodlines in his veins
though steadily gaining poise---is finally accepted by Balandran into
the shepherd's distant world of wind, water, and care of the flock. By
this act of loving acknowledgement, Martial feels a joyous dilation to
his very person, recounting that Balandran's words of confidence bound
“my future and were worth more than any solemn promise I myself might
have made, . . . My whole life was what this wild shepherd expected from
me. I was no longer alone. Someone had begun to love me in this immense
solitude. . . . In expressing his faith, Balandran had just given
himself; and in giving himself, he had enlarged me beyond
myself.”#footnote[Henri Bosco, #emph[Malicroix,] trans. Joyce Zonana
(New York: NYRB, 2020), 137--138. On the theological, literary notion of
dilation as a joyous expansion of one's very self in love, see
Jean-Louis Chrétien, #emph[La Joie spacieuse: Essai sur la dilatation]
(Paris: Minuit, 2007).]

What I aim to demonstrate in this essay is how Gregory of Nyssa (c.
335--c. 395) and Sergii Bulgakov (1871--1944) possess resources in their
written corpuses that evoke Bosco's account of the joyful dilation of
one's sense of self simply by the loving acknowledgment of an-other. My
desire is to show how both Gregory and Bulgakov, for all their vital
emphasis on the unity of the “Whole Anthropos,” place a primacy
#emph[also] on the individual person by way of fostering pathways for
all human persons to actualize freedom, self-determination, and creative
potential for what Bulgakov terms the “personal redemptions of the
soul.”#footnote[Sergii Bulgakov, “Карл Маркс как религиозный тип,” in
#emph[Сочинения в Двух Томах], ed. I. B. Rodnianskaia (Moscow: Nauka,
1993), 2:246. (Henceforth “KM”). All translations are mine unless
otherwise noted.] I am calling this an ecology of care, which is built
upon how both Gregory and Bulgakov develop #emph[love], #emph[freedom],
and #emph[life] in their distinct #emph[oeuvres].#footnote[In a recent,
formative essay, Rowan Williams too brings to the surface a thematic of
#emph[care] in Bulgakov: “Bulgakov in effect claims that hypostatic
existence is intrinsically a form of life characterized by #emph[care]:
to exist hypostatically is to be in a relationship of ‘nurture' towards
the world that is encountered. To put it still more strongly, any
account of subjecthood that ignores the responsibility to nurture and
include the environment in the construction of human meaning is illusory
and destructive,” in “Sergei Bulgakov's Christology and Beyond,” in
#emph[Building the House of Wisdom. Sergii Bulgakov and Contemporary
Theology: New Approaches and Interpretations], eds. Barbara
Hallensleben, Regula M. Zwahlen, Aristotle Papanikolaou and Pantelis
Kalaitzidis (Münster: Aschendorff Verlag, 2024), 36--37, emphasis
original. My thanks to the anonymous reader who pointed out this
important text.] This triple-knot of concepts is caught up in a larger
vision, a kind of theological aesthetic that---though not greatly
elaborated upon in this essay---concerns the human person's perception
of and creative movement towards the #emph[beautiful].#footnote[As said,
this essay does not set out to define or develop a theory of beauty or
the beautiful, but a brief aside as to how it is utilized throughout may
prove beneficial. By the #emph[beautiful]---a manifold concept for both
Gregory and Bulgakov---one may regard it as the attractive aspect of
that transcendental horizon saturating every nook and cranny of creation
proper as well as a #emph[name] of God who never ceases in summoning all
of creation to theosis: “God is good; He is Goodness itself. God is
true; He is Truth itself. God is glorious, and His Glory is Beauty
itself,” as Sergii Bulgakov put it in his essay, “Religion and Art,” in
#emph[The Church of God: An Anglo-Russian Symposium,] ed. E.L. Mascall
(London: S.P.C.K. 1934), 175. For both thinkers, though they formulate
it by diverse means, God #emph[is] beauty and beautiful---oft times cast
in terms of the immanent trinity's ineffably infinite life of bliss and
joy; mutually beholding and being beholden, the Father, Son, and Holy
Spirit share the eternally mutual gaze of love, ever enjoying the
radiant dance of perfect unity-in-difference. Thus, at least one
implication of this is that beauty is not #emph[only] a quality or
property of God's relationship with the world (e.g., that God
#emph[only] creates the world beautiful, or God #emph[simply] relates to
the world eschatologically as drawing it toward beauty) nor #emph[only]
a designation of those encounters when human perception of internal and
external realities escape one's grasp, those very real moments when
something, someone, some experience elicit “an instinct for an order
beyond the one it enacts,” as Christian Wiman phrases it in his book,
#emph[Zero to the Bone: Fifty Entries Against Despair] (New York:
Farrar, Straus, and Giroux, 2023), 126. The beautiful, therefore,
exceeds and evades, in the final analysis, purified propositional
analysis. Much more, of course, would need to be said about the nature
of “ugliness” or “grotesquery” vis-à-vis beauty in distinctly Christian
thought, since at the center of this religious tradition is the
“God-Man” who gives himself over to be brutally tortured and executed as
well as resurrected with the wounds still visible. Furthermore, the
history of the use of beauty-language and thought-forms is as violent
and violating as any other. However, no space will be given to
developing these thematics here. Instead, for one work that does address
these issues in relation with Gregory, see Natalie Carnes, #emph[Beauty:
A Theological Engagement with Gregory of Nyssa] (Eugene, OR: Cascade
Books, 2014), especially 17--36, 125--250.]

Why place the fourth-century Cappadocian bishop and twentieth-century
Russian dogmatician in the same essay? First is to honor Nikolai
Berdyaev (1974--1948), who both prized Gregory's work for stressing
humanity's royal origins and nature and was an important companion of
Bulgakov's.#footnote[Nikolai Berdyaev, #emph[The Meaning of the Creative
Act,] trans. Donald Lowrie (San Rafael: Semantron Press, 2009), 82. If
the honorific nature of this statement seems like a bolt out of the
blue, the conference to which this essay was originally given in a
shorter form was in honor of the 150#super[th] birthyear of Berdyaev
(“Religion, Human Dignity, and Human Rights: New Paradigms for Russia
and the West,” Hamilton Center for Classical and Civic Education,
University of Florida, November 1--2, 2024). Furthermore, the conference
concerned an interdisciplinary exploration of various genealogies of
human rights vis-à-vis religious ideas, traditions, and institutions,
specifically regarding freedom, dignity, and rights---hence the
thematics of this essay. On Berdyaev and Bulgakov's philosophical
relationship regarding their conceptions of the human, see the excellent
work of Regula Zwahlen, #emph[Das revolutionäre Ebenbild Gottes:
Anthropologien der Menschenwürde bei Nikolaj A. Berdjaev und Sergej N.
Bulgakov] (Münster: LIT Verlag, 2010); cf. also Zwahlen's distillation
of the aforementioned in “Different Concepts of Personality: Nikolaj
Berdjaev and Sergej Bulgakov,” #emph[Studies in East European Thought]
64, no. 3/4 (2012): 183--204.] Second, Bulgakov calls upon Gregory often
throughout his own work. And third, though the chief reason, through
discrete analyses of Gregory's “abolitionist” thought and Bulgakov's
personalist metaphysics---each taken on its own merits for the bulk of
the essay---we begin to see these portraits form a compelling collage of
sorts, offering a religiously humanistic approach to the same “problem,”
namely, the human person. We will begin with Gregory's pronouncements
regarding the legal manumission of all slaves (argued on distinctly
theological grounds) that each person may experience a prefiguring of
eschatological life and bliss as they grow into that radiant Beauty
which is Divine Goodness. Then, we will move to Bulgakov, who
concretizes in his own way the interdependence of persons who possess
the dignity and, indeed, responsibility to see in the face of the other
divine beauty-in-relationality. Then, in conclusion, both Gregory and
Bulgakov will be brought into more direct dialogue.

The precarity of placing two figures separated by well over a millennium
of culture, language, geography, political alignment, theological and
philosophical development, empires falling, states rising, #emph[etc.],
is not lost on the author though neither is it overly much a concern for
the narrow purposes of this essay. As far as a short #emph[apologia]
regarding methodology---first, what this brief essay is #emph[not]. It
is not an analysis of Bulgakov's mostly positive though at times
critical reception of Gregory's thought (which, of course, would be
greatly welcome).#footnote[Bulgakov utilizes Gregory's thought
throughout the later portion of his life---for example, see his 1914
essay “The Meaning of St. Gregory of Nyssa's Teachings about Names” on
through to an appended essay to #emph[The Bride of the Lamb]
(posthumous, 1945) titled “On the Question of the Apocatastasis of the
Fallen Spirits (in Connection with the Teaching of Gregory of Nyssa),”
as well as many places in between. In the secondary literature, the
majority of Bulgakov---Gregory couplings involve their staunch adherence
to forms of universal salvation. On #emph[apokatastasis,] see Paul
Gavrilyuk, “Universal Salvation in the Eschatology of Sergius Bulgakov,”
#emph[Journal of Theological Studies] 57, No. 1 (2006): 110--32.]
Furthermore, it is #emph[not] a straightforward comparison of certain
words or concepts within these writers' respective writings nor a
comparison of their theological “systems” #emph[in toto]. What this
constructive essay #emph[is], on the other hand, is an attempt to sketch
how both Gregory and Bulgakov, initially taken as distinct signposts,
build a Christian theological case for a religiously humanistic view of
personhood as honoring the individual dignity of each human body and
life as well as necessarily entailing a robust capacity for
relationality, whether this is with companions, strangers, friends,
enemies, embedded communities, and so on. And lastly, for some readers,
the primacy of the human in Gregory and Bulgakov will seem like a relic
of the past, one that could be critiqued as having contributed to the
ecological crises of the present (and future) as well as implicated in
certain utilitarian approaches towards animal and plant life. It is not
my intention to assuage such fears or provide an apologetic as to the
opposite. However, if simply due to intellectual uprightness, one will
find diverse resources within Gregory and Bulgakov that show care for
the environments humans are gifted to steward.#footnote[In other words,
the extreme, and certainly caricatured, notion of #emph[why polish the
brass of a sinking ship?] (i.e., the latter symbolizing the world on the
way to the fires of the eschaton) certainly does not apply to Gregory or
Bulgakov. For example, see Gregory of Nyssa, #emph[On the Soul and the
Resurrection,] in #emph[Ascetical Works,] trans. Virginia Woods Callahan
(Washington D.C.: Catholic University of America Press, 1967), 270.
(Henceforth #emph[OSR]). Here, Gregory's older sister, Macrina, teaches
him that in the resurrection, “None of the beauties we see now, not only
in men, but also in plants and animals, will be destroyed in the life to
come.” Also, to anticipate the argument below, Hans Boersma judges
correctly that Gregory's argument for the abolition of slavery in the
eschaton is likely due to Gregory's “conviction that the eschatological
reality of freedom from sin must take shape in the social structures of
this world. His anagogical theology does not render him indifferent to
material and bodily concerns.” See Hans Boersma, #emph[Embodiment and
Virtue in Gregory of Nyssa: An Anagogical Approach] (Oxford: Oxford
University Press, 2013), 159. For his part, Bulgakov writes, “God put
#emph[everything] into His creation that could be put into it. This gift
of the Creator to creation, . . . as a task to be realized, contains
fullness and perfection to the extent they can be received by creation,
which is created out of nothing and permeated by this nothing as its
inner boundary. However, the creature receives the possibility of
ascending to perfection, of removing boundaries, of overcoming the
‘individual' as self-isolating, nonuniversal being in the ongoing
sophianization of creation.” Sergii Bulgakov, #emph[The Bride of the
Lamb], trans. Boris Jakim (Grand Rapids, MI: Eerdmans, 2002)#emph[,]
149, emphasis original. (Henceforth #emph[BL]). See too later in
#emph[BL,] “the figure of the new Jerusalem signifies the transfigured
and glorified world, which contains the principles of the natural world
and the synthesis of human creative activity in history” (523). Cf.
Sergii Bulgakov, #emph[The Tragedy of Philosophy (Philosophy and
Dogma)], trans. Stephen Churchland (Brooklyn, NY: Angelico Press, 2020),
\117. (Henceforth #emph[TP.]) For a helpful discussion, see Bruce Foltz,
#emph[The Noetics of Nature: Environmental Philosophy and the Holy
Beauty of the Visible] (New York: Fordham University Press, 2014),
88--112.]

#heading(level: 3)[Gregory of Nyssa]

For the towering fourth century figure, one can build a case for a kind
of religious humanism via any number of texts or directions in his
thought. The one I choose to focus on here is his denunciations of
slavery on decidedly #emph[theological] grounds.#footnote[Bulgakov too
refers to the incompatibility of human dignity and institutions of
slavery. For example, in “Первохристианство и новейший социализм”
(1909), Bulgakov speaks of the internal revolution of the individual
that Christianity instantiates in history, a revolution that ultimately
eschews any depersonalizing collective as well as overcomes, eventually,
all legal and societal organizational boundaries such as the relations
of master and slave. See Bulgakov, #emph[Два града: Исследования о
природе общественных идеалов,] ed. Vadim V. Sapov (St. Petersburg:
Издательстбо Русского Христианского гуманитарного института, 1997), 195.
My gratitude to the anonymous reviewer who pointed me to this text.]
#emph[In nuce], Gregory's argument is that one consequence of spiritual
slavery is legal slavery, which is thus in need of eradication;
furthermore, the sheer hubris of one human subjecting another---both of
them sharing in the dignity of imaging God's freedom as well as unified
in one nature---to a life of slavery amounts to an arrogance beyond
reckoning.#footnote[The scholarly literature on Gregory's anti-slavery
thought is immense. For but a few works, see Trevor Dennis, “The
Relationship between Greogry of Nyssa's Attack on Slavery in his Fourth
Homily on Ecclesiastes and his Treatise #emph[De Hominis Opificio],”
#emph[Studia] #emph[Patristica] 17.3 (1982): 1065--1072; #emph[idem.,]
“Man beyond Price: Gregory of Nyssa and Slavery,” in #emph[Heaven and
Earth,] eds. Andrew Linzey and Peter J. Wexler (Wexler, Worthing:
Churchman, 1986), 129--145; Daniel F. Stramara Jr., “Gregory of Nyssa:
An Ardent Abolitionist?” #emph[St. Vladimir's Theological Quarterly] 41,
no. 1 (1997): 37--60; Richard Klein, #emph[Die Haltung der
Kappadokischen Bischöfe Basilius von Caesarea, Gregor von Nazianz und
Gregor von Nyssa zur Sklaverei] (Stuttgart: Steiner, 2000); Boersma,
#emph[Embodiment and Virtue,] 146--177; Ilaria L. E. Ramelli,
#emph[Social Justice and the Legitimacy of Slavery: The Role of
Philosophical Asceticism from Ancient Judaism to Late Antiquity]
(Oxford: Oxford University Press, 2016), 172--211; David Bentley Hart,
“The Whole Humanity: Gregory of Nyssa's Critique of Slavery in Light of
his Eschatology,” in #emph[The Hidden and the Manifest: Essays in
Theology and Metaphysics] (Grand Rapids, MI: Eerdmans, 2017), 237--252;
and J. Kameron Carter, “Interlude on Christology and Race: Gregory of
Nyssa as Abolitionist Intellectual,” in #emph[Race: A Theological
Account] (Oxford: Oxford University Press, 2008), 229--251.] In an
Easter sermon likely preached in 379, Gregory does not denounce legal
slavery only on the grounds of philanthropic goodwill towards the other
(although, of course, this would be commendable in and of itself), nor
does Gregory only direct his comments to those seeking to live an
ascetical life.#footnote[One often encounters in the secondary
literature on Gregory's abolitionism Seneca's laudable 47#super[th]
epistle, which too concerns the plight of slaves. Seneca is, however,
not making any overt #emph[theological] claims here (for which, of
course, he is not at fault, though it should be pointed out how
different this is from Gregory's #emph[theo-]logic).] Instead, he
addresses all households within the congregation: by manumitting slaves
in this present context---releasing and acknowledging them “with equal
decency” as all other persons of the community, letting “the beauty of
the feast blossom like a flower upon everyone”---a prefiguring of the
resurrection of all persons from the grave occurs; thus, the end of
spiritual slavery, progressively unfolding #emph[in part] through the
abolition of legal slavery, restores humanity to its original condition
of #emph[freedom] and #emph[life] without death.#footnote[Gregory of
Nyssa, #emph[In Sanctum Pascha,] trans. Stuart George Hall, in #emph[The
Easter Sermons of Gregory of Nyssa], eds. Andreas Spira and Christopher
Klock (Cambridge, MA: The Philadelphia Patristic Foundation, 1981),
8--9. Cf. “Faire sortir les esclaves de la honte . . . préfigure la
résurrection des morts,” as Marguerite Harl writes in her, “L'Éloge de
la fête de Pâques dans le Prologue du Sermon In Sanctum Pascha de
Grégoire de Nysse,” in #emph[The Easter Sermons of Gregory of Nyssa],
\91. Cf. Ramelli, #emph[Social Justice,] 175; Hart, “The Whole
Humanity,” 239; Boersma, #emph[Embodiment and Virtue,] 160--161---all of
whom make a similar argument.]

Freedom and life are intertwined in Gregory's thought concerning
humanity and the cosmos in general. “\[L\]ife,” he preaches in his
marvelous #emph[Homilies on the Song of Songs], “is the very center of
God's plantation. Death, on the contrary, is, in and of itself, rootless
and unplanted, since it has no place of its own.”#footnote[Gregory of
Nyssa, #emph[Homilies on the Song of Songs,] trans. Richard Norris Jr.
(Atlanta: Society of Biblical Literature, 2012), 369. (Henceforth
#emph[HSS]).] In other words, an ecology of care, as Gregory helps build
it, begins by acknowledging that life and the paths of life are
characteristic of the givenness of things as they are crafted at their
origin, whereas death and the ways of death, including spiritual and
legal slavery, are by way of privation.#footnote[#emph[HSS,] 371.]
#emph[Life], for Gregory, ultimately concerns the creature's infinite
ascent of desirous love to the Good, which constantly forms the pursuer
of the Good by way of attracting them “to that ascent” and
“#emph[constantly expands] as one progresses in pressing on to the
Good.”#footnote[Gregory of Nyssa, #emph[The Life of Moses,] trans.
Abraham Malherbe and Everett Ferguson (New York: Paulist Press, 1978),
2:238, emphasis mine.] This #emph[epektic] logic---a “stretching forth”
into the divine infinite---is foundational for all of Gregory's thought,
a vision of the spiritual life as an erotic summons by and to as well as
participation “in the transcendent Beauty,” whereby one's “desire
increases in proportion to \[one's\] progress toward” that ever old,
always new “Light.”#footnote[#emph[HSS,] 171. See J. Warren Smith,
“Becoming Men, Not Stones: #emph[Epektasis] in Gregory of Nyssa's
#emph[Homilies on the Song of Songs,]” in #emph[Gregory of Nyssa,~In
Canticum Canticorum: Analytical and Supporting Studies: Proceedings of
the 13th International Colloquium on~Gregory of Nyssa~(Rome, 17--20
September 2014),] eds. Giulio Maspero, Miguel Brugarolas, Ilaria
Vigorelli (Leiden: Brill, 2018), 340--359.] And since it is constitutive
of humanity's nature to be shaped by and become in some regard whatever
“it determines upon, . . . whatever goal the thrust \[of which\] its
choice leads,” all the while undergoing “alteration in accord with what
it seeks,” then proximity to the Good for the ascender opens them to
take in more of Divine life and love without it ever being
exhausted.#footnote[#emph[HSS,] 113.] As Gregory's sister Macrina
teaches him near the end of their captivating dialogue, #emph[On the
Soul and the Resurrection,] humanity was made in wisdom as a kind of
“receptacle” for rationality, freedom, and divine goods, “a place that
always becomes larger because of what is additionally poured into it.
For participation in the divine good is such that it makes larger and
more receptive that in which it exists,” ever allowing one to grow in
“power and size,” becoming more “capable” and
“spacious.”#footnote[#emph[OSR,] 244--245.] As one grows, one abounds in
nourishment from the source of wisdom, love, and life as such. Regarding
the faithful ways of life in relation to God's making of the human in
his image and likeness, the keystone is the concept of #emph[freedom].
As Gregory makes plain in his #emph[Catechetical Orations,]

#quote(block: true)[
If some necessity presided over human life, the image would have been
false in that part, being alien to the archetype by \[its\]
dissimilarity; for how would it be called the image of the kingly nature
if it were under yoke to and enslaved by some necessities? Therefore
what is similar to the divine in all things must by all means have
self-mastery and independence by nature, so that the prize for virtue
may be participation in good things.#footnote[Gregory of Nyssa,
#emph[Catechetical Discourse: A Handbook for Catechists,] trans.
Ignatius Green (Yonkers, NY: St. Vladimir Seminary Press, 2019), 5.10.
(Henceforth #emph[CD]).]
]

Furthermore, humanity, Gregory avers, is created with one unified
nature, possessing the “form of every beauty, all virtue and wisdom, and
every higher thing that can be conceived.”#footnote[Gregory of Nyssa,
#emph[On the Human Image of God,] trans. John Behr (Oxford: Oxford
University Press, 2023), 16.11. Gregory continues, “Of all these, one is
to be free from necessity, and not in bondage to any natural domination,
but to have self-determining deliberation regarding what we resolve.”]
Gregory argues that God “craft\[s\] the genesis of such a living thing
out of an excess of love,”#footnote[#emph[CD,] 5.3.] “love for man”
being “the characteristic property of the divine
nature.”#footnote[#emph[CD,] 15.2.] Also, humanity “was born for the
enjoyment of divine good things”; therefore, the human possesses a
“nature” that holds “some kinship with that of which \[the human\]
partakes.”#footnote[#emph[CD,] 5.5--6. Gregory immediately continues,
“Because of this \[humanity\] was adorned with life and reason and
wisdom and all God-befitting good things, so that through each of them
\[each human person\] might have the desire for what is proper \[to
oneself\].”] And to be able to do this, God fashioned human nature as
“both independent and uncontrolled.”#footnote[#emph[CD,] 5.12.] Human
nature “was made godlike and blessed because it had been honored with
free autonomy (as ruling oneself and being without a master is the
specific property of divine blessedness), for humanity to be forcibly
changed to something else through constraint would have been a removal
of its dignity.”#footnote[Gregory of Nyssa, #emph[De Mortuis,] trans.
Rowan Greer, in #emph[One Path for All: Gregory of Nyssa on the
Christian Life and Human Destiny] (Cambridge: James Clarke and Co,
2015), 108--109.] In responding to those who see nothing but distortion,
suffering, and perishability around them, Gregory argues that this is
not the origin of human persons: “For he who made man for participation
in his own good things, and who fashioned in his nature the origin for
all things that are good for him, . . . did not rob \[humanity\] of the
best and most honorable of good things, I mean the grace of
#emph[independence and self-determination.]”#footnote[#emph[CD,] 5.9,
emphasis added, translation slightly modified.]

By “independence” and “self-determination,” Gregory means the
sovereignty to enjoy and adhere to the Good as such, since “choosing”
evil (understood as philosophically unsubstantial and thus parasitical)
is not ultimately a free act.#footnote[Ramelli, #emph[Social Justice],
\184. Cf. #emph[OSR,] 242: “since it is the nature of evil not to exist
apart from choice, when all choice resides in God, evil will disappear
completely because there will be nothing left to contain it.”] Gregory
is certainly not a kind of parodied libertarian, and thus, #emph[real]
freedom is to be found in reaching a point where one does not need to
#emph[choose] between good and evil at all. This is because the Good as
such is the ultimate end of the human appetite, the radiance to which
all desirous intention is ultimately aimed. This, in turn, necessitates
#emph[process] and #emph[development] for Gregory's philosophical
anthropology. To those who fear or show disgust at humanity's inherent
mutability, Gregory gently reminds them in the conclusion of #emph[On
Perfection,] mutableness in the creature is not always for the worse but
potentially for the nobler, the more beautiful, changing into “something
more divine,” exchanging “glory for glory” and “becoming greater through
daily increase.”#footnote[Gregory of Nyssa, #emph[De perfectione,] in
#emph[Ascetical Works,] trans. Virginia Woods Callahan (Washington D.C.:
Catholic University of America Press, 1967), 122. Cf. #emph[OSR,] 240.]
An ecology of care where this vision of freedom is basic sees true
#emph[perfection] as not a final arrival at a promontory of
faultlessness nor deserting those associations and idiosyncrasies each
person possesses, but never stopping in one's growth towards that which
is more radiant.

With all of this in mind, we can approach again what is at issue and at
stake in Gregory's severe condemnation of slavery. Firstly, and of great
importance given some common stances towards slaves and the practices of
legal slavery in antiquity, Gregory does not conceive of slavery as
#emph[natural] nor a #emph[necessary] #emph[evil]. For example, Gregory
is adamant that those whom society at large looks upon as downtrodden,
the “naked and homeless . . . strangers and exiles,” were not assigned
this life “by birth”---meaning, one cannot shift obligation to the
victim of misery and tribulation because it is their so-called #emph[lot
in life] (Gregory is, of course, simply reiterating some synoptic
accounts, e.g., Luke 13; John 9).#footnote[Gregory, #emph[De
beneficentia,] 194.] If so for those victims of war, plague, famine,
#emph[et al.,] then even more for those persons entrapped within the
structures of slavery. Indeed, Gregory is unyielding: humanity itself is
responsible for splitting into the camps of slave and free. “Not
nature,” Gregory thunders in his exegesis of the Lord's prayer, “but
\[a\] ‘spirit of dominion' has divided humanity into slavery and
masters.”#footnote[Quoted in Ramelli, #emph[Social Justice,] 177.
Gregory's “spirit of dominion” and Augustine of Hippo's notion of
#emph[libido dominandi,] especially as described in #emph[de Civitate
Dei] bk. 14, are worthy of further exploration.] What's more, this
“spirit of dominion” serves to make humanity irrationally enslaved to
itself: human self-division into “slavery” and “ownership,” making the
Whole Anthropos “enslaved to itself, and to be the owner of
itself.”#footnote[Gregory of Nyssa, #emph[In Ecclesiasten homiliae], in
#emph[Gregory of Nyssa: Homilies on Ecclesiastes,] trans. Stuart George
Hall and Rachel Moriarty (Berlin: de Gruyter, 1993), 74. (Henceforth
#emph[Eccl]).] The farcicality, Gregory seems to suggest in his obloquy,
could produce droll amusement, if not for the utterly grave and perverse
nature of the absurdity.

In his justly famous fourth homily on Ecclesiastes (exegeting Eccl. 2:7,
“I bought male slaves and slave girls, and I had home-born slaves too.
Also many herds of cattle and sheep did I have, more than all who were
before me in Jerusalem.”#footnote[Translation from Robert Alter,
#emph[The Hebrew Bible: Volume Three, The Writings] (New York: W.W.
Norton & Company, 2019), 682.]), Gregory elucidates upon the
catastrophic implications of being under the sway of this “spirit of
dominion.” While the word count for this section of his larger homily is
quite small, Gregory's unrelenting critique of slavery and those who
ignorantly possess the hubris to believe they “own” another person is
something fearsome to behold.#footnote[Ramelli rightly argues that
Gregory's forceful denunciations in his fourth homily on Ecclesiastes
represents a “structural” argument that “emerges throughout a full range
of his works,” Ramelli, #emph[Social Justice,] 178. Cf. Boersma,
#emph[Embodiment and Virtue,] 149.] First, Gregory warns those who
operate as if they are outside the bounds of human nature that it is a
“challenge to God” when they “‘assume divine power and authority' by
considering themselves masters over the life and death of” other human
persons, which is nothing more than an aberrantly “mistaken masquerade
of government.”#footnote[Gregory of Nyssa, #emph[De beatitudinibus], in
#emph[Gregory of Nyssa: On the Beatitudes,] trans. Stuart George Hall
(Leiden: Brill, 2000), 30#emph[.]] The pretense of this unfaithful
will-towards-division is not of Life as such, which, as constitutive to
an ecology of care, concerns the erotic pursuit of Goodness itself since
human persons are “lovers of the transcendent
Beauty.”#footnote[#emph[HSS,] 183.] Furthermore, the pursual of this
ultimate end is normative for all patterns of life here and
now.#footnote[Cf. Ramelli, #emph[Social Justice,] 175--176.] Thus, one
can best journey when made free of unnatural burdens, including the
bondages of legal slavery.

While one should not conflate spiritual slavery with legal slavery in
Gregory's thought, neither can they be neatly separated into competing
spheres of concern. “All freedom,” Macrina tells Gregory, “is
essentially the same and identical with itself. Consequently, everything
that is free is in harmony with whatever is similar to
itself.”#footnote[#emph[OSR,] 243.] The context of Macrina's line of
argumentation concerns freedom as consisting in virtue, and because the
divine nature is the origin of virtue, each person who is truly free
(and specifically free of #emph[vice]) resides in the divine life that
God may be #emph[all] #emph[in] #emph[all.] To be sure, the argument is
made in relation to spiritual freedom from the ignorance entailed in the
devastating distortions of sin in the world. But, again, considering
Gregory does not wholly bifurcate “the beautiful harmonies of
Neoplatonism with the radical historicality of Christianity,” all
quotidian pathways toward freedom in the here and now anticipate the
final restoration.#footnote[David Bentley Hart, “Matter, Monism, and
Narrative: An Essay on the Metaphysics of #emph[Paradise Lost],” in
Hart, #emph[The Hidden and the Manifest: Essays in Theology and
Metaphysics] (Grand Rapids, MI: Eerdmans, 2017), 235.]

Returning to his fourth homily on Ecclesiastes, Gregory roars against
the would-be master: “You condemn man to slavery, when his nature is
free and possesses free will, and you legislate in competition with God,
overturning his law for the human species. The one made on the specific
terms that he should be the owner of the earth, and appointed to
government by the Creator---him you bring under the yoke of slavery, as
though defying and fighting against the divine
decree.”#footnote[#emph[Eccl,] 73.] Since each human person is more
valuable than the entirety of the world (a logic expressed by Bulgakov
below), then each person is to be perceived as an “owner of the whole
cosmos.”#footnote[Ramelli, #emph[Social Justice,] 178.] Gregory
continually lampoons those who think themselves “master” over another
image bearer, as if one person can be a “buyer” of another:

#quote(block: true)[
He who knew the nature of mankind rightly said that the whole world was
not worth giving in exchange for a human soul. Whenever a human being is
for sale, therefore, nothing less than the owner of the earth is led
into the sale-room. Presumably, then, the property belonging to him is
up for auction too. That means the earth, the islands, the sea, and all
that is in them. What will the buyer pay, and what will the vendor
accept, considering how much property is entailed in the
deal?#footnote[#emph[Eccl,] 74--75.]
]

Indeed, for Gregory, not even God Most High can enslave humanity in such
inhumane fashion, as God's gifts “are irrevocable,” and therefore, “God
would not therefore reduce the human race to slavery, since . . . when
we had been enslaved to sin, \[it was divine love that\] spontaneously
recalled us to freedom.”#footnote[#emph[Eccl,] 74. Moreover: “But if God
does not enslave what is free, who is he that sets his own power above
God's?” #emph[Eccl,] 74.] And this is key to Gregory's re-imagining of
“subjection,” witnessed most lucidly in a sermon on 1 Cor. 15:28, where
St. Paul expresses that all things will be made subject to Christ, who
is subject to God, the one who is “all in all.” Gregory schematizes
“subjection” here as Christo-eschatological: to be subject to Christ is
the “complete alienation from evil,” where, to be precise, the enemy
#emph[death] is blotted out, and each person rests “in a kingdom,
\[with\] incorruptibility and blessedness living in”
all.#footnote[Gregory of Nyssa, #emph[In Illud]: #emph[Tunc et Ipse
Filius], trans. Brother Casimir, O.C.S.O., #emph[Greek Orthodox
Theological Review] 28#emph[~]\(1983): 19, 25, respectively. Gregory
closes his fifteenth homily on #emph[Song of Songs] similarly, “For it
is the nature common to all . . . to press forward in desire . . . until
that time when, since all have become one in desiring the same goal and
there is no vice left in any, God may become all in all persons, in
those who by their oneness are blended together with one another in the
fellowship of the Good in our Lord Jesus Christ.” #emph[HSS,] 497--499.]
This re-configuration of “subjection” is in plainer terms
#emph[friendship], where the friend and lover of God “looks toward that
divine and infinite Beauty \[and\] glimpses something that is always
being discovered as more novel and more surprising . . . and for that
reason she marvels at that which is always being manifested, but she
never comes to a halt in her desire to see, since what she looks forward
to is in every possible way more splendid and more divine than what she
has seen.”#footnote[#emph[HSS], 339. Cf. #emph[OSR,] 240, here Macrina
relays to her younger brother how the soul's journey is one that is
never sated in the sense that one never grows tired of receiving more:
“knowledge becomes love because what is known is, by nature, beautiful.
Wanton satiety does not touch the truly beautiful. And, since the habit
of loving the beautiful is never broken by satiety, the divine life,
which is beautiful by nature and has from its nature a love for the
beautiful, will always be activated by love.”] This dazzling, dizzying
vision of the human person ever-open to ever-new growth, change, and
capaciousness, “enlarging” the self in proximity to divine love, beauty,
and bliss is, again, normative for Gregory in the present. A baseline
perception of the world in this manner---as Gregory stalwartly teaches
throughout his sermons, letters, and treatises---helps to secure
productive pathways of freedom for all persons in the here and now so
that each person, like the Bride from Song of Songs, “never bring\[s\]
her desire for the object of her vision to a halt at what has already
been apprehended.”#footnote[#emph[HSS,] 339.]

#heading(level: 3)[Sergii Bulgakov]

As a “creaturely god” and “a cryptogram of Divinity,” humanity possesses
“a divine, uncreated origin from ‘God's breath,'” which gifts it a
“spark of divinity,” a share in possessing a kind of “uncreatedness,”
and effectively makes “man . . . an uncreated-created, divine-cosmic
being.”#footnote[Sergii Bulgakov, #emph[The Lamb of God], trans. Boris
Jakim (Grand Rapids, MI: Eerdmans, 2008), 112, 116, 186, 143, 140,
respectively. (Henceforth #emph[LG]).] So writes Bulgakov in his
momentous work of Christology, #emph[The Lamb of God] (1933). With such
an elevated anthropology, it is perhaps not shocking that after the
appearance of the work, Bulgakov was twice-charged with teaching
elements “foreign” to the Orthodox faith during what became known as the
“Sophia Affair,” a young Vladimir Lossky demanding alacritous
“anathemas” be formally composed against Bulgakov.#footnote[Antoine
Arjakovsky, #emph[The Way: Religious Thinkers of the Russian Emigration
in Paris and Their Journal, 1925--1940,] trans. Jerry Ryan (Notre Dame:
University of Notre Dame Press, 2013)#emph[,] 387. In January of 1936,
Lossky published #emph[Спор и Софии,] see Arjakovsky, #emph[The Way,]
386--388. For more background, see too Arjakovsky's formative discussion
in #emph[Essai sur la Père Serge Boulgakov (1871--1944): Philosophe et
théologien chrétien] (Parole et Silence: 2006), 106--120. For a very
fine work in English on the “Sophia Affair,” see Roberto De La Noval,
“Sophiology in Suspension: The Theological Condemnations of Fr. Sergius
Bulgakov” (PhD dissertation, University of Notre Dame, 2020), esp.
28--42, 276--363. For some primary documentation of the formal
proceedings, see “The Charges of Heresy against Sergius Bulgakov: The
Majority and Minority Reports of Evlogii's Commission and the Final
Report of the Bishops' Conference” in #emph[St. Vladimir's Theological
Quarterly] 49, no. 1--2 (2005): 47--66.] In response, Bulgakov insists
that his “starting point” is simply taking seriously, and subsequently
teasing out with indefatigable rigor, the “axiom of man being God's
image and likeness.”#footnote[Sergii Bulgakov, “Докладная записка Его
Высокопреосвященству Митрополиту Евлогию профессора прот. Сергия
Булгакова,” #emph[Путь] 50 (1936): 17. On #emph[image and likeness] in
Bulgakov#emph[,] see Zwahlen, #emph[Das revolutionäre Ebenbild Gottes],
293--295.] In short, to be human is to be a “living image of the
trihypostatic God in His Wisdom.”#footnote[#emph[LG,] 140.] And
constitutive to understanding the image (and likeness) is #emph[love,]
which is not meant to be a simple characteristic or quality or static
factoid for categorizing the human, but #emph[capacious], as love is
properly #emph[expansive].#footnote[In a long essay contribution to an
ecumenical volume on revelation in the Christian tradition, Bulgakov
provides some parameters for how he thinks the image of God in humanity
should be approached. He critiques any reduction of the image to a
singular aspect such as rationality or intellect or spirit, #emph[et
al.,] considering this stratagem an exercise in futility; instead, he
holds that the image “belongs to \[humanity\] as a whole, . . . \[since
humanity\] is a creaturely god both in the spirit and in the body, in
their mutual relatedness, and also in his personal being as well as in
his nature.” Sergii Bulgakov, “Revelation,” in #emph[Revelation,] ed.
John Baillie and Hugh Martin, trans. Oliver F. Clarke and Xenia
Braikevitch (London: Faber and Faber Limited, 1937), 131. Cf. #emph[LG,]
140--141 for much of the same qualification.]

In moving from the conceptual portrait of Gregory to Bulgakov and the
latter's #emph[theological] resourcing for building a religious
humanism, we immediately see a thematic similarity to Gregory's
positioning of life, love, freedom, and the pursuit of the
beautiful.#footnote[Bulgakov's personalist thought is well-trodden
territory in the scholarly literature. For but a smidgen of sourcing as
regards his #emph[theological] developments vis-à-vis his specific
personalism, see first the classic study by Lev Zander, #emph[Бог и Мир]
(#emph[Миросозерцание отца Сергия Булгакова]), 2 vol. (Paris:
YMCA-Press, 1948), especially 2: 315--375. For more recent accounts, see
Zwahlen, #emph[Das revolutionäre Ebenbild Gottes,] esp. ch. 6;
#emph[idem.,] “Different Concepts of Personality”; #emph[idem.,] “Sergey
N. Bulgakov's Concept of Human Dignity,” in~#emph[Orthodox Christianity
and Human Rights], eds.~Alfons Brüning~and~Evert van der Zweerde
(Leuven: Peeters, 2012), 169--186; David Bentley Hart, “Masks,
Chimaeras, and Portmanteaux: Sergii Bulgakov and the Metaphysics of the
Person,” in #emph[Building the House of Wisdom. Sergii Bulgakov and
Contemporary Theology: New Approaches and Interpretations], eds. Barbara
Hallensleben, Regula M. Zwahlen, Aristotle Papanikolaou and Pantelis
Kalaitzidis (Münster: Aschendorff Verlag, 2024), 43--62; Michael
Aksionov Meerson, “Sergei Bulgakov's Philosophy of Personality,” in
#emph[Russian Religious Thought,] eds. Judith Deutsch Kornblatt and
Richard F. Gustafson (Madison: The University of Wisconsin Press, 1996),
139--153; #emph[idem., The Trinity of Love in Modern Russian Theology:
The Love Paradigm and the Retrieval of Western Medieval Love Mysticism
in Modern Russian Trinitarian Thought (from Solovyov to Bulgakov)]
(Quincy, IL: Franciscan Press, 1998), esp. 159--186; Joshua Heath,
“Sergii Bulgakov's Linguistic Trinity,” #emph[Modern Theology] 37.4
(October 2021): 888--912.] Surely classifiable as a #emph[theologian]
#emph[of] #emph[love,] Bulgakov#emph[,] in a 1910 essay on Vladimir
Solovyov, famously revised the well-known Cartesian maxim #emph[cogito,
ergo sum] to, “One can accept the metaphysical formula: #emph[I love,
therefore I am], because in love is the loftiest manifestation of
life.”#footnote[“Можно принять метафизическую формулу: #emph[amo, ergo
sum,] ибо в любви -- высшее проявление жизни.” Sergii Bulgakov, “Природа
в философии Вл. Соловьева,” in #emph[Сочинения в Двух Томах], ed. S.S.
Khoruzhii (Moscow: Nauka, 1993), 1: 25--26.] In a nutshell, God gifts
out of an “ecstatic act of creative, self-renouncing love” to humanity a
created-divine spiritual nature, replete with intellect (holistically
conceived) and intentionality in order to pursue the ultimate end of
life, namely, ascendency into that ever-unfolding beauty and bliss that
is infinite desire, to wit, God.#footnote[#emph[BL,] 115.] Recalling
Gregory's #emph[epektic] logic above, all human persons, each of which
bears the image and is called to the likeness of God, are “beings
created by love, in love, and for love,” since love “constitutes the
inner law of their being.”#footnote[#emph[BL], 157.] An ecology of care
in this Bulgakovian key perceives love, life, and freedom as interwoven,
and these features are founded, as all things are in Bulgakov's
so-called “later” works, on the Triune Person, who “does not love
illusory abstractness and deadness, \[but\] all that is concrete . . .
\[having\] the power of #emph[life].”#footnote[Sergii Bulgakov,
“Hypostasis and Hypostaticity: Scholia to the Unfading Light,”~trans.
Brandan Gallaher and Irina Kukota, #emph[St. Vladimir's Theological
Quarterly]~49, no. 1--2 (2005): 27, emphasis mine. (Henceforth “HH”).]

Even before his explicit theological shift, Bulgakov consistently
critiques systems that excessively abstract from the concrete individual
person---her singular life, personality, creativity, sufferings, etc.
Encountering the storm of anthropologies that were present in
#emph[fin-de-siècle] Russian (and broader European) thought, Bulgakov's
early conceptualizations regarding the priority of the human person as
an individual possessing absolute dignity and irreplaceability are in
large part what led him to his break with the “legal Marxism” to which
he apprenticed himself in his twenties. Critiquing Marxism as a kind of
alternative religious tradition in his 1906/1907 essay “Karl Marx as a
Religious Type,” Bulgakov reads Marx(ism) as formulating human persons
as “algebraic signs”; he argues that there is a general “lack of
attention to the concrete, living human person,” which inevitably leads
to a disregard for “the problem of individuality.”#footnote[“KM,” 2:244.
Bulgakov had begun to critique Marxism before 1906---in fact, he had
begun in the late 1890s, partly due to his empirical research abroad as
well as his conviction that the kind of Marxism carried out in, for
example, Germany would not ultimately take root in a Russian context.
Cf. the various articles and reviews collected in Sergii Bulgakov,
#emph[От марксизма к идеализму:] #emph[Статьи и рецензии 1895--1903,]
ed. Vadim Sapov (Moscow: AST, 2006). See too Catherine Evtuhov,
#emph[The Cross & the Sickle: Sergei Bulgakov and the Fate of Russian
Religious Philosophy] (Ithaca: Cornell University Press, 1996), 28--65.
For more on Bulgakov's critique of the “religious Marx,” see J.
R.~Seiling, “From Antinomy to Sophiology: Modern Russian Religious
Consciousness and Sergei Bulgakov's Critical Appropriation of German
Idealism” (PhD dissertation, University of Toronto, 2008), 205--208.]
Ultimately, Bulgakov maintains that with Marxism, at least as regards
the Marxism with which he was acquainted, “the absolutely indivisible
core of human personality, its integral nature, does not
exist.”#footnote[“KM,” 2:244. Bulgakov had already critiqued Marxism on
these very grounds in his contribution to the watershed 1902 volume
#emph[Problems of Idealism]: “Marxism takes the formula of the free
development of the person without, of course, any metaphysical content.
Here the person is not a bearer of absolute tasks, endowed with a
definite moral nature and capabilities, but entirely a product of
historical development, changing with this development. The concept of
the person, strictly speaking, is completely missing here, reduced only
to the purely formal unity of the self. But in such a case, what can the
formula ‘free development of the person' mean? Once more, positive
science knocks at the door of metaphysics.” Sergii Bulgakov, “Basic
Problems of the Theory of Progress,” in #emph[Problems of Idealism:]
#emph[Essays in Russian Social Philosophy], ed., trans. and
intro.~Randall A. Poole (New Haven, CT: Yale University Press, 2003),
\105. (Henceforth “BP.”) Bulgakov would hold to his critique of
Marx(ism) even into the 1930s, cf. Sergii Bulgakov, “The Soul of
Socialism,” in #emph[Sergii Bulgakov: Towards a Russian Political
Theology], trans. & ed. Rowan Williams (Edinburgh: T&T Clark, 1999),
244--245. (Henceforth “SS”).]

Turning towards the face of the person, Bulgakov conceives the “problem”
of the individual as shaped by “religious consciousness,” having most
distinctly to do with humanity's correlation to God, the intuition of
being charted along a transcendent-immanent continuum, not reducible to
any naturalist, physicalist system of thought. Bulgakov later reasons,
“The element of freedom and personhood, i.e., creativity, is irremovable
from religious faith: I come forward here not as an abstract, neutral,
impersonal, ‘normally' organized representative of a genus but as a
concrete, unrepeatable, individual person.”#footnote[Sergii Bulgakov,
#emph[Unfading Light: Contemplations and Speculations,] trans. Thomas
Allan Smith (Grand Rapids, MI: Eerdmans, 2012), 35. (Henceforth
#emph[UL]).] But even a decade earlier, when composing “Karl Marx as a
Religious Type,” Bulgakov is already intimating towards the person's
“living spirit” as possessing a divine-creaturely origin and telos, and
to perceive that which is “real and everlasting”#footnote[“KM,” 2:246.]
in this living, incarnated spirit is not to reduce her to a privatized
subject within an abstract collective. Though he will need close to the
next forty years to further expand these thoughts, Bulgakov recognizes
that what is at stake is the “irreplaceable, absolutely unique person
who only once for a moment flashes in history,” summoning his readers to
see how this #emph[person] “lays claim to eternity, to absoluteness, to
enduring significance.”#footnote[“KM,” 2:246. Indebted greatly to
Vladimir Solovyov, many Russian religious-philosophical thinkers of this
era regarded the human person with such a sense of primacy. For some of
the historical background, see Randall Poole's excellent, “Editor's
Introduction: Philosophy and Politics in the Russian Liberation
Movement,” in #emph[Problems of Idealism:] #emph[Essays in Russian
Social Philosophy], 1--78. Cf. too the classic study by V. V. Zenkovsky,
#emph[A History of Russian Philosophy], trans. George Kline (New York:
Columbia University Press, 1953), esp. 2: 469--531, 706--916. Bulgakov
named Solovyov a great modern Russian “poet-philosopher”: Bulgakov, “Без
плана. Несколько замечаний по поводу статьи Г. И. Чулкова о поэзии Вл.
Соловьева,” in #emph[Тихие Думы], 216--233. Though he later cools in his
affections, he regarded “Solovyov as having been my philosophical ‘guide
to Christ' at the time of a change in my own world outlook.” See
Bulgakov, #emph[Sophia: The Wisdom of God: An Outline of Sophiology,]
trans. Patrick Thompson, O. Fielding Clarke, and Xenia Braikevitc
(Hudson, NY: Lindisfarne Press, 1993), 10. (Henceforth #emph[S.])]

This impulse, in fact, is bedrock for Bulgakov throughout his entire
career. As witnessed in one of his last pieces, a manuscript from
1941-1942 titled “Racism and Christianity,” Bulgakov argues, “Neither
the race nor the nation nor any biological collectivity constitutes an
original reality . . . as is the case of the person. This truth,
insupportable for racism, is . . . the foundation of the human being.
Humanity is composed not of races but of persons who find their common
source, as individuals, in the unique total person, in the new Adam, in
Christ.”#footnote[Translation from Arjakovsky, #emph[The Way,] 436--437.
See also Williams, #emph[Sergii Bulgakov,] 293--303, for a critique of
Bulgakov's “Расизм и христианство,” specifically with regards to
Judaism. In short, Williams argues that Bulgakov holds “a nuanced but
faintly disturbing position,” 295. Cf. too Dominic Rubin, “Judaism and
Russian Religious Thought,” in #emph[The Oxford Handbook of Russian
Religious Thought,] eds. Caryl Emerson, George Pattison, and Randall A.
Poole (Oxford: Oxford University Press, 2020), 349--352.] While Bulgakov
holds no truck with the underlying metaphysics of Marxism that seemingly
despoils the concrete person by abstracting society into a quadratic
equation,#footnote[It should be noted that while Bulgakov heavily
critiques Marxism, he does not dispute that the material, political, and
economic features of life are integral to any philosophico-theological
personalism: e.g., we may note that Bulgakov holds to the “the
completely irrefutable fact that the growth and moral development of
personhood are to a certain degree inextricably connected with material
progress” (“BP,” 102). And later in the same essay, “Pitiful is the
person who in our time is incapable of seeing the radiance of the
absolute moral ideal in the hearts of people devoting themselves to
helping the proletariat in its struggle for human dignity, in the hearts
of people capable of living and dying for the cause of freedom, and
pitiful is the person who will not see this radiance in the dull and
prosaic paragraphs of factory legislation or in the charter of a labor
union, and so forth. . . . Therefore, the emancipation of the peasants,
the introduction of land captains, the limitation of zemstvo revenues,
the municipal reform, and the censorship and university statutes are all
subject to moral evaluation. Everything is either good or evil” (“BP,”
113).] he despises and utterly denounces the “spiritual idolatry” of
state absolutism under the diverse machinations of “Fascism,” “racism,”
“#emph[Führerism],” and “Bolshevism,” which in various ways follow paths
marked by #emph[libido dominandi,] ultimately enslaving “the person to
the state.” It is telling that he associates these abominations with the
false prophets and beasts of St. John's apocalypse.#footnote[Sergii
Bulgakov, #emph[The Apocalypse of John: An Essay in Dogmatic
Interpretation,] trans. Mike Whitton (Münster: Aschendorff Verlag,
2019), 94--96, 104--106, and elsewhere. To be clear, while he explicitly
names Hitler, Lenin, and Stalin in these pages, Bulgakov does not
include Marx, whom he decried but for whom Bulgakov also possessed an
intellectual respect. In the early 1930s, he writes, “In Marx, the
spirit of anti-Christian enmity to God finds a voice of exceptional
power; but this spirit is nonetheless bound up with an authentic social
pathos and an authentic orientation to the future. There is something in
Marx of that outpouring of the Spirit that we find in Israel's prophets,
for all the atheistic trappings, the outpouring of the Spirit that
conquers the heart” (“SS,” 244).]

Clearly, therefore, immense import is afforded human dignity on
theological grounds, as Bulgakov makes explicit in the conclusion of his
#emph[Tragedy of Philosophy]: “God says #emph[you] to human beings, that
He by His Word acknowledges, and, consequently, creates the human
being's personhood, and the fact that He gives to the human being, to a
created being, the power to approach God as #emph[You],” and thereby God
accepts the creature into the “Divine #emph[We].”#footnote[#emph[TP,]
154, emphasis in original, translation modified. Cf. Sergii Bulgakov,
#emph[Tрагедия философии], in #emph[Сочинения в Двух Томах], ed. S. S.
Khoruzhii (Moscow: Наука, 1993), 1:444.] Bulgakov never ceases in his
enthusiasms concerning this theological point, that the trihypostatic
Person “light\[s\] from His \[own\] Light innumerable myriads of
spiritual suns or stars, that is, hypostases.”#footnote[#emph[TP,] 153.]
It “exceeds all thought,” he rhapsodizes, the “ineffability” of such an
act of “Divine love and kindness,” specifically in regards to the
donation of divine breath to the whole humanity at its mysterious
origin, “which appears in the creation of new hypostases, created
gods.”#footnote[#emph[TP,] 154.]

In conceptualizing God's kenotic, and therefore truly transcendent,
communication of #emph[you] to all persons, Bulgakov is not, as has been
pointed out by others, utilizing the #emph[image] and #emph[likeness]
merely to point out an egalitarianism among all persons (though equal
dignity among all persons is obviously present, as amply evidenced by
the preceding). Instead, he is alluding to the dynamic ontological
structure of spiritual persons who possess a selfhood within a nature
defined by sobornost---a unified, Whole Anthropos who images as well as
finds its telos in the Divine Life that is ultimately revealed “as a
sobornal Person” (какъ соборную Личность),#footnote[Sergii Bulgakov,
“Главы о Троичности,” #emph[Православная мысль] 1 (1928): 40. On the
relation of the individual person and the conciliar whole, Eric Perl's
note concerning Dionysius the Areopagite---Bulgakov knowing well the
#emph[Corpus Areopagiticum] (cf. #emph[UL,] 125--128, 166, 270--271;
#emph[TP,] 140; #emph[LG,] 72--75, 125; and elsewhere)---is instructive:
“In Dionysius' metaphysics, then, there is no such thing as an
individual, a being conceived as a closed, self-contained unit which
extrinsically enters into relations with other beings. Because the
principle of reality is pure Openness or Giving, the very identity, the
being of each thing, God-in-it, is its giving to and receiving from
others. Each thing, indeed, is nothing but its relations to others” due
to the “ΠΕΡΙΧΏΡΗΣΗΣ,” whereby “the Great Dance in which all beings are
only in and through each other.” See Eric Perl, #emph[Theophany: The
Neoplatonic Philosophy of Dionysius the Areopagite] (New York: SUNY
Press, 2008)#emph[,] 80. Bulgakov certainly makes room for the
individual person but eschews any form of “individualism” as
“self-isolating, nonuniversal being,” and, in so doing, Bulgakov
attempts to aid #emph[individuals] in their dying as a seed in order to
more fully realize their #emph[person]hood, participating sobornally in
“the ongoing sophianization of creation” (#emph[BL,] 149).] incarnating
lives marked by self-determination in actions of freedom and
creativity.#footnote[As Zwahlen argues, “Bulgakov behandelt den Begriff
‘Ebenbild Gottes' konsequent nicht als eine Wesensgleichheit, sondern
als Analogie der geistigen, personalen und dynamischen Struktur von Gott
und Mensch: Diese Struktur besteht in einem Akt der Selbstbestimmung des
Ich in seiner Natur” (#emph[Das revolutionäre Ebenbild Gottes,] 293).]
Bulgakov argues that the self-determination inherent to the likening
task makes the undertaking “royal, Godlike,” as it is “the path of
freedom.”#footnote[#emph[LG,] 147.] #emph[And], the task of realizing
the likeness is the “path of work,” an “arduous path” for humanity that
requires great enthusiasms and labors as well as even greater feats of
love in overcoming the temptations that saturate such a mercurial state
of “creatureliness,” which “in its untested and un-overcome state is
ontologically unstable,” bearing “within itself a certain risk of
failure, which God's love takes upon itself in its sacrificial
kenosis.”#footnote[#emph[LG,] 147.] The givenness of the image and the
task to actualize the likeness find purchase in the logic of love that
understands the heart of creation as, in the final analysis, purposed
towards theosis.

The Triune Person communes and thus communicates with created persons
through the gate or mode of freedom---which, like Gregory before him, is
#emph[not] merely the capacity to choose,#footnote[“\[F\]reedom is never
the irrational arbitrariness of #emph[sic volo] but is always and
invariably motivated with all the power of persuasiveness for each given
moment” (#emph[BL], 145).] as if God's gift of free self-determination
to created persons reaches its apotheosis in the choice of the sheer
varieties of bread to pick over at the supermarket. Tellingly, Bulgakov
concludes the English-prepared #emph[Sophia: The Wisdom of God] (1937)
with the crucial caveat: “Freedom is only a mode in which life is
participated, not the content of the life itself.”#footnote[#emph[S,]
\148.] Created persons, as creative self-determiners who possess “real,
concrete . . . modal freedom,” are free to undertake and reject
possibilities in the life of the world, free to work towards the
likening task of realizing the image of God and synergistically bending
the world towards its eschatological end or cultivating the lonely image
of Lucifer, making hovels in the #emph[underground] for their
increasingly diminishing souls.#footnote[#emph[BL,] 191. Regarding
humanity's #emph[likeness] to God, Bulgakov usually casts this in terms
of a #emph[task] to be realized, something to which all human persons
are called, not only certain ascetics, zealots, monastics, holy fools,
etc. Furthermore, given the nature of the #emph[likening] task, which in
the present form of the world is not realized, Bulgakov considers this
“perhaps the supreme dignity of the human being,” as he explains in the
following passage: “The whole creation thirsts for ‘deliverance' from
slavery to ‘vanity,' for sophianic illumination, for transfiguration in
beauty, but it speaks of this with a tongue that is mute. And only the
human soul, our own soul---poor, intimidated Psyche---do we know with
final, intimate, certain knowledge. What can be more certain than that
our present I is #emph[not] I at all, for our eternal essence, our
divine genius is quite different from our empirical person, our body,
character psychology! #emph[One can never be reconciled with oneself],
and this irreconcilability is perhaps the supreme dignity of the human
being.” #emph[UL], 248, emphasis original.] Freedom for the creature is
of a different order than God's absolute self-determination and
(supra)freedom, where freedom and necessity are ultimately reducible to
Divine love.#footnote[For some of the contemporary debates concerning
freedom and necessity vis-à-vis God in Bulgakov's thought, see Brandon
Gallaher, #emph[Freedom and Necessity in Modern Trinitarian Theology]
(Oxford: Oxford University Press, 2016), esp. 70--114, and David Bentley
Hart, “Martin and Gallaher on Bulgakov,” in #emph[Theological
Territories: A David Bentley Hart Digest] (Notre Dame: University of
Notre Dame Press, 2020), 55--64.] The creature's freedom is #emph[given]
and thus #emph[relative], meaning it can only be antinomically
understood as God's kenotic gift to creatures as “the capacity for
#emph[creative] self-determination” within the bounds, however grand, of
creation.#footnote[#emph[LG,] 142; cf. #emph[BL,] 192. The antinomy lies
in the following: Freedom for human persons is self-determination or
“spontaneity in the sense of causelessness.” This is “the very essence
of freedom” and it is “a divine gift of the Creator, who communicates to
creatures the image of His creative activity.” Yet, at the same time,
“Creaturely freedom is always actualized within a determinate given; its
entire content and its positive possibilities depend on this given.”
#emph[BL], 145. On the gift of freedom being a loving act of kenosis,
see #emph[BL], 230.]

Thus, conceptualizing a straightforward dualism of freedom as between
creaturely and divine choice is entirely insufficient (as well as
illogical, as truly transcendent Divinity does not #emph[choose] in the
ways creatures as psychological selves do), since, in the end, true
freedom “lets itself be convinced and compelled . . . otherwise it would
remain a motor without a drive.”#footnote[#emph[BL], 145.] Thus, freedom
is not to be witnessed as an exercise of competition between finite and
infinite wills, as if an #emph[I] is most free when it wills against
God. Wholly to the contrary, instead of being a free act, this is a
disfigurement of the freedom gifted to spiritual persons, a sterile
rebellion, a reduction to #emph[drive], which, in turn, inevitably
entails derision for one's neighbor. Since real freedom #emph[lets
itself be compelled], it is still rationally, intentionally, creatively
(and #emph[erotically,] as Gregory would have it) participating by
allowing itself to be compelled in the very act of being convinced.
Thus, Bulgakov, like Gregory long before him, fits snugly in the
classical and ancient tradition of imagining freedom to do with the
sovereignty to enjoy and adhere to one's natural end: the infinitely
attractive Good of all goods.

#heading(level: 3)[Conclusion]

To conclude, we will interweave a couple of sermons that Gregory
delivered during the crisis in the late-360s with a few entries from
Bulgakov's spiritual diary, which he kept while in Prague during the
first few years of forced exile (1923--1925). I conclude with these
because they demonstrate Gregory and Bulgakov's hand-in-hand concern for
“the other,” concretizing even further, and in a more intimate,
interpersonal fashion, the ecology of care---that constellation of life,
love, and the productive pathways of freedom.

The famine of 368 C.E. in and around Cappadocia was historically
severe.#footnote[Susan Holman, #emph[The Hungry are Dying: Beggars and
Bishops in Roman Cappadocia] (Oxford: Oxford University Press, 2001),
64--83.] As witnessed from the letters and homilies of Gregory---as well
as his brother Basil of Caesarea and their friend Gregory of
Nazianzus---how one #emph[saw] the poor, the alien, anyone fleeing
famine and pestilence was of great importance in how he championed
actively aiding them as persons. Recall Gregory's interpretation of the
pleromatic #emph[whole humanity] and the role it plays in the individual
dignity afforded each person; if one person is enslaved, then all are
enslaved, as humanity as such cannot be bifurcated into two abstracted
entities. He beckons hearers to appreciate this logic too in a sermon on
loving the poor during these acutely calamitous times: “Do not tear
apart the unity of the Spirit, . . . do not consider strangers those
beings who partake of our nature; . . . Remember who you are and on whom
you contemplate: a human person like yourself, whose basic nature is no
different from your own. . . . Treat all therefore as one common
reality.”#footnote[Gregory of Nyssa, #emph[De pauperibus amandis II,]
trans. in Susan Holman, #emph[The Hungry are Dying: Beggars and Bishops
in Roman Cappadocia] (Oxford: Oxford University Press, 2001)#emph[,]
199--206 (201). (Henceforth #emph[PA].)] Preached in an era shattered by
record scarcity and starvation, Gregory's point is plain though
formative. One belongs to and possesses a common nature; therefore, to
look upon the poor or sick or homeless as intrinsically different than
oneself is dangerously erroneous---indeed, damnable.#footnote[“If God
sees these scenes---and I am sure He does---what fatal catastrophe, do
you think, does He hold in store for those who hate the poor? Answer
me!” Gregory of Nyssa, #emph[De beneficentia,] trans. in Susan Holman,
#emph[The Hungry are Dying: Beggars and Bishops in Roman Cappadocia],
193--199 (199). (Henceforth #emph[B].) While the rhetoric is harsh, it
is worth remembering that the gospel according to Matthew, especially
the 25#super[th] chapter, is none too dissimilar. Furthermore, this
rhetoric, it is worth emphasizing for those perhaps dreading the
excesses of #emph[old-time religion] and its many #emph[hellfires,] is
not aimed at any abstract “sinner” but those specific persons who hoard
food during a time of famine, especially in the face of other person(s)
actively perishing from hunger in their doorway.] What's more, to
categorize humanity as divided into two abstract entities---masters and
slaves or those with food and those without---is to divide the unified
Human image-bearer into competing entities, a metaphysical absurdity
since the Whole Anthropos is founded upon the Person of all persons, the
divine-human Christ whose Face is the visage of all faces originally
made and finally restored. Gregory would have his audience commit to
ways of actively seeing without evasion, a pledge that Rowan Williams
describes as the “‘staking' of ourselves precisely in recognition of the
non-transparent thereness of others, \[which is\] committed to the risky
business of being there with or for them in their radical
difference.”#footnote[Rowan Williams, #emph[The Edge of Words: God and
the Habits of Language] (London: Bloomsbury Continuum, 2014), 87.] And
by practicing this kind of #emph[staking], by a disciplining of the gaze
ever towards love, one is (and continues to be) indelibly shaped by the
encounter.#footnote[See Natalie Carnes, #emph[Image and Presence: A
Christological Reflection on Iconoclasm and Iconophilia] (Stanford:
Stanford University Press, 2018). Carnes develops a helpful taxonomy
(though it should not be reduced, as Carnes points out, to a strict
binary): “the gaze of love” and “the gaze of contempt.” Carnes argues
that the “contemptuous gaze believes that its object is fully known; it
believes itself to be the master of the object” and to have power over
it. By contrast, the gaze of love “delights in the one it beholds,” and
resists “the will to master the world” (176). For more, see Daniel Adam
Lightsey, “Desirous Seeing: Sol LeWitt, Vision, and Paradox,” in
#emph[Art, Desire, and God: Phenomenological Perspectives,] eds. Kevin
Grove, Christopher Rios, and Taylor Nutter (London: Bloomsbury Academic,
2023), 59--70. While Bulgakov, obviously, does not use Carnes' exact
taxonomy, he does have much to say regarding the “gaze of love” and the
“impure gaze.” For the first, see Sergii Bulgakov, #emph[Spiritual
Diary,] trans. Roberto De La Noval and Mark Roosien (Brooklyn, NY:
Angelico Press, 2022), 157. (Henceforth #emph[SD].) For the second, see
Sergii Bulgakov, #emph[The Comforter,] trans. Boris Jakim (Grand Rapids,
MI: Eerdmans, 2004), 205.] By such growth in an ecology of care, one is
continuously able in loving kindness to open avenues of freedom and life
for others, aiding all in finding “the port of our rest and
desire.”#footnote[#emph[PA], 206.] And these movements of the soul
towards the #emph[beautiful] by acts of “mercy and good deeds,” Gregory
goes so far as to say, work to “divinize those who practice them and
impress them into the likeness of goodness.”#footnote[#emph[B,] 197. A
bit later in the homily, Gregory asks, “Is it not necessary rather to
let out our compassion and love for one another shine forth radiantly in
action?” The proper answer is #emph[of] #emph[course]: “There is a
difference between words and action as great as the difference between a
painting and the reality. The Lord affirms that we will be saved, not by
our words but by our actions” (#emph[PA], 203). Also, near the end,
Gregory invokes the beautiful again: “It is beautiful for the soul to
provide mercy to others” (#emph[PA,] 206).]

Gregory here is working within a context of catastrophe, though (or
perhaps especially in such cases) what he runs to repeatedly is the
immeasurable dignity, irreplaceability, and worth of the person. So too
Bulgakov, who, well before the revolutions of 1917 and his exilic
expulsion five years later, names the human soul as a whole cosmos. And
by truly #emph[seeing] another, not merely looking at, one can help
bring up and out of the depths hidden treasures of the human soul. In a
diary entry from March 3, 1925 (Old Style), Bulgakov writes, “The human
soul is more precious than the world. . . . What a treasury is the
living human soul, what gems may lie hidden in its depths, jewels that a
person \[herself\], as well as those around \[her\], do not suspect,”
although some are able to see this “beauty as God's
creation.”#footnote[#emph[SD], 130.] He goes on in another entry from
June of that year to characterize each human person as possessing “its
own spiritual world,” containing, because it has been given, “unending
depths and riches.”#footnote[#emph[SD], 157.] These profundities can be,
of course, denied or carelessly passed over by oneself or by others in
our many avoidances of love, hardening the boundaries of those
#emph[immense solitudes] so easily fashioned by each human
heart.#footnote[#emph[Avoidances of love] is an allusion to Stanley
Cavell's masterful essay, “The avoidance of love: A reading of
#emph[King Lear,]” in #emph[Must] #emph[We Mean What We Say? A Book of
Essays,] 2#super[nd] ed. (Cambridge: Cambridge University Press, 2002),
246--325.] To be sure, these diverse kinds of avoidances of love are not
always or even mostly vicious but often stem from a lack of attention
due to the feeling of being overburdened with too many cares. As “a
complex of creative potencies,”#footnote[#emph[BL], 331.] persons are a
mixture of being capable, incapable, capacious, fragile, experiencing
many kinds of loneliness (often not by any overt intention), made more
whole though often wounded and damaged by our host of associations,
interrelations, perceptions, habits, each of these and more contributing
to make each person so singular, so incalculably uncategorizable. And
yet, when one commits to ways of seeing without evasion, Bulgakov
continues in his diary, “sometimes \[these depths are\] revealed to the
gaze of love in all their beauty.”#footnote[#emph[SD], 157.] The
practice of truly seeing an-other forms a person's vision with a greater
sense of acknowledgment of love. In the end, this kind of perception
“cannot look upon \[that\] spiritual beauty \[of another person\] with
indifference”---instead, persons “are ignited by love, and in this love
they become assimilated to this beauty, they shine with its brightness .
. . love makes holiness shine forth in souls.”#footnote[#emph[SD], 158.]
Their arguments taken together, Gregory and Bulgakov provide generative
spiritual resources from which an extraordinary religious humanism can
take shape, an ecology of care in which the rudiments of an ontology of
personhood---communion, expression, knowledge---dynamically mirrors
infinite divine life and love.

<end-of-lightsey>
