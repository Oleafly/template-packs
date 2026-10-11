#import "elements.typ": *
#counter(footnote).update(0)
#abstract(
  [The Democratic Christian Vision of Aleksandr Stepanovich Prokhanov
],
  abstract-subtitle: [],
  abstract-author: [J. Eugene Clay],
  [],
)

// This section sets the headers for the article
#set page(
  header-ascent: 40%,
  header: context {
    set text(8pt, font: "IBM Plex Sans", stretch: 75%, weight: 400)
    let first-page = locate(<first-page-article-clay>).page()
    if here().page() == first-page [
      #grid(
        columns: (45%, 45%),
        gutter: 10%,
        align(left)[NORTHWESTERN UNIVERSITY STUDIES IN RUSSIAN\ PHILOSOPHY, LITERATURE, AND RELIGIOUS THOUGHT
        ],
        align(right)[
          Volume 2 (2025): #first-page#sym.dash.en#locate(<end-of-article-clay>).page() \
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
  #upper([_The Democratic Christian Vision of Aleksandr Stepanovich Prokhanov_])
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

#heading(level: 2)[]
<first-page-article-clay>
#v(1em)
#subtitle([An Outline for Future Research])

#v(1em)
#author[J. Eugene Clay]

#heading(level: 3)[Introduction]
<introduction>
Over the past twenty years, scholars including Samuel Moyn, John Witte,
Jr., and Michael Gillespie have argued for the significance of religion
in the development of human rights discourse, taking issue with the
dominant historiography that ignores or discounts
religion.#footnote[Michael Allen Gillespie, #emph[The Theological
Origins of Modernity] (University of Chicago Press, 2008); Samuel Moyn,
#emph[Christian Human Rights] (University of Pennsylvania Press, 2015);
John Witte, #emph[The Reformation of Rights: Law, Religion, and Human
Rights in Early Modern Calvinism] (Cambridge University Press, 2007).]
In Russia, too, religious minorities have played an outsized role in the
struggle to secure human rights, especially freedom of conscience. At
the beginning of the twentieth century, a prime example of a leader in
this struggle was the physician and publicist Aleksandr Stepanovich
Prokhanov (1871--1912). Born into a family of Spiritual Christian
Molokans---dissenters who rejected the icons, sacraments, and hierarchy
of the established Russian Orthodox Church in favor of a biblical faith
that sought to worship God “in spirit and in truth”---Prokhanov
deliberately embraced the religion of his ancestors, even as his father
and brothers abandoned it for Western Protestantism.#footnote[According
to an official census taken in 1912 by the Department of Spiritual
Affairs of the Ministry of the Interior, the number of Molokans who
observed Sunday as their day of worship numbered 133,935. In addition,
there were 4,423 Molokan Sabbatarians and 4,844 Spiritual Christian
Jumpers \[#emph[pryguny]\], so called because they jumped in their
worship gatherings at the inspiration of the Holy Spirit. See
#emph[Statisticheskie svedeniia o sektantakh (k 1 ianvaria 1912 g.)],
Izdanie Departamenta dukhovnykh del (St. Petersburg: Tipografiia, 1914),
33--35, 47, 51. Molokans themselves considered these figures to be a
gross undercount; for example, V. I. Savchenko, a Spiritual Christian of
Vladikavkaz, claimed that the true official figures showed that there
were 930,000 of his co-religionists in Russia as of 1 January 1910. See
V. I. Savchenkov, “Svedeniia o chisle sektantov v Rossii,”
#emph[Dukhovnyi khristianin] 6, no. 1 (January 1911): 52.] However,
Prokhanov's version of Spiritual Christianity was not simply a mindless
adoption of family tradition. Instead, he offered a utopian vision: a
rationalized, ecumenical Christianity of the Russian people, without a
Synod or episcopal authority, that practiced an “internal freedom of
conscience” and was united not by a creed but by love expressed in good
works.#footnote[Aleksandr Stepanovich Prokhanov, “Stoletnii molokanskii
iubilei,” #emph[Dukhovnyi khristianin] 1, no. 2 (January 1906): 20]
Consciously rejecting Western Protestantism, with its proclamation of
salvation through grace alone by faith alone, Prokhanov created the
journal #emph[The Spiritual Christian] (#emph[Dukhovnyi]
#emph[khristianin]) in 1905---the revolutionary year when the czar
issued a decree on religious toleration---to be an arena for open
debate, where a truly popular (#emph[narodnyi]) Christianity could
emerge.

To achieve this result, Prokhanov adopted a radically democratic
approach to the development of doctrine and practice. Is God a trinity
of three persons? Is Christ fully human and fully God? Should Christians
pray for the dead? Is the Old Testament still relevant for followers of
Jesus? Would Christ's Second Coming be an observable physical event or
an invisible spiritual reality? To answer these and similar dogmatic
questions, Russian Orthodox Christians relied on the authority of their
creeds and ecumenical councils while Baptists turned to their infallible
scriptures. By contrast, Prokhanov encouraged believers to decide for
themselves which teachings and rituals were true and right. Rather than
impose his own theological views on others (as did the state-supported
Orthodox Church with its edicts of excommunication, monastery prisons,
and network of missionaries who worked closely with local police to
identify and prosecute heretics), Prokhanov sought to discover and
publicize what Spiritual Christians actually believed and practiced.
When they disagreed, as they often did, Prokhanov invited reasoned
debate and dialogue. In Prokhanov's democratic vision of Christianity,
rules of faith and practice were not to be dictated and enforced from
above, but rather to bubble up from below. No doctrine, no ritual was as
important as love, which could unite into a single community even those
with radically different understandings of faith. Such a Christianity,
which placed love above dogma, would create a free society “of the sons
of liberty who worship God in spirit and
truth.”#footnote[#emph[Dukhovnyi khristianin] 7, no. 1 (January 1912):
\1.] Firmly committed to a progressive theology, Prokhanov believed that
the orthodoxies and orthopraxies of today would inevitably change as
humanity advanced toward truth. In Prokhanov's assembly of saints, there
were no dogmas, no heretics, no excommunications: the Chalcedonian
Christian who held that Christ was fully God and fully human lived in
loving fellowship with the docetic Molokan elder who taught that Jesus
had the body of an angel. To achieve such unity, free believers did not
need the external force of pope, priest, creed, or sacred scripture.
They needed only the Christian virtue of love.

Beyond his attempts to unify and reform the fractured Molokan community
to which he was heir, Prokhanov also lobbied for religious freedom,
petitioned state officials for the right to publish, organized Spiritual
Christian congresses, and helped congregations navigate the complex
process of registration so that they could enjoy the benefits of
juridical personhood. He provided tools, drawn partly from his
theological education at the Protestant Faculty of the University of
Paris, to help Molokan elders compose sermons and cultivate the faith of
their children and youth.

In his religious project, Prokhanov also engaged prominent members of
the secular intelligentsia. He was a passionate participant in sessions
of the Ethnographic Section of the Imperial Russian Geographical Society
that focused on the so-called “sectarians,” a disparaging epithet that
included Spiritual Christianity. At such sessions, he exchanged his
views with the writer and diarist Mikhail Mikhailovich Prishvin
(1873--1954), the avant-garde novelist Dmitrii Sergeevich Merezhkovskii
(1865--1941), the Bolshevik revolutionary Vladimir Dmitrievich
Bonch-Bruevich (1873--1955), and the Populist journalist Aleksandr
Stepanovich Prugavin (1850--1920), who authored several books on popular
religion. He also participated in the Religious-Philosophical Society
that met in the home of Merezhkovskii and his wife, Zinaida Nikolaevna
Gippius (1869--1945).#footnote[“Zhurnal zasedaniia Otdeleniia etnografii
I.R.G.O. 13 fevralia 1909 g.,” #emph[Izvestiia Vsesoiuznogo
geograficheskogo obshchestva] (1909): 33--34; Mikhail Mikhaĭlovich
Prishvin, #emph[Sobranie sochinenii v vosʹmi tomakh] (Moscow: Khudozh.
lit-ra, 1986), vol. 8: 34.] Seeking to expand the discussion about true
religion, Prokhanov invited non-Molokans, including vegetarians,
followers of Leo Tolstoy (1828--1910), and former revolutionaries to
publish articles in his journal.

