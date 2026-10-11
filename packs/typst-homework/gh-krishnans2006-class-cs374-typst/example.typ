#import "template.typ": *

#show: template

#let fig-dir = "fig"

#problem(
  1,
  2,
  authors: (
    ("Violet Baudelaire", "vbeaudel"),
    ("Friday Caliban", "fcaliban"),
    ("Duncan Quagmire", "dquagmir"),
  ),
)[
  #solution[
    These are, without exception, inappropriate inquiries, a phrase which here means “all the wrong questions”. Here are the questions you should have asked instead:

    + Why would someone say something was stolen when it was never theirs to begin with?

    + How could someone who was missing be in two places at once?

    + Why would someone destroy one building when they really wanted to destroy another?
  ]

  #solution[
    Pietrisycamollaviadelrechiotemexity!
  ]

  #sources[
    Sunny Baudelaire, Thursday Caliban, Isadora Quagmire, The Henchperson of Indeterminate Gender, Lemony Snickett
  ]
]

#problem(
  1,
  1,
  authors: (
    ("Marceline Abadeer", "vampireq"),
    ("Finn Mertens", "thehuman"),
    ("Simon Petrikov", "iceking"),
  ),
)[
  #solution(by: "R. Rotten", qed: false)[
    Alright! I can see that I will have to teach you how to be _villains!_

    + Now listen closely. Here's a little lesson in trickery. This is going down in history.
      If you wanna be a Villain Number One, you have to chase a superhero on the run. Just follow my moves, and $""^("sneak")$ around. Be careful not to make a sound!
      Shh! No, don't touch that!

      $ italic("We") = hash 1^("Hey!") $

      #sources[
        Glanni Glæpur, Íþróttaálfurinn, #link("https://genius.com/Lazy-town-we-are-number-one-lyrics")[Genius Lyrics]
      ]

    + #algo[
        #ul[#sc[HaHaHa]\(_net_\):] #indent \
        $italic("net.found") <- italic("now")$ \
        #sc[LookAt]$(italic("net"))$ \
        in parallel: #indent \
        for $i <- 1$ to $100$ #indent \
        if $italic("said_go") =$#sc[True] #indent \
        $italic("net.ReadyToThrow") <-$#sc[True] #outdent #outdent \
        $italic("said_go") <- "True"$ #outdent \
        if $italic("net.ReadyToThrow")$ #indent \
        #sc[Throw]$(italic("net"), italic("him"), not italic("me"))$ #outdent \
        #sc[Try]$(italic("banana").italic("peel"))$ #outdent \
      ]

      #algo[
        #ul[#sc[Try]\(somethingelse\):] #indent \
        #sc[Watch]$()$ \
        #sc[Learn]$()$ \
        $italic("deal.location") <- italic("here")$ \
        return #sc[Slip]$(italic("somethingelse")) and$ #sc[Slide]$(italic("somethingelse"))$ \
      ]

      #sc[HaHaHa]$(italic("Gasp!"))$ What are you _doing!?_

      #sources[
        - Bonnibel “Stephanie” Bubblegum; Prismo
        - Ἐπίκτητος, _Enchiridion_, Chapter 13
      ]

      #colbreak()

    + Ba-ba-biddly-ba-ba-ba-ba, ba-ba-ba-ba-ba-ba-ba, we are number one. Hey! \
      Ba-ba-biddly-ba-ba-ba-ba, ba-ba-ba-ba-ba-ba-ba, *VILLAIN NUMBER ONE!*

      #sources[
        anbb, Alva Noto, and Blixa Bargeld, _Mimikry_, track 3.
      ]

    + Ba-ba-biddly-ba-ba-ba-ba, ba-ba-ba-ba-ba-ba-ba, we are number one. Hey! \
      Ba-ba-biddly-ba-ba-ba-ba, ba-ba-ba-ba-ba-ba-ba, we are number one. Hey! \
      We are number one, hey! We are number one! We are number one! Hey! Hey!

      #sources[
        They Might be Giants, _They Might be Giants_, track 3.
      ]
  ]
]

#problem(
  1,
  3,
  authors: (
    ("Anathema Device", "anathema"),
    ("Newton Pulsifer", "newt"),
    ("Adam Young", "ntchrist"),
  ),
)[
  #solution[
    Let $n$ be an arbitrary non-negative integer. There are four cases to consider:
    - Makin’ pancakes, makin’ bacon pancakes
    - Make some bacon and I put it in a pancake
    - Bacon pancakes, that’s what it’s gonna make
    - #block(width: 100%)[
        #box(baseline: 50%, width: 12%, scale(x: -100%, reflow: true)[#image(fig-dir + "/datboi.png", width: 100%)])
        #box(baseline: 50%, width: 66%, image(fig-dir + "/pancakes2.pdf", width: 100%))
        #box(baseline: 50%, width: 12%, image(fig-dir + "/datboi.png", width: 100%))
      ]

    O shit waddup
  ]

  #sources[
    - Jake the Dog, Harry Dweighter, Prismo, and Dat Boi.
    - “Is That You?”, _Adventure Time_, Season 6, Episode 19, 2014.
    - #link("https://sephardicu.com/midrash/frog-or-frogs/")[Midrash on Exodus 8:2]
  ]
]
