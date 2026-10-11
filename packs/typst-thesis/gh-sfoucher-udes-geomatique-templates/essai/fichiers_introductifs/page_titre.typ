#import "../styles.typ": *

// bandeau : option 2 (logo blanc dans le bandeau) — palette foncée
// pour l'option 1 (logo horizontal à côté), mettre option-logo: 1
#page-titre(
  type-doc: [ESSAI DE MAÎTRISE],
  bandeau-sous: [Géomatique appliquée et télédétection],
  option-logo: 2,
  logo-bandeau: image("../logoUdes/UdeS_logo_v_blancHR.png", width: 2.8cm),
  logo-cote: image("../logoUdes/UdeS_logo_h_rgbHR.png", width: 30%),
  titre: [Titre dans la langue de rédaction \ (français ou anglais)],
  titre-fr: [Titre en français, si la langue de rédaction est l'anglais],
  auteur: [#smallcaps[Prénom] NOM],
  mention: [Essai présenté à la Faculté des lettres et sciences humaines \
    au Département de géomatique appliquée \
    en vue de l'obtention du grade de],
  grade: [_Maître ès sciences_ (M. Sc.) en géomatique appliquée et télédétection],
  date: [Mois 20XX],
  copyright: [© #smallcaps[Prénom] NOM, 20XX],
)
