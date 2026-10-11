#let cover-page(client-name, date) = [
    #set page(
    margin: 2cm,
    )

    #align(center)[

    // BOŞLUK
    #v(20%)

    // LOGO
    #image("images/caglansec_logo_5.png", width: 7cm)

    #v(0.6cm)

    // İnce ayırıcı çizgi
    #line(length: 30%, stroke: (paint: rgb("#0021FF"), thickness: 1pt))

    #v(2cm)


    #text(size: 24pt, weight: "bold")[#client-name]

    #text(size: 24pt, weight: "bold")[Smart Contract Security Review]

    #v(4cm)

    // Alt bilgi ile başlık arasında çizgi
    #line(length: 30%, stroke: (paint: gray, thickness: 0.5pt))

    #v(0.8cm)

    #text(size: 12pt)[
      **Date:** #date
    ]

    #v(0.8cm)

    #line(length: 30%, stroke: (paint: gray, thickness: 0.5pt))

    #v(2cm)

    // Gizlilik ibaresi (opsiyonel ama profesyonel durur)
    #text(size: 10pt, style: "italic", fill: gray)[
        © 2025 caglansec — Confidential
    ]
    ]

        #align(bottom)[
        #text(size: 10pt, style: "italic")[
            Visit: https://caglansec.xyz
        ]
    ]
]
