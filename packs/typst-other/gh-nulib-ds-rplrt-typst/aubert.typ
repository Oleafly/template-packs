#import "elements.typ": *

#counter(footnote).update(0)
#abstract(
  [Friedrich Schleiermacher and Semyon Frank],
  abstract-subtitle: [On Religion and Dignity],
  abstract-author: [Annette G. Aubert],
  [
    ],
  abstract-keywords: []
)

// This section sets the headers for the article
#set page(
  header-ascent: 40%,
  header: context {
    set text(8pt, font: "IBM Plex Sans", stretch: 75%, weight: 400)
    let first-page = locate(<first-page-aubert>).page()
    if here().page() == first-page [
      #grid(
        columns: (45%, 45%),
        gutter: 10%,
        align(left)[
          NORTHWESTERN UNIVERSITY STUDIES IN RUSSIAN\
          PHILOSOPHY, LITERATURE, AND RELIGIOUS THOUGHT
        ],
        align(right)[
          Volume 2 (2024): #first-page#sym.dash.en#locate(<end-of-aubert>).page() \
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

#heading(level: 2)[Friedrich Schleiermacher and Semyon Frank]
#v(1em)
#subtitle([On Religion and Dignity])

#v(1em)
#author[Annette G. Aubert]
<first-page-aubert>
Scholars of Russian culture have long acknowledged the importance of
situating ideas and cultural norms within broader comparative
frameworks.#footnote[Parts of this article were presented at the
conference #emph[Religion, Human Dignity, and Human Rights: New
Paradigms for Russia and the West at the Hamilton Center for Classical
and Civic Education], University of Florida, Gainesville, November 2024.
I thank the anonymous reviewers for their insightful comments and
suggestions.

Iver G. Neumann, #emph[Russia and the Idea of Europe: A Study in
Identity and International Relations], 2nd ed. (New York: Routledge,
2013).] In his classic #emph[Spirit of Russia] (1918), philosopher and
politician Tomáš Garrigue Masaryk noted the “incontestably great”
influence of Europe on Russia,#footnote[T. G. Masaryk, #emph[The Spirit
of Russia: Studies in History, Literature and Philosophy], trans. Eden
and Cedar Paul, vol. 2 (London: Allen & Unwin, 1919), 559, 560. See also
Donald Mackenzie Wallace, #emph[Russia] (London: Cassel, 1886), 397.]
with varying influences from specific foreign-based
sources,#footnote[For a recent study on the cultural transfer between
Russia and Europe, see Nikolaus Katzer, “Kulturtransfer zwischen
Russland und dem Westen vom späten 17. bis zum beginnenden 20.
Jahrhundert,” in #emph[Band 6 Deutsch-russische Kulturbeziehungen im 20.
Jahrhundert. Einflüsse und Wechselwirkungen], ed. Horst Möller and
Aleksandr O. Cubar'jan (Berlin: De Gruyter, 2016), 1--9.] such as German
theological texts.#footnote[In the 1840s the libraries of educated
Russian priests were filled with books written by German theologians
such as Friedrich Schleiermacher, August Neander, and David Friedrich
Strauss. J. G. Kohl, #emph[Russia: St. Petersburg, Moscow, Kharkoff,
Riga, Odessa, the German Provinces on the Baltic, the Steppes, the
Crimea, and the Interior of the Empire] (Kiribati: Chapman & Hall,
1842), 268.] In their recent discussion of exploring Russian ideas
across diverse fields in the global age, Vlad Strukov and Sarah Hudspith
advocate an approach that presents Russia as a transnational
space.#footnote[Vlad Strukov and Sarah Hudspith, eds., #emph[Russian
Culture in the Age of Globalization] (New York: Routledge, 2019).] While
the term “transnational” is more frequently found in the social sciences
and history than in religious, philosophical, or related
studies,#footnote[Andy Byford, Connor Doak, and Stephen Hutchings, eds.,
#emph[Transnational Russian Studies] (Liverpool, UK: Liverpool
University Press, 2020), 6.] English-language scholarship can benefit
from studying interactions between Russian religious philosophers and
nineteenth-century theological ideas from Germany. Scholars have
explored the impact of German idealism on Russian
thought,#footnote[Recent examples include Oksana Nazarova, #emph[Das
Problem der Wiedergeburt und Neubegründung der Metaphysik am Beispiel
der christlichen philosophischen Traditionen: Die russische religiöse
Philosophie (Simon L. Frank) und die deutschsprachige neuscholastische
Philosophie] #emph[\(Emerich Coreth)] (Munich: Herbert Utz Verlag,
2017); Thomas Nemeth, #emph[Kant in Imperial Russia] (Cham, Switzerland:
Springer International Publishing, 2017); Vladislav Lektorsky and Marina
Bykova, eds., #emph[Philosophical Thought in Russia in the Second Half
of the Twentieth Century: A Contemporary View from Russia and Abroad]
(London: Bloomsbury, 2019); and Konstantin Abrekovich Barsht,
“Filosofskaia teologiia F. Shleiermakhera i religioznoe reformatorstvo v
proizvedeniiakh I. V. Kireevskogo i F. M. Dostoevskogo,”
#emph[Filosoficheskie pis'ma. Russko-evropeiskii dialog], vol. 4, no. 1
(2021): 57--79. See also the classic account in Nikolai Berdyaev,
#emph[The Russian Idea], trans. R. M. French (Hudson, NY: Lindisfarne,
1992).] but further investigation is required to understand fully the
west-to-east flow of ideas produced by German intellectuals such as
Friedrich Schleiermacher (1768--1834), frequently described as “the
father of modern Protestantism.” This article compares his ideas
concerning human dignity with those of the Russian philosopher Semyon
Liudvigovich Frank (1877--1950).

In her study of theological ethics, Lydia Lauxmann describes human
dignity as a “central theological concept.”#footnote[Lydia Lauxmann,
#emph[Die Entdeckung der Menschenwürde in der theologischen Ethik]
(Tübingen: Mohr Siebeck, 2022), 1.] While Catholicism has placed a
greater emphasis on human dignity,#footnote[Jadwiga Guerrero van der
Meijden, #emph[Person and Dignity in Edith Stein's Writings:
Investigated in Comparison to the Writings of the Doctors of the Church
and the Magisterial Documents of the Catholic Church] (Berlin: De
Gruyter, 2019); Regis A. Duffy and Angelus Gambatese, eds., #emph[Made
in God's Image: The Catholic Vision of Human Dignity] (New York:
Paulist, 1999); David G. Kirchhoffer, “Benedict XVI, Human Dignity, and
Absolute Moral Norms,” #emph[New Blackfriars] 91, no. 1035 (September
2010): 586--608; Alejo José G. Sison, Ignacio Ferrero, and Gregorio
Guitián, “Human Dignity and the Dignity of Work: Insights from Catholic
Social Teaching,” #emph[Business Ethics Quarterly] 26, no. 4 (October
2016): 503--528.] multiple discussions of the topic are nevertheless
also found in the German Protestant tradition,#footnote[See, for
example, Jürgen Moltmann, #emph[Menschenwürde, Rechte und Freiheit]
(Stuttgart: Kreuz-Verlag, 1979) and Oswald Bayer, “Martin Luther's
Conception of Human Dignity,” in #emph[The Cambridge Handbook of Human
Dignity: Interdisciplinary Perspectives], ed. M. Düwell, J. Braarvig, R.
Brownsword, and D. Mieth (Cambridge: Cambridge University Press, 2014),
101--107.] as well as in Russian philosophical texts written by figures
such as Frank.#footnote[For a fine study on Russian philosophy and human
dignity, see G. M. Hamburg and Randall A. Poole, eds., #emph[A History
of Russian Philosophy], #emph[1830--1930:] #emph[Faith], #emph[Reason,
and the Defense of Human Dignity] (Cambridge: Cambridge University
Press, 2010).] However, recent scholarship in Protestant perspectives on
dignity has mostly passed over Schleiermacher's ideas,#footnote[For
recent books that deal with the Protestant tradition of human dignity
but overlook the contribution of Schleiermacher, see R. Kendall Soulen
and Linda Woodhead, eds., #emph[God and Human Dignity] (Grand Rapids,
MI: Eerdmans, 2006); Lauxmann, #emph[Die Entdeckung der Menschenwürde in
der theologischen Ethik]\; John
#link("https://www.google.com/search?sca_esv=9c491feca8eb3a39&hl=en&q=John+Loughlin+(political+scientist)&si=APYL9btKi1TLoawpxIKkhA47KIc3RH36yjJAdk2TmwBtOZld-qBzUxF5v7rGTdeWcHg8wDCYl4-WahGr-GMU-07Q7bJQFp7LKGpBZk52pNj2dNXd8naSQsPeE709oedob4XF61I3KmnDNLWMl06lS5W0dcY6qjavwZ8h8o3Nnj6HI2qN1eSWJdnFTFXqvUVxERio2jUDNzhIBC-aoaULiMMdp86u_FIekpRY4DcpG7SIxkJAk59ro2g%3D&sa=X&ved=2ahUKEwjsndqwqtuMAxVGFFkFHSkxKMwQmxMoAHoECAwQAg")[Loughlin],
ed., #emph[Human Dignity in the Judaeo-Christian Tradition: Catholic,
Orthodox, Anglican and Protestant Perspectives] (London: Bloomsbury,
2019).] preferring instead to analyze the views of Immanuel
Kant.#footnote[A notable exception to this is
#link("https://www.google.com/search?sca_esv=9c491feca8eb3a39&hl=en&q=J%C3%B6rg+Dierken&si=APYL9bvbTYBlvjo9HgsKokb80VOuw9zV-z5EXyhbMKCadi8Rh0lr6jtNj4_o4cHu9YF7v1jXYq5Vq_JZNxriRhE3F_W_ETPkK7187bGzvmQG-6QR2nzoc1WxvLNfc2Sv1fMRGbusJvaNLJ6ObtiGtD4I4C4qbCfTti8QMJhSvbX_h1KBudb4KzfghY1uZnizC-EFe6exdQPxQlHNskTzMiXbxxnWNtIN-ZIx6tSu1koGgnnF7E7ZRJHzDzGUvcBbqrz7j2SQvi2OGxnyC_wakTR1xTcQHzhRqQ%3D%3D&sa=X&ved=2ahUKEwigzvSqq9uMAxXxMlkFHd4-EWQQmxMoAHoECBkQAg")[Jörg Dierken]
and
#link("https://www.google.com/search?sca_esv=9c491feca8eb3a39&hl=en&q=Arnulf+von+Scheliha&si=APYL9btZkf4kdGhzReFKIi4_F4HlfAbNt65clXF8w4EPLuE33vh2Z2NmGE95FWgUwNQ0qDVInIEQPh4rlCJII-MuFlZZ-wfzZQZyNe96SJU47oUaCvlDIFPTC8KuMvni5gP_KIzFZTQWix6AVY64as1Ux_CgmksI9iVFjbXGPgCU47mAdguzwfPD0SZvc8tof2KEZSm7Wx2rj8ofisCt2BDKaXzFcEpS4T6cBq0Pqw95-dQm9gm6JSWmumC1hAUS7M8r9oDjGV-fVMX3poVm8YN3ZQiOhugilQ%3D%3D&sa=X&ved=2ahUKEwigzvSqq9uMAxXxMlkFHd4-EWQQmxMoAXoECBkQAw")[Arnulf von Scheliha],
eds., #emph[Freiheit und Menschenwürde: Studien zum Beitrag des
Protestantismus] (Tübingen: Mohr Siebeck, 2005). The authors reference
Schleiermacher, but they do not offer a detailed analysis of his views.
For a study focused on Schleiermacher and the concept of dignity in his
published sermons, see Annette G. Aubert, “Human Dignity in the Sermons
of Friedrich Schleiermacher,” in #emph[Sermons and Human Dignity], ed.
Paul E. Kerry and William Skiles (Leiden: Brill, forthcoming).] Unlike
Schleiermacher and Frank, Kant deemphasized religion when arguing that
morality is at the core of dignity.#footnote[Michael Rosen,
#emph[Dignity: Its History and Meaning] (Cambridge, MA: Harvard
University Press, 2012), 20--25; Immanuel Kant, #emph[Groundwork of the
Metaphysics of Morals], ed. and trans. Mary Gregor (Cambridge: Cambridge
University Press, 1997), 4: 434--35.] To illustrate post-Kantian
perspectives on dignity in modernity, it will be shown how
Schleiermacher and Frank used a theological lens (as opposed to Kant's
more secular approach) to identify religious experience and human
creativity in relation to human dignity.