To be sure, Prokhanov's expansive understanding of Spiritual
Christianity was not widely shared even among his fellow Molokans, many
of whom held tightly to their own traditions, doctrines, and rituals. In
fact, his critical approach to the biblical text provoked strongly
negative reactions from some of his co-religionists. As his friend and
collaborator David Vasil'evich Zaitsev noted upon Prokhanov's death,
“Only a small group of conscientious Molokan youth and some of the
Tolstoyan intelligentsia supported him.”#footnote[D. Zaitsev, “Nad
bezvremennoi mogiloi (Pamiati A. S. Prokhanova),” #emph[Dukhovnyi
khristianin] 7, no. 6/7 (June/July 1912): 8.] Nevertheless, by creating
the most successful of all the Molokan journals, Prokhanov created an
important legacy for the generations of Spiritual Christians who lived
under atheistic Communism; in the 1960s and 1970s, Soviet ethnographers
investigating contemporary Molokans found handwritten copies of articles
from Prokhanov's journal, #emph[Dukhovnyi khristianin].#footnote[A. I.
Klibanov, #emph[Iz mira religioznogo sektantstva: Vstrechi, besedy,
nabliudeniia] (Moscow: Politizdat, 1974), 221--22.]

On April 2, 1912, Prokhanov's tragic death at the age of 41 from typhus,
contracted from a patient he was treating in St. Michael's Hospital in
Tiflis, put an end to his personal participation in the Molokan revival.
His two-year-old son Andrei (1910--1943), who would later perish at the
Battle of Stalingrad, was left an orphan. Deprived of the opportunity to
raise his son, Prokhanov could not transmit his religious values to his
descendants. Likewise, the Stalinist antireligious campaigns of the
1930s undid much of his work as a champion of religious freedom.
Ironically, today Prokhanov is remembered primarily not for his
religious views or for his struggle for freedom of conscience, but as
the grandfather of the ultranationalist, antisemitic Russian Orthodox
journalist and novelist Aleksandr Andreevich Prokhanov (b. 1938), a
founder of the reactionary newspaper #emph[Zavtra].#footnote[Lev
Danilkin, #emph[Chelovek s iaitsom: Zhiznʹ i mneniia Aleksandra
Prokhanova] (Moscow: Ad Marginem, 2007); Juliette Faure, “A Russian
Version of Reactionary Modernism: Aleksandr Prokhanov's
‘Spiritualization of Technology,'” #emph[Journal of Political
Ideologies] 26, no. 3 (2021): 356--79; Juliette Faure, #emph[The Rise of
the Russian Hawks: Ideology and Politics from the Late Soviet Union to
Putin's Russia] (New York: Cambridge University Press, 2025).]
Nevertheless, the elder Prokhanov's legacy survives in his journal,
#emph[Dukhovnyi khristianin], whose issues have been carefully
collected, digitized, and made available on the internet by contemporary
Molokans.#footnote[For example, Sergei Petrov, “Dukhovnye khristiane
molokane: Gazety, zhurnaly,”
#link("https://molokanin.ru/gztjur/?n=n5_7")\; “Dukhovnye
khristiane-molokane: Materialy k istorii,”
#link("http://molokans.ru/bibliography/periodicals")]

#heading(level: 3)[Molokanism: Aleksandr Prokhanov's Spiritual Heritage]

Prokhanov's heritage of religious dissent stretched back to the 1760s
when hundreds of people in southern Russia's black-earth provinces of
Tambov and Voronezh openly rejected the fasts, hierarchies, temples,
priesthood, sacraments, and icons of the Russian Orthodox Church and
instead embraced the worship of God “in spirit and in truth” (John
4:23-24). Relying on their interpretations of the Slavonic Bible, these
rebels, who later became known as Spiritual Christians, declared that
“God dwells in temples that are not made by hand and does not take
pleasure in the works of human hands…. The image of God is the human
soul; one day true worshipers will worship the Father in Spirit and
Truth, for the Lord seeks such worshipers.... God did not ordain
salvation to come from soulless things made by human
hands.”#footnote[Nikolai Gavrilovich Vysotskii, ed., #emph[Materialy iz
istorii dukhoborcheskoi sekty] (Sergiev Posad: Tipografiia I. I.
Ivanova, 1914), 14.] Rather than venerate icons, these believers
venerated one another, for humans were made in God's
image.#footnote[Pavel Grigor'evich Ryndziunskii, “Antitserkovnoe
dvizhenie v Tambovskom krae v 60-kh godakh XVIII veka,” #emph[Voprosy
istorii religii i ateizma] 4 (1954): 174.] Sacraments such as baptism
and communion were internal spiritual experiences rather than physical
rites. The true church was the community of the faithful gathered in the
open air, not specially sanctified buildings. It was a church made up of
people, “not of boards, but of ribs” \[#emph[ne v brevnakh, a v
rebrakh]\].#footnote[Vladimir Ivanovich Dal', “Poslovitsy russkogo
naroda: sbornik poslovits, pogovorok, rechenii, prislovii,
chistogovorok, pribautok, zagadok, poverii i proch.,” #emph[Chteniia v
Imperatorskom obshchestve istorii i drevnostei rossiiskikh pri
Moskovskom universitete] kn. 2, chast' II: Materialy otechestvennye
(1861): 14.] Believing that Christ would soon return, the Spiritual
Christians took the bold step of sending delegations to Empress
Catherine to have their faith recognized and protected from the abuses
of local officials.#footnote[Svetlana Aleksandrovna Inikova, “Tambovskie
dukhobortsy v 60-e gody XVIII veka,” #emph[Vestnik Tambovskogo
universiteta.] Series: #emph[Gumanitarnye nauki] 2, no. 1 (1997):
39--53; Svetlana Aleksandrovna Inikova, “The Tambov Dukhobors in the
1760s,” #emph[Russian Studies in History] 46, no. 3 (2007): 10--39;
Svetlana Georgievna Tambovtseva, “Dukhobortsy XVIII veka kak
tekstual'noe soobshchestvo: Nekotorye istochniki chetyrekh rannikh
dukhoborcheskikh psalmov,” #emph[Russkaia literatura], no. 2 (2019):
25--37.]

Unsurprisingly, this bold appeal to the empress failed. The Spiritual
Christians were disappointed in both their political and their
eschatological expectations. Christ did not return, and in 1769 the
Russian government not only rejected their pleas for toleration but
actively repressed their faith, seizing their children and property and
sending their leaders into military service on the imperial frontiers.
Others were publicly beaten and exiled to hard labor. In the face of
such persecution, Spiritual Christians went underground, forming secret
support networks and coded passwords to maintain their community, even
as they were forcibly separated from one another.#footnote[J. Eugene
Clay, “Russian Spiritual Christianity and the Closing of the Black-Earth
Frontier: The First Heresy Trials of the Dukhobors in the 1760s,”
#emph[Russian History] 40, no. 2 (2013): 221--43; Inikova, “Tambovskie
dukhobortsy”; Inikova, “Tambov Dukhobors”; Elena Borisovna Smilianskaia,
#emph[Volshebniki, bogokhul'niki, eretiki: narodnaia religioznost' i
“dukhovnye prestupleniia” v Rossii XVIII v.] (Moscow: Indrik,
#highlight[date]), 310--13.]

During the next decades, these religious rebels split into two major
movements: the Dukhobors (spirit-wrestlers, named by learned Orthodox
heresiologists after the unrelated fourth-century heresy, the
#emph[pneumatomachi]) and the Spiritual Christian Molokans, so called
because they drank milk (#emph[moloko]) during the Orthodox fasts when
the consumption of dairy products was forbidden.#footnote[Petr Ivanovich
Bogdanovich, #emph[Istoricheskoe izvestie o raskol'nikakh], 2nd ed. (St.
Petersburg: Tip. Geka, 1787), 45. On the #emph[pneumatomachi], see
Michael A. G. Haykin, #emph[The Spirit of God: The Exegesis of 1 and 2
Corinthians in the Pneumatomachian Controversy of the Fourth Century]
(New York: Brill, 1994); Wolf-Dieter Hauschild, #emph[Die
Pneumatomachen: Eine Untersuchung zur Dogmengeschichte des vierten
Jahrhunderts] (Hamburg: Hauschild, 1967).] In contrast to the Dukhobors,
who created a relatively closed community that emphasized their own oral
tradition and the inner illumination of the Holy Spirit, the Molokans
stressed the authority of the Slavonic Bible, which included the
deutero-canonical books. Molokans also proselytized more actively,
spreading their spiritual vision to the sparsely populated steppe
frontiers of Saratov and Astrakhan provinces, where the institutions of
the official church were less developed.#footnote[\[Grigorii
Pokrovskii\], “Istoricheskie svedeniia o molokanskoi sekte,”
#emph[Pravoslavnyi sobesednik] (September 1858): 50, 62; Dmitrii
Igorevich Frolov, “Religioznoe dvizhenie dukhovnykh khristian molokan v
Rossiiskoi imperii v 1905--1917 godakh” (kandidat diss., Moscow State
University, 2024), 36--40.]

