#import "../templates/long-report.typ":project

#show: project.with(
  title: "A spoonful of title",
  authors: ("Walt Disney", "Bob Iger", "Michael Eisner", "Elon Musk", "Steve Jobs",),
  
)

#lorem(42)
= Premier Lorem
== Premier sous-Lorem
=== Premier sous sous lorem
#lorem(42)
=== Second sous sous lorem
#lorem(42)
== Second sous lorem
=== Troisieme sous sous lorem
#lorem(42)
=== Quatrieme sous sous lorem
#lorem(42)
= Deuxieme Lorem
== Troisieme sous-Lorem
=== Cinquieme sous sous lorem
#lorem(42)
=== Sixieme sous sous lorem
#lorem(42)
== Quatrieme sous lorem
=== Septieme sous sous lorem
#lorem(42)
=== Huitieme sous sous lorem
#lorem(42)