Frank, whom Vasily Zenkovsky described as Russia's greatest
philosopher,#footnote[V. V. Zenkovsky, #emph[A History of Russian
Philosophy], trans. George L. Kline, 2 vols. (New York: Columbia
University Press, 1953), 2: 853, 872.] was born more than forty years
after Schleiermacher's death. To date, no scholarship has examined
similarities in Schleiermacher's and Frank's views on human dignity,
even though Frank was clearly familiar with Schleiermacher's work on
Protestant religious topics, describing Schleiermacher as someone who
could “serve as a teacher of life for us,”#footnote[S. L. Frank,
“Persönlichkeit und Weltanschauung Friedrich Schleiermachers,” in
#emph[Werke in acht Bänden], vol. 8, #emph[Lebendiges Wissen: Aufsätze
zur Philosophie], ed. Peter Schulz, Peter Ehlen, Nikolaus Lobkowicz et
al., trans. from the Russian by Vera Ammer (Freiburg: Karl Alber, 2013),
\128.] and writing a detailed sketch of Schleiermacher for Russians who
were unfamiliar with his views.#footnote[Scholars have commented on
Frank's efforts to translate Schleiermacher's work only briefly. Philip
Boobbyer, #emph[S. L. Frank: The Life and Work of a Russian Philosopher,
1877--1950] (Athens: Ohio University Press, 1995), 78, 79. For a study
on Frank's use of W. Dilthey's interpretation of Schleiermacher, see K.
M. Antonov and M. A. Pylaev, “Vliianie knigi #emph[Leben
Schleiermachers] V. Dil'teia na interpretatsiiu #emph[Rechei o religii]
F. Shleiermakhera u S. Franka,” #emph[Studia Religiosa Rossica] 4
(2021): 14‒31. For research on Russian philosophers, such as Sergius
Bulgakov, and his connection with Schleiermacher, see Edmund Newey,
#emph[Children of God: The Child as Source of Theological Anthropology]
(New York: Taylor & Francis, 2016).] In his “Friedrich Schleiermacher's
Personality and Worldview,” Frank called him “a genius of life” on the
basis that Schleiermacher's religious-philosophical opinions created
“the foundation and starting point of the entire German Protestant
theology … \[and noted that\] his historical philosophical research,
alongside Hegel's philosophy of history, laid the groundwork for the
entire German philosophy of history.”#footnote[Frank, “Persönlichkeit
und Weltanschaung Friedrich Schleiermachers,” 106, 98.] Frank (who was
proficient in German) was so impressed by Schleiermacher's
religious-philosophical opinions that he translated some of his texts
into Russian. His first project, completed in 1911, was Schleiermacher's
1799 #emph[On Religion: Speeches to Its Cultured Despisers], which Frank
considered to be a highlight of the Romantic movement and a core text
during his own lifetime.#footnote[Frank, “Persönlichkeit und
Weltanschaung Friedrich Schleiermachers,” 99.] As Frank translated
#emph[On Religion], he came under the intellectual influence of
Schleiermacher, especially his romanticist-idealist-pietistic
views.#footnote[Frank's work is shaped by various influences, including
Plato, Plotinus, Nicholas of Cusa, Neo-Kantianism, and German Idealism,
as well as Goethe and Spinoza. Philip J. Swoboda, “Semën Frank's
Expressivist Humanism,” in #emph[A History of Russian Philosophy,
1830--1930: Faith, Reason, and the Defense of Human Dignity], ed. G. M.
Hamburg and Randall A. Poole (Cambridge: Cambridge University Press,
2010), 210. H. Moore, “German Idealism and the Early Philosophy of S. L.
Frank,” #emph[Studies in East European Thought] 75 (2023): 525--42. For
a study on the influence on Hegel's thought on Frank, see George L.
Kline, “The Hegelian Roots of S. L. Frank's Ethics and Social
Philosophy,” #emph[The Owl of Minerva] 25, no. 2 (1994): 195--208;
George L#emph[.] Kline#emph[,] “The Religious Roots of S. L. Frank's
Ethics and Social Philosophy,” in #emph[Russian Religious Thought], ed.
Judith Deutsch Kornblatt and Richard F. Gustafson (Madison: University
of Wisconsin Press, 1996), 213--33.] The translation project supported
Frank's immersion in Schleiermacher's ideas on religion and anthropology
in a modern context, including foundational connections among religion,
human consciousness, and the creation of humanity.#footnote[Another
translation project was #emph[Monologen], which resembled J. G. Fichte's
#emph[The Vocation of Man] (1799). Johann Gottlieb Fichte, #emph[The
Vocation of Man], trans. William Smith, 2nd ed. (Chicago: Open Court
Publishing Company, 1910).]

A review of Schleiermacher's early writings reveals similarities and
differences with Frank's definitions of human dignity. These definitions
were based on “religious consciousness” frameworks rooted in “the
personal piety of believers,” as opposed to Enlightenment definitions
based on intrinsic moral values.#footnote[Randi Rashkover, #emph[Nature
and Norm: Judaism, Christianity, and the Theopolitical Problem] (Boston:
Academic Studies Press, 2021).] Moving away from the ethical
considerations that preceded them, Schleiermacher and Frank used an
anthropological focus that stressed aesthetics and creativity as central
to any effort to understand human dignity. Both followed Christian
tradition by emphasizing the #emph[imago Dei] concept of human creation,
but with a notably stronger Christological emphasis. This essay first
introduces Schleiermacher's views on human dignity, then describes
parallels with Frank's religious philosophy in a post-Kantian
context#emph[.]#footnote[For religious humanism and Frank in Russia, see
Bernice Glatzer Rosenthal, “Religious Humanism in the Russian Silver
Age#emph[,]” in #emph[A History of Russian Philosophy, 1830--1930:
Faith, Reason, and the Defense of Human Dignity,] ed. G. M. Hamburg and
Randall A. Poole (Cambridge#emph[:] Cambridge University Press, 2010),
227--47.]