Prokhanov's parents and grandparents were Spiritual Christian Molokans
from Atkarskii district in Saratov province, where the energetic popular
preachers Semen Matveev Uklein (1733--1809) of Tambov province and
Akinfii Semenov Popov (fl. 1790s--1800s), a townsman of Dubovskii posad
on the Volga River, helped to spread this biblical, aniconic faith. In
1806, the Molokans of Atkarskii district delivered an explanation of
their faith to the local police chief (#emph[ispravnik]). In thirteen
paragraphs, filled with references to the Slavonic Bible, the Molokans
explained their spiritual understanding of the sacraments. For example,
they observed baptism not by a ritual immersion but by repenting of
their sins, maintaining their faith, hearing the word of God, and
holding to Christ's teachings. Likewise, by obeying the commandments of
God---and not by participating in a ritual meal---the Molokans partook
of the Eucharist. The church was not a sanctified building but an
assembly of people, as the Apostle Paul explained in I Corinthians 6:16,
“You are the church of the living God.”#footnote[Rossiiskii
gosudarstvennyi istoricheskii arkhiv (RGIA), #emph[fond] (f.) 1286
(Departament politsii ispolnitel'noi Ministerstva vnutrennikh del),
#emph[opis'] (op.) 1, 1806 #emph[god] (g.), #emph[delo] (d.) 122,
#emph[list] (l.) 5ob.] They confessed their sins not to a priest, but to
one another and to their elders. They did not observe the schedule of
fasts set by the official church, but instead, in imitation of the
biblical prophets, they fasted individually and voluntarily. They also
prayed for the czar and for the civil authorities “in accordance with
the Apostle's testimony.”#footnote[RGIA, f. 1286, op. 1, 1806 g., d.122,
l. 7.]

Although the Spiritual Christian Molokans received grudging toleration
from the government of Alexander I (r. 1801--1825), his younger brother
and successor Nicholas I (r. 1825--1855) instituted much harsher
policies toward all forms of dissent, both religious and political. In
1830, Nicholas ordered the mass deportation of Dukhobors and Molokans to
the unpacified Caucasian frontier. This policy had three goals: (1) to
establish ethnic Russian colonies in recently conquered territories; (2)
to separate heretics (and their baleful influence) from the Orthodox
population; and (3) to discourage the pacifist tendencies of the
Spiritual Christians by deliberately placing them in a war zone where
they would have to defend themselves. Over the next quarter century,
thousands of Molokans were forcibly removed from their homes in southern
Russia and sent hundreds of miles away to present-day Georgia, Armenia,
and Ossetia. These transplanted Spiritual Christians founded new Molokan
villages such as Vorontsovka (now Tashir) and Nikitino (Fioletovo) in
Armenia and Ivanovka in present-day Azerbaijan.#footnote[Nicholas B.
Breyfogle, #emph[Heretics and Colonizers: Forging Russia's Empire in the
South Caucasus] (Ithaca, NY: Cornell University Press, 2005), 92, 132;
I. Ia. Semenov, #emph[Russkie v istorii Armenii] (Erevan: Lusabats,
2009), 75.]

Some Molokans voluntarily made the trip to the Caucasus. In the 1830s,
prophecies that Christ would return and establish his millennial,
terrestrial kingdom on Mount Ararat encouraged those more
apocalyptically-minded among the Molokans to move to Armenia. Others, in
hope of obtaining greater freedom to practice their faith, decided to
leave the regions where they remained a sometimes persecuted minority
and join their co-religionists in the Caucasus. With this hope, in 1862
Aleksandr Prokhanov's grandmother and his parents, Stepan and Agrafena,
moved their families from Saratov Province to Vladikavkaz, a growing
settlement that had just achieved official status as a town
\[#emph[gorod]\] and would soon become the administrative center of the
Terek Region (Terskaia #emph[oblast']).#footnote[Ivan Stepanovich
Prokhanov, #emph[In the Cauldron of Russia, 1869]--#emph[1933] (New
York: All-Russian Evangelical Christian Union, 1933), 29.]

In their new home, the Prokhanovs flourished. They owned and operated
several large mills, and, in Russia's highly stratified society, earned
enough money to join the second guild of the merchant
estate.#footnote[RGIA, fond 776 (Otdelenie kantseliarii Glavnogo
upravleniia po delam pechati), op. 8, d. 2015 (Ob izdanii v gor. SPb
zhurnala “Dukhovnyi khristianin”), l. 9.] Their three sons distinguished
themselves professionally and educationally. The oldest, Ivan
(1869--1935), graduated as an engineer from the Technological Institute
in St. Petersburg and became a leader of the nascent Evangelical
Christian movement; forced into exile by the atheistic Soviet
authorities in 1928, he spent his final years abroad.#footnote[Heather
J. Coleman, #emph[Russian Baptists and Spiritual Revolution,
1905]--#emph[1929] (Bloomington, IN: Indiana University Press, 2005),
218--22; Prokhanov, #emph[In the Cauldron of Russia], 252.] The
youngest, Vasilii (1878--1941), inherited the family business upon the
death of his father in 1910 and suffered expropriation eight years later
under the Soviet government, ultimately emigrating to the United
States.#footnote[Amir Aleksandrovich Khisamutdinov, #emph[O russkikh
amerikantsakh, kotorye sdelali Ameriku bogatoi: Materialy k slovar'iu]
(Vladivostok: Izd-vo VGUES, 2008), 180.] Aleksandr, the second son,
devoted his life to medicine and to reviving and reforming the faith of
his grandparents until his untimely death from typhus in 1912.

#heading(level: 3)[Prokhanov's Spiritual Quest]

Unlike his father and brothers, Aleksandr consciously chose to live as a
Russian Spiritual Christian Molokan, the religion of his ancestors,
rather than as a Baptist or Evangelical Christian, the Western movements
that became increasingly popular and widespread among the peasantry
after the abolition of serfdom in 1861. Although he had migrated from
Saratov to Vladikavkaz to preserve his Molokan faith, Stepan Prokhanov,
Aleksandr's father, converted to Baptism in 1876, won over by the
testimony of a visiting church member from Tiflis. Only five years of
age when his father converted, Aleksandr was raised for most of his
childhood as a Baptist, which was also the religion listed in his
internal passport as late as 1905.#footnote[RGIA, f. 776, op.' 8, d.
2015, l. 4.] He witnessed the spiritual struggles of his older brother,
Ivan, who ultimately decided to commit his life to Christ in November
\1886. On 17 January 1887---the day that Aleksandr turned 16---Ivan
joined the local Vladikavkaz Baptist congregation by immersion baptism
in the Terek River. In the summer of 1890, Aleksandr helped Ivan to
publish an illegal, clandestine Christian journal #emph[Beseda]
(#emph[The Conversation]), which the brothers hectographed and sent by
mail to their evangelical subscribers.#footnote[Prokhanov, #emph[In the
Cauldron of Russia], 48, 67--69, 160.] Despite his participation in this
illegal enterprise, Aleksandr was no extremist. Unlike the most radical
pacifists who rejected all military service, he fulfilled his obligation
as a non-commissioned officer of the Terek Corps of Engineers, shortened
from six years to a few months thanks to the education he received in
the Vladikavkaz Realschule. Honorably discharged in 1890, he began his
medical studies in Dorpat (present-day Tartu).

Political repression in Russia encouraged him to study abroad. In 1894,
the Committee of Ministers declared the nascent Russian Baptist movement
a “most harmful” sect. As a direct result of the new laws, Aleksandr's
father, Stepan, was exiled to Geriusy (present-day Goris, Armenia) in
Elizavetpol' province. To escape the persecution, Aleksandr's older
brother Ivan fled abroad in 1895.#footnote[Prokhanov, #emph[In the
Cauldron of Russia], 89, 115--16, 160--61; Coleman, #emph[Russian
Baptists and Spiritual Revolution], 21--22.] Aleksandr moved to Paris to
continue his medical education; he also attended courses at the liberal
state-supported Protestant Theological Faculty. He then spent a year at
London Hospital Medical College. By 1899, he had returned to Russia to
study medicine at the University of Moscow, graduating in December 1900
as a district physician.#footnote[RGIA, f. 776, op. 8, d. 2015, l. 3;
Werner Benecke, “Die Allgemeine Wehrpflicht in Russland: Zwischen
militärischem Anspruch und zivilen Interessen,” #emph[Journal of Modern
European History] 5, no. 2 (2007): 250--51; Pavel Ivanov, “A. S.
Prokhanov,” #emph[Sovremennoe slovo] (April 6, 1912).]

#heading(level: 3)[The Society of Educated Molokans]

