= Template 2 : images

== Afficher des images simplement

#image("Photos/Folder2/photo1.jpg")

#v(1em)

#figure(
  image("Photos/Folder2/photo1.jpg", height: 10em),
  caption: [Une image avec un titre, et une taille "contenue"]
)

#figure(
  rotate(5deg, reflow: true, image("Photos/Folder2/photo1.jpg", height: 10em)),
  caption: [Une inclinaison à toute épreuve]
)

== Afficher plusieurs images

#grid(
  columns: 3*(auto,),
  image("Photos/Folder2/photo1.jpg"),
  image("Photos/Folder2/photo1.jpg"),
  image("Photos/Folder2/photo1.jpg"),
  image("Photos/Folder2/photo1.jpg"),
  image("Photos/Folder2/photo1.jpg"),
  image("Photos/Folder2/photo1.jpg"),
)

#v(5em)

#figure(
  [
    #set grid(column-gutter: 1em, row-gutter: 1em)
    #grid(
      columns: 3,
      image("Photos/Folder2/photo1.jpg"),
      image("Photos/Folder2/photo1.jpg"),
      image("Photos/Folder2/photo1.jpg"),
    )
    #grid(
      columns: 2,
      image("Photos/Folder2/photo1.jpg"),
      image("Photos/Folder2/photo1.jpg"),
    )
  ],
  caption: [Ici avec une description générale à toutes les images et un espace entre les images]
) <fig>

#figure(
  grid(
    columns: 3,
    inset: 1em,
    align: horizon,
    figure(image("Photos/Folder2/photo1.jpg"), caption: [Image1], numbering: none, kind: "none"),
    figure(image("Photos/Folder2/photo2.jpg"), caption: [Image2], numbering: none, kind: "none"),
    figure(image("Photos/Folder2/photo1.jpg"), caption: [Image3], numbering: none, kind: "none"),
    figure(image("Photos/Folder2/photo2.jpg"), caption: [Image4], numbering: none, kind: "none"),
    figure(image("Photos/Folder2/photo1.jpg"), caption: [Image5], numbering: none, kind: "none"),
    figure(image("Photos/Folder2/photo2.jpg"), caption: [Image6], numbering: none, kind: "none"),
  ),
  caption: [Plusieurs images avec des descriptions unitaires et une générale, avec un référencement]
) <Tab_images>

#figure(
  grid(
    columns: 3*(auto,),
    rows: 2,
    inset: 1em,
    align: horizon,
    figure(rotate(20deg, reflow: true, image("Photos/Folder2/photo1.jpg", height: 8em)), caption: [Image1], numbering: none, kind: "none"),
    figure(rotate(0deg, reflow: true, image("Photos/Folder2/photo2.jpg", height: 8em)), caption: [Image2], numbering: none, kind: "none"),
    figure(rotate(320deg, reflow: true, image("Photos/Folder2/photo1.jpg", height: 8em)), caption: [Image3], numbering: none, kind: "none"),
    figure(rotate(340deg, reflow: true, image("Photos/Folder2/photo2.jpg", height: 8em)), caption: [Image4], numbering: none, kind: "none"),
    figure(rotate(180deg, reflow: true, image("Photos/Folder2/photo1.jpg", height: 8em)), caption: [Image5], numbering: none, kind: "none"),
    figure(rotate(200deg, reflow: true, image("Photos/Folder2/photo2.jpg", height: 8em)), caption: [Image6], numbering: none, kind: "none"),
  ),
  caption: [Plusieurs images en bazar]
) <Tab_images_desordre>
