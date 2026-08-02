#let ppi = 600
#let to-pt(value) = value * 72pt / ppi

#let layout = (
    card-size: (width: to-pt(1394), height: to-pt(2031)),
    image: (
        pos: (
            normal: (x: to-pt(169), y: to-pt(376)),
            pendulum: (x: to-pt(95), y: to-pt(365)),
        ),
        size: (
            normal: (width: to-pt(1055), height: to-pt(1053)),
            pendulum: (
                width: to-pt(1205),
                tall-height: to-pt(1546),
                short-height: to-pt(900),
            ),
        ),
    ),
    attribute-pos: (
        x: to-pt(1166),
        y: to-pt(98),
    ),
    name-area: (
        start: (x: to-pt(100), y: to-pt(100)),
        end: (x: to-pt(1160), y: to-pt(225)),
    ),
    scale-area: (
        x: (left: to-pt(100), right: to-pt(1202)),
        y: to-pt(1386),
    ),
    password-pos: (
        x: to-pt(66),
        y: to-pt(1910),
    ),
    race-pos: (
        x: (
            with-icon: to-pt(850),
            without-icon: to-pt(890),
        ),
        y: to-pt(245),
    ),
    star-pos: (
        x: (
            up-to-twelve: (
                to-pt(148),
                to-pt(238),
                to-pt(332),
                to-pt(424),
                to-pt(515),
                to-pt(608),
                to-pt(700),
                to-pt(791),
                to-pt(884),
                to-pt(976),
                to-pt(1067),
                to-pt(1160),
            ),
            over-twelve: (
                start: to-pt(100),
                end: to-pt(1280),
            ),
        ),
        y: to-pt(249),
    ),
    bar-pos: (
        x: to-pt(106),
        y: to-pt(1848),
    ),
    atk-pos: (
        x: to-pt(870),
        y: to-pt(1856),
    ),
    def-pos: (
        x: to-pt(1155),
        y: to-pt(1856),
    ),
    link-value-pos: (
        x: to-pt(1222),
        y: to-pt(1856),
    ),
    link-marker-pos: (
        (x: to-pt(117), y: to-pt(321)),
        (x: to-pt(93), y: to-pt(773)),
        (x: to-pt(117), y: to-pt(1352)),
        (x: to-pt(572), y: to-pt(1428)),
        (x: to-pt(1149), y: to-pt(1352)),
        (x: to-pt(1223), y: to-pt(773)),
        (x: to-pt(1149), y: to-pt(321)),
        (x: to-pt(569), y: to-pt(298)),
    ),
    pendulum-area: (
        start: (x: to-pt(210), y: to-pt(1285)),
        end: (x: to-pt(1180), y: to-pt(1495)),
    ),
    description-area: (
        start: (x: to-pt(104), y: to-pt(1530)),
        end: (x: to-pt(1290), y: to-pt(1836)),
    ),
)