Prokhanov's theological studies in Paris shaped his understanding of
Christianity and his project to revive and reform his ancestral
religion. In 1899, soon after returning to Russia, he tried to create a
Society of Educated Molokans that would reconcile science and faith, a
major preoccupation of his French professors. Later, as the editor and
publisher of #emph[Dukhovnyi khristianin], he proudly highlighted his
status as an auditor of the “Paris Theological Faculty,” a qualification
that puzzled at least one Russian Orthodox reviewer.#footnote[Aleksandr
Stepanovich Prokhanov, ed., #emph[Dukhovnyi khristianin]:
#emph[Molokanskii religiozno-ekonomicheskii zhurnal] 1, no. 1 (Tiflis:
Tipografiia Metekhskogo Tiflisskogo zamka, 1905), 47.
“Tserkovno-obshchestvennaia zhizn': Molokanskii
religiozno-ekonomicheskii zhurnal,” #emph[Tserkovnyia vedomosti,
Pribavleniia] 19, no. 3 (1906): 134--37.]

Much of Prokhanov's thinking was influenced by the liberal unitarian Amy
Gaston Charles Auguste Bonet-Maury (1842--1919), a theologian who
championed freedom of conscience, ecumenicism, and the integration of
theology with science.#footnote[Gaston Bonet-Maury, #emph[Histoire de la
liberté de conscience en France depuis l'édit de Nantes jusqu'à Juillet
1870] (Paris: F. Alcan, 1900); Gaston Bonet-Maury, #emph[Le Congrès des
religions à Chicago en 1893] (Paris: Hachette, 1895); Theodore Stanton,
“Professor Gaston Bonet-Maury,” #emph[Open Court], no. 10 (1898):
630--34; “Prof. G. Bonet-Maury,” #emph[Forty Portraits and Biographical
Sketches for the Fourth International Congress of Religious Liberals,
Held at Boston, U.S.A., September 22--28, 1907] (n.p., 1907), 4--5.] As
a historian of religious liberty, Bonet-Maury was especially sympathetic
to the persecuted Russian Protestants he met in his classes. Aleksandr
and Ivan Prokhanov provided him with extensive information about the
religious situation of Baptists in Russia.#footnote[Prokhanov, #emph[In
the Cauldron of Russia], 102] Bonet-Maury admired Leo Tolstoy's
religious thought; in 1896, he made a pilgrimage to the Russian
novelist's estate in Iasnaia Poliana to present a personal invitation to
a congress of religions to be held in Paris in 1900---an invitation
Tolstoy politely declined.#footnote[Lev Nikolaevich Tolstoi,
#emph[Polnoe sobranie sochinenii,] 90 vols. (Moscow: Gos. izd-vo
khudozh. lit-ry, 1928--1958), 69: 198--201.]

Bonet-Maury was also a noted ecumenicist. When Prokhanov arrived in
Paris, Bonet-Maury had recently returned from the 1893 World's
Parliament of Religions in Chicago, which he celebrated as a sign of
progress toward religious liberty and harmony. “Men from twenty races,
priests of sixteen different religions, came from five parts of the
world, many dressed in their sacred vestments,” Bonet-Maury wrote
enthusiastically to the #emph[Journal des débats].#footnote[Quoted in
Gustave de Molinari, #emph[Science et religion] (Paris: Guillaumin,
1894), 238.] Comparing the Parliament to the ecumenical projects of the
Roman emperor Alexander Severus and the Mughal emperor Akbar, the French
theologian triumphantly concluded that “the world was ripe for a
peaceful conference of the great religions of the earth.” All particular
religions, Bonet-Maury declared, were simply derivations of the one
universal religion.#footnote[Quoted in Molinari, #emph[Science et
religion], 255.] Some of Bonet-Maury's ecumenical spirit seems to have
influenced Aleksandr Prokhanov. In articles that outlined his conception
of true religion, Prokhanov also drew upon speeches given at the
Parliament.#footnote[Aleksandr Stepanovich Prokhanov, “Fundament nashego
molokanstva,” #emph[Dukhovnyi khristianin] 1, no. 2 (1906): 1--4;
Aleksandr Stepanovich Prokhanov, “Fundament upovaniia dukhovnykh
khristian (O priiatii i otluchenii za veru),” #emph[Dukhovnyi
khristianin], no. 7 (June 1906): 9--15. See below for a fuller
discussion of these articles.]

Bonet-Maury was also a strong believer in the compatibility of religion
and science, a conviction that Prokhanov shared. In 1899, after he had
returned from France, Prokhanov attempted to organize a Society of
Educated Molokans that included believers across the empire, from the
Amur River to the Volga to the Caucasus---wherever Molokans had settled.
He sent a copy of the society's proposed charter to Vladimir
Prokof\'evich Efremov, a Molokan from Siberia who was studying medicine
in St. Petersburg, and asked whether there were any “intellectual
sectarian youth, who were interested in and loved their sectarianism”
among the Molokans on the Amur.#footnote[Gosudarstvennyi arkhiv
Rossiiskoi Federatsii (GARF), f. 102, Departament politsii Osobyi otdel
(DPOO), 1898 g., op. 226, d. 12, #emph[chast'] 2, l. 3] Prokhanov was
also in contact with another potential member of the society, Grigorii
Korotkov, a Molokan from Saratov Province studying in the Mining
Institute in St. Petersburg. Yet in a letter to his older brother Ivan,
Aleksandr expressed deep misgivings about his hope for the Molokan
community, which he regarded as crippled by ignorance, fanaticism, and
superstition: “I asked myself, can I live and do something among the
sectarians in the Caucasus? Is some compromise possible between me and
this superstitious, fanatical milieu? Can any work be done among them?
Could there be a society there where I could feel at
home?”#footnote[GARF, f. 102 DPOO, 1898 g., op. 226, d. 12 #emph[chast']
2, l. 15.]

Unfortunately for Prokhanov, the czarist police, increasingly fearful of
radical sectarian religion, perlustrated his correspondence and passed
on their intelligence to the overprocurator of the Holy Synod, who
immediately turned it over to the Synodal missionary Vasilii
Mikhailovich Skvortsov (1859--1932). First in a speech to the Tauride
Missionary Congress of May 1899 and then on the pages of his journal
#emph[Missionerskoe obozrenie] (#emph[Missionary Survey]), Skvortsov
publicly critiqued Aleksandr's attempt to reconcile science and
religion. Quoting tendentiously from the organization's charter,
Skvortsov presented the new association as godless and nihilistic, even
though it simply reflected the rationalistic, liberal Protestantism of
the French theological faculty.#footnote[Vasilii Mikhailovich Skvortsov,
“O starykh sobytiiakh i novykh iavleniiakh v oblasti sektantstva i
missionerskogo dela (Rech' pri otkrytii Tavricheskogo missionerskogo
s\"ezda 24 maia 1899),” #emph[Missionerskoe obozrenie], no. 10 (October
1899): 312.] Prokhanov's charter called for “the transformation of
traditional … sectarianism with the help of a scientific, but religious
worldview.”#footnote[Skvortsov, “O starykh sobytiiakh,” 310.] In
particular, the charter rejected “the literal inspiration and authority
of the Bible” in scientific questions such as “the origin of our solar
system” and of humanity. While affirming the existence and unity of God,
the charter denied the Trinity, the deity of Christ, original sin, the
devil, and the eternity of hell. At the same time, it affirmed that
human beings possessed free will, moral responsibility, immortal souls,
and a natural sense of right and wrong.

Much to Prokhanov's bewilderment, Skvortsov's attack was picked up by
right-wing newspapers, such as the nationalistic St. Petersburg daily
#emph[Svet] \[#emph[The Light]\]. Dismayed by the way his society was
mischaracterized, Aleksandr wrote his younger brother, Vasilii, on
February 2, 1900, asking how a newspaper could have learned about the
society and published its founding document. He asked Vasilii to burn
the letter after reading it, to no avail; by the time it reached
Vladikavkaz, the letter had already been intercepted. A copy remains in
the police archive to this day.#footnote[GARF f. 102, DPOO 1898, op. 226
d. 12 ch. 2, l. 19.]

#heading(level: 3)[The 1905 Revolution and the Struggle for Religious Freedom]

