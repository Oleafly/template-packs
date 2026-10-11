#import "../conf_imag.typ": conf, description, eqn

#show: conf.with(
  title: "Gros rendu - Exemple",
  authors: (
    (
      name: "Prénom1 Nom1",
      mail: "prenom1.nom1@blabla.org"
    ), 
    (
      name: "Prénom2 Nom2",
      mail: "prenom2.nom2@blabla.org"
    ),
  ),
  title_page: true
)

= Introduction
== Première section
#description("Ce document est un exemple de gros rendu. Il illustre la structure et le format attendu pour un rendu propre.")

#lorem(100)

#eqn(body: $e = 1 + sum_(k=1)^n (x^k)/(k!) = 1 + x + x^2/2! + ... + x^k/k!$)

= Fonction de réduction
#description("Écrire une fonction " + $r_(i)$ + " qui prend en entrée un hash et qui retourne un pass réduit.")

@reduce montre la fonction de réduction simple.

#figure(caption: "Fonction de réduction simple")[
```c
#include <stdint.h>

/**
 * Fonction de réduction simple : transforme un hash en une chaîne de M caractères.
 * @param h Le hash à réduire.
 * @param i L'indice de la réduction (utilisé pour varier la réduction).
 * @param out Pointeur vers le buffer où stocker la chaîne réduite (doit avoir au moins M+1 octets).
 * 
 * Cette fonction utilise une méthode simple pour générer une chaîne de M
 * caractères à partir du hash, en utilisant une base-26 et un petit mélange
 * pour éviter les motifs.
 */
void reduce(pwhash h, int i, char out[M+1]) {
    uint64_t x = h + SEED * (uint64_t)(i + 1); // juste un décalage par i
    for (int k = 0; k < M; k++) {
        out[k] = (char)('a' + (x % 26));
        x /= 26;                       // base-26 directe
        x ^= (x << 13) ^ (x >> 7);     // petit mélange pour éviter motifs
    }

    out[M] = '\0';
}```
] <reduce>


= Recherche documentaire
#description("Vous pouvez (si vous en avez le temps et l'envie) essayer d'améliorer vos résultats en changeant les valeurs de R, N et L, dans les limites du raisonnable en terme de temps de calcul.")


Comme nous avons pu le voir dans les résultats précédents, une simple fonction de hachage ne permet pas de protéger efficacement les mots de passe d'une base de données.
Afin de mieux se prémunir contre ce type d'attaque, plusieurs techniques modernes sont aujourd'hui utilisées dans la quasi-totalité des systèmes d'authentification. Nous allons les citer et les expliquer.

Il est d'abord fortement déconseillé d'utiliser sa propre fonction de hachage "maison". Même si elle semble fonctionner correctement, le risque de faille est très élevé.
De plus, les fonctions de hachage classiques telles que #emph[SHA-2], #emph[SHA-3] ou #emph[WHIRLPOOL], bien qu'encore employées dans certains contextes, sont désormais considérées comme trop rapides et donc insuffisantes pour protéger directement des mots de passe. 
Elles ont été conçues pour vérifier l'intégrité des données, et non pour ralentir une attaque par force brute. 

La première technique à mettre en œuvre est le #emph[salage cryptographique] (ou #emph[salt]) @salage. 
Cette méthode consiste à concaténer le mot de passe avec une chaîne de caractères aléatoire et unique à chaque création de mot de passe, avant de l'envoyer à la fonction de hachage. 
Ainsi, même si deux utilisateurs choisissent le même mot de passe, les hachages obtenus seront différents. 
Le salage est particulièrement efficace contre les attaques de type #emph[rainbow table], car l'attaquant devrait générer une table différente pour chaque valeur de sel possible. 
En revanche, il ne protège pas contre les attaques par force brute, car il ne ralentit pas le processus de calcul. 

Pour limiter ces dernières, on utilise une #emph[fonction de dérivation de clé] (#emph[Key Derivation Function], ou #emph[KDF]) @kdf. 
Ces fonctions ajoutent une #emph[lenteur volontaire] et une #emph[utilisation accrue de la mémoire], rendant le calcul beaucoup plus coûteux pour un attaquant. 
Elles appliquent la fonction de hachage de base un grand nombre de fois (itérations).

Les KDF les plus courantes sont~:

- #emph[bcrypt] : utilisée notamment dans Apache, elle repose sur l'algorithme Blowfish, intègre un sel de 128~bits et permet d'ajuster le nombre d'itérations.
- #emph[PBKDF2]: utilisée par MacOS, elle utilise un sel de 64~à~128~bits et un nombre d'itérations configurable (entre 1\,000 et 100\,000, voire plus) @pbkdf2.
- #emph[Argon2] (et ses variantes #emph[Argon2d], #emph[Argon2i] et #emph[Argon2id])~: utilisée par PHP (depuis la version~7.2) et Symfony (depuis la version~4.1), elle est aujourd'hui la KDF recommandée @argon2. 
Conçue pour résister aux attaques massives par force brute, elle permet d'ajuster à la fois le nombre d'itérations, la mémoire utilisée et le nombre de cœurs exploités en parallèle. 
Chaque variante cible un type d'attaque particulier (GPU, canaux cachés, ou combinaison des deux). 

En complément, on peut ajouter un #emph[poivre cryptographique] (#emph[pepper]) @pepper. 
Contrairement au sel, le poivre est une valeur #emph[secrète], partagée par l'application et stockée séparément du code et de la base de données. 
Il renforce la sécurité en rendant le test d'un mot de passe beaucoup plus difficile pour un attaquant, même en cas de fuite de la base de données. 

Enfin, au-delà de ces protections cryptographiques, il est recommandé d'activer une #emph[authentification à deux facteurs (2FA)] et de mettre en place une #emph[politique stricte de mot de passe] 
(longueur minimale, complexité, interdiction de réutilisation, etc.) afin d'assurer une sécurité globale du système d'accès.


#bibliography("doc.bib", style: "ieee", title: "Références bibliographiques")