#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

= Exemple de Chapitre <exemple-de-chapitre>
#lorem(100)

== Rédiger des expression mathématiques
Voici des maths intégrés: $3^2/4^3$

ou alors à la ligne: $ (3x_a)/(y_b^2+4) $

== Insérer des images
Voici comment mettre une image.

#figure(
  image("../images/PGP_101.png", width: 60%),
  caption: [
    Schéma PGP
  ]
) <pgp>

== Créer et citer une référence bibliographique

Ceci est un exemple de citation d'un livre de Pasini @ajop15\
\
Mais aussi le site de Black Alps 2019 @pas19

== Créer une référence à une autre partie du document

On peut aussi ajouter une référence à la section @inclure-du-code[]\
\
On peut aussi ajouter une référence à l’introduction, @introduction.\
\
Comme montre la @pgp, on peut référencer une figure.

== Afficher une commande simple ou du bash

Exemple : Test d’une commande bash shell `ls` :\
\

```sh
$> ls -al test_underscore $$* "coucou"
```

== Inclure du code <inclure-du-code>

```C
#include <stdio.h>
int main(int argc, char* argv[])
{
   printf("Hello World!\n");
   return 0;
}
```