Schleiermacher frequently referred to “#emph[Menschenwürde]” or
“#emph[Würde der Menschheit]” (“human dignity”) in his writing but never
devoted an entire book or essay to the topic. He first addressed the
concept in #emph[On Religion] when describing “the dignity of
humanity.”#footnote[Friedrich Schleiermacher, #emph[Über die Religion:
Reden an die Gebildeten unter ihren Verächtern] (Berlin: Johann
Friedrich Unger, 1799), 18. A similar reference appears in the fourth
edition of #emph[On Religion] (1831). Friedrich Schleiermacher,
#emph[Über die Religion: Reden an die Gebildeten unter ihren
Verächtern], ed. Günter Meckenstock (Berlin: De Gruyter, 1995), 24.]
This text on “Romantic piety” formed Schleiermacher's anthropology and
ideas about dignity; this work is considered a primary example of
Schleiermacher's influence.#footnote[Günter Meckenstock, “Historische
Einführung,” in Friedrich Schleiermacher, #emph[Über die Religion,
Monologen], ed. Günter Meckenstock (Berlin: De Gruyter 1995), vii.]
Schleiermacher articulated the theme of human dignity both directly and
indirectly in collections of academic lectures and dogmatic works:
#emph[Aesthetics], #emph[Dialectics], #emph[Ethics], and #emph[Christian
Faith]. Schleiermacher grounded his concept of dignity in an
anthropology associated with human identity,#footnote[Ruedi Imbach,
“Human Dignity in the Middle Ages,” in #emph[The Cambridge Handbook of
Human Dignity], ed. Marcus Düwell, Jens Braarvig, Roger Brownsword, and
Dietmar Mieth (Cambridge: Cambridge University Press, 2014), 64.] human
consciousness, and the soul. Since Frank never wrote a monograph focused
solely on human dignity, to uncover his views on dignity and related
topics within a religious framework, we must examine texts such as the
posthumously published #emph[Reality and Man: An Essay in the
Metaphysics of Human Nature] (1956), #emph[God with Us] (1946), and
#emph[The Light Shineth in Darkness: An Essay in Christian Ethics and
Social Philosophy] (1949).#footnote[As Philip Boobbyer notes, “it was in
emigration---\[Frank\] was forced into exile in 1922---that his
religious ideas emerged in their most developed form.” Philip Boobbyer,
“Semyon Frank,” in #emph[The Oxford Handbook of Russian Religious
Thought], ed. Caryl Emerson, George Pattison, and Randall A. Poole
(Oxford: Oxford University Press, 2020), 495.] Frank used the word
“dignity” much more frequently than Schleiermacher, especially in texts
expressing Frank's “mature philosophy of religion.”#footnote[According
to Philip Swoboda, there are “significant differences between the
philosophical opinions Frank held in 1904, and those he defended in his
mature books.” Philip J. Swoboda, “‘Spiritual Life' versus Life in
Christ: S. L. Frank and the Patristic Doctrine of Deification,” in
#emph[Russian Religious Thought], ed. Judith Deutsch Kornblatt and
Richard F. Gustafson (Madison: University of Wisconsin Press, 1996),
235, 241.]

Details on Schleiermacher's attempts to comprehend human beings appear
in his engagement with both Christian and Romantic traditions and
portray human dignity through a combination of Romantic aesthetics,
religious self-consciousness, and Christian theology. His unique status
as a nineteenth-century mediating theologian enabled him to integrate
elements from both Christianity and Romanticism into his views of human
dignity and identity.#footnote[For Schleiermacher as mediating
theologian, see Annette G. Aubert, “Schleiermacher and Mediating
Theology,” in #emph[The Oxford Handbook of Friedrich Schleiermacher,]
ed. Andrew C. Dole, Shelli M. Poe, and Kevin M. Vander Schel (Oxford:
Oxford University Press, 2023), 505--21.] Close readings of his lectures
and dogmatic work show how his approach to human dignity was based on an
understanding of human nature in a post-Enlightenment context. In
discussing religious consciousness, Schleiermacher described an indirect
connection between human dignity and identity, using the “feeling of
absolute dependence” formula involving human dignity and religious
experience. According to Schleiermacher, the essence of humanity
consists of an absolute dependence on God, with piety as its
source,#footnote[As Maureen Junker-Kenny notes, “Piety which has its
seat in #emph[feeling] is in itself something entirely different from
morality.” Maureen Junker-Kenny, #emph[Self, Christ and God in
Schleiermacher's Dogmatics: A Theology Reconceived for Modernity]
(Berlin: De Gruyter, 2021), 32.] and a strong God-consciousness. This
post-Kantian idea distinguished his views from those based on
morality.#footnote[Philip M. Merklinger, #emph[Philosophy, Theology, and
Hegel's Berlin Philosophy of Religion, 1821]--#emph[1827] (Albany: State
University of New York Press, 1993), 128.]

#strong[Human Dignity and Aesthetics]

Schleiermacher's concept of human dignity combined ideas from religion
and aesthetics when offering insights into human identity.#footnote[He
considered ideas associated with aesthetics, especially regarding
aesthetic feelings and human nature. Holden Kelm, “Philosophy of Art:
With Special Regard to the #emph[Lectures on Aesthetics],” in #emph[The
Oxford Handbook of Friedrich Schleiermacher,] ed. Andrew C. Dole, Shelli
M. Poe, and Kevin M. Vander Schel (Oxford: Oxford University Press,
2023), 207. For a study on Schleiermacher's anthropology and aesthetics,
see Dorothea Meier and Holden Kelm, #emph[Der Mensch und die Kunst bei
Friedrich Schleiermacher: Beiträge zur Anthropologie und Ästhetik]
(Berlin: De Gruyter, 2023).] He was not the first to consider the topic
of dignity in terms of aesthetics: Friedrich Schiller (1759--1805) had
integrated the concept into his moral psychology in his #emph[Grace and
Dignity] (1793).#footnote[Rosen, #emph[Dignity], 35.] Long before the
nineteenth-century humanist renaissance, thinkers such as Pico della
Mirandola (1463--1494) and Marsilio Ficino (1443--1499) analyzed dignity
as the essence of creative beings. Schleiermacher applied an artist
metaphor to explain human creativity, describing God as “the great
artist” who created humans in his own image, endowing them with the
necessary powers to act as creators and shapers of their
worlds.#footnote[Enno Rudolph, #emph[Theologie -- diesseits des Dogmas:
Studien zur systematischen Theologie, Religionsphilosophie und Ethik]
(Tübingen: J. C. B. Mohr, 1994), 75.] Similar to some Renaissance
humanists, he used a creativity lens to describe a humanity created in
God's own image.

A closer examination of Schleiermacher's #emph[Lectures on Aesthetics]
(delivered at the University of Berlin in 1819) reveals the romanticist
framework of his views on human dignity, especially the ways in which he
connected human dignity and identity with aesthetic characteristics and
religion. Similar to other early romanticists, in #emph[On Religion],
Schleiermacher discussed the idea of “art as religion”
(#emph[Kunstreligion]) when discussing human dignity.#footnote[Frank
notes this connection between art and religion in his interpretation of
Schleiermacher's #emph[On Religion]. Frank, “Persönlichkeit und
Weltanschaung Friedrich Schleiermachers,” 113. For a study on art and
religion in Schleiermacher, see Anne Käfer, #emph[Die wahre Ausübung der
Kunst ist religiös. Schleiermachers Ästhetik im Kontext der
zeitgenössischen Entwürfe Kants, Schillers und Friedrich Schlegels],
Beiträge zur historischen Theologie 136 (Tübingen: Mohr Siebeck, 2006).
For a discussion on #emph[Kunstreligion], see Jan Rohls, “Sinn und
Geschmack fürs Unendliche---Aspekte romantischer Kunstreligion,”
#emph[Neue Zeitschrift für Systematische Theologie und
Religionsphilosophie] 27 (1985): 1--24.] Unlike Schiller, Schleiermacher
viewed human beings as imitating and possessing the consciousness of
God#footnote[Friedrich Schleiermacher, #emph[Vorlesungen über die
Aesthetik,] ed. Rudolf Odebrecht (Berlin: De Gruyter, 1931), 67.]---that
is, his perception of aesthetics treated religion as a “general
psychological connection” reflecting human religious
consciousness.#footnote[Eugen Huber, #emph[Die Entwicklung des
Religionsbegriffs bei Schleiermacher] (Leipzig: Dieterisch'sche, 1901),
215-17. Frank, in particular, emphasized the significance of
Schleiermacher's “psychological description of his religious
consciousness.” Frank, “Persönlichkeit und Weltanschaung Friedrich
Schleiermachers,” 111. For a recent discussion that engages with
Schleiermacher's reduction of religion to psychology, see Matei Iagher,
#emph[The Making and Unmaking of the Psychology of Religion] (New York:
Routledge, 2024).] He described music as having the closest connection
to religious consciousness, which he expressed as a “feeling of absolute
dependence.”#footnote[Albert Blackwell, “The Role of Music in
Schleiermacher's Writings,” in #emph[Internationaler
Schleiermacher-Kongreß Berlin 1984], ed. Kurt-Victor Selge (Berlin: De
Gruyter, 1985), 439--48, esp. 445.] As Frederick Copleston notes in
#emph[A History of Philosophy], Schleiermacher viewed “religious
consciousness” as more closely related to “aesthetic consciousness than
theoretical knowledge,” with its most salient feature being the “feeling
of absolute dependence on the infinite.”#footnote[Frederick Charles
Copleston, #emph[A History of Philosophy], vol. 7: #emph[Modern
Philosophy: From the Post-Kantian Idealists to Marx, Kierkegaard, and
Nietzsche] (New York: Image Books, 1963), 152.]

