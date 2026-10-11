#import "diapo.typ": *

#show: diapo.with(
        title: "Exemple de présentation",
        author: "Olivier Delhomme",
        date: "20/09/2023",
        display-lastpage: true,
)



= Première partie

== Une première planche

Ici on va pouvoir exposer ce dont on veut parler~:

- La facilité de création
  - qui est en lien avec la rapidité de compilation
- Le réel découplage entre le contenu et les styles appliqués



== Rust code

En rust on défini une fonction main~:

```rust
fn main() { 
    println!("Hello World!");
}
```
qui peut ressembler à celle du C~:

```C
int main(int argc, char **argv) {
  fprintf(stdout, _("Hello World!"));
}
```

#transition[Ceci est une vignette de transition]

== Enfin la fin

C'est la dernière vignette de la présentation
mais pas la dernière page où l'on remercie l'audience
pour sa patience.

Celle là, c'est la vignette suivante ;-)

#lastpage[N'hésitez pas à poser vos questions]