His hopes for a Society of Educated Molokans stifled by the authorities,
Prokhanov continued his medical studies, moving to St. Petersburg to
enroll in the Imperial Military Medical Academy, where he defended his
doctoral dissertation in histology in 1910.#footnote[Aleksandr
Stepanovich Prokhanov, #emph[K voprosu o patologo-anamoticheskikh
izmeneniiakh miokarda pri ostrom i khronicheskom oteke serdtsa], Seriia
doktorskikh dissertatsii dopushchennykh k zashchite v
Voenno-meditsinskoi akademii v 1909--1910 uchebnom godu, vol. 27 (St.
Petersburg: Tip. I. V. Leontʹeva, 1910).] During these eventful years,
he witnessed the 1905 revolution from his seat in the capital. Mass
political and social protest forced Nicholas II (r. 1894--1917) to
reform his autocratic system, expand religious toleration, and introduce
a legislative assembly. On 17 April 1905, the czar issued a manifesto of
religious toleration, providing a legal foundation for nonconformist
associations, publications, congresses, and
conferences.#footnote[#emph[Polnoe sobranie zakonov Rossiiskoi imperii],
sobranie 3-e, vol. XXV (1905) (St, Petersburg: Gosudarstvennaia
tipografiia, 1908), 257--58; Paul W. Werth, #emph[The Tsar's Foreign
Faiths: Toleration and the Fate of Religious Freedom in Imperial
Russia], Oxford Studies in Modern European History (Oxford: Oxford
University Press, 2014), 201--06; Coleman, #emph[Russian Baptists],
22--26.] One month later, on May 18, Prokhanov petitioned the Interior
Ministry for permission to establish a monthly periodical called
#emph[Dukhovnyi khristianin] (#emph[The Spiritual Christian]), which
would serve as a thick journal both for the faith of his ancestral
community and for the radical Christian vision that he hoped to
propagate. The journal's twelve-point program envisioned historical,
theological, and legal articles related to the Molokans, as well as
short stories, literary essays, debates, and book reviews. The journal
would also cover “other Russian and foreign sects and confessions,”
especially “the English sect called the Quakers,” hinting at Prokhanov's
aspirations for his own movement: the Society of Friends might serve as
a model for the kind of Christianity he hoped to nurture in
Russia.#footnote[RGIA, f. 776 , op. 8, d. 2015, l. 15.]

Permission from the St. Petersburg authorities, who had to check with
the police and the governors, took several months---too long for an
impatient Prokhanov, who traveled back to Tiflis so that he could make
his appeal directly to the newly appointed viceroy of the Caucasus,
Illarion Vorontsov-Dashkov (1837--1916, r. 1905--1916). Mass political
unrest had led the Senate to reestablish the viceroyalty in February
\1905. In early September, the viceroy met a delegation of Molokan
elders, led by Prokhanov, and allowed them to launch the journal, as
long as it was subject to preliminary censorship.#footnote[Prokhanov
1905 Nov-Dec: 4--6. An imperial decree in November removed the
requirement for preliminary censorship.] A few weeks later, on 3
November, Prokhanov also finally received permission to publish his
journal from the Main Directorate of the Press in St.
Petersburg.#footnote[RGIA, f. 776, op. 8, d. 2015.]

#heading(level: 3)[The Legendary Decree of 1805]

With the very first issue of his journal, Prokhanov faced the challenge
of reconciling his commitment to scientific truth with his desire to
revive and strengthen Russian Spiritual Christianity. For decades,
Russian Molokans had treasured the conviction that in 1805, Emperor
Alexander I had issued a decree granting them the liberty to practice
their faith. By the late 19th century, Molokans were circulating many
manuscript copies of this mythical decree and the petition to which it
responded.#footnote[Nikolai Dingelʹshtedt, #emph[Zakavkazskie sektanty v
ikh semeinom i religioznom bytu] (Tipografiia M. M. Stasiulevicha,
1885), 93--94; Frolov, “Religioznoe dvizhenie dukhovnykh khristian
Molokan,” 41; Aleksei L'vovich Vysotskii, “K voprosu o polozhenii
molokan v tsarstvovanie imperatora Aleksandra I (Proshenie na
vysochaishee imia molokan Tambovskoi i Voronezhskoi gubernii ot 22
iiunia 1805 g., s prilozhennym k nemu molokanskim obriadnikom),”
#emph[Izvestiia Tavricheskoi uchenoi arkhivnoi komissii] 32/33 (1902):
18--46.] Over the summer of 1905, Molokans immediately took advantage of
the April declaration of toleration to organize congresses celebrating
the centenary of the decree in the villages of Vorontsovka (present-day
Tashir, Armenia) in July and Astrakhanka, Tauride Province (today in
Zaporizhia Oblast', Ukraine) in early September.#footnote[“Stoletnii
molokanskii iubilei,” #emph[Dukhovnyi khristianin], no. 1 (December
1905): 6--38.; Ivan Fedos'evich Kolesnikov, “Iubileinyi s\"ezd v
Vorontsovke,” #emph[Dukhovnyi khristianin] 1, no. 3 (February 1906):
31--33; Daniil Evteevich Aver'ianov, “S\"ezd v Astrakhanke,”
#emph[Dukhovnyi khristianin] 1, no. 3 (February 1906): 33--40.] These
congresses celebrated the centenary of the decree, which established a
venerable pedigree for official recognition of Spiritual Christianity.

Prokhanov fully supported these congresses. At the same time, he was
also aware of the many flaws in the documentary evidence for the
legendary ukase, which was extant only in Molokan manuscripts. According
to these sources, three Molokan representatives---the townsman Petr
Zhuravtsov of Tambov Province and the peasants Maksim Losev and Matvei
Motylev of Voronezh Province---appeared before the emperor in July 1805
with a written request that they and their co-religionists receive
permission to worship God in their own way. “Free us from the yoke of
slavery of the Orthodox religion and from the tortures and slanders
against us by the priests…free us from the demands of the lords and the
torments of the chief officials and from the parish priests…. Forbid
them from entering our homes with their demands so that they might never
be able to burden us with slanders through false
denunciations.”#footnote[A. V. Loskutov, M. I. Bletkin, and M. M.
Maksimov, eds., #emph[Otchet o Vserossiiskom s\"ezde dukhovnykh
khristian (molokan), sostoiavshemsia 22-go iiulia 1905 g. v selenii
Vorontsovke, Tiflisskoi gubernii, Borchalinskogo uezda, po povodu
100-letnego iubileia samostoiatelnogo ikh religioznogo sushchestvovaniia
v Rossii so dnia opublikovaniia vysochaishego ukaza blazhennnoi pamiati
blagoslovennogo monarkha Aleksandra Pavlovicha, ot 22-go iiulia 1805 g.
1805--1905 gg.] (Tip. Gub. pravl., 1907), 20; Vysotskii, “K voprosu o
polozhenii Molokan,” 28--29; “Stoletnii molokanskii iubilei,” 13.]

The manuscripts then offer a mythologized account of the emperor's
response to the petition. Alexander convokes a committee of his
advisors, including Metropolitan Amvrosii (Andrei Ivanovich Podobedov,
1742--1818) of St. Petersburg (incorrectly identified as archbishop);
the overprocurator of the Holy Synod Aleksandr Nikolaevich Golitsyn
(1773--1844); the interior minister Viktor Pavlovich Kochubei
(1768--1834); the future field marshal (and hero of the Napoleonic wars)
Mikhail Illarionovich Kutuzov (1745--1813), the minister of justice Petr
Vasil'evich Lopukhin (1753--1827), the prominent landowner Count Sergei
Vasil'evich Sheremetev (1792--1866) (whose serfs included many
Molokans), and Mikhail Mikhailovich Speranskii (1772--1839), the author
of much of Alexander I's reformist legislation. Except for Sheremetev,
all of the royal counselors---even the Orthodox archbishop---support the
Molokans' petition, noting the impossibility of preventing them from
reading the Word of God. For his own venal motives, Sheremetev, the
owner of Molokan serfs, opposes the czar's merciful decision: the law
should recognize only ancient faith traditions, not “those who have
fallen away from the Orthodox Church and its law.”#footnote[“Stoletnii
molokanskii iubilei,” #emph[Dukhovnyi khristianin] 1, no. 1 (December
1905): 16.] Over Sheremetev's objections, the czar decides in favor of
the Molokans, who “are not to be hindered in the thoughts of their faith
nor to be constrained in the hope that they uphold.”
#footnote[“Stoletnii molokanskii iubilei,” 16]

Although no copy of this petition has been found outside of the Molokan
manuscript tradition, it may well have a historical basis. On several
different occasions, Molokans did petition Emperor Alexander for relief
from the pressures put upon them by local officials.#footnote[Frolov,
“Religioznoe dvizhenie dukhovnykh khristian molokan,” 97--99; Vysotskii,
“K voprosu o polozhenii Molokan,” 20--22.] However, the Molokan record
of Alexander's response has clearly been mythologized. The text contains
several anachronisms that reveal it as a forgery. For example, Kutuzov
is identified as a field marshal and holds the honorific “Smolenskii,”
titles that he received only in 1812 during the war against Napoleon.
Although he never served in the military, Speranskii is given the rank
of cavalry general. Vasilii Sheremetev, the greedy landowner, was only
twelve years old in July 1805, and so could not have participated in an
imperial council.#footnote[“Stoletnii molokanskii iubilei,”
#emph[Dukhovnyi khristianin] 1, no. 1 (November-December 1905): 14.]