Schleiermacher's aesthetic reinterpretation employed the arts as a
framework for understanding the concept of dignity, similar to the
broader intellectual descriptions of “human dignity through art”
(#emph[Menschenwürde durch die Kunst]) offered by Schiller and Johann
Wolfgang von Goethe.#footnote[Egbert von Frankenberg, #emph[Die
geistigen Grundlagen der Theaterkunst] (Weimar: Kiepenheuer, 1910), 65.]
As a #emph[Bildungsbürger], Schleiermacher (who valued both art and
culture) perceived art as the door through which the value of an
individual is recognized, arguing that “only together with art \[do\] we
become conscious of the dignity of man (#emph[Würde des
Menschen]).”#footnote[Friedrich Schleiermacher, #emph[Vorlesungen über
die Ästhetik], ed. Holden Kelm, KGA II/14 (Berlin: De Gruyter, 2021),
215 (Kollegheft 1819).] His conception of human dignity stressed the
importance of human freedom as well as religious consciousness,
acknowledging art as being both diversionary and also fulfilling an
essential role for humanity. He described art as the only way for humans
to attain both an “awareness of freedom” and “an independent, permanent
consciousness of the divine within; everything is only ennobled when it
comes in contact with art.”#footnote[Schleiermacher, #emph[Vorlesungen
über die Ästhetik], 215.] In this way, he promoted art and creativity as
vital components of human dignity.#footnote[For a discussion on the
aesthetic concept of dignity in Friedrich Schiller's work, see Rosen,
#emph[Dignity], 31. Similarities are found with Renaissance writers
whose ideas resurfaced with German idealism; see W. Norris Clarke,
#emph[The Creative Retrieval of Saint Thomas Aquinas: Essays in
Thomistic Philosophy, New and Old] (New York: Fordham University Press,
2009), 214.]

Art and dignity occupied central positions in Schleiermacher's lectures
on ethics, underscoring the connection between aesthetics and creativity
that he described in his #emph[Lectures on Aesthetics]. Specifically, he
emphasized the intrinsic value of each individual through the lens of
art. In #emph[Grundriß der philosophischen Ethik] (#emph[Outline of the
Philosophical Ethics]), he suggested that life can be viewed as a form
of art in which every action embodies expressions of creativity---an
ontological notion also found in Frank's work. Schleiermacher believed
that this creative component can be identified in the sounds and
gestures of human infants who express “the peculiar character of the
outer person … formation of the imagination shows itself early, and from
it the peculiar character of the inner person develops by which the
individual appearances are conditioned.”#footnote[Friedrich
Schleiermachers, #emph[Grundriß der philosophischen Ethik (Grundlinien
der Sittenlehre)], ed. August Twesten (Berlin: Reimer, 1841), 114, 115.]

In his #emph[Lectures on Aesthetics], Schleiermacher added interactions
among art, nature, and creativity to his description of human dignity,
linking the three elements to the divine and God's creation, and arguing
that “just as humans are creative (#emph[schöpferisch]), so God is
artistic in the creation.”#footnote[Schleiermacher, #emph[Vorlesungen
über die Ästhetik], 43.] As a romanticist, Schleiermacher gave
particular attention to the relationship between creation and art
(#emph[Schöpfung und Kunst]), believing that creation and art are
essentially intertwined components. By doing so, he elevated human
dignity, emphasizing the intrinsic value of human creativity in the
context of divine creativity. His central idea was that delight “in
divine art is always the highest destiny for humans,” thus motivating
them to act creatively. In short, Schleiermacher understood creativity
as being central to humanity, an idea that Frank also
endorsed.#footnote[Schleiermacher, #emph[Vorlesungen über die Ästhetik],
\43.]

Much like Schleiermacher, Frank addressed the relationship between human
creativity and dignity in his #emph[Reality and Man: An Essay on the
Metaphysics of Human Nature], in which he presented a refined version of
a philosophical system he had been developing for more than forty years.
To address the creative essence of humanity, Frank moved beyond
Augustine's opinions that only God can be viewed as a creator and that
no human being is capable of creating something. Specifically, while
identifying God's acts of creation as miraculous, he also described an
inherent human “creativeness” in artistic, cognitive, moral, and
political domains.#footnote[S. L. Frank, #emph[Reality and Man: An
Essay] #emph[in the] #emph[Metaphysics of Human Nature,] trans. Natalie
Duddington (London: Faber & Faber, 1965), 153.] For Frank, “all
creativeness bears an artistic stamp … in so far as \[an individual\]
strives for it and achieves it, he is an artist.”#footnote[Frank,
#emph[Reality and Man], 153--54.]

In their respective discourses on human creativity, Frank and
Schleiermacher argued that the spiritual dimension of creative
expression is an important aspect of human nature. Frank posited that an
innate artistic force drives humans to express themselves through
poetry, music, painting, and other modes. For Frank, the personification
of human creative expression had a strong spiritual feature---he wrote,
“man's inner being is spirit.”#footnote[Frank, #emph[Reality and Man,]
\154.] Frank regarded creativity as an example of “the divinely-human
nature of man,” and argued that humans engaging in creative activity
experience both freedom and a “dependence upon a transcendent spiritual
reality.”#footnote[Frank, #emph[Reality and Man], 155.] He described how
artists perceive their unique artistic nature as a manifestation of a
“super-human spirit” that is inseparable from a human metaphysical
position.#footnote[Frank, #emph[Reality and Man], 156, 160. In
#emph[Man's Soul], similarly, Frank explains that the entire “domain of
spiritual life” in relation to culture and art is a realm where human
beings instantly “experience and are conscious of the creative activity
of the human spirit.” S. L. Frank, #emph[Man's Soul:] #emph[An
Introductory Essay in Philosophical Psychology], trans. Boris Jakim
(Athens: Ohio University Press, 1993), 263.] According to Frank, even
though artists might not explicitly mention “God's action,” during
moments of artistic inspiration, it was impossible for individuals not
to encounter God as a “#emph[creative principle] and thereby as the
source of his own creativeness.”#footnote[Frank, #emph[Reality and Man],
\156.] In short, Frank believed that occurrences of creative inspiration
were made special by the distinctive connection between individuals and
“the creative power of God.”#footnote[Frank, #emph[Reality and Man],
\156.] This view has important metaphysical implications that fit with
Schleiermacher's description of God as the creative source for all
beings. Frank perceived God as “the supreme transcendent principle in
the human spirit,” who bestowed his creative power upon
humanity.#footnote[Frank, #emph[Reality and Man], 157.] In other words,
Frank's anthropological perspective implied a God who “creates
creators,” and “creates derivatively-creative beings and grants His
creatures a share in His own creativeness.”#footnote[Frank,
#emph[Reality and Man,] 156, 157.] This view underscored the uniqueness
of humanity by emphasizing God's presence in the human spirit.

Frank used this relationship between the creative and religious to
construct a model of human dignity that included an artistic
characteristic---that is, a “superhuman creative principle” in which
individuals are cognizant of their status as creators. This awareness,
which connects them to the principal sources of their artwork, supports
their participation in an enigmatic ontological “process of
creation.”#footnote[Frank believed that artists as “creators,”
understand they are made in the image and likeness of God.] Frank
declared that creative humans were “co-partner\[s\] of God's
creativeness”---a key point in his perception of human
dignity.#footnote[Frank, #emph[Reality and Man,] 156.] He viewed
intrinsic creativity as a fundamental aspect of human existence
associated with the divine, with humans actively, freely, and
consciously engaging in God's creative process rather than simply
obeying his commandments. Frank described God's will as inherently
creative rather than governed by rigid laws producing uniform outcomes,
enabling individuals channeling their creativity to express themselves
uniquely. Frank believed that human identity and dignity are grounded in
a creative collaboration with God, rather than in the execution of
divine obligations and duties.#footnote[Frank, #emph[Reality and Man,]
159#emph[.]]

