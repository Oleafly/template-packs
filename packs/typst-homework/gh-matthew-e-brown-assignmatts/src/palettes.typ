// cspell:ignoreRegExp /rgb\("#?[A-Fa-f0-9]{6}"\)/

/// The player colours from Super Smash Bros. Ultimate.
///
/// @see https://www.deviantart.com/thewolfbunny64/art/Super-Smash-Bros-Every-Player-Color-is-Here-754697613
#let smash-bros = (
    rgb("#ff3837"), // red
    rgb("#308aff"), // blue
    rgb("#ffbc16"), // yellow
    rgb("#29b548"), // green
    rgb("#fa8737"), // orange
    rgb("#2ed2eb"), // cyan
    rgb("#ff9db6"), // pink
    rgb("#9471ff"), // purple
)

/// Colours picked from the Desmos graphing calculator.
#let desmos = (
  red: rgb("#c74440"),
  blue: rgb("#2d70b3"),
  green: rgb("#348543"),
  orange: rgb("#fa7e19"),
  purple: rgb("#6042a6"),
  black: rgb("#000000"),
)

/// Colours picked from the Notability app on iPad.
#let notability = (
    // First page
    yellow: rgb("#fefe00"),
    orange: rgb("#fa9d00"),
    red: rgb("#ed3624"),
    pink: rgb("#fe00d4"),
    bright-green: rgb("#a9ff18"),
    light-green: rgb("#60bb46"),
    purple: rgb("#a500c8"),
    dark-purple: rgb("#612d91"),
    dark-green: rgb("#00733a"),
    bright-blue: rgb("#006ffd"),
    dark-blue: rgb("#1649b4"),
    navy-blue: rgb("#120476"),
    white: rgb("#ffffff"),
    gray: rgb("#969696"),
    black: rgb("#000000"),
    brown: rgb("#946635"),
    // Second page
    golden-yellow: rgb("#f1c40f"),
    rusty-orange: rgb("#cb670f"),
    soft-pink: rgb("#e26a6b"),
    maroon: rgb("#b71415"),
    halloween-orange: rgb("#f05f33"),
    raspberry-red: rgb("#cf366c"),
    teal-green: rgb("#30da77"),
    teal: rgb("#19b091"),
    light-blue-gray: rgb("#9dbad8"),
    cyan: rgb("#14c7de"),
    cornflower-blue: rgb("#3598db"),
    blueberry-blue: rgb("#444ead"),
    ash-gray: rgb("#c7c4bd"),
    moss-gray: rgb("#515d5d"),
    lilac: rgb("#b09cff"),
    deep-lavender: rgb("#8e53d1"),
)

/// Typst's built-in palette, just in case any of its variable names are shadowed.
#let typst = (
    black: std.black,
    gray: std.gray,
    silver: std.silver,
    white: std.white,
    navy: std.navy,
    blue: std.blue,
    aqua: std.aqua,
    teal: std.teal,
    eastern: std.eastern,
    purple: std.purple,
    fuchsia: std.fuchsia,
    maroon: std.maroon,
    red: std.red,
    orange: std.orange,
    yellow: std.yellow,
    olive: std.olive,
    green: std.green,
    lime: std.lime,
)