For his part, Prokhanov was perfectly aware that the 1805 decree of
religious freedom was a fiction, albeit a useful one. In the first issue
of his journal, he published a critical analysis of the manuscript by an
author (probably Prokhanov himself) who used the pseudonym Zealot.
Zealot declared that “no educated person in the world” would accept the
Molokan manuscripts as genuine records of a czarist ukase. Not only did
these manuscripts contain many orthographic and grammatical errors, but
they also incorporated the internal debates of the czar's
advisors---something that no official decree would include. The Molokan
manuscripts recorded only a story \[#emph[rasskaz]\], but a story that
did have some basis in the truth. After all, Alexander I was
characterized by remarkable religiosity and tolerance, showed interest
in Russian sectarianism, and even conversed readily with the leaders of
minority religious movements, including even the infamous Castrates
\[#emph[skoptsy]\]. One could not entirely preclude the possibility that
Alexander had decreed freedom of religious confession for the Molokans,
Zealot concluded, even if the version preserved by the Molokan community
was not authentic. Molokans now had a duty to show the world that such a
decree really did exist by scouring the archives and gathering oral
traditions from the oldest members of the communities where the
descendants of the petitioners still lived. Zealot ended his critique by
hinting that the petitioners' surnames, which were each derived from the
names of animals, might belong to folklore rather than history:
Zhuravtsev came from the Russian word for crane (#emph[zhuravl']);
Losev, from elk (#emph[los']); and Motylev, from butterfly
(#emph[motylek]).#footnote[Revnitel', “Kriticheskii razbor dokumenta,”
#emph[Dukhovnyi khristianin] 1, no. 1 (November-December 1905): 20--22.]
Later, Prokhanov argued that the legendary decree had a historical basis
in Alexander I's efforts to mitigate persecution of religious dissenters
through specific edicts issued in 1800, 1801, and
\1803.#footnote[Aleksandr Stepanovich Prokhanov, “Podlinnyi ukaz tsaria
Aleksandra I-go naiden,” #emph[Dukhovnyi khristianin] 1, no. 3 (February
1906): 28--30; Aleksandr Stepanovich Prokhanov, “Kak my napali na sled
startsa Zhuravtsova,” #emph[Dukhovnyi khristianin] 1, no. 5 (April
1906): 64--70.]

Authentic or not, the legend of the czar who graciously responded to the
humble request of his dissenting subjects was valuable for the Molokans
who were seeking to expand religious liberty and obtain a more
respectable position in Russian society during a period of revolutionary
upheaval. The story, with dates amenable to commemoration, offered a
convenient rallying point to unite the theologically and politically
disparate Molokan movement that included both wealthy monarchist
merchants and revolutionary apocalyptic prophets. Molokans of all
persuasions continued to celebrate anniversaries of the decree through
the twentieth and twenty-first centuries.#footnote[San Francisco
Obshchina dukhovnykh khristian molokan postoiannykh, #emph[Otchet
Dukhovnykh khristian molokan (postoiannykh) po povodu 150-ti letniago
iubileia samostoiatel'nago ikh religioznago sushchestvovaniia so dnia
opublikovaniia vysochaishago ukaza gosudaria rossiiskago prestola
Aleksandra Pavlovicha ot 22-go iiulia, 1805 goda i 50-letniago iubileia
so dnia pereseleniia ... iz Rossii v Soed. shtaty Ameriki,
sostoiavshagosia 22-23 i 24-go iiulia, 1955 goda v gorode
San-Frantsisko] (\[Obshchina\], 1955); Ivan Aleksandrov, “‘Vozliubivshie
slovesnoe moloko': Molokane otprazdnovali iubilei darovaniia svobody
veroispovedaniia,” #emph[NG-Religii], October 5, 2005; Arkadii Sosnov,
“Poslanie ot molokan,” #emph[Poisk], August 26, 2016.]

#heading(level: 3)[Prokhanov's Vision: A Rational Religion of Love]

Through his journal, Prokhanov sought to shape a new kind of Russian
Christianity, an alternative to both the established Orthodox Church and
the Western evangelical Protestantism propounded by his father and
brothers. His vision called for a popular (#emph[narodnoe]) and
democratic Christianity, characterized by a love that could overcome
doctrinal division. At the same time, he hoped to bring Molokanism into
dialogue with Western biblical scholarship and with the global
ecumenical movement. On the pages of his journal, he brought Molokan
elders and leaders into conversation with each other, with other
sectarians, and even with members of the revolutionary intelligentsia.

Prokhanov celebrated the unique contribution of Spiritual Christians,
whose approach to faith, ethics, and scriptural interpretation was
distinct from Western Protestantism. In an article titled, “We Must
Return to Our Own Originality,” Prokhanov warned of a “silent
struggle…between our original Spiritual Christian theology and a foreign
theology, planted in our Zion with unusual zeal and energy by an entire
special organization!”#footnote[Aleksandr Stepanovich Prokhanov, “My
dolzhny vozvratit'sia k svoei samobytnosti,” #emph[Dukhovnyi
khristianin] 1, no. 6 (May 1906): 47.] Molokans were too quick to give
up their theology and practice. In too many congregations, “the former
patriarchal order of worship, consisting of mutual discussions while
seated,” had been replaced by a single preacher who alone had the right
to speak. Likewise, Spiritual Christians also abandoned their own
theology, developed consensually over many years of respectful dialogue.
“And our theological views! All of them, beginning with baptism and
ending with the dogmas of the Trinity, the Second Coming, and the
resurrection of the dead---all of our original Spiritual Christian
concepts have been transformed by the thirty-year influence of foreign
doctrines!”#footnote[Prokhanov, “My dolzhny vozvratit'sia,” 47.] Unlike
Baptism, which was committed to the literal interpretation of the
canonical scriptures, Russian Spiritual Christianity was marked by
“freedom of spirit…which is the essence of our hope and without which we
will turn into dead slaves of the letter, of ritual, and of an iron
presbyterian bureaucracy.”#footnote[Prokhanov, “My dolzhny
vozvratit'sia,” 48.]

Progressive theology was not to be found abroad, but within the Molokan
tradition itself. In particular, Prokhanov lionized the
mid-nineteenth-century Spiritual Christian elder Ivan Andreevich
Pashatskii (fl. 1860s) as a model for his religious
project.#footnote[“Molokanskaia bogoslovskaia shkola dlia podgotovleniia
nastavnikov i uchitelei molokanskogo veroucheniia imeni Ivana
Andreevicha Pashatskogo, nezabvennogo Saratovskogo nastavnika i pervogo
nashego bogoslova,” #emph[Dukhovnyi khristianin] 1, no. 2 (January
1906): 33--56.] A wealthy Molokan merchant in Saratov Province,
Pashatskii wrote a defense of his faith in 1862, which was smuggled out
of Russia and published three years later by Alexander Herzen's Free
Russian Typography in Geneva. Fully committed to progressive revelation,
Pashatskii expressed the conviction that future generations would
advance in their knowledge of divine truth: “As for our religious
confession, we wait and hope for the day when understanding of the
infinite truth will be explained even more by our descendants who will
have the zeal to penetrate even deeper into the sense of the divine
revelation, and therefore we do not pile anathemas on such people, but
on the contrary, we tell them, ‘rejoice.'”#footnote[\[Ivan Andreevich
Pashatskii\], #emph[Veroispovedanie dukhovnykh khristian, obyknovenno
nazyvaemykh molokanami] (Geneva: Vol'naia russkaia tipogragiia, 1865),
xv--xvi.] In this spirit, Pashatskii interpreted Adam and Eve's exile
from Paradise (Genesis 3) as a necessary step in humanity's spiritual
evolution, not as a punishment for original sin. Adam's innocence was no
better than that of brute beasts; to advance spiritually, he had to eat
of the tree of knowledge of good and evil. Driven from Paradise,
humanity must now “by their own efforts gain the blessing of union with
God.”#footnote[\[Pashatskii\], #emph[Veroispovedanie], 9.] Convinced
that Molokans needed their own version of the Bible, independent of the
Orthodox Church, Pashatskii financed a translation of the scriptures,
which was never completed. One of the translators was arrested and
exiled to Siberia, his work confiscated and destroyed. All that remained
of Pashatskii's project was a partial translation of the psalms kept in
the personal possession of a Molokan elder.#footnote[“Molokanskaia
bogoslovskaia shkola,” 37--38.]