Turning to Schleiermacher, a romanticist reading of the interplay
between religious art and religious emotions clearly shaped his
understanding of human dignity. His initial views reflected Romantic
aesthetics in the artistic approach to religion that he expressed in
#emph[On Religion].#footnote[Holden Kelm “Historische Einführung,” in
Friedrich Schleiermacher, #emph[Vorlesungen über die Ästhetik], ed.
Holden Kelm, KGA II/14 (Berlin: De Gruyter, 2021), xxv. Schleiermacher
declared that “#emph[religion] and #emph[art] stand beside one another
like #emph[two] friendly #emph[souls].” Friedrich Schleiermacher,
#emph[On Religion: Speeches to Its Cultured Despisers], ed. Richard
Crouter (Cambridge: Cambridge University Press, 1996), 69#emph[.]] As a
synthesis of art, religion, and human experience, this perception
conflicted with the rationalist framework of Enlightenment thinkers.
Notable parallels exist between Schleiermacher's ideas and those of the
influential early Romantic writer Wilhelm Wackenroder, especially in
their shared use of religious sentiment to explain the connection
between the arts and religion.#footnote[In #emph[On Religion],
Schleiermacher alludes to Wackenroder's work. Friedrich Schleiermacher,
#emph[Über die Religion.] #emph[Reden an die Gebildeten unter ihren
Verächtern] (1799), ed. Günter Meckenstock, KGA I/2 (Berlin: De Gruyter,
1984), 173. Albrecht Beutel, “Aufklärer höherer Ordnung? Die Bestimmung
der Religion bei Schleiermacher (1799) und Spalding (1797),” in
#emph[200 Jahre “Reden über die Religion”: Akten des 1. Internationalen
Kongresses der Schleiermacher-Gesellschaft, Halle, 14.--17. März 1999.
Anhang: Spalding, Johann Joachim. Religion, eine Angelegenheit des
Menschen. Leipzig 1797], ed. Ulrich Barth and Claus-Dieter Osthövener
(Berlin: De Gruyter, 2000), 289.] In Wackenroder's
#emph[Herzensergiessungen eines kunstliebenden Klosterbruders] (1797),
the degree of unity between art and religion is said to produce “the
most beautiful stream of life,” thus contributing to Wackenroder's
description of religion and art as “the great divine beings” serving as
the best guides for our earthly and spiritual lives.#footnote[Wilhelm
Heinrich Wackenroder, #emph[Herzensergiessungen eines kunstliebenden
Klosterbruders: Phantasien über die Kunst für Freunde der Kunst]
(Weimar: Kiepenheuer, 1918), 122, 123.] In contrast to Frank, both
Schleiermacher and Wackenroder emphasized the notion of God in their
conceptualizations of dependence, an idea that Schleiermacher reiterated
in his description of the essence of humanity.#footnote[Philip
Stoltzfus, #emph[Theology as Performance: Music, Aesthetics, and God in
Western Thought] (London: Bloomsbury, 2006), 75.] He argued in favor of
an inherent connection between human dignity and religious sentiment as
marked by an absolute reliance on the divine---that is, a strong
connection between religious spirituality and human dignity.

Schleiermacher's Romantic orientation explains both his understanding of
human identity as linked to art and the human emotions at the center of
his anthropology. While he believed that all art has its roots in human
creativity, he made distinctions between different art forms, arguing
that some serve as direct expressions of feelings, while others are
based on indirect expressions---for example, music and imitation art
(#emph[Mimik]).#footnote[Schleiermacher, #emph[Vorlesungen über die
Ästhetik], 196.] In #emph[On Religion], he referred to the “music of
sublime feelings”#footnote[Schleiermacher, #emph[On Religion], 92.] when
suggesting that music, as the language of emotion, could not be
considered separately from religion. In his #emph[Aesthetic Lectures],
he described humans as possessing “the identity of nature in an active
way, particularly modified, which expresses the unique relationship of
human being\[s\] to \[their\] kind.”#footnote[Schleiermacher,
#emph[Vorlesungen über die Ästhetik], 67.] Schleiermacher believed that
a general view of human identity could be achieved only if
#emph[Volksdifferenz] (“distinctions between people”) were eliminated.
At the same time, he acknowledged closer connections between certain
types of people or nations and greater distances between others, albeit
with fluctuations. Schleiermacher understood such “variable boundaries”
as proof that “ethnicity belongs to the essence of
art.”#footnote[Schleiermacher, #emph[Vorlesungen über die Ästhetik],
\67.]

Another example of Schleiermacher's sense of aesthetics serves as
evidence of a romanticist influence: he encouraged human beings to
explore the world around them and take on a creative role in their
relationship with nature. In his aesthetic lectures, he asserted that
humans should “gradually rise to \[become\] the master\[s\] of nature”
and become “knower\[s\] of the world.”#footnote[Schleiermacher,
#emph[Vorlesungen über die Ästhetik], 64.] Schleiermacher believed that
if this self-cultivation were realized, the result would be a human
creativity devoid of inventive influence, appearing in the form of “a
mere renewal of things” in which learning without discovery would be a
mere tradition leading to something “mechanical, where human dignity
could not manifest itself.”#footnote[Schleiermacher, #emph[Vorlesungen
über die Ästhetik], 64.] Frank's discourse on creativity resonated with
Schleiermacher's emphasis on a creative role for humanity---that is, the
fusion of scientific and philosophical ideas resulting in “the creation
of something new.”#footnote[Frank, #emph[Reality and Man], 153#emph[.]]

The concept of nature has often appeared in scholarly discussions of
creative human expression, as well as in Romantic literary productions
such as Goethe's #emph[Natur und Kunst] (#emph[Nature and
Art]).#footnote[Robert J. Richards, #emph[The Romantic Conception of
Life: Science and Philosophy in the Age of Goethe] (Chicago: University
of Chicago Press, 2002), 469--70. On Schleiermacher's reading of
Schelling, see Schleiermacher, #emph[Vorlesungen über die Ästhetik], 1.
F. W. J. Schelling, “Ueber das Verhältniß der bildenden Künste zu der
Natur” (1807), in #emph[Philosophische Schriften], vol. 1 (Landshut,
1809), 341--96.] In their respective lectures on aesthetics,
Schleiermacher and F. W. J. Schelling described an organic connection
between art and nature. Based on his belief that nature is inherently
connected to art, Schleiermacher described humans as recreating forms
that already exist in nature.#footnote[#emph[Friedrich Schleiermachers
Ästhetik. Im Auftrage der Preußischen Akademie der Wissenschaften und
der Literatur -- Archiv -- Gesellschaft zu Berlin nach den bisher
unveröffentlichten Urschriften zum ersten Male herausgegeben] #emph[von
Rudolf Odebrecht] (Berlin: De Gruyter, 1931)#emph[,] 9.] In the same
manner, Frank argued that “human creativeness in all its forms is
obviously profoundly akin to \[the\] cosmic creativeness” found in
nature.#footnote[Frank#emph[,] #emph[Reality and Man], 157.] Frank
distinguished between natural and human forms of creative power, thus
echoing Schleiermacher's view concerning the connection between nature
and human creativity, describing the first as depersonalized and the
second as marked by “a personal self-conscious
spirit.”#footnote[Frank#emph[,] #emph[Reality and Man], 157.] In his
analysis of human creativity, Frank argued that humans are conscious of
their creative actions; therefore, creativeness represents an expression
of an independent self---in short, the presence of a higher power is
what separates them from other creatures.

It is important to note that the ontological aspect of Frank's aesthetic
anthropology is aligned with Schleiermacher's belief that all humans are
creative beings. According to Frank's #emph[Reality and Man], creativity
is better viewed as an ontological rather than a mere artistic category,
with creativeness being a fundamental aspect of human nature rather than
a quality reserved for a small number of gifted artists. According to
Frank, “every human being is to some extent or potentially a creator.
Wherever the purpose of activity springs from the depths of the human
spirit, there is creativeness.”#footnote[Frank, #emph[Reality and Man],
158#emph[.]] He argued that creativity is an intrinsic part of human
identity---similar to Schleiermacher, he viewed humans as participants
“in God's creativeness.”#footnote[Frank#emph[,] #emph[Reality and Man],
157#emph[.]]

#strong[Religion and Human Dignity]

Whereas Kant promoted moral value as an essential component of human
dignity,#footnote[Rosen, #emph[Dignity], 144.] Schleiermacher endorsed
religion as its transcendental foundation. In #emph[On Religion,] he
introduced the idea that humans possess “a consciousness of God”
inherently experienced through emotions.#footnote[Schleiermacher,
#emph[Über die Religion], 119.] In his analysis of Schleiermacher's
religious philosophy, Frank paid special attention to the connection
between emotions and “religious experience alongside personal
self-consciousness with the moment of the individuality in human
life.”#footnote[Frank, “Persönlichkeit und Weltanschaung Friedrich
Schleiermachers,” 120.] Schleiermacher imagined a collective
“consciousness of humanity” entailing ethics and
education,#footnote[Friedrich Schleiermacher, #emph[Monologen (2.--) 4.
Auflage], ed#emph[.] Günter Meckenstock#emph[,] KGA 1.12 (Berlin: De
Gruyter, 1995), 342; Schleiermacher, #emph[Über die Religion], 115.]
while positing a disposition linking religion with humanity and human
dignity.#footnote[Schleiermacher, #emph[Über die Religion], 156, 24.] He
described the spiritual dimension of human dignity as rooted in a
dogmatic description of God's image. As part of his consideration of how
Christianity is most conscious of God, Schleiermacher emphasized how the
first Christians saw “the outlines of the divine image” in humanity and
a hidden “heavenly germ of religion,” despite the distortions of this
image.#footnote[Schleiermacher, #emph[Über die Religion], 287.] While
agreeing with Augustine's assertion that the image of the divine is
greatly tarnished in human nature,#footnote[Schleiermacher, #emph[Über
die Religion], 285, 287.] he also maintained that traces of the original
(though distorted) images were observable, and that humanity had always
possessed “a divine character.”#footnote[Schleiermacher, #emph[Über die
Religion], 115.] He used this idea to promote religious sentiment as an
essential aspect of the human experience, one in which the idea of
dependence occupied a central position among religious emotions. Similar
to other Romanticists, he deemed the presence of the divine as an
essential aspect of human identity.#footnote[Schleiermacher, #emph[Über
die Religion], 121.]

