// =============================================================================
// Thesis metadata
// =============================================================================

#import "i18n.typ": lang, t

// -----------------------------------------------------------------------------
// Abstracts and keywords
// -----------------------------------------------------------------------------

// TODO: adapt — replace with your French abstract
#let french-abstract = [
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
]

// TODO: adapt — replace with your French keywords
#let french-keywords = [
Mot-clé 1 --- Mot-clé 2 --- Mot-clé 3
]

// TODO: adapt — replace with your English abstract
#let english-abstract = [
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
]

// TODO: adapt — replace with your English keywords
#let english-keywords = [
Keyword 1 --- Keyword 2 --- Keyword 3
]

// -----------------------------------------------------------------------------
// General information
// -----------------------------------------------------------------------------

// TODO: adapt — replace with your thesis title (bilingual)
#let thesis-title = t(
  [#smallcaps[Titre de la thèse en français]],
  [#smallcaps[Thesis Title in English]],
)

// TODO: adapt — replace with your name
#let thesis-author = [Prénom #smallcaps[Nom]]

// TODO: adapt — replace with your document type
#let thesis-type = t([Thèse de doctorat], [Doctoral Dissertation])

// TODO: adapt — replace with your defense date
#let thesis-date = t([1er janvier 2026], [January 1, 2026])

// TODO: adapt — replace with your specialty
#let thesis-specialty = t([Informatique], [Computer Science])

// TODO: adapt — replace with your domain
#let thesis-domain = t([Domaine], [Domain])

// -----------------------------------------------------------------------------
// Jury
// -----------------------------------------------------------------------------

// TODO: adapt — fill in your jury members
#let thesis-jury = (
  // Example entry:
  // (
  //   name: [M. Jean #smallcaps[Dupont]],
  //   position: t([Professeur, Université X], [Professor, University X]),
  //   role-key: "reviewer",
  // ),
)

#let jury-role(key) = {
  let roles = (
    reviewer: t("Rapporteur", "Reviewer"),
    examiner: t("Examinateur", "Examiner"),
    chair: t("Président", "Chair"),
    advisor: t("Directeur de thèse", "Advisor"),
  )
  roles.at(key)
}
