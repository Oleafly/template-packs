// DTU Colors and Color Utilities
// Official DTU Colors from designguide.dtu.dk

// Primary DTU Colors
#let dtu-red = rgb("#990000")        // Primary DTU Red
#let dtu-white = rgb("#ffffff")      // Primary White
#let dtu-black = rgb("#000000")      // Primary Black

// Secondary DTU Colors  
#let dtu-blue = rgb("#2F3EEA")       // Bright Blue
#let dtu-green = rgb("#1FD082")      // Bright Green
#let dtu-dark-blue = rgb("#030F4F")  // Dark Blue
#let dtu-yellow = rgb("#F6D04D")     // Yellow
#let dtu-orange = rgb("#FC7634")     // Orange
#let dtu-salmon = rgb("#F7BBB1")     // Salmon/Light Pink
#let dtu-gray = rgb("#DADADA")       // Gray
#let dtu-coral = rgb("#E83F48")      // Coral
#let dtu-dark-green = rgb("#008835") // Dark Green
#let dtu-purple = rgb("#79238E")     // Purple

// Additional utility colors
#let dtu-light-gray = rgb("#f0f0f0") // Light Gray
#let dtu-dark-gray = rgb("#666666")  // Dark Gray
#let dtu-teal = rgb("#17a2b8")       // Teal

// Color palette helper function
#let dtu-color(name) = {
  let colors = (
    "red": dtu-red,
    "blue": dtu-blue,
    "green": dtu-green,
    "dark-blue": dtu-dark-blue,
    "yellow": dtu-yellow,
    "orange": dtu-orange,
    "salmon": dtu-salmon,
    "gray": dtu-gray,
    "coral": dtu-coral,
    "dark-green": dtu-dark-green,
    "purple": dtu-purple,
    "white": dtu-white,
    "black": dtu-black,
    "light-gray": dtu-light-gray,
    "dark-gray": dtu-dark-gray,
    "teal": dtu-teal,
  )
  colors.at(name, default: dtu-red)
}