Unlike Kant, both Frank and Schleiermacher used a religious foundation
to address human dignity. In a treatise entitled #emph[God with Us]
(written during his exile in France due to political and religious
oppression), Frank expressed great interest in the idea of “the religion
of personality.”#footnote[S. L. Frank, #emph[God with Us: Three
Meditations], trans. Natalie Duddington (London: Jonathan Cape, 1946),
\140.] In the foreword to the first edition, he wrote, “I am concerned
with showing that the fundamental truths of the religious, and,
particularly, of the Christian consciousness answer the eternal
questions inherent in the very nature of the human
spirit.”#footnote[Frank, #emph[God with Us], 11.] The text shows a clear
preference for an understanding of anthropology that favors Christian
over Enlightenment values, especially in his understanding of human
personality and the soul. When critiquing the assumptions of the German
philosopher Ludwig Feuerbach's anthropological approach, Frank clearly
agreed with the early church father Tertullian in his description of the
human soul as inherently Christian.#footnote[Frank, #emph[God with Us],
138--39.] For Frank, Christianity is an “adequate and perfect expression
of this direct insight into the ontological basis of human
existence.”#footnote[Frank, #emph[God with Us], 139.] His views on
personality could not be separated from the core tenets of the Christian
faith, or insights derived from Christian revelation.#footnote[Frank,
#emph[God with Us], 140.]

Frank's formulation of human dignity extended beyond secular humanism.
When discussing humans and characteristics of God in their likeness, he
emphasized a Christian interpretation of the concept of dignity,
describing it as an “#emph[organic connection] between God and
man.”#footnote[Frank#emph[,] #emph[God with Us], 154.] He believed the
“divine likeness” of human beings and their affinity with God were “in a
sense the very essence of Christianity.”#footnote[Frank#emph[,]
#emph[God with Us], 152.] Frank traced this notion of likeness to the
Old Testament, which he incorporated into his understanding of human
creation and dignity. In his analysis of Genesis 1:26--28, he described
humans as set apart from “the rest of creation,” arguing that the source
of the distinction was the idea that “human life is the spirit of God.”
He claimed that their likeness to God elevated humans to “a higher
order” that set them apart “from all other \[beings\].”#footnote[Frank,
#emph[God with Us], 152.] In an 1817 sermon, Schleiermacher alluded to
Genesis 1:26 when proposing that human beings are “the actual goal and
end of creation,” thus portraying them as “lord\[s\] over all things,”
and asserting that individuals display God's image as far as
possible.#footnote[Friedrich Schleiermacher, #emph[Predigten,
1816--1819], KGA III/5, ed. Katja Kretschmar (Berlin: De Gruyter, 2014),
\314.]

Similar to Schleiermacher, Frank analyzed the importance of God's image
in relation to humanity in terms of “the revelation of Christ,” which
served as a vital basis for cultivating a new
consciousness.#footnote[Frank, #emph[God with Us], 154.] Frank's concept
of dignity, as expressed in #emph[God with Us], echoes Schleiermacher's
statement that the image of God is revealed in Christ. This
Christological interpretation underscores Frank's emphasis on God's love
for humans and God's kingdom as the dwelling place for the human soul.
In support of this argument, he pointed to the organic fusion of the Old
Testament view of human dependence on God with the Hellenistic ideas of
human “dignity” and “kinship with God.” Frank believed these two
positions converged in the notion of love defining the relationship
between God and humans---“that God himself is love.” Frank posited that
this “divine principle of love is the very root of human existence,” one
that added existential meaning to human dignity.#footnote[Frank,
#emph[God with Us], 155.]

Much more so than Schleiermacher, Frank took great care in explaining
how “the divine-human ground of human existence” injected new dignity
into humanity.#footnote[S. L. Frank, #emph[The Light Shineth in
Darkness: An Essay in Christian Ethics and Social Philosophy], trans.
Boris Jakim (Athens: Ohio University Press, 1989), 63.] He clearly
wanted this emphasis on the divine-human connection to move beyond a
simple anthropocentric understanding of human identity, and sought to
highlight the profound significance of the good news of the gospel,
which he believed added a new dimension to human dignity. In this
context, Frank highlighted Schleiermacher's idea of “religious
experience” over dogmatic theory, suggesting that the significance of
this preference stems from the sense of the good news that transforms
all human feelings and self-awareness. Frank concluded that every human
being, even those who are utterly sinful, is God's child, “born from
above” and “from God.” Citing Acts 17:28, Frank echoed Paul's assertion
that “we are ... his offspring” to suggest a new relationship between
God and humanity,#footnote[Frank, #emph[The Light Shineth in Darkness],
\63.] and described “God ... the Father \[as\] the inner foundation of
our own being.”#footnote[Frank, #emph[The] #emph[Light Shineth in
Darkness], 63--64.] Frank clearly believed that the fundamental nature
of human existence did not depend on a dualistic view of “separateness
and heterogeneity between God and man,” but on “#emph[kinship, unity],
\[and\] the #emph[unbreakable connection] of God and
man.”#footnote[Frank, #emph[The] #emph[Light Shineth in Darkness], 64.]
Frank felt it was essential to demonstrate the perpetual grounding of
human existence in the “#emph[Divine-human being].”#footnote[Frank,
#emph[The] #emph[Light Shineth in Darkness], 64.]

#strong[Human Dignity and Individuality]

One characteristic of Schleiermacher's description of humanity is a
strong connection between human dignity and
individuality.#footnote[Frank's analysis underscores that
Schleiermacher's foundational belief is that individuality represents
the unique characteristics of each human being. Frank, “Persönlichkeit
und Weltanschaung Friedrich Schleiermachers,” 120.] An example of the
transition from an older honor culture to a modern dignity concept is
Schleiermacher's view that all individuals are indispensable for
achieving a complete understanding of humanity. According to his
understanding of personhood, “All that is human is interwoven and made
dependent on each other ... every individual is, according to its inner
nature, a necessary harmonizing piece for the perfect view of
humanity.”#footnote[Schleiermacher, #emph[Über die Religion], 98.] He
also emphasized the influential roles that all individuals play in the
human tapestry, thus articulating the centrality of dignity in human
relationships.#footnote[A similar view can be seen in Martin Luther.
Bayer, “Martin Luther's Conception of Human Dignity,” 103.] However, in
his University of Berlin lectures on ethics, he stated that it was
important to acknowledge the differences contributing to each person's
uniqueness. In agreement with Romanticist principles, Schleiermacher
identified “human originality” as the agent of human
dignity,#footnote[Christian König, #emph[Unendlich gebildet
Schleiermachers kritischer Religionsbegriff und seine inklusivistische
Religionstheologie anhand der Erstauflage der Reden], Collegium
Metaphysicum 16 (Tübingen: Mohr Siebeck, 2016), 234. Schleiermacher,
#emph[Über die Religion], 18.] and described diversity as fundamental to
a sense of human completeness.#footnote[#emph[Friedrich Schleiermachers]
#emph[Grundriß der philosophischen Ethik] (Berlin: Reimer, 1841), 84.]
In his depiction of a framework in which the duality of individuality
and relationality could be acknowledged, Schleiermacher described
personal identity as constructed according to a mix of isolation and
engagement, resulting in human differences that complemented each
other.#footnote[#emph[Friedrich Schleiermachers] #emph[Grundriß der
philosophischen Ethik], 84--85.] His emphasis on the significance of all
individuals within a collective identity honored both personal and
communal moral dimensions.

Although Frank also acknowledged the uniqueness of individuals, he
observed a shared effort toward “the attainment of perfection and purity
of the inner life.” Rather than describe this pursuit as an example of a
collective ideal of human perfection, he argued that “everyone must have
\[his\] own special perfection.”#footnote[Frank, #emph[God with Us],
\143.] In explaining his belief in a “personalistic religion,” Frank
noted that while Christianity focuses on the significance of personal
ethical experiences, it prioritizes human personality over strict moral
rules. Unlike Kant, whose views on dignity were heavily focused on
morality, Frank's Christian understanding influenced his conclusion that
in matters of dignity, the real “human being is more valuable to it than
the principles of moral goodness.”#footnote[Frank, #emph[God with Us],
144#emph[.] Swoboda notes that “Frank's thinking about human dignity and
self-realisation can be described as ‘expressivist humanism', in the
sense that Frank came to believe that the moral task of each individual
was to develop his own unique spiritual individuality and that he
generally rejected abstract rules of conduct.” Swoboda, “Semën Frank's
Expressivist Humanism,” 212.]

