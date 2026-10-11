#let MAIN_FONT = "FreeSerif"
#let HEADER_TEXT_SIZE = 30pt
#let NORMAL_TEXT_SIZE = 18pt
#let SMALL_TEXT_SIZE = 12pt

#set page(margin: 10pt)
#show text: it => { smallcaps(it) }
#set text(size: NORMAL_TEXT_SIZE, font: MAIN_FONT)

#v(2cm)
#block(width: 100%)[
    #set align(center + horizon)

    #stack(
        dir: ltr,
        spacing: 4pt,
        box[#line(length: 3cm)],
        box[#text(size: HEADER_TEXT_SIZE)[
            #show par: set block(spacing: 0pt)
            *_Yahtzee!_*

            ⚀ ⚁ ⚂ ⚃ ⚄
        ]],
        box[#line(length: 3cm)],
    )
]

#set align(center + horizon)
#block[
    #table(
        columns: (auto, 2pt, 1fr),
        rows: (
            auto,
            2pt,
            auto,
            auto,
            auto,
            auto,
            auto,
            auto,
            auto,
            2pt,
            auto,
            auto,
            auto,
            auto,
            auto,
            auto,
            auto,
            auto,
            2pt,
            auto
        ),
        inset: 10pt,
        align: left + horizon,

        [*Player*], [], [],
        [], [], [],
        [*1s*], [], [],
        [*2s*], [], [],
        [*3s*], [], [],
        [*4s*], [], [],
        [*5s*], [], [],
        [*6s*], [], [],
        [
            *Bonus _+35_ \
            #text(size: SMALL_TEXT_SIZE)[(if sum > 63)]*
        ], [], [],
        [], [], [],
        [*Sum*], [], [],
        [*3 of a Kind*], [], [],
        [*4 of a Kind*], [], [],
        [*Full House (_25_)*], [], [],
        [*Small Straight (_30_)*], [], [],
        [*Large Straight (_40_)*], [], [],
        [*Yahtzee! (_50_)*], [], [],
        [
            *Bonus Yahtzee! _+50_ \
            #text(size: SMALL_TEXT_SIZE)[(if Yahtzee!)]*
        ], [], [],
        [], [], [],
        [*Total*], [], [],
    )
]