Despite his expressed suspicion of Protestantism, Prokhanov also drew on
his training at the University of Paris to help Molokan presbyters
prepare edifying discourses on scriptural passages. In a series of
articles, Prokhanov translated and paraphrased many of the homiletical
anecdotes collected by the German Methodist preacher August Rodemeyer
(1837--1899).#footnote[\[August Rodemeyer\], “Bud'te gotovy,”
#emph[Dukhovnyi khristianin] 1, no. 4 (1906): 3--6; \[August
Rodemeyer\], “Iskry Bozhiia. Dushespasitel'nye khristiianskiia pritchi
dlia besed i propovedei.,” #emph[Dukhovnyi khristianin] 1, no. 4 (1906):
38--44.; A. S., “Tsarstvo Bozhie vnutri vas (pritcha)---iz Rodemeiera,”
#emph[Dukhovnyi khristianin] 1, no. 3 (1906): 6--8.] Prokhanov published
biblical criticism and theological essays in an effort to introduce
these tools to Spiritual Christian leaders. In his lectures and
writings, Prokhanov consistently defended the Septuagint and the
Slavonic Bible, with their inclusion of deutero-canonical books such as
Tobit, against the Protestant preference for the Masoretic text. In the
year before his death, Prokhanov published an introductory textbook on
the Old Testament for Molokan families and schools that deliberately
undermined the doctrine of biblical inerrancy by carefully unveiling the
contingent nature of the process of canonization and by surveying the
many apocryphal and lost works that had failed to become part of the
Bible. He attacked literal readings of scripture, preferring freer and
more figurative interpretations. He also emphasized the inferiority of
the Old Testament, with its burdensome ritual prescriptions and
prohibitions, to the New Testament, the covenant of the Spirit, which
had replaced it.#footnote[Aleksandr Stepanovich Prokhanov, #emph[Zakon
Bozhii Vetkhogo zaveta ili vvedenie v Vetkhii zavet] (Tipografiia I. V.
Leont'eva, 1911).] Prokhanov did not live long enough to complete
supplementary volumes introducing the New Testament and his approach to
philosophy.

In a series of articles published in the first years of his journal,
Prokhanov set out his understanding of the foundation of Molokanism,
drawing several of his illustrations from the 1893 World's Parliament of
Religions held in Chicago. For example, Prokhanov used a story recounted
at the Parliament by the Jain teacher Virachand Raghavji Gandhi
(1864--1901) about a group of blind men who argue over the nature of an
elephant that they have encountered. One, who touched only the animal's
leg, believes it to be similar to a big, round post; another, who felt
only the ear, imagines it to be a winnowing fan; a third, who came into
contact with the tail, thinks of it as a tapering stick. Only when a
bystander points out that each man has but a partial understanding do
they recognize the necessity of examining all viewpoints before coming
to a definite conclusion.#footnote[Prokhanov, “Fundament upovaniia,”
9--11. Prokhanov cites the work of the Moscow Theological Academy
professor Vasilii Aleksandrovich Sokolov (1851--1918), #emph[Parlament
religii v Chikago] (Sergiev Posad: A. I. Snegirevoi, 1894).]

In another article, to demonstrate the superiority of Molokanism as a
religion of love, Prokhanov cited a Russian folktale that the art critic
Prince Sergei Mikhailovich Volkonskii (1860--1937) had recounted at the
Parliament---a slightly different version of the tale incorporated by
Fedor Dostoevskii into his last novel, #emph[The Brothers Karamazov]
(1879--80). A wicked woman, damned to eternal torment, almost escapes
from hell thanks to the single good deed that she performed during her
life. Because she had once given a carrot (an onion in Dostoevskii's
rendering) to a hungry beggar, God instructs an angel to use that carrot
to pull her out of hell. But as the angel lifts her up, another sinner
grabs tightly to her legs so that he, too, might be carried to heaven.
Then a third clings to the second, and a fourth to the third until an
endless chain of humanity stretches from the tiny carrot to the fiery
abyss. Afraid that the carrot would not withstand the weight of so many
people, the woman cries out, “Leave me alone! Get your hands off me!
After all, the carrot is mine!” As soon as she pronounced the word
“mine,” the carrot suddenly broke in two, plunging all the sinners back
into the pit.#footnote[Aleksandr Stepanovich Prokhanov, “Fundament
nashego molokanstva,” #emph[Dukhovnyi khristianin] 1, no. 2 (1906):
1--4. Prokhanov quoted the story from V. A. Sokolov, “Parlament religii
v Chikago,” #emph[Bogoslovskii vestnik] 1, no. 3 (1894): 502--4. The
original can be found in Serge Wolkonsky, #emph[Addresses] (J.C. Winship
& Co., 1893), 68--70. Fedor Mikhailovich Dostoevskii's version is in
#emph[Brat'ia Karamazovy], #emph[Sobranie sochinenii v 15-ii tomakh]
(Leningrad: Nauka, Leningradskoe otdelenie, 1991), 9: 394, 685--86. In a
letter of 16 September 1879 to his editor Nikolai Liubimov, Dostoevskii
explained that he had recorded his version of the tale directly from a
peasant woman. George Gibian, “Dostoevskij's Use of Russian Folklore,”
#emph[The Journal of American Folklore] 69, no. 273 (1956): 248--49. N.
K. Piksanov, “Dostoevskii i fol'klor,” #emph[Sovetskaia etnografiia],
no. 1--2 (1934): 161--62. Although Dostoevskii claimed that he was the
first to put this oral tale into written form, other folklorists had
already published similar versions. See “Stranstvovanie po tomu svetu,”
in #emph[Zapiski o iuzhnoi Rusi], ed. Panteleimon Oleksandrovych Kulish
(St. Petersburg: A. Iakobson, 1856), 307--8; “Sankt Peters Mutter,” in
#emph[Anmerkungen zu den Kinder-u. Hausmarchen der Bruder Grimm], ed.
Johannes Bolte and Jiří Polívka, vol. 3 (Leipzig: Dieterichʹsche
Verlagsbuchhandlung, 1918).]

Curiously, neither Volkonskii nor Prokhanov showed any awareness of
Dostoevskii's use of the folktale. As Gary Saul Morson has pointed out,
Dostoevskii employed the story to illustrate his vision of the Christian
life as consisting of small, practical acts of kindness rather than
dramatic, ostentatious miracles.#footnote[Gary Saul Morson, “The God of
Onions: #emph[The Brothers Karamazov] and the Mythic Prosaic,” in
#emph[A New Word on the Brothers Karamazov] (Evanston, IL: Northwestern
University Press, 2004), 107--24.] By contrast, for Volkonskii, the
lesson of the tale was that every religion had a portion of the truth
and that everyone should share the portion of the truth that they
possessed: “If any individual, any community, any congregation, any
church, possesses a portion of truth and of good, let that truth shine
for everybody, let that good become the property of everyone. The
substitution of the word ‘mine' by the word ‘ours,' and that of ‘ours'
by the word ‘everyone's,' this is what will secure a fruitful result to
our collective efforts as well as to our individual
activities.”#footnote[Wolkonsky, #emph[Addresses], 70.]

The lesson that Prokhanov drew was quite different and it pointed to the
superiority of Spiritual Christianity over its rivals. Molokans, unlike
other Christian groups, emphasized love over dogma and allowed for major
doctrinal disagreements within their spiritual family. Whereas other
groups demanded creedal purity even in relatively minor matters,
Molokans could disagree over basic elements of the faith and still love
one another and embrace each other in Christian fellowship. For
Prokhanov, the folktale offered a way of vaunting his own natal
Molokanism over other movements, especially the Baptism of his brother
and father. “We Molokans recognize the deep truth in the words of the
Apostle Paul that love is the highest of the Christian
virtues.”#footnote[Prokhanov, “Fundament nashego molokanstva,” 2.]
Clearly pointing the finger at the Baptist movement, Aleksandr Prokhanov
went on to criticize the classical Protestant emphasis on faith, which,
in his view, contradicted Paul's teaching. “There are people who place
faith higher than love and on this foundation construct their salvation
and their ecclesiastical and social life.”#footnote[Prokhanov,
“Fundament nashego molokanstva,” 2] Such Christians associated only with
those who shared their dogmas and excluded all those who, for reasons of
conscience, understood dogmatic questions (baptism, communion)
differently. They preached “nothing other than self-love (#emph[my]
carrot), fanaticism, intolerance, and contempt for the others who have,
in their opinion, gone astray.”#footnote[Prokhanov, “Fundament nashego
molokanstva,” 2.]