Also, unlike Kant, who understood personhood itself as “morally
foundational,”#footnote[Rosen, #emph[Dignity], 81; cf. Kant,
#emph[Groundwork of the Metaphysics of Morals], 4: 428.] Frank and
Schleiermacher took salvation into consideration when embracing the idea
of human value. Frank mentioned Martin Luther but not Schleiermacher in
his discussion of personality, which is interesting in light of their
shared emphasis on the importance of Christ's salvific work, which
offers release from the demands of perfect and absolute
morality.#footnote[Frank, #emph[God with Us], 144, 147#emph[.]] For
Frank, since Christian consciousness takes precedence over the
moral,#footnote[Frank, #emph[God with Us], 148#emph[.]] human dignity
should not be based on moral value alone. Schleiermacher connected
salvation with “Christian consciousness”#footnote[Friedrich
Schleiermacher#emph[,] #emph[Predigten: Fünfte bis Siebente Sammlung
(1826--1833)], ed. Günter Meckenstock, KGA III/2 (Berlin: De Gruyter,
2015), 444.] in the form of an “inner consciousness of God” in human
beings.#footnote[Schleiermacher, #emph[Predigten: Fünfte bis Siebente
Sammlung], 325.] In positing that all individuals possess a religious
consciousness linked to Christ, Schleiermacher expressed an intrinsic
sense of connection between God and human dignity---a view that Frank
shared.

#strong[Human Dignity and Self-Consciousness]

#emph[Vorlesungen über die Dialektik], Schleiermacher's collection of
lectures on dialectics that served as the foundation for his
philosophical system, provides insights into his understanding of human
dignity. He used the concept of self-consciousness to position human
dignity as part of human nature, emphasizing a religious rather than
moral approach to dignity, and arguing that “the presentation of the
deity in analogy to the human consciousness cannot be avoided, because
one must take the view of religious self-consciousness as \[the\] only
way possible.”#footnote[Friedrich Schleiermacher#emph[, Vorlesungen über
die Dialektik], ed. Andreas Arndt, KGA 2.10.1 (Berlin: De Gruyter,
2002), 573.] Schleiermacher differed from Kant in asserting that
“transcendent determination of self-consciousness now is the religious
side of it or the religious feeling, and in this, therefore, the
transcendent ground or the highest being itself is
represented.”#footnote[Schleiermacher#emph[, Vorlesungen über die
Dialektik], 572#emph[.]] He felt it was essential to connect this
feeling to our consciousness of God because he believed that religious
feeling represented an absolute consciousness in human
beings.#footnote[Schleiermacher#emph[, Vorlesungen über die Dialektik],
267#emph[.]]

Frank likewise connected human dignity to human self-consciousness. He
knew that Schleiermacher had recognized “the mature human consciousness
of the nineteenth century that transcended the rationalism of the
eighteenth century, acknowledged its religious elements, and penetrated
into the intellectual heritage of European culture.”#footnote[Frank,
“Persönlichkeit und Weltanschauung Friedrich Schleiermachers,” 102.] In
his work Frank highlighted what he called “the new human
self-consciousness” emerging from the good news of the gospel, which he
described as providing meaning and security for human existence, and as
giving humans their status as spiritual beings.#footnote[Frank,
#emph[The] #emph[Light Shineth in Darkness], 65#emph[.]] He linked God's
“image and likeness” rooted in the Old Testament tradition with a
Pauline understanding of God's revelation of the divine spirit (1 Cor.
2:10). Accordingly, he believed that human existence possesses a
spiritual dimension in the sense of a secure grounding “in the holy
primordial source of being.”#footnote[Frank, #emph[The] #emph[Light
Shineth in Darkness], 65#emph[.]] In his perception of humans, Frank
characterized them as supernatural beings whose existence depends on
God. He argued that a revelation in Christ offered insights into what
constitutes a person, thus helping individuals understand their inner
being.

According to Frank, the personhood concept was established in the later
stages of the development of Christianity and is not found in the Old
Testament or other Old World texts.#footnote[For a study on S. L. Frank
and personhood, see Randall A. Poole, “‘The Kingdom of Spirits': Semyon
Frank and Russian Religious Personalism,” #emph[Northwestern University
Studies in Russian Philosophy, Literature, and Religious Thought] 1
(2024): 244--65.] For Frank, the most profound meaning of the good news
idea was based on “ontologically grounded roots of \[humans\] as
persons,” denoting “a wholly new consciousness of
dignity.”#footnote[Frank, #emph[The] #emph[Light Shineth in Darkness],
65#emph[.]] This argument shares similarities with Schleiermacher's
understanding of human identity, which suggested self-consciousness
based on an assumption of a “communion of life with
Christ.”#footnote[Schleiermacher, #emph[Predigten. Fünfte bis Siebente
Sammlung], 165.] However, for Schleiermacher, a deep association existed
between self-consciousness and “absolute dependence”---an expression
that Frank did not embrace.#footnote[Peter Ehlen, #emph[Russische
Religionsphilosophie im 20. Jahrhundert:] #emph[Simon L. Frank. Das
Gottmenschliche des Menschen] (Munich: Karl Alber, 2009), 53.]
Schleiermacher elaborated on the idea in his #emph[Christian Faith],
indicating continuity with his earlier Romantic views and
Pietism#emph[.] Based on his understanding of religious
self-consciousness, Schleiermacher stressed the idea of absolute
dependence in his theory of religion, especially as regards the human
person. In his words, “If the feeling of absolute dependence, expressing
itself as consciousness of God, is the highest grade of immediate
self-consciousness, it is also an essential element of human
nature.”#footnote[Friedrich Schleiermacher, #emph[The Christian Faith],
trans. H. R. Mackintosh and J. S. Steward (Edinburgh: T. & T. Clark,
1928), 26.] Since for Schleiermacher religious self-consciousness was an
innate predisposition of the human soul,#footnote[Schleiermacher,
#emph[The Christian Faith], 22.] one of his central concerns was showing
“that piety is of the essence of human nature,” based on his view that
the human soul is inherently inclined toward both “knowledge of the
world ... \[and\] consciousness of God.”#footnote[Schleiermacher,
#emph[The Christian Faith], 171.]

As expressed in his #emph[Christian Faith], Schleiermacher's
anthropology reflected a Romanticist perception of absolute dependence,
with all individuals aware of a subjective feeling “first awakened in
\[them\] in the same way, by the communicative and stimulative power of
expression or utterance.”#footnote[Schleiermacher, #emph[The Christian
Faith], 26.] Although he considered such feelings individual, he also
believed they contained a collective element, which explains his
argument that this core component of human nature is best understood as
a communal experience. His view of dignity included a collective
awareness of religious self-consciousness built on a universal “feeling
of absolute dependence,” rooted in unconditional and universal human
nature. Schleiermacher believed this universal nature “contains in
itself the potentiality of all those differences by which the particular
content of the individual personality is
determined.”#footnote[Schleiermacher, #emph[The Christian Faith], 134.]
Whereas Schleiermacher described human awareness as a dependent and
innately religious concept, Frank portrayed human self-consciousness in
terms of a “primordial connection and interwovenness with God”---in
other words, the presence of God in the nature of human
beings.#footnote[Frank, #emph[The] #emph[Light Shineth in Darkness],
66--67#emph[.]] As Frank saw it, human beings are from the beginning
associated with God and “are so organically and inseparably interwoven
with Him that #emph[we are in Him and He is in us.]”#footnote[Frank,
#emph[The] #emph[Light Shineth in Darkness], 64.]

Frank's description of religious consciousness in #emph[The Light
Shineth in Darkness] is similar to Schleiermacher's image of religious
feelings tied to human awareness of God. According to Frank, “the idea
of the all-powerfulness of God is given wholly immediately and with
utter self-evidence in religious experience”#footnote[Frank, #emph[The]
#emph[Light Shineth in Darkness], 41.]---that is, a profound connection
between humanity and God in which “a higher power flows into and acts in
the world through the invisible depths of the human
heart.”#footnote[Frank, #emph[The] #emph[Light Shineth in Darkness],
44#emph[.]] Frank recognized the centrality of this idea in
Schleiermacher's #emph[On Religion],#footnote[Frank, “Persönlichkeit und
Weltanschaung Friedrich Schleiermachers,” 111, 102.] especially the way
in which that feeling was portrayed as a principal component of
religion---in Frank's words, a “primary unity” marked by a “feeling of
harmony.”#footnote[Boobbyer, #emph[S. L. Frank: The Life and Work of a
Russian Philosopher], 79.]

#strong[Human Dignity and the Human Soul]

There is no universal, pan-religion definition of “soul” regarding
dignity, beyond a recognition of the existence of a “nonempirical
spiritual substance in human beings.”#footnote[Matthew Petrusek and
Jonathan Rotchild, #emph[Value and Vulnerability: An Interfaith Dialogue
on Human Dignity] (Notre Dame: University of Notre Dame Press, 2020),
\11.] In #emph[On Religion], Schleiermacher referred to “the condition
of the pious excitement of the soul.”#footnote[Schleiermacher,
#emph[Über die Religion], 147.] Arguing that religion originates with
the
soul,#footnote[Martin Redeker, #emph[Schleiermacher: Life and Thought], trans. John Wallhauser (Philadelphia: Fortress, 1973), 35.]
he described “holy souls” as always being “penetrated by the glow of
religion” under “the direct influence of the
Deity.”#footnote[Schleiermacher, #emph[Über die Religion], 212, 283.] In
the second speech of this collection, he expressed his view that all
human feelings are found in the human soul.#footnote[Schleiermacher,
#emph[Über die Religion], 143.]

