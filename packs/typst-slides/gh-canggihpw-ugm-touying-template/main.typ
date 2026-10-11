#import "themes/ugm1/lib.typ": *

#set page(
  width: slide-width,
  height: slide-height,
  margin: 0pt,
)

// =======================================================
// Sample presentation — demonstrates all four slide types
// =======================================================

#title-slide(
  title: [Your Title],
  subtitle: [Your Subtitle],
  author: [Your Name],
  date: [2024],
)

#section-slide([Introduction])

#content-slide(title: [Slide Title], [
  - First point
  - Second point
  - Third point
])

#quote-slide(["Your quote here." - Author])

#section-slide([Getting Started])

#content-slide(title: [What is This?], [
  - A powerful template for creating presentations
  - Offers a wide range of customization options
  - Creates high-quality professional presentations

  #text(font: gama-font, weight: "bold")[Key features:]

  + Easy to use with familiar syntax
  + Supports custom themes and layouts
  + Ready for academic and professional use
])

#quote-slide(["Anyone who stops learning is old, whether at twenty or eighty. Anyone who keeps learning stays young." - Henry Ford])