Under Prokhanov's philosophy, #emph[The Spiritual Christian] became a
lively venue for opposing views on many doctrinal and ritual questions.
Should the text of the New Testament be the final, infallible rule of
faith for Christians? Or did the Holy Spirit continue to provide new
guidance and revelation?#footnote[Nikifor Vasil'evich Rakhmanov and
Dukhovnyi uchenik Gospoda, “Ob istochnikakh verouchenii” #emph[Dukhovnyi
khristianin] 1, no. 9 (August 1906), 4--15.] Molokan elders debated
whether the prophecies of Christ's second coming should be taken
literally or metaphorically.#footnote[Dukhovnyi uchenik Gospoda, “Besedy
startsev o vtorom prishestvii,” #emph[Dukhovnyi khristianin] 1, no. 9
(August 1906), 34--40.] Likewise, they argued about the resurrection of
the dead, with many denying the possibility of any physical
resuscitation. Molokans were divided over the Apostle Paul's command to
“greet one another with a holy kiss” (Romans 16:16). Some exchanged holy
kisses as an essential part of their weekly assemblies; others
considered the practice to be a form of debauchery. Although most
Molokans held funerary repasts and prayed for their dead, many rejected
these practices as pagan.

The nature of the Godhead also provoked debates on the pages of
#emph[The Spiritual Christian.] Although many Molokan statements of
faith, dating back to the early nineteenth century, affirmed the
Trinity, many Molokan elders rejected traditional Trinitarianism. For
example, in his 1862 confession of faith, Pashatskii dismissed the idea
of a three-person Godhead as “the absurd doctrine” of the Greco-Russian
Church. “God is one and indivisible,” Pashatskii firmly declared,
anticipating Prokhanov's own unitarianism. Father, Son, and Holy Spirit
were simply different names for the same being.#footnote[\[Pashatskii\],
#emph[Veroispovedanie], 5.] Likewise, many Spiritual Christians rejected
the idea that Jesus Christ, as the Son of God, could have had a human
body. Instead, they reasoned, his body was like that of the angel
Raphael in the deutero-canonical book of Tobit; consisting of spirit, it
only seemed to be physical.

#emph[Dukhovnyi khristianin] published many articles to help
congregations with legal problems, especially the complex process of
registration established in 1906.#footnote[T. G. Pankratov, “Bez
registratsii obshchiny,” #emph[Dukhovnyi khristianin] 6, no. 10 (1911):
67--69; Il'ia Kishko, “Registratsiia obshchin v Rossii. Iz sela
Ivanovki, Novouzen. u. Samar. Gub.,” #emph[Dukhovnyi khristianin] 6, no.
1 (1911): 38--45; Mikhail Kursiakov, “Registratsiia obshchin,”
#emph[Dukhovnyi khristianin] 6, no. 4 (1906): 39--40.] It also welcomed
writers from outside the community of Spiritual Christians. Baptists and
Russian Orthodox missionaries also contributed to the journal,
participating in debates about immersion baptism, the authority of
scripture, and the necessity of temples. Such articles were invariably
paired with Spiritual Christians offering a different point of view.
Tolstoyans, vegetarians, and revolutionaries also participated in the
ongoing conversation about true religion. Viktor Aleksandrovich Danilov
(1851--1916), a Populist who had been exiled to Siberia for his
participation in the 1874 “Going to the People” movement, expounded on
his own vision of a rational religion, criticizing Leo Tolstoy for
failing to live up fully to his ideals.#footnote[Viktor Aleksandrovich
Danilov, “Chelovek bez shapki,” #emph[Dukhovnyi khristianin] 5, no. 12
(1910): 25--36; Viktor Aleksandrovich Danilov, “Otvet na 50 voprosov
cheloveka religii-znaniia,” #emph[Dukhovnyi khristianin] 5, no. 11
(1910): 3--27; V Danilov, “Zhivoi ‘Ikonostas,'” #emph[Dukhovnyi
khristianin] 10, no. 1 (1915): 31--43; Viktor Aleksandrovich Danilov,
“Sushchnost' i znachenie religii v zhizni chelovechestva,”
#emph[Dukhovnyi khristianin] 5, no. 11 (1910): 27--33.] Iurii Osipovich
Iakubovskii (1857--1929), a Tolstoyan in Turkestan, made his case for
ethical vegetarianism.#footnote[Iu. O. Iakubovskii, “Chem pitat'sia
razumnym sushchestvam,” #emph[Dukhovnyi khristianin] 5, no. 12 (December
1910): 63--71; Peter Brang, #emph[Ein unbekanntes Russland:
Kulturgeschichte vegetarischer Lebensweisen von den Anfängen bis zur
Gegenwart] (Cologne, Germany: Böhlau, 2002), 210.] The politically
engaged Pavel Vasil'evich Ivanov (who later used the name
Ivanov-Klyshnikov, 1885? --1937), the son of a prominent Baptist
missionary and a future leader of the Baptist movement, also enjoyed
close ties to the Socialist Revolutionaries; he regularly contributed a
column on contemporary politics for the journal.#footnote[A. Dolotov,
“Nutro religii,” #emph[Sibirskie ogni], no. 1 (February 1929): 139;
Coleman, #emph[Russian Baptists], 253, n. 3; 254, n. 27.]

#heading(level: 3)[Conclusion]

Aleksandr Prokhanov's tragic death on 2 April 1912 from typhus
contracted from a patient that he was treating in the Tiflis hospital
put an end to his personal participation in the Molokan revival of the
early twentieth century. He was unable to realize his dream of a pure
religion of love, where doctrine, ritual, hierarchy, and institutions
yielded to spiritual freedom (#emph[svoboda dukha]).

Prokhanov's wife, Anastasiia Titovna (née Fefelova), the daughter of a
prominent Molokan who had joined the Baptist movement, took over the
editorship of the journal, with help from a circle of like-minded
supporters. #emph[Dukhovnyi khristianin] continued to be published until
the Bolshevik Revolution of 1917. Prokhanov's democratic vision of
Christianity animated the journal throughout its existence. It published
verses and stories written by Spiritual Christians from across the
empire. It also published debates among Spiritual Christians over
theology and ritual, including such questions as the Second Coming of
Christ, the nature of conversion, the place of works in salvation, the
place of the Old Testament, and the appropriateness of praying for the
dead. Prokhanov and his successors actively solicited essays on the
history and practices of Spiritual Christianity throughout the empire.
The journal gave space to widely differing visions of Spiritual
Christianity. On the one hand, it included missives from the apocalyptic
and radically pacifist followers of the Molokan prophet Maksim
Rudometkin (1818--1877), who fled to the United States to escape
persecution and military service. On the other hand, the journal
celebrated the service of Molokan soldiers fighting in the Caucasus
during World War I. The journal joyfully greeted the February Revolution
of 1917, which led to Nicholas II's abdication. However, the
#emph[Spiritual Christian] did not limit itself to Molokan voices alone.
It included debates between Molokans and Baptists, Molokans and Orthodox
missionaries. It published accounts from other religious minorities,
including the followers of Leo Tolstoy, the community of “New Israel”
who were led by the Voronezh peasant Vasilii Semenovich Lubkov
(1869--1937?), and the charismatic teetotaling peasant preachers Ivan
Alekseevich Churikov (1861--1933) and Ivan Koloskov, who, though
Orthodox, were suspected of heresy by the church
hierarchy.#footnote[Semen Antonovich Sushkov, “Golos Novogo Izrailia:
Put' k poznaniiu Boga i Tsarstviia Boga na zemle,” #emph[Dukhovnyi
khristianin] 6, no. 4 (1911): 54--57; I. M. Vel'mozhin, “Sredi
izrail'tian (molitvennye sobraniia molodezhi i ikh prepony).”
#emph[Dukhovnyi khristianin] 10, no. 9 (September 1915): 78--82; Page
Herrlinger, #emph[Holy Sobriety in Modern Russia: A Faith Healer and His
Followers] (Ithaca, NY: NIU Series in Slavic, East European, and
Eurasian Studies, Cornell University Press, 2023). Unfortunately,
Herrlinger's work is marred by its uncritical use of the fraudulent
memoir #emph[I Was Stalin's Bodyguard] (London: F. Muller, 1952) by the
notorious serial forger Grigorii Zinov'evich Besedovskii (1896--1951),
writing under the pseudonym “Achmed Amba.” On Besedovskii, see François
Kersaudy, “Quelques faux ouvrages remarquables sur l'URSS,”
#emph[Communisme: Revue d'etudes pluridisciplinaires], no. 29--31
(1992): 6--25.; N. Galay, “Atomzaren-Geflunker,” #emph[Ost-Probleme] 23
(1955): 934--35; Paul W. Blackstock, “‘Books for Idiots': False Soviet
‘Memoirs,'” #emph[Russian Review] 25, no. 3 (1966): 285--96.]
Ultimately, the journal succumbed to a lack of funds and the repression
of the Bolshevik Revolution. Molokans continued to publish in the 1920s,
but these publications represented the work of the official Molokan
religious denomination, dissolved in the first five-year plan. The
democratic and utopian vision of Christians united in spirit, perhaps
always unrealistic, did not long survive the Russian empire, with its
much different understanding of democracy, citizenship, and the
church-state relationship.

<end-of-article-clay>