Frank's understanding of the soul in his later writings, such as
#emph[Reality and Man], is firmly grounded in theological rather than
philosophical principles. The mystical religious sources that Frank
applied help to explain his criticism of Nietzsche's rejection of God's
transcendence in the human soul.#footnote[Frank, #emph[Reality and Man],
\129.] Frank's appreciation of “mystical experience” and “the presence
of the deity in the human soul” fit with Schleiermacher's description of
the presence of God in the soul.#footnote[Frank, #emph[Reality and Man],
\141.] Frank was clearly referring to Christian doctrine and New
Testament beliefs regarding the human soul when asserting the living
presence of Christ in humans.#footnote[Frank, #emph[Reality and Man],
\140.] He believed that the soul, “as a reality revealing itself … as
the inmost depth of being” indicates that “God is immanent and dwells
‘in me', while remaining distinct from me.”#footnote[Frank,
#emph[Reality and Man], 144.] Frank's understanding of the relationship
between the soul and God took two forms: as God's presence in humans,
and as rooted in Him. In other words, Frank believed that “God as a
reality” transcended humans as an intrinsic essence of their very
existence.#footnote[Frank, #emph[Reality and Man], 144.]

In the context of his discussion of the soul serving as an “eternal
homeland,” and of suffering as inherent in our human experience, Frank
wrote of the importance of the kingdom of God.#footnote[Frank,
#emph[The] #emph[Light Shineth in Darkness], 58.] He believed that
humans were aware of their status as “homeless wanderers.” His view of
human nature entailed a “contemporary metaphysical feeling based on
unfaith \[existing\] in the consciousness of our utter
desolation.”#footnote[Frank, #emph[The] #emph[Light Shineth in
Darkness], 59, 60.] He perceived this collective sense of desolation as
shaping human identity and understood the message of God's kingdom as a
longed-for “eternal homeland” as offering a foundation for human
transformation. Accordingly, he believed that the kingdom of God was an
“already attained (or rather the eternally present) possession of
man---namely, the homeland of his soul.”#footnote[Frank, #emph[The]
#emph[Light Shineth in Darkness], 60.] In alignment with the Platonist
tradition of philosophy, Frank adopted the idea of “the homeland,” a
notion that Schleiermacher never specifically expressed. Frank also used
this image in his work #emph[The Unknowable: An Ontological Introduction
to the Philosophy of Religion],#footnote[S. L. Frank#emph[, The
Unknowable: An] #emph[Ontological Introduction to the Philosophy of
Religion], trans. Boris Jakim (Athens: Ohio University Press, 1983),
\192.] and discussed self-consciousness and self-realization in Man's
Soul to suggest that the internal soul must be perceived in light of
“its return to \[a\] ‘heavenly homeland.'”#footnote[Frank, #emph[Man's
Soul], 223.]

This gospel element Frank considers to coincide with Plato's teaching of
“the ideal world, of heavenly being as the true homeland of the human
soul.”#footnote[Frank, #emph[The] #emph[Light Shineth in Darkness], 62.]
However, Frank moved beyond this Platonic explanation when emphasizing
the distinction between “the religious spirit of Platonism and the good
news of Christ”: the first expresses “a closed aristocratic character,”
while the second is “freely accessible to every human
soul.”#footnote[Frank, #emph[The] #emph[Light Shineth in Darkness], 62.]
Frank viewed Christ's revelation as offering shared ownership of God's
kingdom “to every human soul that seeks it.”#footnote[Frank, #emph[The]
#emph[Light Shineth in Darkness], 62.] Frank drew on Matthew 11:25 when
stating that all human souls eventually find themselves in “inviolable
nearness to the heavenly Father … in whose image and likeness it is
created.”#footnote[Frank, #emph[The] #emph[Light Shineth in Darkness],
\62.] He contended that this understanding of the good news of Christ
and the kingdom of God was directly related to human dignity as shaped
by their affinity with God.#footnote[Frank, #emph[The] #emph[Light
Shineth in Darkness], 66.]

When discussing what he felt were the superior characteristics of
Christianity, Schleiermacher mentioned activities of the soul in the
context of aesthetic religions, offering a unique view involving “a
peculiar form of inward beauty” in humans. He added detail to this idea
in #emph[Christian Faith], asserting that in Christianity, God's
consciousness---as it exists in the human soul---“is always related to
the totality of active states in the idea of a Kingdom of
God.”#footnote[For Schleiermacher, the essential Christian concept of
God's kingdom states that fundamental life experiences are only
considered religious when associated with piety and God's kingdom.
Schleiermacher, #emph[The Christian Faith], 43.] He used this premise to
critique the notion of the beauty of the soul, which he viewed as formed
by natural and worldly influences that were unrelated to
Christianity.#footnote[Schleiermacher, #emph[The Christian Faith], 43.]
In this work, he analyzed the human soul in a dogmatic context,
describing it as inherently inclined to seek both an understanding of
the world and a connection with a consciousness of
God.#footnote[Schleiermacher, #emph[The Christian Faith], 171.] Further,
he discussed sensible self-awareness of the soul in relation to an
“uninterrupted sequence of religious emotions” connected to a
consciousness of God in human beings. He maintained that “a religious
soul laments over a moment of his life which is quite empty of the
consciousness of God,”#footnote[Schleiermacher, #emph[The Christian
Faith], 24.] associating this consciousness with a “feeling of absolute
dependence” that varied in intensity. He acknowledged that “there will
naturally be moments in which a man is not directly and definitely
conscious of such a feeling at all.”#footnote[Schleiermacher, #emph[The
Christian Faith], 25.]

To maintain consistency in his theological methodology, which was
centered on Christian self-consciousness, Schleiermacher considered
awareness of sin in light of the human soul and recognition of “the
personal self-consciousness which attests \[to\] an inner state as
sin.”#footnote[Schleiermacher, #emph[The Christian Faith], 271.]
According to Schleiermacher, the absence of this consciousness would
constitute an “additional sin.” He was convinced that “the consciousness
of sin never exists in the soul of the Christian without the
consciousness of the power of redemption”#footnote[Schleiermacher,
#emph[The Christian Faith], 272.]---a belief that aligned with his
perception of sin and grace as interwoven.#footnote[Schleiermacher,
#emph[The Christian Faith], 265--66. For a fuller treatment, see Annette
G. Aubert, #emph[The German Roots of Nineteenth-Century American
Theology] (New York: Oxford University Press, 2013), 49.]

#strong[Conclusion]

This article makes a contribution to efforts to position Russian ideas
within a broader comparative context, specifically by demonstrating how
German theological texts contributed to the transfer of ideas to Russian
scholars. Frank's work in translating Schleiermacher's #emph[On
Religion] and #emph[Monologues] was an important influence on his later
ideas. Even though Frank did not directly mention Schleiermacher in his
later writings, he did engage with Schleiermacher's views on human
consciousness and religious feelings, views that influenced his own
interpretations of religious experience and intuition that underscored
human dignity and God-consciousness. Similar to Schleiermacher, Frank
synthesized ideas in a post-Enlightenment environment in which he
combined his religious philosophical positions with Neo-Platonism when
analyzing Schleiermacher's work. Frank synthesized ideas in a
post-Enlightenment context, blending his own religious-philosophical
views with insights drawn from Schleiermacher's work. His conclusion was
that despite the limitations of “Schleiermacher's ideas, his living
consciousness, which in the religious and moral sphere connects
subjectivism and objectivism, individualism and universalism, offers a
greater wisdom of life and is closer to the ideal of an all-encompassing
worldview than the doctrines of more consistent
thinkers.”#footnote[Frank, “Persönlichkeit und Weltanschaung Friedrich
Schleiermachers,” 128.]

Schleiermacher's concept of human dignity arose from his subjective
religious and anthropological views, his Romantic-Pietistic
understanding of dignity, and his assumptions of humans' aesthetic
capacity---a capacity associated with the feeling of absolute dependence
(on God). While Frank did not adopt Schleiermacher's notion of absolute
dependence, both Frank and Schleiermacher included notions of creation
and art into their human dignity analyses. An important idea found in
the work of both is that creativity is an essential part of human
existence and dignity, with creativity serving a central role in human
efforts to imitate God. Both Schleiermacher and Frank emphasized the
significance of God's image in relation to humanity, and asserted that
this image is ultimately revealed to human beings through Christ, who
serves as a fundamental foundation for a new consciousness of human
dignity.

Though they did their work during different periods in the modern era,
both Schleiermacher and Frank responded to Enlightenment ideals by
underscoring the spiritual aspects of human dignity, shifting the focus
away from moral values to religious (especially Christian)
consciousness, which they felt was essential to the concept of human
dignity. Schleiermacher and Frank came from different intellectual and
geographic backgrounds, but their shared religious foundation and
worldview were essential to their views on human dignity. While Frank's
connections with Eastern Orthodoxy#footnote[Swoboda, “‘Spiritual Life,'”
\235.] and German Idealism are important to understanding his
anthropology, his intellectual affinity with Schleiermacher is evident
in his views linking religion with human dignity.
<end-of-aubert>
